From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 08 Mar 2012 16:26:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Remove unnecessary device IDs
Message-Id: <1331223985-21810-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We don't really use or need separate device IDs for the various JC42.4 compliant
chips, so remove them and only retain 'jc42'.

Also update a datasheet references for SE98A, STTS424, and STTS424E02.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
TBD: Should we merge "Prefix" and "Addresses scanned" lines in Documentation ?

 Documentation/hwmon/jc42 |   33 +++++++++++++--------------------
 drivers/hwmon/jc42.c     |   18 ------------------
 2 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index 52729a7..74a2995 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -3,17 +3,17 @@ Kernel driver jc42
 
 Supported chips:
   * Analog Devices ADT7408
-    Prefix: 'adt7408'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
   * Atmel AT30TS00
-    Prefix: 'at30ts00'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://www.atmel.com/Images/doc8585.pdf
   * IDT TSE2002B3, TSE2002GB2, TS3000B3, TS3000GB2
-    Prefix: 'tse2002', 'ts3000'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://www.idt.com/sites/default/files/documents/IDT_TSE2002B3C_DST_20100512_120303152056.pdf
@@ -21,45 +21,38 @@ Supported chips:
 	http://www.idt.com/sites/default/files/documents/IDT_TS3000B3A_DST_20101129_120303152013.pdf
 	http://www.idt.com/sites/default/files/documents/IDT_TS3000GB2A1_DST_20111104_120303151012.pdf
   * Maxim MAX6604
-    Prefix: 'max6604'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
   * Microchip MCP9804, MCP9805, MCP98242, MCP98243, MCP9843
-    Prefixes: 'mcp9804', 'mcp9805', 'mcp98242', 'mcp98243', 'mcp9843'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
-  * NXP Semiconductors SE97, SE97B
-    Prefix: 'se97'
+  * NXP Semiconductors SE97, SE97B, SE98, SE98A
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://www.nxp.com/documents/data_sheet/SE97.pdf
 	http://www.nxp.com/documents/data_sheet/SE97B.pdf
-  * NXP Semiconductors SE98
-    Prefix: 'se98'
-    Addresses scanned: I2C 0x18 - 0x1f
-    Datasheets:
 	http://www.nxp.com/documents/data_sheet/SE98.pdf
+	http://www.nxp.com/documents/data_sheet/SE98A.pdf
   * ON Semiconductor CAT34TS02, CAT6095
-    Prefix: 'cat34ts02', 'cat6095'
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheet:
 	http://www.onsemi.com/pub_link/Collateral/CAT34TS02-D.PDF
 	http://www.onsemi.com/pub/Collateral/CAT6095-D.PDF
-  * ST Microelectronics STTS424, STTS424E02
-    Prefix: 'stts424'
-    Addresses scanned: I2C 0x18 - 0x1f
-    Datasheets:
-	http://www.st.com/stonline/products/literature/ds/13447/stts424.pdf
-	http://www.st.com/stonline/products/literature/ds/13448/stts424e02.pdf
-  * ST Microelectronics STTS2002, STTS3000
-    Prefix: 'stts2002', 'stts3000'
+  * ST Microelectronics STTS424, STTS424E02, STTS2002, STTS3000
+    Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
+	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00157556.pdf
+	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00157558.pdf
 	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00225278.pdf
 	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATA_BRIEF/CD00270920.pdf
   * JEDEC JC 42.4 compliant temperature sensor chips
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index a002bda..a9bfd67 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -180,25 +180,7 @@ static int jc42_remove(struct i2c_client *client);
 static struct jc42_data *jc42_update_device(struct device *dev);
 
 static const struct i2c_device_id jc42_id[] = {
-	{ "adt7408", 0 },
-	{ "at30ts00", 0 },
-	{ "cat94ts02", 0 },
-	{ "cat6095", 0 },
 	{ "jc42", 0 },
-	{ "max6604", 0 },
-	{ "mcp9804", 0 },
-	{ "mcp9805", 0 },
-	{ "mcp98242", 0 },
-	{ "mcp98243", 0 },
-	{ "mcp9843", 0 },
-	{ "se97", 0 },
-	{ "se97b", 0 },
-	{ "se98", 0 },
-	{ "stts424", 0 },
-	{ "stts2002", 0 },
-	{ "stts3000", 0 },
-	{ "tse2002", 0 },
-	{ "ts3000", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, jc42_id);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
