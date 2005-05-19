From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: Merge unused address lists in some video drivers
Message-Id: <20050402200441.7bf7a310.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

On top of my previous patch which removes the use of address ranges in
video i2c drivers, this one can save an additional few bytes of memory.
Most of these drivers which do not use I2C_CLIENT_INSMOD initialize the
unused address lists in a less than optimal way. This patch simply
optimizes this, by using a single one-element list instead of 3
different lists with two elements each.

This saves an average 63 bytes on these drivers.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7170.c linux-2.6.12-rc1-bk5/drivers/media/video/adv7170.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7170.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/adv7170.c	Thu Mar 31 16:02:57 2005
@@ -385,15 +385,13 @@
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7170;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7175.c linux-2.6.12-rc1-bk5/drivers/media/video/adv7175.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/adv7175.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/adv7175.c	Thu Mar 31 16:02:15 2005
@@ -435,15 +435,13 @@
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_adv7175;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt819.c linux-2.6.12-rc1-bk5/drivers/media/video/bt819.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt819.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/bt819.c	Thu Mar 31 15:57:17 2005
@@ -501,15 +501,13 @@
 	I2C_CLIENT_END,
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt819;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt856.c linux-2.6.12-rc1-bk5/drivers/media/video/bt856.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/bt856.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/bt856.c	Thu Mar 31 15:57:28 2005
@@ -289,15 +289,13 @@
  */
 static unsigned short normal_i2c[] = { I2C_BT856 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_bt856;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7110.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7110.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7110.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7110.c	Thu Mar 31 15:57:33 2005
@@ -464,15 +464,13 @@
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7110;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7111.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7111.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7111.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7111.c	Thu Mar 31 16:04:26 2005
@@ -483,15 +483,13 @@
  */
 static unsigned short normal_i2c[] = { I2C_SAA7111 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7111;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7114.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7114.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7114.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7114.c	Thu Mar 31 16:00:00 2005
@@ -821,15 +821,13 @@
 static unsigned short normal_i2c[]      { I2C_SAA7114 >> 1, I2C_SAA7114A >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7114;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7185.c linux-2.6.12-rc1-bk5/drivers/media/video/saa7185.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/saa7185.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/saa7185.c	Thu Mar 31 16:03:40 2005
@@ -381,15 +381,13 @@
  */
 static unsigned short normal_i2c[] = { I2C_SAA7185 >> 1, I2C_CLIENT_END };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver i2c_driver_saa7185;
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-3036.c linux-2.6.12-rc1-bk5/drivers/media/video/tuner-3036.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/tuner-3036.c	Thu Mar 31 14:42:46 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/tuner-3036.c	Thu Mar 31 15:57:13 2005
@@ -35,15 +35,13 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x60, 0x61, I2C_CLIENT_END };
-static unsigned short probe[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2]       = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2]        = { I2C_CLIENT_END, I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c	= normal_i2c,
-	.probe		= probe,
-	.ignore		= ignore,
-	.force		= force,
+	.probe		= &ignore,
+	.ignore		= &ignore,
+	.force		= &ignore,
 };
 
 /* ---------------------------------------------------------------------- */
diff -ruN linux-2.6.12-rc1-bk5.orig/drivers/media/video/vpx3220.c linux-2.6.12-rc1-bk5/drivers/media/video/vpx3220.c
--- linux-2.6.12-rc1-bk5.orig/drivers/media/video/vpx3220.c	Thu Mar 31 14:42:49 2005
+++ linux-2.6.12-rc1-bk5/drivers/media/video/vpx3220.c	Thu Mar 31 16:01:37 2005
@@ -570,15 +570,13 @@
 	I2C_CLIENT_END
 };
 
-static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short ignore[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
-static unsigned short force[2] = { I2C_CLIENT_END , I2C_CLIENT_END };
+static unsigned short ignore = I2C_CLIENT_END;
                                                                                 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_i2c,
-	.probe			= probe,
-	.ignore			= ignore,
-	.force			= force
+	.probe			= &ignore,
+	.ignore			= &ignore,
+	.force			= &ignore,
 };
 
 static struct i2c_driver vpx3220_i2c_driver;


-- 
Jean Delvare
