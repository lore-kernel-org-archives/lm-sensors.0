From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:02:53 +0000
Subject: [lm-sensors] [patch 34/36] hwmon: (w83795) Delay reading pwm config
Message-Id: <20100915160253.1865f1a6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wait until we need the pwm config register values, instead of
pre-reading them. This saves over 1 second on modprobe on my test
system.

Obviously this time is added when first accessing pwm config
attributes, however not everybody will use them, so it seems unfair
to slow down driver loading (and thus boot) for an optional feature.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   51 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:15:37.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:15:57.000000000 +0200
@@ -372,6 +372,7 @@ struct w83795_data {
 
 	char valid;
 	char valid_limits;
+	char valid_pwm_config;
 };
 
 /*
@@ -503,11 +504,17 @@ static void w83795_update_limits(struct
 	data->valid_limits = 1;
 }
 
-static void w83795_update_pwm_config(struct i2c_client *client)
+static struct w83795_data *w83795_update_pwm_config(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct w83795_data *data = i2c_get_clientdata(client);
 	int i, tmp;
 
+	mutex_lock(&data->update_lock);
+
+	if (data->valid_pwm_config)
+		goto END;
+
 	/* Read temperature source selection */
 	for (i = 0; i < ARRAY_SIZE(data->temp_src); i++)
 		data->temp_src[i] = w83795_read(client, W83795_REG_TSS(i));
@@ -556,6 +563,12 @@ static void w83795_update_pwm_config(str
 	for (i = 0; i < ARRAY_SIZE(data->setup_pwm); i++)
 		data->setup_pwm[i]  			w83795_read(client, W83795_REG_SETUP_PWM(i));
+
+	data->valid_pwm_config = 1;
+
+END:
+	mutex_unlock(&data->update_lock);
+	return data;
 }
 
 static struct w83795_data *w83795_update_device(struct device *dev)
@@ -775,13 +788,16 @@ store_fan_min(struct device *dev, struct
 static ssize_t
 show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w83795_data *data = w83795_update_device(dev);
+	struct w83795_data *data;
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	unsigned int val;
 
+	data = nr = PWM_OUTPUT ? w83795_update_device(dev)
+				: w83795_update_pwm_config(dev);
+
 	switch (nr) {
 	case PWM_STOP_TIME:
 		val = time_from_reg(data->pwm[index][nr]);
@@ -835,8 +851,7 @@ show_pwm_enable(struct device *dev, stru
 {
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	int index = sensor_attr->index;
 	u8 tmp;
 
@@ -864,7 +879,7 @@ store_pwm_enable(struct device *dev, str
 	  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
@@ -905,8 +920,7 @@ show_temp_src(struct device *dev, struct
 {
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	int index = sensor_attr->index;
 	u8 val = index / 2;
 	u8 tmp = data->temp_src[val];
@@ -926,7 +940,7 @@ store_temp_src(struct device *dev, struc
 	  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
@@ -957,8 +971,7 @@ static ssize_t
 show_temp_pwm_enable(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -986,7 +999,7 @@ store_temp_pwm_enable(struct device *dev
 	  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -1023,8 +1036,7 @@ store_temp_pwm_enable(struct device *dev
 static ssize_t
 show_fanin(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -1081,8 +1093,7 @@ store_fanin(struct device *dev, struct d
 static ssize_t
 show_temp_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -1143,8 +1154,7 @@ store_temp_pwm(struct device *dev, struc
 static ssize_t
 show_sf4_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -1179,8 +1189,7 @@ store_sf4_pwm(struct device *dev, struct
 static ssize_t
 show_sf4_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
@@ -1456,8 +1465,7 @@ show_sf_setup(struct device *dev, struct
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int nr = sensor_attr->nr;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83795_data *data = i2c_get_clientdata(client);
+	struct w83795_data *data = w83795_update_pwm_config(dev);
 	u16 val = data->setup_pwm[nr];
 
 	switch (nr) {
@@ -2029,7 +2037,6 @@ static int w83795_probe(struct i2c_clien
 		data->has_pwm = 8;
 	else
 		data->has_pwm = 2;
-	w83795_update_pwm_config(client);
 
 	err = w83795_handle_files(dev, device_create_file);
 	if (err)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
