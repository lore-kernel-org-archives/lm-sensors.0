From: Christian Hohnstaedt <chohnstaedt@innominate.com>
Date: Wed, 15 Aug 2007 15:32:03 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070815153203.GD10132@tweety>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  - replace differing temperature variable types by long
  - use strtol() instead of strtoul() for conversion

Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
---
 drivers/hwmon/ad7418.c    |    2 +-
 drivers/hwmon/asb100.c    |    4 ++--
 drivers/hwmon/ds1621.c    |    2 +-
 drivers/hwmon/lm75.c      |    2 +-
 drivers/hwmon/lm75.h      |    2 +-
 drivers/hwmon/w83627ehf.c |    2 +-
 drivers/hwmon/w83627hf.c  |    6 +++---
 drivers/hwmon/w83781d.c   |    2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

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
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index c51ae2e..e3ee30b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
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
