From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] Update IOP3xx I2C bus driver
Message-Id: <20050104195023.GA9225@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Greg,

The following patch is a major cleanup of the IOP3xx I2C bus driver
that is found on Intel's IOP and IXP chipsets. The existing driver in
the 2.6 tree uses hardcoded I/O addresses based on board configuration=20
which is just going to get ugly as more chips use this unit. The update
switches to using the driver model and passing in the I/O addresses
via platform_device resources. The patch also updates the ID name to=20
more closely match the actual usage of the device. =20

I have tested this new driver on IXP46x systems and Dave Jiang has
tested it on both IOP321 and IOP331 systems. ARM-specific patches
to provide platform-level hooks will go upstream after this patch
is integrated.

An example of using the new driver (from IXP46x ARM code) follows:

static struct resource ixp46x_i2c_resources[] =3D {
	[0] =3D {
		.start 	=3D 0xc8011000,
		.end	=3D 0xc801101c,
		.flags	=3D IORESOURCE_MEM,
	},
	[1] =3D {
		.start 	=3D IRQ_IXP4XX_I2C,
		.end	=3D IRQ_IXP4XX_I2C,
		.flags	=3D IORESOURCE_IRQ
	}
};

static struct platform_device ixp46x_i2c_controller =3D {
	.name		=3D "IOP3xx-I2C",
	.id		=3D 0,
	.num_resources	=3D 2,
	.resource	=3D &ixp46x_i2c_resources
};

static struct platform_device *ixp46x_devices[] __initdata =3D {
	&ixp46x_i2c_controller
};

void __init ixp4xx_init(void)
{
	if (cpu_is_ixp46x()) {
		platform_add_devices(ixp46x_devices,=20
				ARRAY_SIZE(ixp46x_devices));
	}
}

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

=3D=3D=3D drivers/i2c/busses/Kconfig 1.61 vs edited =3D=3D--- 1.61/drivers/=
i2c/busses/Kconfig	2004-11-08 16:49:49 -08:00
+++ edited/drivers/i2c/busses/Kconfig	2004-12-17 02:34:42 -08:00
@@ -143,8 +143,14 @@
 	  will be called i2c-ibm_iic.
=20
 config I2C_IOP3XX
-	tristate "Intel XScale IOP3xx on-chip I2C interface"
-	depends on ARCH_IOP3XX && I2C
+	tristate "Intel IOP3xx and IXP4xx on-chip I2C interface"
+	depends on (ARCH_IOP3XX || ARCH_IXP4XX) && I2C
+	help
+	  Say Y here if you want to use the IIC bus controller on
+	  the Intel IOP3xx I/O Processors or IXP4xx Network Processors.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-iop3xx.
=20
 config I2C_ISA
 	tristate "ISA Bus support"
=3D=3D=3D drivers/i2c/busses/i2c-iop3xx.c 1.6 vs edited =3D=3D--- 1.6/drive=
rs/i2c/busses/i2c-iop3xx.c	2004-03-15 02:25:23 -08:00
+++ edited/drivers/i2c/busses/i2c-iop3xx.c	2005-01-04 11:05:32 -08:00
@@ -1,35 +1,30 @@
 /* -----------------------------------------------------------------------=
-- */
-/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx             =
   */
+/* i2c-iop3xx.c i2c driver algorithms for Intel XScale IOP3xx & IXP46x    =
   */
 /* -----------------------------------------------------------------------=
-- */
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
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.             =
   */
-/* -----------------------------------------------------------------------=
-- */
-/*
-   With acknowledgements to i2c-algo-ibm_ocp.c by=20
-   Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
-
-   And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglun=
d:
-
-     Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
-  =20
-   And which acknowledged Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>,
-   Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.c=
om>
-
-  ------------------------------------------------------------------------=
---*/
+/* Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
+ *                    <Peter dot Milne at D hyphen TACQ dot com>
+ *
+ * With acknowledgements to i2c-algo-ibm_ocp.c by=20
+ * Ian DaSilva, MontaVista Software, Inc. idasilva@mvista.com
+ *
+ * And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Berglun=
d:
+ *
+ * Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
+ * =20
+ * And which acknowledged Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>,
+ * Frodo Looijaard <frodol@dds.nl>, Martin Bailey<mbailey@littlefeet-inc.c=
om>
+ *
+ * Major cleanup by Deepak Saxena <dsaxena@plexity.net>, 01/2005:
+ *
+ * - Use driver model to pass per-chip info instead of hardcoding and #ifd=
efs
+ * - Use ioremap/__raw_readl/__raw_writel instead of direct dereference
+ * - Make it work with IXP46x chips
+ * - Cleanup function names, coding style, etc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2.
+ */
=20
 #include <linux/config.h>
 #include <linux/interrupt.h>
@@ -40,24 +35,18 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/i2c.h>
=20
+#include <asm/io.h>
=20
-#include <asm/arch-iop3xx/iop321.h>
-#include <asm/arch-iop3xx/iop321-irqs.h>
 #include "i2c-iop3xx.h"
