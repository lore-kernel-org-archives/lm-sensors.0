From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:03:06 +0000
Subject: [lm-sensors] [patch 35/36] hwmon: (w83795) Use dev_get_drvdata()
Message-Id: <20100915160306.350331b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When we don't need the client pointer, calling dev_get_drvdata() is
more efficient that calling to_i2c_client() and then
i2c_get_clientdata().

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:15:57.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:16:00.000000000 +0200
@@ -1265,8 +1265,7 @@ store_temp(struct device *dev, struct de
 static ssize_t
 show_dts_mode(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = dev_get_drvdata(dev);
 	int tmp;
 
 	if (data->enable_dts & 2)
@@ -1296,8 +1295,7 @@ show_dts_ext(struct device *dev, struct
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = dev_get_drvdata(dev);
 	long temp = temp_from_reg(data->dts_ext[nr]);
 
 	return sprintf(buf, "%ld\n", temp);
@@ -1328,8 +1326,7 @@ store_dts_ext(struct device *dev, struct
 static ssize_t
 show_temp_mode(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
