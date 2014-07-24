From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Jul 2014 00:58:24 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Update module description and Kconfig for NCT6106D and NCT
Message-Id: <1406163504.7561.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This driver also supports NCT6106D and NCT6791D, thus update module description
and Kconfig accordingly.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/Kconfig   | 4 ++--
 drivers/hwmon/nct6775.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c0aec8d..27e4e56 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1105,8 +1105,8 @@ config SENSORS_NCT6775
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware monitoring
-	  functionality of the Nuvoton NCT6775F, NCT6776F, NCT6779D
-	  and compatible Super-I/O chips. This driver replaces the
+	  functionality of the Nuvoton NCT6106D, NCT6775F, NCT6776F, NCT6779D,
+	  NCT6791D and compatible Super-I/O chips. This driver replaces the
 	  w83627ehf driver for NCT6775F and NCT6776F.
 
 	  This driver can also be built as a module.  If so, the module
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 59d9a3f..1c98655 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4221,7 +4221,7 @@ static void __exit sensors_nct6775_exit(void)
 }
 
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("NCT6775F/NCT6776F/NCT6779D driver");
+MODULE_DESCRIPTION("NCT6106D/NCT6775F/NCT6776F/NCT6779D/NCT6791D driver");
 MODULE_LICENSE("GPL");
 
 module_init(sensors_nct6775_init);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
