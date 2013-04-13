From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 16:36:43 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (nct6775) Add support for NCT6102D/6106D
Message-Id: <1365871004-14448-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |  247 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 4d63943..c58a0b6 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -33,6 +33,7 @@
  * Supports the following chips:
  *
  * Chip        #vin    #fan    #pwm    #temp  chip IDs       man ID
+ * nct6106d     9      3       3       6+3    0xc450 0xc1    0x5ca3
  * nct6775f     9      4       3       6+3    0xb470 0xc1    0x5ca3
  * nct6776f     9      5       3       6+3    0xc330 0xc1    0x5ca3
  * nct6779d    15      5       5       2+6    0xc560 0xc1    0x5ca3
@@ -59,10 +60,11 @@
 
 #define USE_ALTERNATE
 
-enum kinds { nct6775, nct6776, nct6779 };
+enum kinds { nct6106, nct6775, nct6776, nct6779 };
 
 /* used to set data->name = nct6775_device_names[data->sio_kind] */
 static const char * const nct6775_device_names[] = {
+	"nct6106",
 	"nct6775",
 	"nct6776",
 	"nct6779",
@@ -91,6 +93,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
+#define SIO_NCT6106_ID		0xc450
 #define SIO_NCT6775_ID		0xb470
 #define SIO_NCT6776_ID		0xc330
 #define SIO_NCT6779_ID		0xc560
@@ -167,7 +170,7 @@ superio_exit(int ioreg)
 #define NUM_TEMP	10	/* Max number of temp attribute sets w/ limits*/
 #define NUM_TEMP_FIXED	6	/* Max number of fixed temp attribute sets */
 
-#define NUM_REG_ALARM	4	/* Max number of alarm registers */
+#define NUM_REG_ALARM	7	/* Max number of alarm registers */
 
 /* Common and NCT6775 specific data */
 
@@ -185,6 +188,7 @@ static const u16 NCT6775_REG_IN[] = {
 
 #define NCT6775_REG_VBAT		0x5D
 #define NCT6775_REG_DIODE		0x5E
+#define NCT6775_DIODE_MASK		0x02
 
 #define NCT6775_REG_FANDIV1		0x506
 #define NCT6775_REG_FANDIV2		0x507
@@ -238,6 +242,7 @@ static const u16 NCT6775_REG_PWM_READ[] = { 0x01, 0x03, 0x11, 0x13, 0x15 };
 static const u16 NCT6775_REG_FAN[] = { 0x630, 0x632, 0x634, 0x636, 0x638 };
 static const u16 NCT6775_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d };
 static const u16 NCT6775_REG_FAN_PULSES[] = { 0x641, 0x642, 0x643, 0x644, 0 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0 };
 
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -396,6 +401,7 @@ static const u16 NCT6779_REG_FAN_PULSES[] = {
 
 static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] = {
 	0x136, 0x236, 0x336, 0x836, 0x936 };
+#define NCT6779_CRITICAL_PWM_ENABLE_MASK	0x01
 static const u16 NCT6779_REG_CRITICAL_PWM[] = {
 	0x137, 0x237, 0x337, 0x837, 0x937 };
 
@@ -449,6 +455,88 @@ static const u16 NCT6779_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6779_temp_label) - 1]
 static const u16 NCT6779_REG_TEMP_CRIT[ARRAY_SIZE(nct6779_temp_label) - 1]
 	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x709, 0x70a };
 
