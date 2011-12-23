From: kg4ysn@gmail.com
Date: Fri, 23 Dec 2011 10:15:43 +0000
Subject: [lm-sensors] [PATCH 1/2] Added resolution control to lm73 driver
Message-Id: <1324635343-24105-1-git-send-email-kg4ysn@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Chris Verges <kg4ysn@gmail.com>

The LM73 sensor supports four resolutions (11-bit to 14-bit).  The
number of bits used are controlled via the control/status register on
the LM73.  This patch adds a sysfs interface to manipulate the
appropriate bits in the control/status register.

Example usage:

  # set resolution to 11-bit (default)
  echo "11" > /sys/class/hwmon/hwmon0/device/temp1_resolution

  # set resolution to 14-bit
  echo "14" > /sys/class/hwmon/hwmon0/device/temp1_resolution

  # read current resolution
  cat /sys/class/hwmon/hwmon0/device/temp1_resolution

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 drivers/hwmon/lm73.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 9e64d96..e9fb992 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -73,6 +73,61 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 	return sprintf(buf, "%d\n", temp);
 }
 
+static ssize_t set_resolution(struct device *dev,
+			struct device_attribute *da, const char *buf,
+			size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	long value;
+	int reg = strict_strtol(buf, 10, &value);
+	if (reg < 0)
+		return reg;
+
+	if (value < 11 || value > 14)
+		return -EINVAL;
+
+	/* Read the current control/status register */
+	reg = i2c_smbus_read_byte_data(client, attr->index);
+	if (reg < 0)
+		return -EIO;
+
+	reg &= 0x7F;	/* Remove all non-essential bits */
+
+	/*
+	 * Control/Status register bit description:
+	 *
+	 * D[7]   Time-Out Disable
+	 * D[6:5] Temperature Resolution
+	 *        00: 0.25    C/LSB
+	 *        01: 0.125   C/LSB
+	 *        10: 0.0625  C/LSB
+	 *        11: 0.03125 C/LSB
+	 * D[4]   Reserved
+	 * D[3]   Alert Pin Status
+	 * D[2]   Temperature High Flag
+	 * D[1]   Temperature Low Flag
+	 * D[0]   Data Available Flag
+	 */
+
+	/* Convert the resolution from the integer value to the bitmask */
+	value -= 11;
+	value <<= 5;
+	value |= reg;
+
+	/* Write the new control/status register value */
+	i2c_smbus_write_byte_data(client, attr->index, value);
+	return count;
+}
+
+static ssize_t show_resolution(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	int value = i2c_smbus_read_byte_data(client, attr->index);
+	return sprintf(buf, "%d\n", value);
+}
 
 /*-----------------------------------------------------------------------*/
 
@@ -84,13 +139,14 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, LM73_REG_MIN);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			show_temp, NULL, LM73_REG_INPUT);
-
+static SENSOR_DEVICE_ATTR(temp1_resolution, S_IWUSR | S_IRUGO,
+			show_resolution, set_resolution, LM73_REG_CTRL);
 
 static struct attribute *lm73_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
-
+	&sensor_dev_attr_temp1_resolution.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.4.1


From 171bd4d58d5e9ded28bf3d105a714c6d9486927b Mon Sep 17 00:00:00 2001
From: Chris Verges <kg4ysn@gmail.com>
Date: Fri, 23 Dec 2011 02:10:27 -0800
Subject: [PATCH 2/2] Replaced strict_strtol with kstrtol in lm73 set_resolution()

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 drivers/hwmon/lm73.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index e9fb992..ca1eff1 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -80,7 +80,7 @@ static ssize_t set_resolution(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
 	long value;
-	int reg = strict_strtol(buf, 10, &value);
+	int reg = kstrtol(buf, 10, &value);
 	if (reg < 0)
 		return reg;
 
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
