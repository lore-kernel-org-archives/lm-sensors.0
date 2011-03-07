From: Axel Lin <axel.lin@gmail.com>
Date: Mon, 07 Mar 2011 03:05:33 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: twl4030-madc-hwmon: add "platform:"
Message-Id: <1299467133.3879.5.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299466949.3879.0.camel@mola>
In-Reply-To: <1299466949.3879.0.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: J Keerthy <j-keerthy@ti.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

Since 43cc71eed1250755986da4c0f9898f9a635cb3bf (platform: prefix MODALIAS
with "platform:"), the platform modalias is prefixed with "platform:".

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/twl4030-madc-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
index 97e22be..de58191 100644
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -154,4 +154,4 @@ module_exit(twl4030_madc_hwmon_exit);
 MODULE_DESCRIPTION("TWL4030 ADC Hwmon driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("J Keerthy");
-MODULE_ALIAS("twl4030_madc_hwmon");
+MODULE_ALIAS("platform:twl4030_madc_hwmon");
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
