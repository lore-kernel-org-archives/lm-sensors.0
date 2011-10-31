From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Oct 2011 14:23:42 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add support for the
Message-Id: <20111031152342.15f99729@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is essentially a stripped down version of the W83627DHG. Noticeable
difference is that it is still powered with +5V, as older models, even
though the ADC resolution is 8 mV as newer models have.

Thanks to Ulf Bruman (Saab Group) for doing all the testing.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Hmm, I'm almost certain that I had originally prepared changes to
Kconfig and the documentation file too, but apparently they got lost
somewhere. I'll see if I can find a backup somewhere.

 drivers/hwmon/w83627ehf.c |  146 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 121 insertions(+), 25 deletions(-)

--- linux-3.2-rc0.orig/drivers/hwmon/w83627ehf.c	2011-10-31 14:31:50.000000000 +0100
+++ linux-3.2-rc0/drivers/hwmon/w83627ehf.c	2011-10-31 14:48:18.000000000 +0100
@@ -39,6 +39,7 @@
 					       0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
     w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
+    w83627uhg    8      2       2       2      0xa230 0xc1    0x5ca3
     w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
     w83667hg-b   9      5       3       4      0xb350 0xc1    0x5ca3
     nct6775f     9      4       3       9      0xb470 0xc1    0x5ca3
@@ -61,14 +62,17 @@
 #include <linux/io.h>
 #include "lm75.h"
 
-enum kinds { w83627ehf, w83627dhg, w83627dhg_p, w83667hg, w83667hg_b, nct6775,
-	nct6776 };
+enum kinds {
+	w83627ehf, w83627dhg, w83627dhg_p, w83627uhg,
+	w83667hg, w83667hg_b, nct6775, nct6776,
+};
 
 /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
 static const char * const w83627ehf_device_names[] = {
 	"w83627ehf",
 	"w83627dhg",
 	"w83627dhg",
+	"w83627uhg",
 	"w83667hg",
 	"w83667hg",
 	"nct6775",
@@ -104,6 +108,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable d
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
 #define SIO_W83627DHG_P_ID	0xb070
+#define SIO_W83627UHG_ID	0xa230
 #define SIO_W83667HG_ID		0xa510
 #define SIO_W83667HG_B_ID	0xb350
 #define SIO_NCT6775_ID		0xb470
@@ -388,18 +393,23 @@ div_from_reg(u8 reg)
 	return 1 << reg;
 }
 
-/* Some of analog inputs have internal scaling (2x), 8mV is ADC LSB */
-
-static u8 scale_in[10] = { 8, 8, 16, 16, 8, 8, 8, 16, 16, 8 };
+/* Some of the voltage inputs have internal scaling, the tables below
+ * contain 8 (the ADC LSB in mV) * scaling factor * 100 */
+static const u16 scale_in_common[10] = {
+	800, 800, 1600, 1600, 800, 800, 800, 1600, 1600, 800
+};
+static const u16 scale_in_w83627uhg[9] = {
+	800, 800, 3328, 3424, 800, 800, 0, 3328, 3400
+};
 
-static inline long in_from_reg(u8 reg, u8 nr)
+static inline long in_from_reg(u8 reg, u8 nr, const u16 *scale_in)
 {
-	return reg * scale_in[nr];
+	return DIV_ROUND_CLOSEST(reg * scale_in[nr], 100);
 }
 
