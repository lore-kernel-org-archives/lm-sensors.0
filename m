From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:07 +0000
Subject: [lm-sensors] [PATCH 41/44] [PATCH] hwmon: Fix the Kconfig header
Message-Id: <115100105316-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Hardware monitoring chips don't have to be on the I2C bus.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6fb93d6..43e1f08 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1,5 +1,5 @@
 #
-# I2C Sensor chip drivers configuration
+# Hardware monitoring chip drivers configuration
 #
 
 menu "Hardware Monitoring support"
-- 
1.4.0


