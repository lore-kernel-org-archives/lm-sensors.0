From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 22:19:26 +0000
Subject: [lm-sensors] [PATCH 15/17] hwmon: Semaphore to mutex conversions
Message-Id: <20060118231926.542a7b93.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Ingo Molnar <mingo at elte.hu>
Content-Disposition: inline; filename=3Dhwmon-convert-semaphores-to-mutexes=
.patch

convert drivers/hwmon/*.c semaphore use to mutexes.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

all affected hwmon drivers were build-tested.

Signed-off-by: Ingo Molnar <mingo at elte.hu>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
----
 drivers/hwmon/adm1021.c    |   13 ++++---
 drivers/hwmon/adm1025.c    |   25 +++++++------
 drivers/hwmon/adm1026.c    |   87 ++++++++++++++++++++++------------------=
----
 drivers/hwmon/adm1031.c    |   49 +++++++++++++------------
 drivers/hwmon/adm9240.c    |   29 ++++++++-------
 drivers/hwmon/asb100.c     |   45 ++++++++++++-----------
 drivers/hwmon/atxp1.c      |    9 +++--
 drivers/hwmon/ds1621.c     |   13 ++++---
 drivers/hwmon/fscher.c     |   41 +++++++++++----------
 drivers/hwmon/fscpos.c     |   29 ++++++++-------
 drivers/hwmon/gl518sm.c    |   25 +++++++------
 drivers/hwmon/gl520sm.c    |   45 ++++++++++++-----------
 drivers/hwmon/hdaps.c      |   37 ++++++++++---------
 drivers/hwmon/it87.c       |   61 ++++++++++++++++---------------
 drivers/hwmon/lm63.c       |   29 ++++++++-------
 drivers/hwmon/lm75.c       |   13 ++++---
 drivers/hwmon/lm77.c       |   21 ++++++-----
 drivers/hwmon/lm78.c       |   47 ++++++++++++------------
 drivers/hwmon/lm80.c       |   27 +++++++-------
 drivers/hwmon/lm83.c       |   13 ++++---
 drivers/hwmon/lm85.c       |   67 +++++++++++++++++-----------------
 drivers/hwmon/lm87.c       |   39 ++++++++++----------
 drivers/hwmon/lm90.c       |   21 ++++++-----
 drivers/hwmon/lm92.c       |   17 +++++----
 drivers/hwmon/max1619.c    |   13 ++++---
 drivers/hwmon/pc87360.c    |   61 ++++++++++++++++---------------
 drivers/hwmon/sis5595.c    |   47 ++++++++++++------------
 drivers/hwmon/smsc47b397.c |   17 +++++----
 drivers/hwmon/smsc47m1.c   |   41 +++++++++++----------
 drivers/hwmon/via686a.c    |   33 +++++++++--------
 drivers/hwmon/vt8231.c     |   51 +++++++++++++-------------
 drivers/hwmon/w83627ehf.c  |   33 +++++++++--------
 drivers/hwmon/w83627hf.c   |   57 +++++++++++++++--------------
 drivers/hwmon/w83781d.c    |   55 ++++++++++++++--------------
 drivers/hwmon/w83792d.c    |    9 +++--
 drivers/hwmon/w83l785ts.c  |    9 +++--
 36 files changed, 632 insertions(+), 596 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/hwmon/adm1021.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/adm1021.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -26,6 +26,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
=20
 /* Addresses to scan */
@@ -92,7 +93,7 @@
 	struct class_device *class_dev;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -162,10 +163,10 @@
 	struct adm1021_data *data =3D i2c_get_clientdata(client);	\
 	int temp =3D simple_strtoul(buf, NULL, 10);		\
 								\
-	down(&data->update_lock);				\
+	mutex_lock(&data->update_lock);				\
 	data->value =3D TEMP_TO_REG(temp);			\
 	adm1021_write_value(client, reg, data->value);		\
-	up(&data->update_lock);					\
+	mutex_unlock(&data->update_lock);			\
 	return count;						\
 }
 set(temp_max, ADM1021_REG_TOS_W);
@@ -275,7 +276,7 @@
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -351,7 +352,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1021_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -375,7 +376,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/adm1025.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/adm1025.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -53,6 +53,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -133,7 +134,7 @@
 struct adm1025_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -207,11 +208,11 @@
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->in_min[offset] =3D IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
 				  data->in_min[offset]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, struct device_attr=
ibute *attr, const char *buf, \
@@ -221,11 +222,11 @@
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->in_max[offset] =3D IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
 				  data->in_max[offset]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
@@ -247,11 +248,11 @@
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->temp_min[offset-1] =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
 				  data->temp_min[offset-1]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, struct device_at=
tribute *attr, const char *buf, \
@@ -261,11 +262,11 @@
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->temp_max[offset-1] =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
 				  data->temp_max[offset-1]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
@@ -404,7 +405,7 @@
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -523,7 +524,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1025_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int i;
@@ -558,7 +559,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/adm1026.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/adm1026.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -32,6 +32,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END =
};
@@ -260,10 +261,10 @@
 struct adm1026_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
