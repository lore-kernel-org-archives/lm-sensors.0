From: clock@twibright.com (Karel Kulhavy)
Date: Sat, 11 Jun 2005 16:12:32 +0000
Subject: [lm-sensors] Patch to check return values in i2c-algo-bit.c
Message-Id: <20050611141135.GA25547@kestrel>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050611110823.GA21311@kestrel>
In-Reply-To: <20050611110823.GA21311@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

When you use a parallel port adapter that supports SCL readback and have
the kernel configured to use it and are using also some additional
driver on top of it (PCFxxx or whatever) and the adapter is accidentally
pulled out, you get a big (90 second) delay on system startup.

This is because SCL readback times out, generates -ETIMEDOUT, but the
caller functions don't check this and continue repeating operations
again and again.

I have made a patch to fix this problem. However was unable to check it
because don't have suitable hardware.

Please ideologicallt check it and try it someone. I hope the changes are
not so complicated it could cause some bug.

CL<

--- /usr/src/linux/drivers/i2c/algos/i2c-algo-bit.c	2005-06-10 20:06:26.000000000 +0200
+++ i2c-algo-bit.c	2005-06-10 20:10:20.000000000 +0200
@@ -115,26 +115,36 @@
 	scllo(adap);
 }
 
-static void i2c_repstart(struct i2c_algo_bit_data *adap) 
+/* Return value: 0 OK, <0 error */
+static int i2c_repstart(struct i2c_algo_bit_data *adap) 
 {
+	int retval;
 	/* scl, sda may not be high */
 	DEBPROTO(printk(" Sr "));
 	setsda(adap,1);
-	sclhi(adap);
+	if ((retval = sclhi(adap)) < 0)
+		return retval; 
 	udelay(adap->udelay);
 	
 	sdalo(adap);
 	scllo(adap);
+	return 0;
 }
 
 
-static void i2c_stop(struct i2c_algo_bit_data *adap) 
+/* Returns 0 on OK and -ETIMEDOUT on timeout. */
+static int i2c_stop(struct i2c_algo_bit_data *adap) 
 {
+	int retval;
+
 	DEBPROTO(printk("P\n"));
+
 	/* assert: scl is low */
 	sdalo(adap);
-	sclhi(adap); 
+	if ((retval = sclhi(adap)) < 0)
+		return retval;
 	sdahi(adap);
+	return 0;
 }
 
 
@@ -218,8 +228,9 @@
  * Sanity check for the adapter hardware - check the reaction of
  * the bus lines only if it seems to be idle.
  */
-static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
-	int scl,sda;
+static int test_bus(struct i2c_algo_bit_data *adap, char* name)
+{
+	int scl, sda, retval;
 
 	if (adap->getscl=NULL)
 		printk(KERN_INFO "i2c-algo-bit.o: Testing SDA only, "
@@ -275,7 +286,10 @@
 		goto bailout;
 	}
 	
-	sclhi(adap);
+	retval = sclhi(adap);
+	if (retval < 0)
+		return retval;
+
 	sda=getsda(adap);
 	scl=(adap->getscl=NULL?1:getscl(adap));
 	printk(KERN_DEBUG "i2c-algo-bit.o: (4) scl=%d, sda=%d\n",scl,sda);
@@ -292,7 +306,11 @@
 	return 0;
 bailout:
 	sdahi(adap);
-	sclhi(adap);
+	
+	retval = sclhi(adap);
+	if (retval < 0)
+		return retval;
+
 	return -ENODEV;
 }
 
