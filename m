From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 29 Jan 2008 14:02:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Discard useless I2C driver IDs
Message-Id: <20080129140214.GM29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103194409.7f04100f@hyperion.delvare>
In-Reply-To: <20080103194409.7f04100f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 19:44:09 +0100]:
> Many I2C hwmon drivers define a driver ID but no other code references
> these, meaning that they are useless. Discard them, along with a few
> IDs which are defined but never used at all.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>


I've applied the following patch to hwmon-2.6.git/testing.  It's almost
identical to your original, just revised to apply to my tree in the
absence of your i2c tree  (as we discussed on IRC).  Thanks.

commit 8631334aadb4b7165face9fdccfcebb2cc346b2a
Author: Jean Delvare <khali@linux-fr.org>
Date:   Thu Jan 3 19:44:09 2008 +0100

    hwmon: Discard useless I2C driver IDs
    
    Many I2C hwmon drivers define a driver ID but no other code references
    these, meaning that they are useless. Discard them, along with a few
    IDs which are defined but never used at all.
    
    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index ebdc6d7..b96be77 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -115,7 +115,6 @@ static struct i2c_driver adm1021_driver = {
 	.driver = {
 		.name	= "adm1021",
 	},
-	.id		= I2C_DRIVERID_ADM1021,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index c7a365a..33cc58b 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -123,7 +123,6 @@ static struct i2c_driver adm1025_driver = {
 	.driver = {
 		.name	= "adm1025",
 	},
-	.id		= I2C_DRIVERID_ADM1025,
 	.attach_adapter	= adm1025_attach_adapter,
 	.detach_client	= adm1025_detach_client,
 };
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index c17d0b6..7887192 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -141,7 +141,6 @@ static struct i2c_driver adm9240_driver = {
 	.driver = {
 		.name	= "adm9240",
 	},
-	.id		= I2C_DRIVERID_ADM9240,
 	.attach_adapter	= adm9240_attach_adapter,
 	.detach_client	= adm9240_detach_client,
 };
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 9460dba..815493b 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -221,7 +221,6 @@ static struct i2c_driver asb100_driver = {
 	.driver = {
 		.name	= "asb100",
 	},
-	.id		= I2C_DRIVERID_ASB100,
 	.attach_adapter	= asb100_attach_adapter,
 	.detach_client	= asb100_detach_client,
 };
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index b7bd000..3f5163d 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -94,7 +94,6 @@ static struct i2c_driver ds1621_driver = {
 	.driver = {
 		.name	= "ds1621",
 	},
-	.id		= I2C_DRIVERID_DS1621,
 	.attach_adapter	= ds1621_attach_adapter,
 	.detach_client	= ds1621_detach_client,
 };
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index e67c369..721c701 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -123,7 +123,6 @@ static struct i2c_driver fscher_driver = {
 	.driver = {
 		.name	= "fscher",
 	},
-	.id		= I2C_DRIVERID_FSCHER,
 	.attach_adapter	= fscher_attach_adapter,
 	.detach_client	= fscher_detach_client,
 };
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index 92c9703..2f10753 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -105,7 +105,6 @@ static struct i2c_driver fscpos_driver = {
 	.driver = {
 		.name	= "fscpos",
 	},
-	.id		= I2C_DRIVERID_FSCPOS,
 	.attach_adapter	= fscpos_attach_adapter,
 	.detach_client	= fscpos_detach_client,
 };
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 37a8cc0..e5c35a3 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -74,7 +74,6 @@ static struct i2c_driver lm75_driver = {
 	.driver = {
 		.name	= "lm75",
 	},
-	.id		= I2C_DRIVERID_LM75,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 934378e..0a9eb1f 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -168,7 +168,6 @@ static struct i2c_driver lm78_driver = {
 	.driver = {
 		.name	= "lm78",
 	},
-	.id		= I2C_DRIVERID_LM78,
 	.attach_adapter	= lm78_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 063cdba..0bde0a3 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -147,7 +147,6 @@ static struct i2c_driver lm80_driver = {
 	.driver = {
 		.name	= "lm80",
 	},
-	.id		= I2C_DRIVERID_LM80,
 	.attach_adapter	= lm80_attach_adapter,
 	.detach_client	= lm80_detach_client,
 };
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 0336b45..6e8903a 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -133,7 +133,6 @@ static struct i2c_driver lm83_driver = {
 	.driver = {
 		.name	= "lm83",
 	},
-	.id		= I2C_DRIVERID_LM83,
 	.attach_adapter	= lm83_attach_adapter,
 	.detach_client	= lm83_detach_client,
 };
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 9f1c6f1..43212db 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -367,7 +367,6 @@ static struct i2c_driver lm85_driver = {
 	.driver = {
 		.name   = "lm85",
 	},
-	.id             = I2C_DRIVERID_LM85,
 	.attach_adapter = lm85_attach_adapter,
 	.detach_client  = lm85_detach_client,
 };
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 3ab4c3f..7bedf74 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -171,7 +171,6 @@ static struct i2c_driver lm87_driver = {
 	.driver = {
 		.name	= "lm87",
 	},
-	.id		= I2C_DRIVERID_LM87,
 	.attach_adapter	= lm87_attach_adapter,
 	.detach_client	= lm87_detach_client,
 };
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 116093d..f7ec95b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -204,7 +204,6 @@ static struct i2c_driver lm90_driver = {
 	.driver = {
 		.name	= "lm90",
 	},
-	.id		= I2C_DRIVERID_LM90,
 	.attach_adapter	= lm90_attach_adapter,
 	.detach_client	= lm90_detach_client,
 };
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 61d1bd1..af5c77d 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -428,7 +428,6 @@ static struct i2c_driver lm92_driver = {
 	.driver = {
 		.name	= "lm92",
 	},
-	.id		= I2C_DRIVERID_LM92,
 	.attach_adapter	= lm92_attach_adapter,
 	.detach_client	= lm92_detach_client,
 };
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index b5db354..1d6259d 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -96,7 +96,6 @@ static struct i2c_driver w83l785ts_driver = {
 	.driver = {
 		.name	= "w83l785ts",
 	},
-	.id		= I2C_DRIVERID_W83L785TS,
 	.attach_adapter	= w83l785ts_attach_adapter,
 	.detach_client	= w83l785ts_detach_client,
 };
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
index 1a7eeeb..8de2b4a 100644
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -71,7 +71,6 @@ static struct i2c_driver eeprom_driver = {
 	.driver = {
 		.name	= "eeprom",
 	},
-	.id		= I2C_DRIVERID_EEPROM,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
index 21c6dd6..56ed213 100644
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -65,7 +65,6 @@ static struct i2c_driver pcf8574_driver = {
 	.driver = {
 		.name	= "pcf8574",
 	},
-	.id		= I2C_DRIVERID_PCF8574,
 	.attach_adapter	= pcf8574_attach_adapter,
 	.detach_client	= pcf8574_detach_client,
 };
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
index 4dc3637..61834fd 100644
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -92,7 +92,6 @@ static struct i2c_driver pcf8591_driver = {
 	.driver = {
 		.name	= "pcf8591",
 	},
-	.id		= I2C_DRIVERID_PCF8591,
 	.attach_adapter	= pcf8591_attach_adapter,
 	.detach_client	= pcf8591_detach_client,
 };
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 1382de8..3240825 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -130,39 +130,6 @@
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
 #define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
 
-/* IDs --   Use DRIVERIDs 1000-1999 for sensors.
-   These were originally in sensors.h in the lm_sensors package */
-#define I2C_DRIVERID_LM78 1002
-#define I2C_DRIVERID_LM75 1003
-#define I2C_DRIVERID_EEPROM 1005
-#define I2C_DRIVERID_LM80 1007
-#define I2C_DRIVERID_ADM1021 1008
-#define I2C_DRIVERID_ADM9240 1009
-#define I2C_DRIVERID_LTC1710 1010
-#define I2C_DRIVERID_BT869 1013
-#define I2C_DRIVERID_MAXILIFE 1014
-#define I2C_DRIVERID_MATORB 1015
-#define I2C_DRIVERID_THMC50 1017
-#define I2C_DRIVERID_ADM1025 1020
-#define I2C_DRIVERID_LM87 1021
-#define I2C_DRIVERID_PCF8574 1022
-#define I2C_DRIVERID_MTP008 1023
-#define I2C_DRIVERID_DS1621 1024
-#define I2C_DRIVERID_ADM1024 1025
-#define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
-#define I2C_DRIVERID_FSCPOS 1028
-#define I2C_DRIVERID_FSCSCY 1029
-#define I2C_DRIVERID_PCF8591 1030
-#define I2C_DRIVERID_LM92 1033
-#define I2C_DRIVERID_SMARTBATT 1035
-#define I2C_DRIVERID_BMCSENSORS 1036
-#define I2C_DRIVERID_FS451 1037
-#define I2C_DRIVERID_LM85 1039
-#define I2C_DRIVERID_LM83 1040
-#define I2C_DRIVERID_LM90 1042
-#define I2C_DRIVERID_ASB100 1043
-#define I2C_DRIVERID_FSCHER 1046
-#define I2C_DRIVERID_W83L785TS 1047
 #define I2C_DRIVERID_OV7670 1048	/* Omnivision 7670 camera */
 
 /*

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
