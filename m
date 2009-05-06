From: Michael Abbott <michael@araneidae.co.uk>
Date: Wed, 06 May 2009 07:29:52 +0000
Subject: [lm-sensors] [PATCH 2.6.29.2] Add low_power support for adm1021
Message-Id: <Pine.LNX.4.64.0905060826530.24668@venus.araneidae.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

Occasionally it is helpful to be able to turn a temperature sensor off
(for example if it's making unwanted electrical noise).  This patch
adds a sysfs node to put any adm1021 compatible device into low power mode.

In low power mode a special single-shot command is required to take a 
measurement: this is not implemented in this patch.

Signed-off-by: Michael Abbott <michael.abbott@diamond.ac.uk>
---
 drivers/hwmon/adm1021.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index b11e06f..ba7a423 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -83,6 +83,7 @@ struct adm1021_data {
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
+	char low_power;		/* !=0 if device in low power mode */
 	unsigned long last_updated;	/* In jiffies */
 
 	s8 temp_max[2];		/* Register values */
@@ -216,6 +217,35 @@ static ssize_t set_temp_min(struct device *dev,
 	return count;
 }
 
+static ssize_t show_low_power(
+	struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct adm1021_data *data = adm1021_update_device(dev);
+	return sprintf(buf, "%d\n", data->low_power);
+}
+
+static ssize_t set_low_power(
+	struct device *dev, struct device_attribute *devattr,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1021_data *data = i2c_get_clientdata(client);
+	int low_power = simple_strtol(buf, NULL, 10) != 0;
+	mutex_lock(&data->update_lock);
+
+	if (low_power != data->low_power) {
+		int config = i2c_smbus_read_byte_data(
+			client, ADM1021_REG_CONFIG_R);
+		data->low_power = low_power;
+		i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
+			(config & 0xBF) | (low_power << 6));
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
 			  set_temp_max, 0);
@@ -233,6 +263,8 @@ static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(
+	low_power, S_IWUSR | S_IRUGO, show_low_power, set_low_power);
 
 static struct attribute *adm1021_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
@@ -247,6 +279,7 @@ static struct attribute *adm1021_attributes[] = {
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&dev_attr_alarms.attr,
+	&dev_attr_low_power.attr,
 	NULL
 };
 
-- 
1.6.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
