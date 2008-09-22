From: Rodolfo Giometti <giometti@enneenne.com>
Date: Mon, 22 Sep 2008 14:06:22 +0000
Subject: [lm-sensors] [PATCH 1/1] leds: support for Philips PCA9531 8-bit
Message-Id: <1222092382-22148-2-git-send-email-giometti@enneenne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rodolfo Giometti <giometti@linux.it>

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
---
 drivers/leds/Kconfig        |    7 +
 drivers/leds/Makefile       |    1 +
 drivers/leds/leds-pca9531.c |  325 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/pca9531.h |   25 ++++
 4 files changed, 358 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-pca9531.c
 create mode 100644 include/linux/i2c/pca9531.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9556262..52fca4c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -163,6 +163,13 @@ config LEDS_PCA955X
 	  LED driver chips accessed via the I2C bus.  Supported
 	  devices include PCA9550, PCA9551, PCA9552, and PCA9553.
 
+config LEDS_PCA9531
+	tristate "LED Support using PCA9531 8-bit led dimmer"
+	depends on LEDS_CLASS && I2C
+	help
+	  This option enables led support by using Philips PCA9531
+	  8-bit led dimmer.
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index ff7982b..4901575 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_LEDS_CM_X270)              += leds-cm-x270.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
 obj-$(CONFIG_LEDS_FSG)			+= leds-fsg.o
+obj-$(CONFIG_LEDS_PCA9531)		+= leds-pca9531.o
 obj-$(CONFIG_LEDS_PCA955X)		+= leds-pca955x.o
 
 # LED Triggers
