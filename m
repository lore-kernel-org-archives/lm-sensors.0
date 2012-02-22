From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:43 +0000
Subject: [lm-sensors] [PATCH 1/7] hwmon: (pmbus) Convert pmbus drivers to use devm_kzalloc
Message-Id: <1329929809-6085-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/adm1275.c    |   16 ++---------
 drivers/hwmon/pmbus/lm25066.c    |   26 ++++--------------
 drivers/hwmon/pmbus/ltc2978.c    |   30 +++++---------------
 drivers/hwmon/pmbus/pmbus.c      |   17 ++----------
 drivers/hwmon/pmbus/pmbus_core.c |   54 ++++++++++++-------------------------
 drivers/hwmon/pmbus/ucd9000.c    |   26 +++++-------------
 drivers/hwmon/pmbus/ucd9200.c    |   22 ++++-----------
 drivers/hwmon/pmbus/zl6100.c     |   19 +++----------
 8 files changed, 56 insertions(+), 154 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index fe52c3c..f81cb4a 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -229,7 +229,8 @@ static int adm1275_probe(struct i2c_client *client,
 	if (device_config < 0)
 		return device_config;
 
-	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1275_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -297,23 +298,12 @@ static int adm1275_probe(struct i2c_client *client,
 		break;
 	}
 
-	ret = pmbus_do_probe(client, id, info);
-	if (ret)
-		goto err_mem;
-	return 0;
-
-err_mem:
-	kfree(data);
-	return ret;
+	return pmbus_do_probe(client, id, info);
 }
 
 static int adm1275_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	const struct adm1275_data *data = to_adm1275_data(info);
-
 	pmbus_do_remove(client);
-	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 86ac15a..e70d4ca 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -176,7 +176,6 @@ static int lm25066_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
 	int config;
-	int ret;
 	struct lm25066_data *data;
 	struct pmbus_driver_info *info;
 
@@ -184,15 +183,14 @@ static int lm25066_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct lm25066_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct lm25066_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	config = i2c_smbus_read_byte_data(client, LM25066_DEVICE_SETUP);
-	if (config < 0) {
-		ret = config;
-		goto err_mem;
-	}
+	if (config < 0)
+		return config;
 
 	data->id = id->driver_data;
 	info = &data->info;
@@ -291,27 +289,15 @@ static int lm25066_probe(struct i2c_client *client,
 		}
 		break;
 	default:
-		ret = -ENODEV;
-		goto err_mem;
+		return -ENODEV;
 	}
 
-	ret = pmbus_do_probe(client, id, info);
-	if (ret)
-		goto err_mem;
-	return 0;
-
-err_mem:
-	kfree(data);
-	return ret;
+	return pmbus_do_probe(client, id, info);
 }
 
 static int lm25066_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	const struct lm25066_data *data = to_lm25066_data(info);
-
 	pmbus_do_remove(client);
-	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index c9e4dd2..5e07a36 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -287,7 +287,7 @@ MODULE_DEVICE_TABLE(i2c, ltc2978_id);
 static int ltc2978_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	int chip_id, ret, i;
+	int chip_id, i;
 	struct ltc2978_data *data;
 	struct pmbus_driver_info *info;
 
@@ -295,15 +295,14 @@ static int ltc2978_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_READ_WORD_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct ltc2978_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct ltc2978_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	chip_id = i2c_smbus_read_word_data(client, LTC2978_MFR_SPECIAL_ID);
-	if (chip_id < 0) {
-		ret = chip_id;
-		goto err_mem;
-	}
+	if (chip_id < 0)
+		return chip_id;
 
 	if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2) {
 		data->id = ltc2978;
@@ -311,8 +310,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		data->id = ltc3880;
 	} else {
 		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
-		ret = -ENODEV;
-		goto err_mem;
+		return -ENODEV;
 	}
 	if (data->id != id->driver_data)
 		dev_warn(&client->dev,
@@ -357,27 +355,15 @@ static int ltc2978_probe(struct i2c_client *client,
 		data->vout_min[1] = 0xffff;
 		break;
 	default:
-		ret = -ENODEV;
-		goto err_mem;
+		return -ENODEV;
 	}
 
-	ret = pmbus_do_probe(client, id, info);
-	if (ret)
-		goto err_mem;
-	return 0;
-
-err_mem:
-	kfree(data);
-	return ret;
+	return pmbus_do_probe(client, id, info);
 }
 
 static int ltc2978_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	const struct ltc2978_data *data = to_ltc2978_data(info);
-
 	pmbus_do_remove(client);
