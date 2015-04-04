From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:55:11 +0000
Subject: [lm-sensors] [PATCH 20/22] hwmon: (it87) Use BIT macro
Message-Id: <1428184513-22380-21-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using the BIT macro makes the code a little easier to read and has the
added benefit of making checkpatch happy.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 288 ++++++++++++++++++++++++++-------------------------
 1 file changed, 145 insertions(+), 143 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 37a2827348b6..bac1fd7f3b2a 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -51,6 +51,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -264,22 +265,22 @@ struct it87_devices {
 	u8 old_peci_mask;
 };
 
-#define FEAT_12MV_ADC		(1 << 0)
-#define FEAT_NEWER_AUTOPWM	(1 << 1)
-#define FEAT_OLD_AUTOPWM	(1 << 2)
-#define FEAT_16BIT_FANS		(1 << 3)
-#define FEAT_TEMP_OFFSET	(1 << 4)
-#define FEAT_TEMP_PECI		(1 << 5)
-#define FEAT_TEMP_OLD_PECI	(1 << 6)
-#define FEAT_FAN16_CONFIG	(1 << 7)	/* Need to enable 16-bit fans */
-#define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
-#define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
-#define FEAT_IN7_INTERNAL	(1 << 10)	/* Set if in7 is internal */
-#define FEAT_SIX_FANS		(1 << 11)	/* Supports six fans */
-#define FEAT_AVCC3		(1 << 12)	/* Chip supports in9/AVCC3 */
-#define FEAT_SIX_PWM		(1 << 13)	/* Chip supports 6 pwm chn */
-#define FEAT_PWM_FREQ2		(1 << 14)	/* Separate pwm freq 2 */
-#define FEAT_SIX_TEMP		(1 << 15)	/* Up to 6 temp sensors */
+#define FEAT_12MV_ADC		BIT(0)
+#define FEAT_NEWER_AUTOPWM	BIT(1)
+#define FEAT_OLD_AUTOPWM	BIT(2)
+#define FEAT_16BIT_FANS		BIT(3)
+#define FEAT_TEMP_OFFSET	BIT(4)
+#define FEAT_TEMP_PECI		BIT(5)
+#define FEAT_TEMP_OLD_PECI	BIT(6)
+#define FEAT_FAN16_CONFIG	BIT(7)	/* Need to enable 16-bit fans */
+#define FEAT_FIVE_FANS		BIT(8)	/* Supports five fans */
+#define FEAT_VID		BIT(9)	/* Set if chip supports VID */
+#define FEAT_IN7_INTERNAL	BIT(10)	/* Set if in7 is internal */
+#define FEAT_SIX_FANS		BIT(11)	/* Supports six fans */
+#define FEAT_AVCC3		BIT(12)	/* Chip supports in9/AVCC3 */
+#define FEAT_SIX_PWM		BIT(13)	/* Chip supports 6 pwm chn */
+#define FEAT_PWM_FREQ2		BIT(14)	/* Separate pwm freq 2 */
+#define FEAT_SIX_TEMP		BIT(15)	/* Up to 6 temp sensors */
 
 static const struct it87_devices it87_devices[] = {
 	[it87] = {
@@ -419,10 +420,10 @@ static const struct it87_devices it87_devices[] = {
 #define has_old_autopwm(data)	((data)->features & FEAT_OLD_AUTOPWM)
 #define has_temp_offset(data)	((data)->features & FEAT_TEMP_OFFSET)
 #define has_temp_peci(data, nr)	(((data)->features & FEAT_TEMP_PECI) && \
-				 ((data)->peci_mask & (1 << nr)))
+				 ((data)->peci_mask & BIT(nr)))
 #define has_temp_old_peci(data, nr) \
 				(((data)->features & FEAT_TEMP_OLD_PECI) && \
-				 ((data)->old_peci_mask & (1 << nr)))
+				 ((data)->old_peci_mask & BIT(nr)))
 #define has_fan16_config(data)	((data)->features & FEAT_FAN16_CONFIG)
 #define has_five_fans(data)	((data)->features & (FEAT_FIVE_FANS | \
 						     FEAT_SIX_FANS))
