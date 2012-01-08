From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:19 +0000
Subject: [lm-sensors] [PATCH 16/17 v2] hwmon: (wm831x-hwmon) fix checkpatch
Message-Id: <1326047660-20539-16-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: static const char * array should probably be static const char * const
#43: FILE: wm831x-hwmon.c:43:
+static const char *input_names[] = {

not fixed (will probably provide separate fix later)
ERROR: Macros with multiple statements should be enclosed in a do - while loop
#98: FILE: wm831x-hwmon.c:98:
+#define WM831X_NAMED_VOLTAGE(id, name) \
+	WM831X_VOLTAGE(id, name); \
+	static SENSOR_DEVICE_ATTR(in##id##_label, S_IRUGO, show_label,	\
+				  NULL, name)

total: 1 errors, 1 warnings, 217 lines checked

wm831x-hwmon.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/wm831x-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index 9b598ed..23b44de 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -40,7 +40,7 @@ static ssize_t show_name(struct device *dev,
 	return sprintf(buf, "wm831x\n");
 }
 
-static const char *input_names[] = {
+static const char * const input_names[] = {
 	[WM831X_AUX_SYSVDD]    = "SYSVDD",
 	[WM831X_AUX_USB]       = "USB",
 	[WM831X_AUX_BKUP_BATT] = "Backup battery",
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
