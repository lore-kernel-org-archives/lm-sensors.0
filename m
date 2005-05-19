From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: Kill common macro abuse in chip drivers
Message-Id: <20050516185238.1dd20356.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch kills a common macro abuse in i2c chip drivers: defining
ALARMS_FROM_REG returning its argument unchanged. Dropping the macro
makes the code somewhat more readable IMHO.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/asb100.c  |    4 +---
 drivers/i2c/chips/it87.c    |    4 +---
 drivers/i2c/chips/lm85.c    |    4 +---
 drivers/i2c/chips/via686a.c |    4 +---
 drivers/i2c/chips/w83781d.c |    3 +--
 5 files changed, 5 insertions(+), 14 deletions(-)

Index: linux-2.6.12-rc4/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.12-rc4.orig/drivers/i2c/chips/asb100.c	2005-05-07 18:44:14.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/asb100.c	2005-05-16 18:32:47.000000000 +0200
@@ -168,8 +168,6 @@
 	return reg * 16;
 }
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
@@ -556,7 +554,7 @@
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
Index: linux-2.6.12-rc4/drivers/i2c/chips/it87.c
=================================--- linux-2.6.12-rc4.orig/drivers/i2c/chips/it87.c	2005-05-10 22:08:19.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/it87.c	2005-05-16 18:32:35.000000000 +0200
@@ -172,8 +172,6 @@
 					((val)+500)/1000),-128,127))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define PWM_TO_REG(val)   ((val) >> 1)
 #define PWM_FROM_REG(val) (((val)&0x7f) << 1)
 
@@ -665,7 +663,7 @@
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
Index: linux-2.6.12-rc4/drivers/i2c/chips/lm85.c
=================================--- linux-2.6.12-rc4.orig/drivers/i2c/chips/lm85.c	2005-05-07 18:48:32.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/lm85.c	2005-05-16 18:32:28.000000000 +0200
@@ -284,8 +284,6 @@
 /* i2c-vid.h defines vid_from_reg() */
 #define VID_FROM_REG(val,vrm) (vid_from_reg((val),(vrm)))
 
-#define ALARMS_FROM_REG(val) (val)
-
 /* Unlike some other drivers we DO NOT set initial limits.  Use
  * the config file to set limits.  Some users have reported
  * motherboards shutting down when we set limits in a previous
@@ -480,7 +478,7 @@
 static ssize_t show_alarms_reg(struct device *dev, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
Index: linux-2.6.12-rc4/drivers/i2c/chips/via686a.c
=================================--- linux-2.6.12-rc4.orig/drivers/i2c/chips/via686a.c	2005-05-10 22:09:07.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/via686a.c	2005-05-16 18:28:02.000000000 +0200
@@ -292,8 +292,6 @@
 	        tempLUT[eightBits + 1] * twoBits) * 25;
 }
 
-#define ALARMS_FROM_REG(val) (val)
-
 #define DIV_FROM_REG(val) (1 << (val))
 #define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
 
@@ -570,7 +568,7 @@
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
Index: linux-2.6.12-rc4/drivers/i2c/chips/w83781d.c
=================================--- linux-2.6.12-rc4.orig/drivers/i2c/chips/w83781d.c	2005-05-12 18:30:07.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/w83781d.c	2005-05-16 18:32:41.000000000 +0200
@@ -172,7 +172,6 @@
 						: (val)) / 1000, 0, 0xff))
 #define TEMP_FROM_REG(val)		(((val) & 0x80 ? (val)-0x100 : (val)) * 1000)
 
-#define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
 #define BEEP_MASK_FROM_REG(val,type)	((type) = as99127f ? \
@@ -523,7 +522,7 @@
 show_alarms_reg(struct device *dev, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static


-- 
Jean Delvare
