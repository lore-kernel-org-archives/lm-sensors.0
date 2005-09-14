From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 00:50:03 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: adm9240 updates
Message-Id: <3qlei19r8ek8sk32o3osekefl3b9l853tc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hwmon: adm9240 update 1/3: whitespace

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

--- linux-2.6.14-rc1/drivers/hwmon/adm9240.c	2005-09-13 18:36:27.000000000 +1000
+++ linux-2.6.14-rc1b/drivers/hwmon/adm9240.c	2005-09-14 07:07:08.000000000 +1000
@@ -350,7 +350,7 @@
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* 
+/*
  * set fan speed low limit:
  *
  * - value is zero: disable fan speed low limit alarm
@@ -449,7 +449,8 @@
 show_fan_offset(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -457,7 +458,8 @@
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -465,13 +467,15 @@
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_aout(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -486,7 +490,8 @@
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);
