From: Donggeun Kim <dg77.kim@samsung.com>
Date: Thu, 17 Nov 2011 10:33:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix dependency of EXYNOS4 TMU
Message-Id: <1321525985-25572-1-git-send-email-dg77.kim@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The dependency of EXYNOS4 TMU in Kconfig is renamed to the existing one.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9ec854a..91be41f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -315,7 +315,7 @@ config SENSORS_DS1621
 
 config SENSORS_EXYNOS4_TMU
 	tristate "Temperature sensor on Samsung EXYNOS4"
-	depends on EXYNOS4_DEV_TMU
+	depends on ARCH_EXYNOS4
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS4 series of SoC.
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
