From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Jan 2013 04:36:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Add support for MCP98244
Message-Id: <1359434171-21043-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/jc42 |    3 ++-
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/jc42.c     |    4 ++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index 66ecb9f..1650771 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -17,12 +17,13 @@ Supported chips:
   * Maxim MAX6604
     Datasheets:
 	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
-  * Microchip MCP9804, MCP9805, MCP98242, MCP98243, MCP9843
+  * Microchip MCP9804, MCP9805, MCP98242, MCP98243, MCP98244, MCP9843
     Datasheets:
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
 	http://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
+	http://ww1.microchip.com/downloads/en/DeviceDoc/22327A.pdf
   * NXP Semiconductors SE97, SE97B, SE98, SE98A
     Datasheets:
 	http://www.nxp.com/documents/data_sheet/SE97.pdf
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 32f238f..befdb4d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -529,8 +529,8 @@ config SENSORS_JC42
 	  temperature sensors, which are used on many DDR3 memory modules for
 	  mobile devices and servers.  Support will include, but not be limited
 	  to, ADT7408, AT30TS00, CAT34TS02, CAT6095, MAX6604, MCP9804, MCP9805,
-	  MCP98242, MCP98243, MCP9843, SE97, SE98, STTS424(E), STTS2002,
-	  STTS3000, TSE2002B3, TSE2002GB2, TS3000B3, and TS3000GB2.
+	  MCP98242, MCP98243, MCP98244, MCP9843, SE97, SE98, STTS424(E),
+	  STTS2002, STTS3000, TSE2002B3, TSE2002GB2, TS3000B3, and TS3000GB2.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called jc42.
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index e21e43c..87e888f 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -103,6 +103,9 @@ static const unsigned short normal_i2c[] = {
 #define MCP98243_DEVID		0x2100
 #define MCP98243_DEVID_MASK	0xfffc
 
+#define MCP98244_DEVID		0x2200
+#define MCP98244_DEVID_MASK	0xfffc
+
 #define MCP9843_DEVID		0x0000	/* Also matches mcp9805 */
 #define MCP9843_DEVID_MASK	0xfffe
 
@@ -147,6 +150,7 @@ static struct jc42_chips jc42_chips[] = {
 	{ MCP_MANID, MCP9804_DEVID, MCP9804_DEVID_MASK },
 	{ MCP_MANID, MCP98242_DEVID, MCP98242_DEVID_MASK },
 	{ MCP_MANID, MCP98243_DEVID, MCP98243_DEVID_MASK },
+	{ MCP_MANID, MCP98244_DEVID, MCP98244_DEVID_MASK },
 	{ MCP_MANID, MCP9843_DEVID, MCP9843_DEVID_MASK },
 	{ NXP_MANID, SE97_DEVID, SE97_DEVID_MASK },
 	{ ONS_MANID, CAT6095_DEVID, CAT6095_DEVID_MASK },
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
