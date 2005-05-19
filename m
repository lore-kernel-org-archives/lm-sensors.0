From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] I2C: rename in0_ref to cpu0_vid
Message-Id: <20040812224551.712f8b5e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch changes all the i2c chip drivers and documentation to use the
name "cpu0_vid" instead of "in0_ref". The name "in0_ref" was an error in
the first place as motherboard manufacturers may fail to follow the chip
manufacturer's recommendation about which "in" channel to use for VCore
monitoring.

The new name leaves room for chips able to monitor more than 1 vid
value, such as the LM93 and, to a lesser extent, the PC87360 family (all
by National Semiconductor). These chips are typically designed for
dual-CPU motherboards.

This breaks the interface (obviously) so libsensors has been updated to
support both names.

Please apply,
thanks.

Signed-off-by; Jean Delvare <khali at linux-fr dot org>

diff -ruN linux-2.6.8-rc4.orig/Documentation/i2c/sysfs-interface linux-2.6.8-rc4/Documentation/i2c/sysfs-interface
--- linux-2.6.8-rc4.orig/Documentation/i2c/sysfs-interface	2004-08-12 21:45:25.000000000 +0200
+++ linux-2.6.8-rc4/Documentation/i2c/sysfs-interface	2004-08-12 21:57:05.000000000 +0200
@@ -104,7 +104,7 @@
 			in7_*	varies
 			in8_*	varies
 
-in0_ref		CPU core reference voltage.
+cpu[0-1]_vid	CPU core reference voltage.
 		Unit: millivolt
 		Read only.
 		Not always correct.
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/asb100.c linux-2.6.8-rc4/drivers/i2c/chips/asb100.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/asb100.c	2004-08-12 21:48:33.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/asb100.c	2004-08-12 22:00:14.000000000 +0200
@@ -520,9 +520,9 @@
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
 static ssize_t show_vrm(struct device *dev, char *buf)
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/it87.c linux-2.6.8-rc4/drivers/i2c/chips/it87.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/it87.c	2004-08-12 21:48:33.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/it87.c	2004-08-12 22:00:13.000000000 +0200
@@ -571,9 +571,9 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/lm78.c linux-2.6.8-rc4/drivers/i2c/chips/lm78.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/lm78.c	2004-08-12 21:46:52.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/lm78.c	2004-08-12 22:00:12.000000000 +0200
@@ -423,7 +423,7 @@
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
@@ -615,7 +615,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_in0_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 
 	return 0;
 
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/lm85.c linux-2.6.8-rc4/drivers/i2c/chips/lm85.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/lm85.c	2004-08-12 21:48:33.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/lm85.c	2004-08-12 22:00:12.000000000 +0200
@@ -465,7 +465,7 @@
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -874,7 +874,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
-	device_create_file(&new_client->dev, &dev_attr_in0_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/w83627hf.c linux-2.6.8-rc4/drivers/i2c/chips/w83627hf.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/w83627hf.c	2004-08-12 21:48:33.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/w83627hf.c	2004-08-12 22:00:11.000000000 +0200
@@ -635,9 +635,9 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
diff -ruN linux-2.6.8-rc4.orig/drivers/i2c/chips/w83781d.c linux-2.6.8-rc4/drivers/i2c/chips/w83781d.c
--- linux-2.6.8-rc4.orig/drivers/i2c/chips/w83781d.c	2004-08-12 21:48:33.000000000 +0200
+++ linux-2.6.8-rc4/drivers/i2c/chips/w83781d.c	2004-08-12 21:59:39.000000000 +0200
@@ -503,9 +503,9 @@
 }
 
 static
-DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref);
+device_create_file(&client->dev, &dev_attr_cpu0_vid);
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
 {


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
