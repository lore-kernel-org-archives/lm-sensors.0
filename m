From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:28 +0000
Subject: [lm-sensors] [PATCH 26/39] hwmon: (sis5595): Fix checkpatch issues
Message-Id: <1326703781-14272-27-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: space prohibited after that open parenthesis '('
ERROR: space prohibited before that close parenthesis ')'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: trailing statements should be on next line
ERROR: trailing whitespace
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sis5595.c |  140 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 96 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 47d7ce9..fa0e04e 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -26,7 +26,7 @@
 /*
    SiS southbridge has a LM78-like chip integrated on the same IC.
    This driver is a customized copy of lm78.c
-   
+
    Supports following revisions:
 	Version		PCI ID		PCI Revision
 	1		1039/0008	AF or less
@@ -36,7 +36,7 @@
 	 5595. We recognize these by the presence of the listed
 	 "blacklist" PCI ID and refuse to load.
 
-   NOT SUPPORTED	PCI ID		BLACKLIST PCI ID	
+   NOT SUPPORTED	PCI ID		BLACKLIST PCI ID
 	 540		0008		0540
 	 550		0008		0550
 	5513		0008		5511
@@ -105,11 +105,11 @@ static struct platform_device *pdev;
    OVER and HYST are really MAX and MIN. */
 
 #define REV2MIN	0xb0
-#define SIS5595_REG_TEMP 	(( data->revision) >= REV2MIN) ? \
+#define SIS5595_REG_TEMP	((data->revision) >= REV2MIN) ? \
 					SIS5595_REG_IN(4) : 0x27
-#define SIS5595_REG_TEMP_OVER	(( data->revision) >= REV2MIN) ? \
+#define SIS5595_REG_TEMP_OVER	((data->revision) >= REV2MIN) ? \
 					SIS5595_REG_IN_MAX(4) : 0x39
-#define SIS5595_REG_TEMP_HYST	(( data->revision) >= REV2MIN) ? \
+#define SIS5595_REG_TEMP_HYST	((data->revision) >= REV2MIN) ? \
 					SIS5595_REG_IN_MIN(4) : 0x3a
 
 #define SIS5595_REG_CONFIG 0x40
