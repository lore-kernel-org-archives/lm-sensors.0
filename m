From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (04/11)
Message-Id: <11259567681539@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567691080@kroah.com>
In-Reply-To: <11259567691080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (04/11)

i2c_probe and i2c_detect now do the exact same thing and operate on
the same data structure, so we can have everyone call i2c_probe.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2ed2dc3c116d26fc6a9384e83d136b15cc203b6c
tree c79308b2cfe55eaddc95c47cbcafa6e0cae27413
parent b78ec31582c60578ee1d3bb470791d6dde96ccf7
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 21:42:02 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:20 -0700

 Documentation/i2c/porting-clients |    1 +
 Documentation/i2c/writing-clients |   19 +++++--------------
 drivers/hwmon/adm1021.c           |    2 +-
 drivers/hwmon/adm1025.c           |    2 +-
 drivers/hwmon/adm1026.c           |    2 +-
 drivers/hwmon/adm1031.c           |    4 ++--
 drivers/hwmon/adm9240.c           |    2 +-
 drivers/hwmon/asb100.c            |    2 +-
 drivers/hwmon/atxp1.c             |    2 +-
 drivers/hwmon/ds1621.c            |    4 ++--
 drivers/hwmon/fscher.c            |    2 +-
 drivers/hwmon/fscpos.c            |    2 +-
 drivers/hwmon/gl518sm.c           |    2 +-
 drivers/hwmon/gl520sm.c           |    2 +-
 drivers/hwmon/it87.c              |    4 ++--
 drivers/hwmon/lm63.c              |    2 +-
 drivers/hwmon/lm75.c              |    4 ++--
 drivers/hwmon/lm77.c              |    4 ++--
 drivers/hwmon/lm78.c              |    4 ++--
 drivers/hwmon/lm80.c              |    2 +-
 drivers/hwmon/lm83.c              |    2 +-
 drivers/hwmon/lm85.c              |    2 +-
 drivers/hwmon/lm87.c              |    2 +-
 drivers/hwmon/lm90.c              |    2 +-
 drivers/hwmon/lm92.c              |    2 +-
 drivers/hwmon/max1619.c           |    2 +-
 drivers/hwmon/w83781d.c           |    2 +-
 drivers/hwmon/w83792d.c           |    2 +-
 drivers/hwmon/w83l785ts.c         |    2 +-
 drivers/i2c/chips/ds1337.c        |    2 +-
 drivers/i2c/chips/eeprom.c        |    4 ++--
 drivers/i2c/chips/max6875.c       |    4 ++--
 drivers/i2c/chips/pca9539.c       |    4 ++--
 drivers/i2c/chips/pcf8574.c       |    4 ++--
 drivers/i2c/chips/pcf8591.c       |    4 ++--
 35 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -66,6 +66,7 @@ Technical changes:
   if (!(adapter->class & I2C_CLASS_HWMON))
           return 0;
   ISA-only drivers of course don't need this.
+  Call i2c_probe() instead of i2c_detect().
 
 * [Detect] As mentioned earlier, the flags parameter is gone.
   The type_name and client_name strings are replaced by a single
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -148,7 +148,7 @@ are defined in i2c.h to help you support
 detection algorithm.
 
 You do not have to use this parameter interface; but don't try to use
-function i2c_probe() (or i2c_detect()) if you don't.
+function i2c_probe() if you don't.
 
 NOTE: If you want to write a `sensors' driver, the interface is slightly
       different! See below.
@@ -259,17 +259,10 @@ detected at a specific address, another 
     return i2c_probe(adapter,&addr_data,&foo_detect_client);
   }
 
-For `sensors' drivers, use the i2c_detect function instead:
-  
-  int foo_attach_adapter(struct i2c_adapter *adapter)
-  { 
-    return i2c_detect(adapter,&addr_data,&foo_detect_client);
-  }
-
 Remember, structure `addr_data' is defined by the macros explained above,
 so you do not have to define it yourself.
 
-The i2c_probe or i2c_detect function will call the foo_detect_client
+The i2c_probe function will call the foo_detect_client
 function only for those i2c addresses that actually have a device on
 them (unless a `force' parameter was used). In addition, addresses that
 are already in use (by some other registered client) are skipped.
