From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sun, 08 Jul 2007 09:00:33 +0000
Subject: [lm-sensors] [PATCH] adm1021 dynamic sysfs callbacks added
Message-Id: <4690a7b195e80@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part4690a7b198588"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--part4690a7b198588
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds dynamic sysfs callback and provides some coding=20
standard cleanups.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/hwmon/adm1021.c	2007-04-26 05:
08:32.000000000 +0200
+++ linux-2.6.21/drivers/hwmon/adm1021.c	2007-07-08 09:48:47.
000000000 +0200
@@ -1,6 +1,6 @@
 /*
     adm1021.c - Part of lm_sensors, Linux kernel modules for=20
hardware
-             monitoring
+		monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>=20
and
     Philip Edelbrock <phil@netroedge.com>
=20
@@ -25,6 +25,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
=20
@@ -32,11 +33,12 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,
-					0x4c, 0x4d, 0x4e,=20
+					0x4c, 0x4d, 0x4e,
 					I2C_CLIENT_END };
=20
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10,=20
lm84, gl523sm, mc1066);
+I2C_CLIENT_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10,=20
lm84, gl523sm,
+			mc1066);
=20
 /* adm1021 constants specified below */
=20
@@ -45,8 +47,10 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 #define ADM1021_REG_TEMP		0x00
 #define ADM1021_REG_REMOTE_TEMP		0x01
 #define ADM1021_REG_STATUS		0x02
-#define ADM1021_REG_MAN_ID		0x0FE	/* 0x41 =3D AMD, 0x49=20
=3D TI, 0x4D =3D Maxim, 0x23 =3D Genesys , 0x54 =3D Onsemi*/
-#define ADM1021_REG_DEV_ID		0x0FF	/* ADM1021 =3D 0x0X,=20
ADM1023 =3D 0x3X */
+/* 0x41 =3D AD, 0x49 =3D TI, 0x4D =3D Maxim, 0x23 =3D Genesys , 0x54 =3D=20
Onsemi */
+#define ADM1021_REG_MAN_ID		0x0FE
+/* ADM1021 =3D 0x0X, ADM1023 =3D 0x3X */
+#define ADM1021_REG_DEV_ID		0x0FF
 #define ADM1021_REG_DIE_CODE		0x0FF	/* MAX1617A */
 /* These use different addresses for reading/writing */
 #define ADM1021_REG_CONFIG_R		0x03
@@ -54,11 +58,11 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 #define ADM1021_REG_CONV_RATE_R		0x04
 #define ADM1021_REG_CONV_RATE_W		0x0A
 /* These are for the ADM1023's additional precision on the=20
remote temp sensor */
-#define ADM1021_REG_REM_TEMP_PREC	0x010
-#define ADM1021_REG_REM_OFFSET		0x011
-#define ADM1021_REG_REM_OFFSET_PREC	0x012
-#define ADM1021_REG_REM_TOS_PREC	0x013
-#define ADM1021_REG_REM_THYST_PREC	0x014
+#define ADM1023_REG_REM_TEMP_PREC	0x010
+#define ADM1023_REG_REM_OFFSET		0x011
+#define ADM1023_REG_REM_OFFSET_PREC	0x012
+#define ADM1023_REG_REM_TOS_PREC	0x013
+#define ADM1023_REG_REM_THYST_PREC	0x014
 /* limits */
 #define ADM1021_REG_TOS_R		0x05
 #define ADM1021_REG_TOS_W		0x0B
@@ -71,20 +75,11 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
 /* write-only */
 #define ADM1021_REG_ONESHOT		0x0F
=20
-
-/* Conversions. Rounding and limit checking is only done on the=20
TO_REG
-   variants. Note that you should be a bit careful with which=20
arguments
-   these macros are called: arguments may be evaluated more than=20
once.
-   Fixing this is just not worth it. */
-/* Conversions  note: 1021 uses normal integer signed-byte=20
format*/
-#define TEMP_FROM_REG(val)	(val > 127 ? (val-256)*1000 :=20
val*1000)
-#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ?=20
(val/1000)+256 : val/1000),0,255))
-
 /* Initial values */
=20
-/* Note: Even though I left the low and high limits named os and=20
hyst,=20
-they don't quite work like a thermostat the way the LM75 does. =20
I.e.,=20
-a lower temp than THYST actually triggers an alarm instead of=20
+/* Note: Even though I left the low and high limits named os and=20
hyst,
+they don't quite work like a thermostat the way the LM75 does. =20
I.e.,
+a lower temp than THYST actually triggers an alarm instead of
 clearing it.  Weird, ey?   --Phil  */
=20
 /* Each client has this additional data */
@@ -97,28 +92,22 @@ struct adm1021_data {
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
-	u8	temp_max;	/* Register values */
-	u8	temp_hyst;
-	u8	temp_input;
-	u8	remote_temp_max;
-	u8	remote_temp_hyst;
-	u8	remote_temp_input;
-	u8	alarms;
-        /* Special values for ADM1023 only */
-	u8	remote_temp_prec;
-	u8	remote_temp_os_prec;
-	u8	remote_temp_hyst_prec;
-	u8	remote_temp_offset;
-	u8	remote_temp_offset_prec;
+	s8 temp_max[2];		/* Register values */
+	s8 temp_min[2];
+	s8 temp[2];
+	u8 alarms;
+	/* Special values for ADM1023 only */
+	u8 remote_temp_prec;
+	u8 remote_temp_os_prec;
+	u8 remote_temp_hyst_prec;
+	u8 remote_temp_offset;
+	u8 remote_temp_offset_prec;
 };
=20
 static int adm1021_attach_adapter(struct i2c_adapter *adapter);
 static int adm1021_detect(struct i2c_adapter *adapter, int=20
address, int kind);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_detach_client(struct i2c_client *client);
-static int adm1021_read_value(struct i2c_client *client, u8 reg)
;
-static int adm1021_write_value(struct i2c_client *client, u8=20
reg,
-			       u16 value);
 static struct adm1021_data *adm1021_update_device(struct device=20
*dev);
=20
 /* (amalysh) read only mode, otherwise any limit's writing=20
confuse BIOS */
@@ -135,53 +124,89 @@ static struct i2c_driver adm1021_driver=20
 	.detach_client	=3D adm1021_detach_client,
 };
=20
-#define show(value)	\
-static ssize_t show_##value(struct device *dev, struct=20
device_attribute *attr, char *buf)		\
-{									\
-	struct adm1021_data *data =3D adm1021_update_device(dev);
		\
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value));
	\
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	int index =3D to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data =3D adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp[index]);
+}
+
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index =3D to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data =3D adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp_max[index]);
+}
+
+static ssize_t show_temp_min(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index =3D to_sensor_dev_attr(devattr)->index;
+	struct adm1021_data *data =3D adm1021_update_device(dev);
+
+	return sprintf(buf, "%d\n", 1000 * data->temp_min[index]);
 }
-show(temp_max);
-show(temp_hyst);
-show(temp_input);
-show(remote_temp_max);
-show(remote_temp_hyst);
-show(remote_temp_input);
=20
 #define show2(value)	\
-static ssize_t show_##value(struct device *dev, struct=20
device_attribute *attr, char *buf)		\
+static ssize_t show_##value(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    char *buf)					\
 {									\
 	struct adm1021_data *data =3D adm1021_update_device(dev);
		\
 	return sprintf(buf, "%d\n", data->value);			\
 }
 show2(alarms);
=20
-#define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, struct=20
device_attribute *attr, const char *buf, size_t count)	\
-{								\
-	struct i2c_client *client =3D to_i2c_client(dev);		\
-	struct adm1021_data *data =3D i2c_get_clientdata(client);
	\
-	int temp =3D simple_strtoul(buf, NULL, 10);		\
-								\
-	mutex_lock(&data->update_lock);				\
-	data->value =3D TEMP_TO_REG(temp);			\
-	adm1021_write_value(client, reg, data->value);		\
-	mutex_unlock(&data->update_lock);			\
-	return count;						\
-}
-set(temp_max, ADM1021_REG_TOS_W);
-set(temp_hyst, ADM1021_REG_THYST_W);
-set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
-set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
-
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,=20
set_temp_max);
-static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst,=20
set_temp_hyst);
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO,=20
show_remote_temp_max, set_remote_temp_max);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO,=20
show_remote_temp_hyst, set_remote_temp_hyst);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input,=20
NULL);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static ssize_t set_temp_max(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index =3D to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adm1021_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10) / 1000;
=20
+	mutex_lock(&data->update_lock);
+	data->temp_max[index] =3D SENSORS_LIMIT(temp, -128, 127);
+	i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W + 2 *=20
index, temp);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_temp_min(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index =3D to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adm1021_data *data =3D i2c_get_clientdata(client);
+	int temp =3D simple_strtol(buf, NULL, 10) / 1000;
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[index] =3D SENSORS_LIMIT(temp, -128, 127);
+	i2c_smbus_write_byte_data(client,
+				  ADM1021_REG_THYST_W + 2 * index, temp);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,=20
0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,=20
show_temp_max,
+			  set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,=20
show_temp_min,
+			  set_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL,=20
1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO,=20
show_temp_max,
+			  set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO,=20
show_temp_min,
+			  set_temp_min, 1);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
=20
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -191,12 +216,12 @@ static int adm1021_attach_adapter(struct
 }
