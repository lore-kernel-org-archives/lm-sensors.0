From: Wei Ni <wni@nvidia.com>
Date: Fri, 12 Jul 2013 07:48:04 +0000
Subject: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <1373615287-18502-2-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
In-Reply-To: <1373615287-18502-1-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, linux@roeck-us.net, thierry.reding@gmail.com
Cc: linux-tegra@vger.kernel.org, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Split set&show temp codes as common functions, so we can use it directly when
implement linux thermal framework.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/hwmon/lm90.c |  112 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 8eeb141..5f30f90 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -702,29 +702,34 @@ static u16 temp_to_u16_adt7461(struct lm90_data *data, long val)
  * Sysfs stuff
  */
 
-static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
-			  char *buf)
+static int read_temp8(struct device *dev, int index)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
 	int temp;
 
 	if (data->kind = adt7461)
-		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
+		temp = temp_from_u8_adt7461(data, data->temp8[index]);
 	else if (data->kind = max6646)
-		temp = temp_from_u8(data->temp8[attr->index]);
+		temp = temp_from_u8(data->temp8[index]);
 	else
-		temp = temp_from_s8(data->temp8[attr->index]);
+		temp = temp_from_s8(data->temp8[index]);
 
 	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind = lm99 && attr->index = 3)
+	if (data->kind = lm99 && index = 3)
 		temp += 16000;
 
-	return sprintf(buf, "%d\n", temp);
+	return temp;
 }
 
-static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
-			 const char *buf, size_t count)
+static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return sprintf(buf, "%d\n", read_temp8(dev, attr->index));
+}
+
+static void write_temp8(struct device *dev, int index, long val)
 {
 	static const u8 reg[8] = {
 		LM90_REG_W_LOCAL_LOW,
@@ -737,60 +742,73 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 		MAX6659_REG_W_REMOTE_EMERG,
 	};
 
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int nr = attr->index;
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err < 0)
-		return err;
 
 	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind = lm99 && attr->index = 3)
+	if (data->kind = lm99 && index = 3)
 		val -= 16000;
 
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
-		data->temp8[nr] = temp_to_u8_adt7461(data, val);
+		data->temp8[index] = temp_to_u8_adt7461(data, val);
 	else if (data->kind = max6646)
-		data->temp8[nr] = temp_to_u8(val);
+		data->temp8[index] = temp_to_u8(val);
 	else
-		data->temp8[nr] = temp_to_s8(val);
+		data->temp8[index] = temp_to_s8(val);
 
-	lm90_select_remote_channel(client, data, nr >= 6);
-	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
+	lm90_select_remote_channel(client, data, index >= 6);
+	i2c_smbus_write_byte_data(client, reg[index], data->temp8[index]);
 	lm90_select_remote_channel(client, data, 0);
 
 	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	int index = attr->index;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	write_temp8(dev, index, val);
+
 	return count;
 }
 
-static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
-			   char *buf)
+static int read_temp11(struct device *dev, int index)
 {
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct lm90_data *data = lm90_update_device(dev);
 	int temp;
 
 	if (data->kind = adt7461)
-		temp = temp_from_u16_adt7461(data, data->temp11[attr->index]);
+		temp = temp_from_u16_adt7461(data, data->temp11[index]);
 	else if (data->kind = max6646)
-		temp = temp_from_u16(data->temp11[attr->index]);
+		temp = temp_from_u16(data->temp11[index]);
 	else
-		temp = temp_from_s16(data->temp11[attr->index]);
+		temp = temp_from_s16(data->temp11[index]);
 
 	/* +16 degrees offset for temp2 for the LM99 */
-	if (data->kind = lm99 &&  attr->index <= 2)
+	if (data->kind = lm99 &&  index <= 2)
 		temp += 16000;
 
-	return sprintf(buf, "%d\n", temp);
+	return temp;
 }
 
-static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
-			  const char *buf, size_t count)
+static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+
+	return sprintf(buf, "%d\n", read_temp11(dev, attr->index));
+}
+
+static void write_temp11(struct device *dev, int nr, int index, long val)
 {
 	struct {
 		u8 high;
@@ -804,17 +822,8 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 		{ LM90_REG_W_REMOTE_HIGHH, LM90_REG_W_REMOTE_HIGHL, 1 }
 	};
 
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
-	int nr = attr->nr;
-	int index = attr->index;
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err < 0)
-		return err;
 
 	/* +16 degrees offset for temp2 for the LM99 */
 	if (data->kind = lm99 && index <= 2)
@@ -839,6 +848,23 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	lm90_select_remote_channel(client, data, 0);
 
 	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int nr = attr->nr;
+	int index = attr->index;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	write_temp11(dev, nr, index, val);
+
 	return count;
 }
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