@@ -310,12 +328,20 @@
 		       unsigned char addr, int retries)
 {
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	int i,ret = -1;
+	int i,ret = -1, retval;
 	for (i=0;i<=retries;i++) {
 		ret = i2c_outb(i2c_adap,addr);
 		if (ret=1)
 			break;	/* success! */
-		i2c_stop(adap);
+		if (ret < 0) return ret; /* Error */
+		
+		retval = i2c_stop(adap);
+		if (retval < 0)
+			return retval;
+		/* This can happen only when SCL readback doesn't work.
+	 	* We won't retry here because retry on sclhi doesn't
+		* make sense (the adapter is powered off or faulty) */
+
 		udelay(5/*adap->udelay*/);
 		if (i=retries)  /* no success */
 			break;
@@ -330,6 +356,7 @@
 	return ret;
 }
 
+/** Return value: */
 static int sendbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
 {
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
@@ -337,7 +364,7 @@
 	const char *temp = msg->buf;
 	int count = msg->len;
 	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK; 
-	int retval;
+	int retval, retval_inner;
 	int wrcount=0;
 
 	while (count > 0) {
@@ -350,7 +377,10 @@
 			wrcount++;
 		} else { /* arbitration or no acknowledge */
 			dev_err(&i2c_adap->dev, "sendbytes: error - bailout.\n");
-			i2c_stop(adap);
+			retval_inner = i2c_stop(adap);
+			if (retval_inner < 0)
+				return retval_inner;
+
 			return (retval<0)? retval : -EFAULT;
 			        /* got a better one ?? */
 		}
@@ -430,22 +460,30 @@
 		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(i2c_adap, addr, retries);
+		if (ret < 0) return ret;
 		if ((ret != 1) && !nak_ok)  {
 			printk(KERN_ERR "died at extended address code.\n");
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
 		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
+		if (ret < 0) return ret;
 		if ((ret != 1) && !nak_ok) {
 			/* the chip did not ack / xmission error occurred */
 			printk(KERN_ERR "died at 2nd address code.\n");
 			return -EREMOTEIO;
 		}
 		if ( flags & I2C_M_RD ) {
-			i2c_repstart(adap);
+			int retval;
+
+			retval = i2c_repstart(adap);
+			if (retval < 0)
+				return retval;
+
 			/* okay, now switch into reading mode */
 			addr |= 0x01;
 			ret = try_address(i2c_adap, addr, retries);
+			if (ret < 0) return ret;
 			if ((ret!=1) && !nak_ok) {
 				printk(KERN_ERR "died at extended address code.\n");
 				return -EREMOTEIO;
@@ -458,6 +496,7 @@
 		if (flags & I2C_M_REV_DIR_ADDR )
 			addr ^= 1;
 		ret = try_address(i2c_adap, addr, retries);
+		if (ret < 0) return ret;
 		if ((ret!=1) && !nak_ok)
 			return -EREMOTEIO;
 	}
@@ -471,7 +510,7 @@
 	struct i2c_msg *pmsg;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 	
-	int i,ret;
+	int i,ret, retval;
 	unsigned short nak_ok;
 
 	i2c_start(adap);
@@ -480,13 +519,17 @@
 		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK; 
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
 			if (i) {
-				i2c_repstart(adap);
+				int retval;
+
+				retval = i2c_repstart(adap);
+				if (retval < 0)
+					return retval;
 			}
 			ret = bit_doAddress(i2c_adap, pmsg);
 			if ((ret != 0) && !nak_ok) {
 			    DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device addr %2.2x msg #%d\n"
 					,msgs[i].addr,i));
-			    return (ret<0) ? ret : -EREMOTEIO;
+			    return (ret < 0) ? ret : -EREMOTEIO;
 			}
 		}
 		if (pmsg->flags & I2C_M_RD ) {
@@ -494,18 +537,22 @@
 			ret = readbytes(i2c_adap, pmsg);
 			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
-				return (ret<0)? ret : -EREMOTEIO;
+				return (ret < 0)? ret : -EREMOTEIO;
 			}
 		} else {
 			/* write bytes from buffer */
 			ret = sendbytes(i2c_adap, pmsg);
 			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
-				return (ret<0) ? ret : -EREMOTEIO;
+				return (ret < 0) ? ret : -EREMOTEIO;
 			}
 		}
 	}
-	i2c_stop(adap);
+
+	retval = i2c_stop(adap);
+	if (retval < 0)
+		return retval;
+
 	return num;
 }
 
@@ -534,7 +581,7 @@
 
 	if (bit_test) {
 		int ret = test_bus(bit_adap, adap->name);
-		if (ret<0)
+		if (ret < 0)
 			return -ENODEV;
 	}
 
