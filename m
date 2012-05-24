From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 May 2012 20:18:58 +0000
Subject: [lm-sensors] [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-Id: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, linux-next@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Since the watchdog code in sch56xx-common now uses the watchdog core, the
Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
being set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8deedc1..3d16d66 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1036,7 +1036,7 @@ config SENSORS_SCH56XX_COMMON
 
 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
-	depends on !PPC
+	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1048,7 +1048,7 @@ config SENSORS_SCH5627
 
 config SENSORS_SCH5636
 	tristate "SMSC SCH5636"
-	depends on !PPC
+	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	help
 	  SMSC SCH5636 Super I/O chips include an embedded microcontroller for
-- 
1.7.10


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