@@ -509,7 +510,7 @@ struct it87_data {
 static int adc_lsb(const struct it87_data *data, int nr)
 {
 	int lsb = has_12mv_adc(data) ? 12 : 16;
-	if (data->in_scaled & (1 << nr))
+	if (data->in_scaled & BIT(nr))
 		lsb <<= 1;
 	return lsb;
 }
@@ -574,7 +575,8 @@ static int DIV_TO_REG(int val)
 		answer++;
 	return answer;
 }
-#define DIV_FROM_REG(val) (1 << (val))
+
+#define DIV_FROM_REG(val) BIT(val)
 
 /*
  * PWM base frequencies. The frequency has to be divided by either 128 or 256,
@@ -664,7 +666,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 				it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
 		for (i = 0; i < ARRAY_SIZE(IT87_REG_VIN); i++) {
-			if (!(data->has_in & (1 << i)))
+			if (!(data->has_in & BIT(i)))
 				continue;
 
 			data->in[i][0] @@ -682,7 +684,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 
 		for (i = 0; i < 6; i++) {
 			/* Skip disabled fans */
-			if (!(data->has_fan & (1 << i)))
+			if (!(data->has_fan & BIT(i)))
 				continue;
 
 			data->fan[i][1] @@ -698,7 +700,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 			}
 		}
 		for (i = 0; i < 6; i++) {
-			if (!(data->has_temp & (1 << i)))
+			if (!(data->has_temp & BIT(i)))
 				continue;
 			data->temp[i][0]  				it87_read_value(data, IT87_REG_TEMP(i));
@@ -1005,7 +1007,7 @@ static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR, show_temp_type,
 
 static int pwm_mode(const struct it87_data *data, int nr)
 {
-	int ctrl = data->fan_main_ctrl & (1 << nr);
+	int ctrl = data->fan_main_ctrl & BIT(nr);
 
 	if (ctrl = 0 && data->type != it8603)		/* Full speed */
 		return 0;
@@ -1038,7 +1040,7 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+	return sprintf(buf, "%lu\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 static ssize_t show_pwm_enable(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -1222,9 +1224,9 @@ static ssize_t set_pwm_enable(struct device *dev,
 		int tmp;
 		/* make sure the fan is on when in on/off mode */
 		tmp = it87_read_value(data, IT87_REG_FAN_CTL);
-		it87_write_value(data, IT87_REG_FAN_CTL, tmp | (1 << nr));
+		it87_write_value(data, IT87_REG_FAN_CTL, tmp | BIT(nr));
 		/* set on/off mode */
-		data->fan_main_ctrl &= ~(1 << nr);
+		data->fan_main_ctrl &= ~BIT(nr);
 		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
 				 data->fan_main_ctrl);
 	} else {
@@ -1238,7 +1240,7 @@ static ssize_t set_pwm_enable(struct device *dev,
 
 		if (data->type != it8603) {
 			/* set SmartGuardian mode */
-			data->fan_main_ctrl |= (1 << nr);
+			data->fan_main_ctrl |= BIT(nr);
 			it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
 					 data->fan_main_ctrl);
 		}
@@ -1332,7 +1334,7 @@ static ssize_t show_pwm_temp_map(struct device *dev,
 	int map;
 
 	if (data->pwm_temp_map[nr] < 3)
-		map = 1 << data->pwm_temp_map[nr];
+		map = BIT(data->pwm_temp_map[nr]);
 	else
 		map = 0;			/* Should never happen */
 	return sprintf(buf, "%d\n", map);
@@ -1351,13 +1353,13 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 		return -EINVAL;
 
 	switch (val) {
-	case (1 << 0):
+	case BIT(0):
 		reg = 0x00;
 		break;
-	case (1 << 1):
+	case BIT(1):
 		reg = 0x01;
 		break;
-	case (1 << 2):
+	case BIT(2):
 		reg = 0x02;
 		break;
 	default:
@@ -1604,7 +1606,7 @@ static ssize_t clear_intrusion(struct device *dev, struct device_attribute
 	if (config < 0) {
 		count = config;
 	} else {
-		config |= 1 << 5;
+		config |= BIT(5);
 		it87_write_value(data, IT87_REG_CONFIG, config);
 		/* Invalidate cache to force re-read */
 		data->valid = 0;
@@ -1655,9 +1657,9 @@ static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	data->beeps = it87_read_value(data, IT87_REG_BEEP_ENABLE);
 	if (val)
-		data->beeps |= (1 << bitnr);
+		data->beeps |= BIT(bitnr);
 	else
-		data->beeps &= ~(1 << bitnr);
+		data->beeps &= ~BIT(bitnr);
 	it87_write_value(data, IT87_REG_BEEP_ENABLE, data->beeps);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1751,7 +1753,7 @@ static umode_t it87_in_is_visible(struct kobject *kobj,
 		a = 0;
 	}
 
-	if (!(data->has_in & (1 << i)))
+	if (!(data->has_in & BIT(i)))
 		return 0;
 
 	if (a = 4 && !data->has_beep)
@@ -1834,7 +1836,7 @@ static umode_t it87_temp_is_visible(struct kobject *kobj,
 		a = 0;
 	}
 
-	if (!(data->has_temp & (1 << i)))
+	if (!(data->has_temp & BIT(i)))
 		return 0;
 
 	if (a = 5 && !has_temp_offset(data))
@@ -1891,7 +1893,7 @@ static umode_t it87_is_visible(struct kobject *kobj,
 	if ((index = 2 || index = 3) && !data->has_vid)
 		return 0;
 
-	if (index > 3 && !(data->in_internal & (1 << (index - 4))))
+	if (index > 3 && !(data->in_internal & BIT(index - 4)))
 		return 0;
 
 	return attr->mode;
@@ -1927,7 +1929,7 @@ static umode_t it87_fan_is_visible(struct kobject *kobj,
 		a = (index - 15) % 4;
 	}
 
-	if (!(data->has_fan & (1 << i)))
+	if (!(data->has_fan & BIT(i)))
 		return 0;
 
 	if (a = 3) {				/* beep */
@@ -1993,7 +1995,7 @@ static umode_t it87_pwm_is_visible(struct kobject *kobj,
 	int i = index / 4;	/* pwm index */
 	int a = index % 4;	/* attribute index */
 
-	if (!(data->has_pwm & (1 << i)))
+	if (!(data->has_pwm & BIT(i)))
 		return 0;
 
 	/* pwmX_auto_channels_temp is only writable for old auto pwm */
@@ -2053,7 +2055,7 @@ static umode_t it87_auto_pwm_is_visible(struct kobject *kobj,
 	struct it87_data *data = dev_get_drvdata(dev);
 	int i = index / 9;	/* pwm index */
 
-	if (!(data->has_pwm & (1 << i)))
+	if (!(data->has_pwm & BIT(i)))
 		return 0;
 
 	return attr->mode;
@@ -2194,19 +2196,19 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 
 	/* in7 (VSB or VCCH5V) is always internal on some chips */
 	if (has_in7_internal(config))
-		sio_data->internal |= (1 << 1);
+		sio_data->internal |= BIT(1);
 
 	/* in8 (Vbat) is always internal */
-	sio_data->internal |= (1 << 2);
+	sio_data->internal |= BIT(2);
 
 	/* in9 (AVCC3), always internal if supported */
 	if (has_avcc3(config))
-		sio_data->internal |= (1 << 3); /* in9 is AVCC */
+		sio_data->internal |= BIT(3); /* in9 is AVCC */
 	else
-		sio_data->skip_in |= (1 << 9);
+		sio_data->skip_in |= BIT(9);
 
 	if (!has_six_pwm(config))
-		sio_data->skip_pwm |= (1 << 3) | (1 << 4) | (1 << 5);
+		sio_data->skip_pwm |= BIT(3) | BIT(4) | BIT(5);
 
 	if (!has_vid(config))
 		sio_data->skip_vid = 1;
@@ -2229,31 +2231,31 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		regef = superio_inb(sioaddr, IT87_SIO_SPI_REG);
 
 		/* Check if fan3 is there or not */
-		if ((reg27 & (1 << 0)) || !(reg2c & (1 << 2)))
-			sio_data->skip_fan |= (1 << 2);
-		if ((reg25 & (1 << 4))
-		    || (!(reg2a & (1 << 1)) && (regef & (1 << 0))))
-			sio_data->skip_pwm |= (1 << 2);
+		if ((reg27 & BIT(0)) || !(reg2c & BIT(2)))
+			sio_data->skip_fan |= BIT(2);
+		if ((reg25 & BIT(4))
+		    || (!(reg2a & BIT(1)) && (regef & BIT(0))))
+			sio_data->skip_pwm |= BIT(2);
 
 		/* Check if fan2 is there or not */
-		if (reg27 & (1 << 7))
-			sio_data->skip_fan |= (1 << 1);
-		if (reg27 & (1 << 3))
-			sio_data->skip_pwm |= (1 << 1);
+		if (reg27 & BIT(7))
+			sio_data->skip_fan |= BIT(1);
+		if (reg27 & BIT(3))
+			sio_data->skip_pwm |= BIT(1);
 
 		/* VIN5 */
-		if ((reg27 & (1 << 0)) || (reg2c & (1 << 2)))
-			sio_data->skip_in |= (1 << 5); /* No VIN5 */
+		if ((reg27 & BIT(0)) || (reg2c & BIT(2)))
+			sio_data->skip_in |= BIT(5); /* No VIN5 */
 
 		/* VIN6 */
-		if (reg27 & (1 << 1))
-			sio_data->skip_in |= (1 << 6); /* No VIN6 */
+		if (reg27 & BIT(1))
+			sio_data->skip_in |= BIT(6); /* No VIN6 */
 
 		/*
 		 * VIN7
 		 * Does not depend on bit 2 of Reg2C, contrary to datasheet.
 		 */
-		if (reg27 & (1 << 2)) {
+		if (reg27 & BIT(2)) {
 			/*
 			 * The data sheet is a bit unclear regarding the
 			 * internal voltage divider for VCCH5V. It says
@@ -2267,8 +2269,8 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 			 * not the case, and ask the user to report if the
 			 * resulting voltage is sane.
 			 */
-			if (!(reg2c & (1 << 1))) {
-				reg2c |= (1 << 1);
+			if (!(reg2c & BIT(1))) {
+				reg2c |= BIT(1);
 				superio_outb(sioaddr, IT87_SIO_PINX2_REG,
 					     reg2c);
 				pr_notice("Routing internal VCCH5V to in7.\n");
@@ -2277,10 +2279,10 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 			pr_notice("Please report if it displays a reasonable voltage.\n");
 		}
 
-		if (reg2c & (1 << 0))
-			sio_data->internal |= (1 << 0);
-		if (reg2c & (1 << 1))
-			sio_data->internal |= (1 << 1);
+		if (reg2c & BIT(0))
+			sio_data->internal |= BIT(0);
+		if (reg2c & BIT(1))
+			sio_data->internal |= BIT(1);
 
 		sio_data->beep_pin = superio_inb(sioaddr,
 						 IT87_SIO_BEEP_PIN_REG) & 0x3f;
@@ -2292,20 +2294,20 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		reg27 = superio_inb(sioaddr, IT87_SIO_GPIO3_REG);
 
 		/* Check if fan3 is there or not */
-		if (reg27 & (1 << 6))
-			sio_data->skip_pwm |= (1 << 2);
-		if (reg27 & (1 << 7))
-			sio_data->skip_fan |= (1 << 2);
+		if (reg27 & BIT(6))
+			sio_data->skip_pwm |= BIT(2);
+		if (reg27 & BIT(7))
+			sio_data->skip_fan |= BIT(2);
 
 		/* Check if fan2 is there or not */
 		reg29 = superio_inb(sioaddr, IT87_SIO_GPIO5_REG);
-		if (reg29 & (1 << 1))
-			sio_data->skip_pwm |= (1 << 1);
-		if (reg29 & (1 << 2))
-			sio_data->skip_fan |= (1 << 1);
+		if (reg29 & BIT(1))
+			sio_data->skip_pwm |= BIT(1);
+		if (reg29 & BIT(2))
+			sio_data->skip_fan |= BIT(1);
 
-		sio_data->skip_in |= (1 << 5); /* No VIN5 */
-		sio_data->skip_in |= (1 << 6); /* No VIN6 */
+		sio_data->skip_in |= BIT(5); /* No VIN5 */
+		sio_data->skip_in |= BIT(6); /* No VIN6 */
 
 		sio_data->beep_pin = superio_inb(sioaddr,
 						 IT87_SIO_BEEP_PIN_REG) & 0x3f;
@@ -2316,38 +2318,38 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 
 		/* Check for pwm5 */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO1_REG);
-		if (reg & (1 << 6))
-			sio_data->skip_pwm |= (1 << 4);
+		if (reg & BIT(6))
+			sio_data->skip_pwm |= BIT(4);
 
 		/* Check for fan4, fan5 */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO2_REG);
-		if (!(reg & (1 << 5)))
-			sio_data->skip_fan |= (1 << 3);
-		if (!(reg & (1 << 4)))
-			sio_data->skip_fan |= (1 << 4);
+		if (!(reg & BIT(5)))
+			sio_data->skip_fan |= BIT(3);
+		if (!(reg & BIT(4)))
+			sio_data->skip_fan |= BIT(4);
 
 		/* Check for pwm3, fan3 */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO3_REG);
-		if (reg & (1 << 6))
-			sio_data->skip_pwm |= (1 << 2);
-		if (reg & (1 << 7))
-			sio_data->skip_fan |= (1 << 2);
+		if (reg & BIT(6))
+			sio_data->skip_pwm |= BIT(2);
+		if (reg & BIT(7))
+			sio_data->skip_fan |= BIT(2);
 
 		/* Check for pwm4 */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO4_REG);
-		if (!(reg & (1 << 4)))
-			sio_data->skip_pwm |= (1 << 3);
+		if (!(reg & BIT(4)))
+			sio_data->skip_pwm |= BIT(3);
 
 		/* Check for pwm2, fan2 */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO5_REG);
-		if (reg & (1 << 1))
-			sio_data->skip_pwm |= (1 << 1);
-		if (reg & (1 << 2))
-			sio_data->skip_fan |= (1 << 1);
+		if (reg & BIT(1))
+			sio_data->skip_pwm |= BIT(1);
+		if (reg & BIT(2))
+			sio_data->skip_fan |= BIT(1);
 		/* Check for pwm6, fan6 */
-		if (!(reg & (1 << 7))) {
-			sio_data->skip_pwm |= (1 << 5);
-			sio_data->skip_fan |= (1 << 5);
+		if (!(reg & BIT(7))) {
+			sio_data->skip_pwm |= BIT(5);
+			sio_data->skip_fan |= BIT(5);
 		}
 
 		sio_data->beep_pin = superio_inb(sioaddr,
@@ -2368,17 +2370,17 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		}
 
 		/* Check if fan3 is there or not */
-		if (reg & (1 << 6))
-			sio_data->skip_pwm |= (1 << 2);
-		if (reg & (1 << 7))
-			sio_data->skip_fan |= (1 << 2);
+		if (reg & BIT(6))
+			sio_data->skip_pwm |= BIT(2);
+		if (reg & BIT(7))
+			sio_data->skip_fan |= BIT(2);
 
 		/* Check if fan2 is there or not */
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO5_REG);
-		if (reg & (1 << 1))
-			sio_data->skip_pwm |= (1 << 1);
-		if (reg & (1 << 2))
-			sio_data->skip_fan |= (1 << 1);
+		if (reg & BIT(1))
+			sio_data->skip_pwm |= BIT(1);
+		if (reg & BIT(2))
+			sio_data->skip_fan |= BIT(1);
 
 		if ((sio_data->type = it8718 || sio_data->type = it8720)
 		 && !(sio_data->skip_vid))
@@ -2387,7 +2389,7 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 
 		reg = superio_inb(sioaddr, IT87_SIO_PINX2_REG);
 
-		uart6 = sio_data->type = it8782 && (reg & (1 << 2));
+		uart6 = sio_data->type = it8782 && (reg & BIT(2));
 
 		/*
 		 * The IT8720F has no VIN7 pin, so VCCH should always be
@@ -2403,15 +2405,15 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		 * If UART6 is enabled, re-route VIN7 to the internal divider
 		 * if that is not already the case.
 		 */
-		if ((sio_data->type = it8720 || uart6) && !(reg & (1 << 1))) {
-			reg |= (1 << 1);
+		if ((sio_data->type = it8720 || uart6) && !(reg & BIT(1))) {
+			reg |= BIT(1);
 			superio_outb(sioaddr, IT87_SIO_PINX2_REG, reg);
 			pr_notice("Routing internal VCCH to in7\n");
 		}
-		if (reg & (1 << 0))
-			sio_data->internal |= (1 << 0);
-		if (reg & (1 << 1))
-			sio_data->internal |= (1 << 1);
+		if (reg & BIT(0))
+			sio_data->internal |= BIT(0);
+		if (reg & BIT(1))
+			sio_data->internal |= BIT(1);
 
 		/*
 		 * On IT8782F, UART6 pins overlap with VIN5, VIN6, and VIN7.
@@ -2423,8 +2425,8 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		 * temperature source here, skip_temp is preliminary.
 		 */
 		if (uart6) {
-			sio_data->skip_in |= (1 << 5) | (1 << 6);
-			sio_data->skip_temp |= (1 << 2);
+			sio_data->skip_in |= BIT(5) | BIT(6);
+			sio_data->skip_temp |= BIT(2);
 		}
 
 		sio_data->beep_pin = superio_inb(sioaddr,
@@ -2448,7 +2450,7 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 			 * the same board is ever used in other systems.
 			 */
 			pr_info("Disabling pwm2 due to hardware constraints\n");
-			sio_data->skip_pwm = (1 << 1);
+			sio_data->skip_pwm = BIT(1);
 		}
 	}
 
@@ -2541,12 +2543,12 @@ static void it87_init_device(struct platform_device *pdev)
 
 	/* Check for additional fans */
 	if (has_five_fans(data)) {
-		if (tmp & (1 << 4))
-			data->has_fan |= (1 << 3); /* fan4 enabled */
-		if (tmp & (1 << 5))
-			data->has_fan |= (1 << 4); /* fan5 enabled */
-		if (has_six_fans(data) && (tmp & (1 << 2)))
-			data->has_fan |= (1 << 5); /* fan6 enabled */
+		if (tmp & BIT(4))
+			data->has_fan |= BIT(3); /* fan4 enabled */
+		if (tmp & BIT(5))
+			data->has_fan |= BIT(4); /* fan5 enabled */
+		if (has_six_fans(data) && (tmp & BIT(2)))
+			data->has_fan |= BIT(5); /* fan6 enabled */
 	}
 
 	/* Fan input pins may be used for alternative functions */
@@ -2557,9 +2559,9 @@ static void it87_init_device(struct platform_device *pdev)
 		/* The following code may be IT8620E specific */
 		tmp = it87_read_value(data, IT87_REG_FAN_DIV);
 		if ((tmp & 0xc0) = 0xc0)
-			sio_data->skip_pwm |= (1 << 4);
-		if (!(tmp & (1 << 3)))
-			sio_data->skip_pwm |= (1 << 5);
+			sio_data->skip_pwm |= BIT(4);
+		if (!(tmp & BIT(3)))
+			sio_data->skip_pwm |= BIT(5);
 	}
 
 	/* Start monitoring */
@@ -2689,27 +2691,27 @@ static int it87_probe(struct platform_device *pdev)
 
 	/* Starting with IT8721F, we handle scaling of internal voltages */
 	if (has_12mv_adc(data)) {
-		if (sio_data->internal & (1 << 0))
-			data->in_scaled |= (1 << 3);	/* in3 is AVCC */
-		if (sio_data->internal & (1 << 1))
-			data->in_scaled |= (1 << 7);	/* in7 is VSB */
-		if (sio_data->internal & (1 << 2))
-			data->in_scaled |= (1 << 8);	/* in8 is Vbat */
-		if (sio_data->internal & (1 << 3))
-			data->in_scaled |= (1 << 9);	/* in9 is AVCC */
+		if (sio_data->internal & BIT(0))
+			data->in_scaled |= BIT(3);	/* in3 is AVCC */
+		if (sio_data->internal & BIT(1))
+			data->in_scaled |= BIT(7);	/* in7 is VSB */
+		if (sio_data->internal & BIT(2))
+			data->in_scaled |= BIT(8);	/* in8 is Vbat */
+		if (sio_data->internal & BIT(3))
+			data->in_scaled |= BIT(9);	/* in9 is AVCC */
 	} else if (sio_data->type = it8781 || sio_data->type = it8782 ||
 		   sio_data->type = it8783) {
-		if (sio_data->internal & (1 << 0))
-			data->in_scaled |= (1 << 3);	/* in3 is VCC5V */
-		if (sio_data->internal & (1 << 1))
-			data->in_scaled |= (1 << 7);	/* in7 is VCCH5V */
+		if (sio_data->internal & BIT(0))
+			data->in_scaled |= BIT(3);	/* in3 is VCC5V */
+		if (sio_data->internal & BIT(1))
+			data->in_scaled |= BIT(7);	/* in7 is VCCH5V */
 	}
 
 	data->has_temp = 0x07;
-	if (sio_data->skip_temp & (1 << 2)) {
+	if (sio_data->skip_temp & BIT(2)) {
 		if (sio_data->type = it8782
 		    && !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
-			data->has_temp &= ~(1 << 2);
+			data->has_temp &= ~BIT(2);
 	}
 
 	data->in_internal = sio_data->internal;
@@ -2720,19 +2722,19 @@ static int it87_probe(struct platform_device *pdev)
 
 		/* Check for additional temperature sensors */
 		if ((reg & 0x03) >= 0x02)
-			data->has_temp |= (1 << 3);
+			data->has_temp |= BIT(3);
 		if (((reg >> 2) & 0x03) >= 0x02)
-			data->has_temp |= (1 << 4);
+			data->has_temp |= BIT(4);
 		if (((reg >> 4) & 0x03) >= 0x02)
-			data->has_temp |= (1 << 5);
+			data->has_temp |= BIT(5);
 
 		/* Check for additional voltage sensors */
 		if ((reg & 0x03) = 0x01)
-			data->has_in |= (1 << 10);
+			data->has_in |= BIT(10);
 		if (((reg >> 2) & 0x03) = 0x01)
-			data->has_in |= (1 << 11);
+			data->has_in |= BIT(11);
 		if (((reg >> 4) & 0x03) = 0x01)
-			data->has_in |= (1 << 12);
+			data->has_in |= BIT(12);
 	}
 
 	data->has_beep = !!sio_data->beep_pin;
@@ -2754,7 +2756,7 @@ static int it87_probe(struct platform_device *pdev)
 	data->groups[3] = &it87_group_fan;
 
 	if (enable_pwm_interface) {
-		data->has_pwm = (1 << ARRAY_SIZE(IT87_REG_PWM)) - 1;
+		data->has_pwm = BIT(ARRAY_SIZE(IT87_REG_PWM)) - 1;
 		data->has_pwm &= ~sio_data->skip_pwm;
 
 		data->groups[4] = &it87_group_pwm;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
