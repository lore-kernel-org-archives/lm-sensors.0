From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:39 +0000
Subject: [lm-sensors] [PATCH 16/17] drivers/hwmon/wm831x-hwmon.c: fix
Message-Id: <1326039820-11147-16-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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
