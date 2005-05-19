From: mporter@kernel.crashing.org (Matt Porter)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: [PATCH][2.6] New PPC4xx I2C driver
Message-Id: <20030912155233.A9590@home.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This updates the current 2.6 PPC 4xx driver to the rewritten version
we have in the PPC development tree.  It is cleaner, has less bugs,
and has more features.  Please apply.

-Matt

This BitKeeper patch contains the following changesets:
1.1316

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	mporter
# Host:	kernel.crashing.org
# Root:	/home/mporter/src/i2c

#
#--- 1.5/drivers/i2c/i2c-algo-ibm_ocp.c	Tue Mar 11 13:21:11 2003
#+++ 1.7/drivers/i2c/i2c-ibm_iic.c	Fri Sep 12 12:31:23 2003
#@@ -1,900 +1,729 @@
# /*
#-   ----------------------------------------------------------------------=
---
#-   i2c-algo-ibm_ocp.c i2c driver algorithms for IBM PPC 405 adapters	    =

#-   ----------------------------------------------------------------------=
---
#-     =20
#-   Ian DaSilva, MontaVista Software, Inc.
#-   idasilva@mvista.com or source@mvista.com
#-
#-   Copyright 2000 MontaVista Software Inc.
#-
#-   Changes made to support the IIC peripheral on the IBM PPC 405
#-
#-
#-   ----------------------------------------------------------------------=
-----
#-   This file was highly leveraged from i2c-algo-pcf.c, which was created
#-   by Simon G. Vogl and Hans Berglund:
#-
#-
#-     Copyright (C) 1995-1997 Simon G. Vogl
#-                   1998-2000 Hans Berglund
#-
#-   With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and=20
#-   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
#-   <mbailey@littlefeet-inc.com>
#-
#-
#-    This program is free software; you can redistribute it and/or modify
#-    it under the terms of the GNU General Public License as published by
#-    the Free Software Foundation; either version 2 of the License, or
#-    (at your option) any later version.
#-
#-    This program is distributed in the hope that it will be useful,
#-    but WITHOUT ANY WARRANTY; without even the implied warranty of
#-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#-    GNU General Public License for more details.
#-
#-    You should have received a copy of the GNU General Public License
#-    along with this program; if not, write to the Free Software
#-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#-   ----------------------------------------------------------------------=
-----
#-
#-   History: 01/20/12 - Armin
#-   	akuster@mvista.com
#-   	ported up to 2.4.16+=09
#-
#-   Version 02/03/25 - Armin
#-       converted to ocp format
#-       removed commented out or #if 0 code
#-       added G?rard Basler's fix to iic_combined_transaction() such that =
it=20
#-       returns the number of successfully completed transfers .
#-*/
#-
#-
#-#include <linux/kernel.h>
#+ * drivers/i2c/i2c-ibm_iic.c
#+ *
#+ * Support for the IIC peripheral on IBM PPC 4xx
#+ *
#+ * Copyright (c) 2003 Zultys Technologies.
#+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
#+ *
#+ * Based on original work by=20
#+ * 	Ian DaSilva  <idasilva@mvista.com>
#+ *      Armin Kuster <akuster@mvista.com>
#+ * 	Matt Porter  <mporter@mvista.com>
#+ *
#+ *      Copyright 2000-2003 MontaVista Software Inc.
#+ *
#+ * Original driver version was highly leveraged from i2c-elektor.c
#+ *
#+ *   	Copyright 1995-97 Simon G. Vogl
#+ *                1998-99 Hans Berglund
#+ *
#+ *   	With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi>=20
#+ *	and even Frodo Looijaard <frodol@dds.nl>
#+ *
#+ * This program is free software; you can redistribute  it and/or modify =
it
#+ * under  the terms of  the GNU General  Public License as published by t=
he
#+ * Free Software Foundation;  either version 2 of the  License, or (at yo=
ur
#+ * option) any later version.
#+ *
#+ */
# #include <linux/module.h>
#+#include <linux/kernel.h>
#+#include <linux/ioport.h>
# #include <linux/delay.h>
# #include <linux/slab.h>
# #include <linux/init.h>
#-#include <linux/errno.h>
#-#include <linux/sched.h>
#+#include <linux/interrupt.h>
#+#include <asm/irq.h>
#+#include <asm/io.h>
# #include <linux/i2c.h>
#-#include <linux/i2c-algo-ibm_ocp.h>
#+#include <linux/i2c-id.h>
# #include <asm/ocp.h>
#+#include <asm/ibm4xx.h>
#=20
#+#include "i2c-ibm_iic.h"
#=20
#-/* ----- global defines ----------------------------------------------- */
#-#define DEB(x) if (i2c_debug>=3D1) x
#-#define DEB2(x) if (i2c_debug>=3D2) x
#-#define DEB3(x) if (i2c_debug>=3D3) x /* print several statistical values=
*/
#-#define DEBPROTO(x) if (i2c_debug>=3D9) x;
#- 	/* debug the protocol by showing transferred bits */
#-#define DEF_TIMEOUT 5
#-
#-
#-/* ----- global variables ---------------------------------------------	*/
#+#define DRIVER_VERSION "2.0"
#=20
#+MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
#+MODULE_LICENSE("GPL");
#=20
#-/* module parameters:
#- */
#-static int i2c_debug=3D0;
#-
#-/* --- setting states on the bus with the right timing: ---------------	*/
#-
#-#define iic_outb(adap, reg, val) adap->setiic(adap->data, (int) &(reg), v=
al)
#-#define iic_inb(adap, reg) adap->getiic(adap->data, (int) &(reg))
#-
#-#define IICO_I2C_SDAHIGH	0x0780
#-#define IICO_I2C_SDALOW		0x0781
#-#define IICO_I2C_SCLHIGH	0x0782
#-#define IICO_I2C_SCLLOW		0x0783
#-#define IICO_I2C_LINEREAD	0x0784
#+static int iic_scan =3D 0;
#+MODULE_PARM(iic_scan, "i");
#+MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
#+
#+static int iic_force_poll =3D 0;
#+MODULE_PARM(iic_force_poll, "i");
#+MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
#+
#+static int iic_force_fast =3D 0;
#+MODULE_PARM(iic_force_fast, "i");
#+MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
#=20
#-#define IIC_SINGLE_XFER		0
#-#define IIC_COMBINED_XFER	1
#+#define DBG_LEVEL 0
#=20
#-#define IIC_ERR_LOST_ARB        -2
#-#define IIC_ERR_INCOMPLETE_XFR  -3
#-#define IIC_ERR_NACK            -1
#+#ifdef DBG
#+#undef DBG
#+#endif
#=20
#-/* --- other auxiliary functions --------------------------------------	*/
#+#ifdef DBG2
#+#undef DBG2
#+#endif
#=20
#+#if DBG_LEVEL > 0
#+#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
#+#else
#+#  define DBG(x...)	((void)0)
#+#endif
#+#if DBG_LEVEL > 1
#+#  define DBG2(x...) 	DBG( ##x )
#+#else
#+#  define DBG2(x...) 	((void)0)
#+#endif
#+#if DBG_LEVEL > 2
#+static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
#+{
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
#+	printk(KERN_DEBUG "  cntl     =3D 0x%02x, mdcntl =3D 0x%02x\n"
#+	       KERN_DEBUG "  sts      =3D 0x%02x, extsts =3D 0x%02x\n"
#+	       KERN_DEBUG "  clkdiv   =3D 0x%02x, xfrcnt =3D 0x%02x\n"
#+	       KERN_DEBUG "  xtcntlss =3D 0x%02x, directcntl =3D 0x%02x\n",
#+		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),=20
#+		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),=20
#+		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
#+}
#+#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
#+#else
#+#  define DUMP_REGS(h,dev)	((void)0)
#+#endif
#=20
#-//
#-// Description: Puts this process to sleep for a period equal to timeout =

#-//
#-static inline void iic_sleep(unsigned long timeout)
#+/* Enable/disable interrupt generation */
#+static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int en=
able)
# {
#-	schedule_timeout( timeout * HZ);
#+	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
# }
#-
#-
#-//
#-// Description: This performs the IBM PPC 405 IIC initialization sequence
#-// as described in the PPC405GP data book.
#-//
#-static int iic_init (struct i2c_algo_iic_data *adap)
#+=20
#+/*
#+ * Initialize IIC interface.
#+ */
#+static void iic_dev_init(struct ibm_iic_private* dev)
# {
#-	struct iic_regs *iic;=09
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	unsigned short	retval;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-        /* Clear master low master address */
#-        iic_outb(adap,iic->lmadr, 0);
#-
#-        /* Clear high master address */
#-        iic_outb(adap,iic->hmadr, 0);
#-
#-        /* Clear low slave address */
#-        iic_outb(adap,iic->lsadr, 0);
#-
#-        /* Clear high slave address */
#-        iic_outb(adap,iic->hsadr, 0);
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#=20
#-        /* Clear status */
#-        iic_outb(adap,iic->sts, 0x0a);
#-
#-        /* Clear extended status */
#-        iic_outb(adap,iic->extsts, 0x8f);
#-
#-        /* Set clock division */
#-        iic_outb(adap,iic->clkdiv, 0x04);
#-
#-	retval =3D iic_inb(adap, iic->clkdiv);
#-	DEB(printk("iic_init: CLKDIV register =3D %x\n", retval));
#-
#-        /* Enable interrupts on Requested Master Transfer Complete */
#-        iic_outb(adap,iic->intmsk, 0x01);
#-
#-        /* Clear transfer count */
#-        iic_outb(adap,iic->xfrcnt, 0x0);
#-
#-        /* Clear extended control and status */
#-        iic_outb(adap,iic->xtcntlss, 0xf0);
#+	DBG("%d: init\n", dev->idx);
#+=09
#+	/* Clear master address */
#+	out_8(&iic->lmadr, 0);
#+	out_8(&iic->hmadr, 0);
#+
#+	/* Clear slave address */
#+	out_8(&iic->lsadr, 0);
#+	out_8(&iic->hsadr, 0);
#+
#+	/* Clear status & extended status */
#+	out_8(&iic->sts, STS_SCMP | STS_IRQA);
#+	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
#+			    | EXTSTS_ICT | EXTSTS_XFRA);
#+
#+	/* Set clock divider */
#+	out_8(&iic->clkdiv, dev->clckdiv);
#+
#+	/* Clear transfer count */
#+	out_8(&iic->xfrcnt, 0);
#+
#+	/* Clear extended control and status */
#+	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
#+			    | XTCNTLSS_SWS);
#=20
#-        /* Set mode control (flush master data buf, enable hold SCL, exit=
 */
#-        /* unknown state.                                                =
 */