=20
+/* global unit counter */
+static int i2c_id =3D 0;
=20
-/* ----- global defines ----------------------------------------------- */
-#define PASSERT(x) do { if (!(x) ) \
-		printk(KERN_CRIT "PASSERT %s in %s:%d\n", #x, __FILE__, __LINE__ );\
-	} while (0)
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-
-static inline unsigned char iic_cook_addr(struct i2c_msg *msg)=20
+static inline unsigned char=20
+iic_cook_addr(struct i2c_msg *msg)=20
 {
 	unsigned char addr;
=20
@@ -66,103 +55,110 @@
 	if (msg->flags & I2C_M_RD)
 		addr |=3D 1;
=20
-	/* PGM: what is M_REV_DIR_ADDR - do we need it ?? */
+	/*
+	 * Read or Write?
+	 */
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^=3D 1;
=20
 	return addr;  =20
 }
=20
-
-static inline void iop3xx_adap_reset(struct i2c_algo_iop3xx_data *iop3xx_a=
dap)
+static void=20
+iop3xx_i2c_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	/* Follows devman 9.3 */
-	*iop3xx_adap->biu->CR =3D IOP321_ICR_UNIT_RESET;
-	*iop3xx_adap->biu->SR =3D IOP321_ISR_CLEARBITS;
-	*iop3xx_adap->biu->CR =3D 0;
+	__raw_writel(IOP3XX_ICR_UNIT_RESET, iop3xx_adap->ioaddr + CR_OFFSET);
+	__raw_writel(IOP3XX_ISR_CLEARBITS, iop3xx_adap->ioaddr + SR_OFFSET);
+	__raw_writel(0, iop3xx_adap->ioaddr + CR_OFFSET);
 }=20
=20
-static inline void iop3xx_adap_set_slave_addr(struct i2c_algo_iop3xx_data =
*iop3xx_adap)
+static void=20
+iop3xx_i2c_set_slave_addr(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	*iop3xx_adap->biu->SAR =3D MYSAR;
+	__raw_writel(MYSAR, iop3xx_adap->ioaddr + SAR_OFFSET);
 }
=20
-static inline void iop3xx_adap_enable(struct i2c_algo_iop3xx_data *iop3xx_=
adap)
+static void=20
+iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	u32 cr =3D IOP321_ICR_GCD|IOP321_ICR_SCLEN|IOP321_ICR_UE;
+	u32 cr =3D IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
=20
+	/*=20
+	 * Everytime unit enable is asserted, GPOD needs to be cleared
+	 * on IOP321 to avoid data corruption on the bus.
+	 */
+#ifdef CONFIG_ARCH_IOP321
+#define IOP321_GPOD_I2C0    0x00c0  /* clear these bits to enable ch0 */
+#define IOP321_GPOD_I2C1    0x0030  /* clear these bits to enable ch1 */
+
+	*IOP321_GPOD &=3D (iop3xx_adap->id =3D 0) ? ~IOP321_GPOD_I2C0 :=20
+		~IOP321_GPOD_I2C1;
+#endif
 	/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->biu->SR_enabled =3D=20
