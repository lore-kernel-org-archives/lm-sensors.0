From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 12 Feb 2015 14:15:16 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (coretemp) Allow format checking
Message-Id: <1423750517-26439-2-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

By extracting the only part that differs we can allow static checking
of the format string, and possibly save a little .rodata.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hwmon/coretemp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5b7fec824f10..0e873bca98a4 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -397,14 +397,13 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 			struct device_attribute *devattr, char *buf) = {
 			show_label, show_crit_alarm, show_temp, show_tjmax,
 			show_ttarget };
-	static const char *const names[TOTAL_ATTRS] = {
-					"temp%d_label", "temp%d_crit_alarm",
-					"temp%d_input", "temp%d_crit",
-					"temp%d_max" };
+	static const char *const suffixes[TOTAL_ATTRS] = {
+		"label", "crit_alarm", "input", "crit", "max"
+	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
-		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
-			attr_no);
+		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
+			"temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
