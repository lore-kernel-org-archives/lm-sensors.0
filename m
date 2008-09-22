From: Rodolfo Giometti <giometti@enneenne.com>
Date: Mon, 22 Sep 2008 13:42:31 +0000
Subject: [lm-sensors] [PATCH 1/1] [i2c] support for MAX8821 led charge pump
Message-Id: <1222090951-20567-2-git-send-email-giometti@enneenne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rodolfo Giometti <giometti@linux.it>

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
---
 drivers/i2c/chips/Kconfig   |   12 +
 drivers/i2c/chips/Makefile  |    1 +
 drivers/i2c/chips/max8821.c |  707 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/max8821.h |   32 ++
 4 files changed, 752 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/max8821.c
 create mode 100644 include/linux/i2c/max8821.h

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index a95cb94..9c8b72d 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -152,6 +152,18 @@ config SENSORS_MAX6875
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.
 
+config SENSORS_MAX8821
+	tristate "Maxim MAX8821 Led charge pump, mono audio amp and dual LDO"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Maxim MAX8821
+	  white led charge pump with mono class D audio amp and dual LDO.
+
+	  This provides an interface to manage internal subsystems.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max8821.
+
 config SENSORS_TSL2550
 	tristate "Taos TSL2550 ambient light sensor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 39e3e69..f55e4d7 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_AT24)		+= at24.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
