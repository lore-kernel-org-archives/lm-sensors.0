From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: PATCH: i2c: add adt7461 chip support to lm90 driver
Message-Id: <422C305F.3000301@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Greg,

Attached is another version of my adt7461 patch, for inclusion in the
2.6 tree. Reviewed by Jean.

/james

-------------- next part --------------
i2c: add adt7461 chip support

The Analog Devices ADT7461 temperature sensor chip is compatible with
the lm90 device provided its extended temperature range is not
enabled.  The chip will be ignored if the boot firmware enables
extended temperature range.

Also, since the adt7461 treats temp values <0 as 0 and >127 as 127,
the driver prevents temperature values outside the supported range
from being set.

Signed-off-by: James Chapman <jchapman@katalix.com>

Index: linux-2.6.i2c/drivers/i2c/chips/lm90.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.i2c.orig/drivers/i2c/chips/lm90.c	200=
5-03-04 16:39:33.000000000 +0000
+++ linux-2.6.i2c/drivers/i2c/chips/lm90.c	2005-03-04 16:57:49.000000000 +0=
000
@@ -43,6 +43,14 @@
  * variants. The extra address and features of the MAX6659 are not
  * supported by this driver.
  *
+ * This driver also supports the ADT7461 chip from Analog Devices but
+ * only in its "compatability mode". If an ADT7461 chip is found but
+ * is configured in non-compatible mode (where its temperature
+ * register values are decoded differently) it is ignored by this
+ * driver. Complete datasheet can be obtained from Analog's website
+ * at:
+ *   http://products.analog.com/products/info.asp?product=ADT7461
+ *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
  * concern all supported chipsets, unless mentioned otherwise.
@@ -76,6 +84,7 @@
  * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
  * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
+ * ADT7461 always has address 0x4c.
  */
=20
 static unsigned short normal_i2c[] =3D { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -85,7 +94,7 @@
  * Insmod parameters
  */
=20
-SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
+SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
=20
 /*
  * The LM90 registers
@@ -147,6 +156,19 @@
 #define HYST_TO_REG(val)	((val) <=3D 0 ? 0 : (val) >=3D 30500 ? 31 : \
 				 ((val) + 500) / 1000)
=20
+/*=20
+ * ADT7461 is almost identical to LM90 except that attempts to write
+ * values that are outside the range 0 < temp < 127 are treated as
+ * the boundary value.=20
+ */
+
+#define TEMP1_TO_REG_ADT7461(val) ((val) <=3D 0 ? 0 : \
+				 (val) >=3D 127000 ? 127 : \
+				 ((val) + 500) / 1000)
+#define TEMP2_TO_REG_ADT7461(val) ((val) <=3D 0 ? 0 : \
+				 (val) >=3D 127750 ? 0x7FC0 : \
+				 ((val) + 125) / 250 * 64)
+
 /*
  * Functions declaration
  */
@@ -180,6 +202,7 @@
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	int kind;
=20
 	/* registers values */
 	s8 temp_input1, temp_low1, temp_high1; /* local */
@@ -221,7 +244,10 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm90_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
-	data->value =3D TEMP1_TO_REG(val); \
+	if (data->kind =3D adt7461) \
+		data->value =3D TEMP1_TO_REG_ADT7461(val); \
+	else \
+		data->value =3D TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -232,7 +258,10 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm90_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
-	data->value =3D TEMP2_TO_REG(val); \
+	if (data->kind =3D adt7461) \
+		data->value =3D TEMP2_TO_REG_ADT7461(val); \
+	else \
+		data->value =3D TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
 	return count; \
@@ -386,6 +415,12 @@
 			 && (reg_config1 & 0x3F) =3D 0x00
 			 && reg_convrate <=3D 0x0A) {
 				kind =3D adm1032;
+			} else
+			if (address =3D 0x4c
+			 && chip_id =3D 0x51 /* ADT7461 */
+			 && (reg_config1 & 0x1F) =3D 0x00 /* check compat mode */
+			 && reg_convrate <=3D 0x0A) {
+				kind =3D adt7461;
 			}
 		} else
 		if (man_id =3D 0x4D) { /* Maxim */
@@ -423,12 +458,15 @@
 		name =3D "lm86";
 	} else if (kind =3D max6657) {
 		name =3D "max6657";
+	} else if (kind =3D adt7461) {
+		name =3D "adt7461";
 	}
=20
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	new_client->id =3D lm90_id++;
 	data->valid =3D 0;
+	data->kind =3D kind;
 	init_MUTEX(&data->update_lock);
=20
 	/* Tell the I2C layer a new client has arrived */