-	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index da5fe36..b94bec2 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -166,32 +166,21 @@ static int pmbus_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct pmbus_driver_info *info;
-	int ret;
 
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
+			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	info->pages = id->driver_data;
 	info->identify = pmbus_identify;
 
-	ret = pmbus_do_probe(client, id, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-
-out:
-	kfree(info);
-	return ret;
+	return pmbus_do_probe(client, id, info);
 }
 
 static int pmbus_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info;
-
-	info = pmbus_get_driver_info(client);
 	pmbus_do_remove(client);
-	kfree(info);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index b31f461..c03b762 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1675,7 +1675,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 				     | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		dev_err(&client->dev, "No memory to allocate driver data\n");
 		return -ENOMEM;
@@ -1687,8 +1687,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	/* Bail out if PMBus status register does not exist. */
 	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
 		dev_err(&client->dev, "PMBus status register not found\n");
-		ret = -ENODEV;
-		goto out_data;
+		return -ENODEV;
 	}
 
 	if (pdata)
@@ -1701,50 +1700,49 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		ret = (*info->identify)(client, info);
 		if (ret < 0) {
 			dev_err(&client->dev, "Chip identification failed\n");
-			goto out_data;
+			return ret;
 		}
 	}
 
 	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
 		dev_err(&client->dev, "Bad number of PMBus pages: %d\n",
 			info->pages);
-		ret = -ENODEV;
-		goto out_data;
+		return -ENODEV;
 	}
 
 	ret = pmbus_identify_common(client, data);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to identify chip capabilities\n");
-		goto out_data;
+		return ret;
 	}
 
 	ret = -ENOMEM;
-	data->sensors = kzalloc(sizeof(struct pmbus_sensor) * data->max_sensors,
-				GFP_KERNEL);
+	data->sensors = devm_kzalloc(&client->dev, sizeof(struct pmbus_sensor)
+				     * data->max_sensors, GFP_KERNEL);
 	if (!data->sensors) {
 		dev_err(&client->dev, "No memory to allocate sensor data\n");
-		goto out_data;
+		return -ENOMEM;
 	}
 
-	data->booleans = kzalloc(sizeof(struct pmbus_boolean)
+	data->booleans = devm_kzalloc(&client->dev, sizeof(struct pmbus_boolean)
 				 * data->max_booleans, GFP_KERNEL);
 	if (!data->booleans) {
 		dev_err(&client->dev, "No memory to allocate boolean data\n");
-		goto out_sensors;
+		return -ENOMEM;
 	}
 
-	data->labels = kzalloc(sizeof(struct pmbus_label) * data->max_labels,
-			       GFP_KERNEL);
+	data->labels = devm_kzalloc(&client->dev, sizeof(struct pmbus_label)
+				    * data->max_labels, GFP_KERNEL);
 	if (!data->labels) {
 		dev_err(&client->dev, "No memory to allocate label data\n");
-		goto out_booleans;
+		return -ENOMEM;
 	}
 
-	data->attributes = kzalloc(sizeof(struct attribute *)
-				   * data->max_attributes, GFP_KERNEL);
+	data->attributes = devm_kzalloc(&client->dev, sizeof(struct attribute *)
+					* data->max_attributes, GFP_KERNEL);
 	if (!data->attributes) {
 		dev_err(&client->dev, "No memory to allocate attribute data\n");
-		goto out_labels;
+		return -ENOMEM;
 	}
 
 	pmbus_find_attributes(client, data);
@@ -1755,8 +1753,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 */
 	if (!data->num_attributes) {
 		dev_err(&client->dev, "No attributes found\n");
-		ret = -ENODEV;
-		goto out_attributes;
+		return -ENODEV;
 	}
 
 	/* Register sysfs hooks */
@@ -1764,7 +1761,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	ret = sysfs_create_group(&client->dev.kobj, &data->group);
 	if (ret) {
 		dev_err(&client->dev, "Failed to create sysfs entries\n");
-		goto out_attributes;
+		return ret;
 	}
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1776,16 +1773,6 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 out_hwmon_device_register:
 	sysfs_remove_group(&client->dev.kobj, &data->group);
-out_attributes:
-	kfree(data->attributes);
-out_labels:
-	kfree(data->labels);
-out_booleans:
-	kfree(data->booleans);
-out_sensors:
-	kfree(data->sensors);
-out_data:
-	kfree(data);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
@@ -1795,11 +1782,6 @@ void pmbus_do_remove(struct i2c_client *client)
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->group);
-	kfree(data->attributes);
-	kfree(data->labels);
-	kfree(data->booleans);
-	kfree(data->sensors);
-	kfree(data);
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
 
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 759a563..e057345 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -155,7 +155,8 @@ static int ucd9000_probe(struct i2c_client *client,
 			   "Device mismatch: Configured %s, detected %s\n",
 			   id->name, mid->name);
 