@@ -575,7 +576,7 @@
 	int i;
 	long value, alarms, gpio;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (!data->valid
 	    || time_after(jiffies, data->last_reading + ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
@@ -710,7 +711,7 @@
 	dev_dbg(&client->dev, "Setting VID from GPIO11-15.\n");
 	data->vid =3D (data->gpio >> 11) & 0x1f;
 	data->valid =3D 1;
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return data;
 }
=20
@@ -739,10 +740,10 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[nr], data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;=20
 }
 static ssize_t show_in_max(struct device *dev, struct device_attribute *at=
tr,
@@ -762,10 +763,10 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[nr], data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -813,10 +814,10 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[16] =3D INS_TO_REG(16, val + NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[16], data->in_min[16]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;=20
 }
 static ssize_t show_in16_max(struct device *dev, struct device_attribute *=
attr, char *buf)
@@ -831,10 +832,10 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[16] =3D INS_TO_REG(16, val+NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[16], data->in_max[16]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -874,11 +875,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, data->fan_div[nr]);
 	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
 		data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -939,7 +940,7 @@
 	if (new_div =3D 0) {
 		return -EINVAL;
 	}
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	orig_div =3D data->fan_div[nr];
 	data->fan_div[nr] =3D DIV_FROM_REG(new_div);
=20
@@ -958,7 +959,7 @@
 	if (data->fan_div[nr] !=3D orig_div) {
 		fixup_fan_min(dev,nr,orig_div);
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1001,11 +1002,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MIN[nr],
 		data->temp_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_max(struct device *dev, struct device_attribute *=
attr,
@@ -1025,11 +1026,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MAX[nr],
 		data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1064,11 +1065,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_OFFSET[nr],
 		data->temp_offset[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1115,11 +1116,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_tmin[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_TMIN[nr],
 		data->temp_tmin[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1150,11 +1151,11 @@
 	int val =3D simple_strtol(buf, NULL, 10);
=20
 	if ((val =3D 1) || (val=3D0)) {
-		down(&data->update_lock);
+		mutex_lock(&data->update_lock);
 		data->config1 =3D (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
 		adm1026_write_value(client, ADM1026_REG_CONFIG1,=20
 			data->config1);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 	}
 	return count;
 }
@@ -1184,11 +1185,11 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_THERM[nr],
 		data->temp_crit[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1212,10 +1213,10 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->analog_out =3D DAC_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_DAC, data->analog_out);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1267,7 +1268,7 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	unsigned long mask;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->alarm_mask =3D val & 0x7fffffff;
 	mask =3D data->alarm_mask
 		| (data->gpio_mask & 0x10000 ? 0x80000000 : 0);
@@ -1282,7 +1283,7 @@
 	mask >>=3D 8;
 	adm1026_write_value(client, ADM1026_REG_MASK4,
 		mask & 0xff);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1303,7 +1304,7 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	long   gpio;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->gpio =3D val & 0x1ffff;
 	gpio =3D data->gpio;
 	adm1026_write_value(client, ADM1026_REG_GPIO_STATUS_0_7,gpio & 0xff);
@@ -1311,7 +1312,7 @@
 	adm1026_write_value(client, ADM1026_REG_GPIO_STATUS_8_15,gpio & 0xff);
 	gpio =3D ((gpio >> 1) & 0x80) | (data->alarms >> 24 & 0x7f);
 	adm1026_write_value(client, ADM1026_REG_STATUS4,gpio & 0xff);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1331,7 +1332,7 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	long   mask;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->gpio_mask =3D val & 0x1ffff;
 	mask =3D data->gpio_mask;
 	adm1026_write_value(client, ADM1026_REG_GPIO_MASK_0_7,mask & 0xff);
@@ -1339,7 +1340,7 @@
 	adm1026_write_value(client, ADM1026_REG_GPIO_MASK_8_15,mask & 0xff);
 	mask =3D ((mask >> 1) & 0x80) | (data->alarm_mask >> 24 & 0x7f);
 	adm1026_write_value(client, ADM1026_REG_MASK1,mask & 0xff);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1359,10 +1360,10 @@
 	if (data->pwm1.enable =3D 1) {
 		int val =3D simple_strtol(buf, NULL, 10);
=20
-		down(&data->update_lock);
+		mutex_lock(&data->update_lock);
 		data->pwm1.pwm =3D PWM_TO_REG(val);
 		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 	}
 	return count;
 }
@@ -1378,14 +1379,14 @@
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm1.auto_pwm_min =3D SENSORS_LIMIT(val,0,255);
 	if (data->pwm1.enable =3D 2) { /* apply immediately */
 		data->pwm1.pwm =3D PWM_TO_REG((data->pwm1.pwm & 0x0f) |
 			PWM_MIN_TO_REG(data->pwm1.auto_pwm_min));=20
 		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_auto_pwm_max(struct device *dev, struct device_attribu=
te *attr, char *buf)
@@ -1406,7 +1407,7 @@
 	int     old_enable;
=20
 	if ((val >=3D 0) && (val < 3)) {
-		down(&data->update_lock);
+		mutex_lock(&data->update_lock);
 		old_enable =3D data->pwm1.enable;
 		data->pwm1.enable =3D val;
 		data->config1 =3D (data->config1 & ~CFG1_PWM_AFC)
@@ -1424,7 +1425,7 @@
 			adm1026_write_value(client, ADM1026_REG_PWM,=20
 				data->pwm1.pwm);
 		}
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 	}
 	return count;
 }
@@ -1541,7 +1542,7 @@
 	/* Fill in the remaining client fields */
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
--- linux-2.6.16-rc1.orig/drivers/hwmon/adm1031.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/adm1031.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Following macros takes channel parameter starting from 0 to 2 */
 #define ADM1031_REG_FAN_SPEED(nr)	(0x08 + (nr))
@@ -70,7 +71,7 @@
 struct adm1031_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -262,10 +263,10 @@
=20
 	old_fan_mode =3D data->conf1;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 =09
 	if ((ret =3D get_fan_auto_nearest(data, nr, val, data->conf1, &reg))) {
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return ret;
 	}
 	if (((data->conf1 =3D FAN_CHAN_TO_REG(reg, data->conf1)) & ADM1031_CONF1_=
AUTO_MODE) ^=20
@@ -288,7 +289,7 @@
 	}
 	data->conf1 =3D FAN_CHAN_TO_REG(reg, data->conf1);
 	adm1031_write_value(client, ADM1031_REG_CONF1, data->conf1);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -329,11 +330,11 @@
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->auto_temp[nr] =3D AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->auto_temp[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_auto_temp_max(struct device *dev, char *buf, int nr)
@@ -349,11 +350,11 @@
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr], dat=
a->pwm[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -405,11 +406,11 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	int reg;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) &&=20
 	    (((val>>4) & 0xf) !=3D 5)) {
 		/* In automatic mode, the only PWM accepted is 33% */
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
 	data->pwm[nr] =3D PWM_TO_REG(val);
@@ -417,7 +418,7 @@
 	adm1031_write_value(client, ADM1031_REG_PWM,
 			    nr ? ((data->pwm[nr] << 4) & 0xf0) | (reg & 0xf)
 			    : (data->pwm[nr] & 0xf) | (reg & 0xf0));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -511,7 +512,7 @@
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (val) {
 		data->fan_min[nr] =3D=20
 			FAN_TO_REG(val, FAN_DIV_FROM_REG(data->fan_div[nr]));
@@ -519,7 +520,7 @@
 		data->fan_min[nr] =3D 0xff;
 	}
 	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t
@@ -540,7 +541,7 @@
 	if (tmp =3D 0xff)
 		return -EINVAL;
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	old_div =3D FAN_DIV_FROM_REG(data->fan_div[nr]);
 	data->fan_div[nr] =3D (tmp & 0xC0) | (0x3f & data->fan_div[nr]);
 	new_min =3D data->fan_min[nr] * old_div /=20
@@ -553,7 +554,7 @@
 			    data->fan_div[nr]);
 	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr),=20
 			    data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -627,11 +628,11 @@
=20
 	val =3D simple_strtol(buf, NULL, 10);
 	val =3D SENSORS_LIMIT(val, -55000, nr =3D 0 ? 127750 : 127875);
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MIN(nr),
 			    data->temp_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t
@@ -643,11 +644,11 @@
=20
 	val =3D simple_strtol(buf, NULL, 10);
 	val =3D SENSORS_LIMIT(val, -55000, nr =3D 0 ? 127750 : 127875);
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MAX(nr),
 			    data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t
@@ -659,11 +660,11 @@
=20
 	val =3D simple_strtol(buf, NULL, 10);
 	val =3D SENSORS_LIMIT(val, -55000, nr =3D 0 ? 127750 : 127875);
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] =3D TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_CRIT(nr),
 			    data->temp_crit[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -778,7 +779,7 @@
=20
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -891,7 +892,7 @@
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
 	int chan;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -965,7 +966,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/adm9240.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/adm9240.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -49,6 +49,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -150,7 +151,7 @@
 	enum chips type;
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
 	unsigned long last_updated_config;
@@ -195,11 +196,11 @@
 	struct adm9240_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[attr->index] =3D TEMP_TO_REG(val);
 	i2c_smbus_write_byte_data(client, ADM9240_REG_TEMP_MAX(attr->index),
 			data->temp_max[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -246,11 +247,11 @@
 	struct adm9240_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] =3D IN_TO_REG(val, attr->index);
 	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MIN(attr->index),
 			data->in_min[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -263,11 +264,11 @@
 	struct adm9240_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] =3D IN_TO_REG(val, attr->index);
 	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MAX(attr->index),
 			data->in_max[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -350,7 +351,7 @@
 	int nr =3D attr->index;
 	u8 new_div;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (!val) {
 		data->fan_min[nr] =3D 255;
@@ -390,7 +391,7 @@
 	i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(nr),
 			data->fan_min[nr]);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -439,10 +440,10 @@
 	struct adm9240_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->aout =3D AOUT_TO_REG(val);
 	i2c_smbus_write_byte_data(client, ADM9240_REG_ANALOG_OUT, data->aout);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
@@ -539,7 +540,7 @@
 	/* fill in the remaining client fields and attach */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->type =3D kind;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	if ((err =3D i2c_attach_client(new_client)))
 		goto exit_free;
@@ -691,7 +692,7 @@
 	struct adm9240_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	/* minimum measurement cycle: 1.75 seconds */
 	if (time_after(jiffies, data->last_updated_measure + (HZ * 7 / 4))
@@ -771,7 +772,7 @@
 		data->last_updated_config =3D jiffies;
 		data->valid =3D 1;
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return data;
 }
=20
--- linux-2.6.16-rc1.orig/drivers/hwmon/asb100.c	2006-01-18 18:28:57.000000=
000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/asb100.c	2006-01-18 21:22:35.000000000 +=
0100
@@ -44,6 +44,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/mutex.h>
 #include "lm75.h"
=20
 /*
@@ -182,10 +183,10 @@
 struct asb100_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
=20
 	/* array of 2 pointers to subclients */
@@ -245,11 +246,11 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client); \
 	unsigned long val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
 		data->in_##reg[nr]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
=20
@@ -331,10 +332,10 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	u32 val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -351,7 +352,7 @@
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
 	int reg;
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			DIV_FROM_REG(data->fan_div[nr]));
@@ -381,7 +382,7 @@
 		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -461,7 +462,7 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client); \
 	unsigned long val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	switch (nr) { \
 	case 1: case 2: \
 		data->reg[nr] =3D LM75_TEMP_TO_REG(val); \
@@ -472,7 +473,7 @@
 	} \
 	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
=20
@@ -574,11 +575,11 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm &=3D 0x80; /* keep the enable bit */
 	data->pwm |=3D (0x0f & ASB100_PWM_TO_REG(val));
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -595,11 +596,11 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm &=3D 0x0f; /* keep the duty cycle bits */
 	data->pwm |=3D (val ? 0x80 : 0x00);
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -729,7 +730,7 @@
 	}
=20
 	new_client =3D &data->client;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
 	new_client->adapter =3D adapter;
@@ -789,7 +790,7 @@
 	data->type =3D kind;
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -885,7 +886,7 @@
 	struct i2c_client *cl;
 	int res, bank;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
=20
 	bank =3D (reg >> 8) & 0x0f;
 	if (bank > 2)
@@ -919,7 +920,7 @@
 	if (bank > 2)
 		i2c_smbus_write_byte_data(client, ASB100_REG_BANK, 0);
=20
-	up(&data->lock);
+	mutex_unlock(&data->lock);
=20
 	return res;
 }
@@ -930,7 +931,7 @@
 	struct i2c_client *cl;
 	int bank;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
=20
 	bank =3D (reg >> 8) & 0x0f;
 	if (bank > 2)
@@ -960,7 +961,7 @@
 	if (bank > 2)
 		i2c_smbus_write_byte_data(client, ASB100_REG_BANK, 0);
=20
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 }
=20
 static void asb100_init_client(struct i2c_client *client)
