From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Tue, 22 Apr 2008 22:54:41 +0000
Subject: [lm-sensors] [PATCH] adt7473: fix voltage conversion
Message-Id: <480E6CB1.1050800@teltonika.lt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070807090402060309030109"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070807090402060309030109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes voltage conversion routines.
According to the datasheet voltage is scaled with resistors and
value 192 is nominal voltage. 0 is 0V.
Conversion routines taken from the lm85 driver

Signed-of-by: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

--------------070807090402060309030109
Content-Type: text/x-patch;
 name="adt7473_voltage_conv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adt7473_voltage_conv.patch"

diff --git a/drivers/hwmon/adt7473.c b/drivers/hwmon/adt7473.c
index 9587869..6eeea6a 100644
--- a/drivers/hwmon/adt7473.c
+++ b/drivers/hwmon/adt7473.c
@@ -317,37 +317,21 @@ out:
 	return data;
 }
 
-/*
- * On this chip, voltages are given as a count of steps between a minimum
- * and maximum voltage, not a direct voltage.
+/* Conversions. Rounding and limit checking is only done on the TO_REG 
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
  */
-static const int volt_convert_table[][2] = {
-	{2997, 3},
-	{4395, 4},
-};
-
-static int decode_volt(int volt_index, u8 raw)
-{
-	int cmax = volt_convert_table[volt_index][0];
-	int cmin = volt_convert_table[volt_index][1];
-	return ((raw * (cmax - cmin)) / 255) + cmin;
-}
-
-static u8 encode_volt(int volt_index, int cooked)
-{
-	int cmax = volt_convert_table[volt_index][0];
-	int cmin = volt_convert_table[volt_index][1];
-	u8 x;
 
-	if (cooked > cmax)
-		cooked = cmax;
-	else if (cooked < cmin)
-		cooked = cmin;
+/* IN are scaled acording to built-in resistors */
+static int adt7473_scaling[] = {  /* .001 Volts */
+		2250, 3300
+	};
+#define SCALE(val,from,to)		(((val)*(to) + ((from)/2))/(from))
 
-	x = ((cooked - cmin) * 255) / (cmax - cmin);
+#define INS_TO_REG(n,val)	\
+		SENSORS_LIMIT(SCALE(val,adt7473_scaling[n],192),0,255)
 
-	return x;
-}
+#define INS_FROM_REG(n,val)	SCALE((val), 192, adt7473_scaling[n])
 
 static ssize_t show_volt_min(struct device *dev,
 			     struct device_attribute *devattr,
@@ -356,7 +340,7 @@ static ssize_t show_volt_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
 	return sprintf(buf, "%d\n",
-		       decode_volt(attr->index, data->volt_min[attr->index]));
+		       INS_FROM_REG(attr->index, data->volt_min[attr->index]));
 }
 
 static ssize_t set_volt_min(struct device *dev,
@@ -367,7 +351,7 @@ static ssize_t set_volt_min(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int volt = encode_volt(attr->index, simple_strtol(buf, NULL, 10));
+	int volt = INS_TO_REG(attr->index, simple_strtol(buf, NULL, 10));
 
 	mutex_lock(&data->lock);
 	data->volt_min[attr->index] = volt;
@@ -385,7 +369,7 @@ static ssize_t show_volt_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7473_data *data = adt7473_update_device(dev);
 	return sprintf(buf, "%d\n",
-		       decode_volt(attr->index, data->volt_max[attr->index]));
+		       INS_FROM_REG(attr->index, data->volt_max[attr->index]));
 }
 
 static ssize_t set_volt_max(struct device *dev,
@@ -396,7 +380,7 @@ static ssize_t set_volt_max(struct device *dev,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7473_data *data = i2c_get_clientdata(client);
-	int volt = encode_volt(attr->index, simple_strtol(buf, NULL, 10));
+	int volt = INS_TO_REG(attr->index, simple_strtol(buf, NULL, 10));
 
 	mutex_lock(&data->lock);
 	data->volt_max[attr->index] = volt;
@@ -414,7 +398,7 @@ static ssize_t show_volt(struct device *dev, struct device_attribute *devattr,
 	struct adt7473_data *data = adt7473_update_device(dev);
 
 	return sprintf(buf, "%d\n",
-		       decode_volt(attr->index, data->volt[attr->index]));
+		       INS_FROM_REG(attr->index, data->volt[attr->index]));
 }
 
 /*

--------------070807090402060309030109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070807090402060309030109--

