From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 04 Jul 2007 14:42:57 +0000
Subject: [lm-sensors] PATCH: hwmon-fscpos-individual-alarm-files-v2.patch
Message-Id: <468BB1F1.9010401@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050409010402090605060206"
List-Id: <lm-sensors.vger.kernel.org>
References: <468A46FC.5070505@hhs.nl>
In-Reply-To: <468A46FC.5070505@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409010402090605060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

This is version 2 (non incremental) of the patch adding individual alarm and
fault files to the fscpos driver. This driver uses the status registers for
the alarms instead of the global event register, allowing seperate alarms
for all sensors. Also it makes the _alarm files r/w, writing 0 to them
resets the alarm flag (this is not done automatically be the hardware once an
alarm condition is cleared).

Notice that:
- I now have an PDF so all used registers and masks are verified now
- Since I do not have a machine with such a beast this patch is NOT tested!
- Since writing the alarm files with 0 clears the alarm, the tempX_reset
   sysfs attributes may be removed

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>


Regards,

Hans

--------------050409010402090605060206
Content-Type: text/x-patch; name="hwmon-fscpos-individual-alarm-files-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-fscpos-individual-alarm-files-v2.patch"

This is version 2 (non incremental) of the patch adding individual alarm and
fault files to the fscpos driver. This driver uses the status registers for
the alarms instead of the global event register, allowing seperate alarms
for all sensors. Also it makes the _alarm files r/w, writing 0 to them
resets the alarm flag (this is not done automatically be the hardware once an
alarm condition is cleared).

Notice that:
- I now have an PDF so all used registers and masks are verified now
- Since I do not have a machine with such a beast this patch is NOT tested!
- Since writing the alarm files with 0 clears the alarm, the tempX_reset
  sysfs attributes may be removed

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/fscpos.c~ linux-2.6.22-rc4/drivers/hwmon/fscpos.c
--- linux-2.6.22-rc4/drivers/hwmon/fscpos.c~	2007-07-03 14:34:43.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/fscpos.c	2007-07-04 16:30:00.000000000 +0200
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
@@ -241,6 +250,60 @@ static ssize_t set_pwm(struct i2c_client
 	return count;
 }
 
+static ssize_t set_fan_alarm(struct i2c_client *client, struct fscpos_data *data,
+			      const char *buf, size_t count, int nr, int reg)
+{
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+
+	if (v == 0) { /* clear alarm? */
+		mutex_lock(&data->update_lock);
+		fscpos_write_value(client, reg, 0x04);
+		data->fan_status[nr - 1] &= ~0x04;
+		mutex_unlock(&data->update_lock);
+	}
+	return count;
+}
+
+static ssize_t show_fan_alarm (struct fscpos_data *data, char *buf, int nr)
+{
+	if (data->fan_status[nr - 1] & 0x04)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
+static ssize_t set_temp_alarm(struct i2c_client *client, struct fschpos_data *data,
+			       const char *buf, size_t count, int nr, int reg)
+{
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+
+	if (v == 0) { /* clear alarm? */
+		mutex_lock(&data->update_lock);
+		fscpos_write_value(client, reg, 0x02);
+		data->temp_status[nr - 1] &= ~0x02;
+		mutex_unlock(&data->update_lock);
+	}
+	return count;
+}
+
+static ssize_t show_temp_alarm (struct fscpos_data *data, char *buf, int nr)
+{
+	/* only signal an alarm if the sensor is working and alert == 1 */
+	if ((data->temp_status[nr - 1] & 0x03) == 0x03)
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
@@ -386,6 +449,10 @@ static ssize_t show_event(struct device 
 	create_getter_n(kind, offset, sub); \
 	create_sysfs_device_ro(kind, sub, offset);
 
+#define sysfs_ro(kind, sub) \
+	create_getter(kind, sub); \
+	create_sysfs_device_ro(kind, sub,);
+
 #define sysfs_rw_n(kind, sub, offset, reg) \
 	create_getter_n(kind, offset, sub); \
 	create_setter_n(kind, offset, sub, reg); \
@@ -403,14 +470,18 @@ static ssize_t show_event(struct device 
 #define sysfs_fan(offset, reg_status, reg_ripple) \
 	sysfs_ro_n(fan, _input, offset); \
 	sysfs_ro_n(fan, _status, offset); \
+	sysfs_rw_n(fan, _alarm, offset, reg_status); \
 	sysfs_rw_n(fan, _ripple, offset, reg_ripple);
 
 #define sysfs_temp(offset, reg_status) \
 	sysfs_ro_n(temp, _input, offset); \
 	sysfs_ro_n(temp, _status, offset); \
+	sysfs_rw_n(temp, _alarm, offset, reg_status); \
+	sysfs_ro_n(temp, _fault, offset); \
 	sysfs_rw_n(temp, _reset, offset, reg_status);
 
 #define sysfs_watchdog(reg_wdog_preset, reg_wdog_state, reg_wdog_control) \
+	sysfs_ro(wdog, _alarm); \
 	sysfs_rw(wdog, _control, reg_wdog_control); \
 	sysfs_rw(wdog, _preset, reg_wdog_preset); \
 	sysfs_rw(wdog, _state, reg_wdog_state);
@@ -442,28 +513,38 @@ static struct attribute *fscpos_attribut
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
+	&dev_attr_temp2_alarm.attr,
 	&dev_attr_temp3_input.attr,
 	&dev_attr_temp3_status.attr,
 	&dev_attr_temp3_reset.attr,
+	&dev_attr_temp3_fault.attr,
+	&dev_attr_temp3_alarm.attr,
 
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_status.attr,
 	&dev_attr_fan1_ripple.attr,
+	&dev_attr_fan1_alarm.attr,
 	&dev_attr_pwm1.attr,
 	&dev_attr_fan2_input.attr,
 	&dev_attr_fan2_status.attr,
 	&dev_attr_fan2_ripple.attr,
+	&dev_attr_fan2_alarm.attr,
 	&dev_attr_pwm2.attr,
 	&dev_attr_fan3_input.attr,
 	&dev_attr_fan3_status.attr,
 	&dev_attr_fan3_ripple.attr,
+	&dev_attr_fan3_alarm.attr,
 	NULL
 };
 

--------------050409010402090605060206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050409010402090605060206--

