From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Wed, 13 Jun 2007 18:27:36 +0000
Subject: [lm-sensors] [PATCH] hwmon it87 to platform driver
Message-Id: <46703718.8060803@geomatys.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080800060300030400050304"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800060300030400050304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello

This is the patch for converting it87 to a platform driver (and remove i2c-isa).

Signed-off-by: Corentin LABBE <corentin.labbe@geomatys.fr>

--------------080800060300030400050304
Content-Type: text/x-patch;
 name="hwmon-it87-to-platform-driver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-it87-to-platform-driver.patch"

--- linux-2.6.22-rc4.orig/drivers/hwmon/Kconfig	2007-06-13 11:54:47.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/Kconfig	2007-06-13 13:16:08.000000000 +0200
@@ -250,8 +250,6 @@ config SENSORS_CORETEMP
 
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
-	depends on I2C
-	select I2C_ISA
 	select HWMON_VID
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
--- linux-2.6.22-rc4.orig/drivers/hwmon/it87.c	2007-06-13 11:54:47.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/it87.c	2007-06-13 13:32:49.000000000 +0200
@@ -31,8 +31,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/i2c-isa.h>
+#include <linux/platform_device.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
@@ -41,10 +40,12 @@
 #include <linux/sysfs.h>
 #include <asm/io.h>
 
+#define DRVNAME "it87"
 
-static unsigned short isa_address;
 enum chips { it87, it8712, it8716, it8718 };
 
+static struct platform_device *pdev;
+
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
 #define	VAL	0x2f	/* The value to read/write */
@@ -112,10 +113,6 @@ static int update_vbat;
 /* Not all BIOSes properly configure the PWM registers */
 static int fix_pwm_polarity;
 
-/* Values read from Super-I/O config space */
-static u16 chip_type;
-static u8 vid_value;
-
 /* Many IT87 constants specified below */
 
 /* Length of ISA address segment */
@@ -216,13 +213,20 @@ static const unsigned int pwm_freq[8] = 
 };
 
 
+struct it87_sio_data {
+	enum chips type;
+	/* Values read from Super-I/O config space */
+	u8 vid_value;
+};
+
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct it87_data {
-	struct i2c_client client;
 	struct class_device *class_dev;
 	enum chips type;
 
+	unsigned short addr;
+	const char *name;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -247,26 +251,25 @@ struct it87_data {
 };
 
 
-static int it87_detect(struct i2c_adapter *adapter);
-static int it87_detach_client(struct i2c_client *client);
+static int it87_probe(struct platform_device *pdev);
+static int it87_remove(struct platform_device *pdev);
 
-static int it87_read_value(struct i2c_client *client, u8 reg);
-static void it87_write_value(struct i2c_client *client, u8 reg, u8 value);
+static int it87_read_value(struct it87_data *data, u8 reg);
+static void it87_write_value(struct it87_data *data, u8 reg, u8 value);
 static struct it87_data *it87_update_device(struct device *dev);
-static int it87_check_pwm(struct i2c_client *client);
-static void it87_init_client(struct i2c_client *client, struct it87_data *data);
+static int it87_check_pwm(struct device *dev);
+static void it87_init_device(struct platform_device *pdev);
 
 
-static struct i2c_driver it87_isa_driver = {
+static struct platform_driver it87_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= "it87-isa",
+		.name	= DRVNAME,
 	},
-	.attach_adapter	= it87_detect,
-	.detach_client	= it87_detach_client,
+	.probe	= it87_probe,
+	.remove	= __devexit_p(it87_remove),
 };
 
