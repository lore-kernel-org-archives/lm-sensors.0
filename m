From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 03 Jul 2007 11:17:25 +0000
Subject: [lm-sensors] Patch: hwmon-fscher-individual-alarm-files.patch
Message-Id: <468A3045.1010307@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030809020801070703010601"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809020801070703010601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

As promised a patch adding individual alarm and fault files to the fscher
driver.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------030809020801070703010601
Content-Type: text/x-patch;
 name="hwmon-fscher-individual-alarm-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-fscher-individual-alarm-files.patch"

As promised a patch adding individual alarm and fault files to the fscher
driver.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up drivers/hwmon/fscher.c.alarms drivers/hwmon/fscher.c
--- drivers/hwmon/fscher.c.alarms	2007-04-26 05:08:32.000000000 +0200
+++ drivers/hwmon/fscher.c	2007-07-03 13:14:07.000000000 +0200
@@ -192,7 +192,7 @@ static DEVICE_ATTR(kind##offset##sub, S_
 
 #define sysfs_ro(kind, sub, reg) \
 sysfs_r(kind, sub, 0, reg) \
-static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
+static DEVICE_ATTR(kind##sub, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
 sysfs_rw_n(pwm,        , offset, reg_min) \
@@ -202,6 +202,7 @@ sysfs_ro_n(fan, _input , offset, reg_act
 
 #define sysfs_temp(offset, reg_status, reg_act) \
 sysfs_rw_n(temp, _status, offset, reg_status) \
+sysfs_ro_n(temp, _fault , offset, reg_status) \
 sysfs_ro_n(temp, _input , offset, reg_act)
     
 #define sysfs_in(offset, reg_act) \
@@ -210,7 +211,13 @@ sysfs_ro_n(in, _input, offset, reg_act)
 #define sysfs_revision(reg_revision) \
 sysfs_ro(revision, , reg_revision)
 
+/* Only fan 1 and temp 1 have an alarm, so we add them here and not to
+   sysfs_fan / sysfs_temp */
 #define sysfs_alarms(reg_events) \
+sysfs_ro_n(fan, _alarm , 1, reg_events) \
+sysfs_ro_n(temp, _alarm , 1, reg_events) \
+sysfs_ro(control, _alarm, reg_events) \
+sysfs_ro(watchdog, _alarm, reg_events) \
 sysfs_ro(alarms, , reg_events)
 
 #define sysfs_control(reg_control) \
@@ -245,10 +252,12 @@ static struct attribute *fscher_attribut
 	&dev_attr_revision.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_control.attr,
+	&dev_attr_control_alarm.attr,
 
 	&dev_attr_watchdog_status.attr,
 	&dev_attr_watchdog_control.attr,
 	&dev_attr_watchdog_preset.attr,
+	&dev_attr_watchdog_alarm.attr,
 
 	&dev_attr_in0_input.attr,
 	&dev_attr_in1_input.attr,
@@ -257,6 +266,7 @@ static struct attribute *fscher_attribut
 	&dev_attr_fan1_status.attr,
 	&dev_attr_fan1_div.attr,
 	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_alarm.attr,
 	&dev_attr_pwm1.attr,
 	&dev_attr_fan2_status.attr,
 	&dev_attr_fan2_div.attr,
@@ -269,10 +279,14 @@ static struct attribute *fscher_attribut
 
 	&dev_attr_temp1_status.attr,
 	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_fault.attr,
+	&dev_attr_temp1_alarm.attr,
 	&dev_attr_temp2_status.attr,
 	&dev_attr_temp2_input.attr,
+	&dev_attr_temp2_fault.attr,
 	&dev_attr_temp3_status.attr,
 	&dev_attr_temp3_input.attr,
+	&dev_attr_temp3_fault.attr,
 	NULL
 };
 
@@ -531,6 +545,13 @@ static ssize_t show_fan_input (struct fs
 	return sprintf(buf, "%u\n", RPM_FROM_REG(data->fan_act[FAN_INDEX_FROM_NUM(nr)]));
 }
 
+static ssize_t show_fan_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x01)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
 
 
 #define TEMP_INDEX_FROM_NUM(nr)		((nr) - 1)
@@ -554,6 +575,15 @@ static ssize_t show_temp_status(struct f
 	return sprintf(buf, "%u\n", data->temp_status[TEMP_INDEX_FROM_NUM(nr)] & 0x03);
 }
 
+static ssize_t show_temp_fault(struct fscher_data *data, char *buf, int nr)
+{
+	/* bit 0 set means sensor working ok, so no fault! */
+	if (data->temp_status[TEMP_INDEX_FROM_NUM(nr)] & 0x01)
+		return sprintf(buf, "0\n");
+	else
+		return sprintf(buf, "1\n");
+}
+
 #define TEMP_FROM_REG(val)	(((val) - 128) * 1000)
 
 static ssize_t show_temp_input(struct fscher_data *data, char *buf, int nr)
@@ -561,6 +591,14 @@ static ssize_t show_temp_input(struct fs
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_act[TEMP_INDEX_FROM_NUM(nr)]));
 }
 
+static ssize_t show_temp_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x02)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
 /*
  * The final conversion is specified in sensors.conf, as it depends on
  * mainboard specific values. We export the registers contents as
@@ -611,6 +649,13 @@ static ssize_t show_control(struct fsche
 	return sprintf(buf, "%u\n", data->global_control & 0x01);
 }
 
+static ssize_t show_control_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x10)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
 
 
 static ssize_t set_watchdog_control(struct i2c_client *client, struct
@@ -670,6 +715,14 @@ static ssize_t show_watchdog_preset(stru
 	return sprintf(buf, "%u\n", data->watchdog[0]);
 }
 
+static ssize_t show_watchdog_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x08)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
 static int __init sensors_fscher_init(void)
 {
 	return i2c_add_driver(&fscher_driver);

--------------030809020801070703010601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030809020801070703010601--

