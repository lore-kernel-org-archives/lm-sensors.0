From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 26 Apr 2014 05:29:52 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (jc42) Add support for STTS2004 and AT30TSE004
Message-Id: <1398490192-593-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Also fix links to datasheets for other supported sensors from
ST Microelectronics, and add links to several Atmel datasheets.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/jc42 |   16 ++++++++++------
 drivers/hwmon/jc42.c     |    9 +++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index 868d74d..f3893f7 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -5,9 +5,12 @@ Supported chips:
   * Analog Devices ADT7408
     Datasheets:
 	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
-  * Atmel AT30TS00
+  * Atmel AT30TS00, AT30TS002A/B, AT30TSE004A
     Datasheets:
 	http://www.atmel.com/Images/doc8585.pdf
+	http://www.atmel.com/Images/doc8711.pdf
+	http://www.atmel.com/Images/Atmel-8852-SEEPROM-AT30TSE002A-Datasheet.pdf
+	http://www.atmel.com/Images/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf
   * IDT TSE2002B3, TSE2002GB2, TS3000B3, TS3000GB2
     Datasheets:
 	http://www.idt.com/sites/default/files/documents/IDT_TSE2002B3C_DST_20100512_120303152056.pdf
@@ -34,12 +37,13 @@ Supported chips:
     Datasheet:
 	http://www.onsemi.com/pub_link/Collateral/CAT34TS02-D.PDF
 	http://www.onsemi.com/pub/Collateral/CAT6095-D.PDF
-  * ST Microelectronics STTS424, STTS424E02, STTS2002, STTS3000
+  * ST Microelectronics STTS424, STTS424E02, STTS2002, STTS2004, STTS3000
     Datasheets:
-	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00157556.pdf
-	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00157558.pdf
-	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00225278.pdf
-	http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATA_BRIEF/CD00270920.pdf
+	http://www.st.com/web/en/resource/technical/document/datasheet/CD00157556.pdf
+	http://www.st.com/web/en/resource/technical/document/datasheet/CD00157558.pdf
+	http://www.st.com/web/en/resource/technical/document/datasheet/CD00266638.pdf
+	http://www.st.com/web/en/resource/technical/document/datasheet/CD00225278.pdf
+	http://www.st.com/web/en/resource/technical/document/datasheet/DM00076709.pdf
   * JEDEC JC 42.4 compliant temperature sensor chips
     Datasheet:
 	http://www.jedec.org/sites/default/files/docs/4_01_04R19.pdf
diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index baa912a..388f8bc 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -65,6 +65,7 @@ static const unsigned short normal_i2c[] = {
 /* Manufacturer IDs */
 #define ADT_MANID		0x11d4  /* Analog Devices */
 #define ATMEL_MANID		0x001f  /* Atmel */
+#define ATMEL_MANID2		0x1114	/* Atmel */
 #define MAX_MANID		0x004d  /* Maxim */
 #define IDT_MANID		0x00b3  /* IDT */
 #define MCP_MANID		0x0054  /* Microchip */
@@ -82,6 +83,9 @@ static const unsigned short normal_i2c[] = {
 #define AT30TS00_DEVID		0x8201
 #define AT30TS00_DEVID_MASK	0xffff
 
+#define AT30TSE004_DEVID	0x2200
+#define AT30TSE004_DEVID_MASK	0xffff
+
 /* IDT */
 #define TS3000B3_DEVID		0x2903  /* Also matches TSE2002B3 */
 #define TS3000B3_DEVID_MASK	0xffff
@@ -130,6 +134,9 @@ static const unsigned short normal_i2c[] = {
 #define STTS2002_DEVID		0x0300
 #define STTS2002_DEVID_MASK	0xffff
 
+#define STTS2004_DEVID		0x2201
+#define STTS2004_DEVID_MASK	0xffff
+
 #define STTS3000_DEVID		0x0200
 #define STTS3000_DEVID_MASK	0xffff
 
@@ -144,6 +151,7 @@ struct jc42_chips {
 static struct jc42_chips jc42_chips[] = {
 	{ ADT_MANID, ADT7408_DEVID, ADT7408_DEVID_MASK },
 	{ ATMEL_MANID, AT30TS00_DEVID, AT30TS00_DEVID_MASK },
+	{ ATMEL_MANID2, AT30TSE004_DEVID, AT30TSE004_DEVID_MASK },
 	{ IDT_MANID, TS3000B3_DEVID, TS3000B3_DEVID_MASK },
 	{ IDT_MANID, TS3000GB2_DEVID, TS3000GB2_DEVID_MASK },
 	{ MAX_MANID, MAX6604_DEVID, MAX6604_DEVID_MASK },
@@ -158,6 +166,7 @@ static struct jc42_chips jc42_chips[] = {
 	{ STM_MANID, STTS424_DEVID, STTS424_DEVID_MASK },
 	{ STM_MANID, STTS424E_DEVID, STTS424E_DEVID_MASK },
 	{ STM_MANID, STTS2002_DEVID, STTS2002_DEVID_MASK },
+	{ STM_MANID, STTS2004_DEVID, STTS2004_DEVID_MASK },
 	{ STM_MANID, STTS3000_DEVID, STTS3000_DEVID_MASK },
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
