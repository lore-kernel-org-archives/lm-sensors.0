From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Tue, 17 Jul 2007 19:27:13 +0000
Subject: [lm-sensors] [PATCH] adm1021 clean ups (rev. 2)
Message-Id: <20070717212713.8269c7e7.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch provides some coding standard cleanups and general code improvements (more debug info, signed values for
temperatures, changed names of ADM1023 regs, removed read/write_value functions).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This is first part of the patch which I already posted and was asked to divide it into two parts.

It fixes all errors pointed by Jean Delvare in the previous version, even the most nonsense ones like 
breaking long lines and alignment of the trailing backslashes in macros which are being gone with the second
part of the patch (remember? it is the first part of dynamic sysfs callbacks patch).

Fun is driving my work and Jean takes fun away from work in this list, like requesting dividing cleanup patches into
 separate patches which removes dots, patches which removes spaces, patches which folds one-shot functions
 into callers, etc. It is very time consuming, counterproductive, discouraging and disappointing.
 I understand that you have one task done in one patch but maybe tasks can be more general
(like 'massive cleanup' or if one kills most of macros with the conversion to dynamic sysfs he can kill rest of macros in one go)?

Simply, I don't care anymore. I just want to send the work I have already done (adm1021) and
 finish the thmc50 driver support (or maybe not if I got sucked by task in another kernel area).
I have deleted a cleanup patch for w83781d (which was planned as the first step to individual alarms conversion)
- I don't want to be irritated by forcing me to do needless work. Someone else will do the patch sooner or later.

Most of people does the work as hobby and they are not perfectionist. Forcing the people to
be perfect is the best way to put them down.

Regards,
Krzysztof

--- linux-2.6.22.old/drivers/hwmon/adm1021.c	2007-04-26 05:08:32.000000000 +0200
+++ linux-2.6.22/drivers/hwmon/adm1021.c	2007-07-17 20:48:39.013918947 +0200
@@ -1,6 +1,6 @@
 /*
     adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+		monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
     Philip Edelbrock <phil@netroedge.com>
 
@@ -32,11 +32,12 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,
-					0x4c, 0x4d, 0x4e, 
+					0x4c, 0x4d, 0x4e,
 					I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
+I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm,
+			mc1066);
 
 /* adm1021 constants specified below */
 
@@ -45,20 +46,22 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 #define ADM1021_REG_TEMP		0x00
 #define ADM1021_REG_REMOTE_TEMP		0x01
 #define ADM1021_REG_STATUS		0x02
-#define ADM1021_REG_MAN_ID		0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
-#define ADM1021_REG_DEV_ID		0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
-#define ADM1021_REG_DIE_CODE		0x0FF	/* MAX1617A */
+/* 0x41 = AD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi */
+#define ADM1021_REG_MAN_ID		0xFE
+/* ADM1021 = 0x0X, ADM1023 = 0x3X */
+#define ADM1021_REG_DEV_ID		0xFF
+#define ADM1021_REG_DIE_CODE		0xFF	/* MAX1617A */
 /* These use different addresses for reading/writing */
 #define ADM1021_REG_CONFIG_R		0x03
 #define ADM1021_REG_CONFIG_W		0x09
 #define ADM1021_REG_CONV_RATE_R		0x04
 #define ADM1021_REG_CONV_RATE_W		0x0A
 /* These are for the ADM1023's additional precision on the remote temp sensor */
-#define ADM1021_REG_REM_TEMP_PREC	0x010
-#define ADM1021_REG_REM_OFFSET		0x011
-#define ADM1021_REG_REM_OFFSET_PREC	0x012
-#define ADM1021_REG_REM_TOS_PREC	0x013
-#define ADM1021_REG_REM_THYST_PREC	0x014
+#define ADM1023_REG_REM_TEMP_PREC	0x10
+#define ADM1023_REG_REM_OFFSET		0x11
+#define ADM1023_REG_REM_OFFSET_PREC	0x12
+#define ADM1023_REG_REM_TOS_PREC	0x13
+#define ADM1023_REG_REM_THYST_PREC	0x14
 /* limits */
 #define ADM1021_REG_TOS_R		0x05
 #define ADM1021_REG_TOS_W		0x0B
@@ -77,14 +80,13 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 /* Conversions  note: 1021 uses normal integer signed-byte format*/
-#define TEMP_FROM_REG(val)	(val > 127 ? (val-256)*1000 : val*1000)
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? (val/1000)+256 : val/1000),0,255))
+#define TEMP_TO_REG(val)	SENSORS_LIMIT((val) / 1000, -128, 127)
 
 /* Initial values */
 
-/* Note: Even though I left the low and high limits named os and hyst, 
-they don't quite work like a thermostat the way the LM75 does.  I.e., 
-a lower temp than THYST actually triggers an alarm instead of 
+/* Note: Even though I left the low and high limits named os and hyst,
+they don't quite work like a thermostat the way the LM75 does.  I.e.,
+a lower temp than THYST actually triggers an alarm instead of
 clearing it.  Weird, ey?   --Phil  */
 
 /* Each client has this additional data */
