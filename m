From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Mar 2012 13:32:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Add support for ST Microelectronics STTS2002 and STTS3000
Message-Id: <20120305143200.676d045b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These are fully compatible with Jedec JC 42.4 as far as I can see.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/jc42 |    6 ++++++
 drivers/hwmon/Kconfig    |    3 ++-
 drivers/hwmon/jc42.c     |   10 ++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

--- linux-3.3-rc6.orig/Documentation/hwmon/jc42	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.3-rc6/Documentation/hwmon/jc42	2012-03-05 14:30:40.173271570 +0100
@@ -48,6 +48,12 @@ Supported chips:
     Datasheets:
 	http://www.st.com/stonline/products/literature/ds/13447/stts424.pdf
 	http://www.st.com/stonline/products/literature/ds/13448/stts424e02.pdf
+  * ST Microelectronics STTS2002, STTS3000
+    Prefix: 'stts2002', 'stts3000'
+    Addresses scanned: I2C 0x18 - 0x1f
+    Datasheets:
+	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00225278.pdf
+	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATA_BRIEF/CD00270920.pdf
   * JEDEC JC 42.4 compliant temperature sensor chips
     Prefix: 'jc42'
     Addresses scanned: I2C 0x18 - 0x1f
--- linux-3.3-rc6.orig/drivers/hwmon/Kconfig	2012-03-04 14:13:20.000000000 +0100
+++ linux-3.3-rc6/drivers/hwmon/Kconfig	2012-03-05 13:50:41.319038596 +0100
@@ -498,7 +498,8 @@ config SENSORS_JC42
 	  temperature sensors, which are used on many DDR3 memory modules for
 	  mobile devices and servers.  Support will include, but not be limited
 	  to, ADT7408, CAT34TS02, CAT6095, MAX6604, MCP9805, MCP98242, MCP98243,
-	  MCP9843, SE97, SE98, STTS424(E), TSE2002B3, and TS3000B3.
+	  MCP9843, SE97, SE98, STTS424(E), STTS2002, STTS3000, TSE2002B3, and
+	  TS3000B3.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called jc42.
--- linux-3.3-rc6.orig/drivers/hwmon/jc42.c	2012-01-20 14:06:38.000000000 +0100
+++ linux-3.3-rc6/drivers/hwmon/jc42.c	2012-03-05 13:51:46.439039562 +0100
@@ -113,6 +113,12 @@ static const unsigned short normal_i2c[]
 #define STTS424E_DEVID		0x0000
 #define STTS424E_DEVID_MASK	0xfffe
 
+#define STTS2002_DEVID		0x0300
+#define STTS2002_DEVID_MASK	0xffff
+
+#define STTS3000_DEVID		0x0200
+#define STTS3000_DEVID_MASK	0xffff
+
 static u16 jc42_hysteresis[] = { 0, 1500, 3000, 6000 };
 
 struct jc42_chips {
@@ -133,6 +139,8 @@ static struct jc42_chips jc42_chips[]  	{ NXP_MANID, SE98_DEVID, SE98_DEVID_MASK },
 	{ STM_MANID, STTS424_DEVID, STTS424_DEVID_MASK },
 	{ STM_MANID, STTS424E_DEVID, STTS424E_DEVID_MASK },
+	{ STM_MANID, STTS2002_DEVID, STTS2002_DEVID_MASK },
+	{ STM_MANID, STTS3000_DEVID, STTS3000_DEVID_MASK },
 };
 
 /* Each client has this additional data */
@@ -171,6 +179,8 @@ static const struct i2c_device_id jc42_i
 	{ "se97b", 0 },
 	{ "se98", 0 },
 	{ "stts424", 0 },
+	{ "stts2002", 0 },
+	{ "stts3000", 0 },
 	{ "tse2002b3", 0 },
 	{ "ts3000b3", 0 },
 	{ }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
