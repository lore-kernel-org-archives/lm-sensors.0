From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Apr 2013 00:44:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Expand scope of supported chips
Message-Id: <1364949858-2805-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6775, NCT6776, and NCT6779 have a number of variants with the same
chip ID but different chip labels. Add text "or compatible" to the
message displayed when the driver is loaded and rephrase the Kconfig
entry to reflect that it also supports compatible chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/nct6775 |    8 ++++----
 drivers/hwmon/Kconfig       |    8 ++++----
 drivers/hwmon/nct6775.c     |   17 ++++++++---------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
index 3f5587e..4e9ef60 100644
--- a/Documentation/hwmon/nct6775
+++ b/Documentation/hwmon/nct6775
@@ -8,15 +8,15 @@ Kernel driver NCT6775
 ========== 
 Supported chips:
-  * Nuvoton NCT6775F/W83667HG-I
+  * Nuvoton NCT5572D/NCT6771F/NCT6772F/NCT6775F/W83677HG-I
     Prefix: 'nct6775'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
-  * Nuvoton NCT6776F
+  * Nuvoton NCT5577D/NCT6776D/NCT6776F
     Prefix: 'nct6776'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
-  * Nuvoton NCT6779D
+  * Nuvoton NCT5532D/NCT6779D
     Prefix: 'nct6779'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
@@ -28,7 +28,7 @@ Description
 -----------
 
 This driver implements support for the Nuvoton NCT6775F, NCT6776F, and NCT6779D
-super I/O chips.
+and compatible super I/O chips.
 
 The chips support up to 25 temperature monitoring sources. Up to 6 of those are
 direct temperature sensor inputs, the others are special sources such as PECI,
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4986961..26ebff0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -908,14 +908,14 @@ config SENSORS_MCP3021
 	  will be called mcp3021.
 
 config SENSORS_NCT6775
-	tristate "Nuvoton NCT6775F, NCT6776F, NCT6779D"
+	tristate "Nuvoton NCT6775F and compatibles"
 	depends on !PPC
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware monitoring
-	  functionality of the Nuvoton NCT6775F, NCT6776F, and NCT6779D
-	  Super-I/O chips. This driver replaces the w83627ehf driver for
-	  NCT6775F and NCT6776F.
+	  functionality of the Nuvoton NCT6775F, NCT6776F, NCT6779D
+	  and compatible Super-I/O chips. This driver replaces the
+	  w83627ehf driver for NCT6775F and NCT6776F.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called nct6775.
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index d3a4cca..c1a275a 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3465,16 +3465,17 @@ static struct platform_driver nct6775_driver = {
 	.remove		= nct6775_remove,
 };
 
+static const char *nct6775_sio_names[] __initconst = {
+	"NCT6775F",
+	"NCT6776D/F",
+	"NCT6779D",
+};
+
 /* nct6775_find() looks for a '627 in the Super-I/O config space */
 static int __init nct6775_find(int sioaddr, unsigned short *addr,
 			       struct nct6775_sio_data *sio_data)
 {
-	static const char sio_name_NCT6775[] __initconst = "NCT6775F";
-	static const char sio_name_NCT6776[] __initconst = "NCT6776F";
-	static const char sio_name_NCT6779[] __initconst = "NCT6779D";
-
 	u16 val;
-	const char *sio_name;
 	int err;
 
 	err = superio_enter(sioaddr);
@@ -3489,15 +3490,12 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 	switch (val & SIO_ID_MASK) {
 	case SIO_NCT6775_ID:
 		sio_data->kind = nct6775;
-		sio_name = sio_name_NCT6775;
 		break;
 	case SIO_NCT6776_ID:
 		sio_data->kind = nct6776;
-		sio_name = sio_name_NCT6776;
 		break;
 	case SIO_NCT6779_ID:
 		sio_data->kind = nct6779;
-		sio_name = sio_name_NCT6779;
 		break;
 	default:
 		if (val != 0xffff)
@@ -3525,7 +3523,8 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 	}
 
 	superio_exit(sioaddr);
-	pr_info("Found %s chip at %#x\n", sio_name, *addr);
+	pr_info("Found %s or compatible chip at %#x\n",
+		nct6775_sio_names[sio_data->kind], *addr);
 	sio_data->sioreg = sioaddr;
 
 	return 0;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