@@ -97,12 +99,12 @@ struct adm1021_data {
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u8	temp_max;	/* Register values */
-	u8	temp_hyst;
-	u8	temp_input;
-	u8	remote_temp_max;
-	u8	remote_temp_hyst;
-	u8	remote_temp_input;
+	s8	temp_max;	/* Register values */
+	s8	temp_hyst;
+	s8	temp_input;
+	s8	remote_temp_max;
+	s8	remote_temp_hyst;
+	s8	remote_temp_input;
 	u8	alarms;
         /* Special values for ADM1023 only */
 	u8	remote_temp_prec;
@@ -116,9 +118,6 @@ static int adm1021_attach_adapter(struct
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_detach_client(struct i2c_client *client);
-static int adm1021_read_value(struct i2c_client *client, u8 reg);
-static int adm1021_write_value(struct i2c_client *client, u8 reg,
-			       u16 value);
 static struct adm1021_data *adm1021_update_device(struct device *dev);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
@@ -135,11 +134,12 @@ static struct i2c_driver adm1021_driver 
 	.detach_client	= adm1021_detach_client,
 };
 
-#define show(value)	\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
+#define show(value)							\
+static ssize_t show_##value(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
 {									\
 	struct adm1021_data *data = adm1021_update_device(dev);		\
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));	\
+	return sprintf(buf, "%d\n", 1000 * data->value);		\
 }
 show(temp_max);
 show(temp_hyst);
@@ -148,26 +148,29 @@ show(remote_temp_max);
 show(remote_temp_hyst);
 show(remote_temp_input);
 
-#define show2(value)	\
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	struct adm1021_data *data = adm1021_update_device(dev);		\
-	return sprintf(buf, "%d\n", data->value);			\
+static ssize_t show_alarms(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct adm1021_data *data = adm1021_update_device(dev);
+	return sprintf(buf, "%u\n", data->alarms);
 }
-show2(alarms);
 
-#define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
-{								\
-	struct i2c_client *client = to_i2c_client(dev);		\
-	struct adm1021_data *data = i2c_get_clientdata(client);	\
-	int temp = simple_strtoul(buf, NULL, 10);		\
-								\
-	mutex_lock(&data->update_lock);				\
-	data->value = TEMP_TO_REG(temp);			\
-	adm1021_write_value(client, reg, data->value);		\
-	mutex_unlock(&data->update_lock);			\
-	return count;						\
+#define set(value, reg)							\
+static ssize_t set_##value(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   const char *buf, size_t count)		\
+{									\
+	struct i2c_client *client = to_i2c_client(dev);			\
+	struct adm1021_data *data = i2c_get_clientdata(client);		\
+	int temp = simple_strtoul(buf, NULL, 10);			\
+									\
+	mutex_lock(&data->update_lock);					\
+	data->value = TEMP_TO_REG(temp);				\
+	if (!read_only)							\
+		i2c_smbus_write_byte_data(client, reg, data->value);	\
+	mutex_unlock(&data->update_lock);				\
+	return count;							\
 }
 set(temp_max, ADM1021_REG_TOS_W);
 set(temp_hyst, ADM1021_REG_THYST_W);
@@ -208,35 +211,44 @@ static const struct attribute_group adm1
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct adm1021_data *data;
 	int err = 0;
 	const char *type_name = "";
+	int conv_rate, status, config;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		pr_debug("adm1021: detect failed, "
+			 "smbus byte data not supported!\n");
 		goto error0;
+	}
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access adm1021_{read,write}_value. */
+	   But it allows us to access adm1021 register values. */
 
 	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
+		pr_debug("adm1021: detect failed, kzalloc failed!\n");
 		err = -ENOMEM;
 		goto error0;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &adm1021_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &adm1021_driver;
+	status = i2c_smbus_read_byte_data(client, ADM1021_REG_STATUS);
+	conv_rate = i2c_smbus_read_byte_data(client,
+					     ADM1021_REG_CONV_RATE_R);
+	config = i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R);
 
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
-		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0x03) != 0x00
-		 || (adm1021_read_value(new_client, ADM1021_REG_CONFIG_R) & 0x3F) != 0x00
-		 || (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) & 0xF8) != 0x00) {
+		if ((status & 0x03) != 0x00 || (config & 0x3F) != 0x00
+		    || (conv_rate & 0xF8) != 0x00) {
+			pr_debug("adm1021: detect failed, "
+				 "chip not detected!\n");
 			err = -ENODEV;
 			goto error1;
 		}
@@ -244,9 +256,10 @@ static int adm1021_detect(struct i2c_ada
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
-		i = adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
+		i = i2c_smbus_read_byte_data(client, ADM1021_REG_MAN_ID);
 		if (i = 0x41)
-			if ((adm1021_read_value(new_client, ADM1021_REG_DEV_ID) & 0x0F0) = 0x030)
+			if ((i2c_smbus_read_byte_data(client,
+					ADM1021_REG_DEV_ID) & 0xF0) = 0x30)
 				kind = adm1023;
 			else
 				kind = adm1021;
@@ -255,15 +268,16 @@ static int adm1021_detect(struct i2c_ada
 		else if (i = 0x23)
 			kind = gl523sm;
 		else if ((i = 0x4d) &&
-			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) = 0x01))
+			 (i2c_smbus_read_byte_data(client,
+						   ADM1021_REG_DEV_ID) = 0x01))
 			kind = max1617a;
 		else if (i = 0x54)
 			kind = mc1066;
 		/* LM84 Mfr ID in a different place, and it has more unused bits */