@@ -984,7 +985,7 @@
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 		|| !data->valid) {
@@ -1042,7 +1043,7 @@
 		dev_dbg(&client->dev, "... device update complete\n");
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/atxp1.c	2006-01-18 18:28:57.0000000=
00 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/atxp1.c	2006-01-18 21:22:35.000000000 +0=
100
@@ -26,6 +26,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
@@ -60,7 +61,7 @@
 struct atxp1_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
 	struct {
@@ -80,7 +81,7 @@
 	client =3D to_i2c_client(dev);
 	data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
=20
@@ -93,7 +94,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return(data);
 }
@@ -309,7 +310,7 @@
=20
 	data->valid =3D 0;
=20
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	err =3D i2c_attach_client(new_client);
=20
--- linux-2.6.16-rc1.orig/drivers/hwmon/ds1621.c	2006-01-18 18:28:57.000000=
000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/ds1621.c	2006-01-18 21:22:35.000000000 +=
0100
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include "lm75.h"
=20
 /* Addresses to scan */
@@ -72,7 +73,7 @@
 struct ds1621_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;			/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -156,10 +157,10 @@
 	struct ds1621_data *data =3D ds1621_update_client(dev);		\
 	u16 val =3D LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
 									\
-	down(&data->update_lock);					\
+	mutex_lock(&data->update_lock);					\
 	data->value =3D val;						\
 	ds1621_write_value(client, reg, data->value);			\
-	up(&data->update_lock);						\
+	mutex_unlock(&data->update_lock);				\
 	return count;							\
 }
=20
@@ -242,7 +243,7 @@
 	/* Fill in remaining client fields and put it into the global list */
 	strlcpy(new_client->name, "ds1621", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -297,7 +298,7 @@
 	struct ds1621_data *data =3D i2c_get_clientdata(client);
 	u8 new_conf;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -327,7 +328,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/fscher.c	2006-01-18 18:28:57.000000=
000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/fscher.c	2006-01-18 21:22:35.000000000 +=
0100
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -133,7 +134,7 @@
 struct fscher_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -332,7 +333,7 @@
 	 * global list */
 	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -417,7 +418,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct fscher_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
=20
@@ -457,7 +458,7 @@
 		data->valid =3D 1;                =20
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
@@ -472,10 +473,10 @@
 	/* bits 0..1, 3..7 reserved =3D> mask with 0x04 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x04;
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_status[FAN_INDEX_FROM_NUM(nr)] &=3D ~v;
 	fscher_write_value(client, reg, v);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -490,10 +491,10 @@
 {
 	unsigned long v =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[FAN_INDEX_FROM_NUM(nr)] =3D v > 0xff ? 0xff : v;
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -518,14 +519,14 @@
 		return -EINVAL;
 	}
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	/* bits 2..7 reserved =3D> mask with 0x03 */
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &=3D ~0x03;
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |=3D v;
=20
 	fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -552,10 +553,10 @@
 	/* bits 2..7 reserved, 0 read only =3D> mask with 0x02 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x02;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &=3D ~v;
 	fscher_write_value(client, reg, v);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -609,10 +610,10 @@
 	/* bits 1..7 reserved =3D> mask with 0x01 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x01;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->global_control &=3D ~v;
 	fscher_write_value(client, reg, v);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -631,11 +632,11 @@
 	/* bits 0..3 reserved =3D> mask with 0xf0 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xf0;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->watchdog[2] &=3D ~0xf0;
 	data->watchdog[2] |=3D v;
 	fscher_write_value(client, reg, data->watchdog[2]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -651,10 +652,10 @@
 	/* bits 0, 2..7 reserved =3D> mask with 0x02 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x02;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->watchdog[1] &=3D ~v;
 	fscher_write_value(client, reg, v);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -669,10 +670,10 @@
 {
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xff;
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->watchdog[0] =3D v;
 	fscher_write_value(client, reg, data->watchdog[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
--- linux-2.6.16-rc1.orig/drivers/hwmon/fscpos.c	2006-01-18 18:28:57.000000=
000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/fscpos.c	2006-01-18 21:22:35.000000000 +=
0100
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -114,7 +115,7 @@
 struct fscpos_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; 		/* 0 until following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -208,13 +209,13 @@
 		return -EINVAL;
 	}
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	/* bits 2..7 reserved =3D> mask with 0x03 */
 	data->fan_ripple[nr - 1] &=3D ~0x03;
 	data->fan_ripple[nr - 1] |=3D v;
 =09
 	fscpos_write_value(client, reg, data->fan_ripple[nr - 1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -232,10 +233,10 @@
 	if (v < 0) v =3D 0;
 	if (v > 255) v =3D 255;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[nr - 1] =3D v;
 	fscpos_write_value(client, reg, data->pwm[nr - 1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -278,11 +279,11 @@
 	/* bits 0..3 reserved =3D> mask with 0xf0 */
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xf0;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->wdog_control &=3D ~0xf0;
 	data->wdog_control |=3D v;
 	fscpos_write_value(client, reg, data->wdog_control);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -304,10 +305,10 @@
 		return -EINVAL;
 	}
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->wdog_state &=3D ~v;
 	fscpos_write_value(client, reg, v);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -321,10 +322,10 @@
 {
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xff;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->wdog_preset =3D v;
 	fscpos_write_value(client, reg, data->wdog_preset);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -483,7 +484,7 @@
 	strlcpy(new_client->name, "fscpos", I2C_NAME_SIZE);
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -579,7 +580,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct fscpos_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		int i;
@@ -625,7 +626,7 @@
 		data->last_updated =3D jiffies;
 		data->valid =3D 1;
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return data;
 }
=20
--- linux-2.6.16-rc1.orig/drivers/hwmon/gl518sm.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/gl518sm.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -43,6 +43,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, I2C_CLIENT_END };
@@ -120,7 +121,7 @@
 	struct class_device *class_dev;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -212,10 +213,10 @@
 	struct gl518_data *data =3D i2c_get_clientdata(client);		\
 	long val =3D simple_strtol(buf, NULL, 10);			\
 									\
-	down(&data->update_lock);					\
+	mutex_lock(&data->update_lock);					\
 	data->value =3D type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
-	up(&data->update_lock);						\
+	mutex_unlock(&data->update_lock);				\
 	return count;							\
 }
=20
@@ -228,12 +229,12 @@
 	int regvalue;							\
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);		\
 									\
-	down(&data->update_lock);					\
+	mutex_lock(&data->update_lock);					\
 	regvalue =3D gl518_read_value(client, reg);			\
 	data->value =3D type##_TO_REG(val);				\
 	regvalue =3D (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
-	up(&data->update_lock);						\
+	mutex_unlock(&data->update_lock);				\
 	return count;							\
 }
=20
@@ -265,7 +266,7 @@
 	int regvalue;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
 	data->fan_min[0] =3D FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[0]));
@@ -280,7 +281,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -291,7 +292,7 @@
 	int regvalue;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
 	data->fan_min[1] =3D FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[1]));
@@ -306,7 +307,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -407,7 +408,7 @@
 	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -525,7 +526,7 @@
 	struct gl518_data *data =3D i2c_get_clientdata(client);
 	int val;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -586,7 +587,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/gl520sm.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/gl520sm.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -29,6 +29,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Type of the extra sensor */
 static unsigned short extra_sensor_type;
@@ -121,7 +122,7 @@
 struct gl520_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
=20
@@ -303,7 +304,7 @@
 	long v =3D simple_strtol(buf, NULL, 10);
 	u8 r;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (n =3D 0)
 		r =3D VDD_TO_REG(v);
@@ -317,7 +318,7 @@
 	else
 		gl520_write_value(client, reg, r);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -331,7 +332,7 @@
 	else
 		r =3D IN_TO_REG(v);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	data->in_max[n] =3D r;
=20
@@ -340,7 +341,7 @@
 	else
 		gl520_write_value(client, reg, r);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -373,7 +374,7 @@
 	unsigned long v =3D simple_strtoul(buf, NULL, 10);
 	u8 r;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	r =3D FAN_TO_REG(v, data->fan_div[n - 1]);
 	data->fan_min[n - 1] =3D r;
=20
@@ -390,7 +391,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -409,7 +410,7 @@
 		return -EINVAL;
 	}
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_div[n - 1] =3D r;
=20
 	if (n =3D 1)
