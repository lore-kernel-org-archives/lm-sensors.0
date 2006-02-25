From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 25 Feb 2006 20:06:07 +0000
Subject: [lm-sensors] [PATCH] I2C: AT91RM9200 bus driver
Message-Id: <4400B8AF.10605@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1140682926.1877.25.camel@fuzzie.sanpeople.com>
In-Reply-To: <1140682926.1877.25.camel@fuzzie.sanpeople.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Could it please be reviewed for submission to the mainline kernel. 
> Thanks.

Yep I will do the review and when done Jean can push it to mainline.

Please check my comments in the code. Please replace all printk with dev_err etc infrastructure.

One error when nobody replies to smbus write quick should be treated as dev_dbg only so users will
not have a full log of errors when chip drivers are probing empty addresses.

You should also move the hw init just before the i2c_add_adapter.

Regards
Rudolf

> diff -urN linux-2.6.16-rc4.orig/drivers/i2c/busses/Kconfig linux-2.6.16-rc4/drivers/i2c/busses/Kconfig
> --- linux-2.6.16-rc4.orig/drivers/i2c/busses/Kconfig	Mon Feb 20 14:42:16 2006
> +++ linux-2.6.16-rc4/drivers/i2c/busses/Kconfig	Mon Feb 20 14:47:11 2006
> @@ -199,6 +199,13 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-iop3xx.
>  
> +config I2C_AT91
> +	tristate "Atmel AT91RM9200 I2C Two-Wire interface (TWI)"
> +	depends on I2C && ARCH_AT91RM9200
> +	help
> +	  This supports the use of the I2C interface on the Atmel
> +	  AT91RM9200 processor.
> +
>  config I2C_ISA
>  	tristate
>  	depends on I2C
> diff -urN linux-2.6.16-rc4.orig/drivers/i2c/busses/Makefile linux-2.6.16-rc4/drivers/i2c/busses/Makefile
> --- linux-2.6.16-rc4.orig/drivers/i2c/busses/Makefile	Mon Feb 20 14:42:16 2006
> +++ linux-2.6.16-rc4/drivers/i2c/busses/Makefile	Mon Feb 20 14:47:11 2006
> @@ -42,6 +42,7 @@
>  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> +obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o

The rest of file seems to follow alphabetic order, please fix it.

>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff -urN linux-2.6.16-rc4.orig/drivers/i2c/busses/i2c-at91.c linux-2.6.16-rc4/drivers/i2c/busses/i2c-at91.c
> --- linux-2.6.16-rc4.orig/drivers/i2c/busses/i2c-at91.c	Thu Jan  1 02:00:00 1970
> +++ linux-2.6.16-rc4/drivers/i2c/busses/i2c-at91.c	Mon Feb 20 14:47:11 2006
> @@ -0,0 +1,279 @@
> +/*
> +    i2c Support for Atmel's AT91RM9200 Two-Wire Interface
> +
> +    Copyright (C) Rick Bronson

No year?

> +
> +    Borrowed heavily from original work by:
> +    Copyright (C) 2000 Philip Edelbrock <phil at stimpy.netroedge.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/io.h>
> +
> +#include <asm/arch/at91rm9200_twi.h>
> +#include <asm/arch/board.h>
> +
> +#define AT91_TWI_CLOCK		100000
> +#define AT91_TWI_CKDIV1		(2 << 16)	/* TWI clock divider.  NOTE: see Errata #22 */
> +
> +
> +#define DBG(x...) do {\
> +	if (debug > 0) \
> +		printk(KERN_DEBUG "i2c:" x); \
> +	} while(0)
> +

there is infrastructure like dev_warn dev_debug dev_err please follow it.
(take a look to other i2c driver please)

> +static int debug = 0;

DOnt need it