-		IOP321_ISR_ALD | IOP321_ISR_BERRD |
-		IOP321_ISR_RXFULL | IOP321_ISR_TXEMPTY;
+	iop3xx_adap->SR_enabled =3D=20
+		IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD |
+		IOP3XX_ISR_RXFULL | IOP3XX_ISR_TXEMPTY;
=20
-	cr |=3D IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE;
+	cr |=3D IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE;
=20
-	*iop3xx_adap->biu->CR =3D cr;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
=20
-static void iop3xx_adap_transaction_cleanup(struct i2c_algo_iop3xx_data *i=
op3xx_adap)
+static void=20
+iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
-	unsigned cr =3D *iop3xx_adap->biu->CR;
+	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 =09
-	cr &=3D ~(IOP321_ICR_MSTART | IOP321_ICR_TBYTE |=20
-		IOP321_ICR_MSTOP | IOP321_ICR_SCLEN);
-	*iop3xx_adap->biu->CR =3D cr;
-}
+	cr &=3D ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE |=20
+		IOP3XX_ICR_MSTOP | IOP3XX_ICR_SCLEN);
=20
-static void iop3xx_adap_final_cleanup(struct i2c_algo_iop3xx_data *iop3xx_=
adap)
-{
-	unsigned cr =3D *iop3xx_adap->biu->CR;
-=09
-	cr &=3D ~(IOP321_ICR_ALDIE | IOP321_ICR_BERRIE |
-		IOP321_ICR_RXFULLIE | IOP321_ICR_TXEMPTYIE);
-	iop3xx_adap->biu->SR_enabled =3D 0;
-	*iop3xx_adap->biu->CR =3D cr;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
=20
 /*=20
  * NB: the handler has to clear the source of the interrupt!=20
  * Then it passes the SR flags of interest to BH via adap data
  */
-static irqreturn_t iop3xx_i2c_handler(int this_irq,=20
-				void *dev_id,=20
-				struct pt_regs *regs)=20
+static irqreturn_t=20
+iop3xx_i2c_irq_handler(int this_irq, void *dev_id, struct pt_regs *regs)=20
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D dev_id;
+	u32 sr =3D __raw_readl(iop3xx_adap->ioaddr + SR_OFFSET);
=20
-	u32 sr =3D *iop3xx_adap->biu->SR;
-
-	if ((sr &=3D iop3xx_adap->biu->SR_enabled)) {
-		*iop3xx_adap->biu->SR =3D sr;
-		iop3xx_adap->biu->SR_received |=3D sr;
+	if ((sr &=3D iop3xx_adap->SR_enabled)) {
+		__raw_writel(sr, iop3xx_adap->ioaddr + SR_OFFSET);
+		iop3xx_adap->SR_received |=3D sr;
 		wake_up_interruptible(&iop3xx_adap->waitq);
 	}
 	return IRQ_HANDLED;
 }
=20
 /* check all error conditions, clear them , report most important */
-static int iop3xx_adap_error(u32 sr)
+static int=20
+iop3xx_i2c_error(u32 sr)
 {
 	int rc =3D 0;
=20
-	if ((sr&IOP321_ISR_BERRD)) {
+	if ((sr & IOP3XX_ISR_BERRD)) {
 		if ( !rc ) rc =3D -I2C_ERR_BERR;
 	}
-	if ((sr&IOP321_ISR_ALD)) {
+	if ((sr & IOP3XX_ISR_ALD)) {
 		if ( !rc ) rc =3D -I2C_ERR_ALD;	=09
 	}
 	return rc;=09
 }
=20
-static inline u32 get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
+static inline u32=20
+iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	unsigned long flags;
 	u32 sr;
=20
 	spin_lock_irqsave(&iop3xx_adap->lock, flags);
-	sr =3D iop3xx_adap->biu->SR_received;
-	iop3xx_adap->biu->SR_received =3D 0;
+	sr =3D iop3xx_adap->SR_received;
+	iop3xx_adap->SR_received =3D 0;
 	spin_unlock_irqrestore(&iop3xx_adap->lock, flags);
=20
 	return sr;
@@ -175,9 +171,10 @@
 typedef int (* compare_func)(unsigned test, unsigned mask);
 /* returns 1 on correct comparison */
=20
-static int iop3xx_adap_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap=
,=20
-				  unsigned flags, unsigned* status,
-				  compare_func compare)
+static int=20
+iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,=20
+			  unsigned flags, unsigned* status,
+			  compare_func compare)
 {
 	unsigned sr =3D 0;
 	int interrupted;
@@ -187,13 +184,13 @@
 	do {
 		interrupted =3D wait_event_interruptible_timeout (
 			iop3xx_adap->waitq,
-			(done =3D compare( sr =3D get_srstat(iop3xx_adap),flags )),
-			iop3xx_adap->timeout
+			(done =3D compare( sr =3D iop3xx_i2c_get_srstat(iop3xx_adap)					,flags=
 )),
+			1 * HZ;
 			);
-		if ((rc =3D iop3xx_adap_error(sr)) < 0) {
+		if ((rc =3D iop3xx_i2c_error(sr)) < 0) {
 			*status =3D sr;
 			return rc;
-		}else if (!interrupted) {
+		} else if (!interrupted) {
 			*status =3D sr;
 			return -ETIMEDOUT;
 		}
@@ -207,141 +204,131 @@
 /*
  * Concrete compare_funcs=20
  */
-static int all_bits_clear(unsigned test, unsigned mask)
+static int=20
+all_bits_clear(unsigned test, unsigned mask)
 {
 	return (test & mask) =3D 0;
 }
-static int any_bits_set(unsigned test, unsigned mask)
+
+static int=20
+any_bits_set(unsigned test, unsigned mask)
 {
 	return (test & mask) !=3D 0;
 }
=20
-static int iop3xx_adap_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_ad=
ap, int *status)
+static int=20
+iop3xx_i2c_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *sta=
tus)
 {
-	return iop3xx_adap_wait_event(=20
+	return iop3xx_i2c_wait_event(=20
 		iop3xx_adap,=20
-	        IOP321_ISR_TXEMPTY|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+	        IOP3XX_ISR_TXEMPTY | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status, any_bits_set);
 }
=20
-static int iop3xx_adap_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_ad=
ap, int *status)
+static int=20
+iop3xx_i2c_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int *sta=
tus)
 {
-	return iop3xx_adap_wait_event(=20
+	return iop3xx_i2c_wait_event(=20
 		iop3xx_adap,=20
-		IOP321_ISR_RXFULL|IOP321_ISR_ALD|IOP321_ISR_BERRD,
+		IOP3XX_ISR_RXFULL | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status,	any_bits_set);
 }
=20
-static int iop3xx_adap_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap,=
 int *status)
-{
-	return iop3xx_adap_wait_event(=20
-		iop3xx_adap, IOP321_ISR_UNITBUSY, status, all_bits_clear);
-}
-
-/*
- * Description: This performs the IOP3xx initialization sequence
- * Valid for IOP321. Maybe valid for IOP310?.
- */
-static int iop3xx_adap_init (struct i2c_algo_iop3xx_data *iop3xx_adap)
+static int=20
+iop3xx_i2c_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *status)
 {
-	*IOP321_GPOD &=3D ~(iop3xx_adap->channel=3D0 ?
-			  IOP321_GPOD_I2C0:
-			  IOP321_GPOD_I2C1);
-
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_set_slave_addr(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
-=09
-        return 0;
+	return iop3xx_i2c_wait_event(=20
+		iop3xx_adap, IOP3XX_ISR_UNITBUSY, status, all_bits_clear);
 }
=20
-static int iop3xx_adap_send_target_slave_addr(struct i2c_algo_iop3xx_data =
*iop3xx_adap,
-					      struct i2c_msg* msg)
+static int=20
+iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,=20
+				struct i2c_msg* msg)
 {
-	unsigned cr =3D *iop3xx_adap->biu->CR;
+	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc;
=20
-	*iop3xx_adap->biu->DBR =3D iic_cook_addr(msg);
+	__raw_writel(iic_cook_addr(msg), iop3xx_adap->ioaddr + DBR_OFFSET);
 =09
-	cr &=3D ~(IOP321_ICR_MSTOP | IOP321_ICR_NACK);
-	cr |=3D IOP321_ICR_MSTART | IOP321_ICR_TBYTE;
+	cr &=3D ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
+	cr |=3D IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE;
+
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+	rc =3D iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
=20
-	*iop3xx_adap->biu->CR =3D cr;
-	rc =3D iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
-	/* this assert fires every time, contrary to IOP manual=09
-	PASSERT((status&IOP321_ISR_UNITBUSY)!=3D0);
-	*/
-	PASSERT((status&IOP321_ISR_RXREAD)=3D0);
-	    =20
 	return rc;
 }