-		else if (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) = 0x00
-		      && (kind = 0 /* skip extra detection */
-		       || ((adm1021_read_value(new_client, ADM1021_REG_CONFIG_R) & 0x7F) = 0x00
-			&& (adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0xAB) = 0x00)))
+		else if (conv_rate = 0x00
+			 && (kind = 0 /* skip extra detection */
+			     || ((config & 0x7F) = 0x00
+				 && (status & 0xAB) = 0x00)))
 			kind = lm84;
 		else
 			kind = max1617;
@@ -286,26 +300,27 @@ static int adm1021_detect(struct i2c_ada
 	} else if (kind = mc1066) {
 		type_name = "mc1066";
 	}
+	pr_debug("adm1021: Detected chip %s at adapter %d, address 0x%02x.\n",
+		 type_name, i2c_adapter_id(adapter), address);
 
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
+	/* Fill in the remaining client fields */
+	strlcpy(client->name, type_name, I2C_NAME_SIZE);
 	data->type = kind;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto error1;
 
 	/* Initialize the ADM1021 chip */
 	if (kind != lm84)
-		adm1021_init_client(new_client);
+		adm1021_init_client(client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1021_group)))
+	if ((err = sysfs_create_group(&client->dev.kobj, &adm1021_group)))
 		goto error2;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto error3;
@@ -314,9 +329,9 @@ static int adm1021_detect(struct i2c_ada
 	return 0;
 
 error3:
-	sysfs_remove_group(&new_client->dev.kobj, &adm1021_group);
+	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
 error2:
-	i2c_detach_client(new_client);
+	i2c_detach_client(client);
 error1:
 	kfree(data);
 error0:
@@ -325,11 +340,13 @@ error0:
 
 static void adm1021_init_client(struct i2c_client *client)
 {
-	/* Enable ADC and disable suspend mode */
-	adm1021_write_value(client, ADM1021_REG_CONFIG_W,
-		adm1021_read_value(client, ADM1021_REG_CONFIG_R) & 0xBF);
-	/* Set Conversion rate to 1/sec (this can be tinkered with) */
-	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
+	if (!read_only) {
+		/* Enable ADC and disable suspend mode */
+		i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
+			i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R) & 0xBF);
+		/* Set Conversion rate to 1/sec (this can be tinkered with) */
+		i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
+	}
 }
 
 static int adm1021_detach_client(struct i2c_client *client)
@@ -347,19 +364,6 @@ static int adm1021_detach_client(struct 
 	return 0;
 }
 
-/* All registers are byte-sized */
-static int adm1021_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int adm1021_write_value(struct i2c_client *client, u8 reg, u16 value)
-{
-	if (!read_only)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	return 0;
-}
-
 static struct adm1021_data *adm1021_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -371,19 +375,36 @@ static struct adm1021_data *adm1021_upda
 	    || !data->valid) {
 		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
-		data->temp_input = adm1021_read_value(client, ADM1021_REG_TEMP);
-		data->temp_max = adm1021_read_value(client, ADM1021_REG_TOS_R);
-		data->temp_hyst = adm1021_read_value(client, ADM1021_REG_THYST_R);
-		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
-		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
-		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
-		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
+		data->temp_input = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TEMP);
+		data->temp_max = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TOS_R);
+		data->temp_hyst = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_THYST_R);
+		data->remote_temp_input = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_REMOTE_TEMP);
+		data->remote_temp_max = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_REMOTE_TOS_R);
+		data->remote_temp_hyst = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_REMOTE_THYST_R);
+		data->alarms = i2c_smbus_read_byte_data(client,
+						ADM1021_REG_STATUS) & 0x7c;
 		if (data->type = adm1023) {
-			data->remote_temp_prec = adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
-			data->remote_temp_os_prec = adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
-			data->remote_temp_hyst_prec = adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
-			data->remote_temp_offset = adm1021_read_value(client, ADM1021_REG_REM_OFFSET);
-			data->remote_temp_offset_prec = adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
+			data->remote_temp_prec +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_TEMP_PREC);
+			data->remote_temp_os_prec +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_TOS_PREC);
+			data->remote_temp_hyst_prec +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_THYST_PREC);
+			data->remote_temp_offset +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET);
+			data->remote_temp_offset_prec +				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET_PREC);
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
