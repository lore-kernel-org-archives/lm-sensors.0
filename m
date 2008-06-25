From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 11:53:08 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: (lm90) Support ADT7461 in extended
Message-Id: <20080625135308.57f42fc4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Nate Case <ncase@xes-inc.com>

Support ADT7461 in extended temperature range mode, which will change
the range of readings from 0..127 to -64..191 degC.  Adjust the
register conversion functions accordingly.

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm90 |    8 ---
 drivers/hwmon/Kconfig    |    7 --
 drivers/hwmon/lm90.c     |  117 +++++++++++++++++++++++++++++++++++-------=
----
 3 files changed, 94 insertions(+), 38 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/lm90.c	2008-06-25 11:00:39.00000000=
0 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/lm90.c	2008-06-25 11:05:02.000000000 +02=
00
@@ -37,11 +37,10 @@
  * chips. The MAX6680 and MAX6681 only differ in the pinout so they can
  * be treated identically.
  *
- * This driver also supports the ADT7461 chip from Analog Devices but
- * only in its "compatability mode". If an ADT7461 chip is found but
- * is configured in non-compatible mode (where its temperature
- * register values are decoded differently) it is ignored by this
- * driver.
+ * This driver also supports the ADT7461 chip from Analog Devices.
+ * It's supported in both compatibility and extended mode. It is mostly
+ * compatible with LM90 except for a data format difference for the
+ * temperature value registers.
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -138,6 +137,11 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99,
 #define MAX6657_REG_R_LOCAL_TEMPL	0x11
=20
 /*
+ * Device flags
+ */
+#define LM90_FLAG_ADT7461_EXT		0x01	/* ADT7461 extended mode */
+
+/*
  * Functions declaration
  */
