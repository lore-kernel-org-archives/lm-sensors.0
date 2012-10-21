From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Oct 2012 16:41:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Manage device specific features with table
Message-Id: <1350837712-31556-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This simplifies the code, improves runtime performance, reduces
code size (about 300 bytes on x86_64), and makes it easier
to add support for new devices.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch applies on top of the previously submitted patch series for it87.

 drivers/hwmon/it87.c |  217 ++++++++++++++++++++++++++------------------------
 1 file changed, 111 insertions(+), 106 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index e7b604c..560f9a9 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -61,8 +61,8 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8782,
-	     it8783 };
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8726, it8728,
+	     it8782, it8783 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -228,6 +228,74 @@ static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
 #define IT87_REG_AUTO_TEMP(nr, i) (0x60 + (nr) * 8 + (i))
 #define IT87_REG_AUTO_PWM(nr, i)  (0x65 + (nr) * 8 + (i))
 
+struct it87_devices {
+	const char * const name;
+	u16 id;
+	u16 features;
+};
+
+#define	FEAT_12MV_ADC		(1 << 0)
+#define	FEAT_NEWER_AUTOPWM	(1 << 1)
+#define	FEAT_OLD_AUTOPWM	(1 << 2)
+#define	FEAT_16BIT_FAN		(1 << 3)
+
+static const struct it87_devices it87_devices[] = {
+	[it87] = {
+		.name = "it87",
+		.id = IT8705F_DEVID,
+		.features = FEAT_OLD_AUTOPWM,	/* may need to override */
+	},
+	[it8712] = {
+		.name = "it8712",
+		.id = IT8712F_DEVID,
+		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
+	},
+	[it8716] = {
+		.name = "it8716",
+		.id = IT8716F_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+	[it8718] = {
+		.name = "it8718",
+		.id = IT8718F_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+	[it8720] = {
+		.name = "it8720",
+		.id = IT8720F_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+	[it8721] = {
+		.name = "it8721",
+		.id = IT8721F_DEVID,
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN,
+	},
+	[it8726] = {
+		.name = "it8726",
+		.id = IT8726F_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+	[it8728] = {
+		.name = "it8728",
+		.id = IT8728F_DEVID,
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FAN,
+	},
+	[it8782] = {
+		.name = "it8782",
+		.id = IT8782F_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+	[it8783] = {
+		.name = "it8783",
+		.id = IT8783E_DEVID,
+		.features = FEAT_16BIT_FAN,
+	},
+};
+
+#define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FAN)
+#define has_12mv_adc(data)	((data)->features & FEAT_12MV_ADC)
+#define has_newer_autopwm(data)	((data)->features & FEAT_NEWER_AUTOPWM)
+#define has_old_autopwm(data)	((data)->features & FEAT_OLD_AUTOPWM)
 
 struct it87_sio_data {
 	enum chips type;
@@ -251,8 +319,7 @@ struct it87_sio_data {
 struct it87_data {
 	struct device *hwmon_dev;
 	enum chips type;
-	bool has_16bit_fans;
-	u8 revision;
+	u32 features;
 
 	unsigned short addr;
 	const char *name;
@@ -294,26 +361,6 @@ struct it87_data {
 	s8 auto_temp[3][5];	/* [nr][0] is point1_temp_hyst */
 };
 
-static inline int has_12mv_adc(const struct it87_data *data)
-{
-	/*
-	 * IT8721F and later have a 12 mV ADC, also with internal scaling
-	 * on selected inputs.
-	 */
-	return data->type = it8721
-	    || data->type = it8728;
-}
-
-static inline int has_newer_autopwm(const struct it87_data *data)
-{
-	/*
-	 * IT8721F and later have separate registers for the temperature
-	 * mapping and the manual duty cycle.
-	 */
-	return data->type = it8721
-	    || data->type = it8728;
-}
-
 static int adc_lsb(const struct it87_data *data, int nr)
 {
 	int lsb = has_12mv_adc(data) ? 12 : 16;
@@ -396,35 +443,6 @@ static const unsigned int pwm_freq[8] = {
 	750000 / 128,
 };
 
-static inline int has_16bit_fans(const struct it87_data *data)
-{
-	/*
-	 * IT8705F Datasheet 0.4.1, 3h = Version G.
-	 * IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
-	 * These are the first revisions with 16-bit tachometer support.
-	 */
-	return (data->type = it87 && data->revision >= 0x03)
-	    || (data->type = it8712 && data->revision >= 0x08)
-	    || data->type = it8716
-	    || data->type = it8718
-	    || data->type = it8720
-	    || data->type = it8721
-	    || data->type = it8728
-	    || data->type = it8782
-	    || data->type = it8783;
-}
-
-static inline int has_old_autopwm(const struct it87_data *data)
-{
-	/*
-	 * The old automatic fan speed control interface is implemented
-	 * by IT8705F chips up to revision F and IT8712F chips up to
-	 * revision G.
-	 */
-	return (data->type = it87 && data->revision < 0x03)
-	    || (data->type = it8712 && data->revision < 0x08);
-}
-
 static int it87_probe(struct platform_device *pdev);
 static int __devexit it87_remove(struct platform_device *pdev);
 
@@ -642,7 +660,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 	int speed;
 	struct it87_data *data = it87_update_device(dev);
 
-	speed = data->has_16bit_fans ?
+	speed = has_16bit_fans(data) ?
 		FAN16_FROM_REG(data->fan[nr][index]) :
 		FAN_FROM_REG(data->fan[nr][index],
 			     DIV_FROM_REG(data->fan_div[nr]));
@@ -702,7 +720,7 @@ static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 
-	if (!data->has_16bit_fans) {
+	if (!has_16bit_fans(data)) {
 		reg = it87_read_value(data, IT87_REG_FAN_DIV);
 		switch (nr) {
 		case 0:
@@ -1576,7 +1594,7 @@ static const struct attribute_group it87_group_label = {
 static int __init it87_find(unsigned short *address,
 	struct it87_sio_data *sio_data)
 {
-	int err;
+	int i, err;
 	u16 chip_type;
 	const char *board_vendor, *board_name;
 
@@ -1587,38 +1605,16 @@ static int __init it87_find(unsigned short *address,
 	err = -ENODEV;
 	chip_type = force_id ? force_id : superio_inw(DEVID);
 
-	switch (chip_type) {
-	case IT8705F_DEVID:
-		sio_data->type = it87;
-		break;
-	case IT8712F_DEVID:
-		sio_data->type = it8712;
-		break;
-	case IT8716F_DEVID:
-	case IT8726F_DEVID:
-		sio_data->type = it8716;
-		break;
-	case IT8718F_DEVID:
-		sio_data->type = it8718;
-		break;
-	case IT8720F_DEVID:
-		sio_data->type = it8720;
-		break;
-	case IT8721F_DEVID:
-		sio_data->type = it8721;
-		break;
-	case IT8728F_DEVID:
-		sio_data->type = it8728;
-		break;
-	case IT8782F_DEVID:
-		sio_data->type = it8782;
-		break;
-	case IT8783E_DEVID:
-		sio_data->type = it8783;
-		break;
-	case 0xffff:	/* No device at all */
+	if (chip_type = 0xffff)
 		goto exit;
-	default:
+
+	for (i = 0; i < ARRAY_SIZE(it87_devices); i++) {
+		if (chip_type = it87_devices[i].id) {
+			sio_data->type = i;
+			break;
+		}
+	}
+	if (i = ARRAY_SIZE(it87_devices)) {
 		pr_debug("Unsupported chip (DEVID=0x%x)\n", chip_type);
 		goto exit;
 	}
@@ -1860,7 +1856,7 @@ static void it87_remove_files(struct device *dev)
 		if (sio_data->beep_pin)
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_fan_beep[i]);
-		if (i < 3 && !data->has_16bit_fans)
+		if (i < 3 && !has_16bit_fans(data))
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_fan_div[i]);
 	}
@@ -1886,17 +1882,6 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	int err = 0, i;
 	int enable_pwm_interface;
 	int fan_beep_need_rw;
-	static const char * const names[] = {
-		"it87",
-		"it8712",
-		"it8716",
-		"it8718",
-		"it8720",
-		"it8721",
-		"it8728",
-		"it8782",
-		"it8783",
-	};
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IT87_EC_EXTENT,
@@ -1913,8 +1898,29 @@ static int __devinit it87_probe(struct platform_device *pdev)
 
 	data->addr = res->start;
 	data->type = sio_data->type;
-	data->revision = sio_data->revision;
-	data->name = names[sio_data->type];
+	data->features = it87_devices[data->type].features;
+	data->name = it87_devices[sio_data->type].name;
+	/*
+	 * IT8705F Datasheet 0.4.1, 3h = Version G.
+	 * IT8712F Datasheet 0.9.1, section 8.3.5 indicates 8h = Version J.
+	 * These are the first revisions with 16-bit tachometer support.
+	 */
+	switch (data->type) {
+	case it87:
+		if (sio_data->revision >= 0x03) {
+			data->features &= ~FEAT_OLD_AUTOPWM;
+			data->features |= FEAT_16BIT_FAN;
+		}
+		break;
+	case it8712:
+		if (sio_data->revision >= 0x08) {
+			data->features &= ~FEAT_OLD_AUTOPWM;
+			data->features |= FEAT_16BIT_FAN;
+		}
+		break;
+	default:
+		break;
+	}
 
 	/* Now, we do the remaining detection. */
 	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
@@ -1995,7 +2001,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
 		if (err)
 			goto error;
 
-		if (i < 3 && !data->has_16bit_fans) {
+		if (i < 3 && !has_16bit_fans(data)) {
 			err = sysfs_create_file(&dev->kobj,
 						it87_attributes_fan_div[i]);
 			if (err)
@@ -2232,10 +2238,9 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 				 data->fan_main_ctrl);
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
-	data->has_16bit_fans = has_16bit_fans(data);
 
 	/* Set tachometers to 16-bit mode if needed */
-	if (data->has_16bit_fans) {
+	if (has_16bit_fans(data)) {
 		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&pdev->dev,
@@ -2326,7 +2331,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 			data->fan[i][0] = it87_read_value(data,
 				       IT87_REG_FAN[i]);
 			/* Add high byte if in 16-bit mode */
-			if (data->has_16bit_fans) {
+			if (has_16bit_fans(data)) {
 				data->fan[i][0] |= it87_read_value(data,
 						IT87_REG_FANX[i]) << 8;
 				data->fan[i][1] |= it87_read_value(data,
@@ -2347,7 +2352,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 		}
 
 		/* Newer chips don't have clock dividers */
-		if ((data->has_fan & 0x07) && !data->has_16bit_fans) {
+		if ((data->has_fan & 0x07) && !has_16bit_fans(data)) {
 			i = it87_read_value(data, IT87_REG_FAN_DIV);
 			data->fan_div[0] = i & 0x07;
 			data->fan_div[1] = (i >> 3) & 0x07;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
