From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 26 Jan 2010 11:16:17 +0000
Subject: [lm-sensors] [PATCH 2/2] HWMON: Add s3c64xx support to s3c-hwmon
Message-Id: <b2e8f9f71001260316h7fe29effn290648178ff42397@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, lm-sensors@lm-sensors.org

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/hwmon/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68cf877..a8a267c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -702,7 +702,7 @@ config SENSORS_SHT15

 config SENSORS_S3C
 	tristate "S3C24XX/S3C64XX Inbuilt ADC"
-	depends on ARCH_S3C2410
+	depends on ARCH_S3C2410 || ARCH_S3C64XX
 	help
 	  If you say yes here you get support for the on-board ADCs of
 	  the Samsung S3C24XX or S3C64XX series of SoC
-- 
1.6.6.1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
