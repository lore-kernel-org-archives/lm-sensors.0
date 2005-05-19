From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734271572@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ChangeSet 1.1315.1.24, 2003/09/22 15:00:04-07:00, greg@kroah.com

[PATCH] I2C: move the remaining i2c bus drivers to drivers/i2c/busses


 drivers/i2c/i2c-adap-ite.c       |  278 --------------
 drivers/i2c/i2c-frodo.c          |   85 ----
 drivers/i2c/i2c-ibm_iic.c        |  729 ---------------------------------------
 drivers/i2c/i2c-ibm_iic.h        |  124 ------
 drivers/i2c/i2c-iop3xx.c         |  536 ----------------------------
 drivers/i2c/i2c-iop3xx.h         |  118 ------
 drivers/i2c/i2c-keywest.c        |  653 ----------------------------------
 drivers/i2c/i2c-keywest.h        |  110 -----
 drivers/i2c/i2c-rpx.c            |  103 -----
 drivers/i2c/Kconfig              |   35 -
 drivers/i2c/Makefile             |   10 
 drivers/i2c/busses/Kconfig       |   35 +
 drivers/i2c/busses/Makefile      |    9 
 drivers/i2c/busses/i2c-frodo.c   |   85 ++++
 drivers/i2c/busses/i2c-ibm_iic.c |  729 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-ibm_iic.h |  124 ++++++
 drivers/i2c/busses/i2c-iop3xx.c  |  536 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-iop3xx.h  |  118 ++++++
 drivers/i2c/busses/i2c-ite.c     |  278 ++++++++++++++
 drivers/i2c/busses/i2c-keywest.c |  653 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-keywest.h |  110 +++++
 drivers/i2c/busses/i2c-rpx.c     |  103 +++++
 22 files changed, 2781 insertions(+), 2780 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:12:05 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:12:05 2003
@@ -59,17 +59,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-pcf.
 
-config I2C_KEYWEST
-	tristate "Powermac Keywest I2C interface"
-	depends on I2C && PPC_PMAC
-	help
-	  This supports the use of the I2C interface in the combo-I/O
-	  chip on recent Apple machines.  Say Y if you have such a machine.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-keywest.
-
-config ITE_I2C_ALGO
+config I2C_ALGOITE
 	tristate "ITE I2C Algorithm"
 	depends on MIPS_ITE8172 && I2C
 	help
@@ -80,32 +70,9 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-ite.
 
-config ITE_I2C_ADAP
-	tristate "ITE I2C Adapter"
-	depends on ITE_I2C_ALGO
-	help
-	  This supports the ITE8172 I2C peripheral found on some MIPS
-	  systems. Say Y if you have one of these. You should also say Y for
-	  the ITE I2C driver algorithm support above.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-adap-ite.
-
 config I2C_ALGO8XX
 	tristate "MPC8xx CPM I2C interface"
 	depends on 8xx && I2C
-
-config I2C_RPXLITE
-	tristate "Embedded Planet RPX Lite/Classic suppoort"
-	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
-
-config I2C_IBM_IIC
-	tristate "IBM IIC I2C"
-	depends on IBM_OCP && I2C
-
-config I2C_IOP3XX
-	tristate "Intel XScale IOP3xx on-chip I2C interface"
-	depends on ARCH_IOP3XX && I2C
 
 	source drivers/i2c/busses/Kconfig
 	source drivers/i2c/chips/Kconfig
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:12:05 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:12:05 2003
@@ -1,15 +1,11 @@
 #
-# Makefile for the kernel i2c bus driver.
+# Makefile for the i2c core.
 #
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
+obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
-obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
-obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
-obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
-obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
-obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
-obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
+obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
 obj-y				+= busses/ chips/
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:05 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:05 2003
@@ -2,7 +2,7 @@
 # Sensor device configuration
 #
 
-menu "I2C Hardware Sensors Mainboard support"
+menu "I2C Hardware Bus support"
 
 config I2C_ALI1535
 	tristate "ALI 1535"
@@ -97,6 +97,14 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i810.
 
+config I2C_IBM_IIC
+	tristate "IBM IIC I2C"
+	depends on IBM_OCP && I2C
+
+config I2C_IOP3XX
+	tristate "Intel XScale IOP3xx on-chip I2C interface"
+	depends on ARCH_IOP3XX && I2C
+
 config I2C_ISA
 	tristate "ISA Bus support"
 	depends on I2C && ISA && EXPERIMENTAL
@@ -107,6 +115,27 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-isa.
 
+config I2C_ITE
+	tristate "ITE I2C Adapter"
+	depends on I2C_ALGOITE
+	help
+	  This supports the ITE8172 I2C peripheral found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C driver algorithm support above.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-ite.
+
+config I2C_KEYWEST
+	tristate "Powermac Keywest I2C interface"
+	depends on I2C && PPC_PMAC
+	help
+	  This supports the use of the I2C interface in the combo-I/O
+	  chip on recent Apple machines.  Say Y if you have such a machine.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-keywest.
+
 config I2C_NFORCE2
 	tristate "Nvidia Nforce2"
 	depends on I2C && PCI && EXPERIMENTAL
@@ -155,6 +184,10 @@
 
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-prosavage.
+
+config I2C_RPXLITE
+	tristate "Embedded Planet RPX Lite/Classic suppoort"
+	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
 
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:05 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:05 2003
@@ -1,5 +1,5 @@
 #
