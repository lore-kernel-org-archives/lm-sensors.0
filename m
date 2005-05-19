From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test7
Message-Id: <10662411483843@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10662411472283@kroah.com>
References: <1064526609700@kroah.com>
In-Reply-To: <1064526609700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1347.1.3, 2003/10/14 13:30:34-07:00, greg@kroah.com

[PATCH] I2C: fix more define problems in w83781d driver


 drivers/i2c/chips/w83781d.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:42 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:42 2003
@@ -426,7 +426,7 @@
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
 device_create_file(&client->dev, &dev_attr_in_max##offset); \
-} while (0);
+} while (0)
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -484,8 +484,10 @@
 sysfs_fan_min_offset(3);
 
 #define device_create_file_fan(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_fan_input##offset); \
 device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+} while (0)
 
 #define show_temp_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -568,9 +570,11 @@
 sysfs_temp_offsets(3);
 
 #define device_create_file_temp(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_temp_input##offset); \
 device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_min##offset);
+device_create_file(&client->dev, &dev_attr_temp_min##offset); \
+} while (0)
 
 static ssize_t
 show_vid_reg(struct device *dev, char *buf)
@@ -693,8 +697,10 @@
 sysfs_beep(MASK, mask);
 
 #define device_create_file_beep(client) \
+do { \
 device_create_file(&client->dev, &dev_attr_beep_enable); \
-device_create_file(&client->dev, &dev_attr_beep_mask);
+device_create_file(&client->dev, &dev_attr_beep_mask); \
+} while (0)
 
 /* w83697hf only has two fans */
 static ssize_t
@@ -771,7 +777,9 @@
 sysfs_fan_div(3);
 
 #define device_create_file_fan_div(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+} while (0)
 
 /* w83697hf only has two fans */
 static ssize_t
@@ -883,10 +891,14 @@
 sysfs_pwm(4);
 
 #define device_create_file_pwm(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_pwm##offset); \
+} while (0)
 
 #define device_create_file_pwmenable(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_pwm_enable##offset); \
+} while (0)
 
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
@@ -959,7 +971,9 @@
 sysfs_sensor(3);
 
 #define device_create_file_sensor(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_sensor##offset); \
+} while (0)
 
 #ifdef W83781D_RT
 static ssize_t
@@ -1018,7 +1032,9 @@
 sysfs_rt(3);
 
 #define device_create_file_rt(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_rt##offset); \
+} while (0)
 
 #endif				/* ifdef W83781D_RT */
 