#-        iic_outb(adap,iic->mdcntl, 0x47);
#+	/* Clear control register */
#+	out_8(&iic->cntl, 0);
#+=09
#+	/* Enable interrupts if possible */
#+	iic_interrupt_mode(dev, dev->irq >=3D 0);
#=20
#-        /* Clear control register */
#-        iic_outb(adap,iic->cntl, 0x0);
#+	/* Set mode control */
#+	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
#+			    | (dev->fast_mode ? MDCNTL_FSM : 0));
#=20
#-        DEB2(printk(KERN_DEBUG "iic_init: Initialized IIC on PPC 405\n"));
#-        return 0;
#+	DUMP_REGS("iic_init", dev);
# }
#=20
#-
#-//
#-// Description: After we issue a transaction on the IIC bus, this function
#-// is called.  It puts this process to sleep until we get an interrupt fr=
om
#-// from the controller telling us that the transaction we requested in co=
mplete.
#-//
#-static int wait_for_pin(struct i2c_algo_iic_data *adap, int *status)=20
#+/*=20
#+ * Reset IIC interface
#+ */
#+static void iic_dev_reset(struct ibm_iic_private* dev)
# {
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	int i;
#+	u8 dc;
#+=09
#+	DBG("%d: soft reset\n", dev->idx);
#+	DUMP_REGS("reset", dev);
#+=09
#+    	/* Place chip in the reset state */
#+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
#+=09
#+	/* Check if bus is free */
#+	dc =3D in_8(&iic->directcntl);=09
#+	if (!DIRCTNL_FREE(dc)){
#+		DBG("%d: trying to regain bus control\n", dev->idx);
#+=09
#+		/* Try to set bus free state */
#+		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);=09
#+=09
#+		/* Wait until we regain bus control */
#+		for (i =3D 0; i < 100; ++i){
#+			dc =3D in_8(&iic->directcntl);
#+			if (DIRCTNL_FREE(dc))
#+				break;
#+		=09
#+			/* Toggle SCL line */
#+			dc ^=3D DIRCNTL_SCC;
#+			out_8(&iic->directcntl, dc);
#+			udelay(10);
#+			dc ^=3D DIRCNTL_SCC;
#+			out_8(&iic->directcntl, dc);
#+		=09
#+			/* be nice */
#+			cond_resched();
#+		}
#+	}
#+=09
#+	/* Remove reset */
#+	out_8(&iic->xtcntlss, 0);
#+=09
#+	/* Reinitialize interface */
#+	iic_dev_init(dev);
#+}
#=20
#-	int timeout =3D DEF_TIMEOUT;
#-	int retval;
#-	struct iic_regs *iic;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-
#-	*status =3D iic_inb(adap, iic->sts);
#-#ifndef STUB_I2C
#+/*
#+ * IIC interrupt handler
#+ */
#+static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *reg=
s)
#+{
#+	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;
#+	volatile struct iic_regs* iic =3D dev->vaddr;
#+=09
#+	DBG2("%d: irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",=20
#+	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
#+=09
#+	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
#+	out_8(&iic->sts, STS_IRQA | STS_SCMP);
#+	wake_up_interruptible(&dev->wq);
#+=09
#+	return IRQ_HANDLED;
#+}
#=20
#-	while (timeout-- && (*status & 0x01)) {
#-	   adap->waitforpin(adap->data);
#-	   *status =3D iic_inb(adap, iic->sts);
#-	}
#-#endif
#-	if (timeout <=3D 0) {
#-	   /* Issue stop signal on the bus, and force an interrupt */
#-           retval =3D iic_inb(adap, iic->cntl);
#-           iic_outb(adap, iic->cntl, retval | 0x80);
#-           /* Clear status register */
#-	   iic_outb(adap, iic->sts, 0x0a);
#-	   /* Exit unknown bus state */
#-	   retval =3D iic_inb(adap, iic->mdcntl);
#-	   iic_outb(adap, iic->mdcntl, (retval | 0x02));
#-
#-	   // Check the status of the controller.  Does it still see a
#-	   // pending transfer, even though we've tried to stop any
#-	   // ongoing transaction?
#-           retval =3D iic_inb(adap, iic->sts);
#-           retval =3D retval & 0x01;
#-           if(retval) {
#-	      // The iic controller is hosed.  It is not responding to any
#-	      // of our commands.  We have already tried to force it into
#-	      // a known state, but it has not worked.  Our only choice now
#-	      // is a soft reset, which will clear all registers, and force
#-	      // us to re-initialize the controller.
#-	      /* Soft reset */
#-              iic_outb(adap, iic->xtcntlss, 0x01);
#-              udelay(500);
#-              iic_init(adap);
#-	      /* Is the pending transfer bit in the sts reg finally cleared? */
#-              retval =3D iic_inb(adap, iic->sts);
#-              retval =3D retval & 0x01;
#-              if(retval) {
#-                 printk(KERN_CRIT "The IIC Controller is hosed.  A proces=
sor reset is required\n");
#-              }
#-	      // For some reason, even though the interrupt bit in this
#-	      // register was set during iic_init, it didn't take.  We
#-	      // need to set it again.  Don't ask me why....this is just what
#-	      // I saw when testing timeouts.
#-              iic_outb(adap, iic->intmsk, 0x01);
#-           }
#-	   return(-1);
#+/*
#+ * Get master transfer result and clear errors if any.
#+ * Returns the number of actually transferred bytes or error (<0)
#+ */
#+static int iic_xfer_result(struct ibm_iic_private* dev)
#+{
#+	volatile struct iic_regs *iic =3D dev->vaddr;=09
#+=09
#+	if (unlikely(in_8(&iic->sts) & STS_ERR)){
#+		DBG("%d: xfer error, EXTSTS =3D 0x%02x\n", dev->idx,=20
#+			in_8(&iic->extsts));
#+			=09
#+		/* Clear errors and possible pending IRQs */
#+		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |=20
#+			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
#+		=09
#+		/* Flush master data buffer */
#+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
#+	=09
#+		/* Is bus free?
#+		 * If error happened during combined xfer
#+		 * IIC interface is usually stuck in some strange
#+		 * state, the only way out - soft reset.
#+		 */
#+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
#+			DBG("%d: bus is stuck, resetting\n", dev->idx);
#+			iic_dev_reset(dev);
#+		}
#+		return -EREMOTEIO;
# 	}
# 	else
#-	   return(0);
#+		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
# }
#=20
#+/*
#+ * Try to abort active transfer.
#+ */
#+static void iic_abort_xfer(struct ibm_iic_private* dev)
#+{
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	unsigned long x;
#+=09
#+	DBG("%d: iic_abort_xfer\n", dev->idx);
#+=09
#+	out_8(&iic->cntl, CNTL_HMT);
#+=09
#+	/*
#+	 * Wait for the abort command to complete.
#+	 * It's not worth to be optimized, just poll (timeout >=3D 1 tick)
#+	 */
#+	x =3D jiffies + 2;
#+	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
#+		if (time_after(jiffies, x)){
#+			DBG("%d: abort timeout, resetting...\n", dev->idx);
#+			iic_dev_reset(dev);
#+			return;
#+		}
#+		schedule();
#+	}
#=20
#-//------------------------------------
#-// Utility functions
#-//
#-
#-
#-//
#-// Description: Look at the status register to see if there was an error
#-// in the requested transaction.  If there is, look at the extended status
#-// register and determine the exact cause.
#-//
#-int analyze_status(struct i2c_algo_iic_data *adap, int *error_code)
#-{
#-   int ret;
#-   struct iic_regs *iic;
#-   struct iic_ibm *adap_priv_data =3D adap->data;
#-   iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-=09
#-   ret =3D iic_inb(adap, iic->sts);
#-   if(ret & 0x04) {
#-      // Error occurred
#-      ret =3D iic_inb(adap, iic->extsts);
#-      if(ret & 0x04) {
#-         // Lost arbitration
#-         *error_code =3D  IIC_ERR_LOST_ARB;
#-      }
#-      if(ret & 0x02) {
#-         // Incomplete transfer
#-         *error_code =3D IIC_ERR_INCOMPLETE_XFR;
#-      }
#-      if(ret & 0x01) {
#-         // Master transfer aborted by a NACK during the transfer of the =

#-	 // address byte
#-         *error_code =3D IIC_ERR_NACK;
#-      }
#-      return -1;
#-   }
#-   return 0;
#+	/* Just to clear errors */
#+	iic_xfer_result(dev);
# }
#=20
#-
#-//
#-// Description: This function is called by the upper layers to do the
#-// grunt work for a master send transaction
#-//
#-static int iic_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
#-                         int count, int xfer_flag)
#-{
#-	struct iic_regs *iic;
#-	struct i2c_algo_iic_data *adap =3D i2c_adap->algo_data;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	int wrcount, status, timeout;
#-	int loops, remainder, i, j;
#-	int ret, error_code;
#-  	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-=20
#-	if( count =3D 0 ) return 0;
#-	wrcount =3D 0;
#-	loops =3D  count / 4;
#-	remainder =3D count % 4;
#-
#-	if((loops > 1) && (remainder =3D 0)) {
#-	   for(i=3D0; i<(loops-1); i++) {
#-       	      //
#-   	      // Write four bytes to master data buffer
#-	      //
#-	      for(j=3D0; j<4; j++) {
#-   	         iic_outb(adap, iic->mdbuf,=20
#-	         buf[wrcount++]);
#-  	      }
#-	      //
#-	      // Issue command to IICO device to begin transmission
#-	      //
#-	      iic_outb(adap, iic->cntl, 0x35);
#-	      //
#-	      // Wait for transmission to complete.  When it does,=20
#-	      //loop to the top of the for statement and write the=20
#-	      // next four bytes.
#-	      //
#-	      timeout =3D wait_for_pin(adap, &status);
#-	      if(timeout < 0) {
#-	         //
#-	         // Error handling
#-	         //
#-                 //printk(KERN_ERR "Error: write timeout\n");
#-                 return wrcount;
#-	      }
#-	      ret =3D analyze_status(adap, &error_code);
#-	      if(ret < 0) {
#-                 if(error_code =3D IIC_ERR_INCOMPLETE_XFR) {
#-                    // Return the number of bytes transferred
#-                    ret =3D iic_inb(adap, iic->xfrcnt);
#-                    ret =3D ret & 0x07;
#-                    return (wrcount-4+ret);
#-                 }
#-                 else return error_code;
#-              }
#-           }
#-	}
#-	else if((loops >=3D 1) && (remainder > 0)){
#-	   //printk(KERN_DEBUG "iic_sendbytes: (loops >=3D 1)\n");
#-	   for(i=3D0; i<loops; i++) {
#-              //
#-              // Write four bytes to master data buffer
#-              //
#-              for(j=3D0; j<4; j++) {
#-                 iic_outb(adap, iic->mdbuf,
#-                 buf[wrcount++]);
#-              }
#-              //
#-              // Issue command to IICO device to begin transmission
#-              //
#-              iic_outb(adap, iic->cntl, 0x35);
#-              //
#-              // Wait for transmission to complete.  When it does,
#-              //loop to the top of the for statement and write the
#-              // next four bytes.
#-              //
#-              timeout =3D wait_for_pin(adap, &status);
#-              if(timeout < 0) {
#-                 //
#-                 // Error handling
#-                 //
#-                 //printk(KERN_ERR "Error: write timeout\n");
#-                 return wrcount;
#-              }
#-              ret =3D analyze_status(adap, &error_code);
#-              if(ret < 0) {
#-                 if(error_code =3D IIC_ERR_INCOMPLETE_XFR) {
#-                    // Return the number of bytes transferred
#-                    ret =3D iic_inb(adap, iic->xfrcnt);
#-                    ret =3D ret & 0x07;
#-                    return (wrcount-4+ret);
#-                 }
#-                 else return error_code;
#-              }
#-           }
#-        }
#-
#-	//printk(KERN_DEBUG "iic_sendbytes: expedite write\n");
#-	if(remainder =3D 0) remainder =3D 4;
#-	// remainder =3D remainder - 1;
#-	//
#-	// Write the remaining bytes (less than or equal to 4)
#-	//
#-	for(i=3D0; i<remainder; i++) {
#-	   iic_outb(adap, iic->mdbuf, buf[wrcount++]);
#-	   //printk(KERN_DEBUG "iic_sendbytes:  data transferred =3D %x, wrcount=
 =3D %d\n", buf[wrcount-1], (wrcount-1));