@@ -417,7 +418,7 @@
 	else
 		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) |=
 (r << 4));
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -425,10 +426,10 @@
 {
 	u8 r =3D simple_strtoul(buf, NULL, 10)?1:0;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_off =3D r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | =
(r << 2));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -454,10 +455,10 @@
 {
 	long v =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[n - 1] =3D TEMP_TO_REG(v);;
 	gl520_write_value(client, reg, data->temp_max[n - 1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -465,10 +466,10 @@
 {
 	long v =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max_hyst[n - 1] =3D TEMP_TO_REG(v);
 	gl520_write_value(client, reg, data->temp_max_hyst[n - 1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -491,10 +492,10 @@
 {
 	u8 r =3D simple_strtoul(buf, NULL, 10)?0:1;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->beep_enable =3D !r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | =
(r << 2));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -502,11 +503,11 @@
 {
 	u8 r =3D simple_strtoul(buf, NULL, 10);
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	r &=3D data->alarm_mask;
 	data->beep_mask =3D r;
 	gl520_write_value(client, reg, r);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -561,7 +562,7 @@
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "gl520sm", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -685,7 +686,7 @@
 	struct gl520_data *data =3D i2c_get_clientdata(client);
 	int val;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
=20
@@ -750,7 +751,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/hdaps.c	2006-01-18 18:23:03.0000000=
00 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/hdaps.c	2006-01-18 21:22:35.000000000 +0=
100
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/dmi.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 #define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
@@ -70,10 +71,10 @@
 static int rest_x;
 static int rest_y;
=20
-static DECLARE_MUTEX(hdaps_sem);
+static DEFINE_MUTEX(hdaps_mutex);
=20
 /*
- * __get_latch - Get the value from a given port.  Callers must hold hdaps=
_sem.
+ * __get_latch - Get the value from a given port.  Callers must hold hdaps=
_mutex.
  */
 static inline u8 __get_latch(u16 port)
 {
@@ -82,7 +83,7 @@
=20
 /*
  * __check_latch - Check a port latch for a given value.  Returns zero if =
the
- * port contains the given value.  Callers must hold hdaps_sem.
+ * port contains the given value.  Callers must hold hdaps_mutex.
  */
 static inline int __check_latch(u16 port, u8 val)
 {
@@ -93,7 +94,7 @@
=20
 /*
  * __wait_latch - Wait up to 100us for a port latch to get a certain value,
- * returning zero if the value is obtained.  Callers must hold hdaps_sem.
+ * returning zero if the value is obtained.  Callers must hold hdaps_mutex.
  */
 static int __wait_latch(u16 port, u8 val)
 {
@@ -110,7 +111,7 @@
=20
 /*
  * __device_refresh - request a refresh from the accelerometer.  Does not =
wait
- * for refresh to complete.  Callers must hold hdaps_sem.
+ * for refresh to complete.  Callers must hold hdaps_mutex.
  */
 static void __device_refresh(void)
 {
@@ -124,7 +125,7 @@
 /*
  * __device_refresh_sync - request a synchronous refresh from the
  * accelerometer.  We wait for the refresh to complete.  Returns zero if
- * successful and nonzero on error.  Callers must hold hdaps_sem.
+ * successful and nonzero on error.  Callers must hold hdaps_mutex.
  */
 static int __device_refresh_sync(void)
 {
@@ -134,7 +135,7 @@
=20
 /*
  * __device_complete - indicate to the accelerometer that we are done read=
ing
- * data, and then initiate an async refresh.  Callers must hold hdaps_sem.
+ * data, and then initiate an async refresh.  Callers must hold hdaps_mute=
x.
  */
 static inline void __device_complete(void)
 {
@@ -152,7 +153,7 @@
 {
 	int ret;
=20
-	down(&hdaps_sem);
+	mutex_lock(&hdaps_mutex);
=20
 	/* do a sync refresh -- we need to be sure that we read fresh data */
 	ret =3D __device_refresh_sync();
@@ -163,7 +164,7 @@
 	__device_complete();
=20
 out:
-	up(&hdaps_sem);
+	mutex_unlock(&hdaps_mutex);
 	return ret;
 }
=20
@@ -198,9 +199,9 @@
 {
 	int ret;
=20
-	down(&hdaps_sem);
+	mutex_lock(&hdaps_mutex);
 	ret =3D __hdaps_read_pair(port1, port2, val1, val2);
-	up(&hdaps_sem);
+	mutex_unlock(&hdaps_mutex);
=20
 	return ret;
 }
@@ -213,7 +214,7 @@
 {
 	int total, ret =3D -ENXIO;
=20
-	down(&hdaps_sem);
+	mutex_lock(&hdaps_mutex);
=20
 	outb(0x13, 0x1610);
 	outb(0x01, 0x161f);
@@ -279,7 +280,7 @@
 	}
=20
 out:
-	up(&hdaps_sem);
+	mutex_unlock(&hdaps_mutex);
 	return ret;
 }
=20
@@ -313,7 +314,7 @@
 };
=20
 /*
- * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_se=
m.
+ * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_mu=
tex.
  */
 static void hdaps_calibrate(void)
 {
@@ -325,7 +326,7 @@
 	int x, y;
=20
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
-	if (down_trylock(&hdaps_sem)) {
+	if (!mutex_trylock(&hdaps_mutex)) {
 		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
 		return;
 	}
@@ -340,7 +341,7 @@
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
=20
 out:
-	up(&hdaps_sem);
+	mutex_unlock(&hdaps_mutex);
 }
=20
=20
@@ -420,9 +421,9 @@
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	down(&hdaps_sem);
+	mutex_lock(&hdaps_mutex);
 	hdaps_calibrate();
-	up(&hdaps_sem);
+	mutex_unlock(&hdaps_mutex);
=20
 	return count;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/it87.c	2006-01-18 20:59:10.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/it87.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -41,6 +41,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
=20
@@ -194,10 +195,10 @@
 struct it87_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -290,11 +291,11 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr),=20
 			data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, struct device_attribute *att=
r,
@@ -307,11 +308,11 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr),=20
 			data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -381,10 +382,10 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *a=
ttr,
@@ -397,10 +398,10 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -440,7 +441,7 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	data->sensor &=3D ~(1 << nr);
 	data->sensor &=3D ~(8 << nr);
@@ -450,11 +451,11 @@
 	else if (val =3D 2)
 	    data->sensor |=3D 8 << nr;
 	else if (val !=3D 0) {
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_sensor_offset(offset)					\
@@ -524,7 +525,7 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	u8 reg =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	switch (nr) {
 	case 0: data->fan_div[nr] =3D reg & 0x07; break;
 	case 1: data->fan_div[nr] =3D (reg >> 3) & 0x07; break;
@@ -533,7 +534,7 @@
=20
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *at=
tr,
@@ -548,7 +549,7 @@
 	int i, min[3];
 	u8 old;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
 	for (i =3D 0; i < 3; i++)
@@ -576,7 +577,7 @@
 		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
 		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm_enable(struct device *dev,
@@ -589,7 +590,7 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (val =3D 0) {
 		int tmp;
@@ -606,11 +607,11 @@
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
 	} else {
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
@@ -626,11 +627,11 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->manual_pwm_ctl[nr] =3D val;
 	if (data->fan_main_ctrl & (1 << nr))
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -776,7 +777,7 @@
=20
 	new_client =3D &data->client;
 	if (is_isa)
-		init_MUTEX(&data->lock);
+		mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
 	new_client->adapter =3D adapter;
@@ -823,7 +824,7 @@
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -950,10 +951,10 @@
=20
 	int res;
 	if (i2c_is_isa_client(client)) {
-		down(&data->lock);
+		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
 		res =3D inb_p(client->addr + IT87_DATA_REG_OFFSET);
-		up(&data->lock);
+		mutex_unlock(&data->lock);
 		return res;
 	} else
 		return i2c_smbus_read_byte_data(client, reg);
@@ -969,10 +970,10 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
=20
 	if (i2c_is_isa_client(client)) {
-		down(&data->lock);
+		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
 		outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
-		up(&data->lock);
+		mutex_unlock(&data->lock);
 		return 0;
 	} else
 		return i2c_smbus_write_byte_data(client, reg, value);
@@ -1098,7 +1099,7 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -1160,7 +1161,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm63.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm63.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -45,6 +45,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -153,7 +154,7 @@
 struct lm63_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -192,13 +193,13 @@
 	struct lm63_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan[1] =3D FAN_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_LSB,
 				  data->fan[1] & 0xFF);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_MSB,
 				  data->fan[1] >> 8);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -222,12 +223,12 @@
 		return -EPERM;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm1_value =3D val <=3D 0 ? 0 :
 			   val >=3D 255 ? 2 * data->pwm1_freq :
 			   (val * data->pwm1_freq * 2 + 127) / 255;
 	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -253,10 +254,10 @@
 	struct lm63_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp8[1] =3D TEMP8_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM63_REG_LOCAL_HIGH, data->temp8[1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -284,13 +285,13 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	int nr =3D attr->index;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp11[nr] =3D TEMP11_TO_REG(val);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
 				  data->temp11[nr] & 0xff);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -314,11 +315,11 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	long hyst;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	hyst =3D TEMP8_FROM_REG(data->temp8[2]) - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -427,7 +428,7 @@
=20
 	strlcpy(new_client->name, "lm63", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -530,7 +531,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm63_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
@@ -582,7 +583,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm75.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm75.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include "lm75.h"
=20
=20
@@ -47,7 +48,7 @@
 struct lm75_data {
 	struct i2c_client	client;
 	struct class_device *class_dev;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 	char			valid;		/* !=3D0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
 	u16			temp_input;	/* Register values */
@@ -91,10 +92,10 @@
 	struct lm75_data *data =3D i2c_get_clientdata(client);	\
 	int temp =3D simple_strtoul(buf, NULL, 10);		\
 								\
-	down(&data->update_lock);				\
+	mutex_lock(&data->update_lock);				\
 	data->value =3D LM75_TEMP_TO_REG(temp);			\
 	lm75_write_value(client, reg, data->value);		\
-	up(&data->update_lock);					\
+	mutex_unlock(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, LM75_REG_TEMP_OS);
@@ -188,7 +189,7 @@
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -264,7 +265,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm75_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -277,7 +278,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm77.c	2006-01-18 19:53:58.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm77.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIEN=
T_END };
@@ -51,7 +52,7 @@
 struct lm77_data {
 	struct i2c_client	client;
 	struct class_device *class_dev;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
 	int			temp_input;	/* Temperatures */
@@ -139,10 +140,10 @@
 	struct lm77_data *data =3D i2c_get_clientdata(client);			\
 	long val =3D simple_strtoul(buf, NULL, 10);				\
 										\
-	down(&data->update_lock);						\
+	mutex_lock(&data->update_lock);						\
 	data->value =3D val;				\
 	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));		\
-	up(&data->update_lock);							\
+	mutex_unlock(&data->update_lock);					\
 	return count;								\
 }
=20
@@ -157,11 +158,11 @@
 	struct lm77_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_hyst =3D data->temp_crit - val;
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -173,7 +174,7 @@
 	long val =3D simple_strtoul(buf, NULL, 10);
 	int oldcrithyst;
 =09
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	oldcrithyst =3D data->temp_crit - data->temp_hyst;
 	data->temp_crit =3D val;
 	data->temp_hyst =3D data->temp_crit - oldcrithyst;
@@ -181,7 +182,7 @@
 			 LM77_TEMP_TO_REG(data->temp_crit));
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -306,7 +307,7 @@
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -380,7 +381,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm77_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -406,7 +407,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm78.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm78.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -27,6 +27,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 /* Addresses to scan */
@@ -131,10 +132,10 @@
 struct lm78_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -207,10 +208,10 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MIN(nr), data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -221,10 +222,10 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MAX(nr), data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 =09
@@ -288,10 +289,10 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_over =3D TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_OVER, data->temp_over);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -307,10 +308,10 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_hyst =3D TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_HYST, data->temp_hyst);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -342,10 +343,10 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -368,7 +369,7 @@
 	unsigned long min;
 	u8 reg;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
=20
@@ -380,7 +381,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -398,7 +399,7 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -548,7 +549,7 @@
=20
 	new_client =3D &data->client;
 	if (is_isa)
-		init_MUTEX(&data->lock);
+		mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
 	new_client->adapter =3D adapter;
@@ -598,7 +599,7 @@
 	data->type =3D kind;
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -697,10 +698,10 @@
 	int res;
 	if (i2c_is_isa_client(client)) {
 		struct lm78_data *data =3D i2c_get_clientdata(client);
-		down(&data->lock);
+		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
 		res =3D inb_p(client->addr + LM78_DATA_REG_OFFSET);
-		up(&data->lock);
+		mutex_unlock(&data->lock);
 		return res;
 	} else
 		return i2c_smbus_read_byte_data(client, reg);
@@ -717,10 +718,10 @@
 {
 	if (i2c_is_isa_client(client)) {
 		struct lm78_data *data =3D i2c_get_clientdata(client);
-		down(&data->lock);
+		mutex_lock(&data->lock);
 		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
 		outb_p(value, client->addr + LM78_DATA_REG_OFFSET);
-		up(&data->lock);
+		mutex_unlock(&data->lock);
 		return 0;
 	} else
 		return i2c_smbus_write_byte_data(client, reg, value);
@@ -742,7 +743,7 @@
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -786,7 +787,7 @@
 		data->fan_div[2] =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm80.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm80.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
@@ -108,7 +109,7 @@
 struct lm80_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -191,10 +192,10 @@
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock);\
+	mutex_lock(&data->update_lock);\
 	data->value =3D IN_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
-	up(&data->update_lock);\
+	mutex_unlock(&data->update_lock);\
 	return count; \
 }
 set_in(min0, in_min[0], LM80_REG_IN_MIN(0));
@@ -241,10 +242,10 @@
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock);\
+	mutex_lock(&data->update_lock);\
 	data->value =3D FAN_TO_REG(val, DIV_FROM_REG(data->div)); \
 	lm80_write_value(client, reg, data->value); \
-	up(&data->update_lock);\
+	mutex_unlock(&data->update_lock);\
 	return count; \
 }
 set_fan(min1, fan_min[0], LM80_REG_FAN_MIN(1), fan_div[0]);
@@ -263,7 +264,7 @@
 	u8 reg;
=20
 	/* Save fan_min */
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
=20
@@ -275,7 +276,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -286,7 +287,7 @@
 	/* Restore fan_min */
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -325,10 +326,10 @@
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->value =3D TEMP_LIMIT_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 set_temp(hot_max, temp_hot_max, LM80_REG_TEMP_HOT_MAX);
@@ -437,7 +438,7 @@
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -545,7 +546,7 @@
 	struct lm80_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
@@ -585,7 +586,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm83.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm83.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -35,6 +35,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -139,7 +140,7 @@
 struct lm83_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -171,11 +172,11 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	int nr =3D attr->index;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp[nr] =3D TEMP_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM83_REG_W_HIGH[nr - 4],
 				  data->temp[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -300,7 +301,7 @@
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -373,7 +374,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm83_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int nr;
@@ -393,7 +394,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm85.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm85.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -31,6 +31,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END =
};
@@ -331,10 +332,10 @@
 struct lm85_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
@@ -407,10 +408,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val);
 	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -499,10 +500,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[nr] =3D PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_PWM(nr), data->pwm[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_pwm_enable(struct device *dev, char *buf, int nr)
@@ -559,10 +560,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MIN(nr), data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_in_max(struct device *dev, char *buf, int nr)
@@ -577,10 +578,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MAX(nr), data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_in_reg(offset)						\
@@ -640,10 +641,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), data->temp_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
@@ -658,10 +659,10 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);=09
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_temp_reg(offset)						\
@@ -713,12 +714,12 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);  =20
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->autofan[nr].config =3D (data->autofan[nr].config & (~0xe0))
 		| ZONE_TO_REG(val) ;
 	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
 		data->autofan[nr].config);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_pwm_auto_pwm_min(struct device *dev, char *buf, int nr)
@@ -733,11 +734,11 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_pwm =3D PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_MINPWM(nr),
 		data->autofan[nr].min_pwm);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_pwm_auto_pwm_minctl(struct device *dev, char *buf, int=
 nr)
