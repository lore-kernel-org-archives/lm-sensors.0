From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Jun 2013 17:11:09 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add support for NCT6791D
Message-Id: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Bartley <andareed@gmail.com>

Signed-off-by: David Bartley <andareed@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of previosuly sent patches. Target release is 3.12.

 drivers/hwmon/nct6775.c |  281 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 207 insertions(+), 74 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 6386d1b..3a9bb66 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -37,6 +37,7 @@
  * nct6775f     9      4       3       6+3    0xb470 0xc1    0x5ca3
  * nct6776f     9      5       3       6+3    0xc330 0xc1    0x5ca3
  * nct6779d    15      5       5       2+6    0xc560 0xc1    0x5ca3
+ * nct6791d    15      6       6       2+6    0xc800 0xc1    0x5ca3
  *
  * #temp lists the number of monitored temperature sources (first value) plus
  * the number of directly connectable temperature sensors (second value).
@@ -60,7 +61,7 @@
 
 #define USE_ALTERNATE
 
-enum kinds { nct6106, nct6775, nct6776, nct6779 };
+enum kinds { nct6106, nct6775, nct6776, nct6779, nct6791 };
 
 /* used to set data->name = nct6775_device_names[data->sio_kind] */
 static const char * const nct6775_device_names[] = {
@@ -68,6 +69,7 @@ static const char * const nct6775_device_names[] = {
 	"nct6775",
 	"nct6776",
 	"nct6779",
+	"nct6791",
 };
 
 static unsigned short force_id;
@@ -97,6 +99,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_NCT6775_ID		0xb470
 #define SIO_NCT6776_ID		0xc330
 #define SIO_NCT6779_ID		0xc560
+#define SIO_NCT6791_ID		0xc800
 #define SIO_ID_MASK		0xFFF0
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
@@ -173,6 +176,8 @@ superio_exit(int ioreg)
 #define NUM_REG_ALARM	7	/* Max number of alarm registers */
 #define NUM_REG_BEEP	5	/* Max number of beep registers */
 
+#define NUM_FAN		6
+
 /* Common and NCT6775 specific data */
 
 /* Voltage min/max registers for nr=7..14 are in bank 5 */
@@ -239,28 +244,32 @@ static const u8 NCT6775_PWM_MODE_MASK[] = { 0x01, 0x02, 0x01 };
 
 /* Advanced Fan control, some values are common for all fans */
 
-static const u16 NCT6775_REG_TARGET[] = { 0x101, 0x201, 0x301, 0x801, 0x901 };
-static const u16 NCT6775_REG_FAN_MODE[] = { 0x102, 0x202, 0x302, 0x802, 0x902 };
+static const u16 NCT6775_REG_TARGET[] = {
+	0x101, 0x201, 0x301, 0x801, 0x901, 0xa01 };
+static const u16 NCT6775_REG_FAN_MODE[] = {
+	0x102, 0x202, 0x302, 0x802, 0x902, 0xa02 };
 static const u16 NCT6775_REG_FAN_STEP_DOWN_TIME[] = {
-	0x103, 0x203, 0x303, 0x803, 0x903 };
+	0x103, 0x203, 0x303, 0x803, 0x903, 0xa03 };
 static const u16 NCT6775_REG_FAN_STEP_UP_TIME[] = {
-	0x104, 0x204, 0x304, 0x804, 0x904 };
+	0x104, 0x204, 0x304, 0x804, 0x904, 0xa04 };
 static const u16 NCT6775_REG_FAN_STOP_OUTPUT[] = {
-	0x105, 0x205, 0x305, 0x805, 0x905 };
-static const u16 NCT6775_REG_FAN_START_OUTPUT[]
-	= { 0x106, 0x206, 0x306, 0x806, 0x906 };
+	0x105, 0x205, 0x305, 0x805, 0x905, 0xa05 };
+static const u16 NCT6775_REG_FAN_START_OUTPUT[] = {
+	0x106, 0x206, 0x306, 0x806, 0x906, 0xa06 };
 static const u16 NCT6775_REG_FAN_MAX_OUTPUT[] = { 0x10a, 0x20a, 0x30a };
 static const u16 NCT6775_REG_FAN_STEP_OUTPUT[] = { 0x10b, 0x20b, 0x30b };
 
 static const u16 NCT6775_REG_FAN_STOP_TIME[] = {
-	0x107, 0x207, 0x307, 0x807, 0x907 };
-static const u16 NCT6775_REG_PWM[] = { 0x109, 0x209, 0x309, 0x809, 0x909 };
-static const u16 NCT6775_REG_PWM_READ[] = { 0x01, 0x03, 0x11, 0x13, 0x15 };
+	0x107, 0x207, 0x307, 0x807, 0x907, 0xa07 };
+static const u16 NCT6775_REG_PWM[] = {
+	0x109, 0x209, 0x309, 0x809, 0x909, 0xa09 };
+static const u16 NCT6775_REG_PWM_READ[] = {
+	0x01, 0x03, 0x11, 0x13, 0x15, 0xa09 };
 
 static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
 static const u16 NCT6775_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d };
 static const u16 NCT6775_REG_FAN_PULSES[] = { 0x641, 0x642, 0x643, 0x644, 0 };