=20
-static int iop3xx_adap_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap=
, char byte, int stop)
+static int=20
+iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char byte,=
=20
+				int stop)
 {
-	unsigned cr =3D *iop3xx_adap->biu->CR;
+	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc =3D 0;
=20
-	*iop3xx_adap->biu->DBR =3D byte;
-	cr &=3D ~IOP321_ICR_MSTART;
+	__raw_writel(byte, iop3xx_adap->ioaddr + DBR_OFFSET);
+	cr &=3D ~IOP3XX_ICR_MSTART;
 	if (stop) {
-		cr |=3D IOP321_ICR_MSTOP;
+		cr |=3D IOP3XX_ICR_MSTOP;
 	} else {
-		cr &=3D ~IOP321_ICR_MSTOP;
+		cr &=3D ~IOP3XX_ICR_MSTOP;
 	}
-	*iop3xx_adap->biu->CR =3D cr |=3D IOP321_ICR_TBYTE;
-	rc =3D iop3xx_adap_wait_tx_done(iop3xx_adap, &status);
+	cr |=3D IOP3XX_ICR_TBYTE;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
+	rc =3D iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
=20
 	return rc;
 }=20
=20
-static int iop3xx_adap_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap,
-				 char* byte, int stop)
+static int=20
+iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* byte,=
=20
+				int stop)
 {
-	unsigned cr =3D *iop3xx_adap->biu->CR;
+	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
 	int status;
 	int rc =3D 0;
=20
-	cr &=3D ~IOP321_ICR_MSTART;
+	cr &=3D ~IOP3XX_ICR_MSTART;
=20
 	if (stop) {
-		cr |=3D IOP321_ICR_MSTOP|IOP321_ICR_NACK;
+		cr |=3D IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK;
 	} else {
-		cr &=3D ~(IOP321_ICR_MSTOP|IOP321_ICR_NACK);
+		cr &=3D ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
 	}
-	*iop3xx_adap->biu->CR =3D cr |=3D IOP321_ICR_TBYTE;
+	cr |=3D IOP3XX_ICR_TBYTE;
+	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
=20
-	rc =3D iop3xx_adap_wait_rx_done(iop3xx_adap, &status);
+	rc =3D iop3xx_i2c_wait_rx_done(iop3xx_adap, &status);
=20
-	*byte =3D *iop3xx_adap->biu->DBR;
+	*byte =3D __raw_readl(iop3xx_adap->ioaddr + DBR_OFFSET);
=20
 	return rc;
 }
=20
-static int iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap,=20
-				 const char *buf, int count)
+static int=20
+iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, const char *buf, int c=
ount)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int ii;
 	int rc =3D 0;
=20
-	for (ii =3D 0; rc =3D 0 && ii !=3D count; ++ii) {
-		rc =3D iop3xx_adap_write_byte(iop3xx_adap, buf[ii], ii=3Dcount-1);
-	}
+	for (ii =3D 0; rc =3D 0 && ii !=3D count; ++ii)=20
+		rc =3D iop3xx_i2c_write_byte(iop3xx_adap, buf[ii], ii=3Dcount-1);
 	return rc;
 }
=20
-static int iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap,=20
-				char *buf, int count)
+static int=20
+iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int ii;
 	int rc =3D 0;
=20
-	for (ii =3D 0; rc =3D 0 && ii !=3D count; ++ii) {
-		rc =3D iop3xx_adap_read_byte(iop3xx_adap, &buf[ii], ii=3Dcount-1);
-	}
+	for (ii =3D 0; rc =3D 0 && ii !=3D count; ++ii)
+		rc =3D iop3xx_i2c_read_byte(iop3xx_adap, &buf[ii], ii=3Dcount-1);
+=09
 	return rc;
 }
=20
@@ -352,12 +339,13 @@
  * Each transfer (i.e. a read or a write) is separated by a repeated start
  * condition.
  */
-static int iop3xx_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg*=
 pmsg)=20
+static int=20
+iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pmsg) =

 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int rc;
