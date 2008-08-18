From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 18 Aug 2008 19:23:20 +0000
Subject: [lm-sensors] [PATCH] lm90: Support MAX6646, MAX6647 and MAX6649
Message-Id: <20080818192318.GF7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

These Maxim chips are similar to MAX6657 but use unsigned temperature
values to allow for readings up to 145 degrees.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 Documentation/hwmon/lm90 |   15 +++++++++
 drivers/hwmon/Kconfig    |    3 +-
 drivers/hwmon/lm90.c     |   77 ++++++++++++++++++++++++++++++++++++++----=
---
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index 53cd829..e0d5206 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -32,6 +32,21 @@ Supported chips:
     Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the ON Semiconductor website
                http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
+  * Maxim MAX6646
+    Prefix: 'max6646'
+    Addresses scanned: I2C 0x4d
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+  * Maxim MAX6647
+    Prefix: 'max6646'
+    Addresses scanned: I2C 0x4e
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
+  * Maxim MAX6649
+    Prefix: 'max6646'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3497
   * Maxim MAX6657
     Prefix: 'max6657'
     Addresses scanned: I2C 0x4c
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 47a264f..03ba31e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -495,7 +495,8 @@ config SENSORS_LM90
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, and Maxim
-	  MAX6657, MAX6658, MAX6659, MAX6680 and MAX6681 sensor chips.
+	  MAX6646, MAX6647, MAX6649, MAX6657, MAX6658, MAX6659, MAX6680 and
+	  MAX6681 sensor chips.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 85ba2c4..fe09f82 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -32,6 +32,11 @@
  * supported by this driver. These chips lack the remote temperature
  * offset feature.
  *
+ * This driver also supports the MAX6646, MAX6647 and MAX6649 chips
+ * made by Maxim.  These are again similar to the LM86, but they use
+ * unsigned temperature values and can report temperatures from 0 to
+ * 145 degrees.
+ *
  * This driver also supports the MAX6680 and MAX6681, two other sensor
  * chips made by Maxim. These are quite similar to the other Maxim
  * chips. The MAX6680 and MAX6681 only differ in the pinout so they can
@@ -76,9 +81,10 @@
  * Addresses to scan
  * Address is fully defined internally and cannot be changed except for
  * MAX6659, MAX6680 and MAX6681.
- * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6657 and MAX6658
- * have address 0x4c.
- * ADM1032-2, ADT7461-2, LM89-1, and LM99-1 have address 0x4d.
+ * LM86, LM89, LM90, LM99, ADM1032, ADM1032-1, ADT7461, MAX6649, MAX6657
+ * and MAX6658 have address 0x4c.
+ * ADM1032-2, ADT7461-2, LM89-1, LM99-1 and MAX6646 have address 0x4d.
+ * MAX6647 has address 0x4e.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
  * MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
  * 0x4c, 0x4d or 0x4e.
@@ -91,7 +97,8 @@ static const unsigned short normal_i2c[] =3D {
  * Insmod parameters
  */
=20
-I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680);
+I2C_CLIENT_INSMOD_8(lm90, adm1032, lm99, lm86, max6657, adt7461, max6680,
+		    max6646);
=20
 /*
  * The LM90 registers
@@ -132,7 +139,7 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99, lm86, max6657,=
 adt7461, max6680);
 #define LM90_REG_R_TCRIT_HYST		0x21
 #define LM90_REG_W_TCRIT_HYST		0x21
=20
-/* MAX6657-specific registers */
+/* MAX6646/6647/6649/6657/6658/6659 registers */
=20
 #define MAX6657_REG_R_LOCAL_TEMPL	0x11