-static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -276,25 +285,25 @@ static const u16 NCT6775_REG_TEMP_SOURCE[ARRAY_SIZE(NCT6775_REG_TEMP)] = {
 	0x621, 0x622, 0x623, 0x624, 0x625, 0x626 };
 
 static const u16 NCT6775_REG_TEMP_SEL[] = {
-	0x100, 0x200, 0x300, 0x800, 0x900 };
+	0x100, 0x200, 0x300, 0x800, 0x900, 0xa00 };
 
 static const u16 NCT6775_REG_WEIGHT_TEMP_SEL[] = {
-	0x139, 0x239, 0x339, 0x839, 0x939 };
+	0x139, 0x239, 0x339, 0x839, 0x939, 0xa39 };
 static const u16 NCT6775_REG_WEIGHT_TEMP_STEP[] = {
-	0x13a, 0x23a, 0x33a, 0x83a, 0x93a };
+	0x13a, 0x23a, 0x33a, 0x83a, 0x93a, 0xa3a };
 static const u16 NCT6775_REG_WEIGHT_TEMP_STEP_TOL[] = {
-	0x13b, 0x23b, 0x33b, 0x83b, 0x93b };
+	0x13b, 0x23b, 0x33b, 0x83b, 0x93b, 0xa3b };
 static const u16 NCT6775_REG_WEIGHT_DUTY_STEP[] = {
-	0x13c, 0x23c, 0x33c, 0x83c, 0x93c };
+	0x13c, 0x23c, 0x33c, 0x83c, 0x93c, 0xa3c };
 static const u16 NCT6775_REG_WEIGHT_TEMP_BASE[] = {
-	0x13d, 0x23d, 0x33d, 0x83d, 0x93d };
+	0x13d, 0x23d, 0x33d, 0x83d, 0x93d, 0xa3d };
 
 static const u16 NCT6775_REG_TEMP_OFFSET[] = { 0x454, 0x455, 0x456 };
 
 static const u16 NCT6775_REG_AUTO_TEMP[] = {
-	0x121, 0x221, 0x321, 0x821, 0x921 };
+	0x121, 0x221, 0x321, 0x821, 0x921, 0xa21 };
 static const u16 NCT6775_REG_AUTO_PWM[] = {
-	0x127, 0x227, 0x327, 0x827, 0x927 };
+	0x127, 0x227, 0x327, 0x827, 0x927, 0xa27 };
 
 #define NCT6775_AUTO_TEMP(data, nr, p)	((data)->REG_AUTO_TEMP[nr] + (p))
 #define NCT6775_AUTO_PWM(data, nr, p)	((data)->REG_AUTO_PWM[nr] + (p))
