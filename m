From: Simon Guinot <simon@sequanux.org>
Date: Sun, 17 Oct 2010 15:50:11 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <1287330612-11256-1-git-send-email-simon@sequanux.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
In-Reply-To: <20101017154021.GB29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

This patch adds hwmon support for the GPIO connected fan.

Platform specific informations as GPIO pinout and speed conversion array
(rpm from/to GPIO value) are passed to the driver via platform_data.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/hwmon/Kconfig    |    9 +
 drivers/hwmon/Makefile   |    1 +
 drivers/hwmon/gpio-fan.c |  508 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio-fan.h |   43 ++++
 4 files changed, 561 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/gpio-fan.c
 create mode 100644 include/linux/gpio-fan.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4d4d09b..1dc57c1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -399,6 +399,15 @@ config SENSORS_GL520SM
 	  This driver can also be built as a module.  If so, the module
 	  will be called gl520sm.
 
+config SENSORS_GPIO_FAN
+	tristate "GPIO fan"
+	depends on GENERIC_GPIO
+	help
+	  If you say yes here you get support for the GPIO connected fan.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gpio-fan.
+
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
 	depends on X86 && PCI && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e3c2484..a793e28 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
new file mode 100644
index 0000000..6cc8205
--- /dev/null
+++ b/drivers/hwmon/gpio-fan.c
@@ -0,0 +1,508 @@
+/*
+ * gpio-fan.c - Hwmon driver for GPIO connected fan.
+ *
+ * Copyright (C) 2010 LaCie
+ *
+ * Author: Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/hwmon.h>
+#include <linux/gpio.h>
+#include <linux/gpio-fan.h>
+
+struct gpio_fan_data {
+	struct platform_device	*pdev;
+	struct device		*hwmon_dev;
+	struct mutex		lock; /* lock GPIOs operations. */
+	int			num_ctrl;
+	unsigned		*ctrl;
+	int			ctrl_val;
+	int			num_speed;
+	struct gpio_fan_speed	*speed;
+	int			pwm_enable;
+	struct gpio_fan_alarm	*alarm;
+	struct work_struct	alarm_work;
+	void (*platform_set_ctrl)(int num_ctrl, unsigned *ctrl, int ctrl_val);
+};
+
+/*
+ * Alarm GPIO.
+ */
+
+static void fan_alarm_notify(struct work_struct *ws)
+{
+	struct gpio_fan_data *fan_data +		container_of(ws, struct gpio_fan_data, alarm_work);
+
+	sysfs_notify(&fan_data->pdev->dev.kobj, NULL, "fan1_alarm");
+	kobject_uevent(&fan_data->pdev->dev.kobj, KOBJ_CHANGE);
+}
+
+static irqreturn_t fan_alarm_irq_handler(int irq, void *dev_id)
+{
+	struct gpio_fan_data *fan_data = dev_id;
+
+	schedule_work(&fan_data->alarm_work);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t show_fan_alarm(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	struct gpio_fan_alarm *alarm = fan_data->alarm;
+	int value = gpio_get_value(alarm->gpio);
+
+	if (alarm->active_low)
+		value = !value;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
+
+static int __devinit
+fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *alarm)
+{
+	int err;
+	int alarm_irq;
+	struct platform_device *pdev = fan_data->pdev;
+
+	fan_data->alarm = alarm;
+
+	err = gpio_request(alarm->gpio, "GPIO fan alarm");
+	if (err)
+		return err;
+
+	err = gpio_direction_input(alarm->gpio);
+	if (err)
+		goto err_free_gpio;
+
+	err = device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
+	if (err)
+		goto err_free_gpio;
+
+	INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
+	alarm_irq = gpio_to_irq(alarm->gpio);
+	set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
+	err = request_irq(alarm_irq, fan_alarm_irq_handler, 0,
+			  "GPIO fan alarm", fan_data);
+	if (err)
+		goto err_free_sysfs;
+
+	return 0;
+
+err_free_sysfs:
+	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
+err_free_gpio:
+	gpio_free(alarm->gpio);
+
+	return err;
+}
+
+static void __devexit fan_alarm_free(struct gpio_fan_data *fan_data)
+{
+	struct platform_device *pdev = fan_data->pdev;
+
+	free_irq(gpio_to_irq(fan_data->alarm->gpio), fan_data);
+	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
+	gpio_free(fan_data->alarm->gpio);
+}
+
+/*
+ * Control GPIOs.
+ */
+
+static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
+{
+	int i;
+	int ctrl_val = 0;
+
+	for (i = 0; i < fan_data->num_ctrl; i++) {
+		int value;
+
+		value = gpio_get_value(fan_data->ctrl[i]);
+		ctrl_val |= (value << i);
+	}
+	return ctrl_val;
+}
+
+static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
+{
+	int i;
+
+	for (i = 0; i < fan_data->num_ctrl; i++) {
+		int value = !!(ctrl_val & (1 << i));
+
+		gpio_set_value(fan_data->ctrl[i], value);
+	}
+}
+
+static void set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
+{
+	if (fan_data->platform_set_ctrl)
+		fan_data->platform_set_ctrl(fan_data->num_ctrl, fan_data->ctrl,
+					    ctrl_val);
+	else
+		__set_fan_ctrl(fan_data, ctrl_val);
+
+	fan_data->ctrl_val = ctrl_val;
+}
+
+static int rpm_to_ctrl(struct gpio_fan_data *fan_data, int rpm)
+{
+	struct gpio_fan_speed *speed = fan_data->speed;
+	int num_speed = fan_data->num_speed;
+	int ctrl_val = speed[num_speed - 1].ctrl_val; /* Maximum speed */
+	int i;
+
+	for (i = 0; i < num_speed; i++) {
+		if (speed[i].rpm >= rpm) {
+			ctrl_val = speed[i].ctrl_val;
+			break;
+		}
+	}
+	return ctrl_val;
+}
+
+static int ctrl_to_rpm(struct gpio_fan_data *fan_data, int ctrl_val, int *rpm)
+{
+	struct gpio_fan_speed *speed = fan_data->speed;
+	int num_speed = fan_data->num_speed;
+	int i;
+
+	for (i = 0; i < num_speed; i++) {
+		if (speed[i].ctrl_val = ctrl_val) {
+			*rpm = speed[i].rpm;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int pwm_to_rpm(struct gpio_fan_data *fan_data, u8 pwm)
+{
+	int rpm_min = fan_data->speed[0].rpm;
+	int rpm_max = fan_data->speed[fan_data->num_speed - 1].rpm;
+
+	return rpm_min + DIV_ROUND_UP((rpm_max - rpm_min), 255) * pwm;
+}
+
+static u8 rpm_to_pwm(struct gpio_fan_data *fan_data, int rpm)
+{
+	int rpm_min = fan_data->speed[0].rpm;
+	int rpm_max = fan_data->speed[fan_data->num_speed - 1].rpm;
+
+	return (rpm - rpm_min) / DIV_ROUND_UP((rpm_max - rpm_min), 255);
+}
+
+static ssize_t show_pwm(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int rpm;
+	int ret;
+
+	ret = ctrl_to_rpm(fan_data, fan_data->ctrl_val, &rpm);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", rpm_to_pwm(fan_data, rpm));
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	unsigned long pwm;
+	int ctrl_val;
+	int ret = count;
+
+	if (strict_strtoul(buf, 10, &pwm) || pwm > 255)
+		return -EINVAL;
+
+	mutex_lock(&fan_data->lock);
+
+	if (fan_data->pwm_enable != 1) {
+		ret = -EPERM;
+		goto exit_unlock;
+	}
+
+	ctrl_val = rpm_to_ctrl(fan_data, pwm_to_rpm(fan_data, (u8) pwm));
+	if (ctrl_val != fan_data->ctrl_val)
+		set_fan_ctrl(fan_data, ctrl_val);
+
+exit_unlock:
+	mutex_unlock(&fan_data->lock);
+
+	return ret;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", fan_data->pwm_enable);
+}
+
+static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	unsigned long val;
+	int ctrl_val;
+
+	if (strict_strtoul(buf, 10, &val) || val > 1)
+		return -EINVAL;
+
+	if (fan_data->pwm_enable = val)
+		return count;
+
+	mutex_lock(&fan_data->lock);
+
+	fan_data->pwm_enable = val;
+
+	/* Disable manual control mode: set fan at full speed. */
+	if (val = 0) {
+		ctrl_val = fan_data->speed[fan_data->num_speed - 1].ctrl_val;
+		if (ctrl_val != fan_data->ctrl_val)
+			set_fan_ctrl(fan_data, ctrl_val);
+	}
+
+	mutex_unlock(&fan_data->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_mode(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0\n");
+}
+
+static ssize_t show_rpm(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
+	int ret;
+	int rpm;
+
+	ret = ctrl_to_rpm(fan_data, fan_data->ctrl_val, &rpm);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", rpm);
+}
+
+static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
+		   show_pwm_enable, set_pwm_enable);
+static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
+static DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL);
+
+static struct attribute *gpio_fan_ctrl_attributes[] = {
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm1_mode.attr,
+	&dev_attr_fan1_input.attr,
+	NULL
+};
+
+static const struct attribute_group gpio_fan_ctrl_group = {
+	.attrs = gpio_fan_ctrl_attributes,
+};
+
+static int __devinit fan_ctrl_init(struct gpio_fan_data *fan_data,
+				   struct gpio_fan_platform_data *pdata)
+{
+	struct platform_device *pdev = fan_data->pdev;
+	int num_ctrl = pdata->num_ctrl;
+	unsigned *ctrl = pdata->ctrl;
+	int i, err;
+
+	for (i = 0; i < num_ctrl; i++) {
+		err = gpio_request(ctrl[i], "GPIO fan control");
+		if (err)
+			goto err_free_gpio;
+
+		err = gpio_direction_output(ctrl[i], gpio_get_value(ctrl[i]));
+		if (err) {
+			gpio_free(ctrl[i]);
+			goto err_free_gpio;
+		}
+	}
+
+	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
+	if (err)
+		goto err_free_gpio;
+
+	fan_data->num_ctrl = num_ctrl;
+	fan_data->ctrl = ctrl;
+	fan_data->platform_set_ctrl = pdata->set_ctrl;
+	fan_data->num_speed = pdata->num_speed;
+	fan_data->speed = pdata->speed;
+	fan_data->pwm_enable = 1; /* Enable manual fan speed control. */
+	if (pdata->get_ctrl)
+		fan_data->ctrl_val = pdata->get_ctrl(num_ctrl, ctrl);
+	else
+		fan_data->ctrl_val = __get_fan_ctrl(fan_data);
+
+	return 0;
+
+err_free_gpio:
+	for (i = i - 1; i >= 0; i--)
+		gpio_free(ctrl[i]);
+
+	return err;
+}
+
+static void __devexit fan_ctrl_free(struct gpio_fan_data *fan_data)
+{
+	struct platform_device *pdev = fan_data->pdev;
+	int i;
+
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
+	for (i = 0; i < fan_data->num_ctrl; i++)
+		gpio_free(fan_data->ctrl[i]);
+}
+
+/*
+ * Platform driver.
+ */
+
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "gpio-fan\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static int __devinit gpio_fan_probe(struct platform_device *pdev)
+{
+	int err = 0;
+	struct gpio_fan_data *fan_data;
+	struct gpio_fan_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+	fan_data = kzalloc(sizeof(struct gpio_fan_data), GFP_KERNEL);
+	if (!fan_data)
+		return -ENOMEM;
+
+	fan_data->pdev = pdev;
+	platform_set_drvdata(pdev, fan_data);
+	mutex_init(&fan_data->lock);
+
+	/* Configure alarm GPIO if available. */
+	if (pdata->alarm) {
+		err = fan_alarm_init(fan_data, pdata->alarm);
+		if (err)
+			goto err_free_data;
+	}
+
+	/* Configure control GPIOs if available. */
+	if (pdata->ctrl && pdata->num_ctrl) {
+		if (!pdata->num_speed || !pdata->speed) {
+			err = -EINVAL;
+			goto err_free_alarm;
+		}
+		err = fan_ctrl_init(fan_data, pdata);
+		if (err)
+			goto err_free_alarm;
+	}
+
+	err = device_create_file(&pdev->dev, &dev_attr_name);
+	if (err)
+		goto err_free_ctrl;
+
+	/* Make this driver part of hwmon class. */
+	fan_data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(fan_data->hwmon_dev)) {
+		err = PTR_ERR(fan_data->hwmon_dev);
+		goto err_remove_name;
+	}
+
+	dev_info(&pdev->dev, "GPIO fan initialized\n");
+
+	return 0;
+
+err_remove_name:
+	device_remove_file(&pdev->dev, &dev_attr_name);
+err_free_ctrl:
+	fan_ctrl_free(fan_data);
+err_free_alarm:
+	fan_alarm_free(fan_data);
+err_free_data:
+	platform_set_drvdata(pdev, NULL);
+	kfree(fan_data);
+
+	return err;
+}
+
+static int __devexit gpio_fan_remove(struct platform_device *pdev)
+{
+	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(fan_data->hwmon_dev);
+	device_remove_file(&pdev->dev, &dev_attr_name);
+	if (fan_data->alarm)
+		fan_alarm_free(fan_data);
+	if (fan_data->ctrl)
+		fan_ctrl_free(fan_data);
+	kfree(fan_data);
+
+	return 0;
+}
+
+static struct platform_driver gpio_fan_driver = {
+	.probe	= gpio_fan_probe,
+	.remove	= __devexit_p(gpio_fan_remove),
+	.driver	= {
+		.name = "gpio-fan",
+	},
+};
+
+static int __init gpio_fan_init(void)
+{
+	return platform_driver_register(&gpio_fan_driver);
+}
+
+static void __exit gpio_fan_exit(void)
+{
+	platform_driver_unregister(&gpio_fan_driver);
+	return;
+}
+
+module_init(gpio_fan_init);
+module_exit(gpio_fan_exit);
+
+MODULE_AUTHOR("Simon Guinot <sguinot@lacie.com>");
+MODULE_DESCRIPTION("GPIO FAN driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio-fan");
diff --git a/include/linux/gpio-fan.h b/include/linux/gpio-fan.h
new file mode 100644
index 0000000..58f0930
--- /dev/null
+++ b/include/linux/gpio-fan.h
@@ -0,0 +1,43 @@
+/*
+ * include/linux/gpio-fan.h
+ *
+ * Platform data structure for GPIO fan driver
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_GPIO_FAN_H
+#define __LINUX_GPIO_FAN_H
+
+struct gpio_fan_alarm {
+	unsigned	gpio;
+	unsigned	active_low;
+};
+
+struct gpio_fan_speed {
+	int rpm;
+	int ctrl_val;
+};
+
+struct gpio_fan_platform_data {
+	int			num_ctrl;
+	unsigned		*ctrl;	/* fan control GPIOs. */
+	struct gpio_fan_alarm	*alarm;	/* fan alarm GPIO. */
+	/*
+	 * Speed conversion array: rpm from/to GPIO bit field.
+	 * This array _must_ be sorted in ascending rpm order.
+	 */
+	int			num_speed;
+	struct gpio_fan_speed	*speed;
+	/*
+	 * This functions can be supplied if some specific operations are
+	 * required to get/set a fan control (handle a latch enable GPIO,
+	 * prevent from writing some transitional control value, etc...)
+	 */
+	int	(*get_ctrl)(int num_ctrl, unsigned *ctrl);
+	void	(*set_ctrl)(int num_ctrl, unsigned *ctrl, int ctrl_val);
+};
+
+#endif /* __LINUX_GPIO_FAN_H */
-- 
1.6.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