#-	}
#-        //printk(KERN_DEBUG "iic_sendbytes: Issuing write\n");
#-
#-        if(xfer_flag =3D IIC_COMBINED_XFER) {
#-           iic_outb(adap, iic->cntl, (0x09 | ((remainder-1) << 4)));
#-        }
#-	else {
#-           iic_outb(adap, iic->cntl, (0x01 | ((remainder-1) << 4)));
#-        }
#-	DEB2(printk(KERN_DEBUG "iic_sendbytes: Waiting for interrupt\n"));
#-	timeout =3D wait_for_pin(adap, &status);
#-        if(timeout < 0) {
#-       	   //
#-           // Error handling
#-           //
#-           //printk(KERN_ERR "Error: write timeout\n");
#-           return wrcount;
#-        }
#-        ret =3D analyze_status(adap, &error_code);
#-        if(ret < 0) {
#-           if(error_code =3D IIC_ERR_INCOMPLETE_XFR) {
#-              // Return the number of bytes transferred
#-              ret =3D iic_inb(adap, iic->xfrcnt);
#-              ret =3D ret & 0x07;
#-              return (wrcount-4+ret);
#-           }
#-           else return error_code;
#-        }
#-	DEB2(printk(KERN_DEBUG "iic_sendbytes: Got interrupt\n"));
#-	return wrcount;
#-}
#-
#-
#-//
#-// Description: Called by the upper layers to do the grunt work for
#-// a master read transaction.
#-//
#-static int iic_readbytes(struct i2c_adapter *i2c_adap, char *buf, int cou=
nt, int xfer_type)
#-{
#-	struct iic_regs *iic;
#-	int rdcount=3D0, i, status, timeout;
#-	struct i2c_algo_iic_data *adap =3D i2c_adap->algo_data;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	int loops, remainder, j;
#-        int ret, error_code;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-	if(count =3D 0) return 0;
#-	loops =3D count / 4;
#-	remainder =3D count % 4;
#-
#-	//printk(KERN_DEBUG "iic_readbytes: loops =3D %d, remainder =3D %d\n", l=
oops, remainder);
#-
#-	if((loops > 1) && (remainder =3D 0)) {
#-	//printk(KERN_DEBUG "iic_readbytes: (loops > 1) && (remainder =3D 0)\n");
#-	   for(i=3D0; i<(loops-1); i++) {
#-	      //
#-              // Issue command to begin master read (4 bytes maximum)
#-              //
#-	      //printk(KERN_DEBUG "--->Issued read command\n");
#-	      iic_outb(adap, iic->cntl, 0x37);
#-	      //
#-              // Wait for transmission to complete.  When it does,
#-              // loop to the top of the for statement and write the
#-              // next four bytes.
#-              //
#-	      //printk(KERN_DEBUG "--->Waiting for interrupt\n");
#-              timeout =3D wait_for_pin(adap, &status);
#-              if(timeout < 0) {
#-	         // Error Handler
#-		 //printk(KERN_ERR "Error: read timed out\n");
#-                 return rdcount;
#-	      }
#-              //printk(KERN_DEBUG "--->Got interrupt\n");
#-
#-              ret =3D analyze_status(adap, &error_code);
#-	      if(ret < 0) {
#-                 if(error_code =3D IIC_ERR_INCOMPLETE_XFR)
#-                    return rdcount;
#-                 else
#-                    return error_code;
#-              }
#-
#-	      for(j=3D0; j<4; j++) {
#-                 // Wait for data to shuffle to top of data buffer
#-                 // This value needs to optimized.
#-		 udelay(1);
#-	         buf[rdcount] =3D iic_inb(adap, iic->mdbuf);
#-	         rdcount++;
#-		 //printk(KERN_DEBUG "--->Read one byte\n");
#-              }
#-           }
#-	}
#-
#-	else if((loops >=3D 1) && (remainder > 0)){
#-	//printk(KERN_DEBUG "iic_readbytes: (loops >=3D1) && (remainder > 0)\n");
#-	   for(i=3D0; i<loops; i++) {
#-              //
#-              // Issue command to begin master read (4 bytes maximum)
#-              //
#-              //printk(KERN_DEBUG "--->Issued read command\n");
#-              iic_outb(adap, iic->cntl, 0x37);
#-              //
#-              // Wait for transmission to complete.  When it does,
#-              // loop to the top of the for statement and write the
#-              // next four bytes.
#-              //
#-              //printk(KERN_DEBUG "--->Waiting for interrupt\n");
#-              timeout =3D wait_for_pin(adap, &status);
#-              if(timeout < 0) {
#-                 // Error Handler
#-                 //printk(KERN_ERR "Error: read timed out\n");
#-                 return rdcount;
#-              }
#-              //printk(KERN_DEBUG "--->Got interrupt\n");
#-
#-              ret =3D analyze_status(adap, &error_code);
#-              if(ret < 0) {
#-                 if(error_code =3D IIC_ERR_INCOMPLETE_XFR)
#-                    return rdcount;
#-                 else
#-                    return error_code;
#-              }
#-
#-              for(j=3D0; j<4; j++) {
#-                 // Wait for data to shuffle to top of data buffer
#-                 // This value needs to optimized.
#-                 udelay(1);
#-                 buf[rdcount] =3D iic_inb(adap, iic->mdbuf);
#-                 rdcount++;
#-                 //printk(KERN_DEBUG "--->Read one byte\n");
#-              }
#-           }
#-        }
#-
#-	//printk(KERN_DEBUG "iic_readbytes: expedite read\n");
#-	if(remainder =3D 0) remainder =3D 4;
#-	DEB2(printk(KERN_DEBUG "iic_readbytes: writing %x to IICO_CNTL\n", (0x03=
 | ((remainder-1) << 4))));
#-
#-	if(xfer_type =3D IIC_COMBINED_XFER) {
#-	   iic_outb(adap, iic->cntl, (0x0b | ((remainder-1) << 4)));
#-        }
#-        else {
#-	   iic_outb(adap, iic->cntl, (0x03 | ((remainder-1) << 4)));
#-        }
#-	DEB2(printk(KERN_DEBUG "iic_readbytes: Wait for pin\n"));
#-        timeout =3D wait_for_pin(adap, &status);
#-	DEB2(printk(KERN_DEBUG "iic_readbytes: Got the interrupt\n"));
#-        if(timeout < 0) {
#-           // Error Handler
#-	   //printk(KERN_ERR "Error: read timed out\n");
#-           return rdcount;
#-        }
#-
#-        ret =3D analyze_status(adap, &error_code);
#-        if(ret < 0) {
#-           if(error_code =3D IIC_ERR_INCOMPLETE_XFR)
#-              return rdcount;
#-           else
#-              return error_code;
#-        }
#-
#-	//printk(KERN_DEBUG "iic_readbyte: Begin reading data buffer\n");
#-	for(i=3D0; i<remainder; i++) {
#-	   buf[rdcount] =3D iic_inb(adap, iic->mdbuf);
#-	   // printk(KERN_DEBUG "iic_readbytes:  Character read =3D %x\n", buf[r=
dcount]);
#-           rdcount++;
#-	}
#-
#-	return rdcount;
#-}
#-
#-
#-//
#-// Description:  This function implements combined transactions.  Combined
#-// transactions consist of combinations of reading and writing blocks of =
data.
#-// Each transfer (i.e. a read or a write) is separated by a repeated start
#-// condition.
#-//
#-static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct =
i2c_msg msgs[], int num)=20
#-{
#-   int i;
#-   struct i2c_msg *pmsg;
#-   int ret;
#-
#-   DEB2(printk(KERN_DEBUG "Beginning combined transaction\n"));
#-	for(i=3D0; i < num; i++) {
#-		pmsg =3D &msgs[i];
#-		if(pmsg->flags & I2C_M_RD) {
#-
#-			// Last read or write segment needs to be terminated with a stop
#-			if(i < num-1) {
#-				DEB2(printk(KERN_DEBUG "This one is a read\n"));
#-			}
#-			else {
#-				DEB2(printk(KERN_DEBUG "Doing the last read\n"));
#-			}
#-			ret =3D iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? II=
C_COMBINED_XFER : IIC_SINGLE_XFER);
#-
#-			if (ret !=3D pmsg->len) {
#-				DEB2(printk("i2c-algo-ppc405.o: fail: "
#-							"only read %d bytes.\n",ret));
#-				return i;
#-			}
#-			else {
#-				DEB2(printk("i2c-algo-ppc405.o: read %d bytes.\n",ret));
#-			}
#+/*
#+ * Wait for master transfer to complete.
#+ * It puts current process to sleep until we get interrupt or timeout exp=
ires.
#+ * Returns the number of transferred bytes or error (<0)
#+ */
#+static int iic_wait_for_tc(struct ibm_iic_private* dev){
#+=09
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	int ret =3D 0;
#+=09
#+	if (dev->irq >=3D 0){
#+		/* Interrupt mode */
#+		wait_queue_t wait;
#+    		init_waitqueue_entry(&wait, current);
#+	=09
#+		add_wait_queue(&dev->wq, &wait);
#+		set_current_state(TASK_INTERRUPTIBLE);
#+		if (in_8(&iic->sts) & STS_PT)
#+			schedule_timeout(dev->adap.timeout * HZ);
#+		set_current_state(TASK_RUNNING);
#+		remove_wait_queue(&dev->wq, &wait);
#+	=09
#+		if (unlikely(signal_pending(current))){
#+			DBG("%d: wait interrupted\n", dev->idx);
#+			ret =3D -ERESTARTSYS;
#+		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
#+			DBG("%d: wait timeout\n", dev->idx);
#+			ret =3D -ETIMEDOUT;
# 		}
#-		else if(!(pmsg->flags & I2C_M_RD)) {
#-
#-			// Last read or write segment needs to be terminated with a stop
#-			if(i < num-1) {
#-				DEB2(printk(KERN_DEBUG "This one is a write\n"));
#-			}
#-			else {
#-				DEB2(printk(KERN_DEBUG "Doing the last write\n"));
#-			}
#-			ret =3D iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, (i < num-1) ? II=
C_COMBINED_XFER : IIC_SINGLE_XFER);
#-
#-			if (ret !=3D pmsg->len) {
#-				DEB2(printk("i2c-algo-ppc405.o: fail: "
#-							"only wrote %d bytes.\n",ret));
#-				return i;
#+	}
#+	else {
#+		/* Polling mode */
#+		unsigned long x =3D jiffies + dev->adap.timeout * HZ;
#+	=09
#+		while (in_8(&iic->sts) & STS_PT){
#+			if (unlikely(time_after(jiffies, x))){
#+				DBG("%d: poll timeout\n", dev->idx);
#+				ret =3D -ETIMEDOUT;
#+				break;
# 			}
#-			else {
#-				DEB2(printk("i2c-algo-ppc405.o: wrote %d bytes.\n",ret));
#+	=09
#+			if (unlikely(signal_pending(current))){
#+				DBG("%d: poll interrupted\n", dev->idx);
#+				ret =3D -ERESTARTSYS;
#+				break;
# 			}
#-		}
#+			schedule();
#+		}=09
# 	}
#-=20
#-	return num;
#+=09
#+	if (unlikely(ret < 0))
#+		iic_abort_xfer(dev);
#+	else
#+		ret =3D iic_xfer_result(dev);
#+=09
#+	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
#+=09
#+	return ret;
# }
#=20
#-
#-//
#-// Description: Whenever we initiate a transaction, the first byte clocked
#-// onto the bus after the start condition is the address (7 bit) of the
#-// device we want to talk to.  This function manipulates the address spec=
ified
#-// so that it makes sense to the hardware when written to the IIC periphe=
ral.
#-//
#-// Note: 10 bit addresses are not supported in this driver, although they=
 are