@@ -302,9 +311,9 @@ static const u16 NCT6775_REG_AUTO_PWM[] = {
 static const u16 NCT6775_REG_CRITICAL_ENAB[] = { 0x134, 0x234, 0x334 };
 
 static const u16 NCT6775_REG_CRITICAL_TEMP[] = {
-	0x135, 0x235, 0x335, 0x835, 0x935 };
+	0x135, 0x235, 0x335, 0x835, 0x935, 0xa35 };
 static const u16 NCT6775_REG_CRITICAL_TEMP_TOLERANCE[] = {
-	0x138, 0x238, 0x338, 0x838, 0x938 };
+	0x138, 0x238, 0x338, 0x838, 0x938, 0xa38 };
 
 static const char *const nct6775_temp_label[] = {
 	"",
@@ -360,16 +369,16 @@ static const s8 NCT6776_BEEP_BITS[] = {
 	30, 31 };			/* intrusion0, intrusion1 */
 
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
-	0x10c, 0x20c, 0x30c, 0x80c, 0x90c };
+	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = { 0x63a, 0x63c, 0x63e, 0x640, 0x642 };
 static const u16 NCT6776_REG_FAN_PULSES[] = { 0x644, 0x645, 0x646, 0, 0 };
 
 static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] = {
-	0x13e, 0x23e, 0x33e, 0x83e, 0x93e };
+	0x13e, 0x23e, 0x33e, 0x83e, 0x93e, 0xa3e };
 
 static const u16 NCT6776_REG_TEMP_CONFIG[ARRAY_SIZE(NCT6775_REG_TEMP)] = {
 	0x18, 0x152, 0x252, 0x628, 0x629, 0x62A };
@@ -433,15 +442,16 @@ static const s8 NCT6779_BEEP_BITS[] = {
 	16, 17, -1, -1, -1, -1,		/* temp1..temp6 */
 	30, 31 };			/* intrusion0, intrusion1 */
 
-static const u16 NCT6779_REG_FAN[] = { 0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8 };
+static const u16 NCT6779_REG_FAN[] = {
+	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba };
 static const u16 NCT6779_REG_FAN_PULSES[] = {
-	0x644, 0x645, 0x646, 0x647, 0x648 };
+	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
 static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] = {
-	0x136, 0x236, 0x336, 0x836, 0x936 };
+	0x136, 0x236, 0x336, 0x836, 0x936, 0xa36 };
 #define NCT6779_CRITICAL_PWM_ENABLE_MASK	0x01
 static const u16 NCT6779_REG_CRITICAL_PWM[] = {
-	0x137, 0x237, 0x337, 0x837, 0x937 };
+	0x137, 0x237, 0x337, 0x837, 0x937, 0xa37 };
 
 static const u16 NCT6779_REG_TEMP[] = { 0x27, 0x150 };
 static const u16 NCT6779_REG_TEMP_CONFIG[ARRAY_SIZE(NCT6779_REG_TEMP)] = {
@@ -493,6 +503,23 @@ static const u16 NCT6779_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6779_temp_label) - 1]
 static const u16 NCT6779_REG_TEMP_CRIT[ARRAY_SIZE(nct6779_temp_label) - 1]
 	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x709, 0x70a };
 
+/* NCT6791 specific data */
+
+#define NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE	0x28
+
+static const u16 NCT6791_REG_ALARM[NUM_REG_ALARM] = {
+	0x459, 0x45A, 0x45B, 0x568, 0x45D };
+
+static const s8 NCT6791_ALARM_BITS[] = {
+	0, 1, 2, 3, 8, 21, 20, 16,	/* in0.. in7 */
+	17, 24, 25, 26, 27, 28, 29,	/* in8..in14 */
+	-1,				/* unused */
+	6, 7, 11, 10, 23, 33,		/* fan1..fan6 */
+	-1, -1,				/* unused */
+	4, 5, 13, -1, -1, -1,		/* temp1..temp6 */
+	12, 9 };			/* intrusion0, intrusion1 */
+
+
 /* NCT6102D/NCT6106D specific data */
 
 #define NCT6106_REG_VBAT	0x318
