From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:24 +0000
Subject: [lm-sensors] [PATCH 12/13] hwmon: (smm655) Fix checkpatch error
Message-Id: <1327088365-11149-13-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:
ERROR: Macros with complex values should be enclosed in parenthesis

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smm665.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 5ae028b..5877078 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -124,9 +124,9 @@ enum chips { smm465, smm665, smm665c, smm764, smm766 };
 #define SMM665_AIN_ADC_TO_VOLTS(adc)   ((adc) * vref / 512)
 
 /* Temp Sensor */
-#define SMM665_TEMP_ADC_TO_CELSIUS(adc) ((adc) <= 511) ?		   \
+#define SMM665_TEMP_ADC_TO_CELSIUS(adc) (((adc) <= 511) ?		   \
 					 ((int)(adc) * 1000 / 4) :	   \
-					 (((int)(adc) - 0x400) * 1000 / 4)
+					 (((int)(adc) - 0x400) * 1000 / 4))
 
 #define SMM665_NUM_ADC		11
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