@@ -138,7 +138,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 
 static inline int FAN_FROM_REG(u8 val, int div)
 {
-	return val=0 ? -1 : val=255 ? 0 : 1350000/(val*div);
+	return val = 0 ? -1 : val = 255 ? 0 : 1350000 / (val * div);
 }
 
 /* TEMP: mC (-54.12C to +157.53C)
@@ -150,14 +150,14 @@ static inline int TEMP_FROM_REG(s8 val)
 static inline s8 TEMP_TO_REG(int val)
 {
 	int nval = SENSORS_LIMIT(val, -54120, 157530) ;
-	return nval<0 ? (nval-5212-415)/830 : (nval-5212+415)/830;
+	return nval < 0 ? (nval - 5212 - 415) / 830 : (nval - 5212 + 415) / 830;
 }
 
 /* FAN DIV: 1, 2, 4, or 8 (defaults to 2)
    REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
 static inline u8 DIV_TO_REG(int val)
 {
-	return val=8 ? 3 : val=4 ? 2 : val=1 ? 0 : 1;
+	return val = 8 ? 3 : val = 4 ? 2 : val = 1 ? 0 : 1;
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
@@ -240,7 +240,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -255,7 +260,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -279,22 +289,30 @@ show_in_offset(3);
 show_in_offset(4);
 
 /* Temperature */
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_over = TEMP_TO_REG(val);
@@ -303,16 +321,23 @@ static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *attr,
+			      char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
-static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_hyst = TEMP_TO_REG(val);
@@ -335,7 +360,7 @@ static ssize_t show_fan(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
@@ -344,8 +369,8 @@ static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
 	struct sis5595_data *data = sis5595_update_device(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
-		DIV_FROM_REG(data->fan_div[nr])) );
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+		DIV_FROM_REG(data->fan_div[nr])));
 }
 
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
@@ -354,7 +379,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -369,7 +399,7 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
 	struct sis5595_data *data = sis5595_update_device(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
@@ -383,8 +413,13 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	int nr = attr->index;
 	unsigned long min;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
@@ -392,17 +427,25 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 	reg = sis5595_read_value(data, SIS5595_REG_FANDIV);
 
 	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1:
+		data->fan_div[nr] = 0;
+		break;
+	case 2:
+		data->fan_div[nr] = 1;
+		break;
+	case 4:
+		data->fan_div[nr] = 2;
+		break;
+	case 8:
+		data->fan_div[nr] = 3;
+		break;
 	default:
 		dev_err(dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
-	
+
 	switch (nr) {
 	case 0:
 		reg = (reg & 0xcf) | (data->fan_div[nr] << 4);
@@ -431,7 +474,8 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -521,7 +565,7 @@ static struct attribute *sis5595_attributes_temp1[] = {
 static const struct attribute_group sis5595_group_temp1 = {
 	.attrs = sis5595_attributes_temp1,
 };
- 
+
 /* This is called when the module is loaded */
 static int __devinit sis5595_probe(struct platform_device *pdev)
 {
@@ -539,7 +583,8 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	if (!(data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
@@ -550,7 +595,9 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 	data->name = "sis5595";
 	platform_set_drvdata(pdev, data);
 
-	/* Check revision and pin registers to determine whether 4 or 5 voltages */
+	/*
+	 * Check revision and pin registers to determine whether 4 or 5 voltages
+	 */
 	data->revision = s_bridge->revision;
 	/* 4 voltages, 1 temp */
 	data->maxins = 3;
@@ -560,7 +607,7 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 			/* 5 voltages, no temps */
 			data->maxins = 4;
 	}
-	
+
 	/* Initialize the SIS5595 chip */
 	sis5595_init_device(data);
 
@@ -571,15 +618,16 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group)))
+	err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group);
+	if (err)
 		goto exit_free;
 	if (data->maxins = 4) {
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &sis5595_group_in4)))
+		err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group_in4);
+		if (err)
 			goto exit_remove_files;
 	} else {
-		if ((err = sysfs_create_group(&pdev->dev.kobj,
-					      &sis5595_group_temp1)))
+		err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group_temp1);
+		if (err)
 			goto exit_remove_files;
 	}
 
@@ -699,7 +747,7 @@ static struct sis5595_data *sis5595_update_device(struct device *dev)
 	return data;
 }
 
-static const struct pci_device_id sis5595_pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(sis5595_pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ 0, }
 };
@@ -770,13 +818,16 @@ static int __devinit sis5595_pci_probe(struct pci_dev *dev,
 
 	for (i = blacklist; *i != 0; i++) {
 		struct pci_dev *d;
-		if ((d = pci_get_device(PCI_VENDOR_ID_SI, *i, NULL))) {
-			dev_err(&d->dev, "Looked for SIS5595 but found unsupported device %.4x\n", *i);
+		d = pci_get_device(PCI_VENDOR_ID_SI, *i, NULL);
+		if (d) {
+			dev_err(&d->dev,
+				"Looked for SIS5595 but found unsupported device %.4x\n",
+				*i);
 			pci_dev_put(d);
 			return -ENODEV;
 		}
 	}
-	
+
 	force_addr &= ~(SIS5595_EXTENT - 1);
 	if (force_addr) {
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n", force_addr);
@@ -788,10 +839,11 @@ static int __devinit sis5595_pci_probe(struct pci_dev *dev,
 		dev_err(&dev->dev, "Failed to read ISA address\n");
 		return -ENODEV;
 	}
-	
+
 	address &= ~(SIS5595_EXTENT - 1);
 	if (!address) {
-		dev_err(&dev->dev, "Base address not set - upgrade BIOS or use force_addr=0xaddr\n");
+		dev_err(&dev->dev,
+			"Base address not set - upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 	if (force_addr && address != force_addr) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
