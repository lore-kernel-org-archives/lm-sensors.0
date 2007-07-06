From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 06 Jul 2007 15:17:41 +0000
Subject: [lm-sensors] PATCH:  hwmon-fscher-individual-alarm-files-v3.patch
Message-Id: <468E5D15.30005@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090309020001050209040104"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309020001050209040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

This is version 3 (non incremental) of the patch adding individual alarm and
fault files to the fscher driver. This version automatically clears alarms
when the condition for them is gone, and adds tempX_max sysfs atrributes.

Notice: this should be the final version, merge please.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------090309020001050209040104
Content-Type: text/x-patch; name="hwmon-fscher-individual-alarm-files-v3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-fscher-individual-alarm-files-v3.patch"

This is version 3 (non incremental) of the patch adding individual alarm and
fault files to the fscher driver. This version automatically clears alarms
when the condition for them is gone, and adds tempX_max sysfs atrributes.

Notice: this should be the final version, merge please.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/fscher.c.alarms linux-2.6.22-rc4/drivers/hwmon/fscher.c
--- linux-2.6.22-rc4/drivers/hwmon/fscher.c.alarms	2007-04-26 05:08:32.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/fscher.c	2007-07-06 17:11:52.000000000 +0200
@@ -67,40 +67,24 @@ I2C_CLIENT_INSMOD_1(fscher);
 #define FSCHER_REG_WDOG_STATE		0x23
 #define FSCHER_REG_WDOG_CONTROL		0x21
 
-/* fan 0 */
-#define FSCHER_REG_FAN0_MIN		0x55
-#define FSCHER_REG_FAN0_ACT		0x0e
-#define FSCHER_REG_FAN0_STATE		0x0d
-#define FSCHER_REG_FAN0_RIPPLE		0x0f
-
-/* fan 1 */
-#define FSCHER_REG_FAN1_MIN		0x65
-#define FSCHER_REG_FAN1_ACT		0x6b
-#define FSCHER_REG_FAN1_STATE		0x62
-#define FSCHER_REG_FAN1_RIPPLE		0x6f
-
-/* fan 2 */
-#define FSCHER_REG_FAN2_MIN		0xb5
-#define FSCHER_REG_FAN2_ACT		0xbb
-#define FSCHER_REG_FAN2_STATE		0xb2
-#define FSCHER_REG_FAN2_RIPPLE		0xbf
-
 /* voltage supervision */
 #define FSCHER_REG_VOLT_12		0x45
 #define FSCHER_REG_VOLT_5		0x42
 #define FSCHER_REG_VOLT_BATT		0x48
 
-/* temperature 0 */
-#define FSCHER_REG_TEMP0_ACT		0x64
-#define FSCHER_REG_TEMP0_STATE		0x71
-
-/* temperature 1 */
-#define FSCHER_REG_TEMP1_ACT		0x32
-#define FSCHER_REG_TEMP1_STATE		0x81
-
-/* temperature 2 */
-#define FSCHER_REG_TEMP2_ACT		0x35
-#define FSCHER_REG_TEMP2_STATE		0x91
+/* fans */
+static const u8 FSCHER_REG_FAN_MIN[] =		{ 0x55, 0x65, 0xb5 };
+static const u8 FSCHER_REG_FAN_ACT[] =		{ 0x0e, 0x6b, 0xbb };
+static const u8 FSCHER_REG_FAN_STATE[] =	{ 0x0d, 0x62, 0xb2 };
+static const u8 FSCHER_REG_FAN_RIPPLE[] =	{ 0x0f, 0x6f, 0xbf };
+
+/* temperatures */
+static const u8 FSCHER_REG_TEMP_ACT[] =		{ 0x64, 0x32, 0x35 };
+static const u8 FSCHER_REG_TEMP_STATE[] =	{ 0x71, 0x81, 0x91 };
+/* notice the 3 below are not on the datasheet, they are reverse engineered
+static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
+static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 }; */
+static const u8 FSCHER_REG_TEMP_MAX[] =		{ 0x76, 0x86, 0x96 };
 
 /*
  * Functions declaration
@@ -147,6 +131,11 @@ struct fscher_data {
 	u8 volt[3];		/* 12, 5, battery voltage */ 
 	u8 temp_act[3];		/* temperature */
 	u8 temp_status[3];	/* status of sensor */
