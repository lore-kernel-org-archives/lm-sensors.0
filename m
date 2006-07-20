From: apgo@patchbomb.org (Arthur Othieno)
Date: Thu, 20 Jul 2006 00:28:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: re-order CONFIG_HWMON_DEBUG_CHIP
Message-Id: <20060720002807.GD8584@krypton>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move CONFIG_HWMON_DEBUG_CHIP higher up so it's more accessible.

Signed-off-by: Arthur Othieno <apgo at patchbomb.org>
---
 drivers/hwmon/Kconfig |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0e31a0c..5284491 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -23,6 +23,16 @@ config HWMON
 	  This support can also be built as a module.  If so, the module
 	  will be called hwmon.
 
+config HWMON_DEBUG_CHIP
+	bool "Hardware Monitoring Chip debugging messages"
+	depends on HWMON
+	default n
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
 config HWMON_VID
 	tristate
 	default n
@@ -507,14 +517,4 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
-config HWMON_DEBUG_CHIP
-	bool "Hardware Monitoring Chip debugging messages"
-	depends on HWMON
-	default n
-	help
-	  Say Y here if you want the I2C chip drivers to produce a bunch of
-	  debug messages to the system log.  Select this if you are having
-	  a problem with I2C support and want to see more of what is going
-	  on.
-
 endmenu
-- 
1.4.0


