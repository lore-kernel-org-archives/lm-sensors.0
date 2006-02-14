From: gregkh@suse.de (Greg Kroah-Hartman)
Date: Tue, 14 Feb 2006 06:48:21 +0000
Subject: [lm-sensors] [PATCH 1/5] vt8231: Fix sysfs temperature interface
Message-Id: <1139899701986-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The VT8231 low temperature limits are actually hysteresis temperatures
to the high limits.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Roger Lucas <roger at planbit.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/hwmon/vt8231.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

e3efa5a7392e07471b5d0ef7e7cd7ab862f70284
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 3eb08f0..271e9cb 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -437,12 +437,12 @@ static SENSOR_DEVICE_ATTR(temp##offset##
 		show_temp, NULL, offset - 1);				\
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
 		show_temp_max, set_temp_max, offset - 1);		\
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR,	\
 		show_temp_min, set_temp_min, offset - 1)
 
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp0, NULL);
 static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp0_max, set_temp0_max);
-static DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp0_min, set_temp0_min);
+static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp0_min, set_temp0_min);
 
 define_temperature_sysfs(2);
 define_temperature_sysfs(3);
@@ -451,7 +451,7 @@ define_temperature_sysfs(5);
 define_temperature_sysfs(6);
 
 #define CFG_INFO_TEMP(id)	{ &sensor_dev_attr_temp##id##_input.dev_attr, \
-				&sensor_dev_attr_temp##id##_min.dev_attr, \
+				&sensor_dev_attr_temp##id##_max_hyst.dev_attr, \
 				&sensor_dev_attr_temp##id##_max.dev_attr }
 #define CFG_INFO_VOLT(id)	{ &sensor_dev_attr_in##id##_input.dev_attr, \
 				&sensor_dev_attr_in##id##_min.dev_attr, \
@@ -464,7 +464,7 @@ struct str_device_attr_table {
 };
 
 static struct str_device_attr_table cfg_info_temp[] = {
-	{ &dev_attr_temp1_input, &dev_attr_temp1_min, &dev_attr_temp1_max },
+	{ &dev_attr_temp1_input, &dev_attr_temp1_max_hyst, &dev_attr_temp1_max },
 	CFG_INFO_TEMP(2),
 	CFG_INFO_TEMP(3),
 	CFG_INFO_TEMP(4),



