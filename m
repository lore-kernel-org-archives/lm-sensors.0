From: ebrower@usa.net (Eric Brower)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [RFC/PATCH] lost arbitration detection for PCF8584
Message-Id: <4216C459.1060703@usa.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attached is a patch for detecting lost arbitration via the PCF8584 
algorithm adapter.  The documentation from Philips is not clear on the 
topic, and it seems I could be checking the LAB bit more frequently, but 
this seems to do the trick on a system for which I am developing I2C 
support-- any comments on these modifications for multi-master friendliness?

The result of this patch is that callers of the master_xfer function 
pointer will receive -EINTR when work has been interrupted by a detected 
lost arbitration.  Checking the lost arbitration (LAB) bit is done only 
in wait_for_pin().  This -EINTR bubbles-up all the way to the callers of 
the i2c library functions for accessing the bus and smarter callers 
should be able to retry as appropriate for their task-- this does, 
however, prevent the master_xfer routine from returning the number of 
messages successfully sent; I'm not sure where the best tradeoff could 
be made, given the API (and the fact that I seem to be the only person 
who would find this useful) but I suppose lost arbitration could just 
become another anonymous failure mode and we continue to report back the 
number of successful messages sent.

Any comments?

Many thanks,
E
-------------- next part --------------
=== drivers/i2c/algos/i2c-algo-pcf.c 1.16 vs edited ==--- 1.16/drivers/i2c/algos/i2c-algo-pcf.c	2004-12-07 02:14:58 -08:00
+++ edited/drivers/i2c/algos/i2c-algo-pcf.c	2005-02-11 17:50:20 -08:00
@@ -78,7 +78,6 @@
 	set_pcf(adap, 1, I2C_PCF_STOP);
 }
 
-
 static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
 
 	int timeout = DEF_TIMEOUT;
@@ -109,6 +108,26 @@
 		adap->waitforpin();
 		*status = get_pcf(adap, 1);
 	}
+	if (*status & I2C_PCF_LAB) {
+		DEB2(printk(KERN_INFO 
+			"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
+			 *status));
+		/* Cleanup from LAB-- reset and enable ESO.
+		 * This resets the PCF8584; since we've lost the bus, no
+		 * further attempts should be made by callers to clean up 
+		 * (no i2c_stop() etc.)
+		 */
+		set_pcf(adap, 1, I2C_PCF_PIN);
+		set_pcf(adap, 1, I2C_PCF_ESO);
+		/* TODO: we should pause for a time period sufficient for any
+		 * running I2C transaction to complete-- the arbitration
+		 * logic won't work properly until the next START is seen.
+		 */
+		DEB2(printk(KERN_INFO 
+			"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n", 
+			get_pcf(adap,1)));
+		return(-EINTR);
+	}
 #endif
 	if (timeout <= 0)
 		return(-1);
@@ -188,16 +207,22 @@
 		       unsigned char addr, int retries)
 {
 	int i, status, ret = -1;
+	int wfp;
 	for (i=0;i<retries;i++) {
 		i2c_outb(adap, addr);
 		i2c_start(adap);
 		status = get_pcf(adap, 1);
-		if (wait_for_pin(adap, &status) >= 0) {
+		if ((wfp = wait_for_pin(adap, &status)) >= 0) {
 			if ((status & I2C_PCF_LRB) = 0) { 
 				i2c_stop(adap);
 				break;	/* success! */
 			}
 		}
+		if (wfp = -EINTR) {
+			/* arbitration lost */
+			udelay(adap->udelay);
+			return -EINTR;
+		}
 		i2c_stop(adap);
 		udelay(adap->udelay);
 	}
@@ -219,6 +244,10 @@
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
+			if (timeout = -EINTR) {
+				/* arbitration lost */
+				return -EINTR;
+			}
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
 			return -EREMOTEIO; /* got a better one ?? */
@@ -247,11 +276,16 @@
 {
 	int i, status;
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
+	int wfp;
 
 	/* increment number of bytes to read by one -- read dummy byte */
 	for (i = 0; i <= count; i++) {
 
-		if (wait_for_pin(adap, &status)) {
+		if ((wfp = wait_for_pin(adap, &status))) {
+			if (wfp = -EINTR) {
+				/* arbitration lost */
+				return -EINTR;
+			}
 			i2c_stop(adap);
 			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
 			return (-1);
@@ -366,6 +400,10 @@
 		/* Wait for PIN (pending interrupt NOT) */
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
+			if (timeout = -EINTR) {
+				/* arbitration lost */
+				return (-EINTR);
+			}
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)
@@ -414,8 +452,8 @@
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
-	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING; 
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+	       I2C_FUNC_PROTOCOL_MANGLING; 
 }
 
 /* -----exported algorithm data: -------------------------------------	*/
