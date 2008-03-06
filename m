From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 06 Mar 2008 14:10:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7473) minor cleanup / refactoring
Message-Id: <20080306141041.GP2892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 adt7473.c |   45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

commit ca6edcdc9be92ca3869d5e13f85dbea2b7f794fe
Author: Mark M. Hoffman <mhoffman@lightlink.com>
Date:   Thu Mar 6 08:41:09 2008 -0500

    hwmon: (adt7473) minor cleanup / refactoring
    
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 9587869..c1009d6 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -422,18 +422,14 @@ static ssize_t show_volt(struct device *dev, struct device_attribute *devattr,
  * number in the range -128 to 127, or as an unsigned number that must
  * be offset by 64.
  */
-static int decode_temp(struct adt7473_data *data, u8 raw)
+static int decode_temp(u8 twos_complement, u8 raw)
 {
-	if (data->temp_twos_complement)
-		return (s8)raw;
-	return raw - 64;
+	return twos_complement ? (s8)raw : raw - 64;
 }
 
-static u8 encode_temp(struct adt7473_data *data, int cooked)
+static u8 encode_temp(u8 twos_complement, int cooked)
 {
-	if (data->temp_twos_complement)
-		return (cooked & 0xFF);
-	return cooked + 64;
+	return twos_complement ? cooked & 0xFF : cooked + 64;
 }
 
 static ssize_t show_temp_min(struct device *dev,
@@ -442,8 +438,9 @@ static ssize_t show_temp_min(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_min[attr->index]));
+	return sprintf(buf, "%d\n", 1000 * decode_temp(
+						data->temp_twos_complement,
+						data->temp_min[attr->index]));
 }
 
 static ssize_t set_temp_min(struct device *dev,
@@ -455,7 +452,7 @@ static ssize_t set_temp_min(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	int temp = simple_strtol(buf, NULL, 10) / 1000;
-	temp = encode_temp(data, temp);
+	temp = encode_temp(data->temp_twos_complement, temp);
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
@@ -472,8 +469,9 @@ static ssize_t show_temp_max(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_max[attr->index]));
+	return sprintf(buf, "%d\n", 1000 * decode_temp(
+						data->temp_twos_complement,
+						data->temp_max[attr->index]));
 }
 
 static ssize_t set_temp_max(struct device *dev,
@@ -485,7 +483,7 @@ static ssize_t set_temp_max(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	int temp = simple_strtol(buf, NULL, 10) / 1000;
-	temp = encode_temp(data, temp);
+	temp = encode_temp(data->temp_twos_complement, temp);
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
@@ -501,8 +499,9 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp[attr->index]));
+	return sprintf(buf, "%d\n", 1000 * decode_temp(
+						data->temp_twos_complement,
+						data->temp[attr->index]));
 }
 
 static ssize_t show_fan_min(struct device *dev,
@@ -671,8 +670,9 @@ static ssize_t show_temp_tmax(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_tmax[attr->index]));
+	return sprintf(buf, "%d\n", 1000 * decode_temp(
+						data->temp_twos_complement,
+						data->temp_tmax[attr->index]));
 }
 
 static ssize_t set_temp_tmax(struct device *dev,
@@ -684,7 +684,7 @@ static ssize_t set_temp_tmax(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	int temp = simple_strtol(buf, NULL, 10) / 1000;
-	temp = encode_temp(data, temp);
+	temp = encode_temp(data->temp_twos_complement, temp);
 
 	mutex_lock(&data->lock);
 	data->temp_tmax[attr->index] = temp;
@@ -701,8 +701,9 @@ static ssize_t show_temp_tmin(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
-	return sprintf(buf, "%d\n",
-		       1000 * decode_temp(data, data->temp_tmin[attr->index]));
+	return sprintf(buf, "%d\n", 1000 * decode_temp(
+						data->temp_twos_complement,
+						data->temp_tmin[attr->index]));
 }
 
 static ssize_t set_temp_tmin(struct device *dev,
@@ -714,7 +715,7 @@ static ssize_t set_temp_tmin(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
 	int temp = simple_strtol(buf, NULL, 10) / 1000;
-	temp = encode_temp(data, temp);
+	temp = encode_temp(data->temp_twos_complement, temp);
 
 	mutex_lock(&data->lock);
 	data->temp_tmin[attr->index] = temp;
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
