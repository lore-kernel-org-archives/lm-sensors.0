From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Aug 2007 09:40:10 +0000
Subject: Re: [lm-sensors] [PATCH] Allow writing of negative trigger
Message-Id: <20070816114010.19d6516f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816081353.GF10132@tweety>
In-Reply-To: <20070816081353.GF10132@tweety>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian, Mark,

On Thu, 16 Aug 2007 10:13:53 +0200, Christian Hohnstaedt wrote:
>   - replace differing temperature variable types by long
>   - use strtol() instead of strtoul() for conversion
> 
> Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
> ---
>  drivers/hwmon/ad7418.c    |    2 +-
>  drivers/hwmon/adm1021.c   |    2 +-
>  drivers/hwmon/asb100.c    |    4 ++--
>  drivers/hwmon/ds1621.c    |    2 +-
>  drivers/hwmon/lm75.c      |    2 +-
>  drivers/hwmon/lm75.h      |    2 +-
>  drivers/hwmon/lm77.c      |    2 +-
>  drivers/hwmon/lm93.c      |   10 +++++-----
>  drivers/hwmon/w83627ehf.c |    6 +++---
>  drivers/hwmon/w83627hf.c  |    6 +++---
>  drivers/hwmon/w83781d.c   |    2 +-
>  11 files changed, 20 insertions(+), 20 deletions(-)

I retested w83627ehf and it's now OK for all temperature channels. I
also tested adm1021, successfully. I can't test lm77 nor lm93 but the
code looks right.

I had to rediff the adm1021 part due to this patch from Krzysztof Helt
in Mark's tree:
http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=commit;ha040d50b43652607ad4677fb4b0ba91ea33be3

So here is the updated patch. Mark, please apply.

From: Christian Hohnstaedt <chohnstaedt@innominate.com>
Subject: hwmon: Allow writing of negative trigger temperatures

- replace differing temperature variable types by long
- use strtol() instead of strtoul() for conversion

Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
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

--- linux-2.6.23-rc3.orig/drivers/hwmon/ad7418.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/ad7418.c	2007-08-16 11:17:36.000000000 +0200
@@ -172,7 +172,7 @@ static ssize_t set_temp(struct device *d
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ad7418_data *data = i2c_get_clientdata(client);
-	int temp = simple_strtol(buf, NULL, 10);
+	long temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->lock);
 	data->temp[attr->index] = LM75_TEMP_TO_REG(temp);
--- linux-2.6.23-rc3.orig/drivers/hwmon/adm1021.c	2007-08-15 20:08:26.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/adm1021.c	2007-08-16 11:18:10.000000000 +0200
@@ -162,7 +162,7 @@ static ssize_t set_##value(struct device
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct adm1021_data *data = i2c_get_clientdata(client);		\
-	int temp = simple_strtoul(buf, NULL, 10);			\
+	long temp = simple_strtol(buf, NULL, 10);			\
 									\
 	mutex_lock(&data->update_lock);					\
 	data->value = TEMP_TO_REG(temp);				\
--- linux-2.6.23-rc3.orig/drivers/hwmon/asb100.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/asb100.c	2007-08-16 11:17:36.000000000 +0200
@@ -143,7 +143,7 @@ static int FAN_FROM_REG(u8 val, int div)
 
 /* TEMP: 0.001C/bit (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 TEMP_TO_REG(int temp)
+static u8 TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
 	ntemp += (ntemp<0 ? -500 : 500);
@@ -448,7 +448,7 @@ static ssize_t set_##reg(struct device *
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	switch (nr) { \
--- linux-2.6.23-rc3.orig/drivers/hwmon/ds1621.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/ds1621.c	2007-08-16 11:17:36.000000000 +0200
@@ -151,7 +151,7 @@ static ssize_t set_temp(struct device *d
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ds1621_data *data = ds1621_update_client(dev);
-	u16 val = LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));
+	u16 val = LM75_TEMP_TO_REG(simple_strtol(buf, NULL, 10));
 
 	mutex_lock(&data->update_lock);
 	data->temp[attr->index] = val;
--- linux-2.6.23-rc3.orig/drivers/hwmon/lm75.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/lm75.c	2007-08-16 11:17:36.000000000 +0200
@@ -95,7 +95,7 @@ static ssize_t set_temp(struct device *d
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-	unsigned long temp = simple_strtoul(buf, NULL, 10);
+	long temp = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = LM75_TEMP_TO_REG(temp);
--- linux-2.6.23-rc3.orig/drivers/hwmon/lm75.h	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/lm75.h	2007-08-16 11:17:36.000000000 +0200
@@ -33,7 +33,7 @@
 
 /* TEMP: 0.001C/bit (-55C to +125C)
    REG: (0.5C/bit, two's complement) << 7 */