+/* NCT6102D/NCT6106D specific data */
+
+#define NCT6106_REG_VBAT	0x318
+#define NCT6106_REG_DIODE	0x319
+#define NCT6106_DIODE_MASK	0x01
+
+static const u16 NCT6106_REG_IN_MAX[] = {
+	0x90, 0x92, 0x94, 0x96, 0x98, 0x9a, 0x9e, 0xa0, 0xa2 };
+static const u16 NCT6106_REG_IN_MIN[] = {
+	0x91, 0x93, 0x95, 0x97, 0x99, 0x9b, 0x9f, 0xa1, 0xa3 };
+static const u16 NCT6106_REG_IN[] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x07, 0x08, 0x09 };
+
+static const u16 NCT6106_REG_TEMP[] = { 0x10, 0x11, 0x12, 0x13, 0x14, 0x15 };
+static const u16 NCT6106_REG_TEMP_HYST[] = {
+	0xc3, 0xc7, 0xcb, 0xcf, 0xd3, 0xd7 };
+static const u16 NCT6106_REG_TEMP_OVER[] = {
+	0xc2, 0xc6, 0xca, 0xce, 0xd2, 0xd4 };
+static const u16 NCT6106_REG_TEMP_OFFSET[] = { 0x311, 0x312, 0x313 };
+static const u16 NCT6106_REG_TEMP_CONFIG[] = {
+	0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc };
+
+static const u16 NCT6106_REG_FAN[] = { 0x20, 0x22, 0x24 };
+static const u16 NCT6106_REG_FAN_MIN[] = { 0xe0, 0xe2, 0xe4 };
+static const u16 NCT6106_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0, 0 };
+static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4, 0, 0 };
+
+static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
+static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
+static const u16 NCT6106_REG_PWM[] = { 0x119, 0x129, 0x139 };
+static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c };
+static const u16 NCT6106_REG_FAN_MODE[] = { 0x113, 0x123, 0x133 };
+static const u16 NCT6106_REG_TEMP_SEL[] = { 0x110, 0x120, 0x130 };
+static const u16 NCT6106_REG_TEMP_SOURCE[] = {
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5 };
+
+static const u16 NCT6106_REG_CRITICAL_TEMP[] = { 0x11a, 0x12a, 0x13a };
+static const u16 NCT6106_REG_CRITICAL_TEMP_TOLERANCE[] = {
+	0x11b, 0x12b, 0x13b };
+
+static const u16 NCT6106_REG_CRITICAL_PWM_ENABLE[] = { 0x11c, 0x12c, 0x13c };
+#define NCT6106_CRITICAL_PWM_ENABLE_MASK	0x10
+static const u16 NCT6106_REG_CRITICAL_PWM[] = { 0x11d, 0x12d, 0x13d };
+
+static const u16 NCT6106_REG_FAN_STEP_UP_TIME[] = { 0x114, 0x124, 0x134 };
+static const u16 NCT6106_REG_FAN_STEP_DOWN_TIME[] = { 0x115, 0x125, 0x135 };
+static const u16 NCT6106_REG_FAN_STOP_OUTPUT[] = { 0x116, 0x126, 0x136 };
+static const u16 NCT6106_REG_FAN_START_OUTPUT[] = { 0x117, 0x127, 0x137 };
+static const u16 NCT6106_REG_FAN_STOP_TIME[] = { 0x118, 0x128, 0x138 };
+static const u16 NCT6106_REG_TOLERANCE_H[] = { 0x112, 0x122, 0x132 };
+
+static const u16 NCT6106_REG_TARGET[] = { 0x111, 0x121, 0x131 };
+
+static const u16 NCT6106_REG_WEIGHT_TEMP_SEL[] = { 0x168, 0x178, 0x188 };
+static const u16 NCT6106_REG_WEIGHT_TEMP_STEP[] = { 0x169, 0x179, 0x189 };
+static const u16 NCT6106_REG_WEIGHT_TEMP_STEP_TOL[] = { 0x16a, 0x17a, 0x18a };
+static const u16 NCT6106_REG_WEIGHT_DUTY_STEP[] = { 0x16b, 0x17b, 0x17c };
+static const u16 NCT6106_REG_WEIGHT_TEMP_BASE[] = { 0x16c, 0x17c, 0x18c };
+static const u16 NCT6106_REG_WEIGHT_DUTY_BASE[] = { 0x16d, 0x17d, 0x18d };
+
+static const u16 NCT6106_REG_AUTO_TEMP[] = { 0x160, 0x170, 0x180 };
+static const u16 NCT6106_REG_AUTO_PWM[] = { 0x164, 0x174, 0x184 };
+
+static const u16 NCT6106_REG_ALARM[NUM_REG_ALARM] = {
+	0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d };
+
+static const s8 NCT6106_ALARM_BITS[] = {
+	0, 1, 2, 3, 4, 5, 7, 8,		/* in0.. in7 */
+	9, -1, -1, -1, -1, -1, -1,	/* in8..in14 */
+	-1,				/* unused */
+	32, 33, 34, -1, -1,		/* fan1..fan5 */
+	-1, -1, -1,			/* unused */
+	16, 17, 18, 19, 20, 21,		/* temp1..temp6 */
+	48, -1				/* intrusion0, intrusion1 */
+};
+
+static const u16 NCT6106_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6776_temp_label) - 1]
+	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x51, 0x52, 0x54 };
+
+static const u16 NCT6106_REG_TEMP_CRIT[ARRAY_SIZE(nct6776_temp_label) - 1]
+	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x204, 0x205 };
+
 static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
 {
 	if (mode = 0 && pwm = 255)
@@ -570,6 +658,7 @@ struct nct6775_data {
 	u16 REG_CONFIG;
 	u16 REG_VBAT;
 	u16 REG_DIODE;
+	u8 DIODE_MASK;
 
 	const s8 *ALARM_BITS;
 
@@ -581,6 +670,7 @@ struct nct6775_data {
 	const u16 *REG_FAN_MODE;
 	const u16 *REG_FAN_MIN;
 	const u16 *REG_FAN_PULSES;
+	const u16 *FAN_PULSE_SHIFT;
 	const u16 *REG_FAN_TIME[3];
 
 	const u16 *REG_TOLERANCE_H;
@@ -594,6 +684,10 @@ struct nct6775_data {
 				 */
 	const u16 *REG_PWM_READ;
 
+	const u16 *REG_CRITICAL_PWM_ENABLE;
+	u8 CRITICAL_PWM_ENABLE_MASK;
+	const u16 *REG_CRITICAL_PWM;
+
 	const u16 *REG_AUTO_TEMP;
 	const u16 *REG_AUTO_PWM;
 
@@ -822,6 +916,10 @@ nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
 static bool is_word_sized(struct nct6775_data *data, u16 reg)
 {
 	switch (data->kind) {
+	case nct6106:
+		return reg = 0x20 || reg = 0x22 || reg = 0x24 ||
+		  reg = 0xe0 || reg = 0xe2 || reg = 0xe4 ||
+		  reg = 0x111 || reg = 0x121 || reg = 0x131;
 	case nct6775:
 		return (((reg & 0xff00) = 0x100 ||
 		    (reg & 0xff00) = 0x200) &&
@@ -1187,15 +1285,16 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		case nct6776:
 			data->auto_pwm[i][data->auto_pwm_num] = 0xff;
 			break;
+		case nct6106:
 		case nct6779:
 			reg = nct6775_read_value(data,
-					NCT6779_REG_CRITICAL_PWM_ENABLE[i]);
-			if (reg & 1)
-				data->auto_pwm[i][data->auto_pwm_num] -				  nct6775_read_value(data,
-					NCT6779_REG_CRITICAL_PWM[i]);
+					data->REG_CRITICAL_PWM_ENABLE[i]);
+			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
+				reg = nct6775_read_value(data,
+					data->REG_CRITICAL_PWM[i]);
 			else
-				data->auto_pwm[i][data->auto_pwm_num] = 0xff;
+				reg = 0xff;
+			data->auto_pwm[i][data->auto_pwm_num] = reg;
 			break;
 		}
 	}
@@ -1241,7 +1340,8 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 				data->fan_min[i] = nct6775_read_value(data,
 					   data->REG_FAN_MIN[i]);
 			data->fan_pulses[i] -			  nct6775_read_value(data, data->REG_FAN_PULSES[i]);
+			  (nct6775_read_value(data, data->REG_FAN_PULSES[i])
+				>> data->FAN_PULSE_SHIFT[i]) & 0x03;
 
 			nct6775_select_fan_div(dev, data, i, reg);
 		}
@@ -1505,6 +1605,7 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 	int nr = sattr->index;
 	unsigned long val;
 	int err;
+	u8 reg;
 
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
@@ -1515,7 +1616,10 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->fan_pulses[nr] = val & 3;
-	nct6775_write_value(data, data->REG_FAN_PULSES[nr], val & 3);
+	reg = nct6775_read_value(data, data->REG_FAN_PULSES[nr]);
+	reg &= ~(0x03 << data->FAN_PULSE_SHIFT[nr]);
+	reg |= (val & 3) << data->FAN_PULSE_SHIFT[nr];
+	nct6775_write_value(data, data->REG_FAN_PULSES[nr], reg);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -1663,7 +1767,7 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	int nr = sattr->index;
 	unsigned long val;
 	int err;
-	u8 vbat, diode, bit;
+	u8 vbat, diode, vbit, dbit;
 
 	err = kstrtoul(buf, 10, &val);
 	if (err < 0)
@@ -1675,16 +1779,17 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 
 	data->temp_type[nr] = val;
-	vbat = nct6775_read_value(data, data->REG_VBAT) & ~(0x02 << nr);
-	diode = nct6775_read_value(data, data->REG_DIODE) & ~(0x02 << nr);
-	bit = 0x02 << nr;
+	vbit = 0x02 << nr;
+	dbit = data->DIODE_MASK << nr;
+	vbat = nct6775_read_value(data, data->REG_VBAT) & ~vbit;
+	diode = nct6775_read_value(data, data->REG_DIODE) & ~dbit;
 	switch (val) {
 	case 1:	/* CPU diode (diode, current mode) */
-		vbat |= bit;
-		diode |= bit;
+		vbat |= vbit;
+		diode |= dbit;
 		break;
 	case 3: /* diode, voltage mode */
-		vbat |= bit;
+		vbat |= dbit;
 		break;
 	case 4:	/* thermistor */
 		break;
@@ -2427,17 +2532,18 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 			break;
 		case nct6776:
 			break; /* always enabled, nothing to do */
+		case nct6106:
 		case nct6779:
-			nct6775_write_value(data, NCT6779_REG_CRITICAL_PWM[nr],
+			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
 			reg = nct6775_read_value(data,
-					NCT6779_REG_CRITICAL_PWM_ENABLE[nr]);
+					data->REG_CRITICAL_PWM_ENABLE[nr]);
 			if (val = 255)
-				reg &= ~0x01;
+				reg &= ~data->CRITICAL_PWM_ENABLE_MASK;
 			else
-				reg |= 0x01;
+				reg |= data->CRITICAL_PWM_ENABLE_MASK;
 			nct6775_write_value(data,
-					    NCT6779_REG_CRITICAL_PWM_ENABLE[nr],
+					    data->REG_CRITICAL_PWM_ENABLE[nr],
 					    reg);
 			break;
 		}
@@ -2776,8 +2882,9 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 	for (i = 0; i < data->temp_fixed_num; i++) {
 		if (!(data->have_temp_fixed & (1 << i)))
 			continue;
-		if ((tmp & (0x02 << i)))	/* diode */
-			data->temp_type[i] = 3 - ((diode >> i) & 0x02);
+		if ((tmp & (data->DIODE_MASK << i)))	/* diode */
+			data->temp_type[i]
+			  = 3 - ((diode >> i) & data->DIODE_MASK);
 		else				/* thermistor */
 			data->temp_type[i] = 4;
 	}
@@ -2831,6 +2938,17 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 		pwm3pin = fan3pin;
 		pwm4pin = 0;
 		pwm5pin = 0;
+	} else if (data->kind = nct6106) {
+		regval = superio_inb(sio_data->sioreg, 0x24);
+		fan3pin = !(regval & 0x80);
+		pwm3pin = regval & 0x08;
+		fan3min = fan3pin;
+
+		fan4pin = false;
+		fan4min = false;
+		fan5pin = false;
+		pwm4pin = false;
+		pwm5pin = false;
 	} else {	/* NCT6779D */
 		regval = superio_inb(sio_data->sioreg, 0x1c);
 
@@ -2914,6 +3032,69 @@ static int nct6775_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	switch (data->kind) {
+	case nct6106:
+		data->in_num = 9;
+		data->pwm_num = 3;
+		data->auto_pwm_num = 4;
+		data->temp_fixed_num = 3;
+
+		data->fan_from_reg = fan_from_reg13;
+		data->fan_from_reg_min = fan_from_reg13;
+
+		data->temp_label = nct6776_temp_label;
+		data->temp_label_num = ARRAY_SIZE(nct6776_temp_label);
+
+		data->REG_VBAT = NCT6106_REG_VBAT;
+		data->REG_DIODE = NCT6106_REG_DIODE;
+		data->DIODE_MASK = NCT6106_DIODE_MASK;
+		data->REG_VIN = NCT6106_REG_IN;
+		data->REG_IN_MINMAX[0] = NCT6106_REG_IN_MIN;
+		data->REG_IN_MINMAX[1] = NCT6106_REG_IN_MAX;
+		data->REG_TARGET = NCT6106_REG_TARGET;
+		data->REG_FAN = NCT6106_REG_FAN;
+		data->REG_FAN_MODE = NCT6106_REG_FAN_MODE;
+		data->REG_FAN_MIN = NCT6106_REG_FAN_MIN;
+		data->REG_FAN_PULSES = NCT6106_REG_FAN_PULSES;
+		data->FAN_PULSE_SHIFT = NCT6106_FAN_PULSE_SHIFT;
+		data->REG_FAN_TIME[0] = NCT6106_REG_FAN_STOP_TIME;
+		data->REG_FAN_TIME[1] = NCT6106_REG_FAN_STEP_UP_TIME;
+		data->REG_FAN_TIME[2] = NCT6106_REG_FAN_STEP_DOWN_TIME;
+		data->REG_PWM[0] = NCT6106_REG_PWM;
+		data->REG_PWM[1] = NCT6106_REG_FAN_START_OUTPUT;
+		data->REG_PWM[2] = NCT6106_REG_FAN_STOP_OUTPUT;
+		data->REG_PWM[5] = NCT6106_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] = NCT6106_REG_WEIGHT_DUTY_BASE;
+		data->REG_PWM_READ = NCT6106_REG_PWM_READ;
+		data->REG_PWM_MODE = NCT6106_REG_PWM_MODE;
+		data->PWM_MODE_MASK = NCT6106_PWM_MODE_MASK;
+		data->REG_AUTO_TEMP = NCT6106_REG_AUTO_TEMP;
+		data->REG_AUTO_PWM = NCT6106_REG_AUTO_PWM;
+		data->REG_CRITICAL_TEMP = NCT6106_REG_CRITICAL_TEMP;
+		data->REG_CRITICAL_TEMP_TOLERANCE
+		  = NCT6106_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_CRITICAL_PWM_ENABLE = NCT6106_REG_CRITICAL_PWM_ENABLE;
+		data->CRITICAL_PWM_ENABLE_MASK
+		  = NCT6106_CRITICAL_PWM_ENABLE_MASK;
+		data->REG_CRITICAL_PWM = NCT6106_REG_CRITICAL_PWM;
+		data->REG_TEMP_OFFSET = NCT6106_REG_TEMP_OFFSET;
+		data->REG_TEMP_SOURCE = NCT6106_REG_TEMP_SOURCE;
+		data->REG_TEMP_SEL = NCT6106_REG_TEMP_SEL;
+		data->REG_WEIGHT_TEMP_SEL = NCT6106_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] = NCT6106_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] = NCT6106_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] = NCT6106_REG_WEIGHT_TEMP_BASE;
+		data->REG_ALARM = NCT6106_REG_ALARM;
+		data->ALARM_BITS = NCT6106_ALARM_BITS;
+
+		reg_temp = NCT6106_REG_TEMP;
+		num_reg_temp = ARRAY_SIZE(NCT6106_REG_TEMP);
+		reg_temp_over = NCT6106_REG_TEMP_OVER;
+		reg_temp_hyst = NCT6106_REG_TEMP_HYST;
+		reg_temp_config = NCT6106_REG_TEMP_CONFIG;
+		reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
+		reg_temp_crit = NCT6106_REG_TEMP_CRIT;
+
+		break;
 	case nct6775:
 		data->in_num = 9;
 		data->pwm_num = 3;
