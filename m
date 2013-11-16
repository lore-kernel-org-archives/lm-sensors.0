From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 16 Nov 2013 15:06:55 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Monitor additional temperature registers
Message-Id: <1384614416-27489-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The number of SMIOVT registers on NCT6779 and NCT6791 is limited to 2.
As result, the driver may not report some of the temperatures used for fan
control. Fortunately, the chip has registers to monitor those temperatures.
Add them to the list of temperatures to report.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   62 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index d17325d..3f4ef21 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -274,6 +274,8 @@ static const u16 NCT6775_FAN_PULSE_SHIFT[] = { 0, 0, 0, 0, 0, 0 };
 static const u16 NCT6775_REG_TEMP[] = {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
 
+static const u16 NCT6775_REG_TEMP_MON[] = { 0x73, 0x75, 0x77 };
+
 static const u16 NCT6775_REG_TEMP_CONFIG[ARRAY_SIZE(NCT6775_REG_TEMP)] = {
 	0, 0x152, 0x252, 0x628, 0x629, 0x62A };
 static const u16 NCT6775_REG_TEMP_HYST[ARRAY_SIZE(NCT6775_REG_TEMP)] = {
@@ -454,6 +456,7 @@ static const u16 NCT6779_REG_CRITICAL_PWM[] = {
 	0x137, 0x237, 0x337, 0x837, 0x937, 0xa37 };
 
 static const u16 NCT6779_REG_TEMP[] = { 0x27, 0x150 };
+static const u16 NCT6779_REG_TEMP_MON[] = { 0x73, 0x75, 0x77, 0x79, 0x7b };
 static const u16 NCT6779_REG_TEMP_CONFIG[ARRAY_SIZE(NCT6779_REG_TEMP)] = {
 	0x18, 0x152 };
 static const u16 NCT6779_REG_TEMP_HYST[ARRAY_SIZE(NCT6779_REG_TEMP)] = {
@@ -534,6 +537,7 @@ static const u16 NCT6106_REG_IN[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x07, 0x08, 0x09 };
 
 static const u16 NCT6106_REG_TEMP[] = { 0x10, 0x11, 0x12, 0x13, 0x14, 0x15 };
+static const u16 NCT6106_REG_TEMP_MON[] = { 0x18, 0x19, 0x1a };
 static const u16 NCT6106_REG_TEMP_HYST[] = {
 	0xc3, 0xc7, 0xcb, 0xcf, 0xd3, 0xd7 };
 static const u16 NCT6106_REG_TEMP_OVER[] = {
@@ -3253,9 +3257,9 @@ static int nct6775_probe(struct platform_device *pdev)
 	int i, s, err = 0;
 	int src, mask, available;
 	const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
-	const u16 *reg_temp_alternate, *reg_temp_crit;
+	const u16 *reg_temp_mon, *reg_temp_alternate, *reg_temp_crit;
 	const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
-	int num_reg_temp;
+	int num_reg_temp, num_reg_temp_mon;
 	u8 cr2a;
 	struct attribute_group *group;
 	struct device *hwmon_dev;
@@ -3338,7 +3342,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->BEEP_BITS = NCT6106_BEEP_BITS;
 
 		reg_temp = NCT6106_REG_TEMP;
+		reg_temp_mon = NCT6106_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6106_REG_TEMP);
+		num_reg_temp_mon = ARRAY_SIZE(NCT6106_REG_TEMP_MON);
 		reg_temp_over = NCT6106_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6106_REG_TEMP_HYST;
 		reg_temp_config = NCT6106_REG_TEMP_CONFIG;
@@ -3410,7 +3416,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_BEEP = NCT6775_REG_BEEP;
 
 		reg_temp = NCT6775_REG_TEMP;
+		reg_temp_mon = NCT6775_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
+		num_reg_temp_mon = ARRAY_SIZE(NCT6775_REG_TEMP_MON);
 		reg_temp_over = NCT6775_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6775_REG_TEMP_HYST;
 		reg_temp_config = NCT6775_REG_TEMP_CONFIG;
@@ -3480,7 +3488,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_BEEP = NCT6776_REG_BEEP;
 
 		reg_temp = NCT6775_REG_TEMP;
+		reg_temp_mon = NCT6775_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
+		num_reg_temp_mon = ARRAY_SIZE(NCT6775_REG_TEMP_MON);
 		reg_temp_over = NCT6775_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6775_REG_TEMP_HYST;
 		reg_temp_config = NCT6776_REG_TEMP_CONFIG;
@@ -3554,7 +3564,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_BEEP = NCT6776_REG_BEEP;
 
 		reg_temp = NCT6779_REG_TEMP;
+		reg_temp_mon = NCT6779_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
+		num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
 		reg_temp_over = NCT6779_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
@@ -3628,7 +3640,9 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_BEEP = NCT6776_REG_BEEP;
 
 		reg_temp = NCT6779_REG_TEMP;
+		reg_temp_mon = NCT6779_REG_TEMP_MON;
 		num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
+		num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
 		reg_temp_over = NCT6779_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
@@ -3729,6 +3743,50 @@ static int nct6775_probe(struct platform_device *pdev)
 		s++;
 	}
 
+	/*
+	 * Repeat with temperatures used for fan control.
+	 * This set of registers does not support limits.
+	 */
+	for (i = 0; i < num_reg_temp_mon; i++) {
+		if (reg_temp_mon[i] = 0)
+			continue;
+
+		src = nct6775_read_value(data, data->REG_TEMP_SEL[i]) & 0x1f;
+		if (!src || (mask & (1 << src)))
+			continue;
+
+		if (src >= data->temp_label_num ||
+		    !strlen(data->temp_label[src])) {
+			dev_info(dev,
+				 "Invalid temperature source %d at index %d, source register 0x%x, temp register 0x%x\n",
+				 src, i, data->REG_TEMP_SEL[i],
+				 reg_temp_mon[i]);
+			continue;
+		}
+
+		mask |= 1 << src;
+
+		/* Use fixed index for SYSTIN(1), CPUTIN(2), AUXTIN(3) */
+		if (src <= data->temp_fixed_num) {
+			if (data->have_temp & (1 << (src - 1)))
+				continue;
+			data->have_temp |= 1 << (src - 1);
+			data->have_temp_fixed |= 1 << (src - 1);
+			data->reg_temp[0][src - 1] = reg_temp_mon[i];
+			data->temp_src[src - 1] = src;
+			continue;
+		}
+
+		if (s >= NUM_TEMP)
+			continue;
+
+		/* Use dynamic index for other sources */
+		data->have_temp |= 1 << s;
+		data->reg_temp[0][s] = reg_temp_mon[i];
+		data->temp_src[s] = src;
+		s++;
+	}
+
 #ifdef USE_ALTERNATE
 	/*
 	 * Go through the list of alternate temp registers and enable
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
