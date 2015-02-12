From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 12 Feb 2015 19:26:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Add support for additional IDT temperature sensors
Message-Id: <1423769172-13519-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TS3000GB0 has a new device ID (0x2913). Since IDT's datasheets suggest
that the upper 8 bit of the device ID reflect the chip ID and the lower
8 bit reflect the version number, modify the code to accept all chips
with ID 0x29xx.

Also add support for TS3001 and TSE2004.

Some of the datasheets for older chips are no longer available from
the IDT web site, so replace explicit links in the documentation with
a generic note.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/jc42 |  8 +++-----
 drivers/hwmon/Kconfig    |  2 +-
 drivers/hwmon/jc42.c     | 16 ++++++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index f3893f7..f7f1830a 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -11,12 +11,10 @@ Supported chips:
 	http://www.atmel.com/Images/doc8711.pdf
 	http://www.atmel.com/Images/Atmel-8852-SEEPROM-AT30TSE002A-Datasheet.pdf
 	http://www.atmel.com/Images/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf
-  * IDT TSE2002B3, TSE2002GB2, TS3000B3, TS3000GB2
+  * IDT TSE2002B3, TSE2002GB2, TSE2004GB2, TS3000B3, TS3000GB0, TS3000GB2,
+	TS3001GB2
     Datasheets:
-	http://www.idt.com/sites/default/files/documents/IDT_TSE2002B3C_DST_20100512_120303152056.pdf
-	http://www.idt.com/sites/default/files/documents/IDT_TSE2002GB2A1_DST_20111107_120303145914.pdf
-	http://www.idt.com/sites/default/files/documents/IDT_TS3000B3A_DST_20101129_120303152013.pdf
-	http://www.idt.com/sites/default/files/documents/IDT_TS3000GB2A1_DST_20111104_120303151012.pdf
+	Available from IDT web site
   * Maxim MAX6604
     Datasheets:
 	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9ea71ea..c80c8a9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -624,7 +624,7 @@ config SENSORS_JC42
 	  mobile devices and servers.  Support will include, but not be limited
 	  to, ADT7408, AT30TS00, CAT34TS02, CAT6095, MAX6604, MCP9804, MCP9805,
 	  MCP98242, MCP98243, MCP98244, MCP9843, SE97, SE98, STTS424(E),
-	  STTS2002, STTS3000, TSE2002B3, TSE2002GB2, TS3000B3, and TS3000GB2.
+	  STTS2002, STTS3000, TSE2002, TSE2004, TS3000, and TS3001.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called jc42.
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 996bdfd..9887d32 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -87,11 +87,14 @@ static const unsigned short normal_i2c[] = {
 #define AT30TSE004_DEVID_MASK	0xffff
 
 /* IDT */
-#define TS3000B3_DEVID		0x2903  /* Also matches TSE2002B3 */
-#define TS3000B3_DEVID_MASK	0xffff
+#define TSE2004_DEVID		0x2200
+#define TSE2004_DEVID_MASK	0xff00
 
-#define TS3000GB2_DEVID		0x2912  /* Also matches TSE2002GB2 */
-#define TS3000GB2_DEVID_MASK	0xffff
+#define TS3000_DEVID		0x2900  /* Also matches TSE2002 */
+#define TS3000_DEVID_MASK	0xff00
+
+#define TS3001_DEVID		0x3000
+#define TS3001_DEVID_MASK	0xff00
 
 /* Maxim */
 #define MAX6604_DEVID		0x3e00
@@ -152,8 +155,9 @@ static struct jc42_chips jc42_chips[] = {
 	{ ADT_MANID, ADT7408_DEVID, ADT7408_DEVID_MASK },
 	{ ATMEL_MANID, AT30TS00_DEVID, AT30TS00_DEVID_MASK },
 	{ ATMEL_MANID2, AT30TSE004_DEVID, AT30TSE004_DEVID_MASK },
-	{ IDT_MANID, TS3000B3_DEVID, TS3000B3_DEVID_MASK },
-	{ IDT_MANID, TS3000GB2_DEVID, TS3000GB2_DEVID_MASK },
+	{ IDT_MANID, TSE2004_DEVID, TSE2004_DEVID_MASK },
+	{ IDT_MANID, TS3000_DEVID, TS3000_DEVID_MASK },
+	{ IDT_MANID, TS3001_DEVID, TS3001_DEVID_MASK },
 	{ MAX_MANID, MAX6604_DEVID, MAX6604_DEVID_MASK },
 	{ MCP_MANID, MCP9804_DEVID, MCP9804_DEVID_MASK },
 	{ MCP_MANID, MCP98242_DEVID, MCP98242_DEVID_MASK },
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
