From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:02:43 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (w83627hf) Rearrange code to no longer require forward declarations
Message-Id: <1363219364-5221-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |  883 +++++++++++++++++++++++-----------------------
 1 file changed, 436 insertions(+), 447 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 4ec5692..765d419 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -396,91 +396,182 @@ struct w83627hf_data {
 #endif
 };
 
+/* Registers 0x50-0x5f are banked */
+static inline void w83627hf_set_bank(struct w83627hf_data *data, u16 reg)
+{
+	if ((reg & 0x00f0) = 0x50) {
+		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(reg >> 8, data->addr + W83781D_DATA_REG_OFFSET);
+	}
+}
 
-static int w83627hf_probe(struct platform_device *pdev);
-static int w83627hf_remove(struct platform_device *pdev);
-
-static int w83627hf_read_value(struct w83627hf_data *data, u16 reg);
-static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value);
-static void w83627hf_update_fan_div(struct w83627hf_data *data);
-static struct w83627hf_data *w83627hf_update_device(struct device *dev);
-static void w83627hf_init_device(struct platform_device *pdev);
+/* Not strictly necessary, but play it safe for now */
+static inline void w83627hf_reset_bank(struct w83627hf_data *data, u16 reg)
+{
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
+	}
+}
 
-#ifdef CONFIG_PM
-static int w83627hf_suspend(struct device *dev)
+/* Caller must hold update_lock except if called during initialization */
+static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 {
-	struct w83627hf_data *data = w83627hf_update_device(dev);
+	int res, word_sized;
 
-	mutex_lock(&data->update_lock);
-	data->scfg1 = w83627hf_read_value(data, W83781D_REG_SCFG1);
-	data->scfg2 = w83627hf_read_value(data, W83781D_REG_SCFG2);
-	mutex_unlock(&data->update_lock);
+	word_sized = (((reg & 0xff00) = 0x100)
+		   || ((reg & 0xff00) = 0x200))
+		  && (((reg & 0x00ff) = 0x50)
+		   || ((reg & 0x00ff) = 0x53)
+		   || ((reg & 0x00ff) = 0x55));
+	w83627hf_set_bank(data, reg);
+	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
+	res = inb_p(data->addr + W83781D_DATA_REG_OFFSET);
+	if (word_sized) {
+		outb_p((reg & 0xff) + 1,
+		       data->addr + W83781D_ADDR_REG_OFFSET);
+		res +		    (res << 8) + inb_p(data->addr +
+				       W83781D_DATA_REG_OFFSET);
+	}
+	w83627hf_reset_bank(data, reg);
+	return res;
+}
+
+/* Caller must hold update_lock except if called during initialization */
+static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
+{
+	int word_sized;
 
+	word_sized = (((reg & 0xff00) = 0x100)
+		   || ((reg & 0xff00) = 0x200))
+		  && (((reg & 0x00ff) = 0x53)
+		   || ((reg & 0x00ff) = 0x55));
+	w83627hf_set_bank(data, reg);
+	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
+	if (word_sized) {
+		outb_p(value >> 8,
+		       data->addr + W83781D_DATA_REG_OFFSET);
+		outb_p((reg & 0xff) + 1,
+		       data->addr + W83781D_ADDR_REG_OFFSET);
+	}
+	outb_p(value & 0xff,
+	       data->addr + W83781D_DATA_REG_OFFSET);
+	w83627hf_reset_bank(data, reg);
 	return 0;
 }
 
-static int w83627hf_resume(struct device *dev)
+static void w83627hf_update_fan_div(struct w83627hf_data *data)
+{
+	int reg;
+
+	reg = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
+	data->fan_div[0] = (reg >> 4) & 0x03;
+	data->fan_div[1] = (reg >> 6) & 0x03;
+	if (data->type != w83697hf) {
+		data->fan_div[2] = (w83627hf_read_value(data,
+				       W83781D_REG_PIN) >> 6) & 0x03;
+	}
+	reg = w83627hf_read_value(data, W83781D_REG_VBAT);
+	data->fan_div[0] |= (reg >> 3) & 0x04;
+	data->fan_div[1] |= (reg >> 4) & 0x04;
+	if (data->type != w83697hf)
+		data->fan_div[2] |= (reg >> 5) & 0x04;
+}
+
+static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	int i, num_temps = (data->type = w83697hf) ? 2 : 3;
+	int num_pwms = (data->type = w83697hf) ? 2 : 3;
 
