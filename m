From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jan 2010 17:00:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Add support for the
Message-Id: <20100113180047.315f5564@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This chips is found on several Zotac Ion ITX boards, amongst others.

Signed-off-by: Jean Delvare <khali@llinux-fr.org>
Cc: MC Matti <mcmatti17@googlemail.com>
Cc: Manuel Lamotte-Schubert <mls@pronego.com>
---
 Documentation/hwmon/lm90 |   10 ++++++++++
 drivers/hwmon/Kconfig    |    5 +++--
 drivers/hwmon/lm90.c     |   12 +++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

--- linux-2.6.33-rc4.orig/Documentation/hwmon/lm90	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc4/Documentation/hwmon/lm90	2010-01-13 17:35:27.000000000 +0100
@@ -84,6 +84,10 @@ Supported chips:
     Addresses scanned: I2C 0x4c
     Datasheet: Publicly available at the Maxim website
                http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3500
+  * Winbond/Nuvoton W83L771AWG/ASG
+    Prefix: 'w83l771'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Not publicly available, can be requested from Nuvoton
 
 
 Author: Jean Delvare <khali@linux-fr.org>
@@ -147,6 +151,12 @@ MAX6680 and MAX6681:
   * Selectable address
   * Remote sensor type selection
 
+W83L771AWG/ASG
+  * The AWG and ASG variants only differ in package format.
+  * Filter and alert configuration register at 0xBF
+  * Diode ideality factor configuration (remote sensor) at 0xE3
+  * Moving average (depending on conversion rate)
+
 All temperature values are given in degrees Celsius. Resolution
 is 1.0 degree for the local temperature, 0.125 degree for the remote
 temperature, except for the MAX6657, MAX6658 and MAX6659 which have a
--- linux-2.6.33-rc4.orig/drivers/hwmon/Kconfig	2010-01-13 09:16:42.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/Kconfig	2010-01-13 16:56:03.000000000 +0100
@@ -563,9 +563,10 @@ config SENSORS_LM90
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, and Maxim
+	  LM86, LM89 and LM99, Analog Devices ADM1032 and ADT7461, Maxim
 	  MAX6646, MAX6647, MAX6648, MAX6649, MAX6657, MAX6658, MAX6659,
-	  MAX6680, MAX6681 and MAX6692 sensor chips.
+	  MAX6680, MAX6681 and MAX6692, and Winbond/Nuvoton W83L771AWG/ASG
+	  sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
--- linux-2.6.33-rc4.orig/drivers/hwmon/lm90.c	2009-12-18 08:34:09.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/lm90.c	2010-01-13 16:58:44.000000000 +0100
@@ -93,7 +93,8 @@
 static const unsigned short normal_i2c[] = {
 	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646 };
+enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646,
+	w83l771 };
 
 /*
  * The LM90 registers
@@ -173,6 +174,7 @@ static const struct i2c_device_id lm90_i
 	{ "max6659", max6657 },
 	{ "max6680", max6680 },
 	{ "max6681", max6680 },
+	{ "w83l771", w83l771 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm90_id);
@@ -758,6 +760,14 @@ static int lm90_detect(struct i2c_client
 		 && reg_convrate <= 0x07) {
 			name = "max6646";
 		}
+	} else
+	if (address = 0x4C
+	 && man_id = 0x5C) { /* Winbond/Nuvoton */
+		if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
+		 && (reg_config1 & 0x2A) = 0x00
+		 && reg_convrate <= 0x08) {
+			name = "w83l771";
+		}
 	}
 
 	if (!name) { /* identification failed */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
