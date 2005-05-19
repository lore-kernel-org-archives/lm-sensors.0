From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: I2C support for IPMI
Message-Id: <41EEDAD7.70105@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm the maintainer of the IPMI driver, and there is a new function that 
needs to be added that does IPMI over SMBUS.  This requires some minor 
changes to the I2C interface to support a special function of the IPMI 
driver.

The IPMI driver support the ability to store panic information into the 
Systen Event Log (SEL) of the IPMI controller.  Since it does this at 
panic time, the system can no longer schedule.  Thus the driver has to 
be able to do this without jiffies or scheduling.  There are also some 
watchdog operations that need to happen at panic time that also need this.

I've attached a patch that modifies the I2C bus drivers to add the 
capability to use a delay.  There's some more work to do on the IPMI 
driver portion, still, but I thought I would socialize this with the 
sensors group first.  This is just a first shot, I'm sure I've missed 
something.

This is relative to 2.6.11-rc1.

Thanks,

-Corey
-------------- next part --------------
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali1535.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-ali1535.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali1535.c	2005-01-19 13:38:37.000000000 -0600
@@ -277,7 +277,7 @@
 	/* We will always wait for a fraction of a second! */
 	timeout = 0;
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
 		 && (timeout++ < MAX_TIMEOUT));
@@ -351,7 +351,7 @@
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
 	     timeout++) {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT)
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali1563.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-ali1563.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali1563.c	2005-01-19 13:38:37.000000000 -0600
@@ -83,7 +83,7 @@
 
 	timeout = ALI1563_MAX_TIMEOUT;
 	do
-		msleep(1);
+		i2c_msleep(1);
 	while (((data = inb_p(SMB_HST_STS)) & HST_STS_BUSY) && --timeout);
 
 	dev_dbg(&a->dev, "Transaction (post): STS=%02x, CNTL1=%02x, "
@@ -138,7 +138,7 @@
 
 	timeout = ALI1563_MAX_TIMEOUT;
 	do
-		msleep(1);
+		i2c_msleep(1);
 	while (!((data = inb_p(SMB_HST_STS)) & HST_STS_DONE) && --timeout);
 
 	dev_dbg(&a->dev, "Block (post): STS=%02x, CNTL1=%02x, "
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali15x3.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-ali15x3.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-ali15x3.c	2005-01-19 13:38:37.000000000 -0600
@@ -297,7 +297,7 @@
 	/* We will always wait for a fraction of a second! */
 	timeout = 0;
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((!(temp & (ALI15X3_STS_ERR | ALI15X3_STS_DONE)))
 		 && (timeout++ < MAX_TIMEOUT));
@@ -354,7 +354,7 @@
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI15X3_STS_IDLE);
 	     timeout++) {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT) {
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-amd756.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-amd756.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-amd756.c	2005-01-19 13:38:37.000000000 -0600
@@ -125,7 +125,7 @@
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
 		dev_dbg(&adap->dev, "SMBus busy (%04x). Waiting...\n", temp);
 		do {
-			msleep(1);
+			i2c_msleep(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
 		} while ((temp & (GS_HST_STS | GS_SMB_STS)) &&
 		         (timeout++ < MAX_TIMEOUT));
@@ -142,7 +142,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inw_p(SMB_GLOBAL_STATUS);
 	} while ((temp & GS_HST_STS) && (timeout++ < MAX_TIMEOUT));
 
@@ -189,7 +189,7 @@
  abort:
 	dev_warn(&adap->dev, "Sending abort\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
-	msleep(100);
+	i2c_msleep(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 	return -1;
 }
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-amd8111.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-amd8111.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-amd8111.c	2005-01-19 13:38:37.000000000 -0600
@@ -276,7 +276,7 @@
 	}
 
 	if (~temp[0] & AMD_SMB_STS_DONE) {
-		msleep(1);
+		i2c_msleep(1);
 		amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
 	}
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-i801.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-i801.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-i801.c	2005-01-19 13:38:37.000000000 -0600
@@ -208,7 +208,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
@@ -336,7 +336,7 @@
 		timeout = 0;
 		do {
 			temp = inb_p(SMBHSTSTS);
-			msleep(1);
+			i2c_msleep(1);
 		}
 		    while ((!(temp & 0x80))
 			   && (timeout++ < MAX_TIMEOUT));
@@ -396,7 +396,7 @@
 		timeout = 0;
 		do {
 			temp = inb_p(SMBHSTSTS);
-			msleep(1);
+			i2c_msleep(1);
 		} while ((!(temp & 0x02))
 			   && (timeout++ < MAX_TIMEOUT));
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-ibm_iic.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-ibm_iic.c	2005-01-19 15:59:14.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-ibm_iic.c	2005-01-19 15:59:16.000000000 -0600
@@ -209,7 +209,8 @@
 			out_8(&iic->directcntl, dc);
 			
 			/* be nice */
-			cond_resched();
+			if (i2c_spin_delay)
+				cond_resched();
 		}
 	}
 	