@@ -752,7 +753,7 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_off =3D val;
 	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
 		| data->syncpwm3
@@ -760,7 +761,7 @@
 		| (data->autofan[1].min_off ? 0x40 : 0)
 		| (data->autofan[2].min_off ? 0x80 : 0)
 	);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_pwm_auto_pwm_freq(struct device *dev, char *buf, int n=
r)
@@ -775,13 +776,13 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->autofan[nr].freq =3D FREQ_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		(data->zone[nr].range << 4)
 		| data->autofan[nr].freq
 	);=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define pwm_auto(offset)						\
@@ -857,7 +858,7 @@
 	int min;
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D TEMP_FROM_REG(data->zone[nr].limit);
 	data->zone[nr].off_desired =3D TEMP_TO_REG(val);
 	data->zone[nr].hyst =3D HYST_TO_REG(min - val);
@@ -871,7 +872,7 @@
 			(data->zone[2].hyst << 4)
 		);
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_auto_temp_min(struct device *dev, char *buf, int =
nr)
@@ -886,7 +887,7 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->zone[nr].limit =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
@@ -913,7 +914,7 @@
 			(data->zone[2].hyst << 4)
 		);
 	}
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_auto_temp_max(struct device *dev, char *buf, int =
nr)
@@ -930,7 +931,7 @@
 	int min;
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D TEMP_FROM_REG(data->zone[nr].limit);
 	data->zone[nr].max_desired =3D TEMP_TO_REG(val);
 	data->zone[nr].range =3D RANGE_TO_REG(
@@ -938,7 +939,7 @@
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
 		| (data->autofan[nr].freq & 0x07));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t show_temp_auto_temp_crit(struct device *dev, char *buf, int=
 nr)
@@ -953,11 +954,11 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->zone[nr].critical =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
 		data->zone[nr].critical);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define temp_auto(offset)						\