#-// supported by the hardware.  This functionality needs to be implemented.
#-//
#-static inline int iic_doAddress(struct i2c_algo_iic_data *adap,
#-                                struct i2c_msg *msg, int retries)=20
#-{
#-	struct iic_regs *iic;
#-	unsigned short flags =3D msg->flags;
#-	unsigned char addr;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-//
#-// The following segment for 10 bit addresses needs to be ported
#-//
#-/* Ten bit addresses not supported right now
#-	if ( (flags & I2C_M_TEN)  ) {=20
#-		// a ten bit address
#-		addr =3D 0xf0 | (( msg->addr >> 7) & 0x03);
#-		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
#-		// try extended address code...
#-		ret =3D try_address(adap, addr, retries);
#-		if (ret!=3D1) {
#-			printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
#-			return -EREMOTEIO;
#-		}
#-		// the remaining 8 bit address
#-		iic_outb(adap,msg->addr & 0x7f);
#-		// Status check comes here
#-		if (ret !=3D 1) {
#-			printk(KERN_ERR "iic_doAddress: died at 2nd address code.\n");
#-			return -EREMOTEIO;
#-		}
#-		if ( flags & I2C_M_RD ) {
#-			i2c_repstart(adap);
#-			// okay, now switch into reading mode
#-			addr |=3D 0x01;
#-			ret =3D try_address(adap, addr, retries);
#-			if (ret!=3D1) {
#-				printk(KERN_ERR "iic_doAddress: died at extended address code.\n");
#-				return -EREMOTEIO;
#-			}
#+/*
#+ * Low level master transfer routine
#+ */
#+static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm=
,=20
#+			  int combined_xfer)
#+{
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	char* buf =3D pm->buf;
#+	int i, j, loops, ret =3D 0;
#+	int len =3D pm->len;
#+
#+	u8 cntl =3D (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
#+	if (pm->flags & I2C_M_RD)
#+		cntl |=3D CNTL_RW;
#+=09
#+	loops =3D (len + 3) / 4;
#+	for (i =3D 0; i < loops; ++i, len -=3D 4){
#+		int count =3D len > 4 ? 4 : len;
#+		u8 cmd =3D cntl | ((count - 1) << CNTL_TCT_SHIFT);
#+	=09
#+		if (!(cntl & CNTL_RW))
#+			for (j =3D 0; j < count; ++j)
#+				out_8((volatile u8*)&iic->mdbuf, *buf++);
#+	=09
#+		if (i < loops - 1)
#+			cmd |=3D CNTL_CHT;
#+		else if (combined_xfer)
#+			cmd |=3D CNTL_RPST;
#+	=09
#+		DBG2("%d: xfer_bytes, %d, CNTL =3D 0x%02x\n", dev->idx, count, cmd);
#+	=09
#+		/* Start transfer */
#+		out_8(&iic->cntl, cmd);
#+	=09
#+		/* Wait for completion */
#+		ret =3D iic_wait_for_tc(dev);
#+
#+		if (unlikely(ret < 0))
#+			break;
#+		else if (unlikely(ret !=3D count)){
#+			DBG("%d: xfer_bytes, requested %d, transfered %d\n",=20
#+				dev->idx, count, ret);
#+		=09
#+			/* If it's not a last part of xfer, abort it */
#+			if (combined_xfer || (i < loops - 1))
#+    				iic_abort_xfer(dev);
#+			=09
#+			ret =3D -EREMOTEIO;
#+			break;			=09
# 		}
#-	} else ----------> // normal 7 bit address
#-
#-Ten bit addresses not supported yet */
#-
#-	addr =3D ( msg->addr << 1 );
#-	if (flags & I2C_M_RD )
#-		addr |=3D 1;
#-	if (flags & I2C_M_REV_DIR_ADDR )
#-		addr ^=3D 1;
#-	//
#-	// Write to the low slave address
#-	//
#-	iic_outb(adap, iic->lmadr, addr);
#-	//
#-	// Write zero to the high slave register since we are
#-	// only using 7 bit addresses
#-	//
#-	iic_outb(adap, iic->hmadr, 0);
#-
#-	return 0;
#+	=09
#+		if (cntl & CNTL_RW)
#+			for (j =3D 0; j < count; ++j)
#+				*buf++ =3D in_8((volatile u8*)&iic->mdbuf);
#+	}
#+=09
#+	return ret > 0 ? 0 : ret;
# }
#=20
#+/*
#+ * Set target slave address for master transfer
#+ */
#+static inline void iic_address(struct ibm_iic_private* dev, struct i2c_ms=
g* msg)
#+{
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	u16 addr =3D msg->addr;
#+=09
#+	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,=20
#+		addr, msg->flags & I2C_M_TEN ? 10 : 7);
#+=09
#+	if (msg->flags & I2C_M_TEN){
#+	    out_8(&iic->cntl, CNTL_AMD);
#+	    out_8(&iic->lmadr, addr);
#+	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
#+	}
#+	else {
#+	    out_8(&iic->cntl, 0);
#+	    out_8(&iic->lmadr, addr << 1);
#+	}
#+}
#=20
#-//
#-// Description: Prepares the controller for a transaction (clearing status
#-// registers, data buffers, etc), and then calls either iic_readbytes or
#-// iic_sendbytes to do the actual transaction.
#-//
#-static int iic_xfer(struct i2c_adapter *i2c_adap,
#-		    struct i2c_msg msgs[],=20
#-		    int num)
#-{
#-	struct iic_regs *iic;
#-	struct i2c_algo_iic_data *adap =3D i2c_adap->algo_data;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	struct i2c_msg *pmsg;
#-	int i =3D 0;
#-	int ret;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-	pmsg =3D &msgs[i];
#-
#-	//
#-	// Clear status register
#-	//
#-	DEB2(printk(KERN_DEBUG "iic_xfer: iic_xfer: Clearing status register\n")=
);
#-	iic_outb(adap, iic->sts, 0x0a);
#-
#-	//
#-	// Wait for any pending transfers to complete
#-	//
#-	DEB2(printk(KERN_DEBUG "iic_xfer: Waiting for any pending transfers to c=
omplete\n"));
#-	while((ret =3D iic_inb(adap, iic->sts)) =3D 0x01) {
#-		;
#-	}
#-
#-	//
#-	// Flush master data buf
#-	//
#-	DEB2(printk(KERN_DEBUG "iic_xfer: Clearing master data buffer\n"));	=09
#-	ret =3D iic_inb(adap, iic->mdcntl);
#-	iic_outb(adap, iic->mdcntl, ret | 0x40);
#-
#-	//
#-	// Load slave address
#-	//
#-	DEB2(printk(KERN_DEBUG "iic_xfer: Loading slave address\n"));
#-	ret =3D iic_doAddress(adap, pmsg, i2c_adap->retries);
#-
#-        //
#-        // Check to see if the bus is busy
#-        //
#-        ret =3D iic_inb(adap, iic->extsts);
#-        // Mask off the irrelevent bits
#-        ret =3D ret & 0x70;
#-        // When the bus is free, the BCS bits in the EXTSTS register are =
0b100
#-        if(ret !=3D 0x40) return IIC_ERR_LOST_ARB;
#-
#-	//
#-	// Combined transaction (read and write)
#-	//
#-	if(num > 1) {
#-           DEB2(printk(KERN_DEBUG "iic_xfer: Call combined transaction\n"=
));
#-           ret =3D iic_combined_transaction(i2c_adap, msgs, num);
#-        }
#-	//
#-	// Read only
#-	//
#-	else if((num =3D 1) && (pmsg->flags & I2C_M_RD)) {
#-	   //
#-	   // Tell device to begin reading data from the  master data=20
#-	   //
#-	   DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's read\n"));
#-	   ret =3D iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER=
);
#-	}=20
#-        //
#-	// Write only
#-	//
#-	else if((num =3D 1 ) && (!(pmsg->flags & I2C_M_RD))) {
#-	   //
#-	   // Write data to master data buffers and tell our device
#-	   // to begin transmitting
#-	   //
#-	   DEB2(printk(KERN_DEBUG "iic_xfer: Call adapter's write\n"));
#-	   ret =3D iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER=
);
#-	}=09
#-
#-	return ret;  =20
#+static inline int iic_invalid_address(const struct i2c_msg* p)
#+{
#+	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f)=
);
# }
#=20
#+static inline int iic_address_neq(const struct i2c_msg* p1,=20
#+				  const struct i2c_msg* p2)
#+{
#+	return (p1->addr !=3D p2->addr)=20
#+		|| ((p1->flags & I2C_M_TEN) !=3D (p2->flags & I2C_M_TEN));
#+}=20
#=20
#-//
#-// Description: Implements device specific ioctls.  Higher level ioctls c=
an
#-// be found in i2c-core.c and are typical of any i2c controller (specifyi=
ng
#-// slave address, timeouts, etc).  These ioctls take advantage of any har=
dware
#-// features built into the controller for which this algorithm-adapter set
#-// was written.  These ioctls allow you to take control of the data and c=
lock
#-// lines on the IBM PPC 405 IIC controller and set the either high or low,
#-// similar to a GPIO pin.
#-//
#-static int algo_control(struct i2c_adapter *adapter,=20
#-	unsigned int cmd, unsigned long arg)
#-{
#-	struct iic_regs *iic;
#-	struct i2c_algo_iic_data *adap =3D adapter->algo_data;
#-	struct iic_ibm *adap_priv_data =3D adap->data;
#-	int ret=3D0;
#-	int lines;
#-	iic =3D (struct iic_regs *) adap_priv_data->iic_base;
#-
#-	lines =3D iic_inb(adap, iic->directcntl);
#-
#-	if (cmd =3D IICO_I2C_SDAHIGH) {
#-	      lines =3D lines & 0x01;
#-	      if( lines ) lines =3D 0x04;
#-	      else lines =3D 0;
#-	      iic_outb(adap, iic->directcntl,(0x08|lines));
#-	}
#-	else if (cmd =3D IICO_I2C_SDALOW) {
#-	      lines =3D lines & 0x01;
#-	      if( lines ) lines =3D 0x04;
#-              else lines =3D 0;
#-              iic_outb(adap, iic->directcntl,(0x00|lines));
#-	}
#-	else if (cmd =3D IICO_I2C_SCLHIGH) {
#-              lines =3D lines & 0x02;
#-              if( lines ) lines =3D 0x08;
#-              else lines =3D 0;
#-              iic_outb(adap, iic->directcntl,(0x04|lines));
#-	}
#-	else if (cmd =3D IICO_I2C_SCLLOW) {
#-              lines =3D lines & 0x02;
#-	      if( lines ) lines =3D 0x08;
#-              else lines =3D 0;
#-              iic_outb(adap, iic->directcntl,(0x00|lines));
#+/*
#+ * Generic master transfer entrypoint.=20
#+ * Returns the number of processed messages or error (<0)
#+ */
#+static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int =
num)
#+{
#+    	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)(i2c_get_ad=
apdata(adap));
#+	volatile struct iic_regs *iic =3D dev->vaddr;
#+	int i, ret =3D 0;
#+=09
#+	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
#+=09
#+	if (!num)
#+		return 0;
#+=09
#+	/* Check the sanity of the passed messages.
#+	 * Uhh, generic i2c layer is more suitable place for such code...
#+	 */
#+	if (unlikely(iic_invalid_address(&msgs[0]))){
#+		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,=20
#+			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
#+		return -EINVAL;
#+	}	=09
#+	for (i =3D 0; i < num; ++i){
#+		if (unlikely(msgs[i].len <=3D 0)){
#+			DBG("%d: invalid len %d in msg[%d]\n", dev->idx,=20
#+				msgs[i].len, i);
#+			return -EINVAL;
#+		}
#+		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
#+			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
#+			return -EINVAL;
#+		}
# 	}
#-	else if (cmd =3D IICO_I2C_LINEREAD) {
#-	      ret =3D lines;
#+=09
#+	/* Check bus state */
#+	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE=
)){
#+		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
#+	=09
#+		/* Usually it means something serious has happend.
#+		 * We *cannot* have unfinished previous transfer
#+		 * so it doesn't make any sense to try to stop it.
#+		 * Probably we were not able to recover from the=20
#+		 * previous error.
#+		 * The only *reasonable* thing I can think of here
#+		 * is soft reset.  --ebs
#+		 */
#+		iic_dev_reset(dev);
#+	=09
#+		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
#+			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
#+			return -EREMOTEIO;
#+		}
#+	}=20
#+	else {
#+		/* Flush master data buffer (just in case) */
#+		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
# 	}
#-	return ret;
#-}
#+=09
#+	/* Load slave address */
#+	iic_address(dev, &msgs[0]);
#+=09
#+	/* Do real transfer */
#+    	for (i =3D 0; i < num && !ret; ++i)
#+		ret =3D iic_xfer_bytes(dev, &msgs[i], i < num - 1);
#=20
#+	return ret < 0 ? ret : num;
#+}
#=20
# static u32 iic_func(struct i2c_adapter *adap)
# {
#-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |=20
#-	       I2C_FUNC_PROTOCOL_MANGLING;=20
#+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
# }
#=20
#-
#-/* -----exported algorithm data: -------------------------------------	*/
#-
# static struct i2c_algorithm iic_algo =3D {
#-	.name		=3D "IBM on-chip IIC algorithm",
#-	.id		=3D I2C_ALGO_OCP,
#-	.master_xfer	=3D iic_xfer,
#-	.algo_control	=3D algo_control,
#-	.functionality	=3D iic_func,
#+	.name 		=3D "IBM IIC algorithm",
#+	.id   		=3D I2C_ALGO_OCP,
#+	.master_xfer 	=3D iic_xfer,
#+	.smbus_xfer	=3D NULL,
#+	.slave_send	=3D NULL,
#+	.slave_recv	=3D NULL,
#+	.algo_control	=3D NULL,
#+	.functionality	=3D iic_func
# };
#=20
#-/*=20
#- * registering functions to load algorithms at runtime=20
#+/*
#+ * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
#+ * We only scan range [0x08 - 0x77], all other addresses are reserved any=
way
#  */
#+static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
#+{
#+	int found =3D 0;
#+	char dummy;
#+	struct i2c_msg msg =3D {
#+		.buf   =3D &dummy,
#+		.len   =3D sizeof(dummy),
#+		.flags =3D I2C_M_RD
#+	};
#+=09
#+	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
#+=09
#+	for (msg.addr =3D 8; msg.addr < 0x78; ++msg.addr)
#+		if (iic_xfer(&dev->adap, &msg, 1) =3D 1){
#+			++found;
#+			printk(" 0x%02x", msg.addr);
#+		}
#=20
#+	printk("%sibm-iic%d: %d device(s) detected\n",=20
#+		found ? "\n" KERN_INFO : "", dev->idx, found);
#+}
#=20
#-//
#-// Description: Register bus structure
#-//
#-int i2c_ocp_add_bus(struct i2c_adapter *adap)
#+/*
#+ * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
#+ */
#+static inline u8 iic_clckdiv(unsigned int opb)
# {
#-	struct i2c_algo_iic_data *iic_adap =3D adap->algo_data;
#+	/* Compatibility kludge, should go away after all cards
#+	 * are fixed to fill correct value for opbfreq.
#+	 * Previous driver version used hardcoded divider value 4,
#+	 * it corresponds to OPB frequency from the range (40, 50] MHz
#+	 */
#+	if (!opb){
#+		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
#+			" fix your board specific setup\n");
#+		opb =3D 50000000;
#+	}
#=20
#-	DEB2(printk(KERN_DEBUG "i2c-algo-iic.o: hw routines for %s registered.\n=
",
#-	            adap->name));
#+	/* Convert to MHz */
#+	opb /=3D 1000000;
#+=09
#+	if (opb < 20 || opb > 150){
#+		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
#+			opb);
#+		opb =3D opb < 20 ? 20 : 150;
#+	}
#+	return (u8)((opb + 9) / 10 - 1);
#+}
#+
#+/*
#+ * Register single IIC interface
#+ */
#+static int __devinit iic_probe(struct ocp_device *ocp){
#+
#+	struct ibm_iic_private* dev;
#+	struct i2c_adapter* adap;
#+	int ret;
#+	bd_t* bd =3D (bd_t*)&__res;
#+=09
#+	if (!(dev =3D kmalloc(sizeof(*dev), GFP_KERNEL))){
#+		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
#+		return -ENOMEM;
#+	}
#=20
#-	/* register new adapter to i2c module... */
#+	memset(dev, 0, sizeof(*dev));
#+	dev->idx =3D ocp->num;
#+	ocp_set_drvdata(ocp, dev);
#+=09
#+	if (!(dev->vaddr =3D ioremap(ocp->paddr, sizeof(struct iic_regs)))){
#+		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
#+			dev->idx);
#+		ret =3D -ENXIO;
#+		goto fail2;
#+	}
#+=09
#+	init_waitqueue_head(&dev->wq);
#=20
#-	adap->id |=3D iic_algo.id;
#+	dev->irq =3D iic_force_poll ? -1 : ocp->irq;
#+	if (dev->irq >=3D 0){
#+		/* Disable interrupts until we finish intialization,
#+		   assumes level-sensitive IRQ setup...
#+		 */
#+		iic_interrupt_mode(dev, 0);
#+		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
#+			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",=20
#+				dev->idx, dev->irq);
#+			/* Fallback to the polling mode */=09
#+			dev->irq =3D -1;
#+		}
#+	}
#+=09
#+	if (dev->irq < 0)
#+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",=20
#+			dev->idx);
#+	=09
#+	/* Board specific settings */
#+	BUG_ON(dev->idx >=3D sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]=
));
#+	dev->fast_mode =3D iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
#+=09
#+	/* clckdiv is the same for *all* IIC interfaces,=20
#+	 * but I'd rather make a copy than introduce another global. --ebs
#+	 */
#+	dev->clckdiv =3D iic_clckdiv(bd->bi_opb_busfreq);
#+	DBG("%d: clckdiv =3D %d\n", dev->idx, dev->clckdiv);
#+=09
#+	/* Initialize IIC interface */
#+	iic_dev_init(dev);
#+=09
#+	/* Register it with i2c layer */
#+	adap =3D &dev->adap;
#+	strcpy(adap->dev.name, "IBM IIC");
#+	i2c_set_adapdata(adap, dev);
#+	adap->id =3D I2C_HW_OCP | iic_algo.id;
# 	adap->algo =3D &iic_algo;
#+	adap->client_register =3D NULL;
#+	adap->client_unregister =3D NULL;
#+	adap->timeout =3D 1;
#+	adap->retries =3D 1;
#+
#+	if ((ret =3D i2c_add_adapter(adap)) !=3D 0){
#+		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
#+			dev->idx);
#+		goto fail;
#+	}
#+=09
#+	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
#+		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
#=20
#-	adap->timeout =3D 100;	/* default values, should	*/
#-	adap->retries =3D 3;		/* be replaced by defines	*/
#+	/* Scan bus if requested by user */
#+	if (iic_scan)
#+		iic_scan_bus(dev);
#=20
#-	iic_init(iic_adap);
#-	i2c_add_adapter(adap);
# 	return 0;
#-}
#=20
#+fail:=09
#+	if (dev->irq >=3D 0){
#+		iic_interrupt_mode(dev, 0);
#+		free_irq(dev->irq, dev);
#+	}=09
#+
#+	iounmap((void*)dev->vaddr);
#+fail2:=09
#+	ocp_set_drvdata(ocp, 0);
#+	kfree(dev);=09
#+	return ret;
#+}
#=20
#-//
#-// Done
#-//
#-int i2c_ocp_del_bus(struct i2c_adapter *adap)
#+/*
#+ * Cleanup initialized IIC interface
#+ */
#+static void __devexit iic_remove(struct ocp_device *ocp)
# {
#-	return i2c_del_adapter(adap);
#+	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)ocp_get_drvdata=
(ocp);
#+	BUG_ON(dev =3D NULL);
#+	if (i2c_del_adapter(&dev->adap)){
#+		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
#+			dev->idx);
#+		/* That's *very* bad, just shutdown IRQ ... */
#+		if (dev->irq >=3D 0){
#+		    iic_interrupt_mode(dev, 0);=09
#+		    free_irq(dev->irq, dev);
#+		    dev->irq =3D -1;
#+		}
#+	} else {
#+		if (dev->irq >=3D 0){
#+		    iic_interrupt_mode(dev, 0);=09
#+		    free_irq(dev->irq, dev);
#+		}
#+		iounmap((void*)dev->vaddr);
#+		kfree(dev);
#+	}
# }
#=20
#+static struct ocp_device_id ibm_iic_ids[] __devinitdata =3D=20
#+{
#+	{ .vendor =3D OCP_VENDOR_IBM, .device =3D OCP_FUNC_IIC },
#+	{ .vendor =3D OCP_VENDOR_INVALID }
#+};
#=20
#-EXPORT_SYMBOL(i2c_ocp_add_bus);
#-EXPORT_SYMBOL(i2c_ocp_del_bus);
#+MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
#=20
#-//
#-// The MODULE_* macros resolve to nothing if MODULES is not defined
#-// when this file is compiled.
#-//
#-MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
#-MODULE_DESCRIPTION("PPC 405 iic algorithm");
#-MODULE_LICENSE("GPL");
#+static struct ocp_driver ibm_iic_driver #+{
#+	.name 		=3D "ocp_iic",
#+	.id_table	=3D ibm_iic_ids,
#+	.probe		=3D iic_probe,
#+	.remove		=3D __devexit_p(iic_remove),
#+#if defined(CONFIG_PM)
#+	.suspend	=3D NULL,
#+	.resume		=3D NULL,
#+#endif
#+};
#=20
#-MODULE_PARM(i2c_debug,"i");
#+static int __init iic_init(void)
#+{
#+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
#+	return ocp_module_init(&ibm_iic_driver);
#+}
#=20
#-MODULE_PARM_DESC(i2c_debug,
#-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol"=
);
#+static void __exit iic_exit(void)
#+{
#+	ocp_unregister_driver(&ibm_iic_driver);
#+}
#=20
#+module_init(iic_init);
#+module_exit(iic_exit);
#
#--- 1.2/drivers/i2c/i2c-algo-ibm_ocp.h	Sat Sep 21 13:00:21 2002
#+++ 1.4/drivers/i2c/i2c-ibm_iic.h	Fri Sep 12 12:31:23 2003
#@@ -1,55 +1,124 @@
#-/* ----------------------------------------------------------------------=
--- */
#-/* i2c-algo-ibm_ocp.h i2c driver algorithms for IBM PPC 405 IIC adapters =
        */
