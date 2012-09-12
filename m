From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Sep 2012 16:51:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Update Kconfig to reference IT8782F and IT8783E/F
Message-Id: <1347468661-24147-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add missing reference to IT8782F and IT8783E/F to it87 driver description
in Kconfig.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..a90195b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -495,8 +495,8 @@ config SENSORS_IT87
 	select HWMON_VID
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
-	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F and IT8758E
-	  sensor chips, and the SiS960 clone.
+	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
+	  IT8782F, and IT8783E/F sensor chips, and the SiS960 clone.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
