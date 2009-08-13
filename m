From: Davide Rizzo <elpa.rizzo@gmail.com>
Date: Thu, 13 Aug 2009 09:46:55 +0000
Subject: [lm-sensors] [PATCH] LM95241 improvements
Message-Id: <8447d6730908130246le5083cbka912896ce6f8568@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8447d6730908130238o4a837c35rbfd8e3e4cbc2ab02@mail.gmail.com>
In-Reply-To: <8447d6730908130238o4a837c35rbfd8e3e4cbc2ab02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, I attached instead of inlining. I'm sorry, now it should be more readable:

Converted macros into functions, to improve readability and size
Corrected also my email address

Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com>
---
diff -urNp linux-2.6.30.4/drivers/hwmon/lm95241.c
linux-2.6.30.4.elpa/drivers/hwmon/lm95241.c
--- linux-2.6.30.4/drivers/hwmon/lm95241.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.30.4.elpa/drivers/hwmon/lm95241.c	2009-08-13
10:54:43.000000000 +0200
@@ -1,13 +1,11 @@
 /*
- * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
- *             monitoring
- * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com>
+ * drivers/hwmon/lm95241.c
  *
- * Based on the max1619 driver. The LM95241 is a sensor chip made by National
- *   Semiconductors.
- * It reports up to three temperatures (its own plus up to
- * two external ones). Complete datasheet can be
- * obtained from National's website at:
+ * Copyright (C) 2009 Davide Rizzo <elpa.rizzo@gmail.com>
+ *
+ * The LM95241 is a sensor chip made by National Semiconductors.
+ * It reports up to three temperatures (its own plus up to two external ones).
+ * Complete datasheet can be obtained from National's website at:
  *   http://www.national.com/ds.cgi/LM/LM95241.pdf
  *
  * This program is free software; you can redistribute it and/or modify
@@ -36,6 +34,8 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>

+#define DEVNAME "lm95241"
+
 static const unsigned short normal_i2c[] = {
 	0x19, 0x2a, 0x2b, I2C_CLIENT_END};

@@ -103,22 +103,81 @@ struct lm95241_data {
 	u8 config, model, trutherm;
 };

+static ssize_t show_input(struct device *dev, struct device_attribute *attr,
+	char *buf);
+static ssize_t show_rate(struct device *dev, struct device_attribute *attr,
+	char *buf);
+static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count);
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+	char *buf);
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,
+	char *buf);
+static ssize_t show_max(struct device *dev, struct device_attribute *attr,
+	char *buf);
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count);
+static ssize_t set_min(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count);
+static ssize_t set_max(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count);
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
+static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type);
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min);
+static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max);
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max);
+static DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate, set_rate);
+
+static struct attribute *lm95241_attributes[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp3_input.attr,
+	&dev_attr_temp2_type.attr,
+	&dev_attr_temp3_type.attr,
+	&dev_attr_temp2_min.attr,
+	&dev_attr_temp3_min.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_rate.attr,
+	NULL
+};
+
+static const struct attribute_group lm95241_group = {
+	.attrs = lm95241_attributes,
+};
+
+/* Conversions */
+static int TempFromReg(u8 val_h, u8 val_l)
+{
+	if (val_h & 0x80)
+		return val_h - 0x100;
+	return val_h * 1000 + val_l * 1000 / 256;
+}
+
 /* Sysfs stuff */