=20
 static struct attribute *adm1021_attributes[] =3D {
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp2_input.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	NULL
 };
@@ -212,15 +237,20 @@ static int adm1021_detect(struct i2c_ada
 	struct adm1021_data *data;
 	int err =3D 0;
 	const char *type_name =3D "";
+	int conv_rate, status, config;
=20
-	if (!i2c_check_functionality(adapter,=20
I2C_FUNC_SMBUS_BYTE_DATA))
+	if (!i2c_check_functionality(adapter,=20
I2C_FUNC_SMBUS_BYTE_DATA)) {
+		pr_debug("adm1021: detect failed, "
+			 "smbus byte data not supported!\n");
 		goto error0;
+	}
=20
 	/* OK. For now, we presume we have a valid client. We now=20
create the
 	   client structure, even though we cannot fill it completely=20
yet.
 	   But it allows us to access adm1021_{read,write}_value. */
=20
 	if (!(data =3D kzalloc(sizeof(struct adm1021_data),=20
GFP_KERNEL))) {
+		pr_debug("adm1021: detect failed, kzalloc failed!\n");
 		err =3D -ENOMEM;
 		goto error0;
 	}
@@ -230,13 +260,17 @@ static int adm1021_detect(struct i2c_ada
 	new_client->addr =3D address;
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &adm1021_driver;
-	new_client->flags =3D 0;
+	status =3D i2c_smbus_read_byte_data(new_client,=20
ADM1021_REG_STATUS);
+	conv_rate =3D i2c_smbus_read_byte_data(new_client,
+					     ADM1021_REG_CONV_RATE_R);
+	config =3D i2c_smbus_read_byte_data(new_client,=20
ADM1021_REG_CONFIG_R);
=20
 	/* Now, we do the remaining detection. */
 	if (kind < 0) {
-		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS)=20
& 0x03) !=3D 0x00
-		 || (adm1021_read_value(new_client, ADM1021_REG_CONFIG_R)=20
& 0x3F) !=3D 0x00
-		 || (adm1021_read_value(new_client,=20
ADM1021_REG_CONV_RATE_R) & 0xF8) !=3D 0x00) {
+		if ((status & 0x03) !=3D 0x00 || (config & 0x3F) !=3D 0x00
+		    || (conv_rate & 0xF8) !=3D 0x00) {
+			pr_debug("adm1021: detect failed, "
+				 "chip not detected!\n");
 			err =3D -ENODEV;
 			goto error1;
 		}
@@ -244,9 +278,10 @@ static int adm1021_detect(struct i2c_ada
=20
 	/* Determine the chip type. */
 	if (kind <=3D 0) {
-		i =3D adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
+		i =3D i2c_smbus_read_byte_data(new_client,=20
ADM1021_REG_MAN_ID);
 		if (i =3D=3D 0x41)
-			if ((adm1021_read_value(new_client,=20
ADM1021_REG_DEV_ID) & 0x0F0) =3D=3D 0x030)
+			if ((i2c_smbus_read_byte_data(new_client,
+					ADM1021_REG_DEV_ID) & 0x0F0) =3D=3D 0x030)
 				kind =3D adm1023;
 			else
 				kind =3D adm1021;
@@ -255,15 +290,16 @@ static int adm1021_detect(struct i2c_ada
 		else if (i =3D=3D 0x23)
 			kind =3D gl523sm;
 		else if ((i =3D=3D 0x4d) &&
-			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) =3D=3D=20
0x01))
+			 (i2c_smbus_read_byte_data(new_client,
+						   ADM1021_REG_DEV_ID) =3D=3D 0x01))
 			kind =3D max1617a;
 		else if (i =3D=3D 0x54)
 			kind =3D mc1066;
 		/* LM84 Mfr ID in a different place, and it has more=20
unused bits */
-		else if (adm1021_read_value(new_client,=20
ADM1021_REG_CONV_RATE_R) =3D=3D 0x00
-		      && (kind =3D=3D 0 /* skip extra detection */
-		       || ((adm1021_read_value(new_client,=20
ADM1021_REG_CONFIG_R) & 0x7F) =3D=3D 0x00
-			&& (adm1021_read_value(new_client,=20
ADM1021_REG_STATUS) & 0xAB) =3D=3D 0x00)))
+		else if (conv_rate =3D=3D 0x00
+			 && (kind =3D=3D 0 /* skip extra detection */
+			     || ((config & 0x7F) =3D=3D 0x00
+				 && (status & 0xAB) =3D=3D 0x00)))
 			kind =3D lm84;
 		else
 			kind =3D max1617;
@@ -286,11 +322,12 @@ static int adm1021_detect(struct i2c_ada
 	} else if (kind =3D=3D mc1066) {
 		type_name =3D "mc1066";
 	}
+	pr_debug("adm1021: Detected chip %s at adapter %d, address=20
0x%02x.\n",
+		 type_name, i2c_adapter_id(adapter), address);
=20
-	/* Fill in the remaining client fields and put it into the=20
global list */
+	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 	data->type =3D kind;
-	data->valid =3D 0;
 	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
@@ -326,10 +363,10 @@ error0:
 static void adm1021_init_client(struct i2c_client *client)
 {
 	/* Enable ADC and disable suspend mode */
-	adm1021_write_value(client, ADM1021_REG_CONFIG_W,
-		adm1021_read_value(client, ADM1021_REG_CONFIG_R) & 0xBF)
;
+	i2c_smbus_write_byte_data(client, ADM1021_REG_CONFIG_W,
+		i2c_smbus_read_byte_data(client, ADM1021_REG_CONFIG_R) &=20
0xBF);
 	/* Set Conversion rate to 1/sec (this can be tinkered with)=20
*/
-	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
+	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W,=20
0x04);
 }
=20
 static int adm1021_detach_client(struct i2c_client *client)
@@ -347,19 +384,6 @@ static int adm1021_detach_client(struct=20
 	return 0;
 }
=20
-/* All registers are byte-sized */
-static int adm1021_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int adm1021_write_value(struct i2c_client *client, u8=20
reg, u16 value)
-{
-	if (!read_only)
-		return i2c_smbus_write_byte_data(client, reg, value);
-	return 0;
-}
-
 static struct adm1021_data *adm1021_update_device(struct device=20
*dev)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
@@ -369,21 +393,39 @@ static struct adm1021_data *adm1021_upda
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
+		int i;
+
 		dev_dbg(&client->dev, "Starting adm1021 update\n");