=20
-	rc =3D iop3xx_adap_send_target_slave_addr(iop3xx_adap, pmsg);
+	rc =3D iop3xx_i2c_send_target_addr(iop3xx_adap, pmsg);
 	if (rc < 0) {
 		return rc;
 	}
@@ -372,22 +360,24 @@
 /*
  * master_xfer() - main read/write entry
  */
-static int iop3xx_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg=
 msgs[], int num)
+static int=20
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[]=
,=20
+				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int im =3D 0;
 	int ret =3D 0;
 	int status;
=20
-	iop3xx_adap_wait_idle(iop3xx_adap, &status);
-	iop3xx_adap_reset(iop3xx_adap);
-	iop3xx_adap_enable(iop3xx_adap);
+	iop3xx_i2c_wait_idle(iop3xx_adap, &status);
+	iop3xx_i2c_reset(iop3xx_adap);
+	iop3xx_i2c_enable(iop3xx_adap);
=20
 	for (im =3D 0; ret =3D 0 && im !=3D num; im++) {
-		ret =3D iop3xx_handle_msg(i2c_adap, &msgs[im]);
+		ret =3D iop3xx_i2c_handle_msg(i2c_adap, &msgs[im]);
 	}
=20
-	iop3xx_adap_transaction_cleanup(iop3xx_adap);
+	iop3xx_i2c_transaction_cleanup(iop3xx_adap);
 =09
 	if(ret)
 		return ret;
@@ -395,136 +385,163 @@
 	return im;  =20
 }