=20
@@ -171,6 +175,7 @@ struct lm90_data {
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	int kind;
+	int flags;
=20
 	/* registers values */
 	s8 temp8[4];	/* 0: local low limit
@@ -236,26 +241,61 @@ static u8 hyst_to_reg(long val)
 }
=20
 /*
- * ADT7461 is almost identical to LM90 except that attempts to write
- * values that are outside the range 0 < temp < 127 are treated as
- * the boundary value.
+ * ADT7461 in compatibility mode is almost identical to LM90 except that
+ * attempts to write values that are outside the range 0 < temp < 127 are
+ * treated as the boundary value.
+ *
+ * ADT7461 in "extended mode" operation uses unsigned integers offset by
+ * 64 (e.g., 0 -> -64 degC).  The range is restricted to -64..191 degC.
  */
-static u8 temp1_to_reg_adt7461(long val)
+static inline int temp1_from_reg_adt7461(struct lm90_data *data, u8 val)
 {
-	if (val <=3D 0)
-		return 0;
-	if (val >=3D 127000)
-		return 127;
-	return (val + 500) / 1000;
+	if (data->flags & LM90_FLAG_ADT7461_EXT)
+		return (val - 64) * 1000;
+	else
+		return temp1_from_reg(val);
 }
=20
-static u16 temp2_to_reg_adt7461(long val)
+static inline int temp2_from_reg_adt7461(struct lm90_data *data, u16 val)
 {
-	if (val <=3D 0)
-		return 0;
-	if (val >=3D 127750)
-		return 0x7FC0;
-	return (val + 125) / 250 * 64;
+	if (data->flags & LM90_FLAG_ADT7461_EXT)
+		return (val - 0x4000) / 64 * 250;
+	else
+		return temp2_from_reg(val);
+}
+
+static u8 temp1_to_reg_adt7461(struct lm90_data *data, long val)
+{
+	if (data->flags & LM90_FLAG_ADT7461_EXT) {
+		if (val <=3D -64000)
+			return 0;
+		if (val >=3D 191000)
+			return 0xFF;
+		return (val + 500 + 64000) / 1000;
+	} else {
+		if (val <=3D 0)
+			return 0;
+		if (val >=3D 127000)
+			return 127;
+		return (val + 500) / 1000;
+	}
+}
+
+static u16 temp2_to_reg_adt7461(struct lm90_data *data, long val)
+{
+	if (data->flags & LM90_FLAG_ADT7461_EXT) {
+		if (val <=3D -64000)
+			return 0;
+		if (val >=3D 191750)
+			return 0xFFC0;
+		return (val + 64000 + 125) / 250 * 64;
+	} else {
+		if (val <=3D 0)
+			return 0;
+		if (val >=3D 127750)
+			return 0x7FC0;
+		return (val + 125) / 250 * 64;
+	}
 }
=20
 /*
@@ -267,7 +307,14 @@ static ssize_t show_temp8(struct device=20
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct lm90_data *data =3D lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
+	int temp;
+
+	if (data->kind =3D adt7461)
+		temp =3D temp1_from_reg_adt7461(data, data->temp8[attr->index]);
+	else
+		temp =3D temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
=20
 static ssize_t set_temp8(struct device *dev, struct device_attribute *deva=
ttr,
@@ -288,7 +335,7 @@ static ssize_t set_temp8(struct device *
=20
 	mutex_lock(&data->update_lock);
 	if (data->kind =3D adt7461)
-		data->temp8[nr] =3D temp1_to_reg_adt7461(val);
+		data->temp8[nr] =3D temp1_to_reg_adt7461(data, val);
 	else
 		data->temp8[nr] =3D temp1_to_reg(val);
 	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
@@ -301,7 +348,14 @@ static ssize_t show_temp11(struct device
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct lm90_data *data =3D lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
+	int temp;
+
+	if (data->kind =3D adt7461)
+		temp =3D temp2_from_reg_adt7461(data, data->temp11[attr->index]);
+	else
+		temp =3D temp2_from_reg(data->temp11[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
 }
=20
 static ssize_t set_temp11(struct device *dev, struct device_attribute *dev=
attr,
@@ -324,7 +378,7 @@ static ssize_t set_temp11(struct device=20
=20
 	mutex_lock(&data->update_lock);
 	if (data->kind =3D adt7461)
-		data->temp11[nr] =3D temp2_to_reg_adt7461(val);
+		data->temp11[nr] =3D temp2_to_reg_adt7461(data, val);
 	else if (data->kind =3D max6657 || data->kind =3D max6680)
 		data->temp11[nr] =3D temp1_to_reg(val) << 8;
 	else
@@ -344,8 +398,14 @@ static ssize_t show_temphyst(struct devi
 {
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	struct lm90_data *data =3D lm90_update_device(dev);
-	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
-		       - temp1_from_reg(data->temp_hyst));
+	int temp;
+
+	if (data->kind =3D adt7461)
+		temp =3D temp1_from_reg_adt7461(data, data->temp8[attr->index]);
+	else
+		temp =3D temp1_from_reg(data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp - temp1_from_reg(data->temp_hyst));
 }
=20
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *d=
ummy,
@@ -602,9 +662,12 @@ static int lm90_detect(struct i2c_adapte
 				kind =3D adm1032;
 			} else
 			if (chip_id =3D 0x51 /* ADT7461 */
-			 && (reg_config1 & 0x1F) =3D 0x00 /* check compat mode */
+			 && (reg_config1 & 0x1B) =3D 0x00
 			 && reg_convrate <=3D 0x0A) {
 				kind =3D adt7461;
+				/* Check Temperature Range Select */
+				if (reg_config1 & 0x04)
+					data->flags |=3D LM90_FLAG_ADT7461_EXT;
 			}
 		} else
 		if (man_id =3D 0x4D) { /* Maxim */
--- linux-2.6.26-rc8.orig/Documentation/hwmon/lm90	2008-06-25 10:23:29.0000=
00000 +0200
+++ linux-2.6.26-rc8/Documentation/hwmon/lm90	2008-06-25 11:58:23.000000000=
 +0200
@@ -32,7 +32,6 @@ Supported chips:
     Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the ON Semiconductor website
                http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
-    Note: Only if in ADM1032 compatibility mode
   * Maxim MAX6657
     Prefix: 'max6657'
     Addresses scanned: I2C 0x4c
@@ -70,16 +69,13 @@ Description
=20
 The LM90 is a digital temperature sensor. It senses its own temperature as
 well as the temperature of up to one external diode. It is compatible
-with many other devices such as the LM86, the LM89, the LM99, the ADM1032,
-the MAX6657, MAX6658, MAX6659, MAX6680 and the MAX6681 all of which are
-supported by this driver.
+with many other devices, many of which are supported by this driver.
=20
 Note that there is no easy way to differentiate between the MAX6657,
 MAX6658 and MAX6659 variants. The extra address and features of the
 MAX6659 are not supported by this driver. The MAX6680 and MAX6681 only
 differ in their pinout, therefore they obviously can't (and don't need to)
-be distinguished. Additionally, the ADT7461 is supported if found in
-ADM1032 compatibility mode.
+be distinguished.
=20
 The specificity of this family of chipsets over the ADM1021/LM84
 family is that it features critical limits with hysteresis, and an
--- linux-2.6.26-rc8.orig/drivers/hwmon/Kconfig	2008-06-25 09:53:17.0000000=
00 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/Kconfig	2008-06-25 11:54:41.000000000 +0=
200
@@ -494,11 +494,8 @@ config SENSORS_LM90
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657,
-	  MAX6658, MAX6659, MAX6680 and MAX6681 sensor chips.
-
-	  The Analog Devices ADT7461 sensor chip is also supported, but only
-	  if found in ADM1032 compatibility mode.
+	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, and Maxim
+	  MAX6657, MAX6658, MAX6659, MAX6680 and MAX6681 sensor chips.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