-	/* Restore limits */
 	mutex_lock(&data->update_lock);
-	for (i = 0; i <= 8; i++) {
-		/* skip missing sensors */
-		if (((data->type = w83697hf) && (i = 1)) ||
-		    ((data->type != w83627hf && data->type != w83697hf)
-		    && (i = 5 || i = 6)))
-			continue;
-		w83627hf_write_value(data, W83781D_REG_IN_MAX(i),
-				     data->in_max[i]);
-		w83627hf_write_value(data, W83781D_REG_IN_MIN(i),
-				     data->in_min[i]);
-	}
-	for (i = 0; i <= 2; i++)
-		w83627hf_write_value(data, W83627HF_REG_FAN_MIN(i),
-				     data->fan_min[i]);
-	for (i = 0; i < num_temps; i++) {
-		w83627hf_write_value(data, w83627hf_reg_temp_over[i],
-				     data->temp_max[i]);
-		w83627hf_write_value(data, w83627hf_reg_temp_hyst[i],
-				     data->temp_max_hyst[i]);
-	}
-
-	/* Fixup BIOS bugs */
-	if (data->type = w83627thf || data->type = w83637hf ||
-	    data->type = w83687thf)
-		w83627hf_write_value(data, W83627THF_REG_VRM_OVT_CFG,
-				     data->vrm_ovt);
-	w83627hf_write_value(data, W83781D_REG_SCFG1, data->scfg1);
-	w83627hf_write_value(data, W83781D_REG_SCFG2, data->scfg2);
 
-	/* Force re-reading all values */
-	data->valid = 0;
-	mutex_unlock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		for (i = 0; i <= 8; i++) {
+			/* skip missing sensors */
+			if (((data->type = w83697hf) && (i = 1)) ||
+			    ((data->type != w83627hf && data->type != w83697hf)
+			    && (i = 5 || i = 6)))
+				continue;
+			data->in[i] +			    w83627hf_read_value(data, W83781D_REG_IN(i));
+			data->in_min[i] +			    w83627hf_read_value(data,
+					       W83781D_REG_IN_MIN(i));
+			data->in_max[i] +			    w83627hf_read_value(data,
+					       W83781D_REG_IN_MAX(i));
+		}
+		for (i = 0; i <= 2; i++) {
+			data->fan[i] +			    w83627hf_read_value(data, W83627HF_REG_FAN(i));
+			data->fan_min[i] +			    w83627hf_read_value(data,
+					       W83627HF_REG_FAN_MIN(i));
+		}
+		for (i = 0; i <= 2; i++) {
+			u8 tmp = w83627hf_read_value(data,
+				W836X7HF_REG_PWM(data->type, i));
+			/* bits 0-3 are reserved  in 627THF */
+			if (data->type = w83627thf)
+				tmp &= 0xf0;
+			data->pwm[i] = tmp;
+			if (i = 1 &&
+			    (data->type = w83627hf || data->type = w83697hf))
+				break;
+		}
+		if (data->type = w83627hf) {
+				u8 tmp = w83627hf_read_value(data,
+						W83627HF_REG_PWM_FREQ);
+				data->pwm_freq[0] = tmp & 0x07;
+				data->pwm_freq[1] = (tmp >> 4) & 0x07;
+		} else if (data->type != w83627thf) {
+			for (i = 1; i <= 3; i++) {
+				data->pwm_freq[i - 1] +					w83627hf_read_value(data,
+						W83637HF_REG_PWM_FREQ[i - 1]);
+				if (i = 2 && (data->type = w83697hf))
+					break;
+			}
+		}
+		if (data->type != w83627hf) {
+			for (i = 0; i < num_pwms; i++) {
+				u8 tmp = w83627hf_read_value(data,
+					W83627THF_REG_PWM_ENABLE[i]);
+				data->pwm_enable[i] +					((tmp >> W83627THF_PWM_ENABLE_SHIFT[i])
+					& 0x03) + 1;
+			}
+		}
+		for (i = 0; i < num_temps; i++) {
+			data->temp[i] +			  w83627hf_read_value(data, w83627hf_reg_temp[i]);
+			data->temp_max[i] +			  w83627hf_read_value(data, w83627hf_reg_temp_over[i]);
+			data->temp_max_hyst[i] +			  w83627hf_read_value(data, w83627hf_reg_temp_hyst[i]);
+		}
 