@@ -278,11 +271,9 @@ are already in use (by some other regist
 The detect client function
 --------------------------
 
-The detect client function is called by i2c_probe or i2c_detect.
-The `kind' parameter contains 0 if this call is due to a `force'
-parameter, and -1 otherwise (for i2c_detect, it contains 0 if
-this call is due to the generic `force' parameter, and the chip type
-number if it is due to a specific `force' parameter).
+The detect client function is called by i2c_probe. The `kind' parameter
+contains -1 for a probed detection, 0 for a forced detection, or a positive
+number for a forced detection with a chip type forced.
 
 Below, some things are only needed if this is a `sensors' driver. Those
 parts are between /* SENSORS ONLY START */ and /* SENSORS ONLY END */
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -187,7 +187,7 @@ static int adm1021_attach_adapter(struct
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1021_detect);
+	return i2c_probe(adapter, &addr_data, adm1021_detect);
 }
 
 static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -314,7 +314,7 @@ static int adm1025_attach_adapter(struct
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1025_detect);
+	return i2c_probe(adapter, &addr_data, adm1025_detect);
 }
 
 /*
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -321,7 +321,7 @@ int adm1026_attach_adapter(struct i2c_ad
 	if (!(adapter->class & I2C_CLASS_HWMON)) {
 		return 0;
 	}
-	return i2c_detect(adapter, &addr_data, adm1026_detect);
+	return i2c_probe(adapter, &addr_data, adm1026_detect);
 }
 
 int adm1026_detach_client(struct i2c_client *client)
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -727,10 +727,10 @@ static int adm1031_attach_adapter(struct
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm1031_detect);
+	return i2c_probe(adapter, &addr_data, adm1031_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -635,7 +635,7 @@ static int adm9240_attach_adapter(struct
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, adm9240_detect);
+	return i2c_probe(adapter, &addr_data, adm9240_detect);
 }
 
 static int adm9240_detach_client(struct i2c_client *client)
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -621,7 +621,7 @@ static int asb100_attach_adapter(struct 
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, asb100_detect);
+	return i2c_probe(adapter, &addr_data, asb100_detect);
 }
 
 static int asb100_detect_subclients(struct i2c_adapter *adapter, int address,
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -254,7 +254,7 @@ static DEVICE_ATTR(gpio2, S_IRUGO | S_IW
 
 static int atxp1_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, &atxp1_detect);
+	return i2c_probe(adapter, &addr_data, &atxp1_detect);
 };
 
 static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -181,10 +181,10 @@ static DEVICE_ATTR(temp1_max, S_IWUSR | 
 
 static int ds1621_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, ds1621_detect);
+	return i2c_probe(adapter, &addr_data, ds1621_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int ds1621_detect(struct i2c_adapter *adapter, int address,
                   int kind)
 {
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -289,7 +289,7 @@ static int fscher_attach_adapter(struct 
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, fscher_detect);
+	return i2c_probe(adapter, &addr_data, fscher_detect);
 }
 
 static int fscher_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -436,7 +436,7 @@ static int fscpos_attach_adapter(struct 
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, fscpos_detect);
+	return i2c_probe(adapter, &addr_data, fscpos_detect);
 }
 
 int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -348,7 +348,7 @@ static int gl518_attach_adapter(struct i
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, gl518_detect);
+	return i2c_probe(adapter, &addr_data, gl518_detect);
 }
 
 static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -520,7 +520,7 @@ static int gl520_attach_adapter(struct i
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, gl520_detect);
+	return i2c_probe(adapter, &addr_data, gl520_detect);
 }
 
 static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -698,7 +698,7 @@ static int it87_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, it87_detect);
+	return i2c_probe(adapter, &addr_data, it87_detect);
 }
 
 static int it87_isa_attach_adapter(struct i2c_adapter *adapter)
@@ -738,7 +738,7 @@ exit:
 	return err;
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -360,7 +360,7 @@ static int lm63_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm63_detect);
+	return i2c_probe(adapter, &addr_data, lm63_detect);
 }
 
 /*
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -109,10 +109,10 @@ static int lm75_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm75_detect);
+	return i2c_probe(adapter, &addr_data, lm75_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -209,10 +209,10 @@ static int lm77_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm77_detect);
+	return i2c_probe(adapter, &addr_data, lm77_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int lm77_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -478,7 +478,7 @@ static int lm78_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm78_detect);
+	return i2c_probe(adapter, &addr_data, lm78_detect);
 }
 
 static int lm78_isa_attach_adapter(struct i2c_adapter *adapter)
@@ -486,7 +486,7 @@ static int lm78_isa_attach_adapter(struc
 	return lm78_detect(adapter, isa_address, -1);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, err;
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -391,7 +391,7 @@ static int lm80_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm80_detect);
+	return i2c_probe(adapter, &addr_data, lm80_detect);
 }
 
 int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -214,7 +214,7 @@ static int lm83_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm83_detect);
+	return i2c_probe(adapter, &addr_data, lm83_detect);
 }
 
 /*
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1012,7 +1012,7 @@ int lm85_attach_adapter(struct i2c_adapt
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm85_detect);
+	return i2c_probe(adapter, &addr_data, lm85_detect);
 }
 
 int lm85_detect(struct i2c_adapter *adapter, int address,
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -539,7 +539,7 @@ static int lm87_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm87_detect);
+	return i2c_probe(adapter, &addr_data, lm87_detect);
 }
 
 /*
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -354,7 +354,7 @@ static int lm90_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm90_detect);
+	return i2c_probe(adapter, &addr_data, lm90_detect);
 }
 
 /*
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -389,7 +389,7 @@ static int lm92_attach_adapter(struct i2
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, lm92_detect);
+	return i2c_probe(adapter, &addr_data, lm92_detect);
 }
 
 static int lm92_detach_client(struct i2c_client *client)
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -180,7 +180,7 @@ static int max1619_attach_adapter(struct
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, max1619_detect);
+	return i2c_probe(adapter, &addr_data, max1619_detect);
 }
 
 /*
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -869,7 +869,7 @@ w83781d_attach_adapter(struct i2c_adapte
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83781d_detect);
+	return i2c_probe(adapter, &addr_data, w83781d_detect);
 }
 
 static int
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1076,7 +1076,7 @@ w83792d_attach_adapter(struct i2c_adapte
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83792d_detect);
+	return i2c_probe(adapter, &addr_data, w83792d_detect);
 }
 
 
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -142,7 +142,7 @@ static int w83l785ts_attach_adapter(stru
 {
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_detect(adapter, &addr_data, w83l785ts_detect);
+	return i2c_probe(adapter, &addr_data, w83l785ts_detect);
 }
 
 /*
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -226,7 +226,7 @@ int ds1337_do_command(int bus, int cmd, 
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, ds1337_detect);
+	return i2c_probe(adapter, &addr_data, ds1337_detect);
 }
 
 /*
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -152,10 +152,10 @@ static struct bin_attribute eeprom_attr 
 
 static int eeprom_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, eeprom_detect);
+	return i2c_probe(adapter, &addr_data, eeprom_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -161,10 +161,10 @@ static struct bin_attribute user_eeprom_
 
 static int max6875_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, max6875_detect);
+	return i2c_probe(adapter, &addr_data, max6875_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int max6875_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *real_client;
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -108,10 +108,10 @@ static struct attribute_group pca9539_de
 
 static int pca9539_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pca9539_detect);
+	return i2c_probe(adapter, &addr_data, pca9539_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -112,10 +112,10 @@ static DEVICE_ATTR(write, S_IWUSR | S_IR
 
 static int pcf8574_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pcf8574_detect);
+	return i2c_probe(adapter, &addr_data, pcf8574_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -163,10 +163,10 @@ static DEVICE_ATTR(out0_enable, S_IWUSR 
  */
 static int pcf8591_attach_adapter(struct i2c_adapter *adapter)
 {
-	return i2c_detect(adapter, &addr_data, pcf8591_detect);
+	return i2c_probe(adapter, &addr_data, pcf8591_detect);
 }
 
-/* This function is called by i2c_detect */
+/* This function is called by i2c_probe */
 int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;

