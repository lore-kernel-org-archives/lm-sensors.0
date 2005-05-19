From: sfr@gmx.net (Stefan Frank)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: i2c-2.8.0: Request/Wish for a patch for the Matrox Marvel driver
Message-Id: <20030912101022.GA31478@mail.gallien.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

well, as offered on the website i'm asking for support/a patch.
It's for the driver for the Matrox Marvel G200/G400 tv tuner cards.

The driver is available here: 

http://prdownloads.sourceforge.net/marvel/mgavideo-0.1.1b.tar.gz?download

and http://sourceforge.net/projects/marvel is the project page.

I have attached a very basic (probably wrong) patch which i created
quickly, based on a patch by the WOLK patchset maintainer. Note that i
didn't really know what i was doing, this is untested  but i 
succeeded to compile the driver at least. Anyway i'm sure you'll create
a better one.

TIA, Stefan


-------------- next part --------------
diff -ur mgavideo-0.1.1b/driver/i2c-algo-ks.c mgavideo-0.1.1b-i2c-2.8/driver/i2c-algo-ks.c
--- mgavideo-0.1.1b/driver/i2c-algo-ks.c	2002-08-04 08:59:35.000000000 +0200
+++ mgavideo-0.1.1b-i2c-2.8/driver/i2c-algo-ks.c	2003-08-30 14:15:00.000000000 +0200
@@ -547,14 +547,15 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_ks_algo = {
-	"ks0127-bug algorithm",
-	I2C_ALGO_BIT,
-	bit_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+    .owner          = THIS_MODULE,
+	.name           = "ks0127-bug algorithm",
+	.id             = I2C_ALGO_BIT,
+	.master_xfer    = bit_xfer,
+	.smbus_xfer     = NULL,
+	.slave_send     = NULL,				/* slave_xmit		*/
+	.slave_recv     = NULL,				/* slave_recv		*/
+	.algo_control   = algo_control,			/* ioctl		*/
+	.functionality  = bit_func,			/* functionality	*/
 };
 
 /* 
diff -ur mgavideo-0.1.1b/driver/ks0127.c mgavideo-0.1.1b-i2c-2.8/driver/ks0127.c
--- mgavideo-0.1.1b/driver/ks0127.c	2002-05-05 11:27:31.000000000 +0200
+++ mgavideo-0.1.1b-i2c-2.8/driver/ks0127.c	2003-08-30 14:03:06.000000000 +0200
@@ -1119,14 +1119,13 @@
 
 
 static struct i2c_driver i2c_driver_ks0127 = {
-	name:		KS0127_DEVNAME,
-	id:		I2C_DRIVERID_KS0127,
-	flags:		I2C_DF_NOTIFY,
-	attach_adapter:	ks0127_attach,
-	detach_client:	ks0127_detach,
-	command:	ks0127_command,
-	inc_use:	NULL,
-	dec_use:	NULL
+    .owner      = THIS_MODULE,
+	.name       = "KS0127_DEVNAME",
+	.id         = I2C_DRIVERID_KS0127,
+	.flags      = I2C_DF_NOTIFY,
+	.attach_adapter = ks0127_attach,
+	.detach_client =  ks0127_detach,
+	.command    = ks0127_command,
 };
 
 
diff -ur mgavideo-0.1.1b/driver/maven.c mgavideo-0.1.1b-i2c-2.8/driver/maven.c
--- mgavideo-0.1.1b/driver/maven.c	2002-05-05 11:26:43.000000000 +0200
+++ mgavideo-0.1.1b-i2c-2.8/driver/maven.c	2003-08-30 14:05:57.000000000 +0200
@@ -658,14 +658,13 @@
 
 
 static struct i2c_driver i2c_driver_maven = {
-	name:		MAVEN_DEVNAME,
-	id:		I2C_DRIVERID_MGATVO,
-	flags:		I2C_DF_NOTIFY,
-	attach_adapter:	maven_attach,
-	detach_client:	maven_detach,
-	command:	maven_command,
-	inc_use:	NULL, //inc use
-	dec_use:	NULL  //dec use
+    .owner      = THIS_MODULE,
+	.name       = "MAVEN_DEVNAME",
+	.id         = I2C_DRIVERID_MGATVO,
+	.flags      = I2C_DF_NOTIFY,
+	.attach_adapter = maven_attach,
+	.detach_client  = maven_detach,
+	.command    = maven_command,
 };
 
 
diff -ur mgavideo-0.1.1b/driver/mgai2c.c mgavideo-0.1.1b-i2c-2.8/driver/mgai2c.c
--- mgavideo-0.1.1b/driver/mgai2c.c	2002-12-21 10:21:29.000000000 +0100
+++ mgavideo-0.1.1b-i2c-2.8/driver/mgai2c.c	2003-08-30 14:04:15.000000000 +0200
@@ -295,17 +295,10 @@
 
 
 static struct i2c_adapter mga_i2c_adap_tmpl = {
-	"mgai2c",
-	I2C_HW_B_BT848, /* needed for 2.4 tuner/msp3400*/	/* I2C_HW_B_G400 fixme */
-	NULL,
-	NULL,
-	adap_inc_use,
-	adap_dec_use,
-	adap_reg_client,
-	adap_unreg_client,
+    .owner = THIS_MODULE,
+    .id =    I2C_HW_B_BT848,
 };
 
-
 EXPORT_SYMBOL(mgai2c_init);
 EXPORT_SYMBOL(mgai2c_cleanup);
 