-# Makefile for the kernel hardware sensors bus drivers.
+# Makefile for the i2c bus drivers.
 #
 
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
@@ -10,11 +10,16 @@
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
+obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
+obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
+obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
+obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
+obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
@@ -23,5 +28,5 @@
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
-obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
diff -Nru a/drivers/i2c/busses/i2c-frodo.c b/drivers/i2c/busses/i2c-frodo.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-frodo.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,85 @@
+
+/*
+ * linux/drivers/i2c/i2c-frodo.c
+ *
+ * Author: Abraham van der Merwe <abraham@2d3d.co.za>
+ *
+ * An I2C adapter driver for the 2d3D, Inc. StrongARM SA-1110
+ * Development board (Frodo).
+ *
+ * This source code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/hardware.h>
+
+
+static void frodo_setsda (void *data,int state)
+{
+	if (state)
+		FRODO_CPLD_I2C |= FRODO_I2C_SDA_OUT;
+	else
+		FRODO_CPLD_I2C &= ~FRODO_I2C_SDA_OUT;
+}
+
+static void frodo_setscl (void *data,int state)
+{
+	if (state)
+		FRODO_CPLD_I2C |= FRODO_I2C_SCL_OUT;
+	else
+		FRODO_CPLD_I2C &= ~FRODO_I2C_SCL_OUT;
+}
+
+static int frodo_getsda (void *data)
+{
+	return ((FRODO_CPLD_I2C & FRODO_I2C_SDA_IN) != 0);
+}
+
+static int frodo_getscl (void *data)
+{
+	return ((FRODO_CPLD_I2C & FRODO_I2C_SCL_IN) != 0);
+}
+
+static struct i2c_algo_bit_data bit_frodo_data = {
+	.setsda		= frodo_setsda,
+	.setscl		= frodo_setscl,
+	.getsda		= frodo_getsda,
+	.getscl		= frodo_getscl,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter frodo_ops = {
+	.owner			= THIS_MODULE,
+	.id			= I2C_HW_B_FRODO,
+	.algo_data		= &bit_frodo_data,
+	.dev			= {
+		.name		= "Frodo adapter driver",
+	},
+};
+
+static int __init i2c_frodo_init (void)
+{
+	return i2c_bit_add_bus(&frodo_ops);
+}
+
+static void __exit i2c_frodo_exit (void)
+{
+	i2c_bit_del_bus(&frodo_ops);
+}
+
+MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
+MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
+MODULE_LICENSE ("GPL");
+
+module_init (i2c_frodo_init);
+module_exit (i2c_frodo_exit);
+
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,729 @@
+/*
+ * drivers/i2c/i2c-ibm_iic.c
+ *
+ * Support for the IIC peripheral on IBM PPC 4xx
+ *
+ * Copyright (c) 2003 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by 
+ * 	Ian DaSilva  <idasilva@mvista.com>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Matt Porter  <mporter@mvista.com>
+ *
+ *      Copyright 2000-2003 MontaVista Software Inc.
+ *
+ * Original driver version was highly leveraged from i2c-elektor.c
+ *
+ *   	Copyright 1995-97 Simon G. Vogl
+ *                1998-99 Hans Berglund
+ *
+ *   	With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> 
+ *	and even Frodo Looijaard <frodol@dds.nl>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <asm/ocp.h>
+#include <asm/ibm4xx.h>
+
+#include "i2c-ibm_iic.h"
+
+#define DRIVER_VERSION "2.0"
+
+MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+
+static int iic_scan = 0;
+MODULE_PARM(iic_scan, "i");
+MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
+
+static int iic_force_poll = 0;
+MODULE_PARM(iic_force_poll, "i");
+MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
+
+static int iic_force_fast = 0;
+MODULE_PARM(iic_force_fast, "i");
+MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
+
+#define DBG_LEVEL 0
+
+#ifdef DBG
+#undef DBG
+#endif
+
+#ifdef DBG2
+#undef DBG2
+#endif
+
+#if DBG_LEVEL > 0
+#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
+#else
+#  define DBG(x...)	((void)0)
+#endif
+#if DBG_LEVEL > 1
+#  define DBG2(x...) 	DBG( ##x )
+#else
+#  define DBG2(x...) 	((void)0)
+#endif
+#if DBG_LEVEL > 2
+static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
+	printk(KERN_DEBUG "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
+	       KERN_DEBUG "  sts      = 0x%02x, extsts = 0x%02x\n"
+	       KERN_DEBUG "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
+	       KERN_DEBUG "  xtcntlss = 0x%02x, directcntl = 0x%02x\n",
+		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts), 
+		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt), 
+		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
+}
+#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
+#else
+#  define DUMP_REGS(h,dev)	((void)0)
+#endif
+
+/* Enable/disable interrupt generation */
+static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
+{
+	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
+}
+ 
+/*
+ * Initialize IIC interface.
+ */
+static void iic_dev_init(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+
+	DBG("%d: init\n", dev->idx);
+	
+	/* Clear master address */
+	out_8(&iic->lmadr, 0);
+	out_8(&iic->hmadr, 0);
+
+	/* Clear slave address */
+	out_8(&iic->lsadr, 0);
+	out_8(&iic->hsadr, 0);
+
+	/* Clear status & extended status */
+	out_8(&iic->sts, STS_SCMP | STS_IRQA);
+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
+			    | EXTSTS_ICT | EXTSTS_XFRA);
+
+	/* Set clock divider */
+	out_8(&iic->clkdiv, dev->clckdiv);
+
+	/* Clear transfer count */
+	out_8(&iic->xfrcnt, 0);
+
+	/* Clear extended control and status */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
+			    | XTCNTLSS_SWS);
+
+	/* Clear control register */
+	out_8(&iic->cntl, 0);
+	
+	/* Enable interrupts if possible */
+	iic_interrupt_mode(dev, dev->irq >= 0);
+
+	/* Set mode control */
+	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
+			    | (dev->fast_mode ? MDCNTL_FSM : 0));
+
+	DUMP_REGS("iic_init", dev);
+}
+
+/* 
+ * Reset IIC interface
+ */
+static void iic_dev_reset(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	int i;
+	u8 dc;
+	
+	DBG("%d: soft reset\n", dev->idx);
+	DUMP_REGS("reset", dev);
+	
+    	/* Place chip in the reset state */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+	
+	/* Check if bus is free */
+	dc = in_8(&iic->directcntl);	
+	if (!DIRCTNL_FREE(dc)){
+		DBG("%d: trying to regain bus control\n", dev->idx);
+	
+		/* Try to set bus free state */
+		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);	
+	
+		/* Wait until we regain bus control */
+		for (i = 0; i < 100; ++i){
+			dc = in_8(&iic->directcntl);
+			if (DIRCTNL_FREE(dc))
+				break;
+			
+			/* Toggle SCL line */
+			dc ^= DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+			udelay(10);
+			dc ^= DIRCNTL_SCC;
+			out_8(&iic->directcntl, dc);
+			
+			/* be nice */
+			cond_resched();
+		}
+	}
+	
+	/* Remove reset */
+	out_8(&iic->xtcntlss, 0);
+	
+	/* Reinitialize interface */
+	iic_dev_init(dev);
+}
+
+/*
+ * IIC interrupt handler
+ */
+static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
+	volatile struct iic_regs* iic = dev->vaddr;
+	
+	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n", 
+	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
+	
+	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
+	wake_up_interruptible(&dev->wq);
+	
+	return IRQ_HANDLED;
+}
+
+/*
+ * Get master transfer result and clear errors if any.
+ * Returns the number of actually transferred bytes or error (<0)
+ */
+static int iic_xfer_result(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;	
+	
+	if (unlikely(in_8(&iic->sts) & STS_ERR)){
+		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx, 
+			in_8(&iic->extsts));
+				
+		/* Clear errors and possible pending IRQs */
+		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | 
+			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
+			
+		/* Flush master data buffer */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+		
+		/* Is bus free?
+		 * If error happened during combined xfer
+		 * IIC interface is usually stuck in some strange
+		 * state, the only way out - soft reset.
+		 */
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+			DBG("%d: bus is stuck, resetting\n", dev->idx);
+			iic_dev_reset(dev);
+		}
+		return -EREMOTEIO;
+	}
+	else
+		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
+}
+
+/*
+ * Try to abort active transfer.
+ */
+static void iic_abort_xfer(struct ibm_iic_private* dev)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	unsigned long x;
+	
+	DBG("%d: iic_abort_xfer\n", dev->idx);
+	
+	out_8(&iic->cntl, CNTL_HMT);
+	
+	/*
+	 * Wait for the abort command to complete.
+	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
+	 */
+	x = jiffies + 2;
+	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+		if (time_after(jiffies, x)){
+			DBG("%d: abort timeout, resetting...\n", dev->idx);
+			iic_dev_reset(dev);
+			return;
+		}
+		schedule();
+	}
+
+	/* Just to clear errors */
+	iic_xfer_result(dev);
+}
+
+/*
+ * Wait for master transfer to complete.
+ * It puts current process to sleep until we get interrupt or timeout expires.
+ * Returns the number of transferred bytes or error (<0)
+ */
+static int iic_wait_for_tc(struct ibm_iic_private* dev){
+	
+	volatile struct iic_regs *iic = dev->vaddr;
+	int ret = 0;
+	
+	if (dev->irq >= 0){
+		/* Interrupt mode */
+		wait_queue_t wait;
+    		init_waitqueue_entry(&wait, current);
+		
+		add_wait_queue(&dev->wq, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (in_8(&iic->sts) & STS_PT)
+			schedule_timeout(dev->adap.timeout * HZ);
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&dev->wq, &wait);
+		
+		if (unlikely(signal_pending(current))){
+			DBG("%d: wait interrupted\n", dev->idx);
+			ret = -ERESTARTSYS;
+		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
+			DBG("%d: wait timeout\n", dev->idx);
+			ret = -ETIMEDOUT;
+		}
+	}
+	else {
+		/* Polling mode */
+		unsigned long x = jiffies + dev->adap.timeout * HZ;
+		
+		while (in_8(&iic->sts) & STS_PT){
+			if (unlikely(time_after(jiffies, x))){
+				DBG("%d: poll timeout\n", dev->idx);
+				ret = -ETIMEDOUT;
+				break;
+			}
+		
+			if (unlikely(signal_pending(current))){
+				DBG("%d: poll interrupted\n", dev->idx);
+				ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}	
+	}
+	
+	if (unlikely(ret < 0))
+		iic_abort_xfer(dev);
+	else
+		ret = iic_xfer_result(dev);
+	
+	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
+	
+	return ret;
+}
+
+/*
+ * Low level master transfer routine
+ */
+static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm, 
+			  int combined_xfer)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	char* buf = pm->buf;
+	int i, j, loops, ret = 0;
+	int len = pm->len;
+
+	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
+	if (pm->flags & I2C_M_RD)
+		cntl |= CNTL_RW;
+	
+	loops = (len + 3) / 4;
+	for (i = 0; i < loops; ++i, len -= 4){
+		int count = len > 4 ? 4 : len;
+		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
+		
+		if (!(cntl & CNTL_RW))
+			for (j = 0; j < count; ++j)
+				out_8((volatile u8*)&iic->mdbuf, *buf++);
+		
+		if (i < loops - 1)
+			cmd |= CNTL_CHT;
+		else if (combined_xfer)
+			cmd |= CNTL_RPST;
+		
+		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
+		
+		/* Start transfer */
+		out_8(&iic->cntl, cmd);
+		
+		/* Wait for completion */
+		ret = iic_wait_for_tc(dev);
+
+		if (unlikely(ret < 0))
+			break;
+		else if (unlikely(ret != count)){
+			DBG("%d: xfer_bytes, requested %d, transfered %d\n", 
+				dev->idx, count, ret);
+			
+			/* If it's not a last part of xfer, abort it */
+			if (combined_xfer || (i < loops - 1))
+    				iic_abort_xfer(dev);
+				
+			ret = -EREMOTEIO;
+			break;				
+		}
+		
+		if (cntl & CNTL_RW)
+			for (j = 0; j < count; ++j)
+				*buf++ = in_8((volatile u8*)&iic->mdbuf);
+	}
+	
+	return ret > 0 ? 0 : ret;
+}
+
+/*
+ * Set target slave address for master transfer
+ */
+static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
+{
+	volatile struct iic_regs *iic = dev->vaddr;
+	u16 addr = msg->addr;
+	
+	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx, 
+		addr, msg->flags & I2C_M_TEN ? 10 : 7);
+	
+	if (msg->flags & I2C_M_TEN){
+	    out_8(&iic->cntl, CNTL_AMD);
+	    out_8(&iic->lmadr, addr);
+	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
+	}
+	else {
+	    out_8(&iic->cntl, 0);
+	    out_8(&iic->lmadr, addr << 1);
+	}
+}
+
+static inline int iic_invalid_address(const struct i2c_msg* p)
+{
+	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
+}
+
+static inline int iic_address_neq(const struct i2c_msg* p1, 
+				  const struct i2c_msg* p2)
+{
+	return (p1->addr != p2->addr) 
+		|| ((p1->flags & I2C_M_TEN) != (p2->flags & I2C_M_TEN));
+} 
+
+/*
+ * Generic master transfer entrypoint. 
+ * Returns the number of processed messages or error (<0)
+ */
+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+    	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
+	volatile struct iic_regs *iic = dev->vaddr;
+	int i, ret = 0;
+	
+	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
+	
+	if (!num)
+		return 0;
+	
+	/* Check the sanity of the passed messages.
+	 * Uhh, generic i2c layer is more suitable place for such code...
+	 */
+	if (unlikely(iic_invalid_address(&msgs[0]))){
+		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx, 
+			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
+		return -EINVAL;
+	}		
+	for (i = 0; i < num; ++i){
+		if (unlikely(msgs[i].len <= 0)){
+			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
+				msgs[i].len, i);
+			return -EINVAL;
+		}
+		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
+			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
+			return -EINVAL;
+		}
+	}
+	
+	/* Check bus state */
+	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
+		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
+		
+		/* Usually it means something serious has happend.
+		 * We *cannot* have unfinished previous transfer
+		 * so it doesn't make any sense to try to stop it.
+		 * Probably we were not able to recover from the 
+		 * previous error.
+		 * The only *reasonable* thing I can think of here
+		 * is soft reset.  --ebs
+		 */
+		iic_dev_reset(dev);
+		
+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
+			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
+			return -EREMOTEIO;
+		}
+	} 
+	else {
+		/* Flush master data buffer (just in case) */
+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
+	}
+	
+	/* Load slave address */
+	iic_address(dev, &msgs[0]);
+	
+	/* Do real transfer */
+    	for (i = 0; i < num && !ret; ++i)
+		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
+
+	return ret < 0 ? ret : num;
+}
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
+}
+
+static struct i2c_algorithm iic_algo = {
+	.name 		= "IBM IIC algorithm",
+	.id   		= I2C_ALGO_OCP,
+	.master_xfer 	= iic_xfer,
+	.smbus_xfer	= NULL,
+	.slave_send	= NULL,
+	.slave_recv	= NULL,
+	.algo_control	= NULL,
+	.functionality	= iic_func
+};
+
+/*
+ * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
+ * We only scan range [0x08 - 0x77], all other addresses are reserved anyway
+ */
+static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
+{
+	int found = 0;
+	char dummy;
+	struct i2c_msg msg = {
+		.buf   = &dummy,
+		.len   = sizeof(dummy),
+		.flags = I2C_M_RD
+	};
+	
+	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
+	
+	for (msg.addr = 8; msg.addr < 0x78; ++msg.addr)
+		if (iic_xfer(&dev->adap, &msg, 1) = 1){
+			++found;
+			printk(" 0x%02x", msg.addr);
+		}
+
+	printk("%sibm-iic%d: %d device(s) detected\n", 
+		found ? "\n" KERN_INFO : "", dev->idx, found);
+}
+
+/*
+ * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
+ */
+static inline u8 iic_clckdiv(unsigned int opb)
+{
+	/* Compatibility kludge, should go away after all cards
+	 * are fixed to fill correct value for opbfreq.
+	 * Previous driver version used hardcoded divider value 4,
+	 * it corresponds to OPB frequency from the range (40, 50] MHz
+	 */
+	if (!opb){
+		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
+			" fix your board specific setup\n");
+		opb = 50000000;
+	}
+
+	/* Convert to MHz */
+	opb /= 1000000;
+	
+	if (opb < 20 || opb > 150){
+		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
+			opb);
+		opb = opb < 20 ? 20 : 150;
+	}
+	return (u8)((opb + 9) / 10 - 1);
+}
+
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe(struct ocp_device *ocp){
+
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	int ret;
+	bd_t* bd = (bd_t*)&__res;
+	
+	if (!(dev = kmalloc(sizeof(*dev), GFP_KERNEL))){
+		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	dev->idx = ocp->num;
+	ocp_set_drvdata(ocp, dev);
+	
+	if (!(dev->vaddr = ioremap(ocp->paddr, sizeof(struct iic_regs)))){
+		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
+			dev->idx);
+		ret = -ENXIO;
+		goto fail2;
+	}
+	
+	init_waitqueue_head(&dev->wq);
+
+	dev->irq = iic_force_poll ? -1 : ocp->irq;
+	if (dev->irq >= 0){
+		/* Disable interrupts until we finish intialization,
+		   assumes level-sensitive IRQ setup...
+		 */
+		iic_interrupt_mode(dev, 0);
+		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
+			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n", 
+				dev->idx, dev->irq);
+			/* Fallback to the polling mode */	
+			dev->irq = -1;
+		}
+	}
+	
+	if (dev->irq < 0)
+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n", 
+			dev->idx);
+		
+	/* Board specific settings */
+	BUG_ON(dev->idx >= sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]));
+	dev->fast_mode = iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
+	
+	/* clckdiv is the same for *all* IIC interfaces, 
+	 * but I'd rather make a copy than introduce another global. --ebs
+	 */
+	dev->clckdiv = iic_clckdiv(bd->bi_opb_busfreq);
+	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
+	
+	/* Initialize IIC interface */
+	iic_dev_init(dev);
+	
+	/* Register it with i2c layer */
+	adap = &dev->adap;
+	strcpy(adap->dev.name, "IBM IIC");
+	i2c_set_adapdata(adap, dev);
+	adap->id = I2C_HW_OCP | iic_algo.id;
+	adap->algo = &iic_algo;
+	adap->client_register = NULL;
+	adap->client_unregister = NULL;
+	adap->timeout = 1;
+	adap->retries = 1;
+
+	if ((ret = i2c_add_adapter(adap)) != 0){
+		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
+			dev->idx);
+		goto fail;
+	}
+	
+	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
+		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
+
+	/* Scan bus if requested by user */
+	if (iic_scan)
+		iic_scan_bus(dev);
+
+	return 0;
+
+fail:	
+	if (dev->irq >= 0){
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}	
+
+	iounmap((void*)dev->vaddr);
+fail2:	
+	ocp_set_drvdata(ocp, 0);
+	kfree(dev);	
+	return ret;
+}
+
+/*
+ * Cleanup initialized IIC interface
+ */
+static void __devexit iic_remove(struct ocp_device *ocp)
+{
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
+	BUG_ON(dev = NULL);
+	if (i2c_del_adapter(&dev->adap)){
+		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
+			dev->idx);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq >= 0){
+		    iic_interrupt_mode(dev, 0);	
+		    free_irq(dev->irq, dev);
+		    dev->irq = -1;
+		}
+	} else {
+		if (dev->irq >= 0){
+		    iic_interrupt_mode(dev, 0);	
+		    free_irq(dev->irq, dev);
+		}
+		iounmap((void*)dev->vaddr);
+		kfree(dev);
+	}
+}
+
+static struct ocp_device_id ibm_iic_ids[] __devinitdata = 
+{
+	{ .vendor = OCP_VENDOR_IBM, .device = OCP_FUNC_IIC },
+	{ .vendor = OCP_VENDOR_INVALID }
+};
+
+MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
+
+static struct ocp_driver ibm_iic_driver +{
+	.name 		= "ocp_iic",
+	.id_table	= ibm_iic_ids,
+	.probe		= iic_probe,
+	.remove		= __devexit_p(iic_remove),
+#if defined(CONFIG_PM)
+	.suspend	= NULL,
+	.resume		= NULL,
+#endif
+};
+
+static int __init iic_init(void)
+{
+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
+	return ocp_module_init(&ibm_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	ocp_unregister_driver(&ibm_iic_driver);
+}
+
+module_init(iic_init);
+module_exit(iic_exit);
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ibm_iic.h	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,124 @@
+/*
+ * drivers/i2c/i2c-ibm_iic.h
+ *
+ * Support for the IIC peripheral on IBM PPC 4xx
+ * 
+ * Copyright (c) 2003 Zultys Technologies.
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *
+ * Based on original work by 
+ * 	Ian DaSilva  <idasilva@mvista.com>
+ *      Armin Kuster <akuster@mvista.com>
+ * 	Matt Porter  <mporter@mvista.com>
+ *
+ *      Copyright 2000-2003 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __I2C_IBM_IIC_H_
+#define __I2C_IBM_IIC_H_
+
+#include <linux/config.h>
+#include <linux/i2c.h> 
+
+struct iic_regs {
+	u16 mdbuf;
+	u16 sbbuf;
+	u8 lmadr;
+	u8 hmadr;
+	u8 cntl;
+	u8 mdcntl;
+	u8 sts;
+	u8 extsts;
+	u8 lsadr;
+	u8 hsadr;
+	u8 clkdiv;
+	u8 intmsk;
+	u8 xfrcnt;
+	u8 xtcntlss;
+	u8 directcntl;
+};
+
+struct ibm_iic_private {
+	struct i2c_adapter adap;
+	volatile struct iic_regs *vaddr;
+	wait_queue_head_t wq;
+	int idx;
+	int irq;
+	int fast_mode;
+	u8  clckdiv;
+};
+
+/* IICx_CNTL register */
+#define CNTL_HMT	0x80
+#define CNTL_AMD	0x40
+#define CNTL_TCT_MASK	0x30
+#define CNTL_TCT_SHIFT	4
+#define CNTL_RPST	0x08
+#define CNTL_CHT	0x04 
+#define CNTL_RW		0x02
+#define CNTL_PT		0x01
+
+/* IICx_MDCNTL register */
+#define MDCNTL_FSDB	0x80
+#define MDCNTL_FMDB	0x40
+#define MDCNTL_EGC	0x20
+#define MDCNTL_FSM	0x10
+#define MDCNTL_ESM	0x08
+#define MDCNTL_EINT	0x04
+#define MDCNTL_EUBS	0x02
+#define MDCNTL_HSCL	0x01
+
+/* IICx_STS register */
+#define STS_SSS		0x80
+#define STS_SLPR	0x40
+#define STS_MDBS	0x20
+#define STS_MDBF	0x10
+#define STS_SCMP	0x08
+#define STS_ERR		0x04
+#define STS_IRQA	0x02
+#define STS_PT		0x01
+
+/* IICx_EXTSTS register */
+#define EXTSTS_IRQP	0x80
+#define EXTSTS_BCS_MASK	0x70
+#define   EXTSTS_BCS_FREE  0x40
+#define EXTSTS_IRQD	0x08
+#define EXTSTS_LA	0x04
+#define EXTSTS_ICT	0x02
+#define EXTSTS_XFRA	0x01
+
+/* IICx_INTRMSK register */
+#define INTRMSK_EIRC	0x80
+#define INTRMSK_EIRS	0x40
+#define INTRMSK_EIWC	0x20
+#define INTRMSK_EIWS	0x10
+#define INTRMSK_EIHE	0x08
+#define INTRMSK_EIIC	0x04
+#define INTRMSK_EITA	0x02
+#define INTRMSK_EIMTC	0x01
+
+/* IICx_XFRCNT register */
+#define XFRCNT_MTC_MASK	0x07
+
+/* IICx_XTCNTLSS register */
+#define XTCNTLSS_SRC	0x80
+#define XTCNTLSS_SRS	0x40
+#define XTCNTLSS_SWC	0x20
+#define XTCNTLSS_SWS	0x10
+#define XTCNTLSS_SRST	0x01
+
+/* IICx_DIRECTCNTL register */
+#define DIRCNTL_SDAC	0x08
+#define DIRCNTL_SCC	0x04
+#define DIRCNTL_MSDA	0x02
+#define DIRCNTL_MSC	0x01
+
+/* Check if we really control the I2C bus and bus is free */
+#define DIRCTNL_FREE(v)	(((v) & 0x0f) = 0x0f)
+
+#endif /* __I2C_IBM_IIC_H_ */
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-iop3xx.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,536 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx                */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
+ *                      <Peter dot Milne at D hyphen TACQ dot com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation, version 2.
+
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
+/* ------------------------------------------------------------------------- */
+/*
+   With acknowledgements to i2c-algo-ibm_ocp.c by 
+   Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
+
+   And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglund:
+
+     Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
+   
+   And which acknowledged Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+   Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.com>
+
+  ---------------------------------------------------------------------------*/
+
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/i2c.h>
+
+
+#include <asm/arch-iop3xx/iop321.h>
+#include <asm/arch-iop3xx/iop321-irqs.h>
+#include "i2c-iop3xx.h"
+
+
+/* ----- global defines ----------------------------------------------- */
+#define PASSERT(x) do { if (!(x) ) \
+		printk(KERN_CRIT "PASSERT %s in %s:%d\n", #x, __FILE__, __LINE__ );\
+	} while (0)
+
+
+/* ----- global variables ---------------------------------------------	*/
+
+
+static inline unsigned char iic_cook_addr(struct i2c_msg *msg) 
+{
+	unsigned char addr;
+
+	addr = (msg->addr << 1);
+
+	if (msg->flags & I2C_M_RD)
+		addr |= 1;
+
+	/* PGM: what is M_REV_DIR_ADDR - do we need it ?? */
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		addr ^= 1;
+
+	return addr;   
+}
+
+
+static inline void iop3xx_adap_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	/* Follows devman 9.3 */
+	*iop3xx_adap->biu->CR = IOP321_ICR_UNIT_RESET;
+	*iop3xx_adap->biu->SR = IOP321_ISR_CLEARBITS;
+	*iop3xx_adap->biu->CR = 0;
+} 
+
+static inline void iop3xx_adap_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	*iop3xx_adap->biu->SAR = MYSAR;
+}
+
+static inline void iop3xx_adap_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	u32 cr = IOP321_ICR_GCD|IOP321_ICR_SCLEN|IOP321_ICR_UE;
+
+	/* NB SR bits not same position as CR IE bits :-( */
+	iop3xx_adap->biu->SR_enabled = 
+		IOP321_ISR_ALD | IOP321_ISR_BERRD |
+		IOP321_ISR_RXFULL | IOP321_ISR_TXEMPTY;
+
+	cr |= IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
+		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE;
+
+	*iop3xx_adap->biu->CR = cr;
+}
+
+static void iop3xx_adap_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	unsigned cr = *iop3xx_adap->biu->CR;
+	
+	cr &= ~(IOP321_ICR_MSTART | IOP321_ICR_TBYTE | 
+		IOP321_ICR_MSTOP | IOP321_ICR_SCLEN);
+	*iop3xx_adap->biu->CR = cr;
+}
+
+static void iop3xx_adap_final_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	unsigned cr = *iop3xx_adap->biu->CR;
+	
+	cr &= ~(IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
+		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE);
+	iop3xx_adap->biu->SR_enabled = 0;
+	*iop3xx_adap->biu->CR = cr;
+}
+
+/* 
+ * NB: the handler has to clear the source of the interrupt! 
+ * Then it passes the SR flags of interest to BH via adap data
+ */
+static void iop3xx_i2c_handler(int this_irq, 
+				void *dev_id, 
+				struct pt_regs *regs) 
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = dev_id;
+
+	u32 sr = *iop3xx_adap->biu->SR;
+
+	if ((sr &= iop3xx_adap->biu->SR_enabled)) {
+		*iop3xx_adap->biu->SR = sr;
+		iop3xx_adap->biu->SR_received |= sr;
+		wake_up_interruptible(&iop3xx_adap->waitq);
+	}
+}
+
+/* check all error conditions, clear them , report most important */
+static int iop3xx_adap_error(u32 sr)
+{
+	int rc = 0;
+
+	if ((sr&IOP321_ISR_BERRD)) {
+		if ( !rc ) rc = -I2C_ERR_BERR;
+	}
+	if ((sr&IOP321_ISR_ALD)) {
+		if ( !rc ) rc = -I2C_ERR_ALD;		
+	}
+	return rc;	
+}
+
+static inline u32 get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	unsigned long flags;
+	u32 sr;
+
+	spin_lock_irqsave(&iop3xx_adap->lock, flags);
+	sr = iop3xx_adap->biu->SR_received;
+	iop3xx_adap->biu->SR_received = 0;
+	spin_unlock_irqrestore(&iop3xx_adap->lock, flags);
+
+	return sr;
+}
+
+/*
+ * sleep until interrupted, then recover and analyse the SR
+ * saved by handler
+ */
+typedef int (* compare_func)(unsigned test, unsigned mask);
+/* returns 1 on correct comparison */
+
+static int iop3xx_adap_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap, 
+				  unsigned flags, unsigned* status,
+				  compare_func compare)
+{
+	unsigned sr = 0;
+	int interrupted;
+	int done;
+	int rc;
+
+	do {
+		interrupted = wait_event_interruptible_timeout (
+			iop3xx_adap->waitq,
+			(done = compare( sr = get_srstat(iop3xx_adap),flags )),
+			iop3xx_adap->timeout
+			);
+		if ((rc = iop3xx_adap_error(sr)) < 0) {
+			*status = sr;
+			return rc;
+		}else if (!interrupted) {
+			*status = sr;
+			return rc = -ETIMEDOUT;
+		}
+	} while(!done);
+
+	*status = sr;
+
+	return rc = 0;
+}
+
+/*
+ * Concrete compare_funcs 
+ */
+static int all_bits_clear(unsigned test, unsigned mask)
+{
+	return (test & mask) = 0;
+}
+static int any_bits_set(unsigned test, unsigned mask)
+{
+	return (test & mask) != 0;
+}
+
+static int iop3xx_adap_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
+{
+	return iop3xx_adap_wait_event( 
+		iop3xx_adap, 
+	        IOP321_ISR_TXEMPTY|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+		status, any_bits_set);
+}
+
+static int iop3xx_adap_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
+{
+	return iop3xx_adap_wait_event( 
+		iop3xx_adap, 
+		IOP321_ISR_RXFULL|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+		status,	any_bits_set);
+}
+
+static int iop3xx_adap_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
+{
+	return iop3xx_adap_wait_event( 
+		iop3xx_adap, IOP321_ISR_UNITBUSY, status, all_bits_clear);
+}
+
+/*
+ * Description: This performs the IOP3xx initialization sequence
+ * Valid for IOP321. Maybe valid for IOP310?.
+ */
+static int iop3xx_adap_init (struct i2c_algo_iop3xx_data *iop3xx_adap)
+{
+	*IOP321_GPOD &= ~(iop3xx_adap->channel=0 ?
+			  IOP321_GPOD_I2C0:
+			  IOP321_GPOD_I2C1);
+
+	iop3xx_adap_reset(iop3xx_adap);
+	iop3xx_adap_set_slave_addr(iop3xx_adap);
+	iop3xx_adap_enable(iop3xx_adap);
+	
+        return 0;
+}
+
+static int iop3xx_adap_send_target_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
+					      struct i2c_msg* msg)
+{
+	unsigned cr = *iop3xx_adap->biu->CR;
+	int status;
+	int rc;
+
+	*iop3xx_adap->biu->DBR = iic_cook_addr(msg);
+	
+	cr &= ~(IOP321_ICR_MSTOP | IOP321_ICR_NACK);
+	cr |= IOP321_ICR_MSTART | IOP321_ICR_TBYTE;
+
+	*iop3xx_adap->biu->CR = cr;
+	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
+	/* this assert fires every time, contrary to IOP manual	
+	PASSERT((status&IOP321_ISR_UNITBUSY)!=0);
+	*/
+	PASSERT((status&IOP321_ISR_RXREAD)=0);
+	     
+	return rc;
+}
+
+static int iop3xx_adap_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, int stop)
+{
+	unsigned cr = *iop3xx_adap->biu->CR;
+	int status;
+	int rc;
+
+	*iop3xx_adap->biu->DBR = byte;
+	cr &= ~IOP321_ICR_MSTART;
+	if (stop) {
+		cr |= IOP321_ICR_MSTOP;
+	} else {
+		cr &= ~IOP321_ICR_MSTOP;
+	}
+	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
+	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
+
+	return rc;
+} 
+
+static int iop3xx_adap_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap,
+				 char* byte, int stop)
+{
+	unsigned cr = *iop3xx_adap->biu->CR;
+	int status;
+	int rc;
+
+	cr &= ~IOP321_ICR_MSTART;
+
+	if (stop) {
+		cr |= IOP321_ICR_MSTOP|IOP321_ICR_NACK;
+	} else {
+		cr &= ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
+	}
+	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
+
+	rc = iop3xx_adap_wait_rx_done(iop3xx_adap, &status);
+
+	*byte = *iop3xx_adap->biu->DBR;
+
+	return rc;
+}
+
+static int iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, 
+				 const char *buf, int count)
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
+	int ii;
+	int rc = 0;
+
+	for (ii = 0; rc = 0 && ii != count; ++ii) {
+		rc = iop3xx_adap_write_byte(iop3xx_adap, buf[ii], ii=count-1);
+	}
+	return rc;
+}
+
+static int iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, 
+				char *buf, int count)
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
+	int ii;
+	int rc = 0;
+
+	for (ii = 0; rc = 0 && ii != count; ++ii) {
+		rc = iop3xx_adap_read_byte(iop3xx_adap, &buf[ii], ii=count-1);
+	}
+	return rc;
+}
+
+/*
+ * Description:  This function implements combined transactions.  Combined
+ * transactions consist of combinations of reading and writing blocks of data.
+ * FROM THE SAME ADDRESS
+ * Each transfer (i.e. a read or a write) is separated by a repeated start
+ * condition.
+ */
+static int iop3xx_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) 
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
+	int rc;
+
+	rc = iop3xx_adap_send_target_slave_addr(iop3xx_adap, pmsg);
+	if (rc < 0) {
+		return rc;
+	}
+
+	if ((pmsg->flags&I2C_M_RD)) {
+		return iop3xx_i2c_readbytes(i2c_adap, pmsg->buf, pmsg->len);
+	} else {
+		return iop3xx_i2c_writebytes(i2c_adap, pmsg->buf, pmsg->len);
+	}
+}
+
+/*
+ * master_xfer() - main read/write entry
+ */
+static int iop3xx_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
+	int im = 0;
+	int ret = 0;
+	int status;
+
+	iop3xx_adap_wait_idle(iop3xx_adap, &status);
+	iop3xx_adap_reset(iop3xx_adap);
+	iop3xx_adap_enable(iop3xx_adap);
+
+	for (im = 0; ret = 0 && im != num; ++im) {
+		ret = iop3xx_handle_msg(i2c_adap, &msgs[im]);
+	}
+
+	iop3xx_adap_transaction_cleanup(iop3xx_adap);
+
+	return ret;   
+}
+
+static int algo_control(struct i2c_adapter *adapter, unsigned int cmd,
+			unsigned long arg)
+{
+	return 0;
+}
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+
+/* -----exported algorithm data: -------------------------------------	*/
+
+static struct i2c_algorithm iic_algo = {
+	.name		= "IOP3xx I2C algorithm",
+	.id		= I2C_ALGO_OCP_IOP3XX,
+	.master_xfer	= iop3xx_master_xfer,
+	.algo_control	= algo_control,
+	.functionality	= iic_func,
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+static int i2c_iop3xx_add_bus(struct i2c_adapter *iic_adap)
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
+
+	if (!request_region( REGION_START(iop3xx_adap), 
+			      REGION_LENGTH(iop3xx_adap),
+			      iic_adap->name)) {
+		return -ENODEV;
+	}
+
+	init_waitqueue_head(&iop3xx_adap->waitq);
+	spin_lock_init(&iop3xx_adap->lock);
+
+	if (request_irq( 
+		     iop3xx_adap->biu->irq,
+		     iop3xx_i2c_handler,
+		     /* SA_SAMPLE_RANDOM */ 0,
+		     iic_adap->name,
+		     iop3xx_adap)) {
+		return -ENODEV;
+	}			  
+
+	/* register new iic_adapter to i2c module... */
+	iic_adap->id |= iic_algo.id;
+	iic_adap->algo = &iic_algo;
+
+	iic_adap->timeout = 100;	/* default values, should */
+	iic_adap->retries = 3;		/* be replaced by defines */
+
+	iop3xx_adap_init(iic_adap->algo_data);
+	i2c_add_adapter(iic_adap);
+	return 0;
+}
+
+static int i2c_iop3xx_del_bus(struct i2c_adapter *iic_adap)
+{
+	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
+
+	iop3xx_adap_final_cleanup(iop3xx_adap);
+	free_irq(iop3xx_adap->biu->irq, iop3xx_adap);
+
+	release_region(REGION_START(iop3xx_adap), REGION_LENGTH(iop3xx_adap));
+
+	return i2c_del_adapter(iic_adap);
+}
+
+#ifdef CONFIG_ARCH_IOP321
+
+static struct iop3xx_biu biu0 = {
+	.CR	= IOP321_ICR0,
+	.SR	= IOP321_ISR0,
+	.SAR	= IOP321_ISAR0,
+	.DBR	= IOP321_IDBR0,
+	.BMR	= IOP321_IBMR0,
+	.irq	= IRQ_IOP321_I2C_0,
+};
+
+static struct iop3xx_biu biu1 = {
+	.CR	= IOP321_ICR1,
+	.SR	= IOP321_ISR1,
+	.SAR	= IOP321_ISAR1,
+	.DBR	= IOP321_IDBR1,
+	.BMR	= IOP321_IBMR1,
+	.irq	= IRQ_IOP321_I2C_1,
+};
+
+#define ADAPTER_NAME_ROOT "IOP321 i2c biu adapter "
+#else
+#error Please define the BIU struct iop3xx_biu for your processor arch
+#endif
+
+static struct i2c_algo_iop3xx_data algo_iop3xx_data0 = {
+	.channel		= 0,
+	.biu			= &biu0,
+	.timeout		= 1*HZ,
+};
+static struct i2c_algo_iop3xx_data algo_iop3xx_data1 = {
+	.channel		= 1,
+	.biu			= &biu1,
+	.timeout		= 1*HZ,
+};
+
+static struct i2c_adapter iop3xx_ops0 = {
+	.owner			= THIS_MODULE,
+	.name			= ADAPTER_NAME_ROOT "0",
+	.id			= I2C_HW_IOP321,
+	.algo_data		= &algo_iop3xx_data0,
+};
+static struct i2c_adapter iop3xx_ops1 = {
+	.owner			= THIS_MODULE,
+	.name			= ADAPTER_NAME_ROOT "1",
+	.id			= I2C_HW_IOP321,
+	.algo_data		= &algo_iop3xx_data1,
+};
+
+static int __init i2c_iop3xx_init (void)
+{
+	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
+		i2c_iop3xx_add_bus(&iop3xx_ops1);
+}
+
+static void __exit i2c_iop3xx_exit (void)
+{
+	i2c_iop3xx_del_bus(&iop3xx_ops0);
+	i2c_iop3xx_del_bus(&iop3xx_ops1);
+}
+
+module_init (i2c_iop3xx_init);
+module_exit (i2c_iop3xx_exit);
+
+MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
+MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(i2c_debug,"i");
+
+MODULE_PARM_DESC(i2c_debug, "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
+
diff -Nru a/drivers/i2c/busses/i2c-iop3xx.h b/drivers/i2c/busses/i2c-iop3xx.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-iop3xx.h	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,118 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-iop3xx.h algorithm driver definitions private to i2c-iop3xx.c         */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
+ *                      <Peter dot Milne at D hyphen TACQ dot com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation, version 2.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
+/* ------------------------------------------------------------------------- */
+
+
+#ifndef I2C_IOP3XX_H
+#define I2C_IOP3XX_H 1
+
+/*
+ * iop321 hardware bit definitions
+ */
+#define IOP321_ICR_FAST_MODE	0x8000	/* 1@0kBps, 00kBps */
+#define IOP321_ICR_UNIT_RESET	0x4000	/* 1=RESET */
+#define IOP321_ICR_SADIE	0x2000	/* 1=Slave Detect Interrupt Enable */
+#define IOP321_ICR_ALDIE	0x1000	/* 1=Arb Loss Detect Interrupt Enable */
+#define IOP321_ICR_SSDIE	0x0800	/* 1=Slave STOP Detect Interrupt Enable */
+#define IOP321_ICR_BERRIE	0x0400	/* 1=Bus Error Interrupt Enable */
+#define IOP321_ICR_RXFULLIE	0x0200	/* 1=Receive Full Interrupt Enable */
+#define IOP321_ICR_TXEMPTYIE	0x0100	/* 1=Transmit Empty Interrupt Enable */
+#define IOP321_ICR_GCD		0x0080	/* 1=General Call Disable */
+/*
+ * IOP321_ICR_GCD: 1 disables response as slave. "This bit must be set
+ * when sending a master mode general call message from the I2C unit"
+ */
+#define IOP321_ICR_UE		0x0040	/* 1=Unit Enable */
+/*
+ * "NOTE: To avoid I2C bus integrity problems, 
+ * the user needs to ensure that the GPIO Output Data Register - 
+ * GPOD bits associated with an I2C port are cleared prior to setting 
+ * the enable bit for that I2C serial port. 
+ * The user prepares to enable I2C port 0 and 
+ * I2C port 1 by clearing GPOD bits 7:6 and GPOD bits 5:4, respectively.
+ */
+#define IOP321_ICR_SCLEN	0x0020	/* 1=SCL enable for master mode */
+#define IOP321_ICR_MABORT	0x0010	/* 1=Send a STOP with no data 
+					 * NB TBYTE must be clear */
+#define IOP321_ICR_TBYTE	0x0008	/* 1=Send/Receive a byte. i2c clears */
+#define IOP321_ICR_NACK		0x0004	/* 1=reply with NACK */
+#define IOP321_ICR_MSTOP	0x0002	/* 1=send a STOP after next data byte */
+#define IOP321_ICR_MSTART	0x0001	/* 1=initiate a START */
+
+
+#define IOP321_ISR_BERRD	0x0400	/* 1=BUS ERROR Detected */
+#define IOP321_ISR_SAD		0x0200	/* 1=Slave ADdress Detected */
+#define IOP321_ISR_GCAD		0x0100	/* 1=General Call Address Detected */
+#define IOP321_ISR_RXFULL	0x0080	/* 1=Receive Full */
+#define IOP321_ISR_TXEMPTY	0x0040	/* 1=Transmit Empty */
+#define IOP321_ISR_ALD		0x0020	/* 1=Arbitration Loss Detected */
+#define IOP321_ISR_SSD		0x0010	/* 1=Slave STOP Detected */
+#define IOP321_ISR_BBUSY	0x0008	/* 1=Bus BUSY */
+#define IOP321_ISR_UNITBUSY	0x0004	/* 1=Unit Busy */
+#define IOP321_ISR_NACK		0x0002	/* 1=Unit Rx or Tx a NACK */
+#define IOP321_ISR_RXREAD	0x0001	/* 1=READ 0=WRITE (R/W bit of slave addr */
+
+#define IOP321_ISR_CLEARBITS	0x07f0
+
+#define IOP321_ISAR_SAMASK	0x007f
+
+#define IOP321_IDBR_MASK	0x00ff
+
+#define IOP321_IBMR_SCL		0x0002
+#define IOP321_IBMR_SDA		0x0001
+
+#define IOP321_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
+#define IOP321_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
+
+#define MYSAR			0x02	/* SWAG a suitable slave address */
+
+#define I2C_ERR			321
+#define I2C_ERR_BERR		(I2C_ERR+0)
+#define I2C_ERR_ALD		(I2C_ERR+1)
+
+
+struct iop3xx_biu {                /* Bus Interface Unit - the hardware */
+/* physical hardware defs - regs*/
+	u32 *CR;
+	u32 *SR;
+	u32 *SAR;
+	u32 *DBR;
+	u32 *BMR;
+/* irq bit vector */
+	u32 irq;
+/* stored flags */
+	u32 SR_enabled, SR_received;
+};
+
+struct i2c_algo_iop3xx_data {
+	int channel;
+
+	wait_queue_head_t waitq;
+	spinlock_t lock;
+	int timeout;
+	struct iop3xx_biu* biu;
+};
+
+#define REGION_START(adap)	((u32)((adap)->biu->CR))
+#define REGION_END(adap)	((u32)((adap)->biu->BMR+1))
+#define REGION_LENGTH(adap)	(REGION_END(adap)-REGION_START(adap))
+
+#define IRQ_STATUS_MASK(adap)	(1<<adap->biu->irq)
+
+#endif /* I2C_IOP3XX_H */
diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ite.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,278 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-adap-ite.c i2c-hw access for the IIC peripheral on the ITE MIPS system
+   -------------------------------------------------------------------------
+   Hai-Pao Fan, MontaVista Software, Inc.
+   hpfan@mvista.com or source@mvista.com
+
+   Copyright 2001 MontaVista Software Inc.
+
+   ----------------------------------------------------------------------------
+   This file was highly leveraged from i2c-elektor.c, which was created
+   by Simon G. Vogl and Hans Berglund:
+
+ 
+     Copyright (C) 1995-97 Simon G. Vogl
+                   1998-99 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl> */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-ite.h>
+#include <linux/i2c-adap-ite.h>
+#include "../i2c-ite.h"
+
+#define DEFAULT_BASE  0x14014030
+#define ITE_IIC_IO_SIZE	0x40
+#define DEFAULT_IRQ   0
+#define DEFAULT_CLOCK 0x1b0e	/* default 16MHz/(27+14) = 400KHz */
+#define DEFAULT_OWN   0x55
+
+static int base  = 0;
+static int irq   = 0;
+static int clock = 0;
+static int own   = 0;
+
+static int i2c_debug=0;
+static struct iic_ite gpi;
+static wait_queue_head_t iic_wait;
+static int iic_pending;
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)	if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x
+#define DEBE(x)	x	/* error messages 				*/
+
+
+/* ----- local functions ----------------------------------------------	*/
+
+static void iic_ite_setiic(void *data, int ctl, short val)
+{
+        unsigned long j = jiffies + 10;
+
+	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
+	DEB3({while (time_before(jiffies, j)) schedule();})
+	outw(val,ctl);
+}
+
+static short iic_ite_getiic(void *data, int ctl)
+{
+	short val;
+
+	val = inw(ctl);
+	DEB3(printk("Read 0x%02x from 0x%x\n",(unsigned short)val, ctl&0xff));  
+	return (val);
+}
+
+/* Return our slave address.  This is the address
+ * put on the I2C bus when another master on the bus wants to address us
+ * as a slave
+ */
+static int iic_ite_getown(void *data)
+{
+	return (gpi.iic_own);
+}
+
+
+static int iic_ite_getclock(void *data)
+{
+	return (gpi.iic_clock);
+}
+
+
+#if 0
+static void iic_ite_sleep(unsigned long timeout)
+{
+	schedule_timeout( timeout * HZ);
+}
+#endif
+
+
+/* Put this process to sleep.  We will wake up when the
+ * IIC controller interrupts.
+ */
+static void iic_ite_waitforpin(void) {
+
+   int timeout = 2;
+
+   /* If interrupts are enabled (which they are), then put the process to
+    * sleep.  This process will be awakened by two events -- either the
+    * the IIC peripheral interrupts or the timeout expires. 
+    * If interrupts are not enabled then delay for a reasonable amount 
+    * of time and return.
+    */
+   if (gpi.iic_irq > 0) {
+	cli();
+	if (iic_pending = 0) {
+		interruptible_sleep_on_timeout(&iic_wait, timeout*HZ );
+	} else
+		iic_pending = 0;
+	sti();
+   } else {
+      udelay(100);
+   }
+}
+
+
+static void iic_ite_handler(int this_irq, void *dev_id, struct pt_regs *regs) 
+{
+	
+   iic_pending = 1;
+
+   DEB2(printk("iic_ite_handler: in interrupt handler\n"));
+   wake_up_interruptible(&iic_wait);
+}
+
+
+/* Lock the region of memory where I/O registers exist.  Request our
+ * interrupt line and register its associated handler.
+ */
+static int iic_hw_resrc_init(void)
+{
+	if (!request_region(gpi.iic_base, ITE_IIC_IO_SIZE, "i2c"))
+		return -ENODEV;
+  
+	if (gpi.iic_irq <= 0)
+		return 0;
+
+	if (request_irq(gpi.iic_irq, iic_ite_handler, 0, "ITE IIC", 0) < 0)
+		gpi.iic_irq = 0;
+	else
+		enable_irq(gpi.iic_irq);
+
+	return 0;
+}
+
+
+static void iic_ite_release(void)
+{
+	if (gpi.iic_irq > 0) {
+		disable_irq(gpi.iic_irq);
+		free_irq(gpi.iic_irq, 0);
+	}
+	release_region(gpi.iic_base , 2);
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+static struct i2c_algo_iic_data iic_ite_data = {
+	NULL,
+	iic_ite_setiic,
+	iic_ite_getiic,
+	iic_ite_getown,
+	iic_ite_getclock,
+	iic_ite_waitforpin,
+	80, 80, 100,		/*	waits, timeout */
+};
+
+static struct i2c_adapter iic_ite_ops = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_HW_I_IIC,
+	.algo_data	= &iic_ite_data,
+	.dev		= {
+		.name	= "ITE IIC adapter",
+	},
+};
+
+/* Called when the module is loaded.  This function starts the
+ * cascade of calls up through the hierarchy of i2c modules (i.e. up to the
+ *  algorithm layer and into to the core layer)
+ */
+static int __init iic_ite_init(void) 
+{
+
+	struct iic_ite *piic = &gpi;
+
+	printk(KERN_INFO "Initialize ITE IIC adapter module\n");
+	if (base = 0)
+		piic->iic_base = DEFAULT_BASE;
+	else
+		piic->iic_base = base;
+
+	if (irq = 0)
+		piic->iic_irq = DEFAULT_IRQ;
+	else
+		piic->iic_irq = irq;
+
+	if (clock = 0)
+		piic->iic_clock = DEFAULT_CLOCK;
+	else
+		piic->iic_clock = clock;
+
+	if (own = 0)
+		piic->iic_own = DEFAULT_OWN;
+	else
+		piic->iic_own = own;
+
+	iic_ite_data.data = (void *)piic;
+	init_waitqueue_head(&iic_wait);
+	if (iic_hw_resrc_init() = 0) {
+		if (i2c_iic_add_bus(&iic_ite_ops) < 0)
+			return -ENODEV;
+	} else {
+		return -ENODEV;
+	}
+	printk(KERN_INFO " found device at %#x irq %d.\n", 
+		piic->iic_base, piic->iic_irq);
+	return 0;
+}
+
+
+static void iic_ite_exit(void)
+{
+	i2c_iic_del_bus(&iic_ite_ops);
+        iic_ite_release();
+}
+
+/* If modules is NOT defined when this file is compiled, then the MODULE_*
+ * macros will resolve to nothing
+ */
+MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for ITE IIC bus adapter");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(base, "i");
+MODULE_PARM(irq, "i");
+MODULE_PARM(clock, "i");
+MODULE_PARM(own, "i");
+MODULE_PARM(i2c_debug,"i");
+
+
+/* Called when module is loaded or when kernel is initialized.
+ * If MODULES is defined when this file is compiled, then this function will
+ * resolve to init_module (the function called when insmod is invoked for a
+ * module).  Otherwise, this function is called early in the boot, when the
+ * kernel is intialized.  Check out /include/init.h to see how this works.
+ */
+module_init(iic_ite_init);
+
+/* Resolves to module_cleanup when MODULES is defined. */
+module_exit(iic_ite_exit); 
diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-keywest.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,653 @@
+/*
+    i2c Support for Apple Keywest I2C Bus Controller
+
+    Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+
+    Original work by
+    
+    Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    Changes:
+
+    2001/12/13 BenH	New implementation
+    2001/12/15 BenH	Add support for "byte" and "quick"
+                        transfers. Add i2c_xfer routine.
+
+    My understanding of the various modes supported by keywest are:
+
+     - Dumb mode : not implemented, probably direct tweaking of lines
+     - Standard mode : simple i2c transaction of type
+         S Addr R/W A Data A Data ... T
+     - Standard sub mode : combined 8 bit subaddr write with data read
+         S Addr R/W A SubAddr A Data A Data ... T
+     - Combined mode : Subaddress and Data sequences appended with no stop
+         S Addr R/W A SubAddr S Addr R/W A Data A Data ... T
+
+    Currently, this driver uses only Standard mode for i2c xfer, and
+    smbus byte & quick transfers ; and uses StandardSub mode for
+    other smbus transfers instead of combined as we need that for the
+    sound driver to be happy
+*/
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+
+#include "i2c-keywest.h"
+
+#define DBG(x...) do {\
+	if (debug > 0) \
+		printk(KERN_DEBUG "KW:" x); \
+	} while(0)
+
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
+MODULE_LICENSE("GPL");
+MODULE_PARM(probe, "i");
+MODULE_PARM(debug, "i");
+
+int probe = 0;
+int debug = 0;
+
+static void
+do_stop(struct keywest_iface* iface, int result)
+{
+	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_STOP);
+	iface->state = state_stop;
+	iface->result = result;
+}
+
+/* Main state machine for standard & standard sub mode */
+static int
+handle_interrupt(struct keywest_iface *iface, u8 isr)
+{
+	int ack;
+	int rearm_timer = 1;
+	
+	DBG("handle_interrupt(), got: %x, status: %x, state: %d\n",
+		isr, read_reg(reg_status), iface->state);
+	if (isr = 0 && iface->state != state_stop) {
+		do_stop(iface, -1);
+		return rearm_timer;
+	}
+	if (isr & KW_I2C_IRQ_STOP && iface->state != state_stop) {
+		iface->result = -1;
+		iface->state = state_stop;
+	}
+	switch(iface->state) {
+	case state_addr:
+		if (!(isr & KW_I2C_IRQ_ADDR)) {
+			do_stop(iface, -1);
+			break;
+		}
+		ack = read_reg(reg_status);
+		DBG("ack on set address: %x\n", ack);
+		if ((ack & KW_I2C_STAT_LAST_AAK) = 0) {
+			do_stop(iface, -1);
+			break;
+		}
+		/* Handle rw "quick" mode */
+		if (iface->datalen = 0)
+			do_stop(iface, 0);
+		else if (iface->read_write = I2C_SMBUS_READ) {
+			iface->state = state_read;
+			if (iface->datalen > 1)
+				write_reg(reg_control, read_reg(reg_control)
+					| KW_I2C_CTL_AAK);
+		} else {
+			iface->state = state_write;
+			DBG("write byte: %x\n", *(iface->data));
+			write_reg(reg_data, *(iface->data++));
+			iface->datalen--;
+		}
+		
+		break;
+	case state_read:
+		if (!(isr & KW_I2C_IRQ_DATA)) {
+			do_stop(iface, -1);
+			break;
+		}
+		*(iface->data++) = read_reg(reg_data);
+		DBG("read byte: %x\n", *(iface->data-1));
+		iface->datalen--;
+		if (iface->datalen = 0)
+			iface->state = state_stop;
+		else
+			write_reg(reg_control, 0);
+		break;
+	case state_write:
+		if (!(isr & KW_I2C_IRQ_DATA)) {
+			do_stop(iface, -1);
+			break;
+		}
+		/* Check ack status */
+		ack = read_reg(reg_status);
+		DBG("ack on data write: %x\n", ack);
+		if ((ack & KW_I2C_STAT_LAST_AAK) = 0) {
+			do_stop(iface, -1);
+			break;
+		}
+		if (iface->datalen) {
+			DBG("write byte: %x\n", *(iface->data));
+			write_reg(reg_data, *(iface->data++));
+			iface->datalen--;
+		} else
+			do_stop(iface, 0);
+		break;
+		
+	case state_stop:
+		if (!(isr & KW_I2C_IRQ_STOP) && (++iface->stopretry) < 10)
+			do_stop(iface, -1);
+		else {
+			rearm_timer = 0;
+			iface->state = state_idle;
+			write_reg(reg_control, 0x00);
+			write_reg(reg_ier, 0x00);
+			complete(&iface->complete);
+		}
+		break;
+	}
+	
+	write_reg(reg_isr, isr);
+
+	return rearm_timer;
+}
+
+/* Interrupt handler */
+static irqreturn_t
+keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
+
+	spin_lock(&iface->lock);
+	del_timer(&iface->timeout_timer);
+	if (handle_interrupt(iface, read_reg(reg_isr)))
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
+	spin_unlock(&iface->lock);
+	return IRQ_HANDLED;
+}
+
+static void
+keywest_timeout(unsigned long data)
+{
+	struct keywest_iface *iface = (struct keywest_iface *)data;
+
+	DBG("timeout !\n");
+	spin_lock_irq(&iface->lock);
+	if (handle_interrupt(iface, read_reg(reg_isr)))
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
+	spin_unlock(&iface->lock);
+}
+
+/*
+ * SMBUS-type transfer entrypoint
+ */
+static s32
+keywest_smbus_xfer(	struct i2c_adapter*	adap,
+			u16			addr,
+			unsigned short		flags,
+			char			read_write,
+			u8			command,
+			int			size,
+			union i2c_smbus_data*	data)
+{
+	struct keywest_chan* chan = i2c_get_adapdata(adap);
+	struct keywest_iface* iface = chan->iface;
+	int len;
+	u8* buffer;
+	u16 cur_word;
+	int rc = 0;
+
+	if (iface->state = state_dead)
+		return -1;
+		
+	/* Prepare datas & select mode */
+	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
+	switch (size) {
+	    case I2C_SMBUS_QUICK:
+	    	len = 0;
+	    	buffer = NULL;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+	    	break;
+	    case I2C_SMBUS_BYTE:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+	    	break;
+	    case I2C_SMBUS_BYTE_DATA:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	    	break;
+	    case I2C_SMBUS_WORD_DATA:
+	    	len = 2;
+	    	cur_word = cpu_to_le16(data->word);
+	    	buffer = (u8 *)&cur_word;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+		break;
+	    case I2C_SMBUS_BLOCK_DATA:
+	    	len = data->block[0];
+	    	buffer = &data->block[1];
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+		break;
+	    default:
+	    	return -1;
+	}
+
+	/* Original driver had this limitation */
+	if (len > 32)
+		len = 32;
+
+	down(&iface->sem);
+
+	DBG("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
+		chan->chan_no, addr, len, read_write = I2C_SMBUS_READ);
+
+	iface->data = buffer;
+	iface->datalen = len;
+	iface->state = state_addr;
+	iface->result = 0;
+	iface->stopretry = 0;
+	iface->read_write = read_write;
+	
+	/* Setup channel & clear pending irqs */
+	write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
+	write_reg(reg_isr, read_reg(reg_isr));
+	write_reg(reg_status, 0);
+
+	/* Set up address and r/w bit */
+	write_reg(reg_addr,
+		(addr << 1) | ((read_write = I2C_SMBUS_READ) ? 0x01 : 0x00));
+
+	/* Set up the sub address */
+	if ((iface->cur_mode & KW_I2C_MODE_MODE_MASK) = KW_I2C_MODE_STANDARDSUB
+	    || (iface->cur_mode & KW_I2C_MODE_MODE_MASK) = KW_I2C_MODE_COMBINED)
+		write_reg(reg_subaddr, command);
+
+	/* Arm timeout */
+	mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
+
+	/* Start sending address & enable interrupt*/
+	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
+	write_reg(reg_ier, KW_I2C_IRQ_MASK);
+
+	/* Wait interrupt operations completion */
+	wait_for_completion(&iface->complete);	
+
+	rc = iface->result;	
+	DBG("transfer done, result: %d\n", rc);
+
+	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && read_write = I2C_SMBUS_READ)
+	    	data->word = le16_to_cpu(cur_word);
+	
+	/* Release sem */
+	up(&iface->sem);
+	
+	return rc;
+}
+
+/*
+ * Generic i2c master transfer entrypoint
+ */
+static int
+keywest_xfer(	struct i2c_adapter *adap,
+		struct i2c_msg msgs[], 
+		int num)
+{
+	struct keywest_chan* chan = i2c_get_adapdata(adap);
+	struct keywest_iface* iface = chan->iface;
+	struct i2c_msg *pmsg;
+	int i, completed;
+	int rc = 0;
+
+	down(&iface->sem);
+
+	/* Set adapter to standard mode */
+	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
+	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+
+	completed = 0;
+	for (i = 0; rc >= 0 && i < num;) {
+		u8 addr;
+		
+		pmsg = &msgs[i++];
+		addr = pmsg->addr;
+		if (pmsg->flags & I2C_M_TEN) {
+			printk(KERN_ERR "i2c-keywest: 10 bits addr not supported !\n");
+			rc = -EINVAL;
+			break;
+		}
+		DBG("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		     chan->chan_no,
+		     pmsg->flags & I2C_M_RD ? "read" : "write",
+                     pmsg->len, addr, i, num);
+    
+		/* Setup channel & clear pending irqs */
+		write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
+		write_reg(reg_isr, read_reg(reg_isr));
+		write_reg(reg_status, 0);
+		
+		iface->data = pmsg->buf;
+		iface->datalen = pmsg->len;
+		iface->state = state_addr;
+		iface->result = 0;
+		iface->stopretry = 0;
+		if (pmsg->flags & I2C_M_RD)
+			iface->read_write = I2C_SMBUS_READ;
+		else
+			iface->read_write = I2C_SMBUS_WRITE;
+
+		/* Set up address and r/w bit */
+		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
+			addr ^= 1;		
+		write_reg(reg_addr,
+			(addr << 1) |
+			((iface->read_write = I2C_SMBUS_READ) ? 0x01 : 0x00));
+
+		/* Arm timeout */
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
+
+		/* Start sending address & enable interrupt*/
+		write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
+		write_reg(reg_ier, KW_I2C_IRQ_MASK);
+
+		/* Wait interrupt operations completion */
+		wait_for_completion(&iface->complete);	
+
+		rc = iface->result;
+		if (rc = 0)
+			completed++;
+		DBG("transfer done, result: %d\n", rc);
+	}
+
+	/* Release sem */
+	up(&iface->sem);
+
+	return completed;
+}
+
+static u32
+keywest_func(struct i2c_adapter * adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm keywest_algorithm = {
+	.name		= "Keywest i2c",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= keywest_smbus_xfer,
+	.master_xfer	= keywest_xfer,
+	.functionality	= keywest_func,
+};
+
+
+static int
+create_iface(struct device_node *np, struct device *dev)
+{
+	unsigned long steps, *psteps, *prate;
+	unsigned bsteps, tsize, i, nchan, addroffset;
+	struct keywest_iface* iface;
+	int rc;
+
+	psteps = (unsigned long *)get_property(np, "AAPL,address-step", NULL);
+	steps = psteps ? (*psteps) : 0x10;
+
+	/* Hrm... maybe we can be smarter here */
+	for (bsteps = 0; (steps & 0x01) = 0; bsteps++)
+		steps >>= 1;
+
+	if (!strcmp(np->parent->name, "uni-n")) {
+		nchan = 2;
+		addroffset = 3;
+	} else {
+		addroffset = 0;
+		nchan = 1;
+	}
+
+	tsize = sizeof(struct keywest_iface) +
+		(sizeof(struct keywest_chan) + 4) * nchan;
+	iface = (struct keywest_iface *) kmalloc(tsize, GFP_KERNEL);
+	if (iface = NULL) {
+		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
+		return -ENOMEM;
+	}
+	memset(iface, 0, tsize);
+	init_MUTEX(&iface->sem);
+	spin_lock_init(&iface->lock);
+	init_completion(&iface->complete);
+	iface->bsteps = bsteps;
+	iface->chan_count = nchan;
+	iface->state = state_idle;
+	iface->irq = np->intrs[0].line;
+	iface->channels = (struct keywest_chan *)
+		(((unsigned long)(iface + 1) + 3UL) & ~3UL);
+	iface->base = (unsigned long)ioremap(np->addrs[0].address + addroffset,
+						np->addrs[0].size);
+	if (iface->base = 0) {
+		printk(KERN_ERR "i2c-keywest: can't map inteface !\n");
+		kfree(iface);
+		return -ENOMEM;
+	}
+
+	init_timer(&iface->timeout_timer);
+	iface->timeout_timer.function = keywest_timeout;
+	iface->timeout_timer.data = (unsigned long)iface;
+
+	/* Select interface rate */
+	iface->cur_mode = KW_I2C_MODE_100KHZ;
+	prate = (unsigned long *)get_property(np, "AAPL,i2c-rate", NULL);
+	if (prate) switch(*prate) {
+	case 100:
+		iface->cur_mode = KW_I2C_MODE_100KHZ;
+		break;
+	case 50:
+		iface->cur_mode = KW_I2C_MODE_50KHZ;
+		break;
+	case 25:
+		iface->cur_mode = KW_I2C_MODE_25KHZ;
+		break;
+	default:
+		printk(KERN_WARNING "i2c-keywest: unknown rate %ldKhz, using 100KHz\n",
+			*prate);
+	}
+	
+	/* Select standard sub mode */
+	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	
+	/* Write mode */
+	write_reg(reg_mode, iface->cur_mode);
+	
+	/* Switch interrupts off & clear them*/
+	write_reg(reg_ier, 0x00);
+	write_reg(reg_isr, KW_I2C_IRQ_MASK);
+
+	/* Request chip interrupt */	
+	rc = request_irq(iface->irq, keywest_irq, 0, "keywest i2c", iface);
+	if (rc) {
+		printk(KERN_ERR "i2c-keywest: can't get IRQ %d !\n", iface->irq);
+		iounmap((void *)iface->base);
+		kfree(iface);
+		return -ENODEV;
+	}
+
+	dev_set_drvdata(dev, iface);
+	
+	for (i=0; i<nchan; i++) {
+		struct keywest_chan* chan = &iface->channels[i];
+		u8 addr;
+		
+		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
+		chan->iface = iface;
+		chan->chan_no = i;
+		chan->adapter.id = I2C_ALGO_SMBUS;
+		chan->adapter.algo = &keywest_algorithm;
+		chan->adapter.algo_data = NULL;
+		chan->adapter.client_register = NULL;
+		chan->adapter.client_unregister = NULL;
+		i2c_set_adapdata(&chan->adapter, chan);
+		chan->adapter.dev.parent = dev;
+
+		rc = i2c_add_adapter(&chan->adapter);
+		if (rc) {
+			printk("i2c-keywest.c: Adapter %s registration failed\n",
+				chan->adapter.name);
+			i2c_set_adapdata(&chan->adapter, NULL);
+		}
+		if (probe) {
+			printk("Probe: ");
+			for (addr = 0x00; addr <= 0x7f; addr++) {
+				if (i2c_smbus_xfer(&chan->adapter,addr,
+				    0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
+					printk("%02x ", addr);
+			}
+			printk("\n");
+		}
+	}
+
+	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
+		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);
+		
+	return 0;
+}
+
+static int
+dispose_iface(struct device *dev)
+{
+	struct keywest_iface *iface = dev_get_drvdata(dev);
+	int i, rc;
+	
+	/* Make sure we stop all activity */
+	down(&iface->sem);
+
+	spin_lock_irq(&iface->lock);
+	while (iface->state != state_idle) {
+		spin_unlock_irq(&iface->lock);
+		set_task_state(current,TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/10);
+		spin_lock_irq(&iface->lock);
+	}
+	iface->state = state_dead;
+	spin_unlock_irq(&iface->lock);
+	free_irq(iface->irq, iface);
+	up(&iface->sem);
+
+	/* Release all channels */
+	for (i=0; i<iface->chan_count; i++) {
+		struct keywest_chan* chan = &iface->channels[i];
+		if (i2c_get_adapdata(&chan->adapter) = NULL)
+			continue;
+		rc = i2c_del_adapter(&chan->adapter);
+		i2c_set_adapdata(&chan->adapter, NULL);
+		/* We aren't that prepared to deal with this... */
+		if (rc)
+			printk("i2c-keywest.c: i2c_del_adapter failed, that's bad !\n");
+	}
+	iounmap((void *)iface->base);
+	dev_set_drvdata(dev, NULL);
+	kfree(iface);
+
+	return 0;
+}
+
+static int
+create_iface_macio(struct macio_dev* dev, const struct of_match *match)
+{
+	return create_iface(dev->ofdev.node, &dev->ofdev.dev);
+}
+
+static int
+dispose_iface_macio(struct macio_dev* dev)
+{
+	return dispose_iface(&dev->ofdev.dev);
+}
+
+static int
+create_iface_of_platform(struct of_device* dev, const struct of_match *match)
+{
+	return create_iface(dev->node, &dev->dev);
+}
+
+static int
+dispose_iface_of_platform(struct of_device* dev)
+{
+	return dispose_iface(&dev->dev);
+}
+
+static struct of_match i2c_keywest_match[] = 
+{
+	{
+	.name 		= OF_ANY_MATCH,
+	.type		= "i2c",
+	.compatible	= "keywest"
+	},
+	{},
+};
+
+static struct macio_driver i2c_keywest_macio_driver = 
+{
+	.name 		= "i2c-keywest",
+	.match_table	= i2c_keywest_match,
+	.probe		= create_iface_macio,
+	.remove		= dispose_iface_macio
+};
+
+static struct of_platform_driver i2c_keywest_of_platform_driver = 
+{
+	.name 		= "i2c-keywest",
+	.match_table	= i2c_keywest_match,
+	.probe		= create_iface_of_platform,
+	.remove		= dispose_iface_of_platform
+};
+
+static int __init
+i2c_keywest_init(void)
+{
+	macio_register_driver(&i2c_keywest_macio_driver);
+	of_register_driver(&i2c_keywest_of_platform_driver);
+
+	return 0;
+}
+
+static void __exit
+i2c_keywest_cleanup(void)
+{
+	macio_unregister_driver(&i2c_keywest_macio_driver);
+	of_unregister_driver(&i2c_keywest_of_platform_driver);
+}
+
+module_init(i2c_keywest_init);
+module_exit(i2c_keywest_cleanup);
diff -Nru a/drivers/i2c/busses/i2c-keywest.h b/drivers/i2c/busses/i2c-keywest.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-keywest.h	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,110 @@
+#ifndef __I2C_KEYWEST_H__
+#define __I2C_KEYWEST_H__
+
+/* The Tumbler audio equalizer can be really slow sometimes */
+#define POLL_TIMEOUT		(2*HZ)
+
+/* Register indices */
+typedef enum {
+	reg_mode = 0,
+	reg_control,
+	reg_status,
+	reg_isr,
+	reg_ier,
+	reg_addr,
+	reg_subaddr,
+	reg_data
+} reg_t;
+
+
+/* Mode register */
+#define KW_I2C_MODE_100KHZ	0x00
+#define KW_I2C_MODE_50KHZ	0x01
+#define KW_I2C_MODE_25KHZ	0x02
+#define KW_I2C_MODE_DUMB	0x00
+#define KW_I2C_MODE_STANDARD	0x04
+#define KW_I2C_MODE_STANDARDSUB	0x08
+#define KW_I2C_MODE_COMBINED	0x0C
+#define KW_I2C_MODE_MODE_MASK	0x0C
+#define KW_I2C_MODE_CHAN_MASK	0xF0
+
+/* Control register */
+#define KW_I2C_CTL_AAK		0x01
+#define KW_I2C_CTL_XADDR	0x02
+#define KW_I2C_CTL_STOP		0x04
+#define KW_I2C_CTL_START	0x08
+
+/* Status register */
+#define KW_I2C_STAT_BUSY	0x01
+#define KW_I2C_STAT_LAST_AAK	0x02
+#define KW_I2C_STAT_LAST_RW	0x04
+#define KW_I2C_STAT_SDA		0x08
+#define KW_I2C_STAT_SCL		0x10
+
+/* IER & ISR registers */
+#define KW_I2C_IRQ_DATA		0x01
+#define KW_I2C_IRQ_ADDR		0x02
+#define KW_I2C_IRQ_STOP		0x04
+#define KW_I2C_IRQ_START	0x08
+#define KW_I2C_IRQ_MASK		0x0F
+
+/* Physical interface */
+struct keywest_iface
+{
+	unsigned long		base;
+	unsigned		bsteps;
+	int			irq;
+	struct semaphore	sem;
+	spinlock_t		lock;
+	struct keywest_chan*	channels;
+	unsigned		chan_count;
+	u8			cur_mode;
+	char			read_write;
+	u8*			data;
+	unsigned		datalen;
+	int			state;
+	int			result;
+	int			stopretry;
+	struct timer_list	timeout_timer;
+	struct completion	complete;
+};
+
+enum {
+	state_idle,
+	state_addr,
+	state_read,
+	state_write,
+	state_stop,
+	state_dead
+};
+
+/* Channel on an interface */
+struct keywest_chan
+{
+	struct i2c_adapter	adapter;
+	struct keywest_iface*	iface;
+	unsigned		chan_no;
+};
+
+/* Register access */
+
+static inline u8 __read_reg(struct keywest_iface *iface, reg_t reg)
+{
+	return in_8(((volatile u8 *)iface->base)
+		+ (((unsigned)reg) << iface->bsteps));
+}
+
+static inline void __write_reg(struct keywest_iface *iface, reg_t reg, u8 val)
+{
+	out_8(((volatile u8 *)iface->base)
+		+ (((unsigned)reg) << iface->bsteps), val);
+	(void)__read_reg(iface, reg);
+	udelay(10);
+}
+
+#define write_reg(reg, val)	__write_reg(iface, reg, val) 
+#define read_reg(reg)		__read_reg(iface, reg) 
+
+
+
+#endif /* __I2C_KEYWEST_H__ */
diff -Nru a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-rpx.c	Mon Sep 22 16:12:05 2003
@@ -0,0 +1,103 @@
+/*
+ * Embedded Planet RPX Lite MPC8xx CPM I2C interface.
+ * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
+ *
+ * moved into proper i2c interface;
+ * Brad Parker (brad@heeltoe.com)
+ *
+ * RPX lite specific parts of the i2c interface
+ * Update:  There actually isn't anything RPXLite-specific about this module.
+ * This should work for most any 8xx board.  The console messages have been 
+ * changed to eliminate RPXLite references.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+#include <linux/parport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-8xx.h>
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+
+
+static void
+rpx_iic_init(struct i2c_algo_8xx_data *data)
+{
+	volatile cpm8xx_t *cp;
+	volatile immap_t *immap;
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */
+
+	data->iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
+
+	/* Check for and use a microcode relocation patch.
+	*/
+	if ((data->reloc = data->iip->iic_rpbase))
+		data->iip = (iic_t *)&cp->cp_dpmem[data->iip->iic_rpbase];
+		
+	data->i2c = (i2c8xx_t *)&(immap->im_i2c);
+	data->cp = cp;
+
+	/* Initialize Port B IIC pins.
+	*/
+	cp->cp_pbpar |= 0x00000030;
+	cp->cp_pbdir |= 0x00000030;
+	cp->cp_pbodr |= 0x00000030;
+
+	/* Allocate space for two transmit and two receive buffer
+	 * descriptors in the DP ram.
+	 */
+	data->dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 4);
+
+	/* ptr to i2c area */
+	data->i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
+}
+
+static int rpx_install_isr(int irq, void (*func)(void *, void *), void *data)
+{
+	/* install interrupt handler */
+	cpm_install_handler(irq, (void (*)(void *, struct pt_regs *)) func, data);
+
+	return 0;
+}
+
+static struct i2c_algo_8xx_data rpx_data = {
+	.setisr = rpx_install_isr
+};
+
+static struct i2c_adapter rpx_ops = {
+	.owner		= THIS_MODULE,
+	.name		= "m8xx",
+	.id		= I2C_HW_MPC8XX_EPON,
+	.algo_data	= &rpx_data,
+};
+
+int __init i2c_rpx_init(void)
+{
+	printk("i2c-rpx.o: i2c MPC8xx module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+
+	/* reset hardware to sane state */
+	rpx_iic_init(&rpx_data);
+
+	if (i2c_8xx_add_bus(&rpx_ops) < 0) {
+		printk("i2c-rpx: Unable to register with I2C\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void __exit i2c_rpx_exit(void)
+{
+	i2c_8xx_del_bus(&rpx_ops);
+}
+
+MODULE_AUTHOR("Dan Malek <dmalek@jlc.net>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for MPC8xx boards");
+
+module_init(i2c_rpx_init);
+module_exit(i2c_rpx_exit);
diff -Nru a/drivers/i2c/i2c-adap-ite.c b/drivers/i2c/i2c-adap-ite.c
--- a/drivers/i2c/i2c-adap-ite.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,278 +0,0 @@
-/*
-   -------------------------------------------------------------------------
-   i2c-adap-ite.c i2c-hw access for the IIC peripheral on the ITE MIPS system
-   -------------------------------------------------------------------------
-   Hai-Pao Fan, MontaVista Software, Inc.
-   hpfan@mvista.com or source@mvista.com
-
-   Copyright 2001 MontaVista Software Inc.
-
-   ----------------------------------------------------------------------------
-   This file was highly leveraged from i2c-elektor.c, which was created
-   by Simon G. Vogl and Hans Berglund:
-
- 
-     Copyright (C) 1995-97 Simon G. Vogl
-                   1998-99 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-
-#include <linux/i2c.h>
-#include <linux/i2c-algo-ite.h>
-#include <linux/i2c-adap-ite.h>
-#include "i2c-ite.h"
-
-#define DEFAULT_BASE  0x14014030
-#define ITE_IIC_IO_SIZE	0x40
-#define DEFAULT_IRQ   0
-#define DEFAULT_CLOCK 0x1b0e	/* default 16MHz/(27+14) = 400KHz */
-#define DEFAULT_OWN   0x55
-
-static int base  = 0;
-static int irq   = 0;
-static int clock = 0;
-static int own   = 0;
-
-static int i2c_debug=0;
-static struct iic_ite gpi;
-static wait_queue_head_t iic_wait;
-static int iic_pending;
-
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)	if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x
-#define DEBE(x)	x	/* error messages 				*/
-
-
-/* ----- local functions ----------------------------------------------	*/
-
-static void iic_ite_setiic(void *data, int ctl, short val)
-{
-        unsigned long j = jiffies + 10;
-
-	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
-	DEB3({while (time_before(jiffies, j)) schedule();})
-	outw(val,ctl);
-}
-
-static short iic_ite_getiic(void *data, int ctl)
-{
-	short val;
-
-	val = inw(ctl);
-	DEB3(printk("Read 0x%02x from 0x%x\n",(unsigned short)val, ctl&0xff));  
-	return (val);
-}
-
-/* Return our slave address.  This is the address
- * put on the I2C bus when another master on the bus wants to address us
- * as a slave
- */
-static int iic_ite_getown(void *data)
-{
-	return (gpi.iic_own);
-}
-
-
-static int iic_ite_getclock(void *data)
-{
-	return (gpi.iic_clock);
-}
-
-
-#if 0
-static void iic_ite_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-#endif
-
-
-/* Put this process to sleep.  We will wake up when the
- * IIC controller interrupts.
- */
-static void iic_ite_waitforpin(void) {
-
-   int timeout = 2;
-
-   /* If interrupts are enabled (which they are), then put the process to
-    * sleep.  This process will be awakened by two events -- either the
-    * the IIC peripheral interrupts or the timeout expires. 
-    * If interrupts are not enabled then delay for a reasonable amount 
-    * of time and return.
-    */
-   if (gpi.iic_irq > 0) {
-	cli();
-	if (iic_pending = 0) {
-		interruptible_sleep_on_timeout(&iic_wait, timeout*HZ );
-	} else
-		iic_pending = 0;
-	sti();
-   } else {
-      udelay(100);
-   }
-}
-
-
-static void iic_ite_handler(int this_irq, void *dev_id, struct pt_regs *regs) 
-{
-	
-   iic_pending = 1;
-
-   DEB2(printk("iic_ite_handler: in interrupt handler\n"));
-   wake_up_interruptible(&iic_wait);
-}
-
-
-/* Lock the region of memory where I/O registers exist.  Request our
- * interrupt line and register its associated handler.
- */
-static int iic_hw_resrc_init(void)
-{
-	if (!request_region(gpi.iic_base, ITE_IIC_IO_SIZE, "i2c"))
-		return -ENODEV;
-  
-	if (gpi.iic_irq <= 0)
-		return 0;
-
-	if (request_irq(gpi.iic_irq, iic_ite_handler, 0, "ITE IIC", 0) < 0)
-		gpi.iic_irq = 0;
-	else
-		enable_irq(gpi.iic_irq);
-
-	return 0;
-}
-
-
-static void iic_ite_release(void)
-{
-	if (gpi.iic_irq > 0) {
-		disable_irq(gpi.iic_irq);
-		free_irq(gpi.iic_irq, 0);
-	}
-	release_region(gpi.iic_base , 2);
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
-static struct i2c_algo_iic_data iic_ite_data = {
-	NULL,
-	iic_ite_setiic,
-	iic_ite_getiic,
-	iic_ite_getown,
-	iic_ite_getclock,
-	iic_ite_waitforpin,
-	80, 80, 100,		/*	waits, timeout */
-};
-
-static struct i2c_adapter iic_ite_ops = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_I_IIC,
-	.algo_data	= &iic_ite_data,
-	.dev		= {
-		.name	= "ITE IIC adapter",
-	},
-};
-
-/* Called when the module is loaded.  This function starts the
- * cascade of calls up through the hierarchy of i2c modules (i.e. up to the
- *  algorithm layer and into to the core layer)
- */
-static int __init iic_ite_init(void) 
-{
-
-	struct iic_ite *piic = &gpi;
-
-	printk(KERN_INFO "Initialize ITE IIC adapter module\n");
-	if (base = 0)
-		piic->iic_base = DEFAULT_BASE;
-	else
-		piic->iic_base = base;
-
-	if (irq = 0)
-		piic->iic_irq = DEFAULT_IRQ;
-	else
-		piic->iic_irq = irq;
-
-	if (clock = 0)
-		piic->iic_clock = DEFAULT_CLOCK;
-	else
-		piic->iic_clock = clock;
-
-	if (own = 0)
-		piic->iic_own = DEFAULT_OWN;
-	else
-		piic->iic_own = own;
-
-	iic_ite_data.data = (void *)piic;
-	init_waitqueue_head(&iic_wait);
-	if (iic_hw_resrc_init() = 0) {
-		if (i2c_iic_add_bus(&iic_ite_ops) < 0)
-			return -ENODEV;
-	} else {
-		return -ENODEV;
-	}
-	printk(KERN_INFO " found device at %#x irq %d.\n", 
-		piic->iic_base, piic->iic_irq);
-	return 0;
-}
-
-
-static void iic_ite_exit(void)
-{
-	i2c_iic_del_bus(&iic_ite_ops);
-        iic_ite_release();
-}
-
-/* If modules is NOT defined when this file is compiled, then the MODULE_*
- * macros will resolve to nothing
- */
-MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for ITE IIC bus adapter");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(base, "i");
-MODULE_PARM(irq, "i");
-MODULE_PARM(clock, "i");
-MODULE_PARM(own, "i");
-MODULE_PARM(i2c_debug,"i");
-
-
-/* Called when module is loaded or when kernel is initialized.
- * If MODULES is defined when this file is compiled, then this function will
- * resolve to init_module (the function called when insmod is invoked for a
- * module).  Otherwise, this function is called early in the boot, when the
- * kernel is intialized.  Check out /include/init.h to see how this works.
- */
-module_init(iic_ite_init);
-
-/* Resolves to module_cleanup when MODULES is defined. */
-module_exit(iic_ite_exit); 
diff -Nru a/drivers/i2c/i2c-frodo.c b/drivers/i2c/i2c-frodo.c
--- a/drivers/i2c/i2c-frodo.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,85 +0,0 @@
-
-/*
- * linux/drivers/i2c/i2c-frodo.c
- *
- * Author: Abraham van der Merwe <abraham@2d3d.co.za>
- *
- * An I2C adapter driver for the 2d3D, Inc. StrongARM SA-1110
- * Development board (Frodo).
- *
- * This source code is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/hardware.h>
-
-
-static void frodo_setsda (void *data,int state)
-{
-	if (state)
-		FRODO_CPLD_I2C |= FRODO_I2C_SDA_OUT;
-	else
-		FRODO_CPLD_I2C &= ~FRODO_I2C_SDA_OUT;
-}
-
-static void frodo_setscl (void *data,int state)
-{
-	if (state)
-		FRODO_CPLD_I2C |= FRODO_I2C_SCL_OUT;
-	else
-		FRODO_CPLD_I2C &= ~FRODO_I2C_SCL_OUT;
-}
-
-static int frodo_getsda (void *data)
-{
-	return ((FRODO_CPLD_I2C & FRODO_I2C_SDA_IN) != 0);
-}
-
-static int frodo_getscl (void *data)
-{
-	return ((FRODO_CPLD_I2C & FRODO_I2C_SCL_IN) != 0);
-}
-
-static struct i2c_algo_bit_data bit_frodo_data = {
-	.setsda		= frodo_setsda,
-	.setscl		= frodo_setscl,
-	.getsda		= frodo_getsda,
-	.getscl		= frodo_getscl,
-	.udelay		= 80,
-	.mdelay		= 80,
-	.timeout	= HZ
-};
-
-static struct i2c_adapter frodo_ops = {
-	.owner			= THIS_MODULE,
-	.id			= I2C_HW_B_FRODO,
-	.algo_data		= &bit_frodo_data,
-	.dev			= {
-		.name		= "Frodo adapter driver",
-	},
-};
-
-static int __init i2c_frodo_init (void)
-{
-	return i2c_bit_add_bus(&frodo_ops);
-}
-
-static void __exit i2c_frodo_exit (void)
-{
-	i2c_bit_del_bus(&frodo_ops);
-}
-
-MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
-MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
-MODULE_LICENSE ("GPL");
-
-module_init (i2c_frodo_init);
-module_exit (i2c_frodo_exit);
-
diff -Nru a/drivers/i2c/i2c-ibm_iic.c b/drivers/i2c/i2c-ibm_iic.c
--- a/drivers/i2c/i2c-ibm_iic.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,729 +0,0 @@
-/*
- * drivers/i2c/i2c-ibm_iic.c
- *
- * Support for the IIC peripheral on IBM PPC 4xx
- *
- * Copyright (c) 2003 Zultys Technologies.
- * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- *
- * Based on original work by 
- * 	Ian DaSilva  <idasilva@mvista.com>
- *      Armin Kuster <akuster@mvista.com>
- * 	Matt Porter  <mporter@mvista.com>
- *
- *      Copyright 2000-2003 MontaVista Software Inc.
- *
- * Original driver version was highly leveraged from i2c-elektor.c
- *
- *   	Copyright 1995-97 Simon G. Vogl
- *                1998-99 Hans Berglund
- *
- *   	With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> 
- *	and even Frodo Looijaard <frodol@dds.nl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <linux/i2c.h>
-#include <linux/i2c-id.h>
-#include <asm/ocp.h>
-#include <asm/ibm4xx.h>
-
-#include "i2c-ibm_iic.h"
-
-#define DRIVER_VERSION "2.0"
-
-MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
-MODULE_LICENSE("GPL");
-
-static int iic_scan = 0;
-MODULE_PARM(iic_scan, "i");
-MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
-
-static int iic_force_poll = 0;
-MODULE_PARM(iic_force_poll, "i");
-MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
-
-static int iic_force_fast = 0;
-MODULE_PARM(iic_force_fast, "i");
-MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
-
-#define DBG_LEVEL 0
-
-#ifdef DBG
-#undef DBG
-#endif
-
-#ifdef DBG2
-#undef DBG2
-#endif
-
-#if DBG_LEVEL > 0
-#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
-#else
-#  define DBG(x...)	((void)0)
-#endif
-#if DBG_LEVEL > 1
-#  define DBG2(x...) 	DBG( ##x )
-#else
-#  define DBG2(x...) 	((void)0)
-#endif
-#if DBG_LEVEL > 2
-static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
-	printk(KERN_DEBUG "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
-	       KERN_DEBUG "  sts      = 0x%02x, extsts = 0x%02x\n"
-	       KERN_DEBUG "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
-	       KERN_DEBUG "  xtcntlss = 0x%02x, directcntl = 0x%02x\n",
-		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts), 
-		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt), 
-		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
-}
-#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
-#else
-#  define DUMP_REGS(h,dev)	((void)0)
-#endif
-
-/* Enable/disable interrupt generation */
-static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
-{
-	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
-}
- 
-/*
- * Initialize IIC interface.
- */
-static void iic_dev_init(struct ibm_iic_private* dev)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-
-	DBG("%d: init\n", dev->idx);
-	
-	/* Clear master address */
-	out_8(&iic->lmadr, 0);
-	out_8(&iic->hmadr, 0);
-
-	/* Clear slave address */
-	out_8(&iic->lsadr, 0);
-	out_8(&iic->hsadr, 0);
-
-	/* Clear status & extended status */
-	out_8(&iic->sts, STS_SCMP | STS_IRQA);
-	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
-			    | EXTSTS_ICT | EXTSTS_XFRA);
-
-	/* Set clock divider */
-	out_8(&iic->clkdiv, dev->clckdiv);
-
-	/* Clear transfer count */
-	out_8(&iic->xfrcnt, 0);
-
-	/* Clear extended control and status */
-	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
-			    | XTCNTLSS_SWS);
-
-	/* Clear control register */
-	out_8(&iic->cntl, 0);
-	
-	/* Enable interrupts if possible */
-	iic_interrupt_mode(dev, dev->irq >= 0);
-
-	/* Set mode control */
-	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
-			    | (dev->fast_mode ? MDCNTL_FSM : 0));
-
-	DUMP_REGS("iic_init", dev);
-}
-
-/* 
- * Reset IIC interface
- */
-static void iic_dev_reset(struct ibm_iic_private* dev)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-	int i;
-	u8 dc;
-	
-	DBG("%d: soft reset\n", dev->idx);
-	DUMP_REGS("reset", dev);
-	
-    	/* Place chip in the reset state */
-	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
-	
-	/* Check if bus is free */
-	dc = in_8(&iic->directcntl);	
-	if (!DIRCTNL_FREE(dc)){
-		DBG("%d: trying to regain bus control\n", dev->idx);
-	
-		/* Try to set bus free state */
-		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);	
-	
-		/* Wait until we regain bus control */
-		for (i = 0; i < 100; ++i){
-			dc = in_8(&iic->directcntl);
-			if (DIRCTNL_FREE(dc))
-				break;
-			
-			/* Toggle SCL line */
-			dc ^= DIRCNTL_SCC;
-			out_8(&iic->directcntl, dc);
-			udelay(10);
-			dc ^= DIRCNTL_SCC;
-			out_8(&iic->directcntl, dc);
-			
-			/* be nice */
-			cond_resched();
-		}
-	}
-	
-	/* Remove reset */
-	out_8(&iic->xtcntlss, 0);
-	
-	/* Reinitialize interface */
-	iic_dev_init(dev);
-}
-
-/*
- * IIC interrupt handler
- */
-static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
-	volatile struct iic_regs* iic = dev->vaddr;
-	
-	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n", 
-	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
-	
-	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
-	out_8(&iic->sts, STS_IRQA | STS_SCMP);
-	wake_up_interruptible(&dev->wq);
-	
-	return IRQ_HANDLED;
-}
-
-/*
- * Get master transfer result and clear errors if any.
- * Returns the number of actually transferred bytes or error (<0)
- */
-static int iic_xfer_result(struct ibm_iic_private* dev)
-{
-	volatile struct iic_regs *iic = dev->vaddr;	
-	
-	if (unlikely(in_8(&iic->sts) & STS_ERR)){
-		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx, 
-			in_8(&iic->extsts));
-				
-		/* Clear errors and possible pending IRQs */
-		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | 
-			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
-			
-		/* Flush master data buffer */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
-		
-		/* Is bus free?
-		 * If error happened during combined xfer
-		 * IIC interface is usually stuck in some strange
-		 * state, the only way out - soft reset.
-		 */
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-			DBG("%d: bus is stuck, resetting\n", dev->idx);
-			iic_dev_reset(dev);
-		}
-		return -EREMOTEIO;
-	}
-	else
-		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
-}
-
-/*
- * Try to abort active transfer.
- */
-static void iic_abort_xfer(struct ibm_iic_private* dev)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-	unsigned long x;
-	
-	DBG("%d: iic_abort_xfer\n", dev->idx);
-	
-	out_8(&iic->cntl, CNTL_HMT);
-	
-	/*
-	 * Wait for the abort command to complete.
-	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
-	 */
-	x = jiffies + 2;
-	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-		if (time_after(jiffies, x)){
-			DBG("%d: abort timeout, resetting...\n", dev->idx);
-			iic_dev_reset(dev);
-			return;
-		}
-		schedule();
-	}
-
-	/* Just to clear errors */
-	iic_xfer_result(dev);
-}
-
-/*
- * Wait for master transfer to complete.
- * It puts current process to sleep until we get interrupt or timeout expires.
- * Returns the number of transferred bytes or error (<0)
- */
-static int iic_wait_for_tc(struct ibm_iic_private* dev){
-	
-	volatile struct iic_regs *iic = dev->vaddr;
-	int ret = 0;
-	
-	if (dev->irq >= 0){
-		/* Interrupt mode */
-		wait_queue_t wait;
-    		init_waitqueue_entry(&wait, current);
-		
-		add_wait_queue(&dev->wq, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (in_8(&iic->sts) & STS_PT)
-			schedule_timeout(dev->adap.timeout * HZ);
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&dev->wq, &wait);
-		
-		if (unlikely(signal_pending(current))){
-			DBG("%d: wait interrupted\n", dev->idx);
-			ret = -ERESTARTSYS;
-		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
-			DBG("%d: wait timeout\n", dev->idx);
-			ret = -ETIMEDOUT;
-		}
-	}
-	else {
-		/* Polling mode */
-		unsigned long x = jiffies + dev->adap.timeout * HZ;
-		
-		while (in_8(&iic->sts) & STS_PT){
-			if (unlikely(time_after(jiffies, x))){
-				DBG("%d: poll timeout\n", dev->idx);
-				ret = -ETIMEDOUT;
-				break;
-			}
-		
-			if (unlikely(signal_pending(current))){
-				DBG("%d: poll interrupted\n", dev->idx);
-				ret = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}	
-	}
-	
-	if (unlikely(ret < 0))
-		iic_abort_xfer(dev);
-	else
-		ret = iic_xfer_result(dev);
-	
-	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
-	
-	return ret;
-}
-
-/*
- * Low level master transfer routine
- */
-static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm, 
-			  int combined_xfer)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-	char* buf = pm->buf;
-	int i, j, loops, ret = 0;
-	int len = pm->len;
-
-	u8 cntl = (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
-	if (pm->flags & I2C_M_RD)
-		cntl |= CNTL_RW;
-	
-	loops = (len + 3) / 4;
-	for (i = 0; i < loops; ++i, len -= 4){
-		int count = len > 4 ? 4 : len;
-		u8 cmd = cntl | ((count - 1) << CNTL_TCT_SHIFT);
-		
-		if (!(cntl & CNTL_RW))
-			for (j = 0; j < count; ++j)
-				out_8((volatile u8*)&iic->mdbuf, *buf++);
-		
-		if (i < loops - 1)
-			cmd |= CNTL_CHT;
-		else if (combined_xfer)
-			cmd |= CNTL_RPST;
-		
-		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
-		
-		/* Start transfer */
-		out_8(&iic->cntl, cmd);
-		
-		/* Wait for completion */
-		ret = iic_wait_for_tc(dev);
-
-		if (unlikely(ret < 0))
-			break;
-		else if (unlikely(ret != count)){
-			DBG("%d: xfer_bytes, requested %d, transfered %d\n", 
-				dev->idx, count, ret);
-			
-			/* If it's not a last part of xfer, abort it */
-			if (combined_xfer || (i < loops - 1))
-    				iic_abort_xfer(dev);
-				
-			ret = -EREMOTEIO;
-			break;				
-		}
-		
-		if (cntl & CNTL_RW)
-			for (j = 0; j < count; ++j)
-				*buf++ = in_8((volatile u8*)&iic->mdbuf);
-	}
-	
-	return ret > 0 ? 0 : ret;
-}
-
-/*
- * Set target slave address for master transfer
- */
-static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
-{
-	volatile struct iic_regs *iic = dev->vaddr;
-	u16 addr = msg->addr;
-	
-	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx, 
-		addr, msg->flags & I2C_M_TEN ? 10 : 7);
-	
-	if (msg->flags & I2C_M_TEN){
-	    out_8(&iic->cntl, CNTL_AMD);
-	    out_8(&iic->lmadr, addr);
-	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
-	}
-	else {
-	    out_8(&iic->cntl, 0);
-	    out_8(&iic->lmadr, addr << 1);
-	}
-}
-
-static inline int iic_invalid_address(const struct i2c_msg* p)
-{
-	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
-}
-
-static inline int iic_address_neq(const struct i2c_msg* p1, 
-				  const struct i2c_msg* p2)
-{
-	return (p1->addr != p2->addr) 
-		|| ((p1->flags & I2C_M_TEN) != (p2->flags & I2C_M_TEN));
-} 
-
-/*
- * Generic master transfer entrypoint. 
- * Returns the number of processed messages or error (<0)
- */
-static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
-{
-    	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
-	volatile struct iic_regs *iic = dev->vaddr;
-	int i, ret = 0;
-	
-	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
-	
-	if (!num)
-		return 0;
-	
-	/* Check the sanity of the passed messages.
-	 * Uhh, generic i2c layer is more suitable place for such code...
-	 */
-	if (unlikely(iic_invalid_address(&msgs[0]))){
-		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx, 
-			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
-		return -EINVAL;
-	}		
-	for (i = 0; i < num; ++i){
-		if (unlikely(msgs[i].len <= 0)){
-			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
-				msgs[i].len, i);
-			return -EINVAL;
-		}
-		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
-			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
-			return -EINVAL;
-		}
-	}
-	
-	/* Check bus state */
-	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
-		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
-		
-		/* Usually it means something serious has happend.
-		 * We *cannot* have unfinished previous transfer
-		 * so it doesn't make any sense to try to stop it.
-		 * Probably we were not able to recover from the 
-		 * previous error.
-		 * The only *reasonable* thing I can think of here
-		 * is soft reset.  --ebs
-		 */
-		iic_dev_reset(dev);
-		
-		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
-			return -EREMOTEIO;
-		}
-	} 
-	else {
-		/* Flush master data buffer (just in case) */
-		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
-	}
-	
-	/* Load slave address */
-	iic_address(dev, &msgs[0]);
-	
-	/* Do real transfer */
-    	for (i = 0; i < num && !ret; ++i)
-		ret = iic_xfer_bytes(dev, &msgs[i], i < num - 1);
-
-	return ret < 0 ? ret : num;
-}
-
-static u32 iic_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
-}
-
-static struct i2c_algorithm iic_algo = {
-	.name 		= "IBM IIC algorithm",
-	.id   		= I2C_ALGO_OCP,
-	.master_xfer 	= iic_xfer,
-	.smbus_xfer	= NULL,
-	.slave_send	= NULL,
-	.slave_recv	= NULL,
-	.algo_control	= NULL,
-	.functionality	= iic_func
-};
-
-/*
- * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
- * We only scan range [0x08 - 0x77], all other addresses are reserved anyway
- */
-static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
-{
-	int found = 0;
-	char dummy;
-	struct i2c_msg msg = {
-		.buf   = &dummy,
-		.len   = sizeof(dummy),
-		.flags = I2C_M_RD
-	};
-	
-	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
-	
-	for (msg.addr = 8; msg.addr < 0x78; ++msg.addr)
-		if (iic_xfer(&dev->adap, &msg, 1) = 1){
-			++found;
-			printk(" 0x%02x", msg.addr);
-		}
-
-	printk("%sibm-iic%d: %d device(s) detected\n", 
-		found ? "\n" KERN_INFO : "", dev->idx, found);
-}
-
-/*
- * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
- */
-static inline u8 iic_clckdiv(unsigned int opb)
-{
-	/* Compatibility kludge, should go away after all cards
-	 * are fixed to fill correct value for opbfreq.
-	 * Previous driver version used hardcoded divider value 4,
-	 * it corresponds to OPB frequency from the range (40, 50] MHz
-	 */
-	if (!opb){
-		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
-			" fix your board specific setup\n");
-		opb = 50000000;
-	}
-
-	/* Convert to MHz */
-	opb /= 1000000;
-	
-	if (opb < 20 || opb > 150){
-		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
-			opb);
-		opb = opb < 20 ? 20 : 150;
-	}
-	return (u8)((opb + 9) / 10 - 1);
-}
-
-/*
- * Register single IIC interface
- */
-static int __devinit iic_probe(struct ocp_device *ocp){
-
-	struct ibm_iic_private* dev;
-	struct i2c_adapter* adap;
-	int ret;
-	bd_t* bd = (bd_t*)&__res;
-	
-	if (!(dev = kmalloc(sizeof(*dev), GFP_KERNEL))){
-		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
-		return -ENOMEM;
-	}
-
-	memset(dev, 0, sizeof(*dev));
-	dev->idx = ocp->num;
-	ocp_set_drvdata(ocp, dev);
-	
-	if (!(dev->vaddr = ioremap(ocp->paddr, sizeof(struct iic_regs)))){
-		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
-			dev->idx);
-		ret = -ENXIO;
-		goto fail2;
-	}
-	
-	init_waitqueue_head(&dev->wq);
-
-	dev->irq = iic_force_poll ? -1 : ocp->irq;
-	if (dev->irq >= 0){
-		/* Disable interrupts until we finish intialization,
-		   assumes level-sensitive IRQ setup...
-		 */
-		iic_interrupt_mode(dev, 0);
-		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
-			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n", 
-				dev->idx, dev->irq);
-			/* Fallback to the polling mode */	
-			dev->irq = -1;
-		}
-	}
-	
-	if (dev->irq < 0)
-		printk(KERN_WARNING "ibm-iic%d: using polling mode\n", 
-			dev->idx);
-		
-	/* Board specific settings */
-	BUG_ON(dev->idx >= sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]));
-	dev->fast_mode = iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
-	
-	/* clckdiv is the same for *all* IIC interfaces, 
-	 * but I'd rather make a copy than introduce another global. --ebs
-	 */
-	dev->clckdiv = iic_clckdiv(bd->bi_opb_busfreq);
-	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
-	
-	/* Initialize IIC interface */
-	iic_dev_init(dev);
-	
-	/* Register it with i2c layer */
-	adap = &dev->adap;
-	strcpy(adap->dev.name, "IBM IIC");
-	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_HW_OCP | iic_algo.id;
-	adap->algo = &iic_algo;
-	adap->client_register = NULL;
-	adap->client_unregister = NULL;
-	adap->timeout = 1;
-	adap->retries = 1;
-
-	if ((ret = i2c_add_adapter(adap)) != 0){
-		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
-			dev->idx);
-		goto fail;
-	}
-	
-	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
-		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
-
-	/* Scan bus if requested by user */
-	if (iic_scan)
-		iic_scan_bus(dev);
-
-	return 0;
-
-fail:	
-	if (dev->irq >= 0){
-		iic_interrupt_mode(dev, 0);
-		free_irq(dev->irq, dev);
-	}	
-
-	iounmap((void*)dev->vaddr);
-fail2:	
-	ocp_set_drvdata(ocp, 0);
-	kfree(dev);	
-	return ret;
-}
-
-/*
- * Cleanup initialized IIC interface
- */
-static void __devexit iic_remove(struct ocp_device *ocp)
-{
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
-	BUG_ON(dev = NULL);
-	if (i2c_del_adapter(&dev->adap)){
-		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
-			dev->idx);
-		/* That's *very* bad, just shutdown IRQ ... */
-		if (dev->irq >= 0){
-		    iic_interrupt_mode(dev, 0);	
-		    free_irq(dev->irq, dev);
-		    dev->irq = -1;
-		}
-	} else {
-		if (dev->irq >= 0){
-		    iic_interrupt_mode(dev, 0);	
-		    free_irq(dev->irq, dev);
-		}
-		iounmap((void*)dev->vaddr);
-		kfree(dev);
-	}
-}
-
-static struct ocp_device_id ibm_iic_ids[] __devinitdata = 
-{
-	{ .vendor = OCP_VENDOR_IBM, .device = OCP_FUNC_IIC },
-	{ .vendor = OCP_VENDOR_INVALID }
-};
-
-MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
-
-static struct ocp_driver ibm_iic_driver -{
-	.name 		= "ocp_iic",
-	.id_table	= ibm_iic_ids,
-	.probe		= iic_probe,
-	.remove		= __devexit_p(iic_remove),
-#if defined(CONFIG_PM)
-	.suspend	= NULL,
-	.resume		= NULL,
-#endif
-};
-
-static int __init iic_init(void)
-{
-	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
-	return ocp_module_init(&ibm_iic_driver);
-}
-
-static void __exit iic_exit(void)
-{
-	ocp_unregister_driver(&ibm_iic_driver);
-}
-
-module_init(iic_init);
-module_exit(iic_exit);
diff -Nru a/drivers/i2c/i2c-ibm_iic.h b/drivers/i2c/i2c-ibm_iic.h
--- a/drivers/i2c/i2c-ibm_iic.h	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,124 +0,0 @@
-/*
- * drivers/i2c/i2c-ibm_iic.h
- *
- * Support for the IIC peripheral on IBM PPC 4xx
- * 
- * Copyright (c) 2003 Zultys Technologies.
- * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- *
- * Based on original work by 
- * 	Ian DaSilva  <idasilva@mvista.com>
- *      Armin Kuster <akuster@mvista.com>
- * 	Matt Porter  <mporter@mvista.com>
- *
- *      Copyright 2000-2003 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-#ifndef __I2C_IBM_IIC_H_
-#define __I2C_IBM_IIC_H_
-
-#include <linux/config.h>
-#include <linux/i2c.h> 
-
-struct iic_regs {
-	u16 mdbuf;
-	u16 sbbuf;
-	u8 lmadr;
-	u8 hmadr;
-	u8 cntl;
-	u8 mdcntl;
-	u8 sts;
-	u8 extsts;
-	u8 lsadr;
-	u8 hsadr;
-	u8 clkdiv;
-	u8 intmsk;
-	u8 xfrcnt;
-	u8 xtcntlss;
-	u8 directcntl;
-};
-
-struct ibm_iic_private {
-	struct i2c_adapter adap;
-	volatile struct iic_regs *vaddr;
-	wait_queue_head_t wq;
-	int idx;
-	int irq;
-	int fast_mode;
-	u8  clckdiv;
-};
-
-/* IICx_CNTL register */
-#define CNTL_HMT	0x80
-#define CNTL_AMD	0x40
-#define CNTL_TCT_MASK	0x30
-#define CNTL_TCT_SHIFT	4
-#define CNTL_RPST	0x08
-#define CNTL_CHT	0x04 
-#define CNTL_RW		0x02
-#define CNTL_PT		0x01
-
-/* IICx_MDCNTL register */
-#define MDCNTL_FSDB	0x80
-#define MDCNTL_FMDB	0x40
-#define MDCNTL_EGC	0x20
-#define MDCNTL_FSM	0x10
-#define MDCNTL_ESM	0x08
-#define MDCNTL_EINT	0x04
-#define MDCNTL_EUBS	0x02
-#define MDCNTL_HSCL	0x01
-
-/* IICx_STS register */
-#define STS_SSS		0x80
-#define STS_SLPR	0x40
-#define STS_MDBS	0x20
-#define STS_MDBF	0x10
-#define STS_SCMP	0x08
-#define STS_ERR		0x04
-#define STS_IRQA	0x02
-#define STS_PT		0x01
-
-/* IICx_EXTSTS register */
-#define EXTSTS_IRQP	0x80
-#define EXTSTS_BCS_MASK	0x70
-#define   EXTSTS_BCS_FREE  0x40
-#define EXTSTS_IRQD	0x08
-#define EXTSTS_LA	0x04
-#define EXTSTS_ICT	0x02
-#define EXTSTS_XFRA	0x01
-
-/* IICx_INTRMSK register */
-#define INTRMSK_EIRC	0x80
-#define INTRMSK_EIRS	0x40
-#define INTRMSK_EIWC	0x20
-#define INTRMSK_EIWS	0x10
-#define INTRMSK_EIHE	0x08
-#define INTRMSK_EIIC	0x04
-#define INTRMSK_EITA	0x02
-#define INTRMSK_EIMTC	0x01
-
-/* IICx_XFRCNT register */
-#define XFRCNT_MTC_MASK	0x07
-
-/* IICx_XTCNTLSS register */
-#define XTCNTLSS_SRC	0x80
-#define XTCNTLSS_SRS	0x40
-#define XTCNTLSS_SWC	0x20
-#define XTCNTLSS_SWS	0x10
-#define XTCNTLSS_SRST	0x01
-
-/* IICx_DIRECTCNTL register */
-#define DIRCNTL_SDAC	0x08
-#define DIRCNTL_SCC	0x04
-#define DIRCNTL_MSDA	0x02
-#define DIRCNTL_MSC	0x01
-
-/* Check if we really control the I2C bus and bus is free */
-#define DIRCTNL_FREE(v)	(((v) & 0x0f) = 0x0f)
-
-#endif /* __I2C_IBM_IIC_H_ */
diff -Nru a/drivers/i2c/i2c-iop3xx.c b/drivers/i2c/i2c-iop3xx.c
--- a/drivers/i2c/i2c-iop3xx.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,536 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx                */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
- *                      <Peter dot Milne at D hyphen TACQ dot com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation, version 2.
-
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
-/* ------------------------------------------------------------------------- */
-/*
-   With acknowledgements to i2c-algo-ibm_ocp.c by 
-   Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
-
-   And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglund:
-
-     Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
-   
-   And which acknowledged Ky?sti M?lkki <kmalkki@cc.hut.fi>,
-   Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.com>
-
-  ---------------------------------------------------------------------------*/
-
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/i2c.h>
-
-
-#include <asm/arch-iop3xx/iop321.h>
-#include <asm/arch-iop3xx/iop321-irqs.h>
-#include "i2c-iop3xx.h"
-
-
-/* ----- global defines ----------------------------------------------- */
-#define PASSERT(x) do { if (!(x) ) \
-		printk(KERN_CRIT "PASSERT %s in %s:%d\n", #x, __FILE__, __LINE__ );\
-	} while (0)
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-
-static inline unsigned char iic_cook_addr(struct i2c_msg *msg) 
-{
-	unsigned char addr;
-
-	addr = (msg->addr << 1);
-
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
-
-	/* PGM: what is M_REV_DIR_ADDR - do we need it ?? */
-	if (msg->flags & I2C_M_REV_DIR_ADDR)
-		addr ^= 1;
-
-	return addr;   
-}
-
-
-static inline void iop3xx_adap_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	/* Follows devman 9.3 */
-	*iop3xx_adap->biu->CR = IOP321_ICR_UNIT_RESET;
-	*iop3xx_adap->biu->SR = IOP321_ISR_CLEARBITS;
-	*iop3xx_adap->biu->CR = 0;
-} 
-
-static inline void iop3xx_adap_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	*iop3xx_adap->biu->SAR = MYSAR;
-}
-
-static inline void iop3xx_adap_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	u32 cr = IOP321_ICR_GCD|IOP321_ICR_SCLEN|IOP321_ICR_UE;
-
-	/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->biu->SR_enabled = 
-		IOP321_ISR_ALD | IOP321_ISR_BERRD |
-		IOP321_ISR_RXFULL | IOP321_ISR_TXEMPTY;
-
-	cr |= IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE;
-
-	*iop3xx_adap->biu->CR = cr;
-}
-
-static void iop3xx_adap_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	
-	cr &= ~(IOP321_ICR_MSTART | IOP321_ICR_TBYTE | 
-		IOP321_ICR_MSTOP | IOP321_ICR_SCLEN);
-	*iop3xx_adap->biu->CR = cr;
-}
-
-static void iop3xx_adap_final_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	
-	cr &= ~(IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE);
-	iop3xx_adap->biu->SR_enabled = 0;
-	*iop3xx_adap->biu->CR = cr;
-}
-
-/* 
- * NB: the handler has to clear the source of the interrupt! 
- * Then it passes the SR flags of interest to BH via adap data
- */
-static void iop3xx_i2c_handler(int this_irq, 
-				void *dev_id, 
-				struct pt_regs *regs) 
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = dev_id;
-
-	u32 sr = *iop3xx_adap->biu->SR;
-
-	if ((sr &= iop3xx_adap->biu->SR_enabled)) {
-		*iop3xx_adap->biu->SR = sr;
-		iop3xx_adap->biu->SR_received |= sr;
-		wake_up_interruptible(&iop3xx_adap->waitq);
-	}
-}
-
-/* check all error conditions, clear them , report most important */
-static int iop3xx_adap_error(u32 sr)
-{
-	int rc = 0;
-
-	if ((sr&IOP321_ISR_BERRD)) {
-		if ( !rc ) rc = -I2C_ERR_BERR;
-	}
-	if ((sr&IOP321_ISR_ALD)) {
-		if ( !rc ) rc = -I2C_ERR_ALD;		
-	}
-	return rc;	
-}
-
-static inline u32 get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	unsigned long flags;
-	u32 sr;
-
-	spin_lock_irqsave(&iop3xx_adap->lock, flags);
-	sr = iop3xx_adap->biu->SR_received;
-	iop3xx_adap->biu->SR_received = 0;
-	spin_unlock_irqrestore(&iop3xx_adap->lock, flags);
-
-	return sr;
-}
-
-/*
- * sleep until interrupted, then recover and analyse the SR
- * saved by handler
- */
-typedef int (* compare_func)(unsigned test, unsigned mask);
-/* returns 1 on correct comparison */
-
-static int iop3xx_adap_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap, 
-				  unsigned flags, unsigned* status,
-				  compare_func compare)
-{
-	unsigned sr = 0;
-	int interrupted;
-	int done;
-	int rc;
-
-	do {
-		interrupted = wait_event_interruptible_timeout (
-			iop3xx_adap->waitq,
-			(done = compare( sr = get_srstat(iop3xx_adap),flags )),
-			iop3xx_adap->timeout
-			);
-		if ((rc = iop3xx_adap_error(sr)) < 0) {
-			*status = sr;
-			return rc;
-		}else if (!interrupted) {
-			*status = sr;
-			return rc = -ETIMEDOUT;
-		}
-	} while(!done);
-
-	*status = sr;
-
-	return rc = 0;
-}
-
-/*
- * Concrete compare_funcs 
- */
-static int all_bits_clear(unsigned test, unsigned mask)
-{
-	return (test & mask) = 0;
-}
-static int any_bits_set(unsigned test, unsigned mask)
-{
-	return (test & mask) != 0;
-}
-
-static int iop3xx_adap_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event( 
-		iop3xx_adap, 
-	        IOP321_ISR_TXEMPTY|IOP321_ISR_ALD|IOP321_ISR_BERRD,
-		status, any_bits_set);
-}
-
-static int iop3xx_adap_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event( 
-		iop3xx_adap, 
-		IOP321_ISR_RXFULL|IOP321_ISR_ALD|IOP321_ISR_BERRD,
-		status,	any_bits_set);
-}
-
-static int iop3xx_adap_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
-{
-	return iop3xx_adap_wait_event( 
-		iop3xx_adap, IOP321_ISR_UNITBUSY, status, all_bits_clear);
-}
-
-/*
- * Description: This performs the IOP3xx initialization sequence
- * Valid for IOP321. Maybe valid for IOP310?.
- */
-static int iop3xx_adap_init (struct i2c_algo_iop3xx_data *iop3xx_adap)
-{
-	*IOP321_GPOD &= ~(iop3xx_adap->channel=0 ?
-			  IOP321_GPOD_I2C0:
-			  IOP321_GPOD_I2C1);
-
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_set_slave_addr(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
-	
-        return 0;
-}
-
-static int iop3xx_adap_send_target_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
-					      struct i2c_msg* msg)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	*iop3xx_adap->biu->DBR = iic_cook_addr(msg);
-	
-	cr &= ~(IOP321_ICR_MSTOP | IOP321_ICR_NACK);
-	cr |= IOP321_ICR_MSTART | IOP321_ICR_TBYTE;
-
-	*iop3xx_adap->biu->CR = cr;
-	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
-	/* this assert fires every time, contrary to IOP manual	
-	PASSERT((status&IOP321_ISR_UNITBUSY)!=0);
-	*/
-	PASSERT((status&IOP321_ISR_RXREAD)=0);
-	     
-	return rc;
-}
-
-static int iop3xx_adap_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte, int stop)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	*iop3xx_adap->biu->DBR = byte;
-	cr &= ~IOP321_ICR_MSTART;
-	if (stop) {
-		cr |= IOP321_ICR_MSTOP;
-	} else {
-		cr &= ~IOP321_ICR_MSTOP;
-	}
-	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
-	rc = iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
-
-	return rc;
-} 
-
-static int iop3xx_adap_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap,
-				 char* byte, int stop)
-{
-	unsigned cr = *iop3xx_adap->biu->CR;
-	int status;
-	int rc;
-
-	cr &= ~IOP321_ICR_MSTART;
-
-	if (stop) {
-		cr |= IOP321_ICR_MSTOP|IOP321_ICR_NACK;
-	} else {
-		cr &= ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
-	}
-	*iop3xx_adap->biu->CR = cr |= IOP321_ICR_TBYTE;
-
-	rc = iop3xx_adap_wait_rx_done(iop3xx_adap, &status);
-
-	*byte = *iop3xx_adap->biu->DBR;
-
-	return rc;
-}
-
-static int iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, 
-				 const char *buf, int count)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
-	int ii;
-	int rc = 0;
-
-	for (ii = 0; rc = 0 && ii != count; ++ii) {
-		rc = iop3xx_adap_write_byte(iop3xx_adap, buf[ii], ii=count-1);
-	}
-	return rc;
-}
-
-static int iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, 
-				char *buf, int count)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
-	int ii;
-	int rc = 0;
-
-	for (ii = 0; rc = 0 && ii != count; ++ii) {
-		rc = iop3xx_adap_read_byte(iop3xx_adap, &buf[ii], ii=count-1);
-	}
-	return rc;
-}
-
-/*
- * Description:  This function implements combined transactions.  Combined
- * transactions consist of combinations of reading and writing blocks of data.
- * FROM THE SAME ADDRESS
- * Each transfer (i.e. a read or a write) is separated by a repeated start
- * condition.
- */
-static int iop3xx_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) 
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
-	int rc;
-
-	rc = iop3xx_adap_send_target_slave_addr(iop3xx_adap, pmsg);
-	if (rc < 0) {
-		return rc;
-	}
-
-	if ((pmsg->flags&I2C_M_RD)) {
-		return iop3xx_i2c_readbytes(i2c_adap, pmsg->buf, pmsg->len);
-	} else {
-		return iop3xx_i2c_writebytes(i2c_adap, pmsg->buf, pmsg->len);
-	}
-}
-
-/*
- * master_xfer() - main read/write entry
- */
-static int iop3xx_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
-	int im = 0;
-	int ret = 0;
-	int status;
-
-	iop3xx_adap_wait_idle(iop3xx_adap, &status);
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
-
-	for (im = 0; ret = 0 && im != num; ++im) {
-		ret = iop3xx_handle_msg(i2c_adap, &msgs[im]);
-	}
-
-	iop3xx_adap_transaction_cleanup(iop3xx_adap);
-
-	return ret;   
-}
-
-static int algo_control(struct i2c_adapter *adapter, unsigned int cmd,
-			unsigned long arg)
-{
-	return 0;
-}
-
-static u32 iic_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
-}
-
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo = {
-	.name		= "IOP3xx I2C algorithm",
-	.id		= I2C_ALGO_OCP_IOP3XX,
-	.master_xfer	= iop3xx_master_xfer,
-	.algo_control	= algo_control,
-	.functionality	= iic_func,
-};
-
-/* 
- * registering functions to load algorithms at runtime 
- */
-static int i2c_iop3xx_add_bus(struct i2c_adapter *iic_adap)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
-
-	if (!request_region( REGION_START(iop3xx_adap), 
-			      REGION_LENGTH(iop3xx_adap),
-			      iic_adap->name)) {
-		return -ENODEV;
-	}
-
-	init_waitqueue_head(&iop3xx_adap->waitq);
-	spin_lock_init(&iop3xx_adap->lock);
-
-	if (request_irq( 
-		     iop3xx_adap->biu->irq,
-		     iop3xx_i2c_handler,
-		     /* SA_SAMPLE_RANDOM */ 0,
-		     iic_adap->name,
-		     iop3xx_adap)) {
-		return -ENODEV;
-	}			  
-
-	/* register new iic_adapter to i2c module... */
-	iic_adap->id |= iic_algo.id;
-	iic_adap->algo = &iic_algo;
-
-	iic_adap->timeout = 100;	/* default values, should */
-	iic_adap->retries = 3;		/* be replaced by defines */
-
-	iop3xx_adap_init(iic_adap->algo_data);
-	i2c_add_adapter(iic_adap);
-	return 0;
-}
-
-static int i2c_iop3xx_del_bus(struct i2c_adapter *iic_adap)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap = iic_adap->algo_data;
-
-	iop3xx_adap_final_cleanup(iop3xx_adap);
-	free_irq(iop3xx_adap->biu->irq, iop3xx_adap);
-
-	release_region(REGION_START(iop3xx_adap), REGION_LENGTH(iop3xx_adap));
-
-	return i2c_del_adapter(iic_adap);
-}
-
-#ifdef CONFIG_ARCH_IOP321
-
-static struct iop3xx_biu biu0 = {
-	.CR	= IOP321_ICR0,
-	.SR	= IOP321_ISR0,
-	.SAR	= IOP321_ISAR0,
-	.DBR	= IOP321_IDBR0,
-	.BMR	= IOP321_IBMR0,
-	.irq	= IRQ_IOP321_I2C_0,
-};
-
-static struct iop3xx_biu biu1 = {
-	.CR	= IOP321_ICR1,
-	.SR	= IOP321_ISR1,
-	.SAR	= IOP321_ISAR1,
-	.DBR	= IOP321_IDBR1,
-	.BMR	= IOP321_IBMR1,
-	.irq	= IRQ_IOP321_I2C_1,
-};
-
-#define ADAPTER_NAME_ROOT "IOP321 i2c biu adapter "
-#else
-#error Please define the BIU struct iop3xx_biu for your processor arch
-#endif
-
-static struct i2c_algo_iop3xx_data algo_iop3xx_data0 = {
-	.channel		= 0,
-	.biu			= &biu0,
-	.timeout		= 1*HZ,
-};
-static struct i2c_algo_iop3xx_data algo_iop3xx_data1 = {
-	.channel		= 1,
-	.biu			= &biu1,
-	.timeout		= 1*HZ,
-};
-
-static struct i2c_adapter iop3xx_ops0 = {
-	.owner			= THIS_MODULE,
-	.name			= ADAPTER_NAME_ROOT "0",
-	.id			= I2C_HW_IOP321,
-	.algo_data		= &algo_iop3xx_data0,
-};
-static struct i2c_adapter iop3xx_ops1 = {
-	.owner			= THIS_MODULE,
-	.name			= ADAPTER_NAME_ROOT "1",
-	.id			= I2C_HW_IOP321,
-	.algo_data		= &algo_iop3xx_data1,
-};
-
-static int __init i2c_iop3xx_init (void)
-{
-	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
-		i2c_iop3xx_add_bus(&iop3xx_ops1);
-}
-
-static void __exit i2c_iop3xx_exit (void)
-{
-	i2c_iop3xx_del_bus(&iop3xx_ops0);
-	i2c_iop3xx_del_bus(&iop3xx_ops1);
-}
-
-module_init (i2c_iop3xx_init);
-module_exit (i2c_iop3xx_exit);
-
-MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
-MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(i2c_debug, "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
diff -Nru a/drivers/i2c/i2c-iop3xx.h b/drivers/i2c/i2c-iop3xx.h
--- a/drivers/i2c/i2c-iop3xx.h	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,118 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-iop3xx.h algorithm driver definitions private to i2c-iop3xx.c         */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
- *                      <Peter dot Milne at D hyphen TACQ dot com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation, version 2.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
-/* ------------------------------------------------------------------------- */
-
-
-#ifndef I2C_IOP3XX_H
-#define I2C_IOP3XX_H 1
-
-/*
- * iop321 hardware bit definitions
- */
-#define IOP321_ICR_FAST_MODE	0x8000	/* 1@0kBps, 00kBps */
-#define IOP321_ICR_UNIT_RESET	0x4000	/* 1=RESET */
-#define IOP321_ICR_SADIE	0x2000	/* 1=Slave Detect Interrupt Enable */
-#define IOP321_ICR_ALDIE	0x1000	/* 1=Arb Loss Detect Interrupt Enable */
-#define IOP321_ICR_SSDIE	0x0800	/* 1=Slave STOP Detect Interrupt Enable */
-#define IOP321_ICR_BERRIE	0x0400	/* 1=Bus Error Interrupt Enable */
-#define IOP321_ICR_RXFULLIE	0x0200	/* 1=Receive Full Interrupt Enable */
-#define IOP321_ICR_TXEMPTYIE	0x0100	/* 1=Transmit Empty Interrupt Enable */
-#define IOP321_ICR_GCD		0x0080	/* 1=General Call Disable */
-/*
- * IOP321_ICR_GCD: 1 disables response as slave. "This bit must be set
- * when sending a master mode general call message from the I2C unit"
- */
-#define IOP321_ICR_UE		0x0040	/* 1=Unit Enable */
-/*
- * "NOTE: To avoid I2C bus integrity problems, 
- * the user needs to ensure that the GPIO Output Data Register - 
- * GPOD bits associated with an I2C port are cleared prior to setting 
- * the enable bit for that I2C serial port. 
- * The user prepares to enable I2C port 0 and 
- * I2C port 1 by clearing GPOD bits 7:6 and GPOD bits 5:4, respectively.
- */
-#define IOP321_ICR_SCLEN	0x0020	/* 1=SCL enable for master mode */
-#define IOP321_ICR_MABORT	0x0010	/* 1=Send a STOP with no data 
-					 * NB TBYTE must be clear */
-#define IOP321_ICR_TBYTE	0x0008	/* 1=Send/Receive a byte. i2c clears */
-#define IOP321_ICR_NACK		0x0004	/* 1=reply with NACK */
-#define IOP321_ICR_MSTOP	0x0002	/* 1=send a STOP after next data byte */
-#define IOP321_ICR_MSTART	0x0001	/* 1=initiate a START */
-
-
-#define IOP321_ISR_BERRD	0x0400	/* 1=BUS ERROR Detected */
-#define IOP321_ISR_SAD		0x0200	/* 1=Slave ADdress Detected */
-#define IOP321_ISR_GCAD		0x0100	/* 1=General Call Address Detected */
-#define IOP321_ISR_RXFULL	0x0080	/* 1=Receive Full */
-#define IOP321_ISR_TXEMPTY	0x0040	/* 1=Transmit Empty */
-#define IOP321_ISR_ALD		0x0020	/* 1=Arbitration Loss Detected */
-#define IOP321_ISR_SSD		0x0010	/* 1=Slave STOP Detected */
-#define IOP321_ISR_BBUSY	0x0008	/* 1=Bus BUSY */
-#define IOP321_ISR_UNITBUSY	0x0004	/* 1=Unit Busy */
-#define IOP321_ISR_NACK		0x0002	/* 1=Unit Rx or Tx a NACK */
-#define IOP321_ISR_RXREAD	0x0001	/* 1=READ 0=WRITE (R/W bit of slave addr */
-
-#define IOP321_ISR_CLEARBITS	0x07f0
-
-#define IOP321_ISAR_SAMASK	0x007f
-
-#define IOP321_IDBR_MASK	0x00ff
-
-#define IOP321_IBMR_SCL		0x0002
-#define IOP321_IBMR_SDA		0x0001
-
-#define IOP321_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
-#define IOP321_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
-
-#define MYSAR			0x02	/* SWAG a suitable slave address */
-
-#define I2C_ERR			321
-#define I2C_ERR_BERR		(I2C_ERR+0)
-#define I2C_ERR_ALD		(I2C_ERR+1)
-
-
-struct iop3xx_biu {                /* Bus Interface Unit - the hardware */
-/* physical hardware defs - regs*/
-	u32 *CR;
-	u32 *SR;
-	u32 *SAR;
-	u32 *DBR;
-	u32 *BMR;
-/* irq bit vector */
-	u32 irq;
-/* stored flags */
-	u32 SR_enabled, SR_received;
-};
-
-struct i2c_algo_iop3xx_data {
-	int channel;
-
-	wait_queue_head_t waitq;
-	spinlock_t lock;
-	int timeout;
-	struct iop3xx_biu* biu;
-};
-
-#define REGION_START(adap)	((u32)((adap)->biu->CR))
-#define REGION_END(adap)	((u32)((adap)->biu->BMR+1))
-#define REGION_LENGTH(adap)	(REGION_END(adap)-REGION_START(adap))
-
-#define IRQ_STATUS_MASK(adap)	(1<<adap->biu->irq)
-
-#endif /* I2C_IOP3XX_H */
diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,653 +0,0 @@
-/*
-    i2c Support for Apple Keywest I2C Bus Controller
-
-    Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
-
-    Original work by
-    
-    Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Changes:
-
-    2001/12/13 BenH	New implementation
-    2001/12/15 BenH	Add support for "byte" and "quick"
-                        transfers. Add i2c_xfer routine.
-
-    My understanding of the various modes supported by keywest are:
-
-     - Dumb mode : not implemented, probably direct tweaking of lines
-     - Standard mode : simple i2c transaction of type
-         S Addr R/W A Data A Data ... T
-     - Standard sub mode : combined 8 bit subaddr write with data read
-         S Addr R/W A SubAddr A Data A Data ... T
-     - Combined mode : Subaddress and Data sequences appended with no stop
-         S Addr R/W A SubAddr S Addr R/W A Data A Data ... T
-
-    Currently, this driver uses only Standard mode for i2c xfer, and
-    smbus byte & quick transfers ; and uses StandardSub mode for
-    other smbus transfers instead of combined as we need that for the
-    sound driver to be happy
-*/
-
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-
-#include "i2c-keywest.h"
-
-#define DBG(x...) do {\
-	if (debug > 0) \
-		printk(KERN_DEBUG "KW:" x); \
-	} while(0)
-
-
-MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
-MODULE_LICENSE("GPL");
-MODULE_PARM(probe, "i");
-MODULE_PARM(debug, "i");
-
-int probe = 0;
-int debug = 0;
-
-static void
-do_stop(struct keywest_iface* iface, int result)
-{
-	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_STOP);
-	iface->state = state_stop;
-	iface->result = result;
-}
-
-/* Main state machine for standard & standard sub mode */
-static int
-handle_interrupt(struct keywest_iface *iface, u8 isr)
-{
-	int ack;
-	int rearm_timer = 1;
-	
-	DBG("handle_interrupt(), got: %x, status: %x, state: %d\n",
-		isr, read_reg(reg_status), iface->state);
-	if (isr = 0 && iface->state != state_stop) {
-		do_stop(iface, -1);
-		return rearm_timer;
-	}
-	if (isr & KW_I2C_IRQ_STOP && iface->state != state_stop) {
-		iface->result = -1;
-		iface->state = state_stop;
-	}
-	switch(iface->state) {
-	case state_addr:
-		if (!(isr & KW_I2C_IRQ_ADDR)) {
-			do_stop(iface, -1);
-			break;
-		}
-		ack = read_reg(reg_status);
-		DBG("ack on set address: %x\n", ack);
-		if ((ack & KW_I2C_STAT_LAST_AAK) = 0) {
-			do_stop(iface, -1);
-			break;
-		}
-		/* Handle rw "quick" mode */
-		if (iface->datalen = 0)
-			do_stop(iface, 0);
-		else if (iface->read_write = I2C_SMBUS_READ) {
-			iface->state = state_read;
-			if (iface->datalen > 1)
-				write_reg(reg_control, read_reg(reg_control)
-					| KW_I2C_CTL_AAK);
-		} else {
-			iface->state = state_write;
-			DBG("write byte: %x\n", *(iface->data));
-			write_reg(reg_data, *(iface->data++));
-			iface->datalen--;
-		}
-		
-		break;
-	case state_read:
-		if (!(isr & KW_I2C_IRQ_DATA)) {
-			do_stop(iface, -1);
-			break;
-		}
-		*(iface->data++) = read_reg(reg_data);
-		DBG("read byte: %x\n", *(iface->data-1));
-		iface->datalen--;
-		if (iface->datalen = 0)
-			iface->state = state_stop;
-		else
-			write_reg(reg_control, 0);
-		break;
-	case state_write:
-		if (!(isr & KW_I2C_IRQ_DATA)) {
-			do_stop(iface, -1);
-			break;
-		}
-		/* Check ack status */
-		ack = read_reg(reg_status);
-		DBG("ack on data write: %x\n", ack);
-		if ((ack & KW_I2C_STAT_LAST_AAK) = 0) {
-			do_stop(iface, -1);
-			break;
-		}
-		if (iface->datalen) {
-			DBG("write byte: %x\n", *(iface->data));
-			write_reg(reg_data, *(iface->data++));
-			iface->datalen--;
-		} else
-			do_stop(iface, 0);
-		break;
-		
-	case state_stop:
-		if (!(isr & KW_I2C_IRQ_STOP) && (++iface->stopretry) < 10)
-			do_stop(iface, -1);
-		else {
-			rearm_timer = 0;
-			iface->state = state_idle;
-			write_reg(reg_control, 0x00);
-			write_reg(reg_ier, 0x00);
-			complete(&iface->complete);
-		}
-		break;
-	}
-	
-	write_reg(reg_isr, isr);
-
-	return rearm_timer;
-}
-
-/* Interrupt handler */
-static irqreturn_t
-keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
-
-	spin_lock(&iface->lock);
-	del_timer(&iface->timeout_timer);
-	if (handle_interrupt(iface, read_reg(reg_isr)))
-		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
-	spin_unlock(&iface->lock);
-	return IRQ_HANDLED;
-}
-
-static void
-keywest_timeout(unsigned long data)
-{
-	struct keywest_iface *iface = (struct keywest_iface *)data;
-
-	DBG("timeout !\n");
-	spin_lock_irq(&iface->lock);
-	if (handle_interrupt(iface, read_reg(reg_isr)))
-		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
-	spin_unlock(&iface->lock);
-}
-
-/*
- * SMBUS-type transfer entrypoint
- */
-static s32
-keywest_smbus_xfer(	struct i2c_adapter*	adap,
-			u16			addr,
-			unsigned short		flags,
-			char			read_write,
-			u8			command,
-			int			size,
-			union i2c_smbus_data*	data)
-{
-	struct keywest_chan* chan = i2c_get_adapdata(adap);
-	struct keywest_iface* iface = chan->iface;
-	int len;
-	u8* buffer;
-	u16 cur_word;
-	int rc = 0;
-
-	if (iface->state = state_dead)
-		return -1;
-		
-	/* Prepare datas & select mode */
-	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
-	switch (size) {
-	    case I2C_SMBUS_QUICK:
-	    	len = 0;
-	    	buffer = NULL;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-	    	break;
-	    case I2C_SMBUS_BYTE:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-	    	break;
-	    case I2C_SMBUS_BYTE_DATA:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-	    	break;
-	    case I2C_SMBUS_WORD_DATA:
-	    	len = 2;
-	    	cur_word = cpu_to_le16(data->word);
-	    	buffer = (u8 *)&cur_word;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-		break;
-	    case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-		break;
-	    default:
-	    	return -1;
-	}
-
-	/* Original driver had this limitation */
-	if (len > 32)
-		len = 32;
-
-	down(&iface->sem);
-
-	DBG("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
-		chan->chan_no, addr, len, read_write = I2C_SMBUS_READ);
-
-	iface->data = buffer;
-	iface->datalen = len;
-	iface->state = state_addr;
-	iface->result = 0;
-	iface->stopretry = 0;
-	iface->read_write = read_write;
-	
-	/* Setup channel & clear pending irqs */
-	write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
-	write_reg(reg_isr, read_reg(reg_isr));
-	write_reg(reg_status, 0);
-
-	/* Set up address and r/w bit */
-	write_reg(reg_addr,
-		(addr << 1) | ((read_write = I2C_SMBUS_READ) ? 0x01 : 0x00));
-
-	/* Set up the sub address */
-	if ((iface->cur_mode & KW_I2C_MODE_MODE_MASK) = KW_I2C_MODE_STANDARDSUB
-	    || (iface->cur_mode & KW_I2C_MODE_MODE_MASK) = KW_I2C_MODE_COMBINED)
-		write_reg(reg_subaddr, command);
-
-	/* Arm timeout */
-	mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
-
-	/* Start sending address & enable interrupt*/
-	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
-	write_reg(reg_ier, KW_I2C_IRQ_MASK);
-
-	/* Wait interrupt operations completion */
-	wait_for_completion(&iface->complete);	
-
-	rc = iface->result;	
-	DBG("transfer done, result: %d\n", rc);
-
-	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && read_write = I2C_SMBUS_READ)
-	    	data->word = le16_to_cpu(cur_word);
-	
-	/* Release sem */
-	up(&iface->sem);
-	
-	return rc;
-}
-
-/*
- * Generic i2c master transfer entrypoint
- */
-static int
-keywest_xfer(	struct i2c_adapter *adap,
-		struct i2c_msg msgs[], 
-		int num)
-{
-	struct keywest_chan* chan = i2c_get_adapdata(adap);
-	struct keywest_iface* iface = chan->iface;
-	struct i2c_msg *pmsg;
-	int i, completed;
-	int rc = 0;
-
-	down(&iface->sem);
-
-	/* Set adapter to standard mode */
-	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
-	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-
-	completed = 0;
-	for (i = 0; rc >= 0 && i < num;) {
-		u8 addr;
-		
-		pmsg = &msgs[i++];
-		addr = pmsg->addr;
-		if (pmsg->flags & I2C_M_TEN) {
-			printk(KERN_ERR "i2c-keywest: 10 bits addr not supported !\n");
-			rc = -EINVAL;
-			break;
-		}
-		DBG("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
-		     chan->chan_no,
-		     pmsg->flags & I2C_M_RD ? "read" : "write",
-                     pmsg->len, addr, i, num);
-    
-		/* Setup channel & clear pending irqs */
-		write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
-		write_reg(reg_isr, read_reg(reg_isr));
-		write_reg(reg_status, 0);
-		
-		iface->data = pmsg->buf;
-		iface->datalen = pmsg->len;
-		iface->state = state_addr;
-		iface->result = 0;
-		iface->stopretry = 0;
-		if (pmsg->flags & I2C_M_RD)
-			iface->read_write = I2C_SMBUS_READ;
-		else
-			iface->read_write = I2C_SMBUS_WRITE;
-
-		/* Set up address and r/w bit */
-		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
-			addr ^= 1;		
-		write_reg(reg_addr,
-			(addr << 1) |
-			((iface->read_write = I2C_SMBUS_READ) ? 0x01 : 0x00));
-
-		/* Arm timeout */
-		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
-
-		/* Start sending address & enable interrupt*/
-		write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
-		write_reg(reg_ier, KW_I2C_IRQ_MASK);
-
-		/* Wait interrupt operations completion */
-		wait_for_completion(&iface->complete);	
-
-		rc = iface->result;
-		if (rc = 0)
-			completed++;
-		DBG("transfer done, result: %d\n", rc);
-	}
-
-	/* Release sem */
-	up(&iface->sem);
-
-	return completed;
-}
-
-static u32
-keywest_func(struct i2c_adapter * adapter)
-{
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
-}
-
-/* For now, we only handle combined mode (smbus) */
-static struct i2c_algorithm keywest_algorithm = {
-	.name		= "Keywest i2c",
-	.id		= I2C_ALGO_SMBUS,
-	.smbus_xfer	= keywest_smbus_xfer,
-	.master_xfer	= keywest_xfer,
-	.functionality	= keywest_func,
-};
-
-
-static int
-create_iface(struct device_node *np, struct device *dev)
-{
-	unsigned long steps, *psteps, *prate;
-	unsigned bsteps, tsize, i, nchan, addroffset;
-	struct keywest_iface* iface;
-	int rc;
-
-	psteps = (unsigned long *)get_property(np, "AAPL,address-step", NULL);
-	steps = psteps ? (*psteps) : 0x10;
-
-	/* Hrm... maybe we can be smarter here */
-	for (bsteps = 0; (steps & 0x01) = 0; bsteps++)
-		steps >>= 1;
-
-	if (!strcmp(np->parent->name, "uni-n")) {
-		nchan = 2;
-		addroffset = 3;
-	} else {
-		addroffset = 0;
-		nchan = 1;
-	}
-
-	tsize = sizeof(struct keywest_iface) +
-		(sizeof(struct keywest_chan) + 4) * nchan;
-	iface = (struct keywest_iface *) kmalloc(tsize, GFP_KERNEL);
-	if (iface = NULL) {
-		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
-		return -ENOMEM;
-	}
-	memset(iface, 0, tsize);
-	init_MUTEX(&iface->sem);
-	spin_lock_init(&iface->lock);
-	init_completion(&iface->complete);
-	iface->bsteps = bsteps;
-	iface->chan_count = nchan;
-	iface->state = state_idle;
-	iface->irq = np->intrs[0].line;
-	iface->channels = (struct keywest_chan *)
-		(((unsigned long)(iface + 1) + 3UL) & ~3UL);
-	iface->base = (unsigned long)ioremap(np->addrs[0].address + addroffset,
-						np->addrs[0].size);
-	if (iface->base = 0) {
-		printk(KERN_ERR "i2c-keywest: can't map inteface !\n");
-		kfree(iface);
-		return -ENOMEM;
-	}
-
-	init_timer(&iface->timeout_timer);
-	iface->timeout_timer.function = keywest_timeout;
-	iface->timeout_timer.data = (unsigned long)iface;
-
-	/* Select interface rate */
-	iface->cur_mode = KW_I2C_MODE_100KHZ;
-	prate = (unsigned long *)get_property(np, "AAPL,i2c-rate", NULL);
-	if (prate) switch(*prate) {
-	case 100:
-		iface->cur_mode = KW_I2C_MODE_100KHZ;
-		break;
-	case 50:
-		iface->cur_mode = KW_I2C_MODE_50KHZ;
-		break;
-	case 25:
-		iface->cur_mode = KW_I2C_MODE_25KHZ;
-		break;
-	default:
-		printk(KERN_WARNING "i2c-keywest: unknown rate %ldKhz, using 100KHz\n",
-			*prate);
-	}
-	
-	/* Select standard sub mode */
-	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-	
-	/* Write mode */
-	write_reg(reg_mode, iface->cur_mode);
-	
-	/* Switch interrupts off & clear them*/
-	write_reg(reg_ier, 0x00);
-	write_reg(reg_isr, KW_I2C_IRQ_MASK);
-
-	/* Request chip interrupt */	
-	rc = request_irq(iface->irq, keywest_irq, 0, "keywest i2c", iface);
-	if (rc) {
-		printk(KERN_ERR "i2c-keywest: can't get IRQ %d !\n", iface->irq);
-		iounmap((void *)iface->base);
-		kfree(iface);
-		return -ENODEV;
-	}
-
-	dev_set_drvdata(dev, iface);
-	
-	for (i=0; i<nchan; i++) {
-		struct keywest_chan* chan = &iface->channels[i];
-		u8 addr;
-		
-		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
-		chan->iface = iface;
-		chan->chan_no = i;
-		chan->adapter.id = I2C_ALGO_SMBUS;
-		chan->adapter.algo = &keywest_algorithm;
-		chan->adapter.algo_data = NULL;
-		chan->adapter.client_register = NULL;
-		chan->adapter.client_unregister = NULL;
-		i2c_set_adapdata(&chan->adapter, chan);
-		chan->adapter.dev.parent = dev;
-
-		rc = i2c_add_adapter(&chan->adapter);
-		if (rc) {
-			printk("i2c-keywest.c: Adapter %s registration failed\n",
-				chan->adapter.name);
-			i2c_set_adapdata(&chan->adapter, NULL);
-		}
-		if (probe) {
-			printk("Probe: ");
-			for (addr = 0x00; addr <= 0x7f; addr++) {
-				if (i2c_smbus_xfer(&chan->adapter,addr,
-				    0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
-					printk("%02x ", addr);
-			}
-			printk("\n");
-		}
-	}
-
-	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
-		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);
-		
-	return 0;
-}
-
-static int
-dispose_iface(struct device *dev)
-{
-	struct keywest_iface *iface = dev_get_drvdata(dev);
-	int i, rc;
-	
-	/* Make sure we stop all activity */
-	down(&iface->sem);
-
-	spin_lock_irq(&iface->lock);
-	while (iface->state != state_idle) {
-		spin_unlock_irq(&iface->lock);
-		set_task_state(current,TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/10);
-		spin_lock_irq(&iface->lock);
-	}
-	iface->state = state_dead;
-	spin_unlock_irq(&iface->lock);
-	free_irq(iface->irq, iface);
-	up(&iface->sem);
-
-	/* Release all channels */
-	for (i=0; i<iface->chan_count; i++) {
-		struct keywest_chan* chan = &iface->channels[i];
-		if (i2c_get_adapdata(&chan->adapter) = NULL)
-			continue;
-		rc = i2c_del_adapter(&chan->adapter);
-		i2c_set_adapdata(&chan->adapter, NULL);
-		/* We aren't that prepared to deal with this... */
-		if (rc)
-			printk("i2c-keywest.c: i2c_del_adapter failed, that's bad !\n");
-	}
-	iounmap((void *)iface->base);
-	dev_set_drvdata(dev, NULL);
-	kfree(iface);
-
-	return 0;
-}
-
-static int
-create_iface_macio(struct macio_dev* dev, const struct of_match *match)
-{
-	return create_iface(dev->ofdev.node, &dev->ofdev.dev);
-}
-
-static int
-dispose_iface_macio(struct macio_dev* dev)
-{
-	return dispose_iface(&dev->ofdev.dev);
-}
-
-static int
-create_iface_of_platform(struct of_device* dev, const struct of_match *match)
-{
-	return create_iface(dev->node, &dev->dev);
-}
-
-static int
-dispose_iface_of_platform(struct of_device* dev)
-{
-	return dispose_iface(&dev->dev);
-}
-
-static struct of_match i2c_keywest_match[] = 
-{
-	{
-	.name 		= OF_ANY_MATCH,
-	.type		= "i2c",
-	.compatible	= "keywest"
-	},
-	{},
-};
-
-static struct macio_driver i2c_keywest_macio_driver = 
-{
-	.name 		= "i2c-keywest",
-	.match_table	= i2c_keywest_match,
-	.probe		= create_iface_macio,
-	.remove		= dispose_iface_macio
-};
-
-static struct of_platform_driver i2c_keywest_of_platform_driver = 
-{
-	.name 		= "i2c-keywest",
-	.match_table	= i2c_keywest_match,
-	.probe		= create_iface_of_platform,
-	.remove		= dispose_iface_of_platform
-};
-
-static int __init
-i2c_keywest_init(void)
-{
-	macio_register_driver(&i2c_keywest_macio_driver);
-	of_register_driver(&i2c_keywest_of_platform_driver);
-
-	return 0;
-}
-
-static void __exit
-i2c_keywest_cleanup(void)
-{
-	macio_unregister_driver(&i2c_keywest_macio_driver);
-	of_unregister_driver(&i2c_keywest_of_platform_driver);
-}
-
-module_init(i2c_keywest_init);
-module_exit(i2c_keywest_cleanup);
diff -Nru a/drivers/i2c/i2c-keywest.h b/drivers/i2c/i2c-keywest.h
--- a/drivers/i2c/i2c-keywest.h	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,110 +0,0 @@
-#ifndef __I2C_KEYWEST_H__
-#define __I2C_KEYWEST_H__
-
-/* The Tumbler audio equalizer can be really slow sometimes */
-#define POLL_TIMEOUT		(2*HZ)
-
-/* Register indices */
-typedef enum {
-	reg_mode = 0,
-	reg_control,
-	reg_status,
-	reg_isr,
-	reg_ier,
-	reg_addr,
-	reg_subaddr,
-	reg_data
-} reg_t;
-
-
-/* Mode register */
-#define KW_I2C_MODE_100KHZ	0x00
-#define KW_I2C_MODE_50KHZ	0x01
-#define KW_I2C_MODE_25KHZ	0x02
-#define KW_I2C_MODE_DUMB	0x00
-#define KW_I2C_MODE_STANDARD	0x04
-#define KW_I2C_MODE_STANDARDSUB	0x08
-#define KW_I2C_MODE_COMBINED	0x0C
-#define KW_I2C_MODE_MODE_MASK	0x0C
-#define KW_I2C_MODE_CHAN_MASK	0xF0
-
-/* Control register */
-#define KW_I2C_CTL_AAK		0x01
-#define KW_I2C_CTL_XADDR	0x02
-#define KW_I2C_CTL_STOP		0x04
-#define KW_I2C_CTL_START	0x08
-
-/* Status register */
-#define KW_I2C_STAT_BUSY	0x01
-#define KW_I2C_STAT_LAST_AAK	0x02
-#define KW_I2C_STAT_LAST_RW	0x04
-#define KW_I2C_STAT_SDA		0x08
-#define KW_I2C_STAT_SCL		0x10
-
-/* IER & ISR registers */
-#define KW_I2C_IRQ_DATA		0x01
-#define KW_I2C_IRQ_ADDR		0x02
-#define KW_I2C_IRQ_STOP		0x04
-#define KW_I2C_IRQ_START	0x08
-#define KW_I2C_IRQ_MASK		0x0F
-
-/* Physical interface */
-struct keywest_iface
-{
-	unsigned long		base;
-	unsigned		bsteps;
-	int			irq;
-	struct semaphore	sem;
-	spinlock_t		lock;
-	struct keywest_chan*	channels;
-	unsigned		chan_count;
-	u8			cur_mode;
-	char			read_write;
-	u8*			data;
-	unsigned		datalen;
-	int			state;
-	int			result;
-	int			stopretry;
-	struct timer_list	timeout_timer;
-	struct completion	complete;
-};
-
-enum {
-	state_idle,
-	state_addr,
-	state_read,
-	state_write,
-	state_stop,
-	state_dead
-};
-
-/* Channel on an interface */
-struct keywest_chan
-{
-	struct i2c_adapter	adapter;
-	struct keywest_iface*	iface;
-	unsigned		chan_no;
-};
-
-/* Register access */
-
-static inline u8 __read_reg(struct keywest_iface *iface, reg_t reg)
-{
-	return in_8(((volatile u8 *)iface->base)
-		+ (((unsigned)reg) << iface->bsteps));
-}
-
-static inline void __write_reg(struct keywest_iface *iface, reg_t reg, u8 val)
-{
-	out_8(((volatile u8 *)iface->base)
-		+ (((unsigned)reg) << iface->bsteps), val);
-	(void)__read_reg(iface, reg);
-	udelay(10);
-}
-
-#define write_reg(reg, val)	__write_reg(iface, reg, val) 
-#define read_reg(reg)		__read_reg(iface, reg) 
-
-
-
-#endif /* __I2C_KEYWEST_H__ */
diff -Nru a/drivers/i2c/i2c-rpx.c b/drivers/i2c/i2c-rpx.c
--- a/drivers/i2c/i2c-rpx.c	Mon Sep 22 16:12:05 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,103 +0,0 @@
-/*
- * Embedded Planet RPX Lite MPC8xx CPM I2C interface.
- * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
- *
- * moved into proper i2c interface;
- * Brad Parker (brad@heeltoe.com)
- *
- * RPX lite specific parts of the i2c interface
- * Update:  There actually isn't anything RPXLite-specific about this module.
- * This should work for most any 8xx board.  The console messages have been 
- * changed to eliminate RPXLite references.
- */
-
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/stddef.h>
-#include <linux/parport.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-8xx.h>
-#include <asm/mpc8xx.h>
-#include <asm/commproc.h>
-
-
-static void
-rpx_iic_init(struct i2c_algo_8xx_data *data)
-{
-	volatile cpm8xx_t *cp;
-	volatile immap_t *immap;
-
-	cp = cpmp;	/* Get pointer to Communication Processor */
-	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */
-
-	data->iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
-
-	/* Check for and use a microcode relocation patch.
-	*/
-	if ((data->reloc = data->iip->iic_rpbase))
-		data->iip = (iic_t *)&cp->cp_dpmem[data->iip->iic_rpbase];
-		
-	data->i2c = (i2c8xx_t *)&(immap->im_i2c);
-	data->cp = cp;
-
-	/* Initialize Port B IIC pins.
-	*/
-	cp->cp_pbpar |= 0x00000030;
-	cp->cp_pbdir |= 0x00000030;
-	cp->cp_pbodr |= 0x00000030;
-
-	/* Allocate space for two transmit and two receive buffer
-	 * descriptors in the DP ram.
-	 */
-	data->dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 4);
-
-	/* ptr to i2c area */
-	data->i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
-}
-
-static int rpx_install_isr(int irq, void (*func)(void *, void *), void *data)
-{
-	/* install interrupt handler */
-	cpm_install_handler(irq, (void (*)(void *, struct pt_regs *)) func, data);
-
-	return 0;
-}
-
-static struct i2c_algo_8xx_data rpx_data = {
-	.setisr = rpx_install_isr
-};
-
-static struct i2c_adapter rpx_ops = {
-	.owner		= THIS_MODULE,
-	.name		= "m8xx",
-	.id		= I2C_HW_MPC8XX_EPON,
-	.algo_data	= &rpx_data,
-};
-
-int __init i2c_rpx_init(void)
-{
-	printk("i2c-rpx.o: i2c MPC8xx module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-
-	/* reset hardware to sane state */
-	rpx_iic_init(&rpx_data);
-
-	if (i2c_8xx_add_bus(&rpx_ops) < 0) {
-		printk("i2c-rpx: Unable to register with I2C\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-void __exit i2c_rpx_exit(void)
-{
-	i2c_8xx_del_bus(&rpx_ops);
-}
-
-MODULE_AUTHOR("Dan Malek <dmalek@jlc.net>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for MPC8xx boards");
-
-module_init(i2c_rpx_init);
-module_exit(i2c_rpx_exit);

