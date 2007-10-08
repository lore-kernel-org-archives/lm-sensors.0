From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Oct 2007 16:24:35 +0000
Subject: [lm-sensors] [PATCH] hwmon: VRM is not read from registers
Message-Id: <20071008182435.59c4727c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The VRM value is not read from chip registers, so there's no need
to update the device data cache before exporting the VRM value to
user-space.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c    |    2 +-
 drivers/hwmon/adm1026.c    |    2 +-
 drivers/hwmon/asb100.c     |    2 +-
 drivers/hwmon/it87.c       |    2 +-
 drivers/hwmon/lm85.c       |    2 +-
 drivers/hwmon/lm87.c       |    2 +-
 drivers/hwmon/pc87360.c    |    2 +-
 drivers/hwmon/smsc47m192.c |    2 +-
 drivers/hwmon/w83627hf.c   |    2 +-
 drivers/hwmon/w83781d.c    |    2 +-
 drivers/hwmon/w83791d.c    |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.23-rc9.orig/drivers/hwmon/adm1025.c	2007-10-08 18:23:55.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/adm1025.c	2007-10-08 18:23:57.000000000 +0200
@@ -292,7 +292,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct adm1025_data *data = adm1025_update_device(dev);
+	struct adm1025_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
--- linux-2.6.23-rc9.orig/drivers/hwmon/adm1026.c	2007-10-08 18:23:55.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/adm1026.c	2007-10-08 18:23:57.000000000 +0200
@@ -1221,7 +1221,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct adm1026_data *data = adm1026_update_device(dev);
+	struct adm1026_data *data = dev_get_drvdata(dev);
 	return sprintf(buf,"%d\n", data->vrm);
 }
 static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf,
--- linux-2.6.23-rc9.orig/drivers/hwmon/asb100.c	2007-10-08 18:23:55.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/asb100.c	2007-10-08 18:23:57.000000000 +0200
@@ -514,7 +514,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 /* VRM */
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct asb100_data *data = asb100_update_device(dev);
+	struct asb100_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
--- linux-2.6.23-rc9.orig/drivers/hwmon/it87.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/it87.c	2007-10-08 18:23:57.000000000 +0200
@@ -765,7 +765,7 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct it87_data *data = it87_update_device(dev);
+	struct it87_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t
--- linux-2.6.23-rc9.orig/drivers/hwmon/lm85.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/lm85.c	2007-10-08 18:23:57.000000000 +0200
@@ -438,7 +438,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct lm85_data *data = lm85_update_device(dev);
+	struct lm85_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
--- linux-2.6.23-rc9.orig/drivers/hwmon/lm87.c	2007-10-08 18:23:57.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/lm87.c	2007-10-08 18:23:57.000000000 +0200
@@ -501,7 +501,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct lm87_data *data = lm87_update_device(dev);
+	struct lm87_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
--- linux-2.6.23-rc9.orig/drivers/hwmon/pc87360.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/pc87360.c	2007-10-08 18:23:57.000000000 +0200
@@ -500,7 +500,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct pc87360_data *data = pc87360_update_device(dev);
+	struct pc87360_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
--- linux-2.6.23-rc9.orig/drivers/hwmon/smsc47m192.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/smsc47m192.c	2007-10-08 18:23:57.000000000 +0200
@@ -334,7 +334,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	struct smsc47m192_data *data = smsc47m192_update_device(dev);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
--- linux-2.6.23-rc9.orig/drivers/hwmon/w83627hf.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/w83627hf.c	2007-10-08 18:23:57.000000000 +0200
@@ -703,7 +703,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w83627hf_data *data = w83627hf_update_device(dev);
+	struct w83627hf_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
--- linux-2.6.23-rc9.orig/drivers/hwmon/w83781d.c	2007-10-08 18:23:57.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/w83781d.c	2007-10-08 18:23:57.000000000 +0200
@@ -453,7 +453,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w83781d_data *data = w83781d_update_device(dev);
+	struct w83781d_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 
--- linux-2.6.23-rc9.orig/drivers/hwmon/w83791d.c	2007-10-08 18:23:56.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/w83791d.c	2007-10-08 18:23:57.000000000 +0200
@@ -832,7 +832,7 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 static ssize_t show_vrm_reg(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct w83791d_data *data = w83791d_update_device(dev);
+	struct w83791d_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
