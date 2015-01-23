From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 23 Jan 2015 09:27:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Allow negative hysteresis temperatures
Message-Id: <20150123102703.4ff3ce85@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The driver supports negative high and critical limits, it can return
negative hysteresis values, so there is no good reason to not let the
user write negative hysteresis values.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-3.17.orig/drivers/hwmon/jc42.c	2015-01-23 09:59:38.603261084 +0100
+++ linux-3.17/drivers/hwmon/jc42.c	2015-01-23 10:17:46.522752214 +0100
@@ -304,15 +304,16 @@ static ssize_t set_temp_crit_hyst(struct
 				  const char *buf, size_t count)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
-	unsigned long val;
+	long val;
 	int diff, hyst;
 	int err;
 	int ret = count;
 
-	if (kstrtoul(buf, 10, &val) < 0)
+	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
-	val = clamp_val(val, 0, JC42_TEMP_MAX);
+	val = clamp_val(val, (data->extended ? JC42_TEMP_MIN_EXTENDED :
+			      JC42_TEMP_MIN) - 6000, JC42_TEMP_MAX);
 	diff = jc42_temp_from_reg(data->temp[t_crit]) - val;
 
 	hyst = 0;


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
