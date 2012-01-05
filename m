From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 21:23:56 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/adm1025.c   |    2 +-
 drivers/hwmon/ds1621.c    |    6 +++---
 drivers/hwmon/g760a.c     |    2 +-
 drivers/hwmon/hwmon-vid.c |    2 +-
 drivers/hwmon/lm78.c      |   10 +++++-----
 drivers/hwmon/lm83.c      |    2 +-
 drivers/hwmon/max1619.c   |    2 +-
 drivers/hwmon/sis5595.c   |    4 ++--
 drivers/hwmon/smsc47m1.c  |    2 +-
 drivers/hwmon/w83627hf.c  |    2 +-
 drivers/hwmon/w83l785ts.c |    2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 60befc0..80c2b4e 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -12,7 +12,7 @@
  * resolution of about 0.5% of the nominal value). Temperature values are
  * reported with a 1 deg resolution and a 3 deg accuracy. Complete
  * datasheet can be obtained from Analog's website at:
- *   http://www.onsemi.com/PowerSolutions/product.do?id=ADM1025=20
+ *   http://www.onsemi.com/PowerSolutions/product.do?id=ADM1025
  *
  * This driver also supports the ADM1025A, which differs from the ADM1025
  * only in that it has "open-drain VID inputs while the ADM1025 has
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index ef1ac996..89fe791 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -3,7 +3,7 @@
              monitoring
     Christian W. Zuckschwerdt  <zany@triq.net>  2000-11-23
     based on lm75.c by Frodo Looijaard <frodol@dds.nl>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with=20
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
     the help of Jean Delvare <khali@linux-fr.org>
=20
     This program is free software; you can redistribute it and/or modify
@@ -212,8 +212,8 @@ static int ds1621_detect(struct i2c_client *client,
 	int conf, temp;
 	int i;
=20
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA=20
-				     | I2C_FUNC_SMBUS_WORD_DATA=20
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_WORD_DATA
 				     | I2C_FUNC_SMBUS_WRITE_BYTE))
 		return -ENODEV;
=20
diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 1d6a6fa..905e194 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -5,7 +5,7 @@
     Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
=20
     Complete datasheet is available at GMT's website:
-      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf=20
+      http://www.gmt.com.tw/product/datasheet/EDS-760A.pdf
=20
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 4fcb867..a918426 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -40,7 +40,7 @@
  * available at http://developer.intel.com/.
  *
  * AMD Athlon 64 and AMD Opteron Processors, AMD Publication 26094,
- * http://support.amd.com/us/Processor_TechDocs/26094.PDF=20
+ * http://support.amd.com/us/Processor_TechDocs/26094.PDF
  * Table 74. VID Code Voltages
  * This corresponds to an arbitrary VRM code of 24 in the functions below.
  * These CPU models (K8 revision <=3D E) have 5 VID pins. See also:
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 6df0b46..7fc3449 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -1,7 +1,7 @@
 /*
     lm78.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>=20
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
     Copyright (c) 2007, 2011  Jean Delvare <khali@linux-fr.org>
=20
     This program is free software; you can redistribute it and/or modify
@@ -74,7 +74,7 @@ enum chips { lm78, lm79 };
 #define LM78_REG_I2C_ADDR 0x48
=20
=20
-/* Conversions. Rounding and limit checking is only done on the TO_REG=20
+/* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. */
=20
 /* IN: mV, (0V to 4.08V)
@@ -669,7 +669,7 @@ static struct i2c_driver lm78_driver =3D {
 	.address_list	=3D normal_i2c,
 };
=20
-/* The SMBus locks itself, but ISA access must be locked explicitly!=20
+/* The SMBus locks itself, but ISA access must be locked explicitly!
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlock=
s,
@@ -691,11 +691,11 @@ static int lm78_read_value(struct lm78_data *data, u8=
 reg)
 		return i2c_smbus_read_byte_data(client, reg);
 }
=20
-/* The SMBus locks itself, but ISA access muse be locked explicitly!=20
+/* The SMBus locks itself, but ISA access muse be locked explicitly!
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlock=
s,
-   would slow down the LM78 access and should not be necessary.=20
+   would slow down the LM78 access and should not be necessary.
    There are some ugly typecasts here, but the good new is - they should
    nowhere else be necessary! */
 static int lm78_write_value(struct lm78_data *data, u8 reg, u8 value)
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 8290476..565550a 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -124,7 +124,7 @@ static struct lm83_data *lm83_update_device(struct devi=
ce *dev);
 /*
  * Driver data (common to all clients)
  */
-=20
+
 static const struct i2c_device_id lm83_id[] =3D {
 	{ "lm83", lm83 },
 	{ "lm82", lm82 },
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 022ded0..e0586cc 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -125,7 +125,7 @@ struct max1619_data {
 	u8 temp_input2, temp_low2, temp_high2; /* remote */
 	u8 temp_crit2;
 	u8 temp_hyst2;
-	u8 alarms;=20
+	u8 alarms;
 };
=20
 /*
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 3324245..6254eb2 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -26,7 +26,7 @@
 /*
    SiS southbridge has a LM78-like chip integrated on the same IC.
    This driver is a customized copy of lm78.c
-  =20
+
    Supports following revisions:
 	Version		PCI ID		PCI Revision
 	1		1039/0008	AF or less
@@ -521,7 +521,7 @@ static struct attribute *sis5595_attributes_temp1[] =3D=
 {
 static const struct attribute_group sis5595_group_temp1 =3D {
 	.attrs =3D sis5595_attributes_temp1,
 };
-=20
+
 /* This is called when the module is loaded */
 static int __devinit sis5595_probe(struct platform_device *pdev)
 {
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index f44a89a..c3326f9 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -508,7 +508,7 @@ static void smsc47m1_restore(const struct smsc47m1_sio_=
data *sio_data)
=20
 /*
  * This function can be used to:
- *  - test for resource conflicts with ACPI
+ *  - test for resource conflicts with ACP
  *  - request the resources
  *  - release the resources
  * We only allocate the I/O ports we really need, to minimize the risk of
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 2192662..2f528a0 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1605,7 +1605,7 @@ static void __devinit w83627hf_init_device(struct pla=
tform_device *pdev)
=20
 	/* Read VRM & OVT Config only once */
 	if (type =3D w83627thf || type =3D w83637hf || type =3D w83687thf) {
-		data->vrm_ovt =3D=20
+		data->vrm_ovt  			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
 	}
=20
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 20781de..edfc1ec 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -86,7 +86,7 @@ static struct w83l785ts_data *w83l785ts_update_device(str=
uct device *dev);
 /*
  * Driver data (common to all clients)
  */
-=20
+
 static const struct i2c_device_id w83l785ts_id[] =3D {
 	{ "w83l785ts", 0 },
 	{ }
--=20
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