+#if 0 /* These are undocumented, and I'm not 100% sure about them */
+	u8 temp_autop1[3];	/* start accelerating fan if temp above this */
+	u8 temp_autop2[3];	/* put fan at max speed if temp above this */
+#endif
+	u8 temp_max[3];		/* high temp limit, notice: undocumented! */
 	u8 fan_act[3];		/* fans revolutions per second */
 	u8 fan_status[3];	/* fan status */
 	u8 fan_min[3];		/* fan min value for rps */
@@ -192,16 +181,20 @@ static DEVICE_ATTR(kind##offset##sub, S_
 
 #define sysfs_ro(kind, sub, reg) \
 sysfs_r(kind, sub, 0, reg) \
-static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
+static DEVICE_ATTR(kind##sub, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
 sysfs_rw_n(pwm,        , offset, reg_min) \
 sysfs_rw_n(fan, _status, offset, reg_status) \
 sysfs_rw_n(fan, _div   , offset, reg_ripple) \
+sysfs_ro_n(fan, _alarm , offset, reg_status) \
 sysfs_ro_n(fan, _input , offset, reg_act)
 
-#define sysfs_temp(offset, reg_status, reg_act) \
+#define sysfs_temp(offset, reg_status, reg_act, reg_max) \
 sysfs_rw_n(temp, _status, offset, reg_status) \
+sysfs_rw_n(temp, _max   , offset, reg_max) \
+sysfs_ro_n(temp, _alarm , offset, reg_status) \
+sysfs_ro_n(temp, _fault , offset, reg_status) \
 sysfs_ro_n(temp, _input , offset, reg_act)
     
 #define sysfs_in(offset, reg_act) \
@@ -211,6 +204,8 @@ sysfs_ro_n(in, _input, offset, reg_act)
 sysfs_ro(revision, , reg_revision)
 
 #define sysfs_alarms(reg_events) \
+sysfs_ro(control, _alarm, reg_events) \
+sysfs_ro(watchdog, _alarm, reg_events) \
 sysfs_ro(alarms, , reg_events)
 
 #define sysfs_control(reg_control) \
@@ -221,16 +216,19 @@ sysfs_rw(watchdog, _control, reg_control
 sysfs_rw(watchdog, _status , reg_status) \
 sysfs_rw(watchdog, _preset , reg_preset)
 
-sysfs_fan(1, FSCHER_REG_FAN0_STATE, FSCHER_REG_FAN0_MIN,
-	     FSCHER_REG_FAN0_RIPPLE, FSCHER_REG_FAN0_ACT)
-sysfs_fan(2, FSCHER_REG_FAN1_STATE, FSCHER_REG_FAN1_MIN,
-	     FSCHER_REG_FAN1_RIPPLE, FSCHER_REG_FAN1_ACT)
-sysfs_fan(3, FSCHER_REG_FAN2_STATE, FSCHER_REG_FAN2_MIN,
-	     FSCHER_REG_FAN2_RIPPLE, FSCHER_REG_FAN2_ACT)
-
-sysfs_temp(1, FSCHER_REG_TEMP0_STATE, FSCHER_REG_TEMP0_ACT)
-sysfs_temp(2, FSCHER_REG_TEMP1_STATE, FSCHER_REG_TEMP1_ACT)
-sysfs_temp(3, FSCHER_REG_TEMP2_STATE, FSCHER_REG_TEMP2_ACT)
+sysfs_fan(1, FSCHER_REG_FAN_STATE[0], FSCHER_REG_FAN_MIN[0],
+	     FSCHER_REG_FAN_RIPPLE[0], FSCHER_REG_FAN_ACT[0])
+sysfs_fan(2, FSCHER_REG_FAN_STATE[1], FSCHER_REG_FAN_MIN[1],
+	     FSCHER_REG_FAN_RIPPLE[1], FSCHER_REG_FAN_ACT[1])
+sysfs_fan(3, FSCHER_REG_FAN_STATE[2], FSCHER_REG_FAN_MIN[2],
+	     FSCHER_REG_FAN_RIPPLE[2], FSCHER_REG_FAN_ACT[2])
+
+sysfs_temp(1, FSCHER_REG_TEMP_STATE[0], FSCHER_REG_TEMP_ACT[0],
+	      FSCHER_REG_TEMP_MAX[0])
+sysfs_temp(2, FSCHER_REG_TEMP_STATE[1], FSCHER_REG_TEMP_ACT[1],
+	      FSCHER_REG_TEMP_MAX[1])
+sysfs_temp(3, FSCHER_REG_TEMP_STATE[2], FSCHER_REG_TEMP_ACT[2],
+	      FSCHER_REG_TEMP_MAX[2])
 
 sysfs_in(0, FSCHER_REG_VOLT_12)
 sysfs_in(1, FSCHER_REG_VOLT_5)
@@ -245,10 +243,12 @@ static struct attribute *fscher_attribut
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
@@ -257,22 +257,34 @@ static struct attribute *fscher_attribut
 	&dev_attr_fan1_status.attr,
 	&dev_attr_fan1_div.attr,
 	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_alarm.attr,
 	&dev_attr_pwm1.attr,
 	&dev_attr_fan2_status.attr,
 	&dev_attr_fan2_div.attr,
 	&dev_attr_fan2_input.attr,
+	&dev_attr_fan2_alarm.attr,
 	&dev_attr_pwm2.attr,
 	&dev_attr_fan3_status.attr,
 	&dev_attr_fan3_div.attr,
 	&dev_attr_fan3_input.attr,
+	&dev_attr_fan3_alarm.attr,
 	&dev_attr_pwm3.attr,
 
 	&dev_attr_temp1_status.attr,
 	&dev_attr_temp1_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp1_fault.attr,
+	&dev_attr_temp1_alarm.attr,
 	&dev_attr_temp2_status.attr,
 	&dev_attr_temp2_input.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp2_fault.attr,
+	&dev_attr_temp2_alarm.attr,
 	&dev_attr_temp3_status.attr,
 	&dev_attr_temp3_input.attr,
+	&dev_attr_temp3_max.attr,
+	&dev_attr_temp3_fault.attr,
+	&dev_attr_temp3_alarm.attr,
 	NULL
 };
 
@@ -405,37 +417,48 @@ static struct fscher_data *fscher_update
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct fscher_data *data = i2c_get_clientdata(client);
+	int i;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting fscher update\n");
-
-		data->temp_act[0] = fscher_read_value(client, FSCHER_REG_TEMP0_ACT);
-		data->temp_act[1] = fscher_read_value(client, FSCHER_REG_TEMP1_ACT);
-		data->temp_act[2] = fscher_read_value(client, FSCHER_REG_TEMP2_ACT);
-		data->temp_status[0] = fscher_read_value(client, FSCHER_REG_TEMP0_STATE);
-		data->temp_status[1] = fscher_read_value(client, FSCHER_REG_TEMP1_STATE);
-		data->temp_status[2] = fscher_read_value(client, FSCHER_REG_TEMP2_STATE);
+		
+		for (i = 0; i < 3; i++) {
+			data->temp_act[i] = fscher_read_value(client,
+						FSCHER_REG_TEMP_ACT[i]);
+			data->temp_status[i] = fscher_read_value(client,
+						FSCHER_REG_TEMP_STATE[i]);
+			data->temp_max[i] = fscher_read_value(client,
+				FSCHER_REG_TEMP_MAX[i]);
+				
+			/* reset alarm if the alarm condition is gone,
+			   the chip doesn't do this itself */
+			if ((data->temp_status[i] & 0x02) &&
+					data->temp_act[i] < data->temp_max[i])
+				fscher_write_value(client,
+					FSCHER_REG_TEMP_STATE[i], 0x02);
+					
+			data->fan_act[i] = fscher_read_value(client,
+						FSCHER_REG_FAN_ACT[i]);
+			data->fan_status[i] = fscher_read_value(client,
+						FSCHER_REG_FAN_STATE[i]);
+			data->fan_min[i] = fscher_read_value(client,
+						FSCHER_REG_FAN_MIN[i]);
+			data->fan_ripple[i] = fscher_read_value(client,
+						FSCHER_REG_FAN_RIPPLE[i]);
+
+			/* reset fan status if speed is back to > 0 */
+			if ((data->fan_status[i] & 0x04) && data->fan_act[i])
+				fscher_write_value(client,
+					FSCHER_REG_FAN_STATE[i], 0x04);
+		}
 
 		data->volt[0] = fscher_read_value(client, FSCHER_REG_VOLT_12);
 		data->volt[1] = fscher_read_value(client, FSCHER_REG_VOLT_5);
 		data->volt[2] = fscher_read_value(client, FSCHER_REG_VOLT_BATT);
 
-		data->fan_act[0] = fscher_read_value(client, FSCHER_REG_FAN0_ACT);
-		data->fan_act[1] = fscher_read_value(client, FSCHER_REG_FAN1_ACT);
-		data->fan_act[2] = fscher_read_value(client, FSCHER_REG_FAN2_ACT);
-		data->fan_status[0] = fscher_read_value(client, FSCHER_REG_FAN0_STATE);
-		data->fan_status[1] = fscher_read_value(client, FSCHER_REG_FAN1_STATE);
-		data->fan_status[2] = fscher_read_value(client, FSCHER_REG_FAN2_STATE);
-		data->fan_min[0] = fscher_read_value(client, FSCHER_REG_FAN0_MIN);
-		data->fan_min[1] = fscher_read_value(client, FSCHER_REG_FAN1_MIN);
-		data->fan_min[2] = fscher_read_value(client, FSCHER_REG_FAN2_MIN);
-		data->fan_ripple[0] = fscher_read_value(client, FSCHER_REG_FAN0_RIPPLE);
-		data->fan_ripple[1] = fscher_read_value(client, FSCHER_REG_FAN1_RIPPLE);
-		data->fan_ripple[2] = fscher_read_value(client, FSCHER_REG_FAN2_RIPPLE);
-
 		data->watchdog[0] = fscher_read_value(client, FSCHER_REG_WDOG_PRESET);
 		data->watchdog[1] = fscher_read_value(client, FSCHER_REG_WDOG_STATE);
 		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
@@ -531,6 +554,13 @@ static ssize_t show_fan_input (struct fs
 	return sprintf(buf, "%u\n", RPM_FROM_REG(data->fan_act[FAN_INDEX_FROM_NUM(nr)]));
 }
 
+static ssize_t show_fan_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	if (data->fan_status[FAN_INDEX_FROM_NUM(nr)] & 0x04)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
 
 
 #define TEMP_INDEX_FROM_NUM(nr)		((nr) - 1)
@@ -556,11 +586,53 @@ static ssize_t show_temp_status(struct f
 
 #define TEMP_FROM_REG(val)	(((val) - 128) * 1000)
 
+static ssize_t set_temp_max(struct i2c_client *client, struct fscher_data *data,
+			       const char *buf, size_t count, int nr, int reg)
+{
+	unsigned long v = simple_strtoul(buf, NULL, 10) / 1000;
+	
+	if (v > 127)
+		v = 127;
+
+	v += 128;
+
+	mutex_lock(&data->update_lock);
+	fscher_write_value(client, reg, v);
+	data->temp_max[TEMP_INDEX_FROM_NUM(nr)] = v;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_temp_max(struct fscher_data *data, char *buf, int nr)
+{
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(
+		data->temp_max[TEMP_INDEX_FROM_NUM(nr)]));
+}
+
+static ssize_t show_temp_fault(struct fscher_data *data, char *buf, int nr)
+{
+	/* bit 0 set means sensor working ok, so no fault! */
+	if (data->temp_status[TEMP_INDEX_FROM_NUM(nr)] & 0x01)
+		return sprintf(buf, "0\n");
+	else
+		return sprintf(buf, "1\n");
+}
+
 static ssize_t show_temp_input(struct fscher_data *data, char *buf, int nr)
 {
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_act[TEMP_INDEX_FROM_NUM(nr)]));
 }
 
+static ssize_t show_temp_alarm (struct fscher_data *data, char *buf, int nr)
+{
+	/* only signal an alarm if the sensor is working and alert == 1 */
+	if ((data->temp_status[TEMP_INDEX_FROM_NUM(nr)] & 0x03) == 0x03)
+		return sprintf(buf, "1\n");
+	else
+		return sprintf(buf, "0\n");
+}
+
 /*
  * The final conversion is specified in sensors.conf, as it depends on
  * mainboard specific values. We export the registers contents as
@@ -611,6 +683,13 @@ static ssize_t show_control(struct fsche
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
@@ -670,6 +749,14 @@ static ssize_t show_watchdog_preset(stru
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

--------------090309020001050209040104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090309020001050209040104--