@@ -1149,7 +1150,7 @@
 	/* Fill in the remaining client fields */
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -1368,7 +1369,7 @@
 	struct lm85_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if ( !data->valid ||
 	     time_after(jiffies, data->last_reading + LM85_DATA_INTERVAL) ) {
@@ -1571,7 +1572,7 @@
=20
 	data->valid =3D 1;
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm87.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm87.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -60,6 +60,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -176,7 +177,7 @@
 struct lm87_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
=20
@@ -253,11 +254,11 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
 			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
=20
 static void set_in_max(struct device *dev, const char *buf, int nr)
@@ -266,11 +267,11 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
 			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
=20
 #define set_in(offset) \
@@ -327,10 +328,10 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
=20
 static void set_temp_high(struct device *dev, const char *buf, int nr)
@@ -339,10 +340,10 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
=20
 #define set_temp(offset) \
@@ -411,11 +412,11 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val,
 			    FAN_DIV_FROM_REG(data->fan_div[nr]));
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 }
=20
 /* Note: we save and restore the fan minimum here, because its value is
@@ -431,7 +432,7 @@
 	unsigned long min;
 	u8 reg;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   FAN_DIV_FROM_REG(data->fan_div[nr]));
=20
@@ -441,7 +442,7 @@
 	case 4: data->fan_div[nr] =3D 2; break;
 	case 8: data->fan_div[nr] =3D 3; break;
 	default:
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -459,7 +460,7 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
 			 data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -522,10 +523,10 @@
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->aout =3D AOUT_TO_REG(val);
 	lm87_write_value(client, LM87_REG_AOUT, data->aout);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
@@ -589,7 +590,7 @@
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, "lm87", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -744,7 +745,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		int i, j;
@@ -813,7 +814,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm90.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm90.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -78,6 +78,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /*
  * Addresses to scan
@@ -201,7 +202,7 @@
 struct lm90_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	int kind;
@@ -247,13 +248,13 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	int nr =3D attr->index;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (data->kind =3D adt7461)
 		data->temp8[nr] =3D TEMP1_TO_REG_ADT7461(val);
 	else
 		data->temp8[nr] =3D TEMP1_TO_REG(val);
 	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -281,7 +282,7 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	int nr =3D attr->index;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (data->kind =3D adt7461)
 		data->temp11[nr] =3D TEMP2_TO_REG_ADT7461(val);
 	else
@@ -290,7 +291,7 @@
 				  data->temp11[nr] >> 8);
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
 				  data->temp11[nr] & 0xff);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -311,11 +312,11 @@
 	long val =3D simple_strtol(buf, NULL, 10);
 	long hyst;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	hyst =3D TEMP1_FROM_REG(data->temp8[3]) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -558,7 +559,7 @@
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
 	data->kind =3D kind;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -646,7 +647,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm90_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		u8 oldh, newh, l;
@@ -692,7 +693,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/lm92.c	2006-01-18 18:28:57.00000000=
0 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/lm92.c	2006-01-18 21:22:35.000000000 +01=
00
@@ -46,6 +46,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* The LM92 and MAX6635 have 2 two-state pins for address selection,
    resulting in 4 possible addresses. */
@@ -96,7 +97,7 @@
 struct lm92_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -114,7 +115,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm92_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ)
 	 || !data->valid) {
@@ -134,7 +135,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
@@ -158,10 +159,10 @@
 	struct lm92_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->value =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_word_data(client, reg, swab16(data->value)); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
@@ -194,11 +195,11 @@
 	struct lm92_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp1_hyst =3D TEMP_FROM_REG(data->temp1_crit) - val;
 	i2c_smbus_write_word_data(client, LM92_REG_TEMP_HYST,
 				  swab16(TEMP_TO_REG(data->temp1_hyst)));
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -348,7 +349,7 @@
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the i2c subsystem a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
--- linux-2.6.16-rc1.orig/drivers/hwmon/max1619.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/max1619.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 static unsigned short normal_i2c[] =3D { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,
@@ -104,7 +105,7 @@
 struct max1619_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -141,10 +142,10 @@
 	struct max1619_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->value =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
=20
@@ -262,7 +263,7 @@
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -330,7 +331,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct max1619_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Updating max1619 data.\n");
@@ -353,7 +354,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/pc87360.c	2006-01-18 19:54:03.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/pc87360.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -43,6 +43,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 static u8 devid;
@@ -183,8 +184,8 @@
 struct pc87360_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
-	struct semaphore update_lock;
+	struct mutex lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -283,7 +284,7 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long fan_min =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	fan_min =3D FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[attr->i=
ndex]));
=20
 	/* If it wouldn't fit, change clock divisor */
