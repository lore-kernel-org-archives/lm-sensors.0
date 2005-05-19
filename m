From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] Add support for LM86, MAX6657 and MAX6658 to lm90
Message-Id: <20040704213107.0996e984.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Greg,

This adds support for the LM86, MAX6657 and MAX6658 sensor chips to the
lm90 driver. These are less popular than the LM90 and ADM1032 but
several users have reported to use these, so I added support to the lm90
driver. All these chips are fully compatible so that's just a matter of
accepting the new chip ids. I also slightly simplified the detection
code.

Should apply fine on top of your current stack.
Thanks.


Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ruN linux-2.6.7-mm5/drivers/i2c/chips.orig/Kconfig linux-2.6.7-mm5/dr=
ivers/i2c/chips/Kconfig
--- linux-2.6.7-mm5/drivers/i2c/chips.orig/Kconfig	Sun Jul  4 15:49:04 2004
+++ linux-2.6.7-mm5/drivers/i2c/chips/Kconfig	Sun Jul  4 17:52:47 2004
@@ -164,7 +164,8 @@
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
-	  LM89 and LM99, and Analog Devices ADM1032 sensor chips.
+	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
+	  MAX6658 sensor chips.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
diff -ruN linux-2.6.7-mm5/drivers/i2c/chips.orig/lm90.c linux-2.6.7-mm5/dri=
vers/i2c/chips/lm90.c
--- linux-2.6.7-mm5/drivers/i2c/chips.orig/lm90.c	Sat Jun 26 09:46:13 2004
+++ linux-2.6.7-mm5/drivers/i2c/chips/lm90.c	Sun Jul  4 20:06:25 2004
@@ -21,11 +21,26 @@
  *   http://www.national.com/pf/LM/LM99.html
  * Note that there is no way to differenciate between both chips.
  *
+ * This driver also supports the LM86, another sensor chip made by
+ * National Semiconductor. It is exactly similar to the LM90 except it
+ * has a higher accuracy.
+ * Complete datasheet can be obtained from National's website at:
+ *   http://www.national.com/pf/LM/LM86.html
+ *
  * This driver also supports the ADM1032, a sensor chip made by Analog
  * Devices. That chip is similar to the LM90, with a few differences
  * that are not handled by this driver. Complete datasheet can be
  * obtained from Analog's website at:
  *   http://products.analog.com/products/info.asp?product=ADM1032
+ * Among others, it has a higher accuracy than the LM90, much like the
+ * LM86 does.
+ *
+ * This driver also supports the MAX6657 and MAX6658, sensor chips made
+ * by Maxim. These chips are similar to the LM86. Complete datasheet
+ * can be obtained at Maxim's website at:
+ *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+ * Note that there is no way to differenciate between both chips (but
+ * no need either).
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -56,7 +71,7 @@
 /*
  * Addresses to scan
  * Address is fully defined internally and cannot be changed.
- * LM89, LM90, LM99 and ADM1032 have address 0x4c.
+ * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
  */
=20
@@ -69,7 +84,7 @@
  * Insmod parameters
  */
=20
-SENSORS_INSMOD_3(lm90, adm1032, lm99);
+SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
=20
 /*
  * The LM90 registers
@@ -289,7 +304,6 @@
 	struct lm90_data *data;
 	int err =3D 0;
 	const char *name =3D "";
-	u8 reg_config1=3D0, reg_convrate=3D0;
=20
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
@@ -319,28 +333,22 @@
 	 * requested, so both the detection and the identification steps
 	 * are skipped.
 	 */
-	if (kind < 0) { /* detection */
-		reg_config1 =3D i2c_smbus_read_byte_data(new_client,
-			      LM90_REG_R_CONFIG1);
-		reg_convrate =3D i2c_smbus_read_byte_data(new_client,
-			       LM90_REG_R_CONVRATE);
=20
-		if ((reg_config1 & 0x2A) !=3D 0x00
-		 || reg_convrate > 0x0A) {
-			dev_dbg(&adapter->dev,
-				"LM90 detection failed at 0x%02x.\n",
-				address);
-			goto exit_free;
-		}
-	}
+	/* Default to an LM90 if forced */
+	if (kind =3D 0)
+		kind =3D lm90;
=20
-	if (kind <=3D 0) { /* identification */
-		u8 man_id, chip_id;
+	if (kind < 0) { /* detection and identification */
+		u8 man_id, chip_id, reg_config1, reg_convrate;
=20
 		man_id =3D i2c_smbus_read_byte_data(new_client,
 			 LM90_REG_R_MAN_ID);
 		chip_id =3D i2c_smbus_read_byte_data(new_client,
 			  LM90_REG_R_CHIP_ID);
+		reg_config1 =3D i2c_smbus_read_byte_data(new_client,
+			      LM90_REG_R_CONFIG1);
+		reg_convrate =3D i2c_smbus_read_byte_data(new_client,
+			       LM90_REG_R_CONVRATE);
 	=09
 		if (man_id =3D 0x01) { /* National Semiconductor */
 			u8 reg_config2;
@@ -348,25 +356,36 @@
 			reg_config2 =3D i2c_smbus_read_byte_data(new_client,
 				      LM90_REG_R_CONFIG2);
=20
-			if (kind =3D 0 /* skip detection */
-			 || ((reg_config2 & 0xF8) =3D 0x00
-			  && reg_convrate <=3D 0x09)) {
+			if ((reg_config1 & 0x2A) =3D 0x00
+			 && (reg_config2 & 0xF8) =3D 0x00
+			 && reg_convrate <=3D 0x09) {
 				if (address =3D 0x4C
 				 && (chip_id & 0xF0) =3D 0x20) { /* LM90 */
 					kind =3D lm90;
 				} else
 				if ((chip_id & 0xF0) =3D 0x30) { /* LM89/LM99 */
 					kind =3D lm99;
+				} else
+				if (address =3D 0x4C
+				 && (chip_id & 0xF0) =3D 0x10) { /* LM86 */
+					kind =3D lm86;
 				}
 			}
 		} else
 		if (man_id =3D 0x41) { /* Analog Devices */
 			if (address =3D 0x4C
 			 && (chip_id & 0xF0) =3D 0x40 /* ADM1032 */
-			 && (kind =3D 0 /* skip detection */
-			  || (reg_config1 & 0x3F) =3D 0x00)) {
+			 && (reg_config1 & 0x3F) =3D 0x00
+			 && reg_convrate <=3D 0x0A) {
 				kind =3D adm1032;
 			}
+		} else
+		if (man_id =3D 0x4D) { /* Maxim */
+			if (address =3D 0x4C
+			 && (reg_config1 & 0x1F) =3D 0
+			 && reg_convrate <=3D 0x09) {
+			 	kind =3D max6657;
+			}
 		}
=20
 		if (kind <=3D 0) { /* identification failed */
@@ -383,6 +402,10 @@
 		name =3D "adm1032";
 	} else if (kind =3D lm99) {
 		name =3D "lm99";
+	} else if (kind =3D lm86) {
+		name =3D "lm86";
+	} else if (kind =3D max6657) {
+		name =3D "max6657";
 	}
=20
 	/* We can fill in the remaining client fields */

--=20
Jean Delvare
http://khali.linux-fr.org/