=20
-static int algo_control(struct i2c_adapter *adapter, unsigned int cmd,
+static int=20
+iop3xx_i2c_algo_control(struct i2c_adapter *adapter, unsigned int cmd,
 			unsigned long arg)
 {
 	return 0;
 }
=20
-static u32 iic_func(struct i2c_adapter *adap)
+static u32=20
+iop3xx_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
=20
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo =3D {
+static struct i2c_algorithm iop3xx_i2c_algo =3D {
 	.name		=3D "IOP3xx I2C algorithm",
-	.id		=3D I2C_ALGO_OCP_IOP3XX,
-	.master_xfer	=3D iop3xx_master_xfer,
-	.algo_control	=3D algo_control,
-	.functionality	=3D iic_func,
+	.id		=3D I2C_ALGO_IOP3XX,
+	.master_xfer	=3D iop3xx_i2c_master_xfer,
+	.algo_control	=3D iop3xx_i2c_algo_control,
+	.functionality	=3D iop3xx_i2c_func,
 };
=20
-/*=20
- * registering functions to load algorithms at runtime=20
- */
-static int i2c_iop3xx_add_bus(struct i2c_adapter *iic_adap)
+static int=20
+iop3xx_i2c_remove(struct device *device)
+{
+	struct platform_device *pdev =3D to_platform_device(device);
+	struct i2c_adapter *padapter =3D dev_get_drvdata(&pdev->dev);
+	struct i2c_algo_iop3xx_data *adapter_data =3D=20
+		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
+	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	unsigned long cr =3D __raw_readl(adapter_data->ioaddr + CR_OFFSET);
+
+	/*
+	 * Disable the actual HW unit
+	 */
+	cr &=3D ~(IOP3XX_ICR_ALD_IE | IOP3XX_ICR_BERR_IE |
+		IOP3XX_ICR_RXFULL_IE | IOP3XX_ICR_TXEMPTY_IE);
+	__raw_writel(cr, adapter_data->ioaddr + CR_OFFSET);
+
+	iounmap((void __iomem*)adapter_data->ioaddr);
+	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
+	kfree(adapter_data);
+	kfree(padapter);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
+}
+
+static int=20
+iop3xx_i2c_probe(struct device *dev)
 {
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D iic_adap->algo_data;
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct resource *res;
+	int ret;
+	struct i2c_adapter *new_adapter;
+	struct i2c_algo_iop3xx_data *adapter_data;
=20
-	if (!request_region( REGION_START(iop3xx_adap),=20
-			      REGION_LENGTH(iop3xx_adap),
-			      iic_adap->name)) {
-		return -ENODEV;
+	new_adapter =3D kmalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!new_adapter) {
+		ret =3D -ENOMEM;
+		goto out;
 	}
=20
-	init_waitqueue_head(&iop3xx_adap->waitq);
-	spin_lock_init(&iop3xx_adap->lock);
+	adapter_data =3D kmalloc(sizeof(struct i2c_algo_iop3xx_data), GFP_KERNEL);
+	if (!adapter_data) {
+		ret =3D -ENOMEM;
+		goto free_adapter;
+	}
=20
-	if (request_irq(=20
-		     iop3xx_adap->biu->irq,
-		     iop3xx_i2c_handler,
-		     /* SA_SAMPLE_RANDOM */ 0,
-		     iic_adap->name,
-		     iop3xx_adap)) {
-		return -ENODEV;
-	}			 =20
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret =3D -ENODEV;
+		goto free_both;
+	}
=20
-	/* register new iic_adapter to i2c module... */
-	iic_adap->id |=3D iic_algo.id;
-	iic_adap->algo =3D &iic_algo;
+	if (!request_mem_region(res->start, IOP3XX_I2C_IO_SIZE, pdev->name)) {
+		ret =3D -EBUSY;
+		goto free_both;
+	}
=20
-	iic_adap->timeout =3D 100;	/* default values, should */
-	iic_adap->retries =3D 3;		/* be replaced by defines */
+	/* set the adapter enumeration # */
+	adapter_data->id =3D i2c_id++;
=20
-	iop3xx_adap_init(iic_adap->algo_data);
-	i2c_add_adapter(iic_adap);
-	return 0;
-}
+	adapter_data->ioaddr =3D (u32)ioremap(res->start, IOP3XX_I2C_IO_SIZE);
+	if (!adapter_data->ioaddr) {
+		ret =3D -ENOMEM;
+		goto release_region;
+	}
=20
-static int i2c_iop3xx_del_bus(struct i2c_adapter *iic_adap)
-{
-	struct i2c_algo_iop3xx_data *iop3xx_adap =3D iic_adap->algo_data;
+	res =3D request_irq(platform_get_irq(pdev, 0), iop3xx_i2c_irq_handler, 0,=
=20
+				pdev->name, adapter_data);
+	if (res) {
+		ret =3D -EIO;
+		goto unmap;
+	}
=20
-	iop3xx_adap_final_cleanup(iop3xx_adap);
-	free_irq(iop3xx_adap->biu->irq, iop3xx_adap);
+	memcpy(new_adapter->name, pdev->name, strlen(pdev->name));
+	new_adapter->id =3D I2C_HW_IOP3XX;
+	new_adapter->owner =3D THIS_MODULE;
+	new_adapter->dev.parent =3D &pdev->dev;
=20
-	release_region(REGION_START(iop3xx_adap), REGION_LENGTH(iop3xx_adap));
+	/*
+	 * Default values...should these come in from board code?
+	 */
+	new_adapter->timeout =3D 100;=09
+	new_adapter->retries =3D 3;
+	new_adapter->algo =3D &iop3xx_i2c_algo;
=20
-	return i2c_del_adapter(iic_adap);
-}
+	init_waitqueue_head(&adapter_data->waitq);
+	spin_lock_init(&adapter_data->lock);
=20
-#ifdef CONFIG_ARCH_IOP321
+	iop3xx_i2c_reset(adapter_data);
+	iop3xx_i2c_set_slave_addr(adapter_data);
+	iop3xx_i2c_enable(adapter_data);
=20
-static struct iop3xx_biu biu0 =3D {
-	.CR	=3D IOP321_ICR0,
-	.SR	=3D IOP321_ISR0,
-	.SAR	=3D IOP321_ISAR0,
-	.DBR	=3D IOP321_IDBR0,
-	.BMR	=3D IOP321_IBMR0,
-	.irq	=3D IRQ_IOP321_I2C_0,
-};
+	dev_set_drvdata(&pdev->dev, new_adapter);
+	new_adapter->algo_data =3D adapter_data;
=20
-static struct iop3xx_biu biu1 =3D {
-	.CR	=3D IOP321_ICR1,
-	.SR	=3D IOP321_ISR1,
-	.SAR	=3D IOP321_ISAR1,
-	.DBR	=3D IOP321_IDBR1,
-	.BMR	=3D IOP321_IBMR1,
-	.irq	=3D IRQ_IOP321_I2C_1,
-};
+	i2c_add_adapter(new_adapter);
=20
-#define ADAPTER_NAME_ROOT "IOP321 i2c biu adapter "
-#else
-#error Please define the BIU struct iop3xx_biu for your processor arch
-#endif
+	return 0;
=20
-static struct i2c_algo_iop3xx_data algo_iop3xx_data0 =3D {
-	.channel		=3D 0,
-	.biu			=3D &biu0,
-	.timeout		=3D 1*HZ,
-};
-static struct i2c_algo_iop3xx_data algo_iop3xx_data1 =3D {
-	.channel		=3D 1,
-	.biu			=3D &biu1,
-	.timeout		=3D 1*HZ,
-};
+unmap:
+	iounmap((void __iomem*)adapter_data->ioaddr);
=20
-static struct i2c_adapter iop3xx_ops0 =3D {
-	.owner			=3D THIS_MODULE,
-	.name			=3D ADAPTER_NAME_ROOT "0",
-	.id			=3D I2C_HW_IOP321,
-	.algo_data		=3D &algo_iop3xx_data0,
-};
-static struct i2c_adapter iop3xx_ops1 =3D {
-	.owner			=3D THIS_MODULE,
-	.name			=3D ADAPTER_NAME_ROOT "1",
-	.id			=3D I2C_HW_IOP321,
-	.algo_data		=3D &algo_iop3xx_data1,
+release_region:
+	release_mem_region(res->start, IOP3XX_I2C_IO_SIZE);
+
+free_both:
+	kfree(adapter_data);
+
+free_adapter:
+	kfree(new_adapter);
+
+out:
+	return ret;
+}
+
+
+static struct device_driver iop3xx_i2c_driver =3D {
+	.name		=3D "IOP3xx-I2C",
+	.bus		=3D &platform_bus_type,
+	.probe		=3D iop3xx_i2c_probe,
+	.remove		=3D iop3xx_i2c_remove
 };
=20
-static int __init i2c_iop3xx_init (void)
+static int __init=20
+i2c_iop3xx_init (void)
 {
-	return i2c_iop3xx_add_bus(&iop3xx_ops0) ||
-		i2c_iop3xx_add_bus(&iop3xx_ops1);
+	return driver_register(&iop3xx_i2c_driver);
 }
=20
-static void __exit i2c_iop3xx_exit (void)
+static void __exit=20
+i2c_iop3xx_exit (void)
 {
-	i2c_iop3xx_del_bus(&iop3xx_ops0);
-	i2c_iop3xx_del_bus(&iop3xx_ops1);
+	driver_unregister(&iop3xx_i2c_driver);
+	return;
 }
=20
 module_init (i2c_iop3xx_init);
=3D=3D=3D drivers/i2c/busses/i2c-iop3xx.h 1.3 vs edited =3D=3D--- 1.3/drive=
rs/i2c/busses/i2c-iop3xx.h	2003-09-22 07:58:42 -07:00
+++ edited/drivers/i2c/busses/i2c-iop3xx.h	2005-01-04 11:03:30 -08:00
@@ -25,20 +25,20 @@
 /*
  * iop321 hardware bit definitions
  */
-#define IOP321_ICR_FAST_MODE	0x8000	/* 1@0kBps, 0=100kBps */
-#define IOP321_ICR_UNIT_RESET	0x4000	/* 1=3DRESET */
-#define IOP321_ICR_SADIE	0x2000	/* 1=3DSlave Detect Interrupt Enable */
-#define IOP321_ICR_ALDIE	0x1000	/* 1=3DArb Loss Detect Interrupt Enable */
-#define IOP321_ICR_SSDIE	0x0800	/* 1=3DSlave STOP Detect Interrupt Enable =
*/
-#define IOP321_ICR_BERRIE	0x0400	/* 1=3DBus Error Interrupt Enable */
-#define IOP321_ICR_RXFULLIE	0x0200	/* 1=3DReceive Full Interrupt Enable */
-#define IOP321_ICR_TXEMPTYIE	0x0100	/* 1=3DTransmit Empty Interrupt Enable=
 */
-#define IOP321_ICR_GCD		0x0080	/* 1=3DGeneral Call Disable */
+#define IOP3XX_ICR_FAST_MODE	0x8000	/* 1@0kBps, 0=100kBps */
+#define IOP3XX_ICR_UNIT_RESET	0x4000	/* 1=3DRESET */
+#define IOP3XX_ICR_SAD_IE	0x2000	/* 1=3DSlave Detect Interrupt Enable */
+#define IOP3XX_ICR_ALD_IE	0x1000	/* 1=3DArb Loss Detect Interrupt Enable */
+#define IOP3XX_ICR_SSD_IE	0x0800	/* 1=3DSlave STOP Detect Interrupt Enable=
 */
+#define IOP3XX_ICR_BERR_IE	0x0400	/* 1=3DBus Error Interrupt Enable */
+#define IOP3XX_ICR_RXFULL_IE	0x0200	/* 1=3DReceive Full Interrupt Enable */
+#define IOP3XX_ICR_TXEMPTY_IE	0x0100	/* 1=3DTransmit Empty Interrupt Enabl=
e */
+#define IOP3XX_ICR_GCD		0x0080	/* 1=3DGeneral Call Disable */
 /*
- * IOP321_ICR_GCD: 1 disables response as slave. "This bit must be set
+ * IOP3XX_ICR_GCD: 1 disables response as slave. "This bit must be set
  * when sending a master mode general call message from the I2C unit"
  */
-#define IOP321_ICR_UE		0x0040	/* 1=3DUnit Enable */
+#define IOP3XX_ICR_UE		0x0040	/* 1=3DUnit Enable */
 /*
  * "NOTE: To avoid I2C bus integrity problems,=20
  * the user needs to ensure that the GPIO Output Data Register -=20
@@ -47,38 +47,38 @@
  * The user prepares to enable I2C port 0 and=20
  * I2C port 1 by clearing GPOD bits 7:6 and GPOD bits 5:4, respectively.
  */
-#define IOP321_ICR_SCLEN	0x0020	/* 1=3DSCL enable for master mode */
-#define IOP321_ICR_MABORT	0x0010	/* 1=3DSend a STOP with no data=20
+#define IOP3XX_ICR_SCLEN	0x0020	/* 1=3DSCL enable for master mode */
+#define IOP3XX_ICR_MABORT	0x0010	/* 1=3DSend a STOP with no data=20
 					 * NB TBYTE must be clear */
-#define IOP321_ICR_TBYTE	0x0008	/* 1=3DSend/Receive a byte. i2c clears */
-#define IOP321_ICR_NACK		0x0004	/* 1=3Dreply with NACK */
-#define IOP321_ICR_MSTOP	0x0002	/* 1=3Dsend a STOP after next data byte */
-#define IOP321_ICR_MSTART	0x0001	/* 1=3Dinitiate a START */
-
-
-#define IOP321_ISR_BERRD	0x0400	/* 1=3DBUS ERROR Detected */
-#define IOP321_ISR_SAD		0x0200	/* 1=3DSlave ADdress Detected */
-#define IOP321_ISR_GCAD		0x0100	/* 1=3DGeneral Call Address Detected */
-#define IOP321_ISR_RXFULL	0x0080	/* 1=3DReceive Full */
-#define IOP321_ISR_TXEMPTY	0x0040	/* 1=3DTransmit Empty */
-#define IOP321_ISR_ALD		0x0020	/* 1=3DArbitration Loss Detected */
-#define IOP321_ISR_SSD		0x0010	/* 1=3DSlave STOP Detected */
-#define IOP321_ISR_BBUSY	0x0008	/* 1=3DBus BUSY */
-#define IOP321_ISR_UNITBUSY	0x0004	/* 1=3DUnit Busy */
-#define IOP321_ISR_NACK		0x0002	/* 1=3DUnit Rx or Tx a NACK */
-#define IOP321_ISR_RXREAD	0x0001	/* 1=3DREAD 0=3DWRITE (R/W bit of slave a=
ddr */
-
-#define IOP321_ISR_CLEARBITS	0x07f0
-
-#define IOP321_ISAR_SAMASK	0x007f
+#define IOP3XX_ICR_TBYTE	0x0008	/* 1=3DSend/Receive a byte. i2c clears */
+#define IOP3XX_ICR_NACK		0x0004	/* 1=3Dreply with NACK */
+#define IOP3XX_ICR_MSTOP	0x0002	/* 1=3Dsend a STOP after next data byte */
+#define IOP3XX_ICR_MSTART	0x0001	/* 1=3Dinitiate a START */
+
+
+#define IOP3XX_ISR_BERRD	0x0400	/* 1=3DBUS ERROR Detected */
+#define IOP3XX_ISR_SAD		0x0200	/* 1=3DSlave ADdress Detected */
+#define IOP3XX_ISR_GCAD		0x0100	/* 1=3DGeneral Call Address Detected */
+#define IOP3XX_ISR_RXFULL	0x0080	/* 1=3DReceive Full */
+#define IOP3XX_ISR_TXEMPTY	0x0040	/* 1=3DTransmit Empty */
+#define IOP3XX_ISR_ALD		0x0020	/* 1=3DArbitration Loss Detected */
+#define IOP3XX_ISR_SSD		0x0010	/* 1=3DSlave STOP Detected */
+#define IOP3XX_ISR_BBUSY	0x0008	/* 1=3DBus BUSY */
+#define IOP3XX_ISR_UNITBUSY	0x0004	/* 1=3DUnit Busy */
+#define IOP3XX_ISR_NACK		0x0002	/* 1=3DUnit Rx or Tx a NACK */
+#define IOP3XX_ISR_RXREAD	0x0001	/* 1=3DREAD 0=3DWRITE (R/W bit of slave a=
ddr */
+
+#define IOP3XX_ISR_CLEARBITS	0x07f0
+
+#define IOP3XX_ISAR_SAMASK	0x007f
=20
-#define IOP321_IDBR_MASK	0x00ff
+#define IOP3XX_IDBR_MASK	0x00ff
=20
-#define IOP321_IBMR_SCL		0x0002
-#define IOP321_IBMR_SDA		0x0001
+#define IOP3XX_IBMR_SCL		0x0002
+#define IOP3XX_IBMR_SDA		0x0001
=20
-#define IOP321_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
-#define IOP321_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
+#define IOP3XX_GPOD_I2C0	0x00c0	/* clear these bits to enable ch0 */
+#define IOP3XX_GPOD_I2C1	0x0030	/* clear these bits to enable ch1 */
=20
 #define MYSAR			0x02	/* SWAG a suitable slave address */
=20
@@ -87,32 +87,21 @@
 #define I2C_ERR_ALD		(I2C_ERR+1)
=20
=20
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
+#define	CR_OFFSET		0
+#define	SR_OFFSET		0x4
+#define	SAR_OFFSET		0x8
+#define	DBR_OFFSET		0xc
+#define	CCR_OFFSET		0x10
+#define	BMR_OFFSET		0x14
=20
-struct i2c_algo_iop3xx_data {
-	int channel;
+#define	IOP3XX_I2C_IO_SIZE	0x18
=20
+struct i2c_algo_iop3xx_data {
+	u32 ioaddr;
 	wait_queue_head_t waitq;
 	spinlock_t lock;
-	int timeout;
-	struct iop3xx_biu* biu;
+	u32 SR_enabled, SR_received;
+	int id;
 };
-
-#define REGION_START(adap)	((u32)((adap)->biu->CR))
-#define REGION_END(adap)	((u32)((adap)->biu->BMR+1))
-#define REGION_LENGTH(adap)	(REGION_END(adap)-REGION_START(adap))
-
-#define IRQ_STATUS_MASK(adap)	(1<<adap->biu->irq)
=20
 #endif /* I2C_IOP3XX_H */
=3D=3D=3D include/linux/i2c-id.h 1.23 vs edited =3D=3D--- 1.23/include/linu=
x/i2c-id.h	2004-07-29 08:06:29 -07:00
+++ edited/include/linux/i2c-id.h	2004-12-20 18:53:47 -08:00
@@ -193,7 +193,7 @@
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm=
 */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
-#define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
+#define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
 #define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
=20
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
@@ -259,7 +259,7 @@
 #define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
=20
 /* --- XSCALE on-chip adapters                          */
-#define I2C_HW_IOP321 0x00
+#define I2C_HW_IOP3XX 0x00
=20
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00


--=20
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

You cannot find yourself, only create yourself - Anne Sekel
