From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.4] i2c cleanups (1/4)
Message-Id: <20031213193311.2f9aa746.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

This patch does some trivial changes to a few i2c drivers. The changes
are only white space and comment changes, and line reordering. There are
also two simple changes to i2c-id.h to keep it in line with the ones in
our repository and Linux 2.6.0-test11.

These changes should make subsequent patches more readable.

Please apply.

diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-core.c linux-2.4.24-pre1-k/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-core.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-core.c	Thu Dec 11 20:40:08 2003
@@ -1427,9 +1427,10 @@
 #ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
+MODULE_LICENSE("GPL");
+
 MODULE_PARM(i2c_debug, "i");
 MODULE_PARM_DESC(i2c_debug,"debug level");
-MODULE_LICENSE("GPL");
 
 int init_module(void) 
 {
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-dev.c linux-2.4.24-pre1-k/drivers/i2c/i2c-dev.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-dev.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-dev.c	Thu Dec 11 20:40:08 2003
@@ -159,9 +159,9 @@
 
 	struct i2c_client *client = (struct i2c_client *)file->private_data;
 
-	if(count > 8192)
+	if (count > 8192)
 		count = 8192;
-		
+
 	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp=NULL)
@@ -190,9 +190,9 @@
 	struct inode *inode = file->f_dentry->d_inode;
 #endif /* DEBUG */
 
-	if(count > 8192)
+	if (count > 8192)
 		count = 8192;
-		
+
 	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp=NULL)
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-elv.c linux-2.4.24-pre1-k/drivers/i2c/i2c-elv.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-elv.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-elv.c	Thu Dec 11 20:40:08 2003
@@ -202,7 +202,6 @@
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
 MODULE_LICENSE("GPL");
 
-
 MODULE_PARM(base, "i");
 
 int init_module(void)
diff -ruN linux-2.4.24-pre1/drivers/media/video/saa7110.c linux-2.4.24-pre1-k/drivers/media/video/saa7110.c
--- linux-2.4.24-pre1/drivers/media/video/saa7110.c	Wed Dec 10 07:43:27 2003
+++ linux-2.4.24-pre1-k/drivers/media/video/saa7110.c	Thu Dec 11 20:40:08 2003
@@ -404,7 +404,7 @@
 {
 	"saa7110",			/* name */
 
-	I2C_DRIVERID_VIDEODECODER,	/* in i2c.h */
+	I2C_DRIVERID_VIDEODECODER,	/* in i2c-old.h */
 	I2C_SAA7110, I2C_SAA7110+1,	/* Addr range */
 
 	saa7110_attach,
diff -ruN linux-2.4.24-pre1/include/linux/i2c-id.h linux-2.4.24-pre1-k/include/linux/i2c-id.h
--- linux-2.4.24-pre1/include/linux/i2c-id.h	Wed Dec 10 22:34:02 2003
+++ linux-2.4.24-pre1-k/include/linux/i2c-id.h	Thu Dec 11 20:42:15 2003
@@ -90,7 +90,7 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_ADV717X   48     /* video encoder                 */
+#define I2C_DRIVERID_ADV7175	48     /* ADV 7175/7176 video encoder	*/
 #define I2C_DRIVERID_MAX1617	56     /* temp sensor			*/
 #define I2C_DRIVERID_SAA7191	57     /* video decoder                 */
 #define I2C_DRIVERID_INDYCAM	58     /* SGI IndyCam			*/
@@ -213,7 +213,7 @@
 #define I2C_HW_SMBUS_AMD756	0x05
 #define I2C_HW_SMBUS_SIS5595	0x06
 #define I2C_HW_SMBUS_ALI1535	0x07
-#define I2C_HW_SMBUS_W9968CF	0x08
+#define I2C_HW_SMBUS_W9968CF	0x0d
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