=20
@@ -164,6 +171,9 @@ static const struct i2c_device_id lm90_id[] =3D {
 	{ "lm86", lm86 },
 	{ "lm89", lm99 },
 	{ "lm99", lm99 },	/* Missing temperature offset */
+	{ "max6646", max6646 },
+	{ "max6647", max6646 },
+	{ "max6649", max6646 },
 	{ "max6657", max6657 },
 	{ "max6658", max6657 },
 	{ "max6659", max6657 },
@@ -205,7 +215,7 @@ struct lm90_data {
 	s16 temp11[5];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
-			   3: remote offset (except max6657)
+			   3: remote offset (except max6646 and max6657)
 			   4: local input */
 	u8 temp_hyst;
 	u8 alarms; /* bitvector */
@@ -216,7 +226,8 @@ struct lm90_data {
  * For local temperatures and limits, critical limits and the hysteresis
  * value, the LM90 uses signed 8-bit values with LSB =3D 1 degree Celsius.
  * For remote temperatures and limits, it uses signed 11-bit values with
- * LSB =3D 0.125 degree Celsius, left-justified in 16-bit registers.
+ * LSB =3D 0.125 degree Celsius, left-justified in 16-bit registers.  Some
+ * Maxim chips use unsigned values.
  */
=20
 static inline int temp_from_s8(s8 val)
@@ -224,11 +235,21 @@ static inline int temp_from_s8(s8 val)
 	return val * 1000;
 }
=20
+static inline int temp_from_u8(u8 val)
+{
+	return val * 1000;
+}
+
 static inline int temp_from_s16(s16 val)
 {
 	return val / 32 * 125;
 }
=20
+static inline int temp_from_u16(u16 val)
+{
+	return val / 32 * 125;
+}
+
 static s8 temp_to_s8(long val)
 {
 	if (val <=3D -128000)
@@ -240,6 +261,15 @@ static s8 temp_to_s8(long val)
 	return (val + 500) / 1000;
 }
=20
+static u8 temp_to_u8(long val)
+{
+	if (val <=3D 0)
+		return 0;
+	if (val >=3D 255000)
+		return 255;
+	return (val + 500) / 1000;
+}
+
 static s16 temp_to_s16(long val)
 {
 	if (val <=3D -128000)
@@ -331,6 +361,8 @@ static ssize_t show_temp8(struct device *dev, struct de=
vice_attribute *devattr,
=20
 	if (data->kind =3D adt7461)
 		temp =3D temp_from_u8_adt7461(data, data->temp8[attr->index]);
+	else if (data->kind =3D max6646)
+		temp =3D temp_from_u8(data->temp8[attr->index]);
 	else
 		temp =3D temp_from_s8(data->temp8[attr->index]);
=20
@@ -356,6 +388,8 @@ static ssize_t set_temp8(struct device *dev, struct dev=
ice_attribute *devattr,
 	mutex_lock(&data->update_lock);
 	if (data->kind =3D adt7461)
 		data->temp8[nr] =3D temp_to_u8_adt7461(data, val);
+	else if (data->kind =3D max6646)
+		data->temp8[nr] =3D temp_to_u8(val);
 	else
 		data->temp8[nr] =3D temp_to_s8(val);
 	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
@@ -372,6 +406,8 @@ static ssize_t show_temp11(struct device *dev, struct d=
evice_attribute *devattr,
=20
 	if (data->kind =3D adt7461)
 		temp =3D temp_from_u16_adt7461(data, data->temp11[attr->index]);
+	else if (data->kind =3D max6646)
+		temp =3D temp_from_u16(data->temp11[attr->index]);
 	else
 		temp =3D temp_from_s16(data->temp11[attr->index]);
=20
@@ -401,12 +437,15 @@ static ssize_t set_temp11(struct device *dev, struct =
device_attribute *devattr,
 		data->temp11[nr] =3D temp_to_u16_adt7461(data, val);
 	else if (data->kind =3D max6657 || data->kind =3D max6680)
 		data->temp11[nr] =3D temp_to_s8(val) << 8;
+	else if (data->kind =3D max6646)
+		data->temp11[nr] =3D temp_to_u8(val) << 8;
 	else
 		data->temp11[nr] =3D temp_to_s16(val);
=20
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
-	if (data->kind !=3D max6657 && data->kind !=3D max6680)
+	if (data->kind !=3D max6657 && data->kind !=3D max6680
+	    && data->kind !=3D max6646)
 		i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
 					  data->temp11[nr] & 0xff);
 	mutex_unlock(&data->update_lock);
@@ -689,6 +728,16 @@ static int lm90_detect(struct i2c_client *new_client, =
int kind,
 			 && (reg_config1 & 0x03) =3D 0x00
 			 && reg_convrate <=3D 0x07) {
 			 	kind =3D max6680;
+			} else
+			/* The chip_id register of the MAX6646/6647/6649
+			 * holds the revision of the chip.
+			 * The lowest 6 bits of the config1 register are
+			 * unused and should return zero when read.
+			 */
+			if (chip_id =3D 0x59
+			 && (reg_config1 & 0x3f) =3D 0x00
+			 && reg_convrate <=3D 0x07) {
+				kind =3D max6646;
 			}
 		}
=20
@@ -719,6 +768,8 @@ static int lm90_detect(struct i2c_client *new_client, i=
nt kind,
 		name =3D "max6680";
 	} else if (kind =3D adt7461) {
 		name =3D "adt7461";
+	} else if (kind =3D max6646) {
+		name =3D "max6646";
 	}
 	strlcpy(info->type, name, I2C_NAME_SIZE);
=20
@@ -758,7 +809,7 @@ static int lm90_probe(struct i2c_client *new_client,
 					      &dev_attr_pec)))
 			goto exit_remove_files;
 	}
-	if (data->kind !=3D max6657) {
+	if (data->kind !=3D max6657 && data->kind !=3D max6646) {
 		if ((err =3D device_create_file(&new_client->dev,
 				&sensor_dev_attr_temp2_offset.dev_attr)))
 			goto exit_remove_files;
@@ -824,7 +875,7 @@ static int lm90_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
 	device_remove_file(&client->dev, &dev_attr_pec);
-	if (data->kind !=3D max6657)
+	if (data->kind !=3D max6657 && data->kind !=3D max6646)
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
=20
@@ -881,7 +932,7 @@ static struct lm90_data *lm90_update_device(struct devi=
ce *dev)
 		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
 		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
=20
-		if (data->kind =3D max6657) {
+		if (data->kind =3D max6657 || data->kind =3D max6646) {
 			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
 				    MAX6657_REG_R_LOCAL_TEMPL,
 				    &data->temp11[4]);
@@ -896,6 +947,7 @@ static struct lm90_data *lm90_update_device(struct devi=
ce *dev)
 		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) =3D 0) {
 			data->temp11[1] =3D h << 8;
 			if (data->kind !=3D max6657 && data->kind !=3D max6680
+			 && data->kind !=3D max6646
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
 					  &l) =3D 0)
 				data->temp11[1] |=3D l;
@@ -903,12 +955,13 @@ static struct lm90_data *lm90_update_device(struct de=
vice *dev)
 		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) =3D 0) {
 			data->temp11[2] =3D h << 8;
 			if (data->kind !=3D max6657 && data->kind !=3D max6680
+			 && data->kind !=3D max6646
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
 					  &l) =3D 0)
 				data->temp11[2] |=3D l;
 		}
=20
-		if (data->kind !=3D max6657) {
+		if (data->kind !=3D max6657 && data->kind !=3D max6646) {
 			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
 					  &h) =3D 0
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,

--=20
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