-#define show_temp(value) \
-static ssize_t show_##value(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-	struct lm95241_data *data = lm95241_update_device(dev); \
-	snprintf(buf, PAGE_SIZE - 1, "%d\n", \
-		TEMP_FROM_REG(data->value##_h, data->value##_l)); \
-	return strlen(buf); \
-}
-show_temp(local);
-show_temp(remote1);
-show_temp(remote2);
+static ssize_t show_input(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct lm95241_data *data = lm95241_update_device(dev);
+	int value;
+
+	if (attr = &dev_attr_temp1_input)
+		value = TempFromReg(data->local_h, data->local_l);
+	else if (attr = &dev_attr_temp2_input)
+		value = TempFromReg(data->remote1_h, data->remote1_l);
+	else
+		value = TempFromReg(data->remote2_h, data->remote2_l);
+	snprintf(buf, PAGE_SIZE - 1, "%d\n", value);
+	return strlen(buf);
+}

 static ssize_t show_rate(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+	char *buf)
 {
 	struct lm95241_data *data = lm95241_update_device(dev);

@@ -127,7 +186,7 @@ static ssize_t show_rate(struct device *
 }

 static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+	const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm95241_data *data = i2c_get_clientdata(client);
@@ -138,176 +197,151 @@ static ssize_t set_rate(struct device *d
 	return count;
 }

-#define show_type(flag) \
-static ssize_t show_type##flag(struct device *dev, \
-				   struct device_attribute *attr, char *buf) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	snprintf(buf, PAGE_SIZE - 1, \
-		data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
-	return strlen(buf); \
-}
-show_type(1);
-show_type(2);
-
-#define show_min(flag) \
-static ssize_t show_min##flag(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	snprintf(buf, PAGE_SIZE - 1, \
-		data->config & R##flag##DF_MASK ?	\
-		"-127000\n" : "0\n"); \
-	return strlen(buf); \
-}
-show_min(1);
-show_min(2);
-
-#define show_max(flag) \
-static ssize_t show_max##flag(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	snprintf(buf, PAGE_SIZE - 1, \
-		data->config & R##flag##DF_MASK ? \
-		"127000\n" : "255000\n"); \
-	return strlen(buf); \
-}
-show_max(1);
-show_max(2);
-
-#define set_type(flag) \
-static ssize_t set_type##flag(struct device *dev, \
-				  struct device_attribute *attr, \
-				  const char *buf, size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	long val; \
-	strict_strtol(buf, 10, &val); \
-\
-	if ((val = 1) || (val = 2)) { \
-\
-		mutex_lock(&data->update_lock); \
-\
-		data->trutherm &= ~(TT_MASK << TT##flag##_SHIFT); \
-		if (val = 1) { \
-			data->model |= R##flag##MS_MASK; \
-			data->trutherm |= (TT_ON << TT##flag##_SHIFT); \
-		} \
-		else { \
-			data->model &= ~R##flag##MS_MASK; \
-			data->trutherm |= (TT_OFF << TT##flag##_SHIFT); \
-		} \
-\
-		data->valid = 0; \
-\
-		i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL, \
-					  data->model); \
-		i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM, \
-					  data->trutherm); \
-\
-		mutex_unlock(&data->update_lock); \
-\
-	} \
-	return count; \
-}
-set_type(1);
-set_type(2);
-
-#define set_min(flag) \
-static ssize_t set_min##flag(struct device *dev, \
-	struct device_attribute *devattr, const char *buf, size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	long val; \
-	strict_strtol(buf, 10, &val); \
-\
-	mutex_lock(&data->update_lock); \
-\
-	if (val < 0) \
-		data->config |= R##flag##DF_MASK; \
-	else \
-		data->config &= ~R##flag##DF_MASK; \
-\
-	data->valid = 0; \
-\
-	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
-		data->config); \
-\
-	mutex_unlock(&data->update_lock); \
-\
-	return count; \
-}
-set_min(1);
-set_min(2);
-
-#define set_max(flag) \
-static ssize_t set_max##flag(struct device *dev, \
-	struct device_attribute *devattr, const char *buf, size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-	long val; \
-	strict_strtol(buf, 10, &val); \
-\
-	mutex_lock(&data->update_lock); \
-\
-	if (val <= 127000) \
-		data->config |= R##flag##DF_MASK; \
-	else \
-		data->config &= ~R##flag##DF_MASK; \
-\
-	data->valid = 0; \
-\
-	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
-		data->config); \
-\
-	mutex_unlock(&data->update_lock); \
-\
-	return count; \
-}
-set_max(1);
-set_max(2);
-
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_local, NULL);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote1, NULL);
-static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote2, NULL);
-static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type1, set_type1);
-static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type2, set_type2);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min1, set_min1);
-static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min2, set_min2);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max1, set_max1);
-static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max2, set_max2);
-static DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate, set_rate);
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);

-static struct attribute *lm95241_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp2_type.attr,
-	&dev_attr_temp3_type.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp3_min.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp3_max.attr,
-	&dev_attr_rate.attr,
-	NULL
-};
+	if (attr = &dev_attr_temp2_type)
+		snprintf(buf, PAGE_SIZE - 1,
+			data->model & R1MS_MASK ? "1\n" : "2\n");
+	else
+		snprintf(buf, PAGE_SIZE - 1,
+			data->model & R2MS_MASK ? "1\n" : "2\n");
+	return strlen(buf);
+}

