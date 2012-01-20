From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:25 +0000
Subject: [lm-sensors] [PATCH 13/13] hwmon: (wm8350-hwmon) Constify fixed string array
Message-Id: <1327088365-11149-14-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Constify fixed string array and make checkpatch happy.

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
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
