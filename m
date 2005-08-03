From: david-b@pacbell.net (david-b@pacbell.net)
Date: Wed, 03 Aug 2005 22:23:16 +0000
Subject: [lm-sensors] for review: OMAP I2C driver (patch for
Message-Id: <20050803202123.32C1413D95@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The i2c-omap (bus) driver has been pretty reliable, and given some
recent cleanups (including a driver model conversion!) it seems like
it's time to see what else needs updating before pushing it upstream.

So here's the current driver.  Only the I2C master mode is currently
in use (and not even multi-master, AFAIK), but it's known to work at
both 100KHz and 400KHz.

I expect that before it merges both the FIXME and REVISIT comments will
need to be addressed, also various style and whitespace fixups.  (And
I'd be interested in any comments on the "right" way to initialize and
use adap->retries.  Some drivers initialize that to a nonzero value, and
that might be necessary to get beyond a particular board init quirk.)

Other than those issues ... does anything stand out as stuff that needs
to be fixed before submitting upstream?

At the top, notice the drivers/Makefile change we needed to ensure that
essential I2C drivers get initialized early enough to boot various OMAP
boards, which rely on functional I2C (not just tps6501x, used for power
switching) drivers in order to bring other drivers up.  Is that change
potentially mergeable?  If so I'd expect it to be submitted separately.

- Dave

p.s. For general OMAP port info, http://www.muru.com/linux/omap/ is
     probably the most effective place to start.


--- linux-2.6/drivers/Makefile	2005-07-14 05:44:25.000000000 -0700
+++ omap-2.6/drivers/Makefile	2005-08-02 14:52:38.000000000 -0700
@@ -26,7 +26,9 @@
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
-obj-y				+= base/ block/ misc/ net/ media/
+obj-y				+= base/ block/ misc/ net/ 
+obj-$(CONFIG_I2C)               += i2c/
+obj-y				+= media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
@@ -50,7 +52,6 @@
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
-obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
--- linux-2.6/drivers/i2c/busses/i2c-omap.c	1969-12-31 16:00:00.000000000 -0800
+++ omap-2.6/drivers/i2c/busses/i2c-omap.c	2005-08-02 14:52:38.000000000 -0700
@@ -0,0 +1,548 @@
+/*
+ * linux/drivers/i2c/i2c-omap.c
+ *
+ * TI OMAP I2C master mode driver
+ *
+ * Copyright (C) 2003 MontaVista Software, Inc.
+ * Copyright (C) 2004 Texas Instruments.
+ *
+ * ----------------------------------------------------------------------------
+ * This file was highly leveraged from i2c-elektor.c:
+ *
+ * Copyright 1995-97 Simon G. Vogl
+ *           1998-99 Hans Berglund
+ *
+ * With some changes from Kysti M?kki <kmalkki@cc.hut.fi> and even
+ * Frodo Looijaard <frodol@dds.nl>
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/version.h>
+#include <linux/i2c.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/hardware/clock.h>
+
+#include <asm/uaccess.h>
+#include <asm/hardware/clock.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <asm/arch/hardware.h>
+#include <linux/interrupt.h>
+#include <linux/moduleparam.h>
+#include <asm/arch/mux.h>
+#include <linux/err.h>
+#include "i2c-omap.h"
+
+#undef	I2C_OMAP_DEBUG
+
+
+/* ----- debug defines ----------------------------------------------- */
+
+#ifdef I2C_OMAP_DEBUG
+static int i2c_debug = 0;
+
+module_param(i2c_debug, int, 0);
+MODULE_PARM_DESC(i2c_debug,
+		 "debug level - 0 off; 1 normal; 2,3 more verbose; "
+		 "9 omap-protocol");
+
+#define DEB0(format, arg...)	printk(KERN_DEBUG MODULE_NAME " DEBUG: " format "\n",  ## arg )
+#define DEB1(format, arg...)	\
+	if (i2c_debug>=1) {	\
+		printk(KERN_DEBUG MODULE_NAME " DEBUG: " format "\n",  ## arg ); \
+	}
+#define DEB2(format, arg...)	\
+	if (i2c_debug>=2) {	\
+		printk(KERN_DEBUG MODULE_NAME " DEBUG: " format "\n",  ## arg ); \
+	}
+#define DEB3(format, arg...)	\
+	if (i2c_debug>=3) {	\
+		printk(KERN_DEBUG MODULE_NAME " DEBUG: " format "\n",  ## arg ); \
+	}
+#define DEB9(format, arg...)	\
+	/* debug the protocol by showing transferred bits */	\
+	if (i2c_debug>=9) {	\
+		printk(KERN_DEBUG MODULE_NAME " DEBUG: " format "\n",  ## arg ); \
+	}
+#else
+#define DEB0(fmt, args...)
+#define DEB1(fmt, args...)
+#define DEB2(fmt, args...)
+#define DEB3(fmt, args...)
+#define DEB9(fmt, args...)
+#endif
+
+/* ----- global defines ----------------------------------------------- */
+static const char driver_name[] = "i2c_omap";
+
+#define MODULE_NAME "OMAP I2C"
+#define OMAP_I2C_TIMEOUT (1*HZ)	/* timeout waiting for an I2C transaction */
+
+#define err(format, arg...) printk(KERN_ERR MODULE_NAME " ERROR: " format "\n",  ## arg )
+
+#ifdef CONFIG_ARCH_OMAP1510
+#define omap_i2c_rev1()		(readw(OMAP_I2C_REV) < 0x20)
+#else
+#define omap_i2c_rev1()		0
+#endif
+
+#define DEFAULT_OWN	1	/* default own I2C address */
+#define MAX_MESSAGES	65536	/* max number of messages */
+
+static int clock = 100;		/* Default: Fast Mode = 400 KHz, Standard Mode = 100 KHz */
+module_param(clock, int, 0);
+MODULE_PARM_DESC(clock,
+		 "Set I2C clock in KHz: 100 (Standard Mode) or 400 (Fast Mode)");
+
+static int own;
+module_param(own, int, 0);
+MODULE_PARM_DESC(own, "Address of OMAP i2c master (0 for default = 1)");
+
+
+static struct omap_i2c_dev {
+        int cmd_complete, cmd_err;
+        wait_queue_head_t cmd_wait;
+	u8 *buf;
+	size_t buf_len;
+} omap_i2c_dev;
+
+/* FIXME pass "sparse": convert {read,write}w() with iomapped addresses
+ * to omap_{read,write}w() with physical addresses.
+ */
+
+static void omap_i2c_reset(void)
+{
+	unsigned long timeout;
+	u16 psc;
+	struct clk *armxor_ck;
+	unsigned long armxor_rate;
+
+	if (!omap_i2c_rev1())
+		writew(OMAP_I2C_SYSC_SRST, OMAP_I2C_SYSC);	/*soft reset */
+	else
+		writew(OMAP_I2C_CON_RST, OMAP_I2C_CON);		/* reset */
+
+	armxor_ck = clk_get(NULL, "armxor_ck");
+	if (IS_ERR(armxor_ck)) {
+		printk(KERN_WARNING "i2c: Could not obtain armxor_ck rate.\n");
+		armxor_rate = 12000000;
+	} else {
+		armxor_rate = clk_get_rate(armxor_ck);
+		clk_put(armxor_ck);
+	}
+
+	if (armxor_rate <= 16000000)
+		psc = 0;
+	else
+		psc = (armxor_rate + 8000000) / 12000000;
+
+	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
+	writew(psc, OMAP_I2C_PSC);
+
+	/* Program desired operating rate */
+	armxor_rate /= (psc + 1) * 1000;
+	if (psc > 2)
+		psc = 2;
+	writew(armxor_rate / (clock * 2) - 7 + psc, OMAP_I2C_SCLL);
+	writew(armxor_rate / (clock * 2) - 7 + psc, OMAP_I2C_SCLH);
+
+
+	/* Set Own Address: */
+	writew(own, OMAP_I2C_OA);
+
+	/* Enable interrupts */
+	writew((OMAP_I2C_IE_XRDY_IE | OMAP_I2C_IE_RRDY_IE | OMAP_I2C_IE_ARDY_IE |
+		OMAP_I2C_IE_NACK_IE | OMAP_I2C_IE_AL_IE), OMAP_I2C_IE);
+
+	/* Take the I2C module out of reset: */
+	writew(OMAP_I2C_CON_EN, OMAP_I2C_CON);
+
+	if (!omap_i2c_rev1()){
+		timeout = jiffies + OMAP_I2C_TIMEOUT;
+		while (!(readw(OMAP_I2C_SYSS) & OMAP_I2C_SYSS_RDONE)) {
+			if (time_after(jiffies, timeout)) {
+				err("timeout waiting for I2C reset complete");
+				break;
+			}
+			msleep(1);
+		}
+	}
+}
+
+/*
+ * Waiting on Bus Busy
+ */
+static int
+omap_i2c_wait_for_bb(char allow_sleep)
+{
+	unsigned long timeout;
+
+	timeout = jiffies + OMAP_I2C_TIMEOUT;
+	while (readw(OMAP_I2C_STAT) & OMAP_I2C_STAT_BB) {
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_WARNING "timeout waiting for bus ready\n");
+			return -ETIMEDOUT;
+		}
+		if (allow_sleep)
+			schedule_timeout(1);
+	}
+
+	return 0;
+}
+
+/*
+ * Low level master read/write transaction.
+ */
+static int
+omap_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
+{
+	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
+	u8 zero_byte = 0;
+	int r;
+	u16 w;
+
+	DEB2("addr: 0x%04x, len: %d, flags: 0x%x, stop: %d",
+	     msg->addr, msg->len, msg->flags, stop);
+
+	writew(msg->addr, OMAP_I2C_SA);
+
+	/* Sigh, seems we can't do zero length transactions. Thus, we
+	 * can't probe for devices w/o actually sending/receiving at least
+	 * a single byte. So we'll set count to 1 for the zero length
+	 * transaction case and hope we don't cause grief for some
+	 * arbitrary device due to random byte write/read during
+	 * probes.
+	 */
+	if (msg->len = 0) {
+		dev->buf = &zero_byte;
+                dev->buf_len = 1;
+	} else {
+		dev->buf = msg->buf;
+		dev->buf_len = msg->len;
+	}
+	writew(dev->buf_len, OMAP_I2C_CNT);
+        dev->cmd_complete = 0;
+        dev->cmd_err = 0;
+	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
+	if (msg->flags & I2C_M_TEN)
+		w |= OMAP_I2C_CON_XA;
+	if (!(msg->flags & I2C_M_RD))
+		w |= OMAP_I2C_CON_TRX;
+	if (stop)
+		w |= OMAP_I2C_CON_STP;
+	writew(w, OMAP_I2C_CON);
+
+	r = wait_event_interruptible_timeout(dev->cmd_wait,
+					     dev->cmd_complete,
+					     OMAP_I2C_TIMEOUT);
+	dev->buf_len = 0;
+	if (r < 0)
+                return r;
+	if (!dev->cmd_complete) {
+                omap_i2c_reset();
+		return -ETIMEDOUT;
+	}
+	if (!dev->cmd_err)
+		return msg->len;
+
+	/* We have an error */
+	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
+		if (msg->flags & I2C_M_IGNORE_NAK)
+                        return msg->len;
+		if (stop)
+			writew(readw(OMAP_I2C_CON) | OMAP_I2C_CON_STP,
+					OMAP_I2C_CON);
+		return -EREMOTEIO;
+	}
+	if ((OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR | OMAP_I2C_STAT_XUDF)
+			& dev->cmd_err) {
+		omap_i2c_reset();
+		return -EIO;
+	}
+        return msg->len;
+}
+
+/*
+ * Prepare controller for a transaction and call omap_i2c_xfer_msg
+ * to do the work during IRQ processing.
+ */
+static int
+omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	int i;
+	int r = 0;
+
+	DEB1("msgs: %d", num);
+
+	if (num < 1 || num > MAX_MESSAGES)
+		return -EINVAL;
+
+	/* Check for valid parameters in messages */
+	for (i = 0; i < num; i++)
+		if (msgs[i].buf = NULL)
+			return -EINVAL;
+
+// REVISIT:  initialize and use adap->retries
+
+	if ((r = omap_i2c_wait_for_bb(1)) < 0)
+		return r;
+
+	for (i = 0; i < num; i++) {
+		DEB2("msg: %d, addr: 0x%04x, len: %d, flags: 0x%x",
+		     i, msgs[i].addr, msgs[i].len, msgs[i].flags);
+
+		r = omap_i2c_xfer_msg(adap, &msgs[i], (i = (num - 1)));
+
+		DEB2("r: %d", r);
+
+		if (r != msgs[i].len)
+			break;
+	}
+
+	if (r >= 0 && num > 1)
+		r = num;
+
+	DEB1("r: %d", r);
+
+	return r;
+}
+
+static u32
+omap_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static inline void
+omap_i2c_complete_cmd(struct omap_i2c_dev *dev)
+{
+        dev->cmd_complete = 1;
+	wake_up(&dev->cmd_wait);
+}
+
+static irqreturn_t
+omap_i2c_isr(int this_irq, void *dev_id, struct pt_regs *regs)
+{
+	struct omap_i2c_dev *dev = dev_id;
+        u16 bits;
+	u16 stat, w;
+        int count = 0;
+	u16 iv_read;
+
+        bits = readw(OMAP_I2C_IE);
+	while ((stat = readw(OMAP_I2C_STAT)) & bits) {
+		
+		if (count++ = 100) {
+			printk(KERN_WARNING "Too much work in one IRQ\n");
+			break;
+		}
+
+		writew(stat, OMAP_I2C_STAT);
+		if (stat & OMAP_I2C_STAT_ARDY) {
+			omap_i2c_complete_cmd(dev);
+			writew(OMAP_I2C_STAT_ARDY, OMAP_I2C_STAT);
+			if (omap_i2c_rev1())
+				iv_read = readw(OMAP_I2C_IV);
+			continue;
+		}
+		if (stat & OMAP_I2C_STAT_RRDY) {
+                        w = readw(OMAP_I2C_DATA);
+			if (dev->buf_len) {
+				*dev->buf++ = w;
+				dev->buf_len--;
+				if (dev->buf_len) {
+					*dev->buf++ = w >> 8;
+					dev->buf_len--;
+				}
+				if (omap_i2c_rev1() && !dev->buf_len)
+					omap_i2c_complete_cmd(dev);
+			} else
+				err("RRDY IRQ while no data requested");
+			writew(OMAP_I2C_STAT_RRDY, OMAP_I2C_STAT);
+			if (omap_i2c_rev1())
+				iv_read = readw(OMAP_I2C_IV);
+			continue;
+		}
+		if (stat & OMAP_I2C_STAT_XRDY) {
+                        w = 0;
+			if (dev->buf_len) {
+				w = *dev->buf++;
+				dev->buf_len--;
+				if (dev->buf_len) {
+					w |= *dev->buf++ << 8;
+					dev->buf_len--;
+				}
+			} else {
+				err("XRDY IRQ while no data to send");
+			}
+			writew(w, OMAP_I2C_DATA);
+                        /* We have to make sure the XRDY bit is reset */
+			writew(OMAP_I2C_STAT_XRDY, OMAP_I2C_STAT);
+			if (omap_i2c_rev1()) {
+				iv_read = readw(OMAP_I2C_IV);
+				if (!dev->buf_len)
+					omap_i2c_complete_cmd(dev);
+			}
+			continue;
+		}
+		if (stat & OMAP_I2C_STAT_ROVR) {
+			pr_debug("Receive overrun\n");
+                        dev->cmd_err |= OMAP_I2C_STAT_ROVR;
+		}
+		if (stat & OMAP_I2C_STAT_XUDF) {
+			pr_debug("Transmit overflow\n");
+                        dev->cmd_err |= OMAP_I2C_STAT_XUDF;
+		}
+		if (stat & OMAP_I2C_STAT_NACK) {
+                        dev->cmd_err |= OMAP_I2C_STAT_NACK;
+                        omap_i2c_complete_cmd(dev);
+			writew(OMAP_I2C_CON_STP, OMAP_I2C_CON);
+		}
+		if (stat & OMAP_I2C_STAT_AL) {
+			pr_debug("Arbitration lost\n");
+			dev->cmd_err |= OMAP_I2C_STAT_AL;
+                        omap_i2c_complete_cmd(dev);
+		}
+		if (omap_i2c_rev1())
+			iv_read = readw(OMAP_I2C_IV);
+
+	}
+	return IRQ_HANDLED;
+}
+
+static struct i2c_algorithm omap_i2c_algo = {
+	.name		= "OMAP I2C algorithm",
+	.id		= I2C_ALGO_EXP,
+	.master_xfer	= omap_i2c_xfer,
+	.functionality	= omap_i2c_func,
+};
+
+static struct i2c_adapter omap_i2c_adap = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
+	.name		= "OMAP I2C adapter",
+	.algo		= &omap_i2c_algo,
+};
+
+static int __init
+omap_i2c_probe(struct device *dev)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	struct resource		*mem;
+	int r;
+
+	/* NOTE:  driver uses the static register mapping */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		pr_debug("%s: no mem resource?\n", driver_name);
+		return -ENODEV;
+	}
+	r = (int) request_mem_region(mem->start, (mem->end - mem->start) + 1,
+			driver_name);
+	if (!r) {
+		pr_debug("%s: I2C region already claimed\n", driver_name);
+		return -EBUSY;
+	}
+
+	if (clock > 200)
+		clock = 400;	/*Fast mode */
+	else
+		clock = 100;	/*Standard mode */
+
+	if (own < 1 || own > 0x7f)
+		own = DEFAULT_OWN;
+
+	memset(&omap_i2c_dev, 0, sizeof(omap_i2c_dev));
+	init_waitqueue_head(&omap_i2c_dev.cmd_wait);
+
+	/* reset ASAP, clearing any IRQs */
+	omap_i2c_reset();
+
+	r = request_irq(INT_I2C, omap_i2c_isr, 0, driver_name, &omap_i2c_dev);
+	if (r) {
+		pr_debug("%s: failure requesting irq\n", driver_name);
+		goto do_release_region;
+	}
+
+	r = readw(OMAP_I2C_REV) & 0xff;
+	pr_info("%s: rev%d.%d at %d KHz\n", driver_name,
+			r >> 4, r & 0xf, clock);
+
+	/* i2c device drivers may be active on return from add_adapter() */
+	i2c_set_adapdata(&omap_i2c_adap, &omap_i2c_dev);
+	omap_i2c_adap.dev.parent = dev;
+	r = i2c_add_adapter(&omap_i2c_adap);
+	if (r) {
+		pr_debug("%s: failure adding adapter\n", driver_name);
+		goto do_free_irq;
+	}
+
+	return 0;
+
+do_free_irq:
+	free_irq(INT_I2C, &omap_i2c_dev);
+do_release_region:
+	writew(0, OMAP_I2C_CON);
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+
+	return r;
+}
+
+static int __exit
+omap_i2c_remove(struct device *dev)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	struct resource		*mem;
+
+	writew(0, OMAP_I2C_CON);
+	i2c_del_adapter(&omap_i2c_adap);
+	free_irq(INT_I2C, &omap_i2c_dev);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	return 0;
+}
+
+static struct device_driver omap_i2c_driver = {
+	.name		= (char *)driver_name,
+	.bus		= &platform_bus_type,
+	.probe		= omap_i2c_probe,
+	.remove		= __exit_p(omap_i2c_remove),
+};
+
+/* i2c may be needed to bring up other drivers */
+static int __init
+omap_i2c_init_driver(void)
+{
+	return driver_register(&omap_i2c_driver);
+}
+subsys_initcall(omap_i2c_init_driver);
+
+static void __exit omap_i2c_exit_driver(void)
+{
+	driver_unregister(&omap_i2c_driver);
+}
+module_exit(omap_i2c_exit_driver);
+
+MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
+MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
+MODULE_LICENSE("GPL");
--- linux-2.6/drivers/i2c/busses/i2c-omap.h	1969-12-31 16:00:00.000000000 -0800
+++ omap-2.6/drivers/i2c/busses/i2c-omap.h	2005-05-14 12:03:31.000000000 -0700
@@ -0,0 +1,114 @@
+/*
+ *  linux/drivers/i2c/i2c-omap1610.h
+ *
+ *  BRIEF MODULE DESCRIPTION
+ *      OMAP I2C register definitions
+ *
+ *  Copyright (C) 2004 Texas Instruments.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * 
+ *  HISTORY:
+ * 
+ *  20040824: Thiago Radicchi <trr@dcc.ufmg.br>  DCC-UFMG / iNdT
+ *       Removed some ifdefs which broke compilation for some platforms.
+ *       Added new defintion for interrupt vector.
+ */
+
+/* I2C Registers: */
+
+#define OMAP_I2C_BASE        IO_ADDRESS(0xfffb3800)
+#define OMAP_I2C_IOSIZE      (0x40)
+#define OMAP_I2C_REV         (OMAP_I2C_BASE + 0x00)
+#define OMAP_I2C_IE          (OMAP_I2C_BASE + 0x04)
+#define OMAP_I2C_STAT        (OMAP_I2C_BASE + 0x08)
+#define OMAP_I2C_IV          (OMAP_I2C_BASE + 0x0c)
+#define OMAP_I2C_SYSS        (OMAP_I2C_BASE + 0x10)
+#define OMAP_I2C_BUF         (OMAP_I2C_BASE + 0x14)
+#define OMAP_I2C_CNT         (OMAP_I2C_BASE + 0x18)
+#define OMAP_I2C_DATA        (OMAP_I2C_BASE + 0x1c)
+#define OMAP_I2C_SYSC        (OMAP_I2C_BASE + 0x20)
+#define OMAP_I2C_CON         (OMAP_I2C_BASE + 0x24)
+#define OMAP_I2C_OA          (OMAP_I2C_BASE + 0x28)
+#define OMAP_I2C_SA          (OMAP_I2C_BASE + 0x2c)
+#define OMAP_I2C_PSC         (OMAP_I2C_BASE + 0x30)
+#define OMAP_I2C_SCLL        (OMAP_I2C_BASE + 0x34)
+#define OMAP_I2C_SCLH        (OMAP_I2C_BASE + 0x38)
+#define OMAP_I2C_SYSTEST     (OMAP_I2C_BASE + 0x3c)
+
+/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
+
+#define OMAP_I2C_IE_XRDY_IE  (1 << 4)	/* Transmit data ready interrupt enable */
+#define OMAP_I2C_IE_RRDY_IE  (1 << 3)	/* Receive data ready interrupt enable */
+#define OMAP_I2C_IE_ARDY_IE  (1 << 2)	/* Register access ready interrupt enable */
+#define OMAP_I2C_IE_NACK_IE  (1 << 1)	/* No acknowledgment interrupt enable */
+#define OMAP_I2C_IE_AL_IE    (1 << 0)	/* Arbitration lost interrupt enable */
+
+/* I2C Status Register (OMAP_I2C_STAT): */
+
+#define OMAP_I2C_STAT_SBD    (1 << 15)	/* Single byte data */
+#define OMAP_I2C_STAT_BB     (1 << 12)	/* Bus busy */
+#define OMAP_I2C_STAT_ROVR   (1 << 11)	/* Receive overrun */
+#define OMAP_I2C_STAT_XUDF   (1 << 10)	/* Transmit underflow */
+#define OMAP_I2C_STAT_AAS    (1 << 9)	/* Address as slave */
+#define OMAP_I2C_STAT_AD0    (1 << 8)	/* Address zero */
+#define OMAP_I2C_STAT_XRDY   (1 << 4)	/* Transmit data ready */
+#define OMAP_I2C_STAT_RRDY   (1 << 3)	/* Receive data ready */
+#define OMAP_I2C_STAT_ARDY   (1 << 2)	/* Register access ready */
+#define OMAP_I2C_STAT_NACK   (1 << 1)	/* No acknowledgment interrupt enable */
+#define OMAP_I2C_STAT_AL     (1 << 0)	/* Arbitration lost interrupt enable */
+
+/* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
+
+#define OMAP_I2C_BUF_RDMA_EN         (1 << 15)	/* Receive DMA channel enable */
+#define OMAP_I2C_BUF_XDMA_EN         (1 << 7)	/* Transmit DMA channel enable */
+
+/* I2C Configuration Register (OMAP_I2C_CON): */
+
+#define OMAP_I2C_CON_EN      (1 << 15)	/* I2C module enable */
+#define OMAP_I2C_CON_RST     (0 << 15)  /* I2C module reset */
+#define OMAP_I2C_CON_BE      (1 << 14)	/* Big endian mode */
+#define OMAP_I2C_CON_STB     (1 << 11)	/* Start byte mode (master mode only) */
+#define OMAP_I2C_CON_MST     (1 << 10)	/* Master/slave mode */
+#define OMAP_I2C_CON_TRX     (1 << 9)	/* Transmitter/receiver mode (master mode only) */
+#define OMAP_I2C_CON_XA      (1 << 8)	/* Expand address */
+#define OMAP_I2C_CON_RM      (1 << 2)	/* Repeat mode (master mode only) */
+#define OMAP_I2C_CON_STP     (1 << 1)	/* Stop condition (master mode only) */
+#define OMAP_I2C_CON_STT     (1 << 0)	/* Start condition (master mode only) */
+
+/* I2C System Test Register (OMAP_I2C_SYSTEST): */
+
+#define OMAP_I2C_SYSTEST_ST_EN       (1 << 15)	/* System test enable */
+#define OMAP_I2C_SYSTEST_FREE        (1 << 14)	/* Free running mode (on breakpoint) */
+#define OMAP_I2C_SYSTEST_TMODE_MASK  (3 << 12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_TMODE_SHIFT (12)	/* Test mode select */
+#define OMAP_I2C_SYSTEST_SCL_I       (1 << 3)	/* SCL line sense input value */
+#define OMAP_I2C_SYSTEST_SCL_O       (1 << 2)	/* SCL line drive output value */
+#define OMAP_I2C_SYSTEST_SDA_I       (1 << 1)	/* SDA line sense input value */
+#define OMAP_I2C_SYSTEST_SDA_O       (1 << 0)	/* SDA line drive output value */
+
+/* I2C System Status register (OMAP_I2C_SYSS): */
+
+#define OMAP_I2C_SYSS_RDONE          1	/* Reset Done */
+
+/* I2C System Configuration Register (OMAP_I2C_SYSC): */
+
+#define OMAP_I2C_SYSC_SRST           (1 << 1)	/* Soft Reset */
--- linux-2.6/drivers/i2c/busses/Kconfig	2005-06-23 09:07:48.000000000 -0700
+++ omap-2.6/drivers/i2c/busses/Kconfig	2005-08-02 14:52:38.000000000 -0700
@@ -497,4 +497,11 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mv64xxx.
 
+config I2C_OMAP
+	tristate "OMAP I2C adapter"
+	depends on I2C && ARCH_OMAP
+	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
+	help
+	  Support for TI OMAP I2C driver. Say yes if you want to use the OMAP
+	  I2C interface.
 endmenu
--- linux-2.6/drivers/i2c/busses/Makefile	2005-05-03 13:49:20.000000000 -0700
+++ omap-2.6/drivers/i2c/busses/Makefile	2005-05-14 12:03:31.000000000 -0700
@@ -41,6 +41,7 @@
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_OMAP)          += i2c-omap.o
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