=20
-		data->temp_input =3D adm1021_read_value(client,=20
ADM1021_REG_TEMP);
-		data->temp_max =3D adm1021_read_value(client,=20
ADM1021_REG_TOS_R);
-		data->temp_hyst =3D adm1021_read_value(client,=20
ADM1021_REG_THYST_R);
-		data->remote_temp_input =3D adm1021_read_value(client,=20
ADM1021_REG_REMOTE_TEMP);
-		data->remote_temp_max =3D adm1021_read_value(client,=20
ADM1021_REG_REMOTE_TOS_R);
-		data->remote_temp_hyst =3D adm1021_read_value(client,=20
ADM1021_REG_REMOTE_THYST_R);
-		data->alarms =3D adm1021_read_value(client,=20
ADM1021_REG_STATUS) & 0x7c;
+		for (i =3D 0; i < 2; i++) {
+			data->temp[i] =3D i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TEMP + i);
+			data->temp_max[i] =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1021_REG_TOS_R + 2 * i);
+			data->temp_min[i] =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1021_REG_THYST_R + 2 * i);
+		}
+		data->alarms =3D
+			i2c_smbus_read_byte_data(client,
+						ADM1021_REG_STATUS) & 0x7c;
 		if (data->type =3D=3D adm1023) {
-			data->remote_temp_prec =3D adm1021_read_value(client,=20
ADM1021_REG_REM_TEMP_PREC);
-			data->remote_temp_os_prec =3D=20
adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
-			data->remote_temp_hyst_prec =3D=20
adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
-			data->remote_temp_offset =3D adm1021_read_value(client,=20
ADM1021_REG_REM_OFFSET);
-			data->remote_temp_offset_prec =3D=20
adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
+			data->remote_temp_prec =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_TEMP_PREC);
+			data->remote_temp_os_prec =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_TOS_PREC);
+			data->remote_temp_hyst_prec =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_THYST_PREC);
+			data->remote_temp_offset =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET);
+			data->remote_temp_offset_prec =3D
+				i2c_smbus_read_byte_data(client,
+						ADM1023_REG_REM_OFFSET_PREC);
 		}
 		data->last_updated =3D jiffies;
 		data->valid =3D 1;


----------------------------------------------------
ROLLING STONES - A BIGGER BANG
Warszawa S=B3u=BFewiec 25 lipca 2007 r.=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Frollingstone=
s.html&sid=3D1213

--part4690a7b198588
Content-Type: application/octet-stream; name="adm1021-dyn-sysfs.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="adm1021-dyn-sysfs.diff"

