From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 30 Jul 2013 08:13:06 +0000
Subject: [lm-sensors] [PATCH 20/35] hwmon: use dev_get_platdata()
Message-Id: <004f01ce8cfc$9f232190$dd6964b0$@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/ads7828.c          |    2 +-
 drivers/hwmon/ds620.c            |    2 +-
 drivers/hwmon/f71805f.c          |    2 +-
 drivers/hwmon/f71882fg.c         |    2 +-
 drivers/hwmon/f75375s.c          |    3 ++-
 drivers/hwmon/g762.c             |    2 +-
 drivers/hwmon/gpio-fan.c         |    2 +-
 drivers/hwmon/ina2xx.c           |    4 ++--
 drivers/hwmon/it87.c             |    6 +++---
 drivers/hwmon/lm87.c             |    4 ++--
 drivers/hwmon/max197.c           |    2 +-
 drivers/hwmon/max6639.c          |    2 +-
 drivers/hwmon/mcp3021.c          |    7 ++++---
 drivers/hwmon/nct6775.c          |    2 +-
 drivers/hwmon/ntc_thermistor.c   |    2 +-
 drivers/hwmon/pc87427.c          |    4 ++--
 drivers/hwmon/pmbus/pmbus_core.c |    2 +-
 drivers/hwmon/s3c-hwmon.c        |    6 +++---
 drivers/hwmon/sht15.c            |    4 ++--
 drivers/hwmon/smsc47m1.c         |    4 ++--
 drivers/hwmon/w83627ehf.c        |   20 ++++++++++----------
 drivers/hwmon/w83627hf.c         |    6 +++---
 22 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index ba962ac..7092c78 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -145,7 +145,7 @@ static int ads7828_remove(struct i2c_client *client)
 static int ads7828_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct ads7828_platform_data *pdata = client->dev.platform_data;
+	struct ads7828_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct ads7828_data *data;
 	int err;
 
diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
index f1d6b42..0918b91 100644
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -77,7 +77,7 @@ struct ds620_data {
 
 static void ds620_init_client(struct i2c_client *client)
 {
-	struct ds620_platform_data *ds620_info = client->dev.platform_data;
+	struct ds620_platform_data *ds620_info = dev_get_platdata(&client->dev);
 	u16 conf, new_conf;
 
 	new_conf = conf diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 0c9f3da..15b7f52 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1375,7 +1375,7 @@ static void f71805f_init_device(struct f71805f_data *data)
 
 static int f71805f_probe(struct platform_device *pdev)
 {
-	struct f71805f_sio_data *sio_data = pdev->dev.platform_data;
+	struct f71805f_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	struct f71805f_data *data;
 	struct resource *res;
 	int i, err;
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index cfb02dd..31b221e 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2267,7 +2267,7 @@ static int f71882fg_create_fan_sysfs_files(
 static int f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
-	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
+	struct f71882fg_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	int nr_fans = f71882fg_nr_fans[sio_data->type];
 	int nr_temps = f71882fg_nr_temps[sio_data->type];
 	int err, i;
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 9e300e5..a837b94 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -832,7 +832,8 @@ static int f75375_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct f75375_data *data;
-	struct f75375s_platform_data *f75375s_pdata = client->dev.platform_data;
+	struct f75375s_platform_data *f75375s_pdata +			dev_get_platdata(&client->dev);
 	int err;
 
 	if (!i2c_check_functionality(client->adapter,
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 73adf01..b4b8b5b 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -717,7 +717,7 @@ static void g762_of_clock_disable(struct i2c_client *client) { }
 
 static int g762_pdata_prop_import(struct i2c_client *client)
 {
-	struct g762_platform_data *pdata = client->dev.platform_data;
+	struct g762_platform_data *pdata = dev_get_platdata(&client->dev);
 	int ret;
 
 	if (!pdata)
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 3104149..b7d6a57 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -495,7 +495,7 @@ static int gpio_fan_probe(struct platform_device *pdev)
 {
 	int err;
 	struct gpio_fan_data *fan_data;
-	struct gpio_fan_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_fan_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 #ifdef CONFIG_OF_GPIO
 	if (!pdata) {
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d917a2d..18c0623 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -232,9 +232,9 @@ static int ina2xx_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	if (client->dev.platform_data) {
+	if (dev_get_platdata(&client->dev)) {
 		pdata -		  (struct ina2xx_platform_data *)client->dev.platform_data;
+		  (struct ina2xx_platform_data *)dev_get_platdata(&client->dev);
 		shunt = pdata->shunt_uohms;
 	} else if (!of_property_read_u32(client->dev.of_node,
 				"shunt-resistor", &val)) {
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 72b21d5..29ffa27 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1962,7 +1962,7 @@ exit:
 static void it87_remove_files(struct device *dev)
 {
 	struct it87_data *data = platform_get_drvdata(pdev);
-	struct it87_sio_data *sio_data = dev->platform_data;
+	struct it87_sio_data *sio_data = dev_get_platdata(dev);
 	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
@@ -2014,7 +2014,7 @@ static int it87_probe(struct platform_device *pdev)
 	struct it87_data *data;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	struct it87_sio_data *sio_data = dev->platform_data;
+	struct it87_sio_data *sio_data = dev_get_platdata(dev);
 	int err = 0, i;
 	int enable_pwm_interface;
 	int fan_beep_need_rw;
@@ -2316,7 +2316,7 @@ static int it87_check_pwm(struct device *dev)
 /* Called when we have found a new IT87. */
 static void it87_init_device(struct platform_device *pdev)
 {
-	struct it87_sio_data *sio_data = pdev->dev.platform_data;
+	struct it87_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	struct it87_data *data = platform_get_drvdata(pdev);
 	int tmp, i;
 	u8 mask;
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 16e45d7..333092c 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -855,8 +855,8 @@ static void lm87_init_client(struct i2c_client *client)
 {
 	struct lm87_data *data = i2c_get_clientdata(client);
 
-	if (client->dev.platform_data) {
-		data->channel = *(u8 *)client->dev.platform_data;
+	if (dev_get_platdata(&client->dev)) {
+		data->channel = *(u8 *)dev_get_platdata(&client->dev);
 		lm87_write_value(client,
 				 LM87_REG_CHANNEL_MODE, data->channel);
 	} else {
diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
index b5ebb91..96dccaf 100644
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -261,7 +261,7 @@ static int max197_probe(struct platform_device *pdev)
 {
 	int ch, ret;
 	struct max197_data *data;
-	struct max197_platform_data *pdata = pdev->dev.platform_data;
+	struct max197_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	enum max197_chips chip = platform_get_device_id(pdev)->driver_data;
 
 	if (pdata = NULL) {
diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 3e7b426..066e587 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -428,7 +428,7 @@ static int max6639_init_client(struct i2c_client *client)
 {
 	struct max6639_data *data = i2c_get_clientdata(client);
 	struct max6639_platform_data *max6639_info -		client->dev.platform_data;
+		dev_get_platdata(&client->dev);
 	int i;
 	int rpm_range = 1; /* default: 4000 RPM */
 	int err;
diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index eedb322..d219c06 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -143,12 +143,13 @@ static int mcp3021_probe(struct i2c_client *client,
 		break;
 	}
 
-	if (client->dev.platform_data) {
-		data->vdd = *(u32 *)client->dev.platform_data;
+	if (dev_get_platdata(&client->dev)) {
+		data->vdd = *(u32 *)dev_get_platdata(&client->dev);
 		if (data->vdd > MCP3021_VDD_MAX || data->vdd < MCP3021_VDD_MIN)
 			return -EINVAL;
-	} else
+	} else {
 		data->vdd = MCP3021_VDD_REF;
+	}
 
 	err = sysfs_create_file(&client->dev.kobj, &dev_attr_in0_input.attr);
 	if (err)
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 25e2c7b..a0ace07 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3285,7 +3285,7 @@ static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
 static int nct6775_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct nct6775_sio_data *sio_data = dev->platform_data;
+	struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
 	struct nct6775_data *data;
 	struct resource *res;
 	int i, s, err = 0;
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 830a842..8c23203 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -424,7 +424,7 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 	else if (pdata = NULL)
-		pdata = pdev->dev.platform_data;
+		pdata = dev_get_platdata(&pdev->dev);
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platform init data supplied.\n");
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index ea60686..6e6ea44 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -983,7 +983,7 @@ static int pc87427_request_regions(struct platform_device *pdev,
 
 static void pc87427_init_device(struct device *dev)
 {
-	struct pc87427_sio_data *sio_data = dev->platform_data;
+	struct pc87427_sio_data *sio_data = dev_get_platdata(dev);
 	struct pc87427_data *data = dev_get_drvdata(dev);
 	int i;
 	u8 reg;
@@ -1075,7 +1075,7 @@ static void pc87427_remove_files(struct device *dev)
 
 static int pc87427_probe(struct platform_device *pdev)
 {
-	struct pc87427_sio_data *sio_data = pdev->dev.platform_data;
+	struct pc87427_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	struct pc87427_data *data;
 	int i, err, res_count;
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 9add6092..9319fcf 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1726,7 +1726,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info)
 {
 	struct device *dev = &client->dev;
-	const struct pmbus_platform_data *pdata = dev->platform_data;
+	const struct pmbus_platform_data *pdata = dev_get_platdata(dev);
 	struct pmbus_data *data;
 	int ret;
 
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index a9f7e80..73bd64e 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -165,7 +165,7 @@ static ssize_t s3c_hwmon_ch_show(struct device *dev,
 {
 	struct sensor_device_attribute *sen_attr = to_sensor_dev_attr(attr);
 	struct s3c_hwmon *hwmon = platform_get_drvdata(to_platform_device(dev));
-	struct s3c_hwmon_pdata *pdata = dev->platform_data;
+	struct s3c_hwmon_pdata *pdata = dev_get_platdata(dev);
 	struct s3c_hwmon_chcfg *cfg;
 	int ret;
 
@@ -194,7 +194,7 @@ static ssize_t s3c_hwmon_label_show(struct device *dev,
 				    char *buf)
 {
 	struct sensor_device_attribute *sen_attr = to_sensor_dev_attr(attr);
-	struct s3c_hwmon_pdata *pdata = dev->platform_data;
+	struct s3c_hwmon_pdata *pdata = dev_get_platdata(dev);
 	struct s3c_hwmon_chcfg *cfg;
 
 	cfg = pdata->in[sen_attr->index];
@@ -274,7 +274,7 @@ static void s3c_hwmon_remove_attr(struct device *dev,
 */
 static int s3c_hwmon_probe(struct platform_device *dev)
 {
-	struct s3c_hwmon_pdata *pdata = dev->dev.platform_data;
+	struct s3c_hwmon_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct s3c_hwmon *hwmon;
 	int ret = 0;
 	int i;
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 2507f90..883d291 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -940,11 +940,11 @@ static int sht15_probe(struct platform_device *pdev)
 	data->dev = &pdev->dev;
 	init_waitqueue_head(&data->wait_queue);
 
-	if (pdev->dev.platform_data = NULL) {
+	if (dev_get_platdata(&pdev->dev) = NULL) {
 		dev_err(&pdev->dev, "no platform data supplied\n");
 		return -EINVAL;
 	}
-	data->pdata = pdev->dev.platform_data;
+	data->pdata = dev_get_platdata(&pdev->dev);
 	data->supply_uv = data->pdata->supply_mv * 1000;
 	if (data->pdata->checksum)
 		data->checksumming = true;
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 6d8255c..05cb814 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -668,7 +668,7 @@ static void smsc47m1_remove_files(struct device *dev)
 static int __init smsc47m1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct smsc47m1_sio_data *sio_data = dev->platform_data;
+	struct smsc47m1_sio_data *sio_data = dev_get_platdata(dev);
 	struct smsc47m1_data *data;
 	struct resource *res;
 	int err;
@@ -940,7 +940,7 @@ exit_device:
 static void __exit sm_smsc47m1_exit(void)
 {
 	platform_driver_unregister(&smsc47m1_driver);
-	smsc47m1_restore(pdev->dev.platform_data);
+	smsc47m1_restore(dev_get_platdata(&pdev->dev));
 	platform_device_unregister(pdev);
 }
 
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 004801e..286ca7b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -673,7 +673,7 @@ static void w83627ehf_write_fan_div(struct w83627ehf_data *data, int nr)
 static void w83627ehf_write_fan_div_common(struct device *dev,
 					   struct w83627ehf_data *data, int nr)
 {
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 
 	if (sio_data->kind = nct6776)
 		; /* no dividers, do nothing */
@@ -724,7 +724,7 @@ static void w83627ehf_update_fan_div(struct w83627ehf_data *data)
 static void w83627ehf_update_fan_div_common(struct device *dev,
 					    struct w83627ehf_data *data)
 {
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 
 	if (sio_data->kind = nct6776)
 		; /* no dividers, do nothing */
@@ -781,7 +781,7 @@ static void w83627ehf_update_pwm(struct w83627ehf_data *data)
 static void w83627ehf_update_pwm_common(struct device *dev,
 					struct w83627ehf_data *data)
 {
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 
 	if (sio_data->kind = nct6775 || sio_data->kind = nct6776)
 		nct6775_update_pwm(data);
@@ -792,7 +792,7 @@ static void w83627ehf_update_pwm_common(struct device *dev,
 static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 
 	int i;
 
@@ -1392,7 +1392,7 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 	int nr = sensor_attr->index;
 	unsigned long val;
 	int err;
@@ -1448,7 +1448,7 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	unsigned long val;
@@ -1527,7 +1527,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	u16 reg;
@@ -2065,7 +2065,7 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 static int w83627ehf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 	struct w83627ehf_data *data;
 	struct resource *res;
 	u8 en_vrm10;
@@ -2618,7 +2618,7 @@ static int w83627ehf_remove(struct platform_device *pdev)
 static int w83627ehf_suspend(struct device *dev)
 {
 	struct w83627ehf_data *data = w83627ehf_update_device(dev);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 
 	mutex_lock(&data->update_lock);
 	data->vbat = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
@@ -2634,7 +2634,7 @@ static int w83627ehf_suspend(struct device *dev)
 static int w83627ehf_resume(struct device *dev)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
-	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	struct w83627ehf_sio_data *sio_data = dev_get_platdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 3b9ef2d..cb9cd32 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1415,7 +1415,7 @@ static const struct attribute_group w83627hf_group_opt = {
 static int w83627hf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct w83627hf_sio_data *sio_data = dev->platform_data;
+	struct w83627hf_sio_data *sio_data = dev_get_platdata(dev);
 	struct w83627hf_data *data;
 	struct resource *res;
 	int err, i;
@@ -1636,7 +1636,7 @@ static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 
 static int w83627thf_read_gpio5(struct platform_device *pdev)
 {
-	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
+	struct w83627hf_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	int res = 0xff, sel;
 
 	superio_enter(sio_data);
@@ -1669,7 +1669,7 @@ exit:
 
 static int w83687thf_read_vid(struct platform_device *pdev)
 {
-	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
+	struct w83627hf_sio_data *sio_data = dev_get_platdata(&pdev->dev);
 	int res = 0xff;
 
 	superio_enter(sio_data);
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
