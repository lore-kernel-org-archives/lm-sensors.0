From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 29 Oct 2012 08:34:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: da9055: Fix chan_mux[DA9055_ADC_ADCIN3] setting
Message-Id: <1351499678.14725.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: David Dajun Chen <dchen@diasemi.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Set chan_mux[DA9055_ADC_ADCIN3] = DA9055_ADC_MUX_ADCIN3.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
  This looks like a typo, but I don't have a hardware to test it.
Axel
 drivers/hwmon/da9055-hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
index 0b41f2c..3a3377c 100644
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -54,7 +54,7 @@ static const u8 chan_mux[DA9055_ADC_TJUNC + 1] = {
 	[DA9055_ADC_VSYS]	= DA9055_ADC_MUX_VSYS,
 	[DA9055_ADC_ADCIN1]	= DA9055_ADC_MUX_ADCIN1,
 	[DA9055_ADC_ADCIN2]	= DA9055_ADC_MUX_ADCIN2,
-	[DA9055_ADC_ADCIN3]	= DA9055_ADC_MUX_ADCIN1,
+	[DA9055_ADC_ADCIN3]	= DA9055_ADC_MUX_ADCIN3,
 	[DA9055_ADC_TJUNC]	= DA9055_ADC_MUX_T_SENSE,
 };
 
-- 
1.7.9.5




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