@@ -771,10 +798,10 @@ struct nct6775_data {
 	u8 bank;		/* current register bank */
 	u8 in_num;		/* number of in inputs we have */
 	u8 in[15][3];		/* [0]=in, [1]=in_max, [2]=in_min */
-	unsigned int rpm[5];
-	u16 fan_min[5];
-	u8 fan_pulses[5];
-	u8 fan_div[5];
+	unsigned int rpm[NUM_FAN];
+	u16 fan_min[NUM_FAN];
+	u8 fan_pulses[NUM_FAN];
+	u8 fan_div[NUM_FAN];
 	u8 has_pwm;
 	u8 has_fan;		/* some fan inputs can be disabled */
 	u8 has_fan_min;		/* some fans don't have min register */
@@ -791,8 +818,10 @@ struct nct6775_data {
 	u64 beeps;
 
 	u8 pwm_num;	/* number of pwm */
-	u8 pwm_mode[5]; /* 1->DC variable voltage, 0->PWM variable duty cycle */
-	enum pwm_enable pwm_enable[5];
+	u8 pwm_mode[NUM_FAN];	/* 1->DC variable voltage,
+				 * 0->PWM variable duty cycle
+				 */
+	enum pwm_enable pwm_enable[NUM_FAN];
 			/* 0->off
 			 * 1->manual
 			 * 2->thermal cruise mode (also called SmartFan I)
@@ -800,31 +829,31 @@ struct nct6775_data {
 			 * 4->SmartFan III
 			 * 5->enhanced variable thermal cruise (SmartFan IV)
 			 */
-	u8 pwm[7][5];	/* [0]=pwm, [1]=pwm_start, [2]=pwm_floor,
-			 * [3]=pwm_max, [4]=pwm_step,
-			 * [5]=weight_duty_step, [6]=weight_duty_base
-			 */
+	u8 pwm[7][NUM_FAN];	/* [0]=pwm, [1]=pwm_start, [2]=pwm_floor,
+				 * [3]=pwm_max, [4]=pwm_step,
+				 * [5]=weight_duty_step, [6]=weight_duty_base
+				 */
 
-	u8 target_temp[5];
+	u8 target_temp[NUM_FAN];
 	u8 target_temp_mask;
-	u32 target_speed[5];
-	u32 target_speed_tolerance[5];
+	u32 target_speed[NUM_FAN];
+	u32 target_speed_tolerance[NUM_FAN];
 	u8 speed_tolerance_limit;
 
-	u8 temp_tolerance[2][5];
+	u8 temp_tolerance[2][NUM_FAN];
 	u8 tolerance_mask;
 
-	u8 fan_time[3][5]; /* 0 = stop_time, 1 = step_up, 2 = step_down */
+	u8 fan_time[3][NUM_FAN]; /* 0 = stop_time, 1 = step_up, 2 = step_down */
 
 	/* Automatic fan speed control registers */
 	int auto_pwm_num;
-	u8 auto_pwm[5][7];
-	u8 auto_temp[5][7];
-	u8 pwm_temp_sel[5];
-	u8 pwm_weight_temp_sel[5];
-	u8 weight_temp[3][5];	/* 0->temp_step, 1->temp_step_tol,
-				 * 2->temp_base
-				 */
+	u8 auto_pwm[NUM_FAN][7];
+	u8 auto_temp[NUM_FAN][7];
+	u8 pwm_temp_sel[NUM_FAN];
+	u8 pwm_weight_temp_sel[NUM_FAN];
+	u8 weight_temp[3][NUM_FAN];	/* 0->temp_step, 1->temp_step_tol,
+					 * 2->temp_base
+					 */
 
 	u8 vid;
 	u8 vrm;
@@ -1009,8 +1038,9 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 		  ((reg & 0xfff0) = 0x650 && (reg & 0x000f) >= 0x06) ||
 		  reg = 0x73 || reg = 0x75 || reg = 0x77;
 	case nct6779:
+	case nct6791:
 		return reg = 0x150 || reg = 0x153 || reg = 0x155 ||
-		  ((reg & 0xfff0) = 0x4b0 && (reg & 0x000f) < 0x09) ||
+		  ((reg & 0xfff0) = 0x4b0 && (reg & 0x000f) < 0x0b) ||
 		  reg = 0x402 ||
 		  reg = 0x63a || reg = 0x63c || reg = 0x63e ||
 		  reg = 0x640 || reg = 0x642 ||
@@ -1353,6 +1383,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 			break;
 		case nct6106:
 		case nct6779:
+		case nct6791:
 			reg = nct6775_read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[i]);
 			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
@@ -2760,6 +2791,7 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 			break; /* always enabled, nothing to do */
 		case nct6106:
 		case nct6779:
+		case nct6791:
 			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
 			reg = nct6775_read_value(data,
@@ -3135,23 +3167,24 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 			 struct nct6775_data *data)
 {
 	int regval;
-	bool fan3pin, fan3min, fan4pin, fan4min, fan5pin;
-	bool pwm3pin, pwm4pin, pwm5pin;
+	bool fan3pin, fan4pin, fan4min, fan5pin, fan6pin;
+	bool pwm3pin, pwm4pin, pwm5pin, pwm6pin;
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 	if (data->kind = nct6775) {
 		regval = superio_inb(sio_data->sioreg, 0x2c);
 
 		fan3pin = regval & (1 << 6);
-		fan3min = fan3pin;
 		pwm3pin = regval & (1 << 7);
 
 		/* On NCT6775, fan4 shares pins with the fdc interface */
 		fan4pin = !(superio_inb(sio_data->sioreg, 0x2A) & 0x80);
-		fan4min = 0;
-		fan5pin = 0;
-		pwm4pin = 0;
-		pwm5pin = 0;
+		fan4min = false;
+		fan5pin = false;
+		fan6pin = false;
+		pwm4pin = false;
+		pwm5pin = false;
+		pwm6pin = false;
 	} else if (data->kind = nct6776) {
 		bool gpok = superio_inb(sio_data->sioreg, 0x27) & 0x80;
 
@@ -3174,22 +3207,24 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 			fan5pin = superio_inb(sio_data->sioreg, 0x1C) & 0x02;
 
 		fan4min = fan4pin;
-		fan3min = fan3pin;
+		fan6pin = false;
 		pwm3pin = fan3pin;
-		pwm4pin = 0;
-		pwm5pin = 0;
+		pwm4pin = false;
+		pwm5pin = false;
+		pwm6pin = false;
 	} else if (data->kind = nct6106) {
 		regval = superio_inb(sio_data->sioreg, 0x24);
 		fan3pin = !(regval & 0x80);
 		pwm3pin = regval & 0x08;
-		fan3min = fan3pin;
 
 		fan4pin = false;
 		fan4min = false;
 		fan5pin = false;
+		fan6pin = false;
 		pwm4pin = false;
 		pwm5pin = false;
-	} else {	/* NCT6779D */
+		pwm6pin = false;
+	} else {	/* NCT6779D or NCT6791D */
 		regval = superio_inb(sio_data->sioreg, 0x1c);
 
 		fan3pin = !(regval & (1 << 5));
@@ -3200,18 +3235,25 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		pwm4pin = !(regval & (1 << 1));
 		pwm5pin = !(regval & (1 << 2));
 
-		fan3min = fan3pin;
 		fan4min = fan4pin;
-	}
-
-	data->has_fan = data->has_fan_min = 0x03; /* fan1 and fan2 */
-	data->has_fan |= fan3pin << 2;
-	data->has_fan_min |= fan3min << 2;
 
-	data->has_fan |= (fan4pin << 3) | (fan5pin << 4);
-	data->has_fan_min |= (fan4min << 3) | (fan5pin << 4);
+		if (data->kind = nct6791) {
+			regval = superio_inb(sio_data->sioreg, 0x2d);
+			fan6pin = (regval & (1 << 1));
+			pwm6pin = (regval & (1 << 0));
+		} else {	/* NCT6779D */
+			fan6pin = false;
+			pwm6pin = false;
+		}
+	}
 
-	data->has_pwm = 0x03 | (pwm3pin << 2) | (pwm4pin << 3) | (pwm5pin << 4);
+	/* fan 1 and 2 (0x03) are always present */
+	data->has_fan = 0x03 | (fan3pin << 2) | (fan4pin << 3) |
+		(fan5pin << 4) | (fan6pin << 5);
+	data->has_fan_min = 0x03 | (fan3pin << 2) | (fan4min << 3) |
+		(fan5pin << 4);
+	data->has_pwm = 0x03 | (pwm3pin << 2) | (pwm4pin << 3) |
+		(pwm5pin << 4) | (pwm6pin << 5);
 }
 
 static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