@@ -300,7 +301,7 @@
 	/* Write new divider, preserve alarm bits */
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(attr->i=
ndex),
 			    data->fan_status[attr->index] & 0xF9);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -343,12 +344,12 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[attr->index] =3D PWM_TO_REG(val,
 			      FAN_CONFIG_INVERT(data->fan_conf, attr->index));
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index),
 			    data->pwm[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -393,11 +394,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] =3D IN_TO_REG(val, data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN,
 			    data->in_min[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, struct device_attribute *dev=
attr, const char *buf,
@@ -408,12 +409,12 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] =3D IN_TO_REG(val,
 			       data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX,
 			    data->in_max[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -512,11 +513,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[attr->index] =3D IN_TO_REG(val, data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_MIN,
 			    data->in_min[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_therm_max(struct device *dev, struct device_attribute *=
devattr, const char *buf,
@@ -527,11 +528,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[attr->index] =3D IN_TO_REG(val, data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_MAX,
 			    data->in_max[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_therm_crit(struct device *dev, struct device_attribute =
*devattr, const char *buf,
@@ -542,11 +543,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_crit[attr->index-11] =3D IN_TO_REG(val, data->in_vref);
 	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_CRIT,
 			    data->in_crit[attr->index-11]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -654,11 +655,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[attr->index] =3D TEMP_TO_REG(val);
 	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MIN,
 			    data->temp_min[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_max(struct device *dev, struct device_attribute *d=
evattr, const char *buf,
@@ -669,11 +670,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[attr->index] =3D TEMP_TO_REG(val);
 	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MAX,
 			    data->temp_max[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_crit(struct device *dev, struct device_attribute *=
devattr, const char *buf,
@@ -684,11 +685,11 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_crit[attr->index] =3D TEMP_TO_REG(val);
 	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_CRIT,
 			    data->temp_crit[attr->index]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -845,7 +846,7 @@
 	dev =3D &client->dev;
 	i2c_set_clientdata(client, data);
 	client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	client->adapter =3D adapter;
 	client->driver =3D &pc87360_driver;
 	client->flags =3D 0;
@@ -878,7 +879,7 @@
=20
 	strlcpy(client->name, name, sizeof(client->name));
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	for (i =3D 0; i < 3; i++) {
 		if (((data->address[i] =3D extra_isa[i]))
@@ -1027,11 +1028,11 @@
 {
 	int res;
=20
-	down(&(data->lock));
+	mutex_lock(&(data->lock));
 	if (bank !=3D NO_BANK)
 		outb_p(bank, data->address[ldi] + PC87365_REG_BANK);
 	res =3D inb_p(data->address[ldi] + reg);
-	up(&(data->lock));
+	mutex_unlock(&(data->lock));
=20
 	return res;
 }
@@ -1039,11 +1040,11 @@
 static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
 				u8 reg, u8 value)
 {
-	down(&(data->lock));
+	mutex_lock(&(data->lock));
 	if (bank !=3D NO_BANK)
 		outb_p(bank, data->address[ldi] + PC87365_REG_BANK);
 	outb_p(value, data->address[ldi] + reg);
-	up(&(data->lock));
+	mutex_unlock(&(data->lock));
 }
=20
 static void pc87360_init_client(struct i2c_client *client, int use_thermis=
tors)
@@ -1215,7 +1216,7 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	u8 i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		dev_dbg(&client->dev, "Data update\n");
@@ -1315,7 +1316,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/sis5595.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/sis5595.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -60,6 +60,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
=20
@@ -167,9 +168,9 @@
 struct sis5595_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	char maxins;		/* =3D 3 if temp enabled, otherwise =3D 4 */
@@ -231,10 +232,10 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -245,10 +246,10 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -310,10 +311,10 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_over =3D TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_OVER, data->temp_over);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -329,10 +330,10 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_hyst =3D TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_HYST, data->temp_hyst);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -364,10 +365,10 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -390,7 +391,7 @@
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
 	int reg;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			DIV_FROM_REG(data->fan_div[nr]));
 	reg =3D sis5595_read_value(client, SIS5595_REG_FANDIV);
@@ -403,7 +404,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
 =09
@@ -419,7 +420,7 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -527,7 +528,7 @@
=20
 	new_client =3D &data->client;
 	new_client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &sis5595_driver;
@@ -548,7 +549,7 @@
 	strlcpy(new_client->name, "sis5595", I2C_NAME_SIZE);
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -635,20 +636,20 @@
 	int res;
=20
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb_p(reg, client->addr + SIS5595_ADDR_REG_OFFSET);
 	res =3D inb_p(client->addr + SIS5595_DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return res;
 }
=20
 static int sis5595_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb_p(reg, client->addr + SIS5595_ADDR_REG_OFFSET);
 	outb_p(value, client->addr + SIS5595_DATA_REG_OFFSET);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return 0;
 }
=20
@@ -667,7 +668,7 @@
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -707,7 +708,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/smsc47b397.c	2006-01-18 18:28:57.00=
0000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/smsc47b397.c	2006-01-18 21:22:35.0000000=
00 +0100
@@ -35,6 +35,7 @@
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 /* Address is autodetected, there is no default value */
@@ -92,9 +93,9 @@
 struct smsc47b397_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated; /* in jiffies */
 	int valid;
=20
@@ -108,10 +109,10 @@
 	struct smsc47b397_data *data =3D i2c_get_clientdata(client);
 	int res;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	outb(reg, client->addr);
 	res =3D inb_p(client->addr + 1);
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return res;
 }
=20
@@ -121,7 +122,7 @@
 	struct smsc47b397_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		dev_dbg(&client->dev, "starting device update...\n");
@@ -144,7 +145,7 @@
 		dev_dbg(&client->dev, "... device update complete\n");
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
@@ -254,14 +255,14 @@
 	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &smsc47b397_driver;
 	new_client->flags =3D 0;
=20
 	strlcpy(new_client->name, "smsc47b397", I2C_NAME_SIZE);
=20
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	if ((err =3D i2c_attach_client(new_client)))
 		goto error_free;
--- linux-2.6.16-rc1.orig/drivers/hwmon/smsc47m1.c	2006-01-18 18:28:57.0000=
00000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/smsc47m1.c	2006-01-18 21:22:35.000000000=
 +0100
@@ -34,6 +34,7 @@
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 /* Address is autodetected, there is no default value */
@@ -102,9 +103,9 @@
 struct smsc47m1_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
=20
 	u8 fan[2];		/* Register value */
@@ -188,18 +189,18 @@
 	struct smsc47m1_data *data =3D i2c_get_clientdata(client);
 	long rpmdiv, val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	rpmdiv =3D val * DIV_FROM_REG(data->fan_div[nr]);
=20
 	if (983040 > 192 * rpmdiv || 2 * rpmdiv > 983040) {
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
 	data->fan_preload[nr] =3D 192 - ((983040 + rpmdiv / 2) / rpmdiv);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -220,14 +221,14 @@
 	if (new_div =3D old_div) /* No change */
 		return count;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	switch (new_div) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
 	case 4: data->fan_div[nr] =3D 2; break;
 	case 8: data->fan_div[nr] =3D 3; break;
 	default:
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -241,7 +242,7 @@
 	data->fan_preload[nr] =3D SENSORS_LIMIT(tmp, 0, 191);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -257,12 +258,12 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[nr] &=3D 0x81; /* Preserve additional bits */
 	data->pwm[nr] |=3D PWM_TO_REG(val);
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -278,12 +279,12 @@
 	if (val !=3D 0 && val !=3D 1)
 		return -EINVAL;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[nr] &=3D 0xFE; /* preserve the other bits */
 	data->pwm[nr] |=3D !val;
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -408,13 +409,13 @@
 	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &smsc47m1_driver;
 	new_client->flags =3D 0;
=20
 	strlcpy(new_client->name, "smsc47m1", I2C_NAME_SIZE);
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* If no function is properly configured, there's no point in
 	   actually registering the chip. */
@@ -512,17 +513,17 @@
 {
 	int res;
=20
-	down(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
+	mutex_lock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
 	res =3D inb_p(client->addr + reg);
-	up(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
+	mutex_unlock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock=
);
 	return res;
 }
=20
 static void smsc47m1_write_value(struct i2c_client *client, u8 reg, u8 val=
ue)
 {
-	down(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
+	mutex_lock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
 	outb_p(value, client->addr + reg);
-	up(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
+	mutex_unlock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock=
);
 }
=20
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
@@ -531,7 +532,7 @@
  	struct i2c_client *client =3D to_i2c_client(dev);
 	struct smsc47m1_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
 		int i;
@@ -558,7 +559,7 @@
 		data->last_updated =3D jiffies;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return data;
 }
=20
--- linux-2.6.16-rc1.orig/drivers/hwmon/via686a.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/via686a.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -39,6 +39,7 @@
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
=20
@@ -296,7 +297,7 @@
 struct via686a_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -355,11 +356,11 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val, nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
 			data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,
@@ -368,11 +369,11 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val, nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
 			data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_in_offset(offset)					\
@@ -432,11 +433,11 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_over[nr] =3D TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER[nr],
 			    data->temp_over[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf,
@@ -445,11 +446,11 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_hyst[nr] =3D TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST[nr],
 			    data->temp_hyst[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -508,10 +509,10 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,
@@ -521,12 +522,12 @@
 	int val =3D simple_strtol(buf, NULL, 10);
 	int old;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	old =3D via686a_read_value(client, VIA686A_REG_FANDIV);
 	data->fan_div[nr] =3D DIV_TO_REG(val);
 	old =3D (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -639,7 +640,7 @@
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
 		goto exit_free;
@@ -733,7 +734,7 @@
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -788,7 +789,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/vt8231.c	2006-01-18 18:28:57.000000=
000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/vt8231.c	2006-01-18 21:22:35.000000000 +=
0100
@@ -35,6 +35,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
=20
 static int force_addr;
@@ -148,7 +149,7 @@
=20
 struct vt8231_data {
 	struct i2c_client client;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	struct class_device *class_dev;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -223,10 +224,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] =3D SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
 	vt8231_write_value(client, regvoltmin[nr], data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -239,10 +240,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] =3D SENSORS_LIMIT(((val * 958) / 10000) + 3, 0, 255);
 	vt8231_write_value(client, regvoltmax[nr], data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -281,11 +282,11 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[5] =3D SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
 					0, 255);
 	vt8231_write_value(client, regvoltmin[5], data->in_min[5]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -296,11 +297,11 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[5] =3D SENSORS_LIMIT(((val * 958 * 34) / (10000 * 54)) + 3,
 					0, 255);
 	vt8231_write_value(client, regvoltmax[5], data->in_max[5]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -351,10 +352,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[0] =3D SENSORS_LIMIT((val + 500) / 1000, 0, 255);
 	vt8231_write_value(client, regtempmax[0], data->temp_max[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp0_min(struct device *dev, struct device_attribute *=
attr,
@@ -364,10 +365,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[0] =3D SENSORS_LIMIT((val + 500) / 1000, 0, 255);
 	vt8231_write_value(client, regtempmin[0], data->temp_min[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -407,10 +408,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] =3D SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
 	vt8231_write_value(client, regtempmax[nr], data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *a=
ttr,
@@ -422,10 +423,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[nr] =3D SENSORS_LIMIT(TEMP_MAXMIN_TO_REG(val), 0, 255);
 	vt8231_write_value(client, regtempmin[nr], data->temp_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -520,10 +521,10 @@
 	struct vt8231_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -539,7 +540,7 @@
 	long min =3D FAN_FROM_REG(data->fan_min[nr],
 				 DIV_FROM_REG(data->fan_div[nr]));
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	switch (val) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
@@ -548,7 +549,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not supported."
 		        "Choose one of 1, 2, 4 or 8!\n", val);
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -558,7 +559,7 @@
=20
 	old =3D (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	vt8231_write_value(client, VT8231_REG_FANDIV, old);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -660,7 +661,7 @@
 	/* Fill in the remaining client fields and put into the global list */
 	strlcpy(client->name, "vt8231", I2C_NAME_SIZE);
=20
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(client)))
@@ -745,7 +746,7 @@
 	int i;
 	u16 low;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -804,7 +805,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/w83627ehf.c	2006-01-18 18:28:57.000=
000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/w83627ehf.c	2006-01-18 21:22:35.00000000=
0 +0100
@@ -43,6 +43,7 @@
 #include <linux/i2c-isa.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include "lm75.h"
=20
@@ -177,9 +178,9 @@
 struct w83627ehf_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -230,7 +231,7 @@
 	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
 	int res, word_sized =3D is_word_sized(reg);
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
=20
 	w83627ehf_set_bank(client, reg);
 	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
@@ -242,7 +243,7 @@
 	}
 	w83627ehf_reset_bank(client, reg);
=20
-	up(&data->lock);
+	mutex_unlock(&data->lock);
=20
 	return res;
 }
@@ -252,7 +253,7 @@
 	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
 	int word_sized =3D is_word_sized(reg);
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
=20
 	w83627ehf_set_bank(client, reg);
 	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
@@ -264,7 +265,7 @@
 	outb_p(value & 0xff, client->addr + DATA_REG_OFFSET);
 	w83627ehf_reset_bank(client, reg);
=20
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return 0;
 }
=20
@@ -322,7 +323,7 @@
 	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ)
 	 || !data->valid) {
@@ -397,7 +398,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return data;
 }
=20
@@ -434,7 +435,7 @@
 	unsigned int reg;
 	u8 new_div;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	if (!val) {
 		/* No min limit, alarm disabled */
 		data->fan_min[nr] =3D 255;
@@ -482,7 +483,7 @@
 	}
 	w83627ehf_write_value(client, W83627EHF_REG_FAN_MIN[nr],
 			      data->fan_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return count;
 }
@@ -561,11 +562,11 @@
 	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
 	u32 val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->temp1_##reg =3D temp1_to_reg(val); \
 	w83627ehf_write_value(client, W83627EHF_REG_TEMP1_##REG, \
 			      data->temp1_##reg); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_temp1_reg(OVER, max);
@@ -597,11 +598,11 @@
 	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
 	u32 val =3D simple_strtoul(buf, NULL, 10); \
  \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->reg[nr] =3D LM75_TEMP_TO_REG(val); \
 	w83627ehf_write_value(client, W83627EHF_REG_TEMP_##REG[nr], \
 			      data->reg[nr]); \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, temp_max);
@@ -689,14 +690,14 @@
 	client =3D &data->client;
 	i2c_set_clientdata(client, data);
 	client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	client->adapter =3D adapter;
 	client->driver =3D &w83627ehf_driver;
 	client->flags =3D 0;
=20
 	strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the i2c layer a new client has arrived */
 	if ((err =3D i2c_attach_client(client)))
--- linux-2.6.16-rc1.orig/drivers/hwmon/w83627hf.c	2006-01-18 18:28:57.0000=
00000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/w83627hf.c	2006-01-18 21:22:35.000000000=
 +0100
@@ -46,6 +46,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include "lm75.h"
=20
@@ -285,10 +286,10 @@
 struct w83627hf_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -360,12 +361,12 @@
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
 	 \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	w83627hf_write_value(client, W83781D_REG_IN_##REG(nr), \
 			    data->in_##reg[nr]); \
 	 \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min)
@@ -451,7 +452,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 =09
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf =3D data->type || w83637hf =3D data->type))
@@ -465,7 +466,7 @@
 		data->in_min[0] =3D IN_TO_REG(val);
=20
 	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -478,7 +479,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf =3D data->type || w83637hf =3D data->type))
@@ -492,7 +493,7 @@
 		data->in_max[0] =3D IN_TO_REG(val);
=20
 	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -529,13 +530,13 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr=
 - 1]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -597,7 +598,7 @@
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
 	 \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	 \
 	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] =3D LM75_TEMP_TO_REG(val); \
@@ -609,7 +610,7 @@
 			data->temp_##reg); \
 	} \
 	 \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -718,7 +719,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (update_mask =3D BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask =3D BEEP_MASK_TO_REG(val);
@@ -736,7 +737,7 @@
 	w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -783,7 +784,7 @@
 	u8 reg;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	/* Save fan_min */
 	min =3D FAN_FROM_REG(data->fan_min[nr],
@@ -805,7 +806,7 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]=
);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -848,7 +849,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (data->type =3D w83627thf) {
 		/* bits 0-3 are reserved  in 627THF */
@@ -865,7 +866,7 @@
 				     data->pwm[nr - 1]);
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -907,7 +908,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
@@ -941,7 +942,7 @@
 		break;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1057,7 +1058,7 @@
 	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D &w83627hf_driver;
 	new_client->flags =3D 0;
@@ -1077,7 +1078,7 @@
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
 	data->type =3D kind;
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -1187,7 +1188,7 @@
 	struct w83627hf_data *data =3D i2c_get_clientdata(client);
 	int res, word_sized;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	word_sized =3D (((reg & 0xff00) =3D 0x100)
 		   || ((reg & 0xff00) =3D 0x200))
 		  && (((reg & 0x00ff) =3D 0x50)
@@ -1213,7 +1214,7 @@
 		       client->addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
 	}
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return res;
 }
=20
@@ -1252,7 +1253,7 @@
 	struct w83627hf_data *data =3D i2c_get_clientdata(client);
 	int word_sized;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	word_sized =3D (((reg & 0xff00) =3D 0x100)
 		   || ((reg & 0xff00) =3D 0x200))
 		  && (((reg & 0x00ff) =3D 0x53)
@@ -1277,7 +1278,7 @@
 		       client->addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
 	}
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return 0;
 }
=20
@@ -1387,7 +1388,7 @@
 	struct w83627hf_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -1470,7 +1471,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/w83781d.c	2006-01-18 18:28:57.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/w83781d.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -42,6 +42,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include "lm75.h"
=20
@@ -221,10 +222,10 @@
 struct w83781d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -306,11 +307,11 @@
 	 \
 	val =3D simple_strtoul(buf, NULL, 10) / 10; \
 	 \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr])=
; \
 	 \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min);
@@ -376,13 +377,13 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr=
 - 1]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -441,7 +442,7 @@
 	 \
 	val =3D simple_strtol(buf, NULL, 10); \
 	 \
-	down(&data->update_lock); \
+	mutex_lock(&data->update_lock); \
 	 \
 	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] =3D LM75_TEMP_TO_REG(val); \
@@ -453,7 +454,7 @@
 			data->temp_##reg); \
 	} \
 	 \