@@ -2935,6 +3116,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
 		data->REG_DIODE = NCT6775_REG_DIODE;
+		data->DIODE_MASK = NCT6775_DIODE_MASK;
 		data->REG_VIN = NCT6775_REG_IN;
 		data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
 		data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
@@ -2943,6 +3125,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
 		data->REG_FAN_MIN = NCT6775_REG_FAN_MIN;
 		data->REG_FAN_PULSES = NCT6775_REG_FAN_PULSES;
+		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
 		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
@@ -2999,6 +3182,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
 		data->REG_DIODE = NCT6775_REG_DIODE;
+		data->DIODE_MASK = NCT6775_DIODE_MASK;
 		data->REG_VIN = NCT6775_REG_IN;
 		data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
 		data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
@@ -3007,6 +3191,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
 		data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
 		data->REG_FAN_PULSES = NCT6776_REG_FAN_PULSES;
+		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
 		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
@@ -3063,6 +3248,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
 		data->REG_DIODE = NCT6775_REG_DIODE;
+		data->DIODE_MASK = NCT6775_DIODE_MASK;
 		data->REG_VIN = NCT6779_REG_IN;
 		data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
 		data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
@@ -3071,6 +3257,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
 		data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
 		data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
+		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
 		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
@@ -3088,6 +3275,10 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
 		data->REG_CRITICAL_TEMP_TOLERANCE
 		  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