-static inline u8 in_to_reg(u32 val, u8 nr)
+static inline u8 in_to_reg(u32 val, u8 nr, const u16 *scale_in)
 {
-	return SENSORS_LIMIT(((val + (scale_in[nr] / 2)) / scale_in[nr]), 0,
+	return SENSORS_LIMIT(DIV_ROUND_CLOSEST(val * 100, scale_in[nr]), 0,
 			     255);
 }
 
@@ -430,6 +440,7 @@ struct w83627ehf_data {
 	const u16 *REG_FAN_STOP_TIME;
 	const u16 *REG_FAN_MAX_OUTPUT;
 	const u16 *REG_FAN_STEP_OUTPUT;
+	const u16 *scale_in;
 
 	unsigned int (*fan_from_reg)(u16 reg, unsigned int divreg);
 	unsigned int (*fan_from_reg_min)(u16 reg, unsigned int divreg);
@@ -481,7 +492,8 @@ struct w83627ehf_data {
 	u8 vrm;
 
 	u16 have_temp;
-	u8 in6_skip;
+	u8 in6_skip:1;
+	u8 temp3_val_only:1;
 };
 
 struct w83627ehf_sio_data {
@@ -907,7 +919,8 @@ show_##reg(struct device *dev, struct de
 	struct sensor_device_attribute *sensor_attr = \
 		to_sensor_dev_attr(attr); \
 	int nr = sensor_attr->index; \
-	return sprintf(buf, "%ld\n", in_from_reg(data->reg[nr], nr)); \
+	return sprintf(buf, "%ld\n", in_from_reg(data->reg[nr], nr, \
+		       data->scale_in)); \
 }
 show_in_reg(in)
 show_in_reg(in_min)
@@ -928,7 +941,7 @@ store_in_##reg(struct device *dev, struc
 	if (err < 0) \
 		return err; \
 	mutex_lock(&data->update_lock); \
-	data->in_##reg[nr] = in_to_reg(val, nr); \
+	data->in_##reg[nr] = in_to_reg(val, nr, data->scale_in); \
 	w83627ehf_write_value(data, W83627EHF_REG_IN_##REG(nr), \
 			      data->in_##reg[nr]); \
 	mutex_unlock(&data->update_lock); \
@@ -1617,25 +1630,28 @@ static struct sensor_device_attribute sd
 		    store_fan_step_output, 3),
 };
 
+static struct sensor_device_attribute sda_sf3_arrays_fan3[] = {
+	SENSOR_ATTR(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
+		    store_fan_stop_time, 2),
+	SENSOR_ATTR(pwm3_start_output, S_IWUSR | S_IRUGO, show_fan_start_output,
+		    store_fan_start_output, 2),
+	SENSOR_ATTR(pwm3_stop_output, S_IWUSR | S_IRUGO, show_fan_stop_output,
+		    store_fan_stop_output, 2),
+};
+
 static struct sensor_device_attribute sda_sf3_arrays[] = {
 	SENSOR_ATTR(pwm1_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
 		    store_fan_stop_time, 0),
 	SENSOR_ATTR(pwm2_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
 		    store_fan_stop_time, 1),
-	SENSOR_ATTR(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
-		    store_fan_stop_time, 2),
 	SENSOR_ATTR(pwm1_start_output, S_IWUSR | S_IRUGO, show_fan_start_output,
 		    store_fan_start_output, 0),
 	SENSOR_ATTR(pwm2_start_output, S_IWUSR | S_IRUGO, show_fan_start_output,
 		    store_fan_start_output, 1),
-	SENSOR_ATTR(pwm3_start_output, S_IWUSR | S_IRUGO, show_fan_start_output,
-		    store_fan_start_output, 2),
 	SENSOR_ATTR(pwm1_stop_output, S_IWUSR | S_IRUGO, show_fan_stop_output,
 		    store_fan_stop_output, 0),
 	SENSOR_ATTR(pwm2_stop_output, S_IWUSR | S_IRUGO, show_fan_stop_output,
 		    store_fan_stop_output, 1),
-	SENSOR_ATTR(pwm3_stop_output, S_IWUSR | S_IRUGO, show_fan_stop_output,
-		    store_fan_stop_output, 2),
 };
 
 
@@ -1728,6 +1744,8 @@ static void w83627ehf_device_remove_file
 		    data->REG_FAN_STEP_OUTPUT[attr->index] != 0xff)
 			device_remove_file(dev, &attr->dev_attr);
 	}