-static inline u16 LM75_TEMP_TO_REG(int temp)
+static inline u16 LM75_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
 	ntemp += (ntemp<0 ? -250 : 250);
--- linux-2.6.23-rc3.orig/drivers/hwmon/lm77.c	2007-07-22 11:56:48.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/lm77.c	2007-08-16 11:17:36.000000000 +0200
@@ -138,7 +138,7 @@ static ssize_t set_##value(struct device
 {										\
 	struct i2c_client *client = to_i2c_client(dev);				\
 	struct lm77_data *data = i2c_get_clientdata(client);			\
-	long val = simple_strtoul(buf, NULL, 10);				\
+	long val = simple_strtol(buf, NULL, 10);				\
 										\
 	mutex_lock(&data->update_lock);						\
 	data->value = val;				\
--- linux-2.6.23-rc3.orig/drivers/hwmon/lm93.c	2007-08-08 16:53:14.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/lm93.c	2007-08-16 11:17:36.000000000 +0200
@@ -413,7 +413,7 @@ static int LM93_TEMP_FROM_REG(u8 reg)
 
 /* TEMP: 1/1000 degrees C (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 LM93_TEMP_TO_REG(int temp)
+static u8 LM93_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
 	ntemp += (ntemp<0 ? -500 : 500);
@@ -1268,7 +1268,7 @@ static ssize_t store_temp_min(struct dev
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].min = LM93_TEMP_TO_REG(val);
@@ -1298,7 +1298,7 @@ static ssize_t store_temp_max(struct dev
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_lim[nr].max = LM93_TEMP_TO_REG(val);
@@ -1329,7 +1329,7 @@ static ssize_t store_temp_auto_base(stru
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
@@ -1360,7 +1360,7 @@ static ssize_t store_temp_auto_boost(str
 	int nr = (to_sensor_dev_attr(attr))->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm93_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->boost[nr] = LM93_TEMP_TO_REG(val);
--- linux-2.6.23-rc3.orig/drivers/hwmon/w83627ehf.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/w83627ehf.c	2007-08-16 11:17:36.000000000 +0200
@@ -223,7 +223,7 @@ temp1_from_reg(s8 reg)
 }
 
 static inline s8
-temp1_to_reg(int temp, int min, int max)
+temp1_to_reg(long temp, int min, int max)
 {
 	if (temp <= min)
 		return min / 1000;
@@ -805,7 +805,7 @@ store_temp1_##reg(struct device *dev, st
 		  const char *buf, size_t count) \
 { \
 	struct w83627ehf_data *data = dev_get_drvdata(dev); \
-	u32 val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	data->temp1_##reg = temp1_to_reg(val, -128000, 127000); \
@@ -840,7 +840,7 @@ store_##reg(struct device *dev, struct d
 	struct w83627ehf_data *data = dev_get_drvdata(dev); \
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
-	u32 val = simple_strtoul(buf, NULL, 10); \
+	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock); \
 	data->reg[nr] = LM75_TEMP_TO_REG(val); \
--- linux-2.6.23-rc3.orig/drivers/hwmon/w83627hf.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/w83627hf.c	2007-08-16 11:17:36.000000000 +0200
@@ -263,7 +263,7 @@ static inline u8 FAN_TO_REG(long rpm, in
 
 /* TEMP: 0.001C/bit (-128C to +127C)
    REG: 1C/bit, two's complement */
-static u8 TEMP_TO_REG(int temp)
+static u8 TEMP_TO_REG(long temp)
 {
         int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
         ntemp += (ntemp<0 ? -500 : 500);
@@ -639,9 +639,9 @@ static ssize_t \
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
--- linux-2.6.23-rc3.orig/drivers/hwmon/w83781d.c	2007-08-16 11:15:37.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/w83781d.c	2007-08-16 11:17:36.000000000 +0200
@@ -408,7 +408,7 @@ static ssize_t store_temp_##reg (struct 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	struct w83781d_data *data = dev_get_drvdata(dev); \
 	int nr = attr->index; \
-	s32 val; \
+	long val; \
 	 \
 	val = simple_strtol(buf, NULL, 10); \
 	 \

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