@@ -227,11 +228,25 @@
 /* Wait for SCL and/or SDA to be high */
 static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
 {
-	unsigned long x = jiffies + HZ / 28 + 2;
+	unsigned long x;
+
+	/* 1/28th of a second. */
+	if (i2c_spin_delay)
+		x = 1000000 / 28;
+	else
+		x = jiffies + HZ / 28 + 2;
+
 	while ((in_8(&iic->directcntl) & mask) != mask){
-		if (unlikely(time_after(jiffies, x)))
-			return -1;
-		cond_resched();
+		if (i2c_spin_delay) {
+			if (x < 10)
+				goto timeout;
+			x -= 10;
+			udelay(10);
+		} else {
+			if (unlikely(time_after(jiffies, x)))
+				return -1;
+			cond_resched();
+		}
 	}
 	return 0;
 }
@@ -384,16 +399,17 @@
 	
 	/*
 	 * Wait for the abort command to complete.
-	 * It's not worth to be optimized, just poll (timeout >= 1 tick)
+	 * It's not worth to be optimized, just poll (timeout >= 10 ms)
 	 */
-	x = jiffies + 2;
+	x = 0;
 	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-		if (time_after(jiffies, x)){
+		if (x > 10){
 			DBG("%d: abort timeout, resetting...\n", dev->idx);
 			iic_dev_reset(dev);
 			return;
 		}
-		schedule();
+		i2c_msleep(1);
+		x++;
 	}
 
 	/* Just to clear errors */
@@ -424,21 +440,37 @@
 	}
 	else {
 		/* Polling mode */
-		unsigned long x = jiffies + dev->adap.timeout * HZ;
+		unsigned long x;
+
+		if (i2c_spin_delay)
+			/* useconds */
+			x = dev->adap.timeout * 1000000;
+		else
+			/* jiffies */
+			x = jiffies + dev->adap.timeout * HZ;
 		
 		while (in_8(&iic->sts) & STS_PT){
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
+			if (i2c_spin_delay){
+				if (x < 10)
+					goto timeout;
+				x -= 10;
+				udelay(10);
+			}else{
+				if (unlikely(time_after(jiffies, x)))
+					goto timeout;
+				if (unlikely(signal_pending(current))){
+					DBG("%d: poll interrupted\n", dev->idx);
+					ret = -ERESTARTSYS;
+					break;
+				}
+				schedule();
 			}
-			schedule();
+			continue;
+
+		timeout:
+			DBG("%d: poll timeout\n", dev->idx);
+			ret = -ETIMEDOUT;
+			break;
 		}	
 	}
 	
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-keywest.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-keywest.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-keywest.c	2005-01-19 13:38:37.000000000 -0600
@@ -662,7 +662,7 @@
 	spin_lock_irq(&iface->lock);
 	while (iface->state != state_idle) {
 		spin_unlock_irq(&iface->lock);
-		msleep(100);
+		i2c_msleep(100);
 		spin_lock_irq(&iface->lock);
 	}
 #endif /* POLLED_MODE */
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-mpc.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-mpc.c	2005-01-19 15:59:14.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-mpc.c	2005-01-19 15:59:16.000000000 -0600
@@ -76,14 +76,32 @@
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	unsigned long orig_jiffies = jiffies;
+	unsigned long stop_time;
 	u32 x;
 	int result = 0;
 