> +
> +
> +static struct clk *twi_clk;
> +
> +/*
> + * Read from a TWI register.
> + */
> +static inline unsigned long at91_twi_read(unsigned int reg)
> +{
> +	void __iomem *twi_base = (void __iomem *)AT91_VA_BASE_TWI;
> +
> +	return __raw_readl(twi_base + reg);
> +}
> +
> +/*
> + * Write to a TWI register.
> + */
> +static inline void at91_twi_write(unsigned int reg, unsigned long value)
> +{
> +	void __iomem *twi_base = (void __iomem *)AT91_VA_BASE_TWI;
> +
> +	__raw_writel(value, twi_base + reg);
> +}
> +
> +static void at91_twi_hwinit(void)
> +{
> +	unsigned int sclock, cldiv2, cldiv3;
> +
> +	at91_twi_write(AT91_TWI_IDR, 0x1ff);		/* Disable all interrupts */
> +	at91_twi_write(AT91_TWI_CR, AT91_TWI_SWRST);	/* Reset peripheral */
> +	at91_twi_write(AT91_TWI_CR, AT91_TWI_MSEN);	/* Set Master mode */
> +
> +	sclock = (10 * clk_get_rate(twi_clk)) / AT91_TWI_CLOCK;
> +	cldiv2 = (sclock / 10) - 5;
> +	if ((sclock % 10) < 5)
> +		cldiv2 -= 1;
> +	cldiv3 = (cldiv2 + (4 - cldiv2 % 4)) >> 2;
> +
> +	/* Here, CKDIV = 1 and CHDIV=CLDIV  => CLDIV = CHDIV = 1/4*((Fmclk/FTWI) -6) */
> +	at91_twi_write(AT91_TWI_CWGR, AT91_TWI_CKDIV1 | cldiv3 | (cldiv3 << 8));
> +}
> +
> +/*
> + * Poll the i2c status register until the specified bit is set.
> + * Returns 0 if timed out (100 msec)
> + */
> +static short at91_poll_status(unsigned long bit)
> +{
> +	int loop_cntr = 10000;
> +
> +	do {
> +		udelay(10);
> +	} while (!(at91_twi_read(AT91_TWI_SR) & bit) && (--loop_cntr > 0));
> +
> +	return (loop_cntr > 0);
> +}
> +
> +/*
> + * Generic i2c master transfer entrypoint
> + */
> +static int at91_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +	struct i2c_msg *pmsg;
> +	int length;
> +	unsigned char *buf;
> +	int i;
> +
> +	DBG("at91_xfer: processing %d messages:\n", num);

dev_dbg