-static const struct attribute_group lm95241_group = {
-	.attrs = lm95241_attributes,
-};
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);
+
+	if (attr = &dev_attr_temp2_min)
+		snprintf(buf, PAGE_SIZE - 1,
+			data->config & R1DF_MASK ? "-127000\n" : "0\n");
+	else
+		snprintf(buf, PAGE_SIZE - 1,
+			data->config & R2DF_MASK ? "-127000\n" : "0\n");
+	return strlen(buf);
+}
+
+static ssize_t show_max(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);
+
+	if (attr = &dev_attr_temp2_max)
+		snprintf(buf, PAGE_SIZE - 1,
+			data->config & R1DF_MASK ? "127000\n" : "255000\n");
+	else
+		snprintf(buf, PAGE_SIZE - 1,
+			data->config & R2DF_MASK ? "127000\n" : "255000\n");
+	return strlen(buf);
+}
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);
+	long val;
+
+	strict_strtol(buf, 10, &val);
+	if ((val = 1) || (val = 2)) {
+		int shift;
+		u8 mask;
+		if (attr = &dev_attr_temp2_type) {
+			shift = TT1_SHIFT;
+			mask = R1MS_MASK;
+		} else {
+			shift = TT2_SHIFT;
+			mask = R2MS_MASK;
+		}
+
+		mutex_lock(&data->update_lock);
+
+		data->trutherm &= ~(TT_MASK << shift);
+		if (val = 1) {
+			data->model |= mask;
+			data->trutherm |= (TT_ON << shift);
+		} else {
+			data->model &= ~mask;
+			data->trutherm |= (TT_OFF << shift);
+		}
+
+		data->valid = 0;
+
+		i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
+					  data->model);
+		i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
+					  data->trutherm);
+
+		mutex_unlock(&data->update_lock);
+
+	}
+	return count;
+}
+
+static ssize_t set_min(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);
+	long val;
+	u8 mask;
+
+	strict_strtol(buf, 10, &val);
+	if (attr = &dev_attr_temp2_min)
+		mask = R1DF_MASK;
+	else
+		mask = R2DF_MASK;
+
+	mutex_lock(&data->update_lock);
+
+	if (val < 0)
+		data->config |= mask;
+	else
+		data->config &= mask;
+	data->valid = 0;
+
+	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_max(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm95241_data *data = i2c_get_clientdata(client);
+	long val;
+	u8 mask;
+
+	strict_strtol(buf, 10, &val);
+	if (attr = &dev_attr_temp2_max)
+		mask = R1DF_MASK;
+	else
+		mask = R2DF_MASK;
+
+	mutex_lock(&data->update_lock);
+
+	if (val <= 127000)
+		data->config |= R1DF_MASK;
+	else
+		data->config &= ~R2DF_MASK;
+	data->valid = 0;
+
+	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}

 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm95241_detect(struct i2c_client *new_client, int kind,
@@ -359,7 +393,7 @@ static int lm95241_detect(struct i2c_cli

 	/* Fill the i2c board info */
 	if (kind = lm95241)
-		name = "lm95241";
+		name = DEVNAME;
 	strlcpy(info->type, name, I2C_NAME_SIZE);
 	return 0;
 }
@@ -474,15 +508,16 @@ static struct lm95241_data *lm95241_upda

 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95241_id[] = {
-	{ "lm95241", lm95241 },
+	{ DEVNAME, lm95241 },
 	{ }
 };
+
 MODULE_DEVICE_TABLE(i2c, lm95241_id);

 static struct i2c_driver lm95241_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
-		.name   = "lm95241",
+		.name   = DEVNAME,
 	},
 	.probe		= lm95241_probe,
 	.remove		= lm95241_remove,
@@ -501,9 +536,10 @@ static void __exit sensors_lm95241_exit(
 	i2c_del_driver(&lm95241_driver);
 }

-MODULE_AUTHOR("Davide Rizzo <elpa-rizzo@gmail.com>");
+MODULE_AUTHOR("Davide Rizzo <elpa.rizzo@gmail.com>");
 MODULE_DESCRIPTION("LM95241 sensor driver");
 MODULE_LICENSE("GPL");

 module_init(sensors_lm95241_init);
 module_exit(sensors_lm95241_exit);
+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
