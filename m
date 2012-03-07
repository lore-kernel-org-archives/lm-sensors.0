From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Mar 2012 16:17:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804
Message-Id: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Also update IDT datasheet locations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/jc42 |   18 +++++++++++++-----
 drivers/hwmon/Kconfig    |    6 +++---
 drivers/hwmon/jc42.c     |   18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index e713375..fd70d23 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -7,21 +7,29 @@ Supported chips:
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
+  * Atmel AT30TS00
+    Prefix: 'at30ts00'
+    Addresses scanned: I2C 0x18 - 0x1f
+    Datasheets:
+	http://www.atmel.com/Images/doc8585.pdf
   * IDT TSE2002B3, TS3000B3
-    Prefix: 'tse2002b3', 'ts3000b3'
+    Prefix: 'tse2002b3', 'tse2002gb2', 'ts3000b3', 'ts300gb2'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
-	http://www.idt.com/products/getdoc.cfm?docid715691
-	http://www.idt.com/products/getdoc.cfm?docid715692
+	http://www.idt.com/sites/default/files/documents/IDT_TSE2002B3C_DST_20100512_120303152056.pdf
+	http://www.idt.com/sites/default/files/documents/IDT_TSE2002GB2A1_DST_20111107_120303145914.pdf
+	http://www.idt.com/sites/default/files/documents/IDT_TS3000B3A_DST_20101129_120303152013.pdf
+	http://www.idt.com/sites/default/files/documents/IDT_TS3000GB2A1_DST_20111104_120303151012.pdf
   * Maxim MAX6604
     Prefix: 'max6604'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
 	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
-  * Microchip MCP9805, MCP98242, MCP98243, MCP9843
-    Prefixes: 'mcp9805', 'mcp98242', 'mcp98243', 'mcp9843'
+  * Microchip MCP9804, MCP9805, MCP98242, MCP98243, MCP9843
+    Prefixes: 'mcp9804', 'mcp9805', 'mcp98242', 'mcp98243', 'mcp9843'
     Addresses scanned: I2C 0x18 - 0x1f
     Datasheets:
+	http://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 91a51af..dad895f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -497,9 +497,9 @@ config SENSORS_JC42
 	  If you say yes here, you get support for JEDEC JC42.4 compliant
 	  temperature sensors, which are used on many DDR3 memory modules for
 	  mobile devices and servers.  Support will include, but not be limited
-	  to, ADT7408, CAT34TS02, CAT6095, MAX6604, MCP9805, MCP98242, MCP98243,
-	  MCP9843, SE97, SE98, STTS424(E), STTS2002, STTS3000, TSE2002B3, and
-	  TS3000B3.
+	  to, ADT7408, AT30TS00, CAT34TS02, CAT6095, MAX6604, MCP9804, MCP9805,
+	  MCP98242, MCP98243, MCP9843, SE97, SE98, STTS424(E), STTS2002,
+	  STTS3000, TSE2002B3, TSE2002GB2, TS3000B3, and TS3000GB2.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called jc42.
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 08430ec..0007f41 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -64,6 +64,7 @@ static const unsigned short normal_i2c[] = {
 
 /* Manufacturer IDs */
 #define ADT_MANID		0x11d4  /* Analog Devices */
+#define ATMEL_MANID		0x001f  /* Atmel */
 #define MAX_MANID		0x004d  /* Maxim */
 #define IDT_MANID		0x00b3  /* IDT */
 #define MCP_MANID		0x0054  /* Microchip */
@@ -77,15 +78,25 @@ static const unsigned short normal_i2c[] = {
 #define ADT7408_DEVID		0x0801
 #define ADT7408_DEVID_MASK	0xffff
 
+/* Atmel */
+#define AT30TS00_DEVID		0x8201
+#define AT30TS00_DEVID_MASK	0xffff
+
 /* IDT */
 #define TS3000B3_DEVID		0x2903  /* Also matches TSE2002B3 */
 #define TS3000B3_DEVID_MASK	0xffff
 
+#define TS3000GB2_DEVID		0x2912  /* Also matches TSE2002GB2 */
+#define TS3000GB2_DEVID_MASK	0xffff
+
 /* Maxim */
 #define MAX6604_DEVID		0x3e00
 #define MAX6604_DEVID_MASK	0xffff
 
 /* Microchip */
+#define MCP9804_DEVID		0x0200
+#define MCP9804_DEVID_MASK	0xfffc
+
 #define MCP98242_DEVID		0x2000
 #define MCP98242_DEVID_MASK	0xfffc
 
@@ -129,8 +140,11 @@ struct jc42_chips {
 
 static struct jc42_chips jc42_chips[] = {
 	{ ADT_MANID, ADT7408_DEVID, ADT7408_DEVID_MASK },
+	{ ATMEL_MANID, AT30TS00_DEVID, AT30TS00_DEVID_MASK },
 	{ IDT_MANID, TS3000B3_DEVID, TS3000B3_DEVID_MASK },
+	{ IDT_MANID, TS3000GB2_DEVID, TS3000GB2_DEVID_MASK },
 	{ MAX_MANID, MAX6604_DEVID, MAX6604_DEVID_MASK },
+	{ MCP_MANID, MCP9804_DEVID, MCP9804_DEVID_MASK },
 	{ MCP_MANID, MCP98242_DEVID, MCP98242_DEVID_MASK },
 	{ MCP_MANID, MCP98243_DEVID, MCP98243_DEVID_MASK },
 	{ MCP_MANID, MCP9843_DEVID, MCP9843_DEVID_MASK },
@@ -167,10 +181,12 @@ static struct jc42_data *jc42_update_device(struct device *dev);
 
 static const struct i2c_device_id jc42_id[] = {
 	{ "adt7408", 0 },
+	{ "at30ts00", 0 },
 	{ "cat94ts02", 0 },
 	{ "cat6095", 0 },
 	{ "jc42", 0 },
 	{ "max6604", 0 },
+	{ "mcp9804", 0 },
 	{ "mcp9805", 0 },
 	{ "mcp98242", 0 },
 	{ "mcp98243", 0 },
@@ -182,7 +198,9 @@ static const struct i2c_device_id jc42_id[] = {
 	{ "stts2002", 0 },
 	{ "stts3000", 0 },
 	{ "tse2002b3", 0 },
+	{ "tse2002gb2", 0 },
 	{ "ts3000b3", 0 },
+	{ "ts3000gb2", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, jc42_id);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