> +
> +	pmsg = msgs;		/* get 1st message */
> +
> +	for (i = 0; i < num; i++) {
> +		DBG(" #%d: %sing %d byte%s %s 0x%02x ...", i,
> +			pmsg->flags & I2C_M_RD ? "read" : "write",
> +			pmsg->len, pmsg->len > 1 ? "s" : "",
> +			pmsg->flags & I2C_M_RD ? "from" : "to",	pmsg->addr);
> +
here too
> +		/*
> +		 * Set the TWI Master Mode Register:
> +		 *  We do _not_ use Atmel's feature of storing the "internal device address"
> +		 *  in TWI_IADR. Thus the IADRSZ bits in TWI_MMR are set to zero.
> +		 *  Instead the "internal device address" has to be written using a seperate
> +		 *  i2c message.
> +		 *  See http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-September/024411.html
> +		 */
> +		at91_twi_write(AT91_TWI_MMR, (pmsg->addr << 16) | (pmsg->flags & I2C_M_RD ? AT91_TWI_MREAD : 0));
> +
> +		length = pmsg->len;
> +		buf = pmsg->buf;
> +		if (length && buf) {	/* sanity check */
> +			if (pmsg->flags & I2C_M_RD) {
> +				at91_twi_write(AT91_TWI_CR, AT91_TWI_START);
> +				while (length--) {
> +					if (!length)
> +						at91_twi_write(AT91_TWI_CR, AT91_TWI_STOP);
> +					/* Wait until transfer is finished */
> +					if (!at91_poll_status(AT91_TWI_RXRDY)) {
> +						printk(KERN_ERR "at91_i2c: timeout 1\n");
> +						return 0;
And also -1 should be signaled as error + dev_err
> +					}
> +					*buf++ = (at91_twi_read(AT91_TWI_RHR) & 0xff);
> +				}
> +				if (!at91_poll_status(AT91_TWI_TXCOMP)) {
> +					printk(KERN_ERR "at91_i2c: timeout 2\n");
> +					return 0;
-1 and dev_err
> +				}
> +			} else {
> +				at91_twi_write(AT91_TWI_CR, AT91_TWI_START);
> +				while (length--) {
> +					at91_twi_write(AT91_TWI_THR, *buf++);
> +					if (!length)
> +						at91_twi_write(AT91_TWI_CR, AT91_TWI_STOP);
> +					if (!at91_poll_status(AT91_TWI_TXRDY)) {
> +						printk(KERN_ERR "at91_i2c: timeout 3\n");
dev_err or dev_dbg it depends on situation. If there is no device on requested address this error
should not be displeayed as dev_err but as dev_dbg (so people dont panic when the chip drivers is looking
for the chip on empty adresses when their are checking the logs. the detection is done via A Addr Rd/Wr [A] P

> +						return 0;
and -1
> +					}
> +				}
> +				/* Wait until transfer is finished */
> +				if (!at91_poll_status(AT91_TWI_TXCOMP)) {
> +					printk(KERN_ERR "at91_i2c: timeout 4\n");
> +					return 0;
dev_err and -1
> +				}
> +			}
> +		}
> +		DBG("ok\n");
> +		pmsg++;	/* go to next message */
> +	}
> +	return i;
> +}
> +
> +/*
> + * Return list of supported functionality
> + */
> +static u32 at91_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +/* For now, we only handle combined mode (smbus) */
> +static struct i2c_algorithm at91_algorithm = {
> +	.master_xfer	= at91_xfer,
> +	.functionality	= at91_func,
> +};
> +
> +/*
> + * Main initialization routine
> + */
> +static int __init at91_i2c_probe(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter;
> +	int rc;
> +
> +	twi_clk = clk_get(NULL, "twi_clk");
> +	if (!twi_clk) {
> +		printk(KERN_ERR "at91_i2c: no clock defined\n");
dev_err
> +		return -ENODEV;
> +	}
> +	clk_enable(twi_clk);			/* enable peripheral clock */
> +
> +	at91_twi_hwinit();			/* initialize TWI controller */

move it down

> +
> +	adapter = kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> +	if (adapter = NULL) {
> +		printk(KERN_ERR "at91_i2c: can't allocate inteface!\n");
dev_err
> +		return -ENOMEM;
If the HW init is not called you can quit like this. Otherwise not.
> +	}
> +	memset(adapter, 0, sizeof(struct i2c_adapter));
> +

 kzalloc can do that.

> +	sprintf(adapter->name, "AT91RM9200");
> +	adapter->algo = &at91_algorithm;
> +	adapter->algo_data = NULL;
> +	adapter->client_register = NULL;
> +	adapter->client_unregister = NULL;
> +	adapter->class = I2C_CLASS_HWMON;
>
So this NULL are zeros.....

> +	platform_set_drvdata(pdev, adapter);
> +


Here should be HW init called

> +	rc = i2c_add_adapter(adapter);
> +	if (rc) {
> +		printk(KERN_ERR "at91_i2c: Adapter %s registration failed\n", adapter->name);
> +		kfree(adapter);
dev_err

and HW deinit
> +	}
> +	else
> +		printk(KERN_INFO "AT91 i2c bus driver.\n");
dev_info
> +
> +	return rc;
> +}
> +
> +static int __devexit at91_i2c_remove(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
> +	int res;
> +
> +	res = i2c_del_adapter(adapter);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	clk_disable(twi_clk);					/* disable peripheral clock */
> +	clk_put(twi_clk);
> +
> +	return res;
> +}
> +
> +static struct platform_driver at91_i2c_driver = {
> +	.probe		= at91_i2c_probe,
> +	.remove		= at91_i2c_remove,
> +	.driver		= {
> +		.name	= "at91_i2c",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init at91_i2c_init(void)
> +{
> +	return platform_driver_register(&at91_i2c_driver);
> +}
> +
> +static void __exit at91_i2c_exit(void)
> +{
> +	platform_driver_unregister(&at91_i2c_driver);
> +}
> +
> +
> +module_init(at91_i2c_init);
> +module_exit(at91_i2c_exit);
> +
> +MODULE_AUTHOR("Rick Bronson");
> +MODULE_DESCRIPTION("I2C driver for Atmel AT91RM9200");
> +MODULE_LICENSE("GPL");
> diff -urN linux-2.6.16-rc4.orig/include/asm-arm/arch-at91rm9200/at91rm9200_twi.h linux-2.6.16-rc4/include/asm-arm/arch-at91rm9200/at91rm9200_twi.h
> --- linux-2.6.16-rc4.orig/include/asm-arm/arch-at91rm9200/at91rm9200_twi.h	Thu Jan  1 02:00:00 1970
> +++ linux-2.6.16-rc4/include/asm-arm/arch-at91rm9200/at91rm9200_twi.h	Mon Feb 20 14:47:11 2006
> @@ -0,0 +1,57 @@
> +/*
> + * include/asm-arm/arch-at91rm9200/at91rm9200_twi.h
> + *
> + * Copyright (C) 2005 Ivan Kokshaysky
> + * Copyright (C) SAN People
> + *
> + * Two-wire Interface (TWI) registers.
> + * Based on AT91RM9200 datasheet revision E.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef AT91RM9200_TWI_H
> +#define AT91RM9200_TWI_H
> +
> +#define	AT91_TWI_CR		0x00		/* Control Register */
> +#define		AT91_TWI_START		(1 <<  0)	/* Send a Start Condition */
> +#define		AT91_TWI_STOP		(1 <<  1)	/* Send a Stop Condition */
> +#define		AT91_TWI_MSEN		(1 <<  2)	/* Master Transfer Enable */
> +#define		AT91_TWI_MSDIS		(1 <<  3)	/* Master Transfer Disable */
> +#define		AT91_TWI_SWRST		(1 <<  7)	/* Software Reset */
> +
> +#define	AT91_TWI_MMR		0x04		/* Master Mode Register */
> +#define		AT91_TWI_IADRSZ		(3    <<  8)	/* Internal Device Address Size */
> +#define			AT91_TWI_IADRSZ_NO		(0 << 8)
> +#define			AT91_TWI_IADRSZ_1		(1 << 8)
> +#define			AT91_TWI_IADRSZ_2		(2 << 8)
> +#define			AT91_TWI_IADRSZ_3		(3 << 8)
> +#define		AT91_TWI_MREAD		(1    << 12)	/* Master Read Direction */
> +#define		AT91_TWI_DADR		(0x7f << 16)	/* Device Address */
> +
> +#define	AT91_TWI_IADR		0x0c		/* Internal Address Register */
> +
> +#define	AT91_TWI_CWGR		0x10		/* Clock Waveform Generator Register */
> +#define		AT91_TWI_CLDIV		(0xff <<  0)	/* Clock Low Divisor */
> +#define		AT91_TWI_CHDIV		(0xff <<  8)	/* Clock High Divisor */
> +#define		AT91_TWI_CKDIV		(7    << 16)	/* Clock Divider */
> +
> +#define	AT91_TWI_SR		0x20		/* Status Register */
> +#define		AT91_TWI_TXCOMP		(1 <<  0)	/* Transmission Complete */
> +#define		AT91_TWI_RXRDY		(1 <<  1)	/* Receive Holding Register Ready */
> +#define		AT91_TWI_TXRDY		(1 <<  2)	/* Transmit Holding Register Ready */
> +#define		AT91_TWI_OVRE		(1 <<  6)	/* Overrun Error */
> +#define		AT91_TWI_UNRE		(1 <<  7)	/* Underrun Error */
> +#define		AT91_TWI_NACK		(1 <<  8)	/* Not Acknowledged */
> +
> +#define	AT91_TWI_IER		0x24		/* Interrupt Enable Register */
> +#define	AT91_TWI_IDR		0x28		/* Interrupt Disable Register */
> +#define	AT91_TWI_IMR		0x2c		/* Interrupt Mask Register */
> +#define	AT91_TWI_RHR		0x30		/* Receive Holding Register */
> +#define	AT91_TWI_THR		0x34		/* Transmit Holding Register */
> +
> +#endif
> +
> 
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