-	up(&data->update_lock); \
+	mutex_unlock(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -566,7 +567,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (update_mask =3D BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask =3D BEEP_MASK_TO_REG(val, data->type);
@@ -587,7 +588,7 @@
 	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -632,7 +633,7 @@
 	u8 reg;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 =09
 	/* Save fan_min */
 	min =3D FAN_FROM_REG(data->fan_min[nr],
@@ -657,7 +658,7 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -704,10 +705,10 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->pwm[nr - 1] =3D PWM_TO_REG(val);
 	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -720,7 +721,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	switch (val) {
 	case 0:
@@ -737,11 +738,11 @@
 		break;
=20
 	default:
-		up(&data->update_lock);
+		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -803,7 +804,7 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
@@ -836,7 +837,7 @@
 		break;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
=20
@@ -1068,7 +1069,7 @@
 	new_client =3D &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr =3D address;
-	init_MUTEX(&data->lock);
+	mutex_init(&data->lock);
 	new_client->adapter =3D adapter;
 	new_client->driver =3D is_isa ? &w83781d_isa_driver : &w83781d_driver;
 	new_client->flags =3D 0;
@@ -1173,7 +1174,7 @@
 	data->type =3D kind;
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(new_client)))
@@ -1320,7 +1321,7 @@
 	int res, word_sized, bank;
 	struct i2c_client *cl;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	if (i2c_is_isa_client(client)) {
 		word_sized =3D (((reg & 0xff00) =3D 0x100)
 			      || ((reg & 0xff00) =3D 0x200))
@@ -1378,7 +1379,7 @@
 		if (bank > 2)
 			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return res;
 }
=20
@@ -1389,7 +1390,7 @@
 	int word_sized, bank;
 	struct i2c_client *cl;
=20
-	down(&data->lock);
+	mutex_lock(&data->lock);
 	if (i2c_is_isa_client(client)) {
 		word_sized =3D (((reg & 0xff00) =3D 0x100)
 			      || ((reg & 0xff00) =3D 0x200))
@@ -1442,7 +1443,7 @@
 		if (bank > 2)
 			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
-	up(&data->lock);
+	mutex_unlock(&data->lock);
 	return 0;
 }
=20
@@ -1537,7 +1538,7 @@
 	struct w83781d_data *data =3D i2c_get_clientdata(client);
 	int i;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
@@ -1634,7 +1635,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }
--- linux-2.6.16-rc1.orig/drivers/hwmon/w83792d.c	2006-01-18 20:59:10.00000=
0000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/w83792d.c	2006-01-18 21:22:35.000000000 =
+0100
@@ -43,6 +43,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* Addresses to scan */
 static unsigned short normal_i2c[] =3D { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIEN=
T_END };
@@ -271,7 +272,7 @@
 	struct class_device *class_dev;
 	enum chips type;
=20
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=3D0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
=20
@@ -1222,7 +1223,7 @@
 	data->type =3D kind;
=20
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
 	if ((err =3D i2c_attach_client(client)))
@@ -1373,7 +1374,7 @@
 	int i, j;
 	u8 reg_array_tmp[4], pwm_array_tmp[7], reg_tmp;
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (time_after
 	    (jiffies - data->last_updated, (unsigned long) (HZ * 3))
@@ -1484,7 +1485,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 #ifdef DEBUG
 	w83792d_print_debug(data, dev);
--- linux-2.6.16-rc1.orig/drivers/hwmon/w83l785ts.c	2006-01-18 18:28:57.000=
000000 +0100
+++ linux-2.6.16-rc1/drivers/hwmon/w83l785ts.c	2006-01-18 21:22:35.00000000=
0 +0100
@@ -39,6 +39,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
=20
 /* How many retries on register read error */
 #define MAX_RETRIES	5
@@ -107,7 +108,7 @@
 struct w83l785ts_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
=20
@@ -221,7 +222,7 @@
 	/* We can fill in the remaining client fields. */
 	strlcpy(new_client->name, "w83l785ts", I2C_NAME_SIZE);
 	data->valid =3D 0;
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
=20
 	/* Default values in case the first read fails (unlikely). */
 	data->temp[1] =3D data->temp[0] =3D 0;
@@ -299,7 +300,7 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct w83l785ts_data *data =3D i2c_get_clientdata(client);
=20
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
=20
 	if (!data->valid || time_after(jiffies, data->last_updated + HZ * 2)) {
 		dev_dbg(&client->dev, "Updating w83l785ts data.\n");
@@ -312,7 +313,7 @@
 		data->valid =3D 1;
 	}
=20
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
=20
 	return data;
 }

--=20
Jean Delvare

