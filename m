From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 28 Jan 2010 16:02:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: (s3c-hwmon): S3C hwmon requires S3C_ADC
Message-Id: <1264694548-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The S3C hwmon driver uses the core s3c ADC API so needs to either depend
on or select it otherwise the kernel will fail to link.  For ease of use
selecting seems simpler, the shared ADC core is pretty much an
implementation detail.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/hwmon/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 90db0ba..cc810e7 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -704,6 +704,7 @@ config SENSORS_SHT15
 config SENSORS_S3C
 	tristate "S3C24XX/S3C64XX Inbuilt ADC"
 	depends on ARCH_S3C2410 || ARCH_S3C64XX
+	select S3C_ADC
 	help
 	  If you say yes here you get support for the on-board ADCs of
 	  the Samsung S3C24XX or S3C64XX series of SoC
-- 
1.6.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
