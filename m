From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 03 Jul 2007 12:54:20 +0000
Subject: [lm-sensors] PATCH: hwmon-fscpos-individual-alarm-files.patch
Message-Id: <468A46FC.5070505@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090703000207070003060500"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090703000207070003060500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Since the fscpos is very similar to the fscher I've written a patch adding
individual alarm and fault files for the fscpos too.

Notice that:
- This patch assumes the masks for the global event register for the
   fscpos are identical as those for the fscher, I couldn't verify this as I
   don't have a datasheet, but otherwise the 2 are nearly 100% identical, so
   this seems a reasonably safe assumption
- Since I do not have a machine with such a beast this patch is NOT tested!

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans


p.s.

The fscpos and fscher really are very similar, up to the point where I wonder 
why not support the 2 from one driver?

--------------090703000207070003060500
Content-Type: text/x-patch;
 name="hwmon-fscpos-individual-alarm-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-fscpos-individual-alarm-files.patch"

Since the fscpos is very similar to the fscher I've written a patch adding
individual alarm and fault files for the fscpos too.

Notice that:
- This patch assumes the masks for the global event register for the
  fscpos are identical as those for the fscher, I couldn't verify this as I
  don't have a datasheet, but otherwise the 2 are nearly 100% identical, so
  this seems a reasonably safe assumption
- Since I do not have a machine with such a beast this patch is NOT tested!

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up drivers/hwmon/fscpos.c~ drivers/hwmon/fscpos.c
--- drivers/hwmon/fscpos.c~	2007-07-03 14:34:43.000000000 +0200
+++ drivers/hwmon/fscpos.c	2007-07-03 14:42:59.000000000 +0200
@@ -150,6 +150,15 @@ static ssize_t show_temp_status(struct f
 	return sprintf(buf, "%u\n", data->temp_status[nr - 1] & 0x03);
 }
 
+static ssize_t show_temp_fault(struct fscpos_data *data, char *buf, int nr)
+{
+	/* bit 0 set means sensor working ok, so no fault! */
+	if (data->temp_status[nr - 1] & 0x01)
+		return sprintf(buf, "0\n");
+	else
+		return sprintf(buf, "1\n");
+}
+
 static ssize_t show_temp_reset(struct fscpos_data *data, char *buf, int nr)
 {
 	return sprintf(buf, "1\n");
@@ -241,6 +250,31 @@ static ssize_t set_pwm(struct i2c_client
 	return count;
 }
 
+static ssize_t show_fan_alarm (struct fscpos_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x01)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t show_temp_alarm (struct fscpos_data *data, char *buf, int nr)
+{
+	if (data->global_event & 0x02)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t show_wdog_alarm (struct fscpos_data *data, char *buf)
+{
+	if (data->global_event & 0x08)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+
 static void reset_fan_alarm(struct i2c_client *client, int nr)
 {
 	fscpos_write_value(client, FSCPOS_REG_FAN_STATE[nr], 4);
@@ -386,6 +420,10 @@ static ssize_t show_event(struct device 
 	create_getter_n(kind, offset, sub); \
 	create_sysfs_device_ro(kind, sub, offset);
 
+#define sysfs_ro(kind, sub) \
+	create_getter(kind, sub); \
+	create_sysfs_device_ro(kind, sub,);
+
 #define sysfs_rw_n(kind, sub, offset, reg) \
 	create_getter_n(kind, offset, sub); \
 	create_setter_n(kind, offset, sub, reg); \
@@ -408,6 +446,7 @@ static ssize_t show_event(struct device 
 #define sysfs_temp(offset, reg_status) \
 	sysfs_ro_n(temp, _input, offset); \
 	sysfs_ro_n(temp, _status, offset); \
+	sysfs_ro_n(temp, _fault , offset); \
 	sysfs_rw_n(temp, _reset, offset, reg_status);
 
 #define sysfs_watchdog(reg_wdog_preset, reg_wdog_state, reg_wdog_control) \
@@ -415,6 +454,13 @@ static ssize_t show_event(struct device 
 	sysfs_rw(wdog, _preset, reg_wdog_preset); \
 	sysfs_rw(wdog, _state, reg_wdog_state);
 
+/* Only fan 1 and temp 1 have an alarm, so we add them here and not to
+   sysfs_fan / sysfs_temp */
+#define sysfs_alarms() \
+	sysfs_ro_n(fan, _alarm, 1); \
+	sysfs_ro_n(temp, _alarm, 1); \
+	sysfs_ro(wdog, _alarm);
+
 sysfs_fan_with_min(1, FSCPOS_REG_FAN_STATE[0], FSCPOS_REG_FAN_RIPPLE[0],
 							FSCPOS_REG_PWM[0]);
 sysfs_fan_with_min(2, FSCPOS_REG_FAN_STATE[1], FSCPOS_REG_FAN_RIPPLE[1],
@@ -428,6 +474,8 @@ sysfs_temp(3, FSCPOS_REG_TEMP_STATE[2]);
 sysfs_watchdog(FSCPOS_REG_WDOG_PRESET, FSCPOS_REG_WDOG_STATE,
 						FSCPOS_REG_WDOG_CONTROL);
 
+sysfs_alarms();
+
 static DEVICE_ATTR(event, S_IRUGO, show_event, NULL);
 static DEVICE_ATTR(in0_input, S_IRUGO, show_volt_12, NULL);
 static DEVICE_ATTR(in1_input, S_IRUGO, show_volt_5, NULL);
@@ -442,20 +490,26 @@ static struct attribute *fscpos_attribut
 	&dev_attr_wdog_control.attr,
 	&dev_attr_wdog_preset.attr,
 	&dev_attr_wdog_state.attr,
+	&dev_attr_wdog_alarm.attr,
 
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_status.attr,
 	&dev_attr_temp1_reset.attr,
+	&dev_attr_temp1_fault.attr,
+	&dev_attr_temp1_alarm.attr,
 	&dev_attr_temp2_input.attr,
 	&dev_attr_temp2_status.attr,
 	&dev_attr_temp2_reset.attr,
+	&dev_attr_temp2_fault.attr,
 	&dev_attr_temp3_input.attr,
 	&dev_attr_temp3_status.attr,
 	&dev_attr_temp3_reset.attr,
+	&dev_attr_temp3_fault.attr,
 
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_status.attr,
 	&dev_attr_fan1_ripple.attr,
+	&dev_attr_fan1_alarm.attr,
 	&dev_attr_pwm1.attr,
 	&dev_attr_fan2_input.attr,
 	&dev_attr_fan2_status.attr,

--------------090703000207070003060500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090703000207070003060500--

