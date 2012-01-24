From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:57 +0000
Subject: [lm-sensors] [PATCH 78/79] hwmon: (it87) Constify fixed string arrays
Message-Id: <1327373398-997-79-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Make checkpatch happy by constifying fixed string arrays.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 93a197b..0b204e4 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1341,12 +1341,12 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 static ssize_t show_label(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	static const char *labels[] = {
+	static const char * const labels[] = {
 		"+5V",
 		"5VSB",
 		"Vbat",
 	};
-	static const char *labels_it8721[] = {
+	static const char * const labels_it8721[] = {
 		"+3.3V",
 		"3VSB",
 		"Vbat",
@@ -1815,7 +1815,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	int err = 0, i;
 	int enable_pwm_interface;
 	int fan_beep_need_rw;
-	static const char *names[] = {
+	static const char * const names[] = {
 		"it87",
 		"it8712",
 		"it8716",
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