#-/* ----------------------------------------------------------------------=
--- */
#-/*   Copyright (C) 1995-97 Simon G. Vogl
#-                   1998-99 Hans Berglund
#-
#-    This program is free software; you can redistribute it and/or modify
#-    it under the terms of the GNU General Public License as published by
#-    the Free Software Foundation; either version 2 of the License, or
#-    (at your option) any later version.
#-
#-    This program is distributed in the hope that it will be useful,
#-    but WITHOUT ANY WARRANTY; without even the implied warranty of
#-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#-    GNU General Public License for more details.
#-
#-    You should have received a copy of the GNU General Public License
#-    along with this program; if not, write to the Free Software
#-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.            =
    */
#-/* ----------------------------------------------------------------------=
--- */
#-
#-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
#-   Frodo Looijaard <frodol@dds.nl> */
#-
#-/* Modifications by MontaVista Software, August 2000
#-   Changes made to support the IIC peripheral on the IBM PPC 405 */
#-
#-#ifndef I2C_ALGO_IIC_H
#-#define I2C_ALGO_IIC_H 1
#-
#-/* --- Defines for pcf-adapters ---------------------------------------	*/
#-#include <linux/i2c.h>
#-
#-struct i2c_algo_iic_data {
#-	struct iic_regs *data;		/* private data for lolevel routines	*/
#-	void (*setiic) (void *data, int ctl, int val);
#-	int  (*getiic) (void *data, int ctl);
#-	int  (*getown) (void *data);
#-	int  (*getclock) (void *data);
#-	void (*waitforpin) (void *data);    =20
#-
#-	/* local settings */
#-	int udelay;
#-	int mdelay;
#-	int timeout;
#+/*
#+ * drivers/i2c/i2c-ibm_iic.h
#+ *
#+ * Support for the IIC peripheral on IBM PPC 4xx
#+ *=20
#+ * Copyright (c) 2003 Zultys Technologies.
#+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
#+ *
#+ * Based on original work by=20
#+ * 	Ian DaSilva  <idasilva@mvista.com>
#+ *      Armin Kuster <akuster@mvista.com>
#+ * 	Matt Porter  <mporter@mvista.com>
#+ *
#+ *      Copyright 2000-2003 MontaVista Software Inc.
#+ *
#+ * This program is free software; you can redistribute  it and/or modify =
it
#+ * under  the terms of  the GNU General  Public License as published by t=
he
#+ * Free Software Foundation;  either version 2 of the  License, or (at yo=
ur
#+ * option) any later version.
#+ *
#+ */
#+#ifndef __I2C_IBM_IIC_H_
#+#define __I2C_IBM_IIC_H_
#+
#+#include <linux/config.h>
#+#include <linux/i2c.h>=20
#+
#+struct iic_regs {
#+	u16 mdbuf;
#+	u16 sbbuf;
#+	u8 lmadr;
#+	u8 hmadr;
#+	u8 cntl;
#+	u8 mdcntl;
#+	u8 sts;
#+	u8 extsts;
#+	u8 lsadr;
#+	u8 hsadr;
#+	u8 clkdiv;
#+	u8 intmsk;
#+	u8 xfrcnt;
#+	u8 xtcntlss;
#+	u8 directcntl;
# };
#=20
#+struct ibm_iic_private {
#+	struct i2c_adapter adap;
#+	volatile struct iic_regs *vaddr;
#+	wait_queue_head_t wq;
#+	int idx;
#+	int irq;
#+	int fast_mode;
#+	u8  clckdiv;
#+};
#=20
#-#define I2C_IIC_ADAP_MAX	16
#-
#+/* IICx_CNTL register */
#+#define CNTL_HMT	0x80
#+#define CNTL_AMD	0x40
#+#define CNTL_TCT_MASK	0x30
#+#define CNTL_TCT_SHIFT	4
#+#define CNTL_RPST	0x08
#+#define CNTL_CHT	0x04=20
#+#define CNTL_RW		0x02
#+#define CNTL_PT		0x01
#+
#+/* IICx_MDCNTL register */
#+#define MDCNTL_FSDB	0x80
#+#define MDCNTL_FMDB	0x40
#+#define MDCNTL_EGC	0x20
#+#define MDCNTL_FSM	0x10
#+#define MDCNTL_ESM	0x08
#+#define MDCNTL_EINT	0x04
#+#define MDCNTL_EUBS	0x02
#+#define MDCNTL_HSCL	0x01
#+
#+/* IICx_STS register */
#+#define STS_SSS		0x80
#+#define STS_SLPR	0x40
#+#define STS_MDBS	0x20
#+#define STS_MDBF	0x10
#+#define STS_SCMP	0x08
#+#define STS_ERR		0x04
#+#define STS_IRQA	0x02
#+#define STS_PT		0x01
#+
#+/* IICx_EXTSTS register */
#+#define EXTSTS_IRQP	0x80
#+#define EXTSTS_BCS_MASK	0x70
#+#define   EXTSTS_BCS_FREE  0x40
#+#define EXTSTS_IRQD	0x08
#+#define EXTSTS_LA	0x04
#+#define EXTSTS_ICT	0x02
#+#define EXTSTS_XFRA	0x01
#+
#+/* IICx_INTRMSK register */
#+#define INTRMSK_EIRC	0x80
#+#define INTRMSK_EIRS	0x40
#+#define INTRMSK_EIWC	0x20
#+#define INTRMSK_EIWS	0x10
#+#define INTRMSK_EIHE	0x08
#+#define INTRMSK_EIIC	0x04
#+#define INTRMSK_EITA	0x02
#+#define INTRMSK_EIMTC	0x01
#+
#+/* IICx_XFRCNT register */
#+#define XFRCNT_MTC_MASK	0x07
#+
#+/* IICx_XTCNTLSS register */
#+#define XTCNTLSS_SRC	0x80
#+#define XTCNTLSS_SRS	0x40
#+#define XTCNTLSS_SWC	0x20
#+#define XTCNTLSS_SWS	0x10
#+#define XTCNTLSS_SRST	0x01
#+
#+/* IICx_DIRECTCNTL register */
#+#define DIRCNTL_SDAC	0x08
#+#define DIRCNTL_SCC	0x04
#+#define DIRCNTL_MSDA	0x02
#+#define DIRCNTL_MSC	0x01
#=20
#-int i2c_ocp_add_bus(struct i2c_adapter *);
#-int i2c_ocp_del_bus(struct i2c_adapter *);
#+/* Check if we really control the I2C bus and bus is free */
#+#define DIRCTNL_FREE(v)	(((v) & 0x0f) =3D 0x0f)
#=20
#-#endif /* I2C_ALGO_IIC_H */
#+#endif /* __I2C_IBM_IIC_H_ */
#
#--- 1.12/drivers/i2c/Makefile	Sun Jun 15 16:57:44 2003
#+++ 1.13/drivers/i2c/Makefile	Fri Sep 12 12:30:34 2003
#@@ -16,6 +16,7 @@
# obj-$(CONFIG_ITE_I2C_ADAP)	+=3D i2c-adap-ite.o
# obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o
# obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
#+obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o
# obj-$(CONFIG_I2C_SENSOR)	+=3D i2c-sensor.o
# obj-$(CONFIG_I2C_IOP3XX)	+=3D i2c-iop3xx.o
# obj-y				+=3D busses/ chips/
#
#--- 1.14/drivers/i2c/Kconfig	Tue Aug 26 11:58:28 2003
#+++ 1.15/drivers/i2c/Kconfig	Fri Sep 12 12:30:34 2003
#@@ -203,13 +203,9 @@
# 	tristate "Embedded Planet RPX Lite/Classic suppoort"
# 	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
#=20
#-config I2C_IBM_OCP_ALGO
#-	tristate "IBM on-chip I2C Algorithm"
#+config I2C_IBM_IIC
#+	tristate "IBM IIC I2C"
# 	depends on IBM_OCP && I2C
#-
#-config I2C_IBM_OCP_ADAP
#-	tristate "IBM on-chip I2C Adapter"
#-	depends on I2C_IBM_OCP_ALGO
#=20
# config I2C_IOP3XX
# 	tristate "Intel XScale IOP3xx on-chip I2C interface"
#