+obj-$(CONFIG_SENSORS_MAX8821)	+= max8821.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
diff --git a/drivers/i2c/chips/max8821.c b/drivers/i2c/chips/max8821.c
new file mode 100644
index 0000000..1225681
--- /dev/null
+++ b/drivers/i2c/chips/max8821.c
@@ -0,0 +1,707 @@
+/*
+ *  max8821.c - driver for white led charge pump with mono class D
+ *	        audio amp and dual LDO
+ *
+ *  Copyright (C) 2008 Rodolfo Giometti <giometti@linux.it>
+ *  Copyright (C) 2008 Eurotech S.p.A. <info@eurotech.it>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/leds.h>
+
+#include <linux/i2c/max8821.h>
+
+#define DRIVER_VERSION		"0.40.0"
+
+/*
+ * Defines
+ */
+
+#define LED1_CNTL		0x00
+#define LED2_CNTL		0x01
+#define LED3_CNTL		0x02
+#define LED4_CNTL		0x03
+#define LED5_CNTL		0x04
+#define LED6_CNTL		0x05
+#define    INT_MASK		   0x1f
+#define LED_EN			0x0a
+#define LDO1_CNTL		0x0b
+#define LDO2_CNTL		0x0c
+#define    LDO_EN		   (1 << 5)
+#define    VOLT_MASK		   0x0f
+#define AUDIO_CNTL		0x0d
+#define    CLK_MASK		   (3 << 5)
+#define    CLK_1100K		   (0 << 5)
+#define    CLK_1400K		   (1 << 5)
+#define    CLK_1250K		   (2 << 5)
+#define    AMP_EN		   (1 << 4)
+#define    GAIN_MASK		   0x0f
+#define    DB_TO_IDX(dB)	   ((((dB) + 3) / 3) & GAIN_MASK)
+#define    IDX_TO_DB(idx)	   ((((idx) & GAIN_MASK) * 3) - 3)
+
+static u8 led_en_lut[] = {
+	(1 << 7), (1 << 6), (1 << 5), (1 << 4), (1 << 2), (1 << 0),
+};
+static u8 led_dis_lut[] = {
+	(1 << 7), (1 << 6), (1 << 5), (1 << 4), (3 << 2), (3 << 0),
+};
+
+static int ldo_voltage_lut[][16] = {
+	{ 1200, 1300, 1500, 1600, 1800, 1900, 2000, 2300,
+	  2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200, },
+	{ 1500, 1600, 1800, 2000, 2200, 2300, 2400, 2500,
+	  2600, 2700, 2800, 2900, 3000, 3100, 3200, 3300, },
+};
+
+/*
+ * Structs
+ */
+
+struct max8821_data;
+struct max8821_led {
+	struct max8821_data *data;	/* back link */
+	struct led_classdev dev;
+	int new_level;
+	struct work_struct work;
+};
+
+struct max8821_data {
+	struct i2c_client *client;
+	struct mutex update_lock;
+
+	struct max8821_led led[6];
+};
+
+/*
+ * Management functions
+ */
+
+static int write_led_brightness(struct i2c_client *client, int id,
+				unsigned int brightness)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	u8 addr = LED1_CNTL + id;
+	int ret;
+
+	/* By design leds should operate in 0-255 range but we have 0-31 */
+	if (brightness > 255)
+		return -EINVAL;
+	brightness = brightness * INT_MASK / 255;
+
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		goto exit;
+
+	ret &= ~INT_MASK;
+	ret |= brightness;
+
+	ret = i2c_smbus_write_byte_data(client, addr, ret);
+	if (ret < 0)
+		goto exit;
+
+	ret = i2c_smbus_read_byte_data(client, LED_EN);
+	if (ret < 0)
+		goto exit;
+
+	if (brightness)
+		ret |= led_en_lut[id];
+	else
+		ret &= ~led_dis_lut[id];
+
+	ret = i2c_smbus_write_byte_data(client, LED_EN, ret);
+	if (ret < 0)
+		goto exit;
+
+	ret = 0;
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static int read_ldo_power(struct i2c_client *client, int id, char *buf)
+{
+	u8 addr = LDO1_CNTL + id;
+	int ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d", !!(ret & LDO_EN));
+}
+
+static int write_ldo_power(struct i2c_client *client, int id, int val)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	u8 addr = LDO1_CNTL + id;
+	int ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		goto exit;
+
+	if (val)
+		ret |= LDO_EN;
+	else
+		ret &= ~LDO_EN;
+
+	ret = i2c_smbus_write_byte_data(client, addr, ret);
+	if (ret < 0)
+		goto exit;
+
+	ret = 0;
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static int read_ldo_voltage(struct i2c_client *client, int id, char *buf)
+{
+	u8 addr = LDO1_CNTL + id;
+	int ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		return ret;
+
+	ret = ldo_voltage_lut[id][ret & VOLT_MASK];
+	return sprintf(buf, "%d", ret);
+}
+
+static int write_ldo_voltage(struct i2c_client *client, int id, int val)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	u8 addr = LDO1_CNTL + id;
+	int i, ret;
+
+	if (val < ldo_voltage_lut[id][0])
+		return -EINVAL;
+
+	for (i = 0; i < 16; i++)
+		if (val <= ldo_voltage_lut[id][i])
+			break;
+	if (i >= 16)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		goto exit;
+
+	ret &= ~VOLT_MASK;
+	ret |= i;
+
+	ret = i2c_smbus_write_byte_data(client, addr, ret);
+	if (ret < 0)
+		goto exit;
+	ret = 0;
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static ssize_t write_audio_power(struct i2c_client *client, int val)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	int ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_read_byte_data(client, AUDIO_CNTL);
+	if (ret < 0)
+		goto exit;
+
+	if (val)
+		ret |= AMP_EN;
+	else
+		ret &= ~AMP_EN;
+
+	ret = i2c_smbus_write_byte_data(client, AUDIO_CNTL, ret);
+	if (ret < 0)
+		goto exit;
+
+	ret = 0;
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static int write_audio_clock(struct i2c_client *client, int val)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	int ret;
+
+	switch (val) {
+	case 1100:
+		val = CLK_1100K;
+		break;
+	case 1400:
+		val = CLK_1400K;
+		break;
+	case 1250:
+		val = CLK_1250K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_read_byte_data(client, AUDIO_CNTL);
+	if (ret < 0)
+		goto exit;
+
+	ret &= ~CLK_MASK;
+	ret |= val;
+
+	ret = i2c_smbus_write_byte_data(client, AUDIO_CNTL, ret);
+	if (ret < 0)
+		goto exit;
+	ret = 0;
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static int write_audio_gain(struct i2c_client *client, int val)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	int ret;
+
+	if (val < -3 || val > 24)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_read_byte_data(client, AUDIO_CNTL);
+	if (ret < 0)
+		goto exit;
+
+	ret &= ~GAIN_MASK;
+	ret |= DB_TO_IDX(val);
+
+	ret = i2c_smbus_write_byte_data(client, AUDIO_CNTL, ret);
+exit:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/*
+ * SysFS support
+ */
+
+/* LDO1 */
+static ssize_t show_ldo1_power(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return read_ldo_power(to_i2c_client(dev), MAX8821_LDO1, buf);
+}
+
+static ssize_t store_ldo1_power(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_ldo_power(to_i2c_client(dev), MAX8821_LDO1,
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(ldo1_power, S_IWUSR | S_IRUGO,
+		   show_ldo1_power, store_ldo1_power);
+
+static ssize_t show_ldo1_voltage(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return read_ldo_voltage(to_i2c_client(dev), MAX8821_LDO1, buf);
+}
+
+static ssize_t store_ldo1_voltage(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_ldo_voltage(to_i2c_client(dev), MAX8821_LDO1,
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(ldo1_voltage, S_IWUSR | S_IRUGO,
+		   show_ldo1_voltage, store_ldo1_voltage);
+
+/* LDO2 */
+static ssize_t show_ldo2_power(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return read_ldo_power(to_i2c_client(dev), MAX8821_LDO2, buf);
+}
+
+static ssize_t store_ldo2_power(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_ldo_power(to_i2c_client(dev), MAX8821_LDO2,
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(ldo2_power, S_IWUSR | S_IRUGO,
+		   show_ldo2_power, store_ldo2_power);
+
+static ssize_t show_ldo2_voltage(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return read_ldo_voltage(to_i2c_client(dev), MAX8821_LDO2, buf);
+}
+
+static ssize_t store_ldo2_voltage(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_ldo_voltage(to_i2c_client(dev), MAX8821_LDO2,
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(ldo2_voltage, S_IWUSR | S_IRUGO,
+		   show_ldo2_voltage, store_ldo2_voltage);
+
+/* Audio */
+static ssize_t show_audio_power(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret = i2c_smbus_read_byte_data(to_i2c_client(dev), AUDIO_CNTL);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d", !!(ret & AMP_EN));
+}
+
+static ssize_t store_audio_power(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_audio_power(to_i2c_client(dev),
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(audio_power, S_IWUSR | S_IRUGO,
+		   show_audio_power, store_audio_power);
+
+static ssize_t show_audio_clock(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret = i2c_smbus_read_byte_data(to_i2c_client(dev), AUDIO_CNTL);
+	if (ret < 0)
+		return ret;
+
+	if ((ret & CLK_MASK) = CLK_1100K)
+		strncpy(buf, "1100", 4);
+	if ((ret & CLK_MASK) = CLK_1400K)
+		strncpy(buf, "1400", 4);
+	if ((ret & CLK_MASK) = CLK_1250K)
+		strncpy(buf, "1250", 4);
+	return 4;
+}
+
+static ssize_t store_audio_clock(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_audio_clock(to_i2c_client(dev),
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+
+static DEVICE_ATTR(audio_clock, S_IWUSR | S_IRUGO,
+		   show_audio_clock, store_audio_clock);
+
+static ssize_t show_audio_gain(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret = i2c_smbus_read_byte_data(to_i2c_client(dev), AUDIO_CNTL);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d", IDX_TO_DB(ret));
+}
+
+static ssize_t store_audio_gain(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = write_audio_gain(to_i2c_client(dev),
+					strict_strtol(buf, NULL, 10));
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR(audio_gain, S_IWUSR | S_IRUGO,
+		   show_audio_gain, store_audio_gain);
+
+static struct attribute *max8821_attributes[] = {
+	&dev_attr_ldo1_power.attr,
+	&dev_attr_ldo1_voltage.attr,
+	&dev_attr_ldo2_power.attr,
+	&dev_attr_ldo2_voltage.attr,
+	&dev_attr_audio_power.attr,
+	&dev_attr_audio_clock.attr,
+	&dev_attr_audio_gain.attr,
+	NULL
+};
+
+static const struct attribute_group max8821_attr_group = {
+	.attrs = max8821_attributes,
+};
+
+/*
+ * Led support
+ */
+
+static void max8821_led_set_work(struct work_struct *p)
+{
+	struct max8821_led *led = container_of(p, struct max8821_led, work);
+	struct max8821_data *data = led->data;
+	struct i2c_client *client = data->client;
+
+	write_led_brightness(client, led - &data->led[0], led->new_level);
+}
+
+static void max8821_led_set(struct led_classdev *p, enum led_brightness value)
+{
+	struct max8821_led *led = container_of(p, struct max8821_led, dev);
+
+	led->new_level = value;
+	schedule_work(&led->work);
+}
+
+/*
+ * Device init function
+ */
+
+static int max8821_init_client(struct i2c_client *client,
+				struct max8821_platform_data *pdata)
+{
+	int i, ret;
+
+	/* Set the platform defaults */
+	for (i = MAX8821_LED1; i <= MAX8821_LED6; i++) {
+		ret = write_led_brightness(client, i, pdata->led[i].brightness);
+		if (ret)
+			dev_warn(&client->dev,
+				"unable to init LED%d brightness to %d\n",
+				i + 1, pdata->led[i].brightness);
+	}
+
+	for (i = MAX8821_LDO1; i <= MAX8821_LDO2; i++) {
+		ret = write_ldo_power(client, i, pdata->ldo[i].power);
+		if (ret)
+			dev_warn(&client->dev,
+					"unable to init LDO%d power to %d\n",
+					i + 1, pdata->ldo[i].power);
+		if (pdata->ldo[i].power = 0)
+			continue;
+
+		ret = write_ldo_voltage(client, i, pdata->ldo[i].voltage);
+		if (ret)
+			dev_warn(&client->dev,
+					"unable to init LDO%d voltage to %d\n",
+					i + 1, pdata->ldo[i].voltage);
+	}
+
+	ret = write_audio_power(client, pdata->audio.power);
+	if (ret)
+		dev_warn(&client->dev,
+				"unable to init audio power to %d\n",
+				pdata->ldo[i].power);
+	if (pdata->audio.power = 1) {
+		ret = write_audio_clock(client, pdata->audio.clock);
+		if (ret)
+			dev_warn(&client->dev,
+					"unable to init audio clock to %d\n",
+					pdata->audio.clock);
+		ret = write_audio_gain(client, pdata->audio.gain);
+		if (ret)
+			dev_warn(&client->dev,
+					"unable to init audio gain to %d\n",
+					pdata->audio.gain);
+	}
+
+	return 0;
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+
+static struct max8821_platform_data defs;	/* all values are set to '0' */
+
+static struct i2c_driver max8821_driver;
+static int __devinit max8821_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct max8821_data *data;
+	struct max8821_platform_data *pdata;
+	int i, ret = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct max8821_data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	/* Check platform data */
+	pdata = client->dev.platform_data;
+	if (!pdata)
+		pdata = &defs;
+	for (i = MAX8821_LED1; i <= MAX8821_LED6; i++)
+		if (pdata->led[i].name) {
+			dev_dbg(&client->dev, "led%d:\n", i + 1);
+			dev_dbg(&client->dev, "\tname %s\n",
+				pdata->led[i].name);
+			dev_dbg(&client->dev, "\tdefault brightness %d\n",
+				pdata->led[i].brightness);
+#ifdef CONFIG_LEDS_TRIGGERS
+			dev_dbg(&client->dev, "\ttrigger %s\n",
+				pdata->led[i].trigger);
+#endif
+		}
+	for (i = MAX8821_LDO1; i <= MAX8821_LDO2; i++)
+		if (pdata->ldo[i].power) {
+			dev_dbg(&client->dev, "LDO%d:\n", i + 1);
+			dev_dbg(&client->dev, "\tpower %d\n",
+					pdata->ldo[i].power);
+			dev_dbg(&client->dev, "\tvoltage %dV\n",
+					pdata->ldo[i].voltage);
+		}
+	if (pdata->audio.power) {
+		dev_dbg(&client->dev, "audio:\n");
+		dev_dbg(&client->dev, "\tpower %d\n", pdata->audio.power);
+		dev_dbg(&client->dev, "\tclock %dkHz\n", pdata->audio.clock);
+		dev_dbg(&client->dev, "\tgain %dV\n", pdata->audio.gain);
+	}
+
+	mutex_init(&data->update_lock);
+
+	/* Initialize the MAX8821 chip */
+	ret = max8821_init_client(client, pdata);
+	if (ret)
+		goto exit_kfree;
+
+	/* Register the led devices */
+	for (i = MAX8821_LED1; i <= MAX8821_LED6; i++)
+		if (pdata->led[i].name) {
+			data->led[i].data = data;
+			data->led[i].dev.name = pdata->led[i].name;
+			data->led[i].dev.brightness = pdata->led[i].brightness;
+			data->led[i].dev.brightness_set = max8821_led_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+			data->led[i].dev.default_trigger +						pdata->led[i].trigger;
+#endif
+			INIT_WORK(&data->led[i].work, max8821_led_set_work);
+			ret = led_classdev_register(&client->dev,
+							&data->led[i].dev);
+			if (ret < 0)
+				dev_warn(&client->dev, "unable to register "
+						"led%d into the system\n",
+						i + 1);
+		}
+
+	/* Register sysfs hooks */
+	ret = sysfs_create_group(&client->dev.kobj, &max8821_attr_group);
+	if (ret)
+		goto exit_kfree;
+
+	dev_info(&client->dev, "support ver. %s enabled\n", DRIVER_VERSION);
+
+	return 0;
+
+exit_kfree:
+	kfree(data);
+exit:
+	return ret;
+}
+
+static int __devexit max8821_remove(struct i2c_client *client)
+{
+	struct max8821_data *data = i2c_get_clientdata(client);
+	int i;
+
+	for (i = MAX8821_LED1; i <= MAX8821_LED6; i++)
+		led_classdev_unregister(&data->led[i].dev);
+
+	sysfs_remove_group(&client->dev.kobj, &max8821_attr_group);
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id max8821_id[] = {
+	{ "max8821", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max8821_id);
+
+static struct i2c_driver max8821_driver = {
+	.driver = {
+		.name	= "max8821",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= max8821_probe,
+	.remove	= __devexit_p(max8821_remove),
+	.id_table = max8821_id,
+};
+
+static int __init max8821_init(void)
+{
+	return i2c_add_driver(&max8821_driver);
+}
+
+static void __exit max8821_exit(void)
+{
+	i2c_del_driver(&max8821_driver);
+}
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
+MODULE_DESCRIPTION("MAX8821 led charge pump with mono class D audio amp and "
+			"dual LDO");
+MODULE_LICENSE("GPL");
+
+module_init(max8821_init);
+module_exit(max8821_exit);
diff --git a/include/linux/i2c/max8821.h b/include/linux/i2c/max8821.h
new file mode 100644
index 0000000..80f4c4a
--- /dev/null
+++ b/include/linux/i2c/max8821.h
@@ -0,0 +1,32 @@
+#ifndef __LINUX_MAX8821_H
+#define __LINUX_MAX8821_H
+
+#define MAX8821_LED1	0
+#define MAX8821_LED2	1
+#define MAX8821_LED3	2
+#define MAX8821_LED4	3
+#define MAX8821_LED5	4
+#define MAX8821_LED6	5
+
+#define MAX8821_LDO1	0
+#define MAX8821_LDO2	1
+
+struct max8821_platform_data {
+	struct {
+		char *name;
+		char *trigger;	/* see available led triggers */
+		unsigned int brightness; /* use values in [0:31] */
+	} led[6];
+	struct {
+		int power;	/* Use 0 or 1 */
+		int voltage;	/* see ldo1_voltage[2][] for allowed values */
+	} ldo[2];
+	struct {
+		int power;	/* Use 0 or 1 */
+		int clock;	/* see write_clock() for allowed values */
+		int gain;	/* see write_audio_gain() for allowed values */
+	} audio;
+};
+
+#endif /* __LINUX_MAX8821_H */
+
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