LS0tIGxpbnV4LTIuNi4yMS5vbGQvZHJpdmVycy9od21vbi9hZG0xMDIxLmMJMjAwNy0wNC0yNiAw
NTowODozMi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4yMS9kcml2ZXJzL2h3bW9uL2Fk
bTEwMjEuYwkyMDA3LTA3LTA4IDA5OjQ4OjQ3LjAwMDAwMDAwMCArMDIwMApAQCAtMSw2ICsxLDYg
QEAKIC8qCiAgICAgYWRtMTAyMS5jIC0gUGFydCBvZiBsbV9zZW5zb3JzLCBMaW51eCBrZXJuZWwg
bW9kdWxlcyBmb3IgaGFyZHdhcmUKLSAgICAgICAgICAgICBtb25pdG9yaW5nCisJCW1vbml0b3Jp
bmcKICAgICBDb3B5cmlnaHQgKGMpIDE5OTgsIDE5OTkgIEZyb2RvIExvb2lqYWFyZCA8ZnJvZG9s
QGRkcy5ubD4gYW5kCiAgICAgUGhpbGlwIEVkZWxicm9jayA8cGhpbEBuZXRyb2VkZ2UuY29tPgog
CkBAIC0yNSw2ICsyNSw3IEBACiAjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgogI2luY2x1ZGUg
PGxpbnV4L2kyYy5oPgogI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+CisjaW5jbHVkZSA8bGludXgv
aHdtb24tc3lzZnMuaD4KICNpbmNsdWRlIDxsaW51eC9lcnIuaD4KICNpbmNsdWRlIDxsaW51eC9t
dXRleC5oPgogCkBAIC0zMiwxMSArMzMsMTIgQEAKIC8qIEFkZHJlc3NlcyB0byBzY2FuICovCiBz
dGF0aWMgdW5zaWduZWQgc2hvcnQgbm9ybWFsX2kyY1tdID0geyAweDE4LCAweDE5LCAweDFhLAog
CQkJCQkweDI5LCAweDJhLCAweDJiLAotCQkJCQkweDRjLCAweDRkLCAweDRlLCAKKwkJCQkJMHg0
YywgMHg0ZCwgMHg0ZSwKIAkJCQkJSTJDX0NMSUVOVF9FTkQgfTsKIAogLyogSW5zbW9kIHBhcmFt
ZXRlcnMgKi8KLUkyQ19DTElFTlRfSU5TTU9EXzgoYWRtMTAyMSwgYWRtMTAyMywgbWF4MTYxNywg
bWF4MTYxN2EsIHRobWMxMCwgbG04NCwgZ2w1MjNzbSwgbWMxMDY2KTsKK0kyQ19DTElFTlRfSU5T
TU9EXzgoYWRtMTAyMSwgYWRtMTAyMywgbWF4MTYxNywgbWF4MTYxN2EsIHRobWMxMCwgbG04NCwg
Z2w1MjNzbSwKKwkJCW1jMTA2Nik7CiAKIC8qIGFkbTEwMjEgY29uc3RhbnRzIHNwZWNpZmllZCBi
ZWxvdyAqLwogCkBAIC00NSw4ICs0NywxMCBAQCBJMkNfQ0xJRU5UX0lOU01PRF84KGFkbTEwMjEs
IGFkbTEwMjMsIG1hCiAjZGVmaW5lIEFETTEwMjFfUkVHX1RFTVAJCTB4MDAKICNkZWZpbmUgQURN
MTAyMV9SRUdfUkVNT1RFX1RFTVAJCTB4MDEKICNkZWZpbmUgQURNMTAyMV9SRUdfU1RBVFVTCQkw
eDAyCi0jZGVmaW5lIEFETTEwMjFfUkVHX01BTl9JRAkJMHgwRkUJLyogMHg0MSA9IEFNRCwgMHg0
OSA9IFRJLCAweDREID0gTWF4aW0sIDB4MjMgPSBHZW5lc3lzICwgMHg1NCA9IE9uc2VtaSovCi0j
ZGVmaW5lIEFETTEwMjFfUkVHX0RFVl9JRAkJMHgwRkYJLyogQURNMTAyMSA9IDB4MFgsIEFETTEw
MjMgPSAweDNYICovCisvKiAweDQxID0gQUQsIDB4NDkgPSBUSSwgMHg0RCA9IE1heGltLCAweDIz
ID0gR2VuZXN5cyAsIDB4NTQgPSBPbnNlbWkgKi8KKyNkZWZpbmUgQURNMTAyMV9SRUdfTUFOX0lE
CQkweDBGRQorLyogQURNMTAyMSA9IDB4MFgsIEFETTEwMjMgPSAweDNYICovCisjZGVmaW5lIEFE
TTEwMjFfUkVHX0RFVl9JRAkJMHgwRkYKICNkZWZpbmUgQURNMTAyMV9SRUdfRElFX0NPREUJCTB4
MEZGCS8qIE1BWDE2MTdBICovCiAvKiBUaGVzZSB1c2UgZGlmZmVyZW50IGFkZHJlc3NlcyBmb3Ig
cmVhZGluZy93cml0aW5nICovCiAjZGVmaW5lIEFETTEwMjFfUkVHX0NPTkZJR19SCQkweDAzCkBA
IC01NCwxMSArNTgsMTEgQEAgSTJDX0NMSUVOVF9JTlNNT0RfOChhZG0xMDIxLCBhZG0xMDIzLCBt
YQogI2RlZmluZSBBRE0xMDIxX1JFR19DT05WX1JBVEVfUgkJMHgwNAogI2RlZmluZSBBRE0xMDIx
X1JFR19DT05WX1JBVEVfVwkJMHgwQQogLyogVGhlc2UgYXJlIGZvciB0aGUgQURNMTAyMydzIGFk
ZGl0aW9uYWwgcHJlY2lzaW9uIG9uIHRoZSByZW1vdGUgdGVtcCBzZW5zb3IgKi8KLSNkZWZpbmUg
QURNMTAyMV9SRUdfUkVNX1RFTVBfUFJFQwkweDAxMAotI2RlZmluZSBBRE0xMDIxX1JFR19SRU1f
T0ZGU0VUCQkweDAxMQotI2RlZmluZSBBRE0xMDIxX1JFR19SRU1fT0ZGU0VUX1BSRUMJMHgwMTIK
LSNkZWZpbmUgQURNMTAyMV9SRUdfUkVNX1RPU19QUkVDCTB4MDEzCi0jZGVmaW5lIEFETTEwMjFf
UkVHX1JFTV9USFlTVF9QUkVDCTB4MDE0CisjZGVmaW5lIEFETTEwMjNfUkVHX1JFTV9URU1QX1BS
RUMJMHgwMTAKKyNkZWZpbmUgQURNMTAyM19SRUdfUkVNX09GRlNFVAkJMHgwMTEKKyNkZWZpbmUg
QURNMTAyM19SRUdfUkVNX09GRlNFVF9QUkVDCTB4MDEyCisjZGVmaW5lIEFETTEwMjNfUkVHX1JF
TV9UT1NfUFJFQwkweDAxMworI2RlZmluZSBBRE0xMDIzX1JFR19SRU1fVEhZU1RfUFJFQwkweDAx
NAogLyogbGltaXRzICovCiAjZGVmaW5lIEFETTEwMjFfUkVHX1RPU19SCQkweDA1CiAjZGVmaW5l
IEFETTEwMjFfUkVHX1RPU19XCQkweDBCCkBAIC03MSwyMCArNzUsMTEgQEAgSTJDX0NMSUVOVF9J
TlNNT0RfOChhZG0xMDIxLCBhZG0xMDIzLCBtYQogLyogd3JpdGUtb25seSAqLwogI2RlZmluZSBB
RE0xMDIxX1JFR19PTkVTSE9UCQkweDBGCiAKLQotLyogQ29udmVyc2lvbnMuIFJvdW5kaW5nIGFu
ZCBsaW1pdCBjaGVja2luZyBpcyBvbmx5IGRvbmUgb24gdGhlIFRPX1JFRwotICAgdmFyaWFudHMu
IE5vdGUgdGhhdCB5b3Ugc2hvdWxkIGJlIGEgYml0IGNhcmVmdWwgd2l0aCB3aGljaCBhcmd1bWVu
dHMKLSAgIHRoZXNlIG1hY3JvcyBhcmUgY2FsbGVkOiBhcmd1bWVudHMgbWF5IGJlIGV2YWx1YXRl
ZCBtb3JlIHRoYW4gb25jZS4KLSAgIEZpeGluZyB0aGlzIGlzIGp1c3Qgbm90IHdvcnRoIGl0LiAq
LwotLyogQ29udmVyc2lvbnMgIG5vdGU6IDEwMjEgdXNlcyBub3JtYWwgaW50ZWdlciBzaWduZWQt
Ynl0ZSBmb3JtYXQqLwotI2RlZmluZSBURU1QX0ZST01fUkVHKHZhbCkJKHZhbCA+IDEyNyA/ICh2
YWwtMjU2KSoxMDAwIDogdmFsKjEwMDApCi0jZGVmaW5lIFRFTVBfVE9fUkVHKHZhbCkJKFNFTlNP
UlNfTElNSVQoKHZhbCA8IDAgPyAodmFsLzEwMDApKzI1NiA6IHZhbC8xMDAwKSwwLDI1NSkpCi0K
IC8qIEluaXRpYWwgdmFsdWVzICovCiAKLS8qIE5vdGU6IEV2ZW4gdGhvdWdoIEkgbGVmdCB0aGUg
bG93IGFuZCBoaWdoIGxpbWl0cyBuYW1lZCBvcyBhbmQgaHlzdCwgCi10aGV5IGRvbid0IHF1aXRl
IHdvcmsgbGlrZSBhIHRoZXJtb3N0YXQgdGhlIHdheSB0aGUgTE03NSBkb2VzLiAgSS5lLiwgCi1h
IGxvd2VyIHRlbXAgdGhhbiBUSFlTVCBhY3R1YWxseSB0cmlnZ2VycyBhbiBhbGFybSBpbnN0ZWFk
IG9mIAorLyogTm90ZTogRXZlbiB0aG91Z2ggSSBsZWZ0IHRoZSBsb3cgYW5kIGhpZ2ggbGltaXRz
IG5hbWVkIG9zIGFuZCBoeXN0LAordGhleSBkb24ndCBxdWl0ZSB3b3JrIGxpa2UgYSB0aGVybW9z
dGF0IHRoZSB3YXkgdGhlIExNNzUgZG9lcy4gIEkuZS4sCithIGxvd2VyIHRlbXAgdGhhbiBUSFlT
VCBhY3R1YWxseSB0cmlnZ2VycyBhbiBhbGFybSBpbnN0ZWFkIG9mCiBjbGVhcmluZyBpdC4gIFdl
aXJkLCBleT8gICAtLVBoaWwgICovCiAKIC8qIEVhY2ggY2xpZW50IGhhcyB0aGlzIGFkZGl0aW9u
YWwgZGF0YSAqLwpAQCAtOTcsMjggKzkyLDIyIEBAIHN0cnVjdCBhZG0xMDIxX2RhdGEgewogCWNo
YXIgdmFsaWQ7CQkvKiAhPTAgaWYgZm9sbG93aW5nIGZpZWxkcyBhcmUgdmFsaWQgKi8KIAl1bnNp
Z25lZCBsb25nIGxhc3RfdXBkYXRlZDsJLyogSW4gamlmZmllcyAqLwogCi0JdTgJdGVtcF9tYXg7
CS8qIFJlZ2lzdGVyIHZhbHVlcyAqLwotCXU4CXRlbXBfaHlzdDsKLQl1OAl0ZW1wX2lucHV0Owot
CXU4CXJlbW90ZV90ZW1wX21heDsKLQl1OAlyZW1vdGVfdGVtcF9oeXN0OwotCXU4CXJlbW90ZV90
ZW1wX2lucHV0OwotCXU4CWFsYXJtczsKLSAgICAgICAgLyogU3BlY2lhbCB2YWx1ZXMgZm9yIEFE
TTEwMjMgb25seSAqLwotCXU4CXJlbW90ZV90ZW1wX3ByZWM7Ci0JdTgJcmVtb3RlX3RlbXBfb3Nf
cHJlYzsKLQl1OAlyZW1vdGVfdGVtcF9oeXN0X3ByZWM7Ci0JdTgJcmVtb3RlX3RlbXBfb2Zmc2V0
OwotCXU4CXJlbW90ZV90ZW1wX29mZnNldF9wcmVjOworCXM4IHRlbXBfbWF4WzJdOwkJLyogUmVn
aXN0ZXIgdmFsdWVzICovCisJczggdGVtcF9taW5bMl07CisJczggdGVtcFsyXTsKKwl1OCBhbGFy
bXM7CisJLyogU3BlY2lhbCB2YWx1ZXMgZm9yIEFETTEwMjMgb25seSAqLworCXU4IHJlbW90ZV90
ZW1wX3ByZWM7CisJdTggcmVtb3RlX3RlbXBfb3NfcHJlYzsKKwl1OCByZW1vdGVfdGVtcF9oeXN0
X3ByZWM7CisJdTggcmVtb3RlX3RlbXBfb2Zmc2V0OworCXU4IHJlbW90ZV90ZW1wX29mZnNldF9w
cmVjOwogfTsKIAogc3RhdGljIGludCBhZG0xMDIxX2F0dGFjaF9hZGFwdGVyKHN0cnVjdCBpMmNf
YWRhcHRlciAqYWRhcHRlcik7CiBzdGF0aWMgaW50IGFkbTEwMjFfZGV0ZWN0KHN0cnVjdCBpMmNf
YWRhcHRlciAqYWRhcHRlciwgaW50IGFkZHJlc3MsIGludCBraW5kKTsKIHN0YXRpYyB2b2lkIGFk
bTEwMjFfaW5pdF9jbGllbnQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCk7CiBzdGF0aWMgaW50
IGFkbTEwMjFfZGV0YWNoX2NsaWVudChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KTsKLXN0YXRp
YyBpbnQgYWRtMTAyMV9yZWFkX3ZhbHVlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHU4IHJl
Zyk7Ci1zdGF0aWMgaW50IGFkbTEwMjFfd3JpdGVfdmFsdWUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCwgdTggcmVnLAotCQkJICAgICAgIHUxNiB2YWx1ZSk7CiBzdGF0aWMgc3RydWN0IGFkbTEw
MjFfZGF0YSAqYWRtMTAyMV91cGRhdGVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldik7CiAKIC8q
IChhbWFseXNoKSByZWFkIG9ubHkgbW9kZSwgb3RoZXJ3aXNlIGFueSBsaW1pdCdzIHdyaXRpbmcg
Y29uZnVzZSBCSU9TICovCkBAIC0xMzUsNTMgKzEyNCw4OSBAQCBzdGF0aWMgc3RydWN0IGkyY19k
cml2ZXIgYWRtMTAyMV9kcml2ZXIgCiAJLmRldGFjaF9jbGllbnQJPSBhZG0xMDIxX2RldGFjaF9j
bGllbnQsCiB9OwogCi0jZGVmaW5lIHNob3codmFsdWUpCVwKLXN0YXRpYyBzc2l6ZV90IHNob3df
IyN2YWx1ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LCBjaGFyICpidWYpCQlcCi17CQkJCQkJCQkJXAotCXN0cnVjdCBhZG0xMDIxX2RhdGEgKmRhdGEg
PSBhZG0xMDIxX3VwZGF0ZV9kZXZpY2UoZGV2KTsJCVwKLQlyZXR1cm4gc3ByaW50ZihidWYsICIl
ZFxuIiwgVEVNUF9GUk9NX1JFRyhkYXRhLT52YWx1ZSkpOwlcCitzdGF0aWMgc3NpemVfdCBzaG93
X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LAorCQkJIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpk
ZXZhdHRyLCBjaGFyICpidWYpCit7CisJaW50IGluZGV4ID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRl
dmF0dHIpLT5pbmRleDsKKwlzdHJ1Y3QgYWRtMTAyMV9kYXRhICpkYXRhID0gYWRtMTAyMV91cGRh
dGVfZGV2aWNlKGRldik7CisKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgMTAwMCAqIGRh
dGEtPnRlbXBbaW5kZXhdKTsKK30KKworc3RhdGljIHNzaXplX3Qgc2hvd190ZW1wX21heChzdHJ1
Y3QgZGV2aWNlICpkZXYsCisJCQkgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkZXZhdHRy
LCBjaGFyICpidWYpCit7CisJaW50IGluZGV4ID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRldmF0dHIp
LT5pbmRleDsKKwlzdHJ1Y3QgYWRtMTAyMV9kYXRhICpkYXRhID0gYWRtMTAyMV91cGRhdGVfZGV2
aWNlKGRldik7CisKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgMTAwMCAqIGRhdGEtPnRl
bXBfbWF4W2luZGV4XSk7Cit9CisKK3N0YXRpYyBzc2l6ZV90IHNob3dfdGVtcF9taW4oc3RydWN0
IGRldmljZSAqZGV2LAorCQkJICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwg
Y2hhciAqYnVmKQoreworCWludCBpbmRleCA9IHRvX3NlbnNvcl9kZXZfYXR0cihkZXZhdHRyKS0+
aW5kZXg7CisJc3RydWN0IGFkbTEwMjFfZGF0YSAqZGF0YSA9IGFkbTEwMjFfdXBkYXRlX2Rldmlj
ZShkZXYpOworCisJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRcbiIsIDEwMDAgKiBkYXRhLT50ZW1w
X21pbltpbmRleF0pOwogfQotc2hvdyh0ZW1wX21heCk7Ci1zaG93KHRlbXBfaHlzdCk7Ci1zaG93
KHRlbXBfaW5wdXQpOwotc2hvdyhyZW1vdGVfdGVtcF9tYXgpOwotc2hvdyhyZW1vdGVfdGVtcF9o
eXN0KTsKLXNob3cocmVtb3RlX3RlbXBfaW5wdXQpOwogCiAjZGVmaW5lIHNob3cyKHZhbHVlKQlc
Ci1zdGF0aWMgc3NpemVfdCBzaG93XyMjdmFsdWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQkJXAorc3RhdGljIHNzaXplX3Qgc2hv
d18jI3ZhbHVlKHN0cnVjdCBkZXZpY2UgKmRldiwJCQkJXAorCQkJICAgIHN0cnVjdCBkZXZpY2Vf
YXR0cmlidXRlICphdHRyLAkJXAorCQkJICAgIGNoYXIgKmJ1ZikJCQkJCVwKIHsJCQkJCQkJCQlc
CiAJc3RydWN0IGFkbTEwMjFfZGF0YSAqZGF0YSA9IGFkbTEwMjFfdXBkYXRlX2RldmljZShkZXYp
OwkJXAogCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVkXG4iLCBkYXRhLT52YWx1ZSk7CQkJXAogfQog
c2hvdzIoYWxhcm1zKTsKIAotI2RlZmluZSBzZXQodmFsdWUsIHJlZykJXAotc3RhdGljIHNzaXpl
X3Qgc2V0XyMjdmFsdWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpCVwKLXsJCQkJCQkJCVwKLQlz
dHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwkJXAotCXN0cnVj
dCBhZG0xMDIxX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsJXAotCWlu
dCB0ZW1wID0gc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7CQlcCi0JCQkJCQkJCVwKLQlt
dXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CQkJCVwKLQlkYXRhLT52YWx1ZSA9IFRFTVBf
VE9fUkVHKHRlbXApOwkJCVwKLQlhZG0xMDIxX3dyaXRlX3ZhbHVlKGNsaWVudCwgcmVnLCBkYXRh
LT52YWx1ZSk7CQlcCi0JbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CQkJXAotCXJl
dHVybiBjb3VudDsJCQkJCQlcCi19Ci1zZXQodGVtcF9tYXgsIEFETTEwMjFfUkVHX1RPU19XKTsK
LXNldCh0ZW1wX2h5c3QsIEFETTEwMjFfUkVHX1RIWVNUX1cpOwotc2V0KHJlbW90ZV90ZW1wX21h
eCwgQURNMTAyMV9SRUdfUkVNT1RFX1RPU19XKTsKLXNldChyZW1vdGVfdGVtcF9oeXN0LCBBRE0x
MDIxX1JFR19SRU1PVEVfVEhZU1RfVyk7Ci0KLXN0YXRpYyBERVZJQ0VfQVRUUih0ZW1wMV9tYXgs
IFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3RlbXBfbWF4LCBzZXRfdGVtcF9tYXgpOwotc3RhdGlj
IERFVklDRV9BVFRSKHRlbXAxX21pbiwgU19JV1VTUiB8IFNfSVJVR08sIHNob3dfdGVtcF9oeXN0
LCBzZXRfdGVtcF9oeXN0KTsKLXN0YXRpYyBERVZJQ0VfQVRUUih0ZW1wMV9pbnB1dCwgU19JUlVH
Tywgc2hvd190ZW1wX2lucHV0LCBOVUxMKTsKLXN0YXRpYyBERVZJQ0VfQVRUUih0ZW1wMl9tYXgs
IFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3JlbW90ZV90ZW1wX21heCwgc2V0X3JlbW90ZV90ZW1w
X21heCk7Ci1zdGF0aWMgREVWSUNFX0FUVFIodGVtcDJfbWluLCBTX0lXVVNSIHwgU19JUlVHTywg
c2hvd19yZW1vdGVfdGVtcF9oeXN0LCBzZXRfcmVtb3RlX3RlbXBfaHlzdCk7Ci1zdGF0aWMgREVW
SUNFX0FUVFIodGVtcDJfaW5wdXQsIFNfSVJVR08sIHNob3dfcmVtb3RlX3RlbXBfaW5wdXQsIE5V
TEwpOwotc3RhdGljIERFVklDRV9BVFRSKGFsYXJtcywgU19JUlVHTywgc2hvd19hbGFybXMsIE5V
TEwpOworc3RhdGljIHNzaXplX3Qgc2V0X3RlbXBfbWF4KHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJ
CSAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2YXR0ciwKKwkJCSAgICBjb25zdCBjaGFy
ICpidWYsIHNpemVfdCBjb3VudCkKK3sKKwlpbnQgaW5kZXggPSB0b19zZW5zb3JfZGV2X2F0dHIo
ZGV2YXR0ciktPmluZGV4OworCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xp
ZW50KGRldik7CisJc3RydWN0IGFkbTEwMjFfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0
YShjbGllbnQpOworCWludCB0ZW1wID0gc2ltcGxlX3N0cnRvbChidWYsIE5VTEwsIDEwKSAvIDEw
MDA7CiAKKwltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CisJZGF0YS0+dGVtcF9tYXhb
aW5kZXhdID0gU0VOU09SU19MSU1JVCh0ZW1wLCAtMTI4LCAxMjcpOworCWkyY19zbWJ1c193cml0
ZV9ieXRlX2RhdGEoY2xpZW50LCBBRE0xMDIxX1JFR19UT1NfVyArIDIgKiBpbmRleCwgdGVtcCk7
CisJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CisKKwlyZXR1cm4gY291bnQ7Cit9
CisKK3N0YXRpYyBzc2l6ZV90IHNldF90ZW1wX21pbihzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkg
ICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmRldmF0dHIsCisJCQkgICAgY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpCit7CisJaW50IGluZGV4ID0gdG9fc2Vuc29yX2Rldl9hdHRyKGRl
dmF0dHIpLT5pbmRleDsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVu
dChkZXYpOworCXN0cnVjdCBhZG0xMDIxX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEo
Y2xpZW50KTsKKwlpbnQgdGVtcCA9IHNpbXBsZV9zdHJ0b2woYnVmLCBOVUxMLCAxMCkgLyAxMDAw
OworCisJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOworCWRhdGEtPnRlbXBfbWF4W2lu
ZGV4XSA9IFNFTlNPUlNfTElNSVQodGVtcCwgLTEyOCwgMTI3KTsKKwlpMmNfc21idXNfd3JpdGVf
Ynl0ZV9kYXRhKGNsaWVudCwKKwkJCQkgIEFETTEwMjFfUkVHX1RIWVNUX1cgKyAyICogaW5kZXgs
IHRlbXApOworCW11dGV4X3VubG9jaygmZGF0YS0+dXBkYXRlX2xvY2spOworCisJcmV0dXJuIGNv
dW50OworfQorCitzdGF0aWMgU0VOU09SX0RFVklDRV9BVFRSKHRlbXAxX2lucHV0LCBTX0lSVUdP
LCBzaG93X3RlbXAsIE5VTEwsIDApOworc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9t
YXgsIFNfSVdVU1IgfCBTX0lSVUdPLCBzaG93X3RlbXBfbWF4LAorCQkJICBzZXRfdGVtcF9tYXgs
IDApOworc3RhdGljIFNFTlNPUl9ERVZJQ0VfQVRUUih0ZW1wMV9taW4sIFNfSVdVU1IgfCBTX0lS
VUdPLCBzaG93X3RlbXBfbWluLAorCQkJICBzZXRfdGVtcF9taW4sIDApOworc3RhdGljIFNFTlNP
Ul9ERVZJQ0VfQVRUUih0ZW1wMl9pbnB1dCwgU19JUlVHTywgc2hvd190ZW1wLCBOVUxMLCAxKTsK
K3N0YXRpYyBTRU5TT1JfREVWSUNFX0FUVFIodGVtcDJfbWF4LCBTX0lXVVNSIHwgU19JUlVHTywg
c2hvd190ZW1wX21heCwKKwkJCSAgc2V0X3RlbXBfbWF4LCAxKTsKK3N0YXRpYyBTRU5TT1JfREVW
SUNFX0FUVFIodGVtcDJfbWluLCBTX0lXVVNSIHwgU19JUlVHTywgc2hvd190ZW1wX21pbiwKKwkJ
CSAgc2V0X3RlbXBfbWluLCAxKTsKK3N0YXRpYyBERVZJQ0VfQVRUUihhbGFybXMsIFNfSVJVR08s
IHNob3dfYWxhcm1zLCBOVUxMKTsKIAogc3RhdGljIGludCBhZG0xMDIxX2F0dGFjaF9hZGFwdGVy
KHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcHRlcikKIHsKQEAgLTE5MSwxMiArMjE2LDEyIEBAIHN0
YXRpYyBpbnQgYWRtMTAyMV9hdHRhY2hfYWRhcHRlcihzdHJ1Y3QKIH0KIAogc3RhdGljIHN0cnVj
dCBhdHRyaWJ1dGUgKmFkbTEwMjFfYXR0cmlidXRlc1tdID0gewotCSZkZXZfYXR0cl90ZW1wMV9t
YXguYXR0ciwKLQkmZGV2X2F0dHJfdGVtcDFfbWluLmF0dHIsCi0JJmRldl9hdHRyX3RlbXAxX2lu
cHV0LmF0dHIsCi0JJmRldl9hdHRyX3RlbXAyX21heC5hdHRyLAotCSZkZXZfYXR0cl90ZW1wMl9t
aW4uYXR0ciwKLQkmZGV2X2F0dHJfdGVtcDJfaW5wdXQuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRy
X3RlbXAxX21heC5kZXZfYXR0ci5hdHRyLAorCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDFfbWluLmRl
dl9hdHRyLmF0dHIsCisJJnNlbnNvcl9kZXZfYXR0cl90ZW1wMV9pbnB1dC5kZXZfYXR0ci5hdHRy
LAorCSZzZW5zb3JfZGV2X2F0dHJfdGVtcDJfbWF4LmRldl9hdHRyLmF0dHIsCisJJnNlbnNvcl9k
ZXZfYXR0cl90ZW1wMl9taW4uZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rldl9hdHRyX3RlbXAy
X2lucHV0LmRldl9hdHRyLmF0dHIsCiAJJmRldl9hdHRyX2FsYXJtcy5hdHRyLAogCU5VTEwKIH07
CkBAIC0yMTIsMTUgKzIzNywyMCBAQCBzdGF0aWMgaW50IGFkbTEwMjFfZGV0ZWN0KHN0cnVjdCBp
MmNfYWRhCiAJc3RydWN0IGFkbTEwMjFfZGF0YSAqZGF0YTsKIAlpbnQgZXJyID0gMDsKIAljb25z
dCBjaGFyICp0eXBlX25hbWUgPSAiIjsKKwlpbnQgY29udl9yYXRlLCBzdGF0dXMsIGNvbmZpZzsK
IAotCWlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxpdHkoYWRhcHRlciwgSTJDX0ZVTkNfU01CVVNf
QllURV9EQVRBKSkKKwlpZiAoIWkyY19jaGVja19mdW5jdGlvbmFsaXR5KGFkYXB0ZXIsIEkyQ19G
VU5DX1NNQlVTX0JZVEVfREFUQSkpIHsKKwkJcHJfZGVidWcoImFkbTEwMjE6IGRldGVjdCBmYWls
ZWQsICIKKwkJCSAic21idXMgYnl0ZSBkYXRhIG5vdCBzdXBwb3J0ZWQhXG4iKTsKIAkJZ290byBl
cnJvcjA7CisJfQogCiAJLyogT0suIEZvciBub3csIHdlIHByZXN1bWUgd2UgaGF2ZSBhIHZhbGlk
IGNsaWVudC4gV2Ugbm93IGNyZWF0ZSB0aGUKIAkgICBjbGllbnQgc3RydWN0dXJlLCBldmVuIHRo
b3VnaCB3ZSBjYW5ub3QgZmlsbCBpdCBjb21wbGV0ZWx5IHlldC4KIAkgICBCdXQgaXQgYWxsb3dz
IHVzIHRvIGFjY2VzcyBhZG0xMDIxX3tyZWFkLHdyaXRlfV92YWx1ZS4gKi8KIAogCWlmICghKGRh
dGEgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgYWRtMTAyMV9kYXRhKSwgR0ZQX0tFUk5FTCkpKSB7
CisJCXByX2RlYnVnKCJhZG0xMDIxOiBkZXRlY3QgZmFpbGVkLCBremFsbG9jIGZhaWxlZCFcbiIp
OwogCQllcnIgPSAtRU5PTUVNOwogCQlnb3RvIGVycm9yMDsKIAl9CkBAIC0yMzAsMTMgKzI2MCwx
NyBAQCBzdGF0aWMgaW50IGFkbTEwMjFfZGV0ZWN0KHN0cnVjdCBpMmNfYWRhCiAJbmV3X2NsaWVu
dC0+YWRkciA9IGFkZHJlc3M7CiAJbmV3X2NsaWVudC0+YWRhcHRlciA9IGFkYXB0ZXI7CiAJbmV3
X2NsaWVudC0+ZHJpdmVyID0gJmFkbTEwMjFfZHJpdmVyOwotCW5ld19jbGllbnQtPmZsYWdzID0g
MDsKKwlzdGF0dXMgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEobmV3X2NsaWVudCwgQURNMTAy
MV9SRUdfU1RBVFVTKTsKKwljb252X3JhdGUgPSBpMmNfc21idXNfcmVhZF9ieXRlX2RhdGEobmV3
X2NsaWVudCwKKwkJCQkJICAgICBBRE0xMDIxX1JFR19DT05WX1JBVEVfUik7CisJY29uZmlnID0g
aTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKG5ld19jbGllbnQsIEFETTEwMjFfUkVHX0NPTkZJR19S
KTsKIAogCS8qIE5vdywgd2UgZG8gdGhlIHJlbWFpbmluZyBkZXRlY3Rpb24uICovCiAJaWYgKGtp
bmQgPCAwKSB7Ci0JCWlmICgoYWRtMTAyMV9yZWFkX3ZhbHVlKG5ld19jbGllbnQsIEFETTEwMjFf
UkVHX1NUQVRVUykgJiAweDAzKSAhPSAweDAwCi0JCSB8fCAoYWRtMTAyMV9yZWFkX3ZhbHVlKG5l
d19jbGllbnQsIEFETTEwMjFfUkVHX0NPTkZJR19SKSAmIDB4M0YpICE9IDB4MDAKLQkJIHx8IChh
ZG0xMDIxX3JlYWRfdmFsdWUobmV3X2NsaWVudCwgQURNMTAyMV9SRUdfQ09OVl9SQVRFX1IpICYg
MHhGOCkgIT0gMHgwMCkgeworCQlpZiAoKHN0YXR1cyAmIDB4MDMpICE9IDB4MDAgfHwgKGNvbmZp
ZyAmIDB4M0YpICE9IDB4MDAKKwkJICAgIHx8IChjb252X3JhdGUgJiAweEY4KSAhPSAweDAwKSB7
CisJCQlwcl9kZWJ1ZygiYWRtMTAyMTogZGV0ZWN0IGZhaWxlZCwgIgorCQkJCSAiY2hpcCBub3Qg
ZGV0ZWN0ZWQhXG4iKTsKIAkJCWVyciA9IC1FTk9ERVY7CiAJCQlnb3RvIGVycm9yMTsKIAkJfQpA
QCAtMjQ0LDkgKzI3OCwxMCBAQCBzdGF0aWMgaW50IGFkbTEwMjFfZGV0ZWN0KHN0cnVjdCBpMmNf
YWRhCiAKIAkvKiBEZXRlcm1pbmUgdGhlIGNoaXAgdHlwZS4gKi8KIAlpZiAoa2luZCA8PSAwKSB7
Ci0JCWkgPSBhZG0xMDIxX3JlYWRfdmFsdWUobmV3X2NsaWVudCwgQURNMTAyMV9SRUdfTUFOX0lE
KTsKKwkJaSA9IGkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShuZXdfY2xpZW50LCBBRE0xMDIxX1JF
R19NQU5fSUQpOwogCQlpZiAoaSA9PSAweDQxKQotCQkJaWYgKChhZG0xMDIxX3JlYWRfdmFsdWUo
bmV3X2NsaWVudCwgQURNMTAyMV9SRUdfREVWX0lEKSAmIDB4MEYwKSA9PSAweDAzMCkKKwkJCWlm
ICgoaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKG5ld19jbGllbnQsCisJCQkJCUFETTEwMjFfUkVH
X0RFVl9JRCkgJiAweDBGMCkgPT0gMHgwMzApCiAJCQkJa2luZCA9IGFkbTEwMjM7CiAJCQllbHNl
CiAJCQkJa2luZCA9IGFkbTEwMjE7CkBAIC0yNTUsMTUgKzI5MCwxNiBAQCBzdGF0aWMgaW50IGFk
bTEwMjFfZGV0ZWN0KHN0cnVjdCBpMmNfYWRhCiAJCWVsc2UgaWYgKGkgPT0gMHgyMykKIAkJCWtp
bmQgPSBnbDUyM3NtOwogCQllbHNlIGlmICgoaSA9PSAweDRkKSAmJgotCQkJIChhZG0xMDIxX3Jl
YWRfdmFsdWUobmV3X2NsaWVudCwgQURNMTAyMV9SRUdfREVWX0lEKSA9PSAweDAxKSkKKwkJCSAo
aTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKG5ld19jbGllbnQsCisJCQkJCQkgICBBRE0xMDIxX1JF
R19ERVZfSUQpID09IDB4MDEpKQogCQkJa2luZCA9IG1heDE2MTdhOwogCQllbHNlIGlmIChpID09
IDB4NTQpCiAJCQlraW5kID0gbWMxMDY2OwogCQkvKiBMTTg0IE1mciBJRCBpbiBhIGRpZmZlcmVu
dCBwbGFjZSwgYW5kIGl0IGhhcyBtb3JlIHVudXNlZCBiaXRzICovCi0JCWVsc2UgaWYgKGFkbTEw
MjFfcmVhZF92YWx1ZShuZXdfY2xpZW50LCBBRE0xMDIxX1JFR19DT05WX1JBVEVfUikgPT0gMHgw
MAotCQkgICAgICAmJiAoa2luZCA9PSAwIC8qIHNraXAgZXh0cmEgZGV0ZWN0aW9uICovCi0JCSAg
ICAgICB8fCAoKGFkbTEwMjFfcmVhZF92YWx1ZShuZXdfY2xpZW50LCBBRE0xMDIxX1JFR19DT05G
SUdfUikgJiAweDdGKSA9PSAweDAwCi0JCQkmJiAoYWRtMTAyMV9yZWFkX3ZhbHVlKG5ld19jbGll
bnQsIEFETTEwMjFfUkVHX1NUQVRVUykgJiAweEFCKSA9PSAweDAwKSkpCisJCWVsc2UgaWYgKGNv
bnZfcmF0ZSA9PSAweDAwCisJCQkgJiYgKGtpbmQgPT0gMCAvKiBza2lwIGV4dHJhIGRldGVjdGlv
biAqLworCQkJICAgICB8fCAoKGNvbmZpZyAmIDB4N0YpID09IDB4MDAKKwkJCQkgJiYgKHN0YXR1
cyAmIDB4QUIpID09IDB4MDApKSkKIAkJCWtpbmQgPSBsbTg0OwogCQllbHNlCiAJCQlraW5kID0g
bWF4MTYxNzsKQEAgLTI4NiwxMSArMzIyLDEyIEBAIHN0YXRpYyBpbnQgYWRtMTAyMV9kZXRlY3Qo
c3RydWN0IGkyY19hZGEKIAl9IGVsc2UgaWYgKGtpbmQgPT0gbWMxMDY2KSB7CiAJCXR5cGVfbmFt
ZSA9ICJtYzEwNjYiOwogCX0KKwlwcl9kZWJ1ZygiYWRtMTAyMTogRGV0ZWN0ZWQgY2hpcCAlcyBh
dCBhZGFwdGVyICVkLCBhZGRyZXNzIDB4JTAyeC5cbiIsCisJCSB0eXBlX25hbWUsIGkyY19hZGFw
dGVyX2lkKGFkYXB0ZXIpLCBhZGRyZXNzKTsKIAotCS8qIEZpbGwgaW4gdGhlIHJlbWFpbmluZyBj
bGllbnQgZmllbGRzIGFuZCBwdXQgaXQgaW50byB0aGUgZ2xvYmFsIGxpc3QgKi8KKwkvKiBGaWxs
IGluIHRoZSByZW1haW5pbmcgY2xpZW50IGZpZWxkcyAqLwogCXN0cmxjcHkobmV3X2NsaWVudC0+
bmFtZSwgdHlwZV9uYW1lLCBJMkNfTkFNRV9TSVpFKTsKIAlkYXRhLT50eXBlID0ga2luZDsKLQlk
YXRhLT52YWxpZCA9IDA7CiAJbXV0ZXhfaW5pdCgmZGF0YS0+dXBkYXRlX2xvY2spOwogCiAJLyog
VGVsbCB0aGUgSTJDIGxheWVyIGEgbmV3IGNsaWVudCBoYXMgYXJyaXZlZCAqLwpAQCAtMzI2LDEw
ICszNjMsMTAgQEAgZXJyb3IwOgogc3RhdGljIHZvaWQgYWRtMTAyMV9pbml0X2NsaWVudChzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogewogCS8qIEVuYWJsZSBBREMgYW5kIGRpc2FibGUgc3Vz
cGVuZCBtb2RlICovCi0JYWRtMTAyMV93cml0ZV92YWx1ZShjbGllbnQsIEFETTEwMjFfUkVHX0NP
TkZJR19XLAotCQlhZG0xMDIxX3JlYWRfdmFsdWUoY2xpZW50LCBBRE0xMDIxX1JFR19DT05GSUdf
UikgJiAweEJGKTsKKwlpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgQURNMTAyMV9S
RUdfQ09ORklHX1csCisJCWkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsIEFETTEwMjFf
UkVHX0NPTkZJR19SKSAmIDB4QkYpOwogCS8qIFNldCBDb252ZXJzaW9uIHJhdGUgdG8gMS9zZWMg
KHRoaXMgY2FuIGJlIHRpbmtlcmVkIHdpdGgpICovCi0JYWRtMTAyMV93cml0ZV92YWx1ZShjbGll
bnQsIEFETTEwMjFfUkVHX0NPTlZfUkFURV9XLCAweDA0KTsKKwlpMmNfc21idXNfd3JpdGVfYnl0
ZV9kYXRhKGNsaWVudCwgQURNMTAyMV9SRUdfQ09OVl9SQVRFX1csIDB4MDQpOwogfQogCiBzdGF0
aWMgaW50IGFkbTEwMjFfZGV0YWNoX2NsaWVudChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQpA
QCAtMzQ3LDE5ICszODQsNiBAQCBzdGF0aWMgaW50IGFkbTEwMjFfZGV0YWNoX2NsaWVudChzdHJ1
Y3QgCiAJcmV0dXJuIDA7CiB9CiAKLS8qIEFsbCByZWdpc3RlcnMgYXJlIGJ5dGUtc2l6ZWQgKi8K
LXN0YXRpYyBpbnQgYWRtMTAyMV9yZWFkX3ZhbHVlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQs
IHU4IHJlZykKLXsKLQlyZXR1cm4gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgcmVn
KTsKLX0KLQotc3RhdGljIGludCBhZG0xMDIxX3dyaXRlX3ZhbHVlKHN0cnVjdCBpMmNfY2xpZW50
ICpjbGllbnQsIHU4IHJlZywgdTE2IHZhbHVlKQotewotCWlmICghcmVhZF9vbmx5KQotCQlyZXR1
cm4gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIHJlZywgdmFsdWUpOwotCXJldHVy
biAwOwotfQotCiBzdGF0aWMgc3RydWN0IGFkbTEwMjFfZGF0YSAqYWRtMTAyMV91cGRhdGVfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0g
dG9faTJjX2NsaWVudChkZXYpOwpAQCAtMzY5LDIxICszOTMsMzkgQEAgc3RhdGljIHN0cnVjdCBh
ZG0xMDIxX2RhdGEgKmFkbTEwMjFfdXBkYQogCiAJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgZGF0
YS0+bGFzdF91cGRhdGVkICsgSFogKyBIWiAvIDIpCiAJICAgIHx8ICFkYXRhLT52YWxpZCkgewor
CQlpbnQgaTsKKwogCQlkZXZfZGJnKCZjbGllbnQtPmRldiwgIlN0YXJ0aW5nIGFkbTEwMjEgdXBk
YXRlXG4iKTsKIAotCQlkYXRhLT50ZW1wX2lucHV0ID0gYWRtMTAyMV9yZWFkX3ZhbHVlKGNsaWVu
dCwgQURNMTAyMV9SRUdfVEVNUCk7Ci0JCWRhdGEtPnRlbXBfbWF4ID0gYWRtMTAyMV9yZWFkX3Zh
bHVlKGNsaWVudCwgQURNMTAyMV9SRUdfVE9TX1IpOwotCQlkYXRhLT50ZW1wX2h5c3QgPSBhZG0x
MDIxX3JlYWRfdmFsdWUoY2xpZW50LCBBRE0xMDIxX1JFR19USFlTVF9SKTsKLQkJZGF0YS0+cmVt
b3RlX3RlbXBfaW5wdXQgPSBhZG0xMDIxX3JlYWRfdmFsdWUoY2xpZW50LCBBRE0xMDIxX1JFR19S
RU1PVEVfVEVNUCk7Ci0JCWRhdGEtPnJlbW90ZV90ZW1wX21heCA9IGFkbTEwMjFfcmVhZF92YWx1
ZShjbGllbnQsIEFETTEwMjFfUkVHX1JFTU9URV9UT1NfUik7Ci0JCWRhdGEtPnJlbW90ZV90ZW1w
X2h5c3QgPSBhZG0xMDIxX3JlYWRfdmFsdWUoY2xpZW50LCBBRE0xMDIxX1JFR19SRU1PVEVfVEhZ
U1RfUik7Ci0JCWRhdGEtPmFsYXJtcyA9IGFkbTEwMjFfcmVhZF92YWx1ZShjbGllbnQsIEFETTEw
MjFfUkVHX1NUQVRVUykgJiAweDdjOworCQlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CisJCQlk
YXRhLT50ZW1wW2ldID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwKKwkJCQkJCUFE
TTEwMjFfUkVHX1RFTVAgKyBpKTsKKwkJCWRhdGEtPnRlbXBfbWF4W2ldID0KKwkJCQlpMmNfc21i
dXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LAorCQkJCQkJQURNMTAyMV9SRUdfVE9TX1IgKyAyICog
aSk7CisJCQlkYXRhLT50ZW1wX21pbltpXSA9CisJCQkJaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRh
KGNsaWVudCwKKwkJCQkJCUFETTEwMjFfUkVHX1RIWVNUX1IgKyAyICogaSk7CisJCX0KKwkJZGF0
YS0+YWxhcm1zID0KKwkJCWkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsCisJCQkJCQlB
RE0xMDIxX1JFR19TVEFUVVMpICYgMHg3YzsKIAkJaWYgKGRhdGEtPnR5cGUgPT0gYWRtMTAyMykg
ewotCQkJZGF0YS0+cmVtb3RlX3RlbXBfcHJlYyA9IGFkbTEwMjFfcmVhZF92YWx1ZShjbGllbnQs
IEFETTEwMjFfUkVHX1JFTV9URU1QX1BSRUMpOwotCQkJZGF0YS0+cmVtb3RlX3RlbXBfb3NfcHJl
YyA9IGFkbTEwMjFfcmVhZF92YWx1ZShjbGllbnQsIEFETTEwMjFfUkVHX1JFTV9UT1NfUFJFQyk7
Ci0JCQlkYXRhLT5yZW1vdGVfdGVtcF9oeXN0X3ByZWMgPSBhZG0xMDIxX3JlYWRfdmFsdWUoY2xp
ZW50LCBBRE0xMDIxX1JFR19SRU1fVEhZU1RfUFJFQyk7Ci0JCQlkYXRhLT5yZW1vdGVfdGVtcF9v
ZmZzZXQgPSBhZG0xMDIxX3JlYWRfdmFsdWUoY2xpZW50LCBBRE0xMDIxX1JFR19SRU1fT0ZGU0VU
KTsKLQkJCWRhdGEtPnJlbW90ZV90ZW1wX29mZnNldF9wcmVjID0gYWRtMTAyMV9yZWFkX3ZhbHVl
KGNsaWVudCwgQURNMTAyMV9SRUdfUkVNX09GRlNFVF9QUkVDKTsKKwkJCWRhdGEtPnJlbW90ZV90
ZW1wX3ByZWMgPQorCQkJCWkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsCisJCQkJCQlB
RE0xMDIzX1JFR19SRU1fVEVNUF9QUkVDKTsKKwkJCWRhdGEtPnJlbW90ZV90ZW1wX29zX3ByZWMg
PQorCQkJCWkyY19zbWJ1c19yZWFkX2J5dGVfZGF0YShjbGllbnQsCisJCQkJCQlBRE0xMDIzX1JF
R19SRU1fVE9TX1BSRUMpOworCQkJZGF0YS0+cmVtb3RlX3RlbXBfaHlzdF9wcmVjID0KKwkJCQlp
MmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LAorCQkJCQkJQURNMTAyM19SRUdfUkVNX1RI
WVNUX1BSRUMpOworCQkJZGF0YS0+cmVtb3RlX3RlbXBfb2Zmc2V0ID0KKwkJCQlpMmNfc21idXNf
cmVhZF9ieXRlX2RhdGEoY2xpZW50LAorCQkJCQkJQURNMTAyM19SRUdfUkVNX09GRlNFVCk7CisJ
CQlkYXRhLT5yZW1vdGVfdGVtcF9vZmZzZXRfcHJlYyA9CisJCQkJaTJjX3NtYnVzX3JlYWRfYnl0
ZV9kYXRhKGNsaWVudCwKKwkJCQkJCUFETTEwMjNfUkVHX1JFTV9PRkZTRVRfUFJFQyk7CiAJCX0K
IAkJZGF0YS0+bGFzdF91cGRhdGVkID0gamlmZmllczsKIAkJZGF0YS0+dmFsaWQgPSAxOwo=

--part4690a7b198588
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--part4690a7b198588--