# Diff checksum=155f2d45


# Patch vers:	1.3
# Patch type:	REGULAR

=3D ChangeSet =3D
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed0248=
64
torvalds@home.osdl.org|ChangeSet|20030912042307|22597
D 1.1316 03/09/12 12:36:24-07:00 mporter@kernel.crashing.org +4 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
C
c I2C: Add rewritten PPC4xx I2C driver
K 23626
P ChangeSet
------------------------------------------------

0a0
> zippel@linux-m68k.org[torvalds]|drivers/i2c/Kconfig|20021030043228|25271|=
93781e6749f2f6e9 mporter@kernel.crashing.org|drivers/i2c/Kconfig|2003091219=
3034|46908
> torvalds@athlon.transmeta.com|drivers/i2c/Makefile|20020205174018|59980|6=
99ee8af74f52ec9 mporter@kernel.crashing.org|drivers/i2c/Makefile|2003091219=
3034|58226
> ac9410@attbi.com|drivers/i2c/i2c-algo-ibm_ocp.c|20020814030432|31847|15fe=
bbe23542f55 mporter@kernel.crashing.org|drivers/i2c/i2c-ibm_iic.c|200309121=
93123|39319
> ac9410@attbi.com|drivers/i2c/i2c-algo-ibm_ocp.h|20020814030433|04184|75cb=
964c98b96883 mporter@kernel.crashing.org|drivers/i2c/i2c-ibm_iic.h|20030912=
193123|13276

=3D drivers/i2c/i2c-ibm_iic.c =3D
ac9410@attbi.com|drivers/i2c/i2c-algo-ibm_ocp.c|20020814030432|31847|15febb=
e23542f55
hch@sgi.com[torvalds]|drivers/i2c/i2c-algo-ibm_ocp.c|20030311202111|03164
D 1.6 03/09/12 12:21:03-07:00 mporter@kernel.crashing.org +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
c Rename: drivers/i2c/i2c-algo-ibm_ocp.c -> drivers/i2c/i2c-ibm_iic.c
K 1891
O -rw-rw-r--
P drivers/i2c/i2c-ibm_iic.c
------------------------------------------------


mporter@kernel.crashing.org|drivers/i2c/i2c-ibm_iic.c|20030912192103|01891
D 1.7 03/09/12 12:31:23-07:00 mporter@kernel.crashing.org +649 -820
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
C
c Rewritten PPC4xx I2C driver
K 39319
O -rw-rw-r--
P drivers/i2c/i2c-ibm_iic.c
------------------------------------------------

D2 53
I54 28
 * drivers/i2c/i2c-ibm_iic.c
 *
 * Support for the IIC peripheral on IBM PPC 4xx
 *
 * Copyright (c) 2003 Zultys Technologies.
 * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
 *
 * Based on original work by=20
 * 	Ian DaSilva  <idasilva@mvista.com>
 *      Armin Kuster <akuster@mvista.com>
 * 	Matt Porter  <mporter@mvista.com>
 *
 *      Copyright 2000-2003 MontaVista Software Inc.
 *
 * Original driver version was highly leveraged from i2c-elektor.c
 *
 *   	Copyright 1995-97 Simon G. Vogl
 *                1998-99 Hans Berglund
 *
 *   	With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi>=20
 *	and even Frodo Looijaard <frodol@dds.nl>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */
I55 2
#include <linux/kernel.h>
#include <linux/ioport.h>
D59 2
I60 3
#include <linux/interrupt.h>
#include <asm/irq.h>
#include <asm/io.h>
D62 1
I62 1
#include <linux/i2c-id.h>
I63 1
#include <asm/ibm4xx.h>
I64 1
#include "i2c-ibm_iic.h"
D66 10
I75 1
#define DRIVER_VERSION "2.0"
I76 2
MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
MODULE_LICENSE("GPL");
D78 14
I91 11
static int iic_scan =3D 0;
MODULE_PARM(iic_scan, "i");
MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
\
static int iic_force_poll =3D 0;
MODULE_PARM(iic_force_poll, "i");
MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
\
static int iic_force_fast =3D 0;
MODULE_PARM(iic_force_fast, "i");
MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
D93 2
I94 1
#define DBG_LEVEL 0
D96 3
I98 3
#ifdef DBG
#undef DBG
#endif
D100 1
I100 3
#ifdef DBG2
#undef DBG2
#endif
I101 27
#if DBG_LEVEL > 0
#  define DBG(x...)	printk(KERN_DEBUG "ibm-iic" ##x)
#else
#  define DBG(x...)	((void)0)
#endif
#if DBG_LEVEL > 1
#  define DBG2(x...) 	DBG( ##x )
#else
#  define DBG2(x...) 	((void)0)
#endif
#if DBG_LEVEL > 2
static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
{
	volatile struct iic_regs *iic =3D dev->vaddr;
	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
	printk(KERN_DEBUG "  cntl     =3D 0x%02x, mdcntl =3D 0x%02x\n"
	       KERN_DEBUG "  sts      =3D 0x%02x, extsts =3D 0x%02x\n"
	       KERN_DEBUG "  clkdiv   =3D 0x%02x, xfrcnt =3D 0x%02x\n"
	       KERN_DEBUG "  xtcntlss =3D 0x%02x, directcntl =3D 0x%02x\n",
		in_8(&iic->cntl), in_8(&iic->mdcntl), in_8(&iic->sts),=20
		in_8(&iic->extsts), in_8(&iic->clkdiv), in_8(&iic->xfrcnt),=20
		in_8(&iic->xtcntlss), in_8(&iic->directcntl));
}
#  define DUMP_REGS(h,dev)	dump_iic_regs((h),(dev))
#else
#  define DUMP_REGS(h,dev)	((void)0)
#endif
D103 4
I106 2
/* Enable/disable interrupt generation */
static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enab=
le)
D108 1
I108 1
	out_8(&dev->vaddr->intmsk, enable ? INTRMSK_EIMTC : 0);
D110 7
I116 5
=20
/*
 * Initialize IIC interface.
 */
static void iic_dev_init(struct ibm_iic_private* dev)
D118 16
I133 1
	volatile struct iic_regs *iic =3D dev->vaddr;
D135 20
I154 24
	DBG("%d: init\n", dev->idx);
=09
	/* Clear master address */
	out_8(&iic->lmadr, 0);
	out_8(&iic->hmadr, 0);
\
	/* Clear slave address */
	out_8(&iic->lsadr, 0);
	out_8(&iic->hsadr, 0);
\
	/* Clear status & extended status */
	out_8(&iic->sts, STS_SCMP | STS_IRQA);
	out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD | EXTSTS_LA
			    | EXTSTS_ICT | EXTSTS_XFRA);
\
	/* Set clock divider */
	out_8(&iic->clkdiv, dev->clckdiv);
\
	/* Clear transfer count */
	out_8(&iic->xfrcnt, 0);
\
	/* Clear extended control and status */
	out_8(&iic->xtcntlss, XTCNTLSS_SRC | XTCNTLSS_SRS | XTCNTLSS_SWC
			    | XTCNTLSS_SWS);
D156 3
I158 5
	/* Clear control register */
	out_8(&iic->cntl, 0);