-	data = kzalloc(sizeof(struct ucd9000_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct ucd9000_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	info = &data->info;
@@ -164,13 +165,12 @@ static int ucd9000_probe(struct i2c_client *client,
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Failed to read number of active pages\n");
-		goto out;
+		return ret;
 	}
 	info->pages = ret;
 	if (!info->pages) {
 		dev_err(&client->dev, "No pages configured\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	/* The internal temperature sensor is always active */
@@ -181,8 +181,7 @@ static int ucd9000_probe(struct i2c_client *client,
 					block_buffer);
 	if (ret <= 0) {
 		dev_err(&client->dev, "Failed to read configuration data\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 	for (i = 0; i < ret; i++) {
 		int page = UCD9000_MON_PAGE(block_buffer[i]);
@@ -218,7 +217,7 @@ static int ucd9000_probe(struct i2c_client *client,
 							UCD9000_FAN_CONFIG,
 							data->fan_data[i]);
 			if (ret < 0)
-				goto out;
+				return ret;
 		}
 		i2c_smbus_write_byte_data(client, UCD9000_FAN_CONFIG_INDEX, 0);
 
@@ -227,23 +226,12 @@ static int ucd9000_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
 	}
 
-	ret = pmbus_do_probe(client, mid, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-
-out:
-	kfree(data);
-	return ret;
+	return pmbus_do_probe(client, mid, info);
 }
 
 static int ucd9000_remove(struct i2c_client *client)
 {
-	struct ucd9000_data *data;
-
-	data = to_ucd9000_data(pmbus_get_driver_info(client));
 	pmbus_do_remove(client);
-	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index 629d0c9..c0d41b9 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -81,7 +81,8 @@ static int ucd9200_probe(struct i2c_client *client,
 			   "Device mismatch: Configured %s, detected %s\n",
 			   id->name, mid->name);
 
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
+			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -89,7 +90,7 @@ static int ucd9200_probe(struct i2c_client *client,
 					block_buffer);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read phase information\n");
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -106,8 +107,7 @@ static int ucd9200_probe(struct i2c_client *client,
 	}
 	if (!info->pages) {
 		dev_err(&client->dev, "No rails configured\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 	dev_info(&client->dev, "%d rails configured\n", info->pages);
 
@@ -137,7 +137,7 @@ static int ucd9200_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"Failed to initialize PHASE registers\n");
-			goto out;
+			return ret;
 		}
 	}
 	if (info->pages > 1)
@@ -160,22 +160,12 @@ static int ucd9200_probe(struct i2c_client *client,
 	if (mid->driver_data = ucd9240)
 		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12;
 
-	ret = pmbus_do_probe(client, mid, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-out:
-	kfree(info);
-	return ret;
+	return pmbus_do_probe(client, mid, info);
 }
 
 static int ucd9200_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info;
-
-	info = pmbus_get_driver_info(client);
 	pmbus_do_remove(client);
-	kfree(info);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 0bb7bba..ae925a2 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -192,7 +192,8 @@ static int zl6100_probe(struct i2c_client *client,
 			   "Device mismatch: Configured %s, detected %s\n",
 			   id->name, mid->name);
 
-	data = kzalloc(sizeof(struct zl6100_data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(struct zl6100_data),
+			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -227,7 +228,8 @@ static int zl6100_probe(struct i2c_client *client,
 
 	ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
 	if (ret < 0)
-		goto err_mem;
+		return ret;
+
 	if (ret & ZL6100_MFR_XTEMP_ENABLE)
 		info->func[0] |= PMBUS_HAVE_TEMP2;
 
@@ -239,23 +241,12 @@ static int zl6100_probe(struct i2c_client *client,
 	info->write_word_data = zl6100_write_word_data;
 	info->write_byte = zl6100_write_byte;
 
-	ret = pmbus_do_probe(client, mid, info);
-	if (ret)
-		goto err_mem;
-	return 0;
-
-err_mem:
-	kfree(data);
-	return ret;
+	return pmbus_do_probe(client, mid, info);
 }
 
 static int zl6100_remove(struct i2c_client *client)
 {
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	const struct zl6100_data *data = to_zl6100_data(info);
-
 	pmbus_do_remove(client);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