@@ -3556,6 +3598,80 @@ static int nct6775_probe(struct platform_device *pdev)
 		reg_temp_crit = NCT6779_REG_TEMP_CRIT;
 
 		break;
+	case nct6791:
+		data->in_num = 15;
+		data->pwm_num = 6;
+		data->auto_pwm_num = 4;
+		data->has_fan_div = false;
+		data->temp_fixed_num = 6;
+		data->num_temp_alarms = 2;
+		data->num_temp_beeps = 2;
+
+		data->ALARM_BITS = NCT6791_ALARM_BITS;
+		data->BEEP_BITS = NCT6779_BEEP_BITS;
+
+		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg_min = fan_from_reg13;
+		data->target_temp_mask = 0xff;
+		data->tolerance_mask = 0x07;
+		data->speed_tolerance_limit = 63;
+
+		data->temp_label = nct6779_temp_label;
+		data->temp_label_num = ARRAY_SIZE(nct6779_temp_label);
+
+		data->REG_CONFIG = NCT6775_REG_CONFIG;
+		data->REG_VBAT = NCT6775_REG_VBAT;
+		data->REG_DIODE = NCT6775_REG_DIODE;
+		data->DIODE_MASK = NCT6775_DIODE_MASK;
+		data->REG_VIN = NCT6779_REG_IN;
+		data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
+		data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
+		data->REG_TARGET = NCT6775_REG_TARGET;
+		data->REG_FAN = NCT6779_REG_FAN;
+		data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
+		data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
+		data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
+		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
+		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
+		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
+		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
+		data->REG_PWM[0] = NCT6775_REG_PWM;
+		data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
+		data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] = NCT6775_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] = NCT6776_REG_WEIGHT_DUTY_BASE;
+		data->REG_PWM_READ = NCT6775_REG_PWM_READ;
+		data->REG_PWM_MODE = NCT6776_REG_PWM_MODE;
+		data->PWM_MODE_MASK = NCT6776_PWM_MODE_MASK;
+		data->REG_AUTO_TEMP = NCT6775_REG_AUTO_TEMP;
+		data->REG_AUTO_PWM = NCT6775_REG_AUTO_PWM;
+		data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
+		data->REG_CRITICAL_TEMP_TOLERANCE
+		  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_CRITICAL_PWM_ENABLE = NCT6779_REG_CRITICAL_PWM_ENABLE;
+		data->CRITICAL_PWM_ENABLE_MASK
+		  = NCT6779_CRITICAL_PWM_ENABLE_MASK;
+		data->REG_CRITICAL_PWM = NCT6779_REG_CRITICAL_PWM;
+		data->REG_TEMP_OFFSET = NCT6779_REG_TEMP_OFFSET;
+		data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
+		data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
+		data->REG_WEIGHT_TEMP_SEL = NCT6775_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] = NCT6775_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
+		data->REG_ALARM = NCT6791_REG_ALARM;
+		data->REG_BEEP = NCT6776_REG_BEEP;
+
+		reg_temp = NCT6779_REG_TEMP;
+		num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
+		reg_temp_over = NCT6779_REG_TEMP_OVER;
+		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
+		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
+		reg_temp_alternate = NCT6779_REG_TEMP_ALTERNATE;
+		reg_temp_crit = NCT6779_REG_TEMP_CRIT;
+
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -3702,6 +3818,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		break;
 	case nct6106:
 	case nct6779:
+	case nct6791:
 		break;
 	}
 
@@ -3732,6 +3849,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		case nct6779:
 			tmp |= 0x3e;
 			break;
+		case nct6791:
+			tmp |= 0x7e;
+			break;
 		}
 		superio_outb(sio_data->sioreg, NCT6775_REG_CR_FAN_DEBOUNCE,
 			     tmp);
@@ -3900,6 +4020,7 @@ static const char * const nct6775_sio_names[] __initconst = {
 	"NCT6775F",
 	"NCT6776D/F",
 	"NCT6779D",
+	"NCT6791D",
 };
 
 /* nct6775_find() looks for a '627 in the Super-I/O config space */
@@ -3931,6 +4052,9 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 	case SIO_NCT6779_ID:
 		sio_data->kind = nct6779;
 		break;
+	case SIO_NCT6791_ID:
+		sio_data->kind = nct6791;
+		break;
 	default:
 		if (val != 0xffff)
 			pr_debug("unsupported chip ID: 0x%04x\n", val);
@@ -3955,6 +4079,15 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 		pr_warn("Forcibly enabling Super-I/O. Sensor is probably unusable.\n");
 		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
+	if (sio_data->kind = nct6791) {
+		val = superio_inb(sioaddr, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
+		if (val & 0x10) {
+			pr_info("Enabling hardware monitor logical device mappings.\n");
+			superio_outb(sioaddr,
+				     NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
+				     val & ~0x10);
+		}
+	}
 
 	superio_exit(sioaddr);
 	pr_info("Found %s or compatible chip at %#x:%#x\n",
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
