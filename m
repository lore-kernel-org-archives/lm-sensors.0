From: Christian Hohnstaedt <chohnstaedt@innominate.com>
Date: Thu, 16 Aug 2007 08:13:53 +0000
Subject: [lm-sensors] [PATCH] Allow writing of negative trigger temperatures
Message-Id: <20070816081353.GF10132@tweety>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  - replace differing temperature variable types by long
  - use strtol() instead of strtoul() for conversion

Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
---
 drivers/hwmon/ad7418.c    |    2 +-
 drivers/hwmon/adm1021.c   |    2 +-
 drivers/hwmon/asb100.c    |    4 ++--
 drivers/hwmon/ds1621.c    |    2 +-
 drivers/hwmon/lm75.c      |    2 +-
 drivers/hwmon/lm75.h      |    2 +-
 drivers/hwmon/lm77.c      |    2 +-
 drivers/hwmon/lm93.c      |   10 +++++-----
 drivers/hwmon/w83627ehf.c |    6 +++---
 drivers/hwmon/w83627hf.c  |    6 +++---
 drivers/hwmon/w83781d.c   |    2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index cc8b624..879ea72 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -172,7 +172,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7418_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->lock);
 	data->temp[attr->index] = LM75_TEMP_TO_REG(temp);
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index c466329..33d3ef7 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -161,7 +161,7 @@ static ssize_t set_##value(struct device *dev, struct device_attribute *attr, co
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct adm1021_data *data = i2c_get_clientdata(client);	\
-	int temp = simple_strtoul(buf, NULL, 10);		\
+	long temp = simple_strtol(buf, NULL, 10);		\
 								\
 	mutex_lock(&data->update_lock);				\
 	data->value = TEMP_TO_REG(temp);			\
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 57b1c7b..55d92e1 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -143,7 +143,7 @@ static int FAN_FROM_REG(u8 val, int div)
 
 /* TEMP: 0.001C/bit (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 TEMP_TO_REG(int temp)
+static u8 TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
 	ntemp += (ntemp<0 ? -500 : 500);
@@ -448,7 +448,7 @@ static ssize_t set_##reg(struct device *dev, const char *buf, \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	switch (nr) { \
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 1212d6b..5a861f9 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -151,7 +151,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1621_data *data = ds1621_update_client(dev);
-	u16 val = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));
+	u16 val = LM75_TEMP_TO_REG(simple_strtol(buf, NULL, 10));
 
 	mutex_lock(&data->update_lock);
 	data->temp[attr->index] = val;
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a40166f..4fa3220 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -95,7 +95,7 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-	unsigned long temp = simple_strtoul(buf, NULL, 10);
+	long temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = LM75_TEMP_TO_REG(temp);
diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
index af7dc65..7c93454 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -33,7 +33,7 @@
 
 /* TEMP: 0.001C/bit (-55C to +125C)
    REG: (0.5C/bit, two's complement) << 7 */
-static inline u16 LM75_TEMP_TO_REG(int temp)
+static inline u16 LM75_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
 	ntemp += (ntemp<0 ? -250 : 250);
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index dd969f1..46e3aba 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -138,7 +138,7 @@ static ssize_t set_##value(struct device *dev, struct device_attribute *attr, co
 {										\
 	struct i2c_client *client = to_i2c_client(dev);				\
 	struct lm77_data *data = i2c_get_clientdata(client);			\
-	long val = simple_strtoul(buf, NULL, 10);				\
+	long val = simple_strtol(buf, NULL, 10);				\
 										\
 	mutex_lock(&data->update_lock);						\
 	data->value = val;				\
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index d84f8bf..86c6c6e 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -413,7 +413,7 @@ static int LM93_TEMP_FROM_REG(u8 reg)
 
 /* TEMP: 1/1000 degrees C (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 LM93_TEMP_TO_REG(int temp)
+static u8 LM93_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
 	ntemp += (ntemp<0 ? -500 : 500);
@@ -1268,7 +1268,7 @@ static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].min = LM93_TEMP_TO_REG(val);
@@ -1298,7 +1298,7 @@ static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].max = LM93_TEMP_TO_REG(val);
@@ -1329,7 +1329,7 @@ static ssize_t store_temp_auto_base(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
@@ -1360,7 +1360,7 @@ static ssize_t store_temp_auto_boost(struct device *dev,
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->boost[nr] = LM93_TEMP_TO_REG(val);
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index c51ae2e..311987e 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -223,7 +223,7 @@ temp1_from_reg(s8 reg)
 }
 
 static inline s8
-temp1_to_reg(int temp, int min, int max)
+temp1_to_reg(long temp, int min, int max)
 {
 	if (temp <= min)
 		return min / 1000;
@@ -800,7 +800,7 @@ store_temp1_##reg(struct device *dev, struct device_attribute *attr, \
 		  const char *buf, size_t count) \
 { \
 	struct w83627ehf_data *data = dev_get_drvdata(dev); \
-	u32 val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	data->temp1_##reg = temp1_to_reg(val, -128000, 127000); \
@@ -835,7 +835,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	struct w83627ehf_data *data = dev_get_drvdata(dev); \
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
-	u32 val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	data->reg[nr] = LM75_TEMP_TO_REG(val); \
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 7a4a15f..0866739 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -263,7 +263,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 /* TEMP: 0.001C/bit (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 TEMP_TO_REG(int temp)
+static u8 TEMP_TO_REG(long temp)
 {
         int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
         ntemp += (ntemp<0 ? -500 : 500);
@@ -642,9 +642,9 @@ static ssize_t \
 store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
 { \
 	struct w83627hf_data *data = dev_get_drvdata(dev); \
-	u32 val; \
+	long val; \
 	 \
-	val = simple_strtoul(buf, NULL, 10); \
+	val = simple_strtol(buf, NULL, 10); \
 	 \
 	mutex_lock(&data->update_lock); \
 	 \
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index f85b48f..5783995 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -410,7 +410,7 @@ static ssize_t store_temp_##reg (struct device *dev, \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
 	int nr = attr->index; \
-	s32 val; \
+	long val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
 	 \
-- 
1.5.0.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
