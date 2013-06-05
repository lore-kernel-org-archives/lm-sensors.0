From: Alexander Shiyan <shc_work@mail.ru>
Date: Wed, 05 Jun 2013 08:57:08 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: mc13783-adc: Rename unit to indicate various MC13xxx chips support
Message-Id: <1370422628-1073-2-git-send-email-shc_work@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/imx_v4_v5_defconfig           |  2 +-
 drivers/hwmon/Kconfig                          | 10 +++++-----
 drivers/hwmon/Makefile                         |  2 +-
 drivers/hwmon/{mc13783-adc.c => mc13xxx-adc.c} |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/hwmon/{mc13783-adc.c => mc13xxx-adc.c} (100%)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 7fd9f9b..ba5b640 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -114,7 +114,7 @@ CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
 CONFIG_HWMON=m
-CONFIG_SENSORS_MC13783_ADC=m
+CONFIG_SENSORS_MC13XXX_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_MC13XXX_SPI=y
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4f71370..c28a362 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1526,11 +1526,11 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
-config SENSORS_MC13783_ADC
-        tristate "Freescale MC13783/MC13892 ADC"
-        depends on MFD_MC13XXX
-        help
-          Support for the A/D converter on MC13783 and MC13892 PMIC.
+config SENSORS_MC13XXX_ADC
+	tristate "Freescale MC13783/MC13892 ADC"
+	depends on MFD_MC13XXX
+	help
+	  Support for the A/D converter on MC13783 and MC13892 PMIC.
 
 if ACPI
 
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d17d3e6..b0cbc36f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -106,7 +106,7 @@ obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
-obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_MC13XXX_ADC)+= mc13xxx-adc.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13xxx-adc.c
similarity index 100%
rename from drivers/hwmon/mc13783-adc.c
rename to drivers/hwmon/mc13xxx-adc.c
-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