-	if (i2c->ocpdef->irq = OCP_IRQ_NA) {
+	/* Wait timeout jiffies */
+	if (i2c_spin_delay)
+		stop_time = timeout * (1000000 / HZ);
+	else
+		stop_time = jiffies + timeout;
+
+	if ((i2c->ocpdef->irq = OCP_IRQ_NA) || i2c_spin_delay) {
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
-			schedule();
-			if (time_after(jiffies, orig_jiffies + timeout)) {
+			int done_timeout = 0;
+			if (i2c_spin_delay) {
+				if (x < 10) {
+					done_timeout = 1;
+				} else {
+					x -= 10;
+					udelay(10);
+				}
+			} else {
+				schedule();
+				if (time_after(jiffies, stop_time))
+					done_timeout = 1;
+			}					
+			if (done_timeout) {
 				pr_debug("I2C: timeout\n");
 				result = -EIO;
 				break;
@@ -238,22 +256,37 @@
 	struct i2c_msg *pmsg;
 	int i;
 	int ret = 0;
-	unsigned long orig_jiffies = jiffies;
+	unsigned long stop_time;
 	struct mpc_i2c *i2c = i2c_get_adapdata(adap);
 
+	/* Wait 1 second */
+	if (i2c_spin_delay)
+		stop_time = 1000000;
+	else
+		stop_time = jiffies + HZ;
+
 	mpc_i2c_start(i2c);
 
 	/* Allow bus up to 1s to become not busy */
 	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
-		if (signal_pending(current)) {
-			pr_debug("I2C: Interrupted\n");
-			return -EINTR;
-		}
-		if (time_after(jiffies, orig_jiffies + HZ)) {
-			pr_debug("I2C: timeout\n");
-			return -EIO;
+		if (i2c_spin_delay) {
+			if (x < 10) {
+				pr_debug("I2C: timeout\n");
+				return -EIO;
+			}
+			x -= 10;
+			udelay(10);
+		} else {
+			if (signal_pending(current)) {
+				pr_debug("I2C: Interrupted\n");
+				return -EINTR;
+			}
+			if (time_after(jiffies, orig_jiffies + HZ)) {
+				pr_debug("I2C: timeout\n");
+				return -EIO;
+			}
+			schedule();
 		}
-		schedule();
 	}
 
 	for (i = 0; ret >= 0 && i < num; i++) {
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-nforce2.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-nforce2.c	2005-01-19 13:38:37.000000000 -0600
@@ -243,7 +243,7 @@
 		temp = inb_p(NVIDIA_SMB_STS);
 	}
 	if (~temp & NVIDIA_SMB_STS_DONE) {
-		msleep(10);
+		i2c_msleep(10);
 		temp = inb_p(NVIDIA_SMB_STS);
 	}
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-piix4.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-piix4.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-piix4.c	2005-01-19 13:38:37.000000000 -0600
@@ -259,7 +259,7 @@
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-s3c2410.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-s3c2410.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-s3c2410.c	2005-01-19 13:38:37.000000000 -0600
@@ -469,7 +469,7 @@
 		if (!(iicstat & S3C2410_IICSTAT_BUSBUSY))
 			return 0;
 
-		msleep(1);
+		i2c_msleep(1);
 	}
 
 	dev_dbg(i2c->dev, "timeout: GPEDAT is %08x\n",
@@ -521,7 +521,7 @@
 
 	/* ensure the stop has been through the bus */
 
-	msleep(1);
+	i2c_msleep(1);
 
  out:
 	return ret;
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis5595.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-sis5595.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis5595.c	2005-01-19 13:38:37.000000000 -0600
@@ -240,7 +240,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = sis5595_read(SMB_STS_LO);
 	} while (!(temp & 0x40) && (timeout++ < MAX_TIMEOUT));
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis630.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-sis630.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis630.c	2005-01-19 13:38:37.000000000 -0600
@@ -166,7 +166,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = sis630_read(SMB_STS);
 		/* check if block transmitted */
 		if (size = SIS630_BLOCK_DATA && (temp & 0x10))
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis96x.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-sis96x.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-sis96x.c	2005-01-19 13:38:37.000000000 -0600
@@ -137,7 +137,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = sis96x_read(SMB_STS);
 	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/i2c-viapro.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/i2c-viapro.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-viapro.c	2005-01-19 13:38:37.000000000 -0600
@@ -139,7 +139,7 @@
 	/* We will always wait for a fraction of a second! 
 	   I don't know if VIA needs this, Intel did  */
 	do {
-		msleep(1);
+		i2c_msleep(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
Index: linux-2.6.11-rc1/drivers/i2c/busses/scx200_acb.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/busses/scx200_acb.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/busses/scx200_acb.c	2005-01-19 13:38:37.000000000 -0600
@@ -255,7 +255,7 @@
 			scx200_acb_machine(iface, status);
 			return;
 		}
-		msleep(10);
+		i2c_msleep(10);
 	}
 
 	scx200_acb_timeout(iface);
Index: linux-2.6.11-rc1/drivers/i2c/i2c-core.c
=================================--- linux-2.6.11-rc1.orig/drivers/i2c/i2c-core.c	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/drivers/i2c/i2c-core.c	2005-01-19 13:38:37.000000000 -0600
@@ -1247,6 +1247,12 @@
 	return (func & adap_func) = func;
 }
 
+int i2c_spin_delay;
+void i2c_set_spin_delay(int val)
+{
+	i2c_spin_delay = val;
+}
+
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1280,6 +1286,8 @@
 
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
+EXPORT_SYMBOL(i2c_set_spin_delay);
+EXPORT_SYMBOL(i2c_spin_delay);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
Index: linux-2.6.11-rc1/include/linux/i2c.h
=================================--- linux-2.6.11-rc1.orig/include/linux/i2c.h	2005-01-19 13:36:48.000000000 -0600
+++ linux-2.6.11-rc1/include/linux/i2c.h	2005-01-19 14:11:20.000000000 -0600
@@ -30,6 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/delay.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
@@ -595,4 +596,24 @@
 #define i2c_is_isa_adapter(adapptr) \
         ((adapptr)->algo->id = I2C_ALGO_ISA)
 
+/* Tiny delay function used by the i2c bus drivers.  I2C drivers should
+ * use this function instead of the msleep because in some cases (when
+ * supporting IPMI) this has to run even if scheduling is disabled.
+ * This allows IPMI to send messages and store things in the event log
+ * during a panic.  Note that if an I2C driver calls any scheduling
+ * function when i2c_spin_delay is set, it will not work with the IPMI
+ * panic handling code. */
+
+extern void i2c_set_spin_delay(int val);
+extern int i2c_spin_delay;
+#include <asm/delay.h>
+static inline void i2c_msleep(signed int msecs)
+{
+	if( i2c_spin_delay ) {
+		mdelay(msecs);
+	} else {
+		msleep(msecs);
+	}
+}
+
 #endif /* _LINUX_I2C_H */