=09
	/* Enable interrupts if possible */
	iic_interrupt_mode(dev, dev->irq >=3D 0);
D160 2
I161 3
	/* Set mode control */
	out_8(&iic->mdcntl, MDCNTL_FMDB | MDCNTL_EINT | MDCNTL_EUBS
			    | (dev->fast_mode ? MDCNTL_FSM : 0));
D163 2
I164 1
	DUMP_REGS("iic_init", dev);
D167 7
I173 4
/*=20
 * Reset IIC interface
 */
static void iic_dev_reset(struct ibm_iic_private* dev)
I174 42
	volatile struct iic_regs *iic =3D dev->vaddr;
	int i;
	u8 dc;
=09
	DBG("%d: soft reset\n", dev->idx);
	DUMP_REGS("reset", dev);
=09
    	/* Place chip in the reset state */
	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
=09
	/* Check if bus is free */
	dc =3D in_8(&iic->directcntl);=09
	if (!DIRCTNL_FREE(dc)){
		DBG("%d: trying to regain bus control\n", dev->idx);
=09
		/* Try to set bus free state */
		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);=09
=09
		/* Wait until we regain bus control */
		for (i =3D 0; i < 100; ++i){
			dc =3D in_8(&iic->directcntl);
			if (DIRCTNL_FREE(dc))
				break;
		=09
			/* Toggle SCL line */
			dc ^=3D DIRCNTL_SCC;
			out_8(&iic->directcntl, dc);
			udelay(10);
			dc ^=3D DIRCNTL_SCC;
			out_8(&iic->directcntl, dc);
		=09
			/* be nice */
			cond_resched();
		}
	}
=09
	/* Remove reset */
	out_8(&iic->xtcntlss, 0);
=09
	/* Reinitialize interface */
	iic_dev_init(dev);
}
D176 9
I184 17
/*
 * IIC interrupt handler
 */
static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *regs)
{
	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;
	volatile struct iic_regs* iic =3D dev->vaddr;
=09
	DBG2("%d: irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",=20
	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
=09
	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
	out_8(&iic->sts, STS_IRQA | STS_SCMP);
	wake_up_interruptible(&dev->wq);
=09
	return IRQ_HANDLED;
}
D186 43
I228 29
/*
 * Get master transfer result and clear errors if any.
 * Returns the number of actually transferred bytes or error (<0)
 */
static int iic_xfer_result(struct ibm_iic_private* dev)
{
	volatile struct iic_regs *iic =3D dev->vaddr;=09
=09
	if (unlikely(in_8(&iic->sts) & STS_ERR)){
		DBG("%d: xfer error, EXTSTS =3D 0x%02x\n", dev->idx,=20
			in_8(&iic->extsts));
			=09
		/* Clear errors and possible pending IRQs */
		out_8(&iic->extsts, EXTSTS_IRQP | EXTSTS_IRQD |=20
			EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA);
		=09
		/* Flush master data buffer */
		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
	=09
		/* Is bus free?
		 * If error happened during combined xfer
		 * IIC interface is usually stuck in some strange
		 * state, the only way out - soft reset.
		 */
		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
			DBG("%d: bus is stuck, resetting\n", dev->idx);
			iic_dev_reset(dev);
		}
		return -EREMOTEIO;
D231 1
I231 1
		return in_8(&iic->xfrcnt) & XFRCNT_MTC_MASK;
I233 25
/*
 * Try to abort active transfer.
 */
static void iic_abort_xfer(struct ibm_iic_private* dev)
{
	volatile struct iic_regs *iic =3D dev->vaddr;
	unsigned long x;
=09
	DBG("%d: iic_abort_xfer\n", dev->idx);
=09
	out_8(&iic->cntl, CNTL_HMT);
=09
	/*
	 * Wait for the abort command to complete.
	 * It's not worth to be optimized, just poll (timeout >=3D 1 tick)
	 */
	x =3D jiffies + 2;
	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
		if (time_after(jiffies, x)){
			DBG("%d: abort timeout, resetting...\n", dev->idx);
			iic_dev_reset(dev);
			return;
		}
		schedule();
	}
D235 38
I272 2
	/* Just to clear errors */
	iic_xfer_result(dev);
D275 316
I590 28
/*
 * Wait for master transfer to complete.
 * It puts current process to sleep until we get interrupt or timeout expir=
es.
 * Returns the number of transferred bytes or error (<0)
 */
static int iic_wait_for_tc(struct ibm_iic_private* dev){
=09
	volatile struct iic_regs *iic =3D dev->vaddr;
	int ret =3D 0;
=09
	if (dev->irq >=3D 0){
		/* Interrupt mode */
		wait_queue_t wait;
    		init_waitqueue_entry(&wait, current);
	=09
		add_wait_queue(&dev->wq, &wait);
		set_current_state(TASK_INTERRUPTIBLE);
		if (in_8(&iic->sts) & STS_PT)
			schedule_timeout(dev->adap.timeout * HZ);
		set_current_state(TASK_RUNNING);
		remove_wait_queue(&dev->wq, &wait);
	=09
		if (unlikely(signal_pending(current))){
			DBG("%d: wait interrupted\n", dev->idx);
			ret =3D -ERESTARTSYS;
		} else if (unlikely(in_8(&iic->sts) & STS_PT)){
			DBG("%d: wait timeout\n", dev->idx);
			ret =3D -ETIMEDOUT;
D592 15
I606 10
	}
	else {
		/* Polling mode */
		unsigned long x =3D jiffies + dev->adap.timeout * HZ;
	=09
		while (in_8(&iic->sts) & STS_PT){
			if (unlikely(time_after(jiffies, x))){
				DBG("%d: poll timeout\n", dev->idx);
				ret =3D -ETIMEDOUT;
				break;
D608 2
I609 5
	=09
			if (unlikely(signal_pending(current))){
				DBG("%d: poll interrupted\n", dev->idx);
				ret =3D -ERESTARTSYS;
				break;
D611 1
I611 2
			schedule();
		}=09
D613 2
I614 9
=09
	if (unlikely(ret < 0))
		iic_abort_xfer(dev);
	else
		ret =3D iic_xfer_result(dev);
=09
	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
=09
	return ret;
D617 49
I665 49
/*
 * Low level master transfer routine
 */
static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm, =

			  int combined_xfer)
{
	volatile struct iic_regs *iic =3D dev->vaddr;
	char* buf =3D pm->buf;
	int i, j, loops, ret =3D 0;
	int len =3D pm->len;
\
	u8 cntl =3D (in_8(&iic->cntl) & CNTL_AMD) | CNTL_PT;
	if (pm->flags & I2C_M_RD)
		cntl |=3D CNTL_RW;
=09
	loops =3D (len + 3) / 4;
	for (i =3D 0; i < loops; ++i, len -=3D 4){
		int count =3D len > 4 ? 4 : len;
		u8 cmd =3D cntl | ((count - 1) << CNTL_TCT_SHIFT);
	=09
		if (!(cntl & CNTL_RW))
			for (j =3D 0; j < count; ++j)
				out_8((volatile u8*)&iic->mdbuf, *buf++);
	=09
		if (i < loops - 1)
			cmd |=3D CNTL_CHT;
		else if (combined_xfer)
			cmd |=3D CNTL_RPST;
	=09
		DBG2("%d: xfer_bytes, %d, CNTL =3D 0x%02x\n", dev->idx, count, cmd);
	=09
		/* Start transfer */
		out_8(&iic->cntl, cmd);
	=09
		/* Wait for completion */
		ret =3D iic_wait_for_tc(dev);
\
		if (unlikely(ret < 0))
			break;
		else if (unlikely(ret !=3D count)){
			DBG("%d: xfer_bytes, requested %d, transfered %d\n",=20
				dev->idx, count, ret);
		=09
			/* If it's not a last part of xfer, abort it */
			if (combined_xfer || (i < loops - 1))
    				iic_abort_xfer(dev);
			=09
			ret =3D -EREMOTEIO;
			break;			=09
D667 20
I686 7
	=09
		if (cntl & CNTL_RW)
			for (j =3D 0; j < count; ++j)
				*buf++ =3D in_8((volatile u8*)&iic->mdbuf);
	}
=09
	return ret > 0 ? 0 : ret;
I688 21
/*
 * Set target slave address for master transfer
 */
static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg*=
 msg)
{
	volatile struct iic_regs *iic =3D dev->vaddr;
	u16 addr =3D msg->addr;
=09
	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,=20
		addr, msg->flags & I2C_M_TEN ? 10 : 7);
=09
	if (msg->flags & I2C_M_TEN){
	    out_8(&iic->cntl, CNTL_AMD);
	    out_8(&iic->lmadr, addr);
	    out_8(&iic->hmadr, 0xf0 | ((addr >> 7) & 0x06));
	}
	else {
	    out_8(&iic->cntl, 0);
	    out_8(&iic->lmadr, addr << 1);
	}
}
D690 85
I774 3
static inline int iic_invalid_address(const struct i2c_msg* p)
{
	return (p->addr > 0x3ff) || (!(p->flags & I2C_M_TEN) && (p->addr > 0x7f));
I776 6
static inline int iic_address_neq(const struct i2c_msg* p1,=20
				  const struct i2c_msg* p2)
{
	return (p1->addr !=3D p2->addr)=20
		|| ((p1->flags & I2C_M_TEN) !=3D (p2->flags & I2C_M_TEN));
}=20
D778 44
I821 33
/*
 * Generic master transfer entrypoint.=20
 * Returns the number of processed messages or error (<0)
 */
static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int nu=
m)
{
    	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)(i2c_get_adap=
data(adap));
	volatile struct iic_regs *iic =3D dev->vaddr;
	int i, ret =3D 0;
=09
	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
=09
	if (!num)
		return 0;
=09
	/* Check the sanity of the passed messages.
	 * Uhh, generic i2c layer is more suitable place for such code...
	 */
	if (unlikely(iic_invalid_address(&msgs[0]))){
		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,=20
			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
		return -EINVAL;
	}	=09
	for (i =3D 0; i < num; ++i){
		if (unlikely(msgs[i].len <=3D 0)){
			DBG("%d: invalid len %d in msg[%d]\n", dev->idx,=20
				msgs[i].len, i);
			return -EINVAL;
		}
		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
			return -EINVAL;
		}
D823 2
I824 23
=09
	/* Check bus state */
	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE)){
		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
	=09
		/* Usually it means something serious has happend.
		 * We *cannot* have unfinished previous transfer
		 * so it doesn't make any sense to try to stop it.
		 * Probably we were not able to recover from the=20
		 * previous error.
		 * The only *reasonable* thing I can think of here
		 * is soft reset.  --ebs
		 */
		iic_dev_reset(dev);
	=09
		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) !=3D EXTSTS_BCS_FREE){
			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
			return -EREMOTEIO;
		}
	}=20
	else {
		/* Flush master data buffer (just in case) */
		out_8(&iic->mdcntl, in_8(&iic->mdcntl) | MDCNTL_FMDB);
D826 2
I827 7
=09
	/* Load slave address */
	iic_address(dev, &msgs[0]);
=09
	/* Do real transfer */
    	for (i =3D 0; i < num && !ret; ++i)
		ret =3D iic_xfer_bytes(dev, &msgs[i], i < num - 1);
I828 2
	return ret < 0 ? ret : num;
}
D832 2
I833 1
	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
D836 3
D840 5
I844 8
	.name 		=3D "IBM IIC algorithm",
	.id   		=3D I2C_ALGO_OCP,
	.master_xfer 	=3D iic_xfer,
	.smbus_xfer	=3D NULL,
	.slave_send	=3D NULL,
	.slave_recv	=3D NULL,
	.algo_control	=3D NULL,
	.functionality	=3D iic_func
D847 2
I848 3
/*
 * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
 * We only scan range [0x08 - 0x77], all other addresses are reserved anyway
I849 17
static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
{
	int found =3D 0;
	char dummy;
	struct i2c_msg msg =3D {
		.buf   =3D &dummy,
		.len   =3D sizeof(dummy),
		.flags =3D I2C_M_RD
	};
=09
	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
=09
	for (msg.addr =3D 8; msg.addr < 0x78; ++msg.addr)
		if (iic_xfer(&dev->adap, &msg, 1) =3D 1){
			++found;
			printk(" 0x%02x", msg.addr);
		}
I850 3
	printk("%sibm-iic%d: %d device(s) detected\n",=20
		found ? "\n" KERN_INFO : "", dev->idx, found);
}
D852 4
I855 4
/*
 * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
 */
static inline u8 iic_clckdiv(unsigned int opb)
D857 1
I857 10
	/* Compatibility kludge, should go away after all cards
	 * are fixed to fill correct value for opbfreq.
	 * Previous driver version used hardcoded divider value 4,
	 * it corresponds to OPB frequency from the range (40, 50] MHz
	 */
	if (!opb){
		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
			" fix your board specific setup\n");
		opb =3D 50000000;
	}
D859 2
I860 25
	/* Convert to MHz */
	opb /=3D 1000000;
=09
	if (opb < 20 || opb > 150){
		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
			opb);
		opb =3D opb < 20 ? 20 : 150;
	}
	return (u8)((opb + 9) / 10 - 1);
}
\
/*
 * Register single IIC interface
 */