-	return 0;
-}
+		w83627hf_update_fan_div(data);
 
-static const struct dev_pm_ops w83627hf_dev_pm_ops = {
-	.suspend = w83627hf_suspend,
-	.resume = w83627hf_resume,
-};
+		data->alarms +		    w83627hf_read_value(data, W83781D_REG_ALARM1) |
+		    (w83627hf_read_value(data, W83781D_REG_ALARM2) << 8) |
+		    (w83627hf_read_value(data, W83781D_REG_ALARM3) << 16);
+		i = w83627hf_read_value(data, W83781D_REG_BEEP_INTS2);
+		data->beep_mask = (i << 8) |
+		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS1) |
+		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS3) << 16;
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
 
-#define W83627HF_DEV_PM_OPS	(&w83627hf_dev_pm_ops)
-#else
-#define W83627HF_DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
+	mutex_unlock(&data->update_lock);
 
-static struct platform_driver w83627hf_driver = {
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= DRVNAME,
-		.pm	= W83627HF_DEV_PM_OPS,
-	},
-	.probe		= w83627hf_probe,
-	.remove		= w83627hf_remove,
-};
+	return data;
+}
 
 static ssize_t
 show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -1284,83 +1375,19 @@ show_name(struct device *dev, struct device_attribute *devattr, char *buf)
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static int __init w83627hf_find(int sioaddr, unsigned short *addr,
-				struct w83627hf_sio_data *sio_data)
-{
-	int err = -ENODEV;
-	u16 val;
+#define VIN_UNIT_ATTRS(_X_)	\
+	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_max.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_alarm.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_beep.dev_attr.attr
 
-	static __initconst char *const names[] = {
-		"W83627HF",
-		"W83627THF",
-		"W83697HF",
-		"W83637HF",
-		"W83687THF",
-	};
-
-	sio_data->sioaddr = sioaddr;
-	superio_enter(sio_data);
-	val = force_id ? force_id : superio_inb(sio_data, DEVID);
-	switch (val) {
-	case W627_DEVID:
-		sio_data->type = w83627hf;
-		break;
-	case W627THF_DEVID:
-		sio_data->type = w83627thf;
-		break;
-	case W697_DEVID:
-		sio_data->type = w83697hf;
-		break;
-	case W637_DEVID:
-		sio_data->type = w83637hf;
-		break;
-	case W687THF_DEVID:
-		sio_data->type = w83687thf;
-		break;
-	case 0xff:	/* No device at all */
-		goto exit;
-	default:
-		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
-		goto exit;
-	}
-
-	superio_select(sio_data, W83627HF_LD_HWM);
-	val = (superio_inb(sio_data, WINB_BASE_REG) << 8) |
-	       superio_inb(sio_data, WINB_BASE_REG + 1);
-	*addr = val & WINB_ALIGNMENT;
-	if (*addr = 0) {
-		pr_warn("Base address not set, skipping\n");
-		goto exit;
-	}
-
-	val = superio_inb(sio_data, WINB_ACT_REG);
-	if (!(val & 0x01)) {
-		pr_warn("Enabling HWM logical device\n");
-		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
-	}
-
-	err = 0;
-	pr_info(DRVNAME ": Found %s chip at %#x\n",
-		names[sio_data->type], *addr);
-
- exit:
-	superio_exit(sio_data);
-	return err;
-}
-
-#define VIN_UNIT_ATTRS(_X_)	\
-	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
-	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
-	&sensor_dev_attr_in##_X_##_max.dev_attr.attr,		\
-	&sensor_dev_attr_in##_X_##_alarm.dev_attr.attr,		\
-	&sensor_dev_attr_in##_X_##_beep.dev_attr.attr
-
-#define FAN_UNIT_ATTRS(_X_)	\
-	&sensor_dev_attr_fan##_X_##_input.dev_attr.attr,	\
-	&sensor_dev_attr_fan##_X_##_min.dev_attr.attr,		\
-	&sensor_dev_attr_fan##_X_##_div.dev_attr.attr,		\
-	&sensor_dev_attr_fan##_X_##_alarm.dev_attr.attr,	\
-	&sensor_dev_attr_fan##_X_##_beep.dev_attr.attr
+#define FAN_UNIT_ATTRS(_X_)	\
+	&sensor_dev_attr_fan##_X_##_input.dev_attr.attr,	\
+	&sensor_dev_attr_fan##_X_##_min.dev_attr.attr,		\
+	&sensor_dev_attr_fan##_X_##_div.dev_attr.attr,		\
+	&sensor_dev_attr_fan##_X_##_alarm.dev_attr.attr,	\
+	&sensor_dev_attr_fan##_X_##_beep.dev_attr.attr
 
 #define TEMP_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_temp##_X_##_input.dev_attr.attr,	\