+		data->REG_CRITICAL_PWM_ENABLE = NCT6779_REG_CRITICAL_PWM_ENABLE;
+		data->CRITICAL_PWM_ENABLE_MASK
+		  = NCT6779_CRITICAL_PWM_ENABLE_MASK;
+		data->REG_CRITICAL_PWM = NCT6779_REG_CRITICAL_PWM;
 		data->REG_TEMP_OFFSET = NCT6779_REG_TEMP_OFFSET;
 		data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
 		data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
@@ -3237,6 +3428,7 @@ static int nct6775_probe(struct platform_device *pdev)
 	case nct6776:
 		data->have_vid = (cr2a & 0x60) = 0x40;
 		break;
+	case nct6106:
 	case nct6779:
 		break;
 	}
@@ -3258,6 +3450,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		tmp = superio_inb(sio_data->sioreg,
 				  NCT6775_REG_CR_FAN_DEBOUNCE);
 		switch (data->kind) {
+		case nct6106:
+			tmp |= 0xe0;
+			break;
 		case nct6775:
 			tmp |= 0x1e;
 			break;
@@ -3429,6 +3624,7 @@ static struct platform_driver nct6775_driver = {
 };
 
 static const char *nct6775_sio_names[] __initconst = {
+	"NCT6106D",
 	"NCT6775F",
 	"NCT6776D/F",
 	"NCT6779D",
@@ -3451,6 +3647,9 @@ static int __init nct6775_find(int sioaddr, unsigned short *addr,
 		val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8)
 		    | superio_inb(sioaddr, SIO_REG_DEVID + 1);
 	switch (val & SIO_ID_MASK) {
+	case SIO_NCT6106_ID:
+		sio_data->kind = nct6106;
+		break;
 	case SIO_NCT6775_ID:
 		sio_data->kind = nct6775;
 		break;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
