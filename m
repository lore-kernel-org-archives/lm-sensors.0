From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:11 +0000
Subject: [lm-sensors] [PATCH 32/79] hwmon: (wm8350-hwmon) Constify fixed string array
Message-Id: <1327373398-997-33-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Constify fixed string array and make checkpatch happy.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/wm8350-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/wm8350-hwmon.c b/drivers/hwmon/wm8350-hwmon.c
index 3ff67ed..b955756 100644
--- a/drivers/hwmon/wm8350-hwmon.c
+++ b/drivers/hwmon/wm8350-hwmon.c
@@ -34,7 +34,7 @@ static ssize_t show_name(struct device *dev,
 	return sprintf(buf, "wm8350\n");
 }
 
-static const char *input_names[] = {
+static const char * const input_names[] = {
 	[WM8350_AUXADC_USB]  = "USB",
 	[WM8350_AUXADC_LINE] = "Line",
 	[WM8350_AUXADC_BATT] = "Battery",
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