+	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan3); i++)
+		device_remove_file(dev, &sda_sf3_arrays_fan3[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
 	for (i = 0; i < data->in_num; i++) {
@@ -1756,6 +1774,8 @@ static void w83627ehf_device_remove_file
 			continue;
 		device_remove_file(dev, &sda_temp_input[i].dev_attr);
 		device_remove_file(dev, &sda_temp_label[i].dev_attr);
+		if (i = 2 && data->temp3_val_only)
+			continue;
 		device_remove_file(dev, &sda_temp_max[i].dev_attr);
 		device_remove_file(dev, &sda_temp_max_hyst[i].dev_attr);
 		if (i > 2)
@@ -1808,6 +1828,9 @@ static inline void __devinit w83627ehf_i
 	case w83627ehf:
 		diode = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
 		break;
+	case w83627uhg:
+		diode = 0x00;
+		break;
 	default:
 		diode = 0x70;
 	}
@@ -1871,6 +1894,13 @@ w83627ehf_check_fan_inputs(const struct
 {
 	int fan3pin, fan4pin, fan4min, fan5pin, regval;
 
+	/* The W83627UHG is simple, only two fan inputs, no config */
+	if (sio_data->kind = w83627uhg) {
+		data->has_fan = 0x03; /* fan1 and fan2 */
+		data->has_fan_min = 0x03;
+		return;
+	}
+
 	superio_enter(sio_data->sioreg);
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
@@ -1962,11 +1992,21 @@ static int __devinit w83627ehf_probe(str
 
 	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */
 	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
-	/* 667HG, NCT6775F, and NCT6776F have 3 pwms */
-	data->pwm_num = (sio_data->kind = w83667hg
-			 || sio_data->kind = w83667hg_b
-			 || sio_data->kind = nct6775
-			 || sio_data->kind = nct6776) ? 3 : 4;
+	/* 667HG, NCT6775F, and NCT6776F have 3 pwms, and 627UHG has only 2 */
+	switch (sio_data->kind) {
+	default:
+		data->pwm_num = 4;
+		break;
+	case w83667hg:
+	case w83667hg_b:
+	case nct6775:
+	case nct6776:
+		data->pwm_num = 3;
+		break;
+	case w83627uhg:
+		data->pwm_num = 2;
+		break;
+	}
 
 	/* Default to 3 temperature inputs, code below will adjust as needed */
 	data->have_temp = 0x07;
@@ -2085,6 +2125,42 @@ static int __devinit w83627ehf_probe(str
 			data->in6_skip = 1;
 
 		data->temp_label = w83667hg_b_temp_label;
+	} else if (sio_data->kind = w83627uhg) {
+		u8 reg;
+
+		w83627ehf_set_temp_reg_ehf(data, 3);
+
+		/*
+		 * Temperature sources for temp1 and temp2 are selected with
+		 * bank 0, registers 0x49 and 0x4a.
+		 */
+		data->temp_src[0] = 0;	/* SYSTIN */
+		reg = w83627ehf_read_value(data, 0x49) & 0x07;
+		/* Adjust to have the same mapping as other source registers */
+		if (reg = 0)
+			data->temp_src[1]++;
+		else if (reg >= 2 && reg <= 5)
+			data->temp_src[1] += 2;
+		else	/* should never happen */
+			data->have_temp &= ~(1 << 1);
+		reg = w83627ehf_read_value(data, 0x4a);
+		data->temp_src[2] = reg >> 5;
+
+		/*
+		 * Skip temp3 if source is invalid or the same as temp1
+		 * or temp2.
+		 */
+		if (data->temp_src[2] = 2 || data->temp_src[2] = 3 ||
+		    data->temp_src[2] = data->temp_src[0] ||
+		    ((data->have_temp & (1 << 1)) &&
+		     data->temp_src[2] = data->temp_src[1]))
+			data->have_temp &= ~(1 << 2);
+		else
+			data->temp3_val_only = 1;	/* No limit regs */
+
+		data->in6_skip = 1;			/* No VIN3 */
+
+		data->temp_label = w83667hg_b_temp_label;
 	} else {
 		w83627ehf_set_temp_reg_ehf(data, 3);
 
@@ -2162,6 +2238,12 @@ static int __devinit w83627ehf_probe(str
 		  W83627EHF_REG_FAN_STEP_OUTPUT_COMMON;
 	}
 
+	/* Setup input voltage scaling factors */
+	if (sio_data->kind = w83627uhg)
+		data->scale_in = scale_in_w83627uhg;
+	else
+		data->scale_in = scale_in_common;
+
 	/* Initialize the chip */
 	w83627ehf_init_device(data, sio_data->kind);
 
@@ -2178,7 +2260,7 @@ static int __devinit w83627ehf_probe(str
 		err = device_create_file(dev, &dev_attr_cpu0_vid);
 		if (err)
 			goto exit_release;
-	} else {
+	} else if (sio_data->kind != w83627uhg) {
 		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
 		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
 			/* Set VID input sensibility if needed. In theory the
@@ -2268,7 +2350,14 @@ static int __devinit w83627ehf_probe(str
 				goto exit_remove;
 		}
 	}
-	/* if fan4 is enabled create the sf3 files for it */
+	/* if fan3 and fan4 are enabled create the sf3 files for them */
+	if ((data->has_fan & (1 << 2)) && data->pwm_num >= 3)
+		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan3); i++) {
+			err = device_create_file(dev,
+					&sda_sf3_arrays_fan3[i].dev_attr);
+			if (err)
+				goto exit_remove;
+		}
 	if ((data->has_fan & (1 << 3)) && data->pwm_num >= 4)
 		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			err = device_create_file(dev,
@@ -2336,6 +2425,8 @@ static int __devinit w83627ehf_probe(str
 			if (err)
 				goto exit_remove;
 		}
+		if (i = 2 && data->temp3_val_only)
+			continue;
 		if (data->reg_temp_over[i]) {
 			err = device_create_file(dev,
 				&sda_temp_max[i].dev_attr);
@@ -2419,6 +2510,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
 	static const char __initdata sio_name_W83627DHG_P[] = "W83627DHG-P";
+	static const char __initdata sio_name_W83627UHG[] = "W83627UHG";
 	static const char __initdata sio_name_W83667HG[] = "W83667HG";
 	static const char __initdata sio_name_W83667HG_B[] = "W83667HG-B";
 	static const char __initdata sio_name_NCT6775[] = "NCT6775F";
@@ -2451,6 +2543,10 @@ static int __init w83627ehf_find(int sio
 		sio_data->kind = w83627dhg_p;
 		sio_name = sio_name_W83627DHG_P;
 		break;
+	case SIO_W83627UHG_ID:
+		sio_data->kind = w83627uhg;
+		sio_name = sio_name_W83627UHG;
+		break;
 	case SIO_W83667HG_ID:
 		sio_data->kind = w83667hg;
 		sio_name = sio_name_W83667HG;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