@@ -1426,6 +1453,150 @@ static const struct attribute_group w83627hf_group_opt = {
 	.attrs = w83627hf_attributes_opt,
 };
 
+static int w83627thf_read_gpio5(struct platform_device *pdev)
+{
+	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
+	int res = 0xff, sel;
+
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_GPIO5);
+
+	/* Make sure these GPIO pins are enabled */
+	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
+		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
+		goto exit;
+	}
+
+	/*
+	 * Make sure the pins are configured for input
+	 * There must be at least five (VRM 9), and possibly 6 (VRM 10)
+	 */
+	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
+	if ((sel & 0x1f) != 0x1f) {
+		dev_dbg(&pdev->dev,
+			"GPIO5 not configured for VID function\n");
+		goto exit;
+	}
+
+	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
+	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
+
+exit:
+	superio_exit(sio_data);
+	return res;
+}
+
+static int w83687thf_read_vid(struct platform_device *pdev)
+{
+	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
+	int res = 0xff;
+
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_HWM);
+
+	/* Make sure these GPIO pins are enabled */
+	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
+		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
+		goto exit;
+	}
+
+	/* Make sure the pins are configured for input */
+	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
+		dev_dbg(&pdev->dev,
+			"VID configured as output, no VID function\n");
+		goto exit;
+	}
+
+	res = superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
+
+exit:
+	superio_exit(sio_data);
+	return res;
+}
+
+static void w83627hf_init_device(struct platform_device *pdev)
+{
+	struct w83627hf_data *data = platform_get_drvdata(pdev);
+	int i;
+	enum chips type = data->type;
+	u8 tmp;
+
+	/* Minimize conflicts with other winbond i2c-only clients...  */
+	/* disable i2c subclients... how to disable main i2c client?? */
+	/* force i2c address to relatively uncommon address */
+	if (type = w83627hf) {
+		w83627hf_write_value(data, W83781D_REG_I2C_SUBADDR, 0x89);
+		w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
+	}
+
+	/* Read VID only once */
+	if (type = w83627hf || type = w83637hf) {
+		int lo = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
+		int hi = w83627hf_read_value(data, W83781D_REG_CHIPID);
+		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
+	} else if (type = w83627thf) {
+		data->vid = w83627thf_read_gpio5(pdev);
+	} else if (type = w83687thf) {
+		data->vid = w83687thf_read_vid(pdev);
+	}
+
+	/* Read VRM & OVT Config only once */
+	if (type = w83627thf || type = w83637hf || type = w83687thf) {
+		data->vrm_ovt +			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
+	}
+
+	tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
+	for (i = 1; i <= 3; i++) {
+		if (!(tmp & BIT_SCFG1[i - 1])) {
+			data->sens[i - 1] = 4;
+		} else {
+			if (w83627hf_read_value
+			    (data,
+			     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
+				data->sens[i - 1] = 1;
+			else
+				data->sens[i - 1] = 2;
+		}
+		if ((type = w83697hf) && (i = 2))
+			break;
+	}
+
+	if (init) {
+		/* Enable temp2 */
+		tmp = w83627hf_read_value(data, W83627HF_REG_TEMP2_CONFIG);
+		if (tmp & 0x01) {
+			dev_warn(&pdev->dev,
+				 "Enabling temp2, readings might not make sense\n");
+			w83627hf_write_value(data, W83627HF_REG_TEMP2_CONFIG,
+				tmp & 0xfe);
+		}
+
+		/* Enable temp3 */
+		if (type != w83697hf) {
+			tmp = w83627hf_read_value(data,
+				W83627HF_REG_TEMP3_CONFIG);
+			if (tmp & 0x01) {
+				dev_warn(&pdev->dev,
+					 "Enabling temp3, readings might not make sense\n");
+				w83627hf_write_value(data,
+					W83627HF_REG_TEMP3_CONFIG, tmp & 0xfe);
+			}
+		}
+	}
+
+	/* Start monitoring */
+	w83627hf_write_value(data, W83781D_REG_CONFIG,
+			    (w83627hf_read_value(data,
+						W83781D_REG_CONFIG) & 0xf7)
+			    | 0x01);
+
+	/* Enable VBAT monitoring if needed */
+	tmp = w83627hf_read_value(data, W83781D_REG_VBAT);
+	if (!(tmp & 0x01))
+		w83627hf_write_value(data, W83781D_REG_VBAT, tmp | 0x01);
+}
+
 static int w83627hf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1603,327 +1774,81 @@ static int w83627hf_remove(struct platform_device *pdev)
 	return 0;
 }
 
-
-/* Registers 0x50-0x5f are banked */
-static inline void w83627hf_set_bank(struct w83627hf_data *data, u16 reg)
-{
-	if ((reg & 0x00f0) = 0x50) {
-		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(reg >> 8, data->addr + W83781D_DATA_REG_OFFSET);
-	}
-}
-
-/* Not strictly necessary, but play it safe for now */
-static inline void w83627hf_reset_bank(struct w83627hf_data *data, u16 reg)
+#ifdef CONFIG_PM
+static int w83627hf_suspend(struct device *dev)
 {
-	if (reg & 0xff00) {
-		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
-	}
-}
+	struct w83627hf_data *data = w83627hf_update_device(dev);
 
-/* Caller must hold update_lock except if called during initialization */
-static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
-{
-	int res, word_sized;
+	mutex_lock(&data->update_lock);
+	data->scfg1 = w83627hf_read_value(data, W83781D_REG_SCFG1);
+	data->scfg2 = w83627hf_read_value(data, W83781D_REG_SCFG2);
+	mutex_unlock(&data->update_lock);
 
-	word_sized = (((reg & 0xff00) = 0x100)
-		   || ((reg & 0xff00) = 0x200))
-		  && (((reg & 0x00ff) = 0x50)
-		   || ((reg & 0x00ff) = 0x53)
-		   || ((reg & 0x00ff) = 0x55));
-	w83627hf_set_bank(data, reg);
-	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
-	res = inb_p(data->addr + W83781D_DATA_REG_OFFSET);
-	if (word_sized) {
-		outb_p((reg & 0xff) + 1,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-		res -		    (res << 8) + inb_p(data->addr +
-				       W83781D_DATA_REG_OFFSET);
-	}
-	w83627hf_reset_bank(data, reg);
-	return res;
+	return 0;
 }
 
-static int w83627thf_read_gpio5(struct platform_device *pdev)
+static int w83627hf_resume(struct device *dev)
 {
-	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
-	int res = 0xff, sel;
-
-	superio_enter(sio_data);
-	superio_select(sio_data, W83627HF_LD_GPIO5);
-
-	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
-		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
-		goto exit;
-	}
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	int i, num_temps = (data->type = w83697hf) ? 2 : 3;
 
-	/*
-	 * Make sure the pins are configured for input
-	 * There must be at least five (VRM 9), and possibly 6 (VRM 10)
-	 */
-	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
-	if ((sel & 0x1f) != 0x1f) {
-		dev_dbg(&pdev->dev,
-			"GPIO5 not configured for VID function\n");
-		goto exit;
-	}
-
-	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
-	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
-
-exit:
-	superio_exit(sio_data);
-	return res;
-}
-
-static int w83687thf_read_vid(struct platform_device *pdev)
-{
-	struct w83627hf_sio_data *sio_data = pdev->dev.platform_data;
-	int res = 0xff;
-
-	superio_enter(sio_data);
-	superio_select(sio_data, W83627HF_LD_HWM);
-
-	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
-		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
-		goto exit;
+	/* Restore limits */
+	mutex_lock(&data->update_lock);
+	for (i = 0; i <= 8; i++) {
+		/* skip missing sensors */
+		if (((data->type = w83697hf) && (i = 1)) ||
+		    ((data->type != w83627hf && data->type != w83697hf)
+		    && (i = 5 || i = 6)))
+			continue;
+		w83627hf_write_value(data, W83781D_REG_IN_MAX(i),
+				     data->in_max[i]);
+		w83627hf_write_value(data, W83781D_REG_IN_MIN(i),
+				     data->in_min[i]);
 	}
-
-	/* Make sure the pins are configured for input */
-	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
-		dev_dbg(&pdev->dev,
-			"VID configured as output, no VID function\n");
-		goto exit;
+	for (i = 0; i <= 2; i++)
+		w83627hf_write_value(data, W83627HF_REG_FAN_MIN(i),
+				     data->fan_min[i]);
+	for (i = 0; i < num_temps; i++) {
+		w83627hf_write_value(data, w83627hf_reg_temp_over[i],
+				     data->temp_max[i]);
+		w83627hf_write_value(data, w83627hf_reg_temp_hyst[i],
+				     data->temp_max_hyst[i]);
 	}
 
-	res = superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
-
-exit:
-	superio_exit(sio_data);
-	return res;
-}
+	/* Fixup BIOS bugs */
+	if (data->type = w83627thf || data->type = w83637hf ||
+	    data->type = w83687thf)
+		w83627hf_write_value(data, W83627THF_REG_VRM_OVT_CFG,
+				     data->vrm_ovt);
+	w83627hf_write_value(data, W83781D_REG_SCFG1, data->scfg1);
+	w83627hf_write_value(data, W83781D_REG_SCFG2, data->scfg2);
 
-/* Caller must hold update_lock except if called during initialization */
-static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
-{
-	int word_sized;
+	/* Force re-reading all values */
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
 
-	word_sized = (((reg & 0xff00) = 0x100)
-		   || ((reg & 0xff00) = 0x200))
-		  && (((reg & 0x00ff) = 0x53)
-		   || ((reg & 0x00ff) = 0x55));
-	w83627hf_set_bank(data, reg);
-	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
-	if (word_sized) {
-		outb_p(value >> 8,
-		       data->addr + W83781D_DATA_REG_OFFSET);
-		outb_p((reg & 0xff) + 1,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-	}
-	outb_p(value & 0xff,
-	       data->addr + W83781D_DATA_REG_OFFSET);
-	w83627hf_reset_bank(data, reg);
 	return 0;
 }
 
-static void w83627hf_init_device(struct platform_device *pdev)
-{
-	struct w83627hf_data *data = platform_get_drvdata(pdev);
-	int i;
-	enum chips type = data->type;
-	u8 tmp;
-
-	/* Minimize conflicts with other winbond i2c-only clients...  */
-	/* disable i2c subclients... how to disable main i2c client?? */
-	/* force i2c address to relatively uncommon address */
-	if (type = w83627hf) {
-		w83627hf_write_value(data, W83781D_REG_I2C_SUBADDR, 0x89);
-		w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
-	}
-
-	/* Read VID only once */
-	if (type = w83627hf || type = w83637hf) {
-		int lo = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
-		int hi = w83627hf_read_value(data, W83781D_REG_CHIPID);
-		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
-	} else if (type = w83627thf) {
-		data->vid = w83627thf_read_gpio5(pdev);
-	} else if (type = w83687thf) {
-		data->vid = w83687thf_read_vid(pdev);
-	}
-
-	/* Read VRM & OVT Config only once */
-	if (type = w83627thf || type = w83637hf || type = w83687thf) {
-		data->vrm_ovt -			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
-	}
-
-	tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
-	for (i = 1; i <= 3; i++) {
-		if (!(tmp & BIT_SCFG1[i - 1])) {
-			data->sens[i - 1] = 4;
-		} else {
-			if (w83627hf_read_value
-			    (data,
-			     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])
-				data->sens[i - 1] = 1;
-			else
-				data->sens[i - 1] = 2;
-		}
-		if ((type = w83697hf) && (i = 2))
-			break;
-	}
-
-	if (init) {
-		/* Enable temp2 */
-		tmp = w83627hf_read_value(data, W83627HF_REG_TEMP2_CONFIG);
-		if (tmp & 0x01) {
-			dev_warn(&pdev->dev,
-				 "Enabling temp2, readings might not make sense\n");
-			w83627hf_write_value(data, W83627HF_REG_TEMP2_CONFIG,
-				tmp & 0xfe);
-		}
-
-		/* Enable temp3 */
-		if (type != w83697hf) {
-			tmp = w83627hf_read_value(data,
-				W83627HF_REG_TEMP3_CONFIG);
-			if (tmp & 0x01) {
-				dev_warn(&pdev->dev,
-					 "Enabling temp3, readings might not make sense\n");
-				w83627hf_write_value(data,
-					W83627HF_REG_TEMP3_CONFIG, tmp & 0xfe);
-			}
-		}
-	}
-
-	/* Start monitoring */
-	w83627hf_write_value(data, W83781D_REG_CONFIG,
-			    (w83627hf_read_value(data,
-						W83781D_REG_CONFIG) & 0xf7)
-			    | 0x01);
-
-	/* Enable VBAT monitoring if needed */
-	tmp = w83627hf_read_value(data, W83781D_REG_VBAT);
-	if (!(tmp & 0x01))
-		w83627hf_write_value(data, W83781D_REG_VBAT, tmp | 0x01);
-}
-
-static void w83627hf_update_fan_div(struct w83627hf_data *data)
-{
-	int reg;
-
-	reg = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
-	data->fan_div[0] = (reg >> 4) & 0x03;
-	data->fan_div[1] = (reg >> 6) & 0x03;
-	if (data->type != w83697hf) {
-		data->fan_div[2] = (w83627hf_read_value(data,
-				       W83781D_REG_PIN) >> 6) & 0x03;
-	}
-	reg = w83627hf_read_value(data, W83781D_REG_VBAT);
-	data->fan_div[0] |= (reg >> 3) & 0x04;
-	data->fan_div[1] |= (reg >> 4) & 0x04;
-	if (data->type != w83697hf)
-		data->fan_div[2] |= (reg >> 5) & 0x04;
-}
-
-static struct w83627hf_data *w83627hf_update_device(struct device *dev)
-{
-	struct w83627hf_data *data = dev_get_drvdata(dev);
-	int i, num_temps = (data->type = w83697hf) ? 2 : 3;
-	int num_pwms = (data->type = w83697hf) ? 2 : 3;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		for (i = 0; i <= 8; i++) {
-			/* skip missing sensors */
-			if (((data->type = w83697hf) && (i = 1)) ||
-			    ((data->type != w83627hf && data->type != w83697hf)
-			    && (i = 5 || i = 6)))
-				continue;
-			data->in[i] -			    w83627hf_read_value(data, W83781D_REG_IN(i));
-			data->in_min[i] -			    w83627hf_read_value(data,
-					       W83781D_REG_IN_MIN(i));
-			data->in_max[i] -			    w83627hf_read_value(data,
-					       W83781D_REG_IN_MAX(i));
-		}
-		for (i = 0; i <= 2; i++) {
-			data->fan[i] -			    w83627hf_read_value(data, W83627HF_REG_FAN(i));
-			data->fan_min[i] -			    w83627hf_read_value(data,
-					       W83627HF_REG_FAN_MIN(i));
-		}
-		for (i = 0; i <= 2; i++) {
-			u8 tmp = w83627hf_read_value(data,
-				W836X7HF_REG_PWM(data->type, i));
-			/* bits 0-3 are reserved  in 627THF */
-			if (data->type = w83627thf)
-				tmp &= 0xf0;
-			data->pwm[i] = tmp;
-			if (i = 1 &&
-			    (data->type = w83627hf || data->type = w83697hf))
-				break;
-		}
-		if (data->type = w83627hf) {
-				u8 tmp = w83627hf_read_value(data,
-						W83627HF_REG_PWM_FREQ);
-				data->pwm_freq[0] = tmp & 0x07;
-				data->pwm_freq[1] = (tmp >> 4) & 0x07;
-		} else if (data->type != w83627thf) {
-			for (i = 1; i <= 3; i++) {
-				data->pwm_freq[i - 1] -					w83627hf_read_value(data,
-						W83637HF_REG_PWM_FREQ[i - 1]);
-				if (i = 2 && (data->type = w83697hf))
-					break;
-			}
-		}
-		if (data->type != w83627hf) {
-			for (i = 0; i < num_pwms; i++) {
-				u8 tmp = w83627hf_read_value(data,
-					W83627THF_REG_PWM_ENABLE[i]);
-				data->pwm_enable[i] -					((tmp >> W83627THF_PWM_ENABLE_SHIFT[i])
-					& 0x03) + 1;
-			}
-		}
-		for (i = 0; i < num_temps; i++) {
-			data->temp[i] -			  w83627hf_read_value(data, w83627hf_reg_temp[i]);
-			data->temp_max[i] -			  w83627hf_read_value(data, w83627hf_reg_temp_over[i]);
-			data->temp_max_hyst[i] -			  w83627hf_read_value(data, w83627hf_reg_temp_hyst[i]);
-		}
-
-		w83627hf_update_fan_div(data);
-
-		data->alarms -		    w83627hf_read_value(data, W83781D_REG_ALARM1) |
-		    (w83627hf_read_value(data, W83781D_REG_ALARM2) << 8) |
-		    (w83627hf_read_value(data, W83781D_REG_ALARM3) << 16);
-		i = w83627hf_read_value(data, W83781D_REG_BEEP_INTS2);
-		data->beep_mask = (i << 8) |
-		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS1) |
-		    w83627hf_read_value(data, W83781D_REG_BEEP_INTS3) << 16;
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
+static const struct dev_pm_ops w83627hf_dev_pm_ops = {
+	.suspend = w83627hf_suspend,
+	.resume = w83627hf_resume,
+};
 
-	mutex_unlock(&data->update_lock);
+#define W83627HF_DEV_PM_OPS	(&w83627hf_dev_pm_ops)
+#else
+#define W83627HF_DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
 
-	return data;
-}
+static struct platform_driver w83627hf_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DRVNAME,
+		.pm	= W83627HF_DEV_PM_OPS,
+	},
+	.probe		= w83627hf_probe,
+	.remove		= w83627hf_remove,
+};
 
 static int __init w83627hf_device_add(unsigned short address,
 				      const struct w83627hf_sio_data *sio_data)
