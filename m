From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <1102418342.3215.304.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2004-12-07 at 11:42 +0100, Jean Delvare wrote:
> Hi Ian,
> 
> > - printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
> > + DEB1(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
> 
> Doesn't look OK to me. Either this is an error and it has to be
> displayed regardless of DEBUG being enabled or not, or it is a debugging
> info and it should use KERN_DEBUG instead of KERN_ERR. In the latter
> case, I can already hear Greg suggest you should use pr_debug or even
> dev_dbg instead of printk.

I think it can be considered a debug statement since I am reasonably
sure that it is a situation which cannot arise. I've only ever seen the
error with a pre-release of a slave part on the bus. The slave's i2c
implementation was fairly buggy, it ignored stop bits and hung the bus
if you sent it a duff command. The next rev of this particular slave
device shouldn't have this problem and I certainly wouldn't expect it in
released silicon.

If it turns out that in practise (with production slave devices) we can
find that we hit this check then it would make sense to loop for a bit
until the bus becomes idle or we timeout. However I'd rather see it
happen with a production slave device before doing that. 

I've changed it to dev_dbg.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/algos/i2c-algo-pca.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2004-12-06 10:38:41.000000000 +0000
+++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2004-12-07 11:14:08.669738602 +0000
@@ -189,7 +189,7 @@
 
 	state = pca_status(adap);
 	if ( state != 0xF8 ) {
-		printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
+		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state );
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
+++ 2.6/drivers/i2c/algos/i2c-algo-pcf.c	2004-12-07 10:14:58.000000000 +0000
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