diff --git a/drivers/leds/leds-pca9531.c b/drivers/leds/leds-pca9531.c
new file mode 100644
index 0000000..8cad2aa
--- /dev/null
+++ b/drivers/leds/leds-pca9531.c
@@ -0,0 +1,325 @@
+/*
+ *  pca9531.c - driver for 8-bit I2C led dimmer
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
+#include <linux/i2c/pca9531.h>
+
+#define DRIVER_VERSION		"0.40.0"
+
+/*
+ * Defines
+ */
+
+#define INPUT		0x00
+#define PWM0		0x02
+#define PWM1		0x04
+#define LS0		0x05
+#define LS1		0x06
+#define    LED_OFF	   0
+#define    LED_ON	   1
+#define    LED_PWM0	   2
+#define    LED_PWM1	   3
+#define    LED_MASK	   3
+
+/*
+ * Structs
+ */
+
+struct pca9531_data;
+struct pca9531_led {
+	struct pca9531_data *data;	/* back link */
+	struct led_classdev dev;
+	int new_level;
+
+	unsigned long pwm:2;
+	unsigned long inverted:1;
+
+	struct work_struct work;
+};
+
+struct pca9531_data {
+	struct i2c_client *client;
+	struct mutex update_lock;
+
+	struct pca9531_led led[8];
+};
+
+/*
+ * Management functions
+ */
+
+static int write_led_brightness(struct i2c_client *client, int id,
+				int pwm, unsigned int brightness)
+{
+	struct pca9531_data *data = i2c_get_clientdata(client);
+	u8 addr = id <= 3 ? LS0 : LS1;
+	u8 tmp;
+	int ret;
+
+	if (brightness > 255 ||
+		(pwm != PCA9531_PWM0 && pwm != PCA9531_PWM1 &&
+			pwm != PCA9531_ONOFF))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+
+	/* Set brightness intensity.
+	 *
+	 * Please, note that if you (the driver user) define two or more
+	 * leds sharing one PWM unit, then all that leds will change
+	 * their intensity when you change the brightness intensity!
+	 * So, when configuring the drive, you should define at most one
+	 * led for each PWM unit.
+	 * However you (the driver user) are a real-programmer so you
+	 * shouldn't do such (evil) thing... ;)
+	 */
+	if (brightness && pwm != PCA9531_ONOFF) {
+		ret = i2c_smbus_write_byte_data(client,
+				pwm = PCA9531_PWM0 ? PWM0 : PWM1, brightness);
+		if (ret < 0)
+			goto exit;
+	}
+
+	/* Enable/disable led */
+	ret = i2c_smbus_read_byte_data(client, addr);
+	if (ret < 0)
+		goto exit;
+
+	ret &= ~(LED_MASK << ((id % 4) * 2));
+	tmp = LED_OFF;
+	if (brightness)
+		switch (pwm) {
+		case PCA9531_ONOFF:
+			tmp = LED_ON;
+			break;
+		case PCA9531_PWM0:
+			tmp = LED_PWM0;
+			break;
+		case PCA9531_PWM1:
+			tmp = LED_PWM1;
+			break;
+		}
+	ret |= tmp << ((id % 4) * 2);
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
+/*
+ * Led support
+ */
+
+static void pca9531_led_set_work(struct work_struct *p)
+{
+	struct pca9531_led *led = container_of(p, struct pca9531_led, work);
+	struct pca9531_data *data = led->data;
+	struct i2c_client *client = data->client;
+	int id = led - &data->led[0];
+	int ret;
+
+	ret = write_led_brightness(client, id, led->pwm,
+					led->inverted ?
+						255 - led->new_level :
+						led->new_level);
+	if (ret)
+		dev_warn(&client->dev, "unable to set brightness for led%d\n",
+					id);
+}
+
+static void pca9531_led_set(struct led_classdev *p, enum led_brightness value)
+{
+	struct pca9531_led *led = container_of(p, struct pca9531_led, dev);
+
+	led->new_level = value;
+	schedule_work(&led->work);
+}
+
+/*
+ * Device init function
+ */
+
+static int pca9531_init_client(struct i2c_client *client,
+				struct pca9531_platform_data *pdata)
+{
+	int i, ret;
+
+	/* Set the platform defaults */
+	for (i = PCA9531_LED0; i <= PCA9531_LED7; i++) {
+		if (pdata[i].name)
+			ret = write_led_brightness(client, i, pdata[i].pwm,
+					pdata[i].inverted ?
+						255 - pdata[i].brightness :
+						pdata[i].brightness);
+		else
+			ret = write_led_brightness(client, i, PCA9531_ONOFF, 0);
+		if (ret)
+			dev_warn(&client->dev,
+				"unable to init LED%d brightness to %d\n", i,
+				pdata[i].brightness);
+	}
+
+	return 0;
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+
+static struct pca9531_platform_data defs[8];	/* all values are set to '0' */
+
+static struct i2c_driver pca9531_driver;
+static int __devinit pca9531_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct pca9531_data *data;
+	struct pca9531_platform_data *pdata;
+	int i, ret = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	data = kzalloc(sizeof(struct pca9531_data), GFP_KERNEL);
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
+		pdata = defs;
+	for (i = PCA9531_LED0; i <= PCA9531_LED7; i++)
+		if (pdata[i].name) {
+			dev_dbg(&client->dev, "led%d:\n", i);
+			dev_dbg(&client->dev, "\tname %s\n", pdata[i].name);
+			dev_dbg(&client->dev, "\tdefault brightness %d\n",
+				pdata[i].brightness);
+			dev_dbg(&client->dev, "\tinverted brightness %d\n",
+				pdata[i].inverted);
+#ifdef CONFIG_LEDS_TRIGGERS
+			dev_dbg(&client->dev, "\ttrigger %s\n",
+				pdata[i].trigger);
+#endif
+			dev_dbg(&client->dev, "\tpwm %d\n", pdata[i].pwm);
+		}
+
+	mutex_init(&data->update_lock);
+
+	/* Initialize the PCA9531 chip */
+	ret = pca9531_init_client(client, pdata);
+	if (ret)
+		goto exit_kfree;
+
+	/* Register the led devices */
+	for (i = PCA9531_LED0; i <= PCA9531_LED7; i++)
+		if (pdata[i].name) {
+			data->led[i].data = data;
+			data->led[i].pwm = pdata[i].pwm;
+			data->led[i].dev.name = pdata[i].name;
+			data->led[i].inverted = pdata[i].inverted;
+			data->led[i].dev.brightness = pdata[i].brightness;
+			data->led[i].dev.brightness_set = pca9531_led_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+			data->led[i].dev.default_trigger = pdata[i].trigger;
+#endif
+			INIT_WORK(&data->led[i].work, pca9531_led_set_work);
+			ret = led_classdev_register(&client->dev,
+							&data->led[i].dev);
+			if (ret < 0)
+				dev_warn(&client->dev, "unable to register "
+						"led%d into the system\n", i);
+		}
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
+static int __devexit pca9531_remove(struct i2c_client *client)
+{
+	struct pca9531_data *data = i2c_get_clientdata(client);
+	int i;
+
+	for (i = PCA9531_LED1; i <= PCA9531_LED7; i++)
+		led_classdev_unregister(&data->led[i].dev);
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id pca9531_id[] = {
+	{ "pca9531", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca9531_id);
+
+static struct i2c_driver pca9531_driver = {
+	.driver = {
+		.name	= "pca9531",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pca9531_probe,
+	.remove	= __devexit_p(pca9531_remove),
+	.id_table = pca9531_id,
+};
+
+static int __init pca9531_init(void)
+{
+	return i2c_add_driver(&pca9531_driver);
+}
+
+static void __exit pca9531_exit(void)
+{
+	i2c_del_driver(&pca9531_driver);
+}
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
+MODULE_DESCRIPTION("PCA9531 driver for 8-bit I2C led dimmer"
+			"dual LDO");
+MODULE_LICENSE("GPL");
+
+module_init(pca9531_init);
+module_exit(pca9531_exit);
diff --git a/include/linux/i2c/pca9531.h b/include/linux/i2c/pca9531.h
new file mode 100644
index 0000000..c00201d
--- /dev/null
+++ b/include/linux/i2c/pca9531.h
@@ -0,0 +1,25 @@
+#ifndef __LINUX_PCA9531_H
+#define __LINUX_PCA9531_H
+
+#define PCA9531_LED0	0
+#define PCA9531_LED1	1
+#define PCA9531_LED2	2
+#define PCA9531_LED3	3
+#define PCA9531_LED4	4
+#define PCA9531_LED5	5
+#define PCA9531_LED6	6
+#define PCA9531_LED7	7
+
+#define PCA9531_ONOFF	0
+#define PCA9531_PWM0	1
+#define PCA9531_PWM1	2
+
+struct pca9531_platform_data {
+	char *name;
+	char *trigger;			/* see available led triggers */
+	unsigned int brightness;	/* use values in [0:31] */
+	unsigned int inverted:1;	/* inverted polarity led */
+	unsigned int pwm:2;		/* 0 = pwm0, 1 = pwm1, 2 = none */
+};
+
+#endif /* __LINUX_PCA9531_H */
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
