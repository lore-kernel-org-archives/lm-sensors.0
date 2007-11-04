From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 Nov 2007 22:44:52 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (gl520sm) Put register addresses in
Message-Id: <20071104234452.3a59e806@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This allows for some code refactoring, making the binary slightly
smaller. This is also required to use dynamic sysfs callbacks for
voltage and temperature files.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl520sm.c |  104 ++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 64 deletions(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/gl520sm.c	2007-11-04 20:50:44.000000000 +0100
+++ linux-2.6.24-rc1/drivers/hwmon/gl520sm.c	2007-11-04 20:59:28.000000000 +0100
@@ -56,37 +56,14 @@ That's why _TEMP2 and _IN4 access the sa
 
 #define GL520_REG_VID_INPUT		0x02
 
-#define GL520_REG_IN0_INPUT		0x15
-#define GL520_REG_IN0_LIMIT		0x0c
-#define GL520_REG_IN0_MIN		GL520_REG_IN0_LIMIT
-#define GL520_REG_IN0_MAX		GL520_REG_IN0_LIMIT
-
-#define GL520_REG_IN1_INPUT		0x14
-#define GL520_REG_IN1_LIMIT		0x09
-#define GL520_REG_IN1_MIN		GL520_REG_IN1_LIMIT
-#define GL520_REG_IN1_MAX		GL520_REG_IN1_LIMIT
-
-#define GL520_REG_IN2_INPUT		0x13
-#define GL520_REG_IN2_LIMIT		0x0a
-#define GL520_REG_IN2_MIN		GL520_REG_IN2_LIMIT
-#define GL520_REG_IN2_MAX		GL520_REG_IN2_LIMIT
-
-#define GL520_REG_IN3_INPUT		0x0d
-#define GL520_REG_IN3_LIMIT		0x0b
-#define GL520_REG_IN3_MIN		GL520_REG_IN3_LIMIT
-#define GL520_REG_IN3_MAX		GL520_REG_IN3_LIMIT
-
-#define GL520_REG_IN4_INPUT		0x0e
-#define GL520_REG_IN4_MAX		0x17
-#define GL520_REG_IN4_MIN		0x18
-
-#define GL520_REG_TEMP1_INPUT		0x04
-#define GL520_REG_TEMP1_MAX		0x05
-#define GL520_REG_TEMP1_MAX_HYST	0x06
-
-#define GL520_REG_TEMP2_INPUT		0x0e
-#define GL520_REG_TEMP2_MAX		0x17
-#define GL520_REG_TEMP2_MAX_HYST	0x18
+static const u8 GL520_REG_IN_INPUT[]	= { 0x15, 0x14, 0x13, 0x0d, 0x0e };
+static const u8 GL520_REG_IN_LIMIT[]	= { 0x0c, 0x09, 0x0a, 0x0b };
+static const u8 GL520_REG_IN_MIN[]	= { 0x0c, 0x09, 0x0a, 0x0b, 0x18 };
+static const u8 GL520_REG_IN_MAX[]	= { 0x0c, 0x09, 0x0a, 0x0b, 0x17 };
+
+static const u8 GL520_REG_TEMP_INPUT[]		= { 0x04, 0x0e };
+static const u8 GL520_REG_TEMP_MAX[]		= { 0x05, 0x17 };
+static const u8 GL520_REG_TEMP_MAX_HYST[]	= { 0x06, 0x18 };
 
 #define GL520_REG_FAN_INPUT		0x07
 #define GL520_REG_FAN_MIN		0x08
@@ -191,9 +168,9 @@ static DEVICE_ATTR(type##item, S_IRUGO, 
 sysfs_ro_n(cpu, n, _vid, GL520_REG_VID_INPUT)
 
 #define sysfs_in(n) \
-sysfs_ro_n(in, n, _input, GL520_REG_IN##n##INPUT) \
-sysfs_rw_n(in, n, _min, GL520_REG_IN##n##_MIN) \
-sysfs_rw_n(in, n, _max, GL520_REG_IN##n##_MAX)
+sysfs_ro_n(in, n, _input, GL520_REG_IN_INPUT[n]) \
+sysfs_rw_n(in, n, _min, GL520_REG_IN_MIN[n]) \
+sysfs_rw_n(in, n, _max, GL520_REG_IN_MAX[n])
 
 #define sysfs_fan(n) \
 sysfs_ro_n(fan, n, _input, GL520_REG_FAN_INPUT) \
@@ -204,9 +181,9 @@ sysfs_rw_n(fan, n, _div, GL520_REG_FAN_D
 sysfs_rw_n(fan, n, _off, GL520_REG_FAN_OFF)
 
 #define sysfs_temp(n) \
-sysfs_ro_n(temp, n, _input, GL520_REG_TEMP##n##_INPUT) \
-sysfs_rw_n(temp, n, _max, GL520_REG_TEMP##n##_MAX) \
-sysfs_rw_n(temp, n, _max_hyst, GL520_REG_TEMP##n##_MAX_HYST)
+sysfs_ro_n(temp, n, _input, GL520_REG_TEMP_INPUT[(n) - 1]) \
+sysfs_rw_n(temp, n, _max, GL520_REG_TEMP_MAX[(n) - 1]) \
+sysfs_rw_n(temp, n, _max_hyst, GL520_REG_TEMP_MAX_HYST[(n) - 1])
 
 #define sysfs_alarms() \
 sysfs_ro(alarms, , GL520_REG_ALARMS) \
@@ -717,7 +694,7 @@ static struct gl520_data *gl520_update_d
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl520_data *data = i2c_get_clientdata(client);
-	int val;
+	int val, i;
 
 	mutex_lock(&data->update_lock);
 
@@ -729,18 +706,13 @@ static struct gl520_data *gl520_update_d
 		data->beep_mask = gl520_read_value(client, GL520_REG_BEEP_MASK);
 		data->vid = gl520_read_value(client, GL520_REG_VID_INPUT) & 0x1f;
 
-		val = gl520_read_value(client, GL520_REG_IN0_LIMIT);
-		data->in_min[0] = val & 0xff;
-		data->in_max[0] = (val >> 8) & 0xff;
-		val = gl520_read_value(client, GL520_REG_IN1_LIMIT);
-		data->in_min[1] = val & 0xff;
-		data->in_max[1] = (val >> 8) & 0xff;
-		val = gl520_read_value(client, GL520_REG_IN2_LIMIT);
-		data->in_min[2] = val & 0xff;
-		data->in_max[2] = (val >> 8) & 0xff;
-		val = gl520_read_value(client, GL520_REG_IN3_LIMIT);
-		data->in_min[3] = val & 0xff;
-		data->in_max[3] = (val >> 8) & 0xff;
+		for (i = 0; i < 4; i++) {
+			data->in_input[i] = gl520_read_value(client,
+							GL520_REG_IN_INPUT[i]);
+			val = gl520_read_value(client, GL520_REG_IN_LIMIT[i]);
+			data->in_min[i] = val & 0xff;
+			data->in_max[i] = (val >> 8) & 0xff;
+		}
 
 		val = gl520_read_value(client, GL520_REG_FAN_INPUT);
 		data->fan_input[0] = (val >> 8) & 0xff;
@@ -750,9 +722,12 @@ static struct gl520_data *gl520_update_d
 		data->fan_min[0] = (val >> 8) & 0xff;
 		data->fan_min[1] = val & 0xff;
 
-		data->temp_input[0] = gl520_read_value(client, GL520_REG_TEMP1_INPUT);
-		data->temp_max[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX);
-		data->temp_max_hyst[0] = gl520_read_value(client, GL520_REG_TEMP1_MAX_HYST);
+		data->temp_input[0] = gl520_read_value(client,
+						GL520_REG_TEMP_INPUT[0]);
+		data->temp_max[0] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX[0]);
+		data->temp_max_hyst[0] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX_HYST[0]);
 
 		val = gl520_read_value(client, GL520_REG_FAN_DIV);
 		data->fan_div[0] = (val >> 6) & 0x03;
@@ -764,20 +739,21 @@ static struct gl520_data *gl520_update_d
 		val = gl520_read_value(client, GL520_REG_CONF);
 		data->beep_enable = !((val >> 2) & 1);
 
-		data->in_input[0] = gl520_read_value(client, GL520_REG_IN0_INPUT);
-		data->in_input[1] = gl520_read_value(client, GL520_REG_IN1_INPUT);
-		data->in_input[2] = gl520_read_value(client, GL520_REG_IN2_INPUT);
-		data->in_input[3] = gl520_read_value(client, GL520_REG_IN3_INPUT);
-
 		/* Temp1 and Vin4 are the same input */
 		if (data->two_temps) {
-			data->temp_input[1] = gl520_read_value(client, GL520_REG_TEMP2_INPUT);
-			data->temp_max[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX);
-			data->temp_max_hyst[1] = gl520_read_value(client, GL520_REG_TEMP2_MAX_HYST);
+			data->temp_input[1] = gl520_read_value(client,
+						GL520_REG_TEMP_INPUT[1]);
+			data->temp_max[1] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX[1]);
+			data->temp_max_hyst[1] = gl520_read_value(client,
+						GL520_REG_TEMP_MAX_HYST[1]);
 		} else {
-			data->in_input[4] = gl520_read_value(client, GL520_REG_IN4_INPUT);
-			data->in_min[4] = gl520_read_value(client, GL520_REG_IN4_MIN);
-			data->in_max[4] = gl520_read_value(client, GL520_REG_IN4_MAX);
+			data->in_input[4] = gl520_read_value(client,
+						GL520_REG_IN_INPUT[4]);
+			data->in_min[4] = gl520_read_value(client,
+						GL520_REG_IN_MIN[4]);
+			data->in_max[4] = gl520_read_value(client,
+						GL520_REG_IN_MAX[4]);
 		}
 
 		data->last_updated = jiffies;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
