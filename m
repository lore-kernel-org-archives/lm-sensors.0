From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:22:41 +0000
Subject: [lm-sensors] [PATCH 01/11] hwmon: (adt7475) Rework voltage inputs
Message-Id: <20091202162241.18331bca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rework the handling of voltage inputs to make it possible and easy to
support more inputs. This will be needed for the upcoming ADT7490
support.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   83 +++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 35 deletions(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-11-29 13:26:14.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-11-30 20:11:27.000000000 +0100
@@ -39,7 +39,7 @@
 
 /* 7475 Common Registers */
 
-#define REG_VOLTAGE_BASE	0x21
+#define REG_VOLTAGE_BASE	0x20
 #define REG_TEMP_BASE		0x25
 #define REG_TACH_BASE		0x28
 #define REG_PWM_BASE		0x30
@@ -51,8 +51,8 @@
 #define REG_STATUS1		0x41
 #define REG_STATUS2		0x42
 
-#define REG_VOLTAGE_MIN_BASE	0x46
-#define REG_VOLTAGE_MAX_BASE	0x47
+#define REG_VOLTAGE_MIN_BASE	0x44
+#define REG_VOLTAGE_MAX_BASE	0x45
 
 #define REG_TEMP_MIN_BASE	0x4E
 #define REG_TEMP_MAX_BASE	0x4F
@@ -85,7 +85,7 @@
 
 /* ADT7475 Settings */
 
-#define ADT7475_VOLTAGE_COUNT	2
+#define ADT7475_VOLTAGE_COUNT	5	/* Not counting Vtt */
 #define ADT7475_TEMP_COUNT	3
 #define ADT7475_TACH_COUNT	4
 #define ADT7475_PWM_COUNT	3
@@ -137,8 +137,9 @@ struct adt7475_data {
 
 	u8 config4;
 	u8 config5;
+	u8 has_voltage;
 	u16 alarms;
-	u16 voltage[3][3];
+	u16 voltage[3][6];
 	u16 temp[7][3];
 	u16 tach[2][4];
 	u8 pwm[4][3];
@@ -201,26 +202,30 @@ static inline u16 rpm2tach(unsigned long
 	return SENSORS_LIMIT((90000 * 60) / rpm, 1, 0xFFFF);
 }
 
-static inline int reg2vcc(u16 reg)
-{
-	return (4296 * reg) / 1000;
-}
+/* Scaling factors for voltage inputs, taken from the ADT7490 datasheet */
+static const int adt7473_in_scaling[ADT7475_VOLTAGE_COUNT + 1][2] = {
+	{ 45, 94 },	/* +2.5V */
+	{ 175, 525 },	/* Vccp */
+	{ 68, 71 },	/* Vcc */
+	{ 93, 47 },	/* +5V */
+	{ 120, 20 },	/* +12V */
+	{ 45, 45 },	/* Vtt */
+};
 
-static inline int reg2vccp(u16 reg)
+static inline int reg2volt(int channel, u16 reg)
 {
-	return (2929 * reg) / 1000;
-}
+	const int *r = adt7473_in_scaling[channel];
 
-static inline u16 vcc2reg(long vcc)
-{
-	vcc = SENSORS_LIMIT(vcc, 0, 4396);
-	return (vcc * 1000) / 4296;
+	return DIV_ROUND_CLOSEST(reg * (r[0] + r[1]) * 2250, r[1] * 1024);
 }
 
-static inline u16 vccp2reg(long vcc)
+static inline u16 volt2reg(int channel, long volt)
 {
-	vcc = SENSORS_LIMIT(vcc, 0, 2998);
-	return (vcc * 1000) / 2929;
+	const int *r = adt7473_in_scaling[channel];
+	long reg;
+
+	reg = (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
+	return SENSORS_LIMIT(reg, 0, 1023) & (0xff << 2);
 }
 
 static u16 adt7475_read_word(struct i2c_client *client, int reg)
@@ -276,12 +281,10 @@ static ssize_t show_voltage(struct devic
 	switch (sattr->nr) {
 	case ALARM:
 		return sprintf(buf, "%d\n",
-			       (data->alarms >> (sattr->index + 1)) & 1);
+			       (data->alarms >> sattr->index) & 1);
 	default:
 		val = data->voltage[sattr->nr][sattr->index];
-		return sprintf(buf, "%d\n",
-			       sattr->index =
-			       0 ? reg2vccp(val) : reg2vcc(val));
+		return sprintf(buf, "%d\n", reg2volt(sattr->index, val));
 	}
 }
 
@@ -300,8 +303,7 @@ static ssize_t set_voltage(struct device
 
 	mutex_lock(&data->lock);
 
-	data->voltage[sattr->nr][sattr->index] -		sattr->index ? vcc2reg(val) : vccp2reg(val);
+	data->voltage[sattr->nr][sattr->index] = volt2reg(sattr->index, val);
 
 	if (sattr->nr = MIN)
 		reg = VOLTAGE_MIN_REG(sattr->index);
@@ -815,18 +817,18 @@ static ssize_t set_pwm_at_crit(struct de
 	return count;
 }
 
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
 static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 0);
+			    set_voltage, MAX, 1);
 static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 0);
-static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, show_voltage, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
+			    set_voltage, MIN, 1);
+static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, show_voltage, NULL, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_voltage, NULL, INPUT, 2);
 static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 1);
+			    set_voltage, MAX, 2);
 static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 1);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 1);
+			    set_voltage, MIN, 2);
+static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 2);
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, show_temp, NULL, ALARM, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_temp, NULL, FAULT, 0);
@@ -1050,6 +1052,12 @@ static int adt7475_probe(struct i2c_clie
 	mutex_init(&data->lock);
 	i2c_set_clientdata(client, data);
 
+	/* Initialize device-specific values */
+	switch (id->driver_data) {
+	default:
+		data->has_voltage = 0x06;	/* in1, in2 */
+	}
+
 	/* Call adt7475_read_pwm for all pwm's as this will reprogram any
 	   pwm's which are disabled to manual mode with 0% duty cycle */
 	for (i = 0; i < ADT7475_PWM_COUNT; i++)
@@ -1176,10 +1184,13 @@ static struct adt7475_data *adt7475_upda
 		data->alarms |= adt7475_read(REG_STATUS1);
 
 		ext = adt7475_read(REG_EXTEND1);
-		for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++)
+		for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++) {
+			if (!(data->has_voltage & (1 << i)))
+				continue;
 			data->voltage[INPUT][i]  				(adt7475_read(VOLTAGE_REG(i)) << 2) |
-				((ext >> ((i + 1) * 2)) & 3);
+				((ext >> (i * 2)) & 3);
+		}
 
 		ext = adt7475_read(REG_EXTEND2);
 		for (i = 0; i < ADT7475_TEMP_COUNT; i++)
@@ -1205,6 +1216,8 @@ static struct adt7475_data *adt7475_upda
 		data->config5 = adt7475_read(REG_CONFIG5);
 
 		for (i = 0; i < ADT7475_VOLTAGE_COUNT; i++) {
+			if (!(data->has_voltage & (1 << i)))
+				continue;
 			/* Adjust values so they match the input precision */
 			data->voltage[MIN][i]  				adt7475_read(VOLTAGE_MIN_REG(i)) << 2;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
