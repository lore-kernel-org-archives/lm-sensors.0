From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <1102414642.3215.285.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

iOn Mon, 2004-12-06 at 17:23 +0000, Ian Campbell wrote:
> > You are right that i2c-algo-bit should declare itself I2C_FUNC_I2C
> > capable. I even think that every bus being I2C_FUNC_SMBUS_EMUL capable
> > is very likely to be I2C_FUNC_I2C capable. This means that other
> > algorithms (ite, pcf, maybe pca) could most probably be declared
> > I2C_FUNC_I2C capable as well. Can anyone confirm?
> 
> PCF and PCA both say "i2c" in the datasheets and don't mention smbus at
> all, so I reckon I2C_FUNC_I2C would be appropriate. I'll put together a
> patch tomorrow. 

The following adds I2C_FUNC_I2C to the functionality of the PCF and PCA
i2c algorithm drivers.

I also sneaked in a little change which makes the PCA driver a little
quieter in the non-debug case...

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/algos/i2c-algo-pca.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2004-12-06 10:38:41.000000000 +0000
+++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2004-12-07 10:06:22.635455798 +0000
@@ -189,7 +189,7 @@
 
 	state = pca_status(adap);
 	if ( state != 0xF8 ) {
-		printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
+		DEB1(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
 		/* FIXME: what to do. Force stop ? */
 		return -EREMOTEIO;
 	}
@@ -328,7 +328,7 @@
 
 static u32 pca_func(struct i2c_adapter *adap)
 {
-        return I2C_FUNC_SMBUS_EMUL;
+        return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static int pca_init(struct i2c_algo_pca_data *adap)
Index: 2.6/drivers/i2c/algos/i2c-algo-pcf.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pcf.c	2004-10-20 10:43:57.000000000 +0100
+++ 2.6/drivers/i2c/algos/i2c-algo-pcf.c	2004-12-07 10:06:05.001239873 +0000
@@ -414,8 +414,8 @@
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING; 
 }
 
 /* -----exported algorithm data: -------------------------------------	*/

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200