-
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -303,13 +306,12 @@ static ssize_t set_in_min(struct device 
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
-	it87_write_value(client, IT87_REG_VIN_MIN(nr), 
+	it87_write_value(data, IT87_REG_VIN_MIN(nr),
 			data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -320,13 +322,12 @@ static ssize_t set_in_max(struct device 
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
-	it87_write_value(client, IT87_REG_VIN_MAX(nr), 
+	it87_write_value(data, IT87_REG_VIN_MAX(nr),
 			data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -394,13 +395,12 @@ static ssize_t set_temp_max(struct devic
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = TEMP_TO_REG(val);
-	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	it87_write_value(data, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -410,13 +410,12 @@ static ssize_t set_temp_min(struct devic
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->temp_low[nr] = TEMP_TO_REG(val);
-	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	it87_write_value(data, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -453,8 +452,7 @@ static ssize_t set_sensor(struct device 
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -470,7 +468,7 @@ static ssize_t set_sensor(struct device 
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
 	}
-	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	it87_write_value(data, IT87_REG_TEMP_ENABLE, data->sensor);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -544,13 +542,12 @@ static ssize_t set_fan_min(struct device
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 	u8 reg;
 
 	mutex_lock(&data->update_lock);
-	reg = it87_read_value(client, IT87_REG_FAN_DIV);
+	reg = it87_read_value(data, IT87_REG_FAN_DIV);
 	switch (nr) {
 	case 0: data->fan_div[nr] = reg & 0x07; break;
 	case 1: data->fan_div[nr] = (reg >> 3) & 0x07; break;
@@ -558,7 +555,7 @@ static ssize_t set_fan_min(struct device
 	}
 
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	it87_write_value(data, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -568,14 +565,13 @@ static ssize_t set_fan_div(struct device
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int min;
 	u8 old;
 
 	mutex_lock(&data->update_lock);
-	old = it87_read_value(client, IT87_REG_FAN_DIV);
+	old = it87_read_value(data, IT87_REG_FAN_DIV);
 
 	/* Save fan min limit */
 	min = FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr]));
@@ -596,11 +592,11 @@ static ssize_t set_fan_div(struct device
 	val |= (data->fan_div[1] & 0x07) << 3;
 	if (data->fan_div[2] == 3)
 		val |= 0x1 << 6;
-	it87_write_value(client, IT87_REG_FAN_DIV, val);
+	it87_write_value(data, IT87_REG_FAN_DIV, val);
 
 	/* Restore fan min limit */
 	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
-	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	it87_write_value(data, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -611,8 +607,7 @@ static ssize_t set_pwm_enable(struct dev
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -620,17 +615,17 @@ static ssize_t set_pwm_enable(struct dev
 	if (val == 0) {
 		int tmp;
 		/* make sure the fan is on when in on/off mode */
-		tmp = it87_read_value(client, IT87_REG_FAN_CTL);
-		it87_write_value(client, IT87_REG_FAN_CTL, tmp | (1 << nr));
+		tmp = it87_read_value(data, IT87_REG_FAN_CTL);
+		it87_write_value(data, IT87_REG_FAN_CTL, tmp | (1 << nr));
 		/* set on/off mode */
 		data->fan_main_ctrl &= ~(1 << nr);
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	} else if (val == 1) {
 		/* set SmartGuardian mode */
 		data->fan_main_ctrl |= (1 << nr);
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
 	} else {
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -645,8 +640,7 @@ static ssize_t set_pwm(struct device *de
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	if (val < 0 || val > 255)
@@ -655,15 +649,14 @@ static ssize_t set_pwm(struct device *de
 	mutex_lock(&data->update_lock);
 	data->manual_pwm_ctl[nr] = val;
 	if (data->fan_main_ctrl & (1 << nr))
-		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm_freq(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int i;
 
@@ -674,9 +667,9 @@ static ssize_t set_pwm_freq(struct devic
 	}
 
 	mutex_lock(&data->update_lock);
-	data->fan_ctl = it87_read_value(client, IT87_REG_FAN_CTL) & 0x8f;
+	data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL) & 0x8f;
 	data->fan_ctl |= i << 4;
-	it87_write_value(client, IT87_REG_FAN_CTL, data->fan_ctl);
+	it87_write_value(data, IT87_REG_FAN_CTL, data->fan_ctl);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -731,15 +724,14 @@ static ssize_t set_fan16_min(struct devi
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN16_TO_REG(val);
-	it87_write_value(client, IT87_REG_FAN_MIN(nr),
+	it87_write_value(data, IT87_REG_FAN_MIN(nr),
 			 data->fan_min[nr] & 0xff);
-	it87_write_value(client, IT87_REG_FANX_MIN(nr),
+	it87_write_value(data, IT87_REG_FANX_MIN(nr),
 			 data->fan_min[nr] >> 8);
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -777,8 +769,7 @@ show_vrm_reg(struct device *dev, struct 
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	u32 val;
 
 	val = simple_strtoul(buf, NULL, 10);
@@ -796,6 +787,14 @@ show_vid_reg(struct device *dev, struct 
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
+static ssize_t show_name(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
+{
+	struct it87_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", data->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *it87_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -837,6 +836,7 @@ static struct attribute *it87_attributes
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
+	&dev_attr_name.attr,
 	NULL
 };
 
@@ -879,18 +879,36 @@ static const struct attribute_group it87
 };
 
 /* SuperIO detection - will change isa_address if a chip is found */
-static int __init it87_find(unsigned short *address)
+static int __init it87_find(unsigned short *address,
+	struct it87_sio_data *sio_data)
 {
 	int err = -ENODEV;
+	u16 chip_type;
 
 	superio_enter();
 	chip_type = superio_inw(DEVID);
-	if (chip_type != IT8712F_DEVID
-	 && chip_type != IT8716F_DEVID
-	 && chip_type != IT8726F_DEVID
-	 && chip_type != IT8718F_DEVID
-	 && chip_type != IT8705F_DEVID)
-	 	goto exit;
+
+	switch (chip_type) {
+	case IT8705F_DEVID:
+		sio_data->type = it87;
+		break;
+	case IT8712F_DEVID:
+		sio_data->type = it8712;
+		break;
+	case IT8716F_DEVID:
+	case IT8726F_DEVID:
+		sio_data->type = it8716;
+		break;
+	case IT8718F_DEVID:
+		sio_data->type = it8718;
+		break;
+	case 0xffff:	/* No device at all */
+		goto exit;
+	default:
+		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%x)\n",
+			 chip_type);
+		goto exit;
+	}
 
 	superio_select(PME);
 	if (!(superio_inb(IT87_ACT_REG) & 0x01)) {
@@ -914,7 +932,7 @@ static int __init it87_find(unsigned sho
 
 		superio_select(GPIO);
 		if (chip_type == it8718)
-			vid_value = superio_inb(IT87_SIO_VID_REG);
+			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
 
 		reg = superio_inb(IT87_SIO_PINX2_REG);
 		if (reg & (1 << 0))
@@ -928,18 +946,26 @@ exit:
 	return err;
 }
 
-/* This function is called by i2c_probe */
-static int it87_detect(struct i2c_adapter *adapter)
+static int __devinit it87_probe(struct platform_device *pdev)
 {
-	struct i2c_client *new_client;
 	struct it87_data *data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct it87_sio_data *sio_data = dev->platform_data;
 	int err = 0;
-	const char *name;
 	int enable_pwm_interface;
-
-	/* Reserve the ISA region */
-	if (!request_region(isa_address, IT87_EXTENT,
-			    it87_isa_driver.driver.name)){
+	static const char *names[] = {
+		"it87",
+		"it8712",
+		"it8716",
+		"it8718",
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, IT87_EXTENT, DRVNAME)) {
+		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
+			(unsigned long)res->start,
+			(unsigned long)(res->start + IT87_EXTENT - 1));
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -949,131 +975,104 @@ static int it87_detect(struct i2c_adapte
 		goto ERROR1;
 	}
 
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = isa_address;
-	new_client->adapter = adapter;
-	new_client->driver = &it87_isa_driver;
+	data->addr = res->start;
+	data->type = sio_data->type;
+	data->name = names[sio_data->type];
 
 	/* Now, we do the remaining detection. */
-	if ((it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
-	 || it87_read_value(new_client, IT87_REG_CHIPID) != 0x90) {
+	if ((it87_read_value(data, IT87_REG_CONFIG) & 0x80)
+	 || it87_read_value(data, IT87_REG_CHIPID) != 0x90) {
 		err = -ENODEV;
 		goto ERROR2;
 	}
 
-	/* Determine the chip type. */
-	switch (chip_type) {
-	case IT8712F_DEVID:
-		data->type = it8712;
-		name = "it8712";
-		break;
-	case IT8726F_DEVID:
-	/* fall through */
-	case IT8716F_DEVID:
-		data->type = it8716;
-		name = "it8716";
-		break;
-	case IT8718F_DEVID:
-		data->type = it8718;
-		name = "it8718";
-		break;
-	default:
-		data->type = it87;
-		name = "it87";
-	}
+	platform_set_drvdata(pdev, data);
 
-	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	mutex_init(&data->update_lock);
 
-	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
-		goto ERROR2;
-
 	/* Check PWM configuration */
-	enable_pwm_interface = it87_check_pwm(new_client);
+	enable_pwm_interface = it87_check_pwm(dev);
 
 	/* Initialize the IT87 chip */
-	it87_init_client(new_client, data);
+	it87_init_device(pdev);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &it87_group)))
-		goto ERROR3;
+	if ((err = sysfs_create_group(&dev->kobj, &it87_group)))
+		goto ERROR2;
 
 	/* Do not create fan files for disabled fans */
 	if (data->type == it8716 || data->type == it8718) {
 		/* 16-bit tachometers */
 		if (data->has_fan & (1 << 0)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan1_input16.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan1_min16.dev_attr)))
 				goto ERROR4;
 		}
 		if (data->has_fan & (1 << 1)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan2_input16.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan2_min16.dev_attr)))
 				goto ERROR4;
 		}
 		if (data->has_fan & (1 << 2)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan3_input16.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan3_min16.dev_attr)))
 				goto ERROR4;
 		}
 	} else {
 		/* 8-bit tachometers with clock divider */
 		if (data->has_fan & (1 << 0)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan1_input.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan1_min.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan1_div.dev_attr)))
 				goto ERROR4;
 		}
 		if (data->has_fan & (1 << 1)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan2_input.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan2_min.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan2_div.dev_attr)))
 				goto ERROR4;
 		}
 		if (data->has_fan & (1 << 2)) {
-			if ((err = device_create_file(&new_client->dev,
+			if ((err = device_create_file(dev,
 			     &sensor_dev_attr_fan3_input.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan3_min.dev_attr))
-			 || (err = device_create_file(&new_client->dev,
+			 || (err = device_create_file(dev,
 			     &sensor_dev_attr_fan3_div.dev_attr)))
 				goto ERROR4;
 		}
 	}
 
 	if (enable_pwm_interface) {
-		if ((err = device_create_file(&new_client->dev,
+		if ((err = device_create_file(dev,
 		     &sensor_dev_attr_pwm1_enable.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &sensor_dev_attr_pwm2_enable.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &sensor_dev_attr_pwm3_enable.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &sensor_dev_attr_pwm1.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &sensor_dev_attr_pwm2.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &sensor_dev_attr_pwm3.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &dev_attr_pwm1_freq))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &dev_attr_pwm2_freq))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &dev_attr_pwm3_freq)))
 			goto ERROR4;
 	}
@@ -1082,15 +1081,15 @@ static int it87_detect(struct i2c_adapte
 	 || data->type == it8718) {
 		data->vrm = vid_which_vrm();
 		/* VID reading from Super-I/O config space if available */
-		data->vid = vid_value;
-		if ((err = device_create_file(&new_client->dev,
+		data->vid = sio_data->vid_value;
+		if ((err = device_create_file(dev,
 		     &dev_attr_vrm))
-		 || (err = device_create_file(&new_client->dev,
+		 || (err = device_create_file(dev,
 		     &dev_attr_cpu0_vid)))
 			goto ERROR4;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
+	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
 		goto ERROR4;
@@ -1099,31 +1098,27 @@ static int it87_detect(struct i2c_adapte
 	return 0;
 
 ERROR4:
-	sysfs_remove_group(&new_client->dev.kobj, &it87_group);
-	sysfs_remove_group(&new_client->dev.kobj, &it87_group_opt);
-ERROR3:
-	i2c_detach_client(new_client);
+	sysfs_remove_group(&dev->kobj, &it87_group);
+	sysfs_remove_group(&dev->kobj, &it87_group_opt);
 ERROR2:
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 ERROR1:
-	release_region(isa_address, IT87_EXTENT);
+	release_region(res->start, IT87_EXTENT);
 ERROR0:
 	return err;
 }
 
-static int it87_detach_client(struct i2c_client *client)
+static int __devexit it87_remove(struct platform_device *pdev)
 {
-	struct it87_data *data = i2c_get_clientdata(client);
-	int err;
+	struct it87_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->class_dev);
-	sysfs_remove_group(&client->dev.kobj, &it87_group);
-	sysfs_remove_group(&client->dev.kobj, &it87_group_opt);
-
-	if ((err = i2c_detach_client(client)))
-		return err;
+	sysfs_remove_group(&pdev->dev.kobj, &it87_group);
+	sysfs_remove_group(&pdev->dev.kobj, &it87_group_opt);
 
-	release_region(client->addr, IT87_EXTENT);
+	release_region(data->addr, IT87_EXTENT);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	return 0;
@@ -1132,28 +1127,29 @@ static int it87_detach_client(struct i2c
 /* Must be called with data->update_lock held, except during initialization.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
    would slow down the IT87 access and should not be necessary. */
-static int it87_read_value(struct i2c_client *client, u8 reg)
+static int it87_read_value(struct it87_data *data, u8 reg)
 {
-	outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
-	return inb_p(client->addr + IT87_DATA_REG_OFFSET);
+	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
+	return inb_p(data->addr + IT87_DATA_REG_OFFSET);
 }
 
 /* Must be called with data->update_lock held, except during initialization.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
    would slow down the IT87 access and should not be necessary. */
-static void it87_write_value(struct i2c_client *client, u8 reg, u8 value)
+static void it87_write_value(struct it87_data *data, u8 reg, u8 value)
 {
-	outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
-	outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
+	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
+	outb_p(value, data->addr + IT87_DATA_REG_OFFSET);
 }
 
 /* Return 1 if and only if the PWM interface is safe to use */
-static int it87_check_pwm(struct i2c_client *client)
+static int __devinit it87_check_pwm(struct device *dev)
 {
+	struct it87_data *data = dev_get_drvdata(dev);
 	/* Some BIOSes fail to correctly configure the IT87 fans. All fans off
 	 * and polarity set to active low is sign that this is the case so we
 	 * disable pwm control to protect the user. */
-	int tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+	int tmp = it87_read_value(data, IT87_REG_FAN_CTL);
 	if ((tmp & 0x87) == 0) {
 		if (fix_pwm_polarity) {
 			/* The user asks us to attempt a chip reconfiguration.
@@ -1163,7 +1159,7 @@ static int it87_check_pwm(struct i2c_cli
 			u8 pwm[3];
 
 			for (i = 0; i < 3; i++)
-				pwm[i] = it87_read_value(client,
+				pwm[i] = it87_read_value(data,
 							 IT87_REG_PWM(i));
 
 			/* If any fan is in automatic pwm mode, the polarity
@@ -1171,26 +1167,26 @@ static int it87_check_pwm(struct i2c_cli
 			 * better don't change anything (but still disable the
 			 * PWM interface). */
 			if (!((pwm[0] | pwm[1] | pwm[2]) & 0x80)) {
-				dev_info(&client->dev, "Reconfiguring PWM to "
+				dev_info(dev, "Reconfiguring PWM to "
 					 "active high polarity\n");
-				it87_write_value(client, IT87_REG_FAN_CTL,
+				it87_write_value(data, IT87_REG_FAN_CTL,
 						 tmp | 0x87);
 				for (i = 0; i < 3; i++)
-					it87_write_value(client,
+					it87_write_value(data,
 							 IT87_REG_PWM(i),
 							 0x7f & ~pwm[i]);
 				return 1;
 			}
 
-			dev_info(&client->dev, "PWM configuration is "
+			dev_info(dev, "PWM configuration is "
 				 "too broken to be fixed\n");
 		}
 
-		dev_info(&client->dev, "Detected broken BIOS "
+		dev_info(dev, "Detected broken BIOS "
 			 "defaults, disabling PWM interface\n");
 		return 0;
 	} else if (fix_pwm_polarity) {
-		dev_info(&client->dev, "PWM configuration looks "
+		dev_info(dev, "PWM configuration looks "
 			 "sane, won't touch\n");
 	}
 
@@ -1198,8 +1194,9 @@ static int it87_check_pwm(struct i2c_cli
 }
 
 /* Called when we have found a new IT87. */
-static void it87_init_client(struct i2c_client *client, struct it87_data *data)
+static void __devinit it87_init_device(struct platform_device *pdev)
 {
+	struct it87_data *data = platform_get_drvdata(pdev);
 	int tmp, i;
 
 	/* initialize to sane defaults:
@@ -1219,48 +1216,48 @@ static void it87_init_client(struct i2c_
 	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
 	 * but is still confusing, so change to 127 degrees C. */
 	for (i = 0; i < 8; i++) {
-		tmp = it87_read_value(client, IT87_REG_VIN_MIN(i));
+		tmp = it87_read_value(data, IT87_REG_VIN_MIN(i));
 		if (tmp == 0xff)
-			it87_write_value(client, IT87_REG_VIN_MIN(i), 0);
+			it87_write_value(data, IT87_REG_VIN_MIN(i), 0);
 	}
 	for (i = 0; i < 3; i++) {
-		tmp = it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+		tmp = it87_read_value(data, IT87_REG_TEMP_HIGH(i));
 		if (tmp == 0xff)
-			it87_write_value(client, IT87_REG_TEMP_HIGH(i), 127);
+			it87_write_value(data, IT87_REG_TEMP_HIGH(i), 127);
 	}
 
 	/* Check if temperature channnels are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+	tmp = it87_read_value(data, IT87_REG_TEMP_ENABLE);
 	if ((tmp & 0x3f) == 0) {
 		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
 		tmp = (tmp & 0xc0) | 0x2a;
-		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
+		it87_write_value(data, IT87_REG_TEMP_ENABLE, tmp);
 	}
 	data->sensor = tmp;
 
 	/* Check if voltage monitors are reset manually or by some reason */
-	tmp = it87_read_value(client, IT87_REG_VIN_ENABLE);
+	tmp = it87_read_value(data, IT87_REG_VIN_ENABLE);
 	if ((tmp & 0xff) == 0) {
 		/* Enable all voltage monitors */
-		it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+		it87_write_value(data, IT87_REG_VIN_ENABLE, 0xff);
 	}
 
 	/* Check if tachometers are reset manually or by some reason */
-	data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
+	data->fan_main_ctrl = it87_read_value(data, IT87_REG_FAN_MAIN_CTRL);
 	if ((data->fan_main_ctrl & 0x70) == 0) {
 		/* Enable all fan tachometers */
 		data->fan_main_ctrl |= 0x70;
-		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
 	/* Set tachometers to 16-bit mode if needed */
 	if (data->type == it8716 || data->type == it8718) {
-		tmp = it87_read_value(client, IT87_REG_FAN_16BIT);
+		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
-			dev_dbg(&client->dev,
+			dev_dbg(&pdev->dev,
 				"Setting fan1-3 to 16-bit mode\n");
-			it87_write_value(client, IT87_REG_FAN_16BIT,
+			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
 	}
@@ -1270,7 +1267,7 @@ static void it87_init_client(struct i2c_
 	for (i = 0; i < 3; i++) {
 		if (data->fan_main_ctrl & (1 << i)) {
 			/* pwm mode */
-			tmp = it87_read_value(client, IT87_REG_PWM(i));
+			tmp = it87_read_value(data, IT87_REG_PWM(i));
 			if (tmp & 0x80) {
 				/* automatic pwm - not yet implemented, but
 				 * leave the settings made by the BIOS alone
@@ -1284,15 +1281,14 @@ static void it87_init_client(struct i2c_
  	}
 
 	/* Start monitoring */
-	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
+	it87_write_value(data, IT87_REG_CONFIG,
+			 (it87_read_value(data, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
 static struct it87_data *it87_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct it87_data *data = i2c_get_clientdata(client);
+	struct it87_data *data = dev_get_drvdata(dev);
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -1303,20 +1299,20 @@ static struct it87_data *it87_update_dev
 		if (update_vbat) {
 			/* Cleared after each update, so reenable.  Value
 		 	  returned by this read will be previous value */	
-			it87_write_value(client, IT87_REG_CONFIG,
-			   it87_read_value(client, IT87_REG_CONFIG) | 0x40);
+			it87_write_value(data, IT87_REG_CONFIG,
+			   it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
 		for (i = 0; i <= 7; i++) {
 			data->in[i] =
-			    it87_read_value(client, IT87_REG_VIN(i));
+			    it87_read_value(data, IT87_REG_VIN(i));
 			data->in_min[i] =
-			    it87_read_value(client, IT87_REG_VIN_MIN(i));
+			    it87_read_value(data, IT87_REG_VIN_MIN(i));
 			data->in_max[i] =
-			    it87_read_value(client, IT87_REG_VIN_MAX(i));
+			    it87_read_value(data, IT87_REG_VIN_MAX(i));
 		}
 		/* in8 (battery) has no limit registers */
 		data->in[8] =
-		    it87_read_value(client, IT87_REG_VIN(8));
+		    it87_read_value(data, IT87_REG_VIN(8));
 
 		for (i = 0; i < 3; i++) {
 			/* Skip disabled fans */
@@ -1324,46 +1320,47 @@ static struct it87_data *it87_update_dev
 				continue;
 
 			data->fan_min[i] =
-			    it87_read_value(client, IT87_REG_FAN_MIN(i));
-			data->fan[i] = it87_read_value(client,
+			    it87_read_value(data, IT87_REG_FAN_MIN(i));
+			data->fan[i] = it87_read_value(data,
 				       IT87_REG_FAN(i));
 			/* Add high byte if in 16-bit mode */
 			if (data->type == it8716 || data->type == it8718) {
-				data->fan[i] |= it87_read_value(client,
+				data->fan[i] |= it87_read_value(data,
 						IT87_REG_FANX(i)) << 8;
-				data->fan_min[i] |= it87_read_value(client,
+				data->fan_min[i] |= it87_read_value(data,
 						IT87_REG_FANX_MIN(i)) << 8;
 			}
 		}
 		for (i = 0; i < 3; i++) {
 			data->temp[i] =
-			    it87_read_value(client, IT87_REG_TEMP(i));
+			    it87_read_value(data, IT87_REG_TEMP(i));
 			data->temp_high[i] =
-			    it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+			    it87_read_value(data, IT87_REG_TEMP_HIGH(i));
 			data->temp_low[i] =
-			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
+			    it87_read_value(data, IT87_REG_TEMP_LOW(i));
 		}
 
 		/* Newer chips don't have clock dividers */
 		if ((data->has_fan & 0x07) && data->type != it8716
 		 && data->type != it8718) {
-			i = it87_read_value(client, IT87_REG_FAN_DIV);
+			i = it87_read_value(data, IT87_REG_FAN_DIV);
 			data->fan_div[0] = i & 0x07;
 			data->fan_div[1] = (i >> 3) & 0x07;
 			data->fan_div[2] = (i & 0x40) ? 3 : 1;
 		}
 
 		data->alarms =
-			it87_read_value(client, IT87_REG_ALARM1) |
-			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
-			(it87_read_value(client, IT87_REG_ALARM3) << 16);
-		data->fan_main_ctrl = it87_read_value(client, IT87_REG_FAN_MAIN_CTRL);
-		data->fan_ctl = it87_read_value(client, IT87_REG_FAN_CTL);
+			it87_read_value(data, IT87_REG_ALARM1) |
+			(it87_read_value(data, IT87_REG_ALARM2) << 8) |
+			(it87_read_value(data, IT87_REG_ALARM3) << 16);
+		data->fan_main_ctrl = it87_read_value(data,
+				IT87_REG_FAN_MAIN_CTRL);
+		data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL);
 
-		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
 		/* The 8705 does not have VID capability */
 		if (data->type == it8712 || data->type == it8716) {
-			data->vid = it87_read_value(client, IT87_REG_VID);
+			data->vid = it87_read_value(data, IT87_REG_VID);
 			/* The older IT8712F revisions had only 5 VID pins,
 			   but we assume it is always safe to read 6 bits. */
 			data->vid &= 0x3f;
@@ -1377,18 +1374,79 @@ static struct it87_data *it87_update_dev
 	return data;
 }
 
+static int __init it87_device_add(unsigned short address,
+				  const struct it87_sio_data *sio_data)
+{
+	struct resource res = {
+		.start	= address ,
+		.end	= address + IT87_EXTENT - 1,
+		.name	= DRVNAME,
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	pdev = platform_device_alloc(DRVNAME, address);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device resource addition failed "
+		       "(%d)\n", err);
+		goto exit_device_put;
+	}
+
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct it87_sio_data));
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
+		       err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	return err;
+}
+
 static int __init sm_it87_init(void)
 {
-	int res;
+	int err;
+	unsigned short isa_address=0;
+	struct it87_sio_data sio_data;
+
+	err = it87_find(&isa_address, &sio_data);
+	if (err)
+		return err;
+	err = platform_driver_register(&it87_driver);
+	if (err)
+		return err;
 
-	if ((res = it87_find(&isa_address)))
-		return res;
-	return i2c_isa_add_driver(&it87_isa_driver);
+	err = it87_device_add(isa_address, &sio_data);
+	if (err){
+		platform_driver_unregister(&it87_driver);
+		return err;
+	}
+
+	return 0;
 }
 
 static void __exit sm_it87_exit(void)
 {
-	i2c_isa_del_driver(&it87_isa_driver);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&it87_driver);
 }
 
 

--------------080800060300030400050304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080800060300030400050304--