@@ -1974,6 +1899,70 @@ exit:
 	return err;
 }
 
+static int __init w83627hf_find(int sioaddr, unsigned short *addr,
+				struct w83627hf_sio_data *sio_data)
+{
+	int err = -ENODEV;
+	u16 val;
+
+	static __initconst char *const names[] = {
+		"W83627HF",
+		"W83627THF",
+		"W83697HF",
+		"W83637HF",
+		"W83687THF",
+	};
+
+	sio_data->sioaddr = sioaddr;
+	superio_enter(sio_data);
+	val = force_id ? force_id : superio_inb(sio_data, DEVID);
+	switch (val) {
+	case W627_DEVID:
+		sio_data->type = w83627hf;
+		break;
+	case W627THF_DEVID:
+		sio_data->type = w83627thf;
+		break;
+	case W697_DEVID:
+		sio_data->type = w83697hf;
+		break;
+	case W637_DEVID:
+		sio_data->type = w83637hf;
+		break;
+	case W687THF_DEVID:
+		sio_data->type = w83687thf;
+		break;
+	case 0xff:	/* No device at all */
+		goto exit;
+	default:
+		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
+		goto exit;
+	}
+
+	superio_select(sio_data, W83627HF_LD_HWM);
+	val = (superio_inb(sio_data, WINB_BASE_REG) << 8) |
+	       superio_inb(sio_data, WINB_BASE_REG + 1);
+	*addr = val & WINB_ALIGNMENT;
+	if (*addr = 0) {
+		pr_warn("Base address not set, skipping\n");
+		goto exit;
+	}
+
+	val = superio_inb(sio_data, WINB_ACT_REG);
+	if (!(val & 0x01)) {
+		pr_warn("Enabling HWM logical device\n");
+		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
+	}
+
+	err = 0;
+	pr_info(DRVNAME ": Found %s chip at %#x\n",
+		names[sio_data->type], *addr);
+
+ exit:
+	superio_exit(sio_data);
+	return err;
+}
+
 static int __init sensors_w83627hf_init(void)
 {
 	int err;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