static int __devinit iic_probe(struct ocp_device *ocp){
\
	struct ibm_iic_private* dev;
	struct i2c_adapter* adap;
	int ret;
	bd_t* bd =3D (bd_t*)&__res;
=09
	if (!(dev =3D kmalloc(sizeof(*dev), GFP_KERNEL))){
		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
		return -ENOMEM;
	}
D862 1
I862 12
	memset(dev, 0, sizeof(*dev));
	dev->idx =3D ocp->num;
	ocp_set_drvdata(ocp, dev);
=09
	if (!(dev->vaddr =3D ioremap(ocp->paddr, sizeof(struct iic_regs)))){
		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
			dev->idx);
		ret =3D -ENXIO;
		goto fail2;
	}
=09
	init_waitqueue_head(&dev->wq);
D864 1
I864 36
	dev->irq =3D iic_force_poll ? -1 : ocp->irq;
	if (dev->irq >=3D 0){
		/* Disable interrupts until we finish intialization,
		   assumes level-sensitive IRQ setup...
		 */
		iic_interrupt_mode(dev, 0);
		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",=20
				dev->idx, dev->irq);
			/* Fallback to the polling mode */=09
			dev->irq =3D -1;
		}
	}
=09
	if (dev->irq < 0)
		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",=20
			dev->idx);
	=09
	/* Board specific settings */
	BUG_ON(dev->idx >=3D sizeof(bd->bi_iic_fast) / sizeof(bd->bi_iic_fast[0]));
	dev->fast_mode =3D iic_force_fast ? 1 : bd->bi_iic_fast[dev->idx];
=09
	/* clckdiv is the same for *all* IIC interfaces,=20
	 * but I'd rather make a copy than introduce another global. --ebs
	 */
	dev->clckdiv =3D iic_clckdiv(bd->bi_opb_busfreq);
	DBG("%d: clckdiv =3D %d\n", dev->idx, dev->clckdiv);
=09
	/* Initialize IIC interface */
	iic_dev_init(dev);
=09
	/* Register it with i2c layer */
	adap =3D &dev->adap;
	strcpy(adap->dev.name, "IBM IIC");
	i2c_set_adapdata(adap, dev);
	adap->id =3D I2C_HW_OCP | iic_algo.id;
I865 13
	adap->client_register =3D NULL;
	adap->client_unregister =3D NULL;
	adap->timeout =3D 1;
	adap->retries =3D 1;
\
	if ((ret =3D i2c_add_adapter(adap)) !=3D 0){
		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
			dev->idx);
		goto fail;
	}
=09
	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
D867 2
I868 3
	/* Scan bus if requested by user */
	if (iic_scan)
		iic_scan_bus(dev);
D870 2
D873 1
I874 12
fail:=09
	if (dev->irq >=3D 0){
		iic_interrupt_mode(dev, 0);
		free_irq(dev->irq, dev);
	}=09
\
	iounmap((void*)dev->vaddr);
fail2:=09
	ocp_set_drvdata(ocp, 0);
	kfree(dev);=09
	return ret;
}
D876 4
I879 4
/*
 * Cleanup initialized IIC interface
 */
static void __devexit iic_remove(struct ocp_device *ocp)
D881 1
I881 19
	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)ocp_get_drvdata(o=
cp);
	BUG_ON(dev =3D NULL);
	if (i2c_del_adapter(&dev->adap)){
		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
			dev->idx);
		/* That's *very* bad, just shutdown IRQ ... */
		if (dev->irq >=3D 0){
		    iic_interrupt_mode(dev, 0);=09
		    free_irq(dev->irq, dev);
		    dev->irq =3D -1;
		}
	} else {
		if (dev->irq >=3D 0){
		    iic_interrupt_mode(dev, 0);=09
		    free_irq(dev->irq, dev);
		}
		iounmap((void*)dev->vaddr);
		kfree(dev);
	}
I883 5
static struct ocp_device_id ibm_iic_ids[] __devinitdata =3D=20
{
	{ .vendor =3D OCP_VENDOR_IBM, .device =3D OCP_FUNC_IIC },
	{ .vendor =3D OCP_VENDOR_INVALID }
};
D885 2
I886 1
MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
D888 7
I894 11
static struct ocp_driver ibm_iic_driver {
	.name 		=3D "ocp_iic",
	.id_table	=3D ibm_iic_ids,
	.probe		=3D iic_probe,
	.remove		=3D __devexit_p(iic_remove),
#if defined(CONFIG_PM)
	.suspend	=3D NULL,
	.resume		=3D NULL,
#endif
};
D896 1
I896 5
static int __init iic_init(void)
{
	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
	return ocp_module_init(&ibm_iic_driver);
}
D898 2
I899 4
static void __exit iic_exit(void)
{
	ocp_unregister_driver(&ibm_iic_driver);
}
I900 2
module_init(iic_init);
module_exit(iic_exit);

=3D drivers/i2c/i2c-ibm_iic.h =3D
ac9410@attbi.com|drivers/i2c/i2c-algo-ibm_ocp.h|20020814030433|04184|75cb96=
4c98b96883
hch@lst.de[torvalds]|drivers/i2c/i2c-algo-ibm_ocp.h|20021230195059|19958
D 1.3 03/09/12 12:21:10-07:00 mporter@kernel.crashing.org +0 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
c Rename: drivers/i2c/i2c-algo-ibm_ocp.h -> drivers/i2c/i2c-ibm_iic.h
K 48109
O -rw-rw-r--
P drivers/i2c/i2c-ibm_iic.h
------------------------------------------------


mporter@kernel.crashing.org|drivers/i2c/i2c-ibm_iic.h|20030912192110|48109
D 1.4 03/09/12 12:31:23-07:00 mporter@kernel.crashing.org +119 -50
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
C
c Rewritten PPC4xx I2C driver
K 13276
O -rw-rw-r--
P drivers/i2c/i2c-ibm_iic.h
------------------------------------------------

D1 45
I45 43
/*
 * drivers/i2c/i2c-ibm_iic.h
 *
 * Support for the IIC peripheral on IBM PPC 4xx
 *=20
 * Copyright (c) 2003 Zultys Technologies.
 * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
 *
 * Based on original work by=20
 * 	Ian DaSilva  <idasilva@mvista.com>
 *      Armin Kuster <akuster@mvista.com>
 * 	Matt Porter  <mporter@mvista.com>
 *
 *      Copyright 2000-2003 MontaVista Software Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */
#ifndef __I2C_IBM_IIC_H_
#define __I2C_IBM_IIC_H_
\
#include <linux/config.h>
#include <linux/i2c.h>=20
\
struct iic_regs {
	u16 mdbuf;
	u16 sbbuf;
	u8 lmadr;
	u8 hmadr;
	u8 cntl;
	u8 mdcntl;
	u8 sts;
	u8 extsts;
	u8 lsadr;
	u8 hsadr;
	u8 clkdiv;
	u8 intmsk;
	u8 xfrcnt;
	u8 xtcntlss;
	u8 directcntl;
I47 9
struct ibm_iic_private {
	struct i2c_adapter adap;
	volatile struct iic_regs *vaddr;
	wait_queue_head_t wq;
	int idx;
	int irq;
	int fast_mode;
	u8  clckdiv;
};
D49 2
I50 64
/* IICx_CNTL register */
#define CNTL_HMT	0x80
#define CNTL_AMD	0x40
#define CNTL_TCT_MASK	0x30
#define CNTL_TCT_SHIFT	4
#define CNTL_RPST	0x08
#define CNTL_CHT	0x04=20
#define CNTL_RW		0x02
#define CNTL_PT		0x01
\
/* IICx_MDCNTL register */
#define MDCNTL_FSDB	0x80
#define MDCNTL_FMDB	0x40
#define MDCNTL_EGC	0x20
#define MDCNTL_FSM	0x10
#define MDCNTL_ESM	0x08
#define MDCNTL_EINT	0x04
#define MDCNTL_EUBS	0x02
#define MDCNTL_HSCL	0x01
\
/* IICx_STS register */
#define STS_SSS		0x80
#define STS_SLPR	0x40
#define STS_MDBS	0x20
#define STS_MDBF	0x10
#define STS_SCMP	0x08
#define STS_ERR		0x04
#define STS_IRQA	0x02
#define STS_PT		0x01
\
/* IICx_EXTSTS register */
#define EXTSTS_IRQP	0x80
#define EXTSTS_BCS_MASK	0x70
#define   EXTSTS_BCS_FREE  0x40
#define EXTSTS_IRQD	0x08
#define EXTSTS_LA	0x04
#define EXTSTS_ICT	0x02
#define EXTSTS_XFRA	0x01
\
/* IICx_INTRMSK register */
#define INTRMSK_EIRC	0x80
#define INTRMSK_EIRS	0x40
#define INTRMSK_EIWC	0x20
#define INTRMSK_EIWS	0x10
#define INTRMSK_EIHE	0x08
#define INTRMSK_EIIC	0x04
#define INTRMSK_EITA	0x02
#define INTRMSK_EIMTC	0x01
\
/* IICx_XFRCNT register */
#define XFRCNT_MTC_MASK	0x07
\
/* IICx_XTCNTLSS register */
#define XTCNTLSS_SRC	0x80
#define XTCNTLSS_SRS	0x40
#define XTCNTLSS_SWC	0x20
#define XTCNTLSS_SWS	0x10
#define XTCNTLSS_SRST	0x01
\
/* IICx_DIRECTCNTL register */
#define DIRCNTL_SDAC	0x08
#define DIRCNTL_SCC	0x04
#define DIRCNTL_MSDA	0x02
#define DIRCNTL_MSC	0x01
D52 2
I53 2
/* Check if we really control the I2C bus and bus is free */
#define DIRCTNL_FREE(v)	(((v) & 0x0f) =3D 0x0f)
D55 1
I55 1
#endif /* __I2C_IBM_IIC_H_ */

=3D drivers/i2c/Makefile =3D
torvalds@athlon.transmeta.com|drivers/i2c/Makefile|20020205174018|59980|699=
ee8af74f52ec9
henk@god.dyndns.org[greg]|drivers/i2c/Makefile|20030623222422|55080
D 1.13 03/09/12 12:30:34-07:00 mporter@kernel.crashing.org +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
C
c Update PPC4xx I2C driver name
K 58226
O -rw-rw-r--
P drivers/i2c/Makefile
------------------------------------------------

I18 1
obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o

=3D drivers/i2c/Kconfig =3D
zippel@linux-m68k.org[torvalds]|drivers/i2c/Kconfig|20021030043228|25271|93=
781e6749f2f6e9
bunk@fs.tum.de[torvalds]|drivers/i2c/Kconfig|20030902162248|55767
D 1.15 03/09/12 12:30:34-07:00 mporter@kernel.crashing.org +2 -6
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed02=
4864
C
c Update PPC4xx I2C driver name
K 46908
O -rw-rw-r--
P drivers/i2c/Kconfig
------------------------------------------------

D206 2
I207 2
config I2C_IBM_IIC
	tristate "IBM IIC I2C"
D209 4

# Patch checksum=EB4878fa
