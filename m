From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Feb 2011 12:18:49 +0000
Subject: [lm-sensors] [PATCH 2/4 v2] Move hp_accel to drivers/platform/x86
Message-Id: <20110220131849.7cf01314@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hp_accel driver isn't a hardware monitoring driver, so it doesn't
belong to drivers/hwmon. Move it to drivers/platform/x86, assuming HP
doesn't ship non-x86 laptops.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Eric Piel <eric.piel@tremplin-utc.net>
---
Changes since v1:
* Update hp_accel driver path in Documentation/hwmon/lis3lv02d.
* Move hpfall.c to Documentation/laptops.

Not tested due to lack of hardware.

 Documentation/hwmon/hpfall.c    |  146 --------------
 Documentation/hwmon/lis3lv02d   |    4 
 Documentation/laptops/hpfall.c  |  146 ++++++++++++++
 drivers/hwmon/Kconfig           |   59 -----
 drivers/hwmon/Makefile          |    1 
 drivers/hwmon/hp_accel.c        |  405 ---------------------------------------
 drivers/platform/x86/Kconfig    |   18 +
 drivers/platform/x86/Makefile   |    1 
 drivers/platform/x86/hp_accel.c |  405 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 572 insertions(+), 613 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/hwmon/hp_accel.c	2011-02-19 16:50:32.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,405 +0,0 @@
-/*
- *  hp_accel.c - Interface between LIS3LV02DL driver and HP ACPI BIOS
- *
- *  Copyright (C) 2007-2008 Yan Burman
- *  Copyright (C) 2008 Eric Piel
- *  Copyright (C) 2008-2009 Pavel Machek
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/dmi.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/wait.h>
-#include <linux/poll.h>
-#include <linux/freezer.h>
-#include <linux/uaccess.h>
-#include <linux/leds.h>
-#include <acpi/acpi_drivers.h>
-#include <asm/atomic.h>
-#include "lis3lv02d.h"
-
-#define DRIVER_NAME     "lis3lv02d"
-#define ACPI_MDPS_CLASS "accelerometer"
-
-/* Delayed LEDs infrastructure ------------------------------------ */
-
-/* Special LED class that can defer work */
-struct delayed_led_classdev {
-	struct led_classdev led_classdev;
-	struct work_struct work;
-	enum led_brightness new_brightness;
-
-	unsigned int led;		/* For driver */
-	void (*set_brightness)(struct delayed_led_classdev *data, enum led_brightness value);
-};
-
-static inline void delayed_set_status_worker(struct work_struct *work)
-{
-	struct delayed_led_classdev *data -			container_of(work, struct delayed_led_classdev, work);
-
-	data->set_brightness(data, data->new_brightness);
-}
-
-static inline void delayed_sysfs_set(struct led_classdev *led_cdev,
-			      enum led_brightness brightness)
-{
-	struct delayed_led_classdev *data = container_of(led_cdev,
-			     struct delayed_led_classdev, led_classdev);
-	data->new_brightness = brightness;
-	schedule_work(&data->work);
-}
-
-/* HP-specific accelerometer driver ------------------------------------ */
-
-/* For automatic insertion of the module */
-static struct acpi_device_id lis3lv02d_device_ids[] = {
-	{"HPQ0004", 0}, /* HP Mobile Data Protection System PNP */
-	{"", 0},
-};
-MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
-
-
-/**
- * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
- * @lis3: pointer to the device struct
- *
- * Returns 0 on success.
- */
-int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
-{
-	struct acpi_device *dev = lis3->bus_priv;
-	if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
-				 NULL, NULL) != AE_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
-/**
- * lis3lv02d_acpi_read - ACPI ALRD method: read a register
- * @lis3: pointer to the device struct
- * @reg:    the register to read
- * @ret:    result of the operation
- *
- * Returns 0 on success.
- */
-int lis3lv02d_acpi_read(struct lis3lv02d *lis3, int reg, u8 *ret)
-{
-	struct acpi_device *dev = lis3->bus_priv;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-	unsigned long long lret;
-	acpi_status status;
-
-	arg0.integer.value = reg;
-
-	status = acpi_evaluate_integer(dev->handle, "ALRD", &args, &lret);
-	*ret = lret;
-	return (status != AE_OK) ? -EINVAL : 0;
-}
-
-/**
- * lis3lv02d_acpi_write - ACPI ALWR method: write to a register
- * @lis3: pointer to the device struct
- * @reg:    the register to write to
- * @val:    the value to write
- *
- * Returns 0 on success.
- */
-int lis3lv02d_acpi_write(struct lis3lv02d *lis3, int reg, u8 val)
-{
-	struct acpi_device *dev = lis3->bus_priv;
-	unsigned long long ret; /* Not used when writting */
-	union acpi_object in_obj[2];
-	struct acpi_object_list args = { 2, in_obj };
-
-	in_obj[0].type          = ACPI_TYPE_INTEGER;
-	in_obj[0].integer.value = reg;
-	in_obj[1].type          = ACPI_TYPE_INTEGER;
-	in_obj[1].integer.value = val;
-
-	if (acpi_evaluate_integer(dev->handle, "ALWR", &args, &ret) != AE_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int lis3lv02d_dmi_matched(const struct dmi_system_id *dmi)
-{
-	lis3_dev.ac = *((union axis_conversion *)dmi->driver_data);
-	pr_info("hardware type %s found\n", dmi->ident);
-
-	return 1;
-}
-
-/* Represents, for each axis seen by userspace, the corresponding hw axis (+1).
- * If the value is negative, the opposite of the hw value is used. */
-#define DEFINE_CONV(name, x, y, z)			      \
-	static union axis_conversion lis3lv02d_axis_##name = \
-		{ .as_array = { x, y, z } }
-DEFINE_CONV(normal, 1, 2, 3);
-DEFINE_CONV(y_inverted, 1, -2, 3);
-DEFINE_CONV(x_inverted, -1, 2, 3);
-DEFINE_CONV(z_inverted, 1, 2, -3);
-DEFINE_CONV(xy_swap, 2, 1, 3);
-DEFINE_CONV(xy_rotated_left, -2, 1, 3);
-DEFINE_CONV(xy_rotated_left_usd, -2, 1, -3);
-DEFINE_CONV(xy_swap_inverted, -2, -1, 3);
-DEFINE_CONV(xy_rotated_right, 2, -1, 3);
-DEFINE_CONV(xy_swap_yz_inverted, 2, -1, -3);
-
-#define AXIS_DMI_MATCH(_ident, _name, _axis) {		\
-	.ident = _ident,				\
-	.callback = lis3lv02d_dmi_matched,		\
-	.matches = {					\
-		DMI_MATCH(DMI_PRODUCT_NAME, _name)	\
-	},						\
-	.driver_data = &lis3lv02d_axis_##_axis		\
-}
-
-#define AXIS_DMI_MATCH2(_ident, _class1, _name1,	\
-				_class2, _name2,	\
-				_axis) {		\
-	.ident = _ident,				\
-	.callback = lis3lv02d_dmi_matched,		\
-	.matches = {					\
-		DMI_MATCH(DMI_##_class1, _name1),	\
-		DMI_MATCH(DMI_##_class2, _name2),	\
-	},						\
-	.driver_data = &lis3lv02d_axis_##_axis		\
-}
-static struct dmi_system_id lis3lv02d_dmi_ids[] = {
-	/* product names are truncated to match all kinds of a same model */
-	AXIS_DMI_MATCH("NC64x0", "HP Compaq nc64", x_inverted),
-	AXIS_DMI_MATCH("NC84x0", "HP Compaq nc84", z_inverted),
-	AXIS_DMI_MATCH("NX9420", "HP Compaq nx9420", x_inverted),
-	AXIS_DMI_MATCH("NW9440", "HP Compaq nw9440", x_inverted),
-	AXIS_DMI_MATCH("NC2510", "HP Compaq 2510", y_inverted),
-	AXIS_DMI_MATCH("NC2710", "HP Compaq 2710", xy_swap),
-	AXIS_DMI_MATCH("NC8510", "HP Compaq 8510", xy_swap_inverted),
-	AXIS_DMI_MATCH("HP2133", "HP 2133", xy_rotated_left),
-	AXIS_DMI_MATCH("HP2140", "HP 2140", xy_swap_inverted),
-	AXIS_DMI_MATCH("NC653x", "HP Compaq 653", xy_rotated_left_usd),
-	AXIS_DMI_MATCH("NC6730b", "HP Compaq 6730b", xy_rotated_left_usd),
-	AXIS_DMI_MATCH("NC6730s", "HP Compaq 6730s", xy_swap),
-	AXIS_DMI_MATCH("NC651xx", "HP Compaq 651", xy_rotated_right),
-	AXIS_DMI_MATCH("NC6710x", "HP Compaq 6710", xy_swap_yz_inverted),
-	AXIS_DMI_MATCH("NC6715x", "HP Compaq 6715", y_inverted),
-	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 693", xy_rotated_right),
-	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 853", xy_swap),
-	/* Intel-based HP Pavilion dv5 */
-	AXIS_DMI_MATCH2("HPDV5_I",
-			PRODUCT_NAME, "HP Pavilion dv5",
-			BOARD_NAME, "3603",
-			x_inverted),
-	/* AMD-based HP Pavilion dv5 */
-	AXIS_DMI_MATCH2("HPDV5_A",
-			PRODUCT_NAME, "HP Pavilion dv5",
-			BOARD_NAME, "3600",
-			y_inverted),
-	AXIS_DMI_MATCH("DV7", "HP Pavilion dv7", x_inverted),
-	AXIS_DMI_MATCH("HP8710", "HP Compaq 8710", y_inverted),
-	AXIS_DMI_MATCH("HDX18", "HP HDX 18", x_inverted),
-	AXIS_DMI_MATCH("HPB432x", "HP ProBook 432", xy_rotated_left),
-	AXIS_DMI_MATCH("HPB442x", "HP ProBook 442", xy_rotated_left),
-	AXIS_DMI_MATCH("HPB452x", "HP ProBook 452", y_inverted),
-	AXIS_DMI_MATCH("HPB522x", "HP ProBook 522", xy_swap),
-	AXIS_DMI_MATCH("HPB532x", "HP ProBook 532", y_inverted),
-	AXIS_DMI_MATCH("Mini510x", "HP Mini 510", xy_rotated_left_usd),
-	{ NULL, }
-/* Laptop models without axis info (yet):
- * "NC6910" "HP Compaq 6910"
- * "NC2400" "HP Compaq nc2400"
- * "NX74x0" "HP Compaq nx74"
- * "NX6325" "HP Compaq nx6325"
- * "NC4400" "HP Compaq nc4400"
- */
-};
-
-static void hpled_set(struct delayed_led_classdev *led_cdev, enum led_brightness value)
-{
-	struct acpi_device *dev = lis3_dev.bus_priv;
-	unsigned long long ret; /* Not used when writing */
-	union acpi_object in_obj[1];
-	struct acpi_object_list args = { 1, in_obj };
-
-	in_obj[0].type          = ACPI_TYPE_INTEGER;
-	in_obj[0].integer.value = !!value;
-
-	acpi_evaluate_integer(dev->handle, "ALED", &args, &ret);
-}
-
-static struct delayed_led_classdev hpled_led = {
-	.led_classdev = {
-		.name			= "hp::hddprotect",
-		.default_trigger	= "none",
-		.brightness_set		= delayed_sysfs_set,
-		.flags                  = LED_CORE_SUSPENDRESUME,
-	},
-	.set_brightness = hpled_set,
-};
-
-static acpi_status
-lis3lv02d_get_resource(struct acpi_resource *resource, void *context)
-{
-	if (resource->type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
-		struct acpi_resource_extended_irq *irq;
-		u32 *device_irq = context;
-
-		irq = &resource->data.extended_irq;
-		*device_irq = irq->interrupts[0];
-	}
-
-	return AE_OK;
-}
-
-static void lis3lv02d_enum_resources(struct acpi_device *device)
-{
-	acpi_status status;
-
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-					lis3lv02d_get_resource, &lis3_dev.irq);
-	if (ACPI_FAILURE(status))
-		printk(KERN_DEBUG DRIVER_NAME ": Error getting resources\n");
-}
-
-static int lis3lv02d_add(struct acpi_device *device)
-{
-	int ret;
-
-	if (!device)
-		return -EINVAL;
-
-	lis3_dev.bus_priv = device;
-	lis3_dev.init = lis3lv02d_acpi_init;
-	lis3_dev.read = lis3lv02d_acpi_read;
-	lis3_dev.write = lis3lv02d_acpi_write;
-	strcpy(acpi_device_name(device), DRIVER_NAME);
-	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
-	device->driver_data = &lis3_dev;
-
-	/* obtain IRQ number of our device from ACPI */
-	lis3lv02d_enum_resources(device);
-
-	/* If possible use a "standard" axes order */
-	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
-		pr_info("Using custom axes %d,%d,%d\n",
-			lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
-	} else if (dmi_check_system(lis3lv02d_dmi_ids) = 0) {
-		pr_info("laptop model unknown, using default axes configuration\n");
-		lis3_dev.ac = lis3lv02d_axis_normal;
-	}
-
-	/* call the core layer do its init */
-	ret = lis3lv02d_init_device(&lis3_dev);
-	if (ret)
-		return ret;
-
-	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
-	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
-	if (ret) {
-		lis3lv02d_joystick_disable();
-		lis3lv02d_poweroff(&lis3_dev);
-		flush_work(&hpled_led.work);
-		return ret;
-	}
-
-	return ret;
-}
-
-static int lis3lv02d_remove(struct acpi_device *device, int type)
-{
-	if (!device)
-		return -EINVAL;
-
-	lis3lv02d_joystick_disable();
-	lis3lv02d_poweroff(&lis3_dev);
-
-	led_classdev_unregister(&hpled_led.led_classdev);
-	flush_work(&hpled_led.work);
-
-	return lis3lv02d_remove_fs(&lis3_dev);
-}
-
-
-#ifdef CONFIG_PM
-static int lis3lv02d_suspend(struct acpi_device *device, pm_message_t state)
-{
-	/* make sure the device is off when we suspend */
-	lis3lv02d_poweroff(&lis3_dev);
-	return 0;
-}
-
-static int lis3lv02d_resume(struct acpi_device *device)
-{
-	lis3lv02d_poweron(&lis3_dev);
-	return 0;
-}
-#else
-#define lis3lv02d_suspend NULL
-#define lis3lv02d_resume NULL
-#endif
-
-/* For the HP MDPS aka 3D Driveguard */
-static struct acpi_driver lis3lv02d_driver = {
-	.name  = DRIVER_NAME,
-	.class = ACPI_MDPS_CLASS,
-	.ids   = lis3lv02d_device_ids,
-	.ops = {
-		.add     = lis3lv02d_add,
-		.remove  = lis3lv02d_remove,
-		.suspend = lis3lv02d_suspend,
-		.resume  = lis3lv02d_resume,
-	}
-};
-
-static int __init lis3lv02d_init_module(void)
-{
-	int ret;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	ret = acpi_bus_register_driver(&lis3lv02d_driver);
-	if (ret < 0)
-		return ret;
-
-	pr_info("driver loaded\n");
-
-	return 0;
-}
-
-static void __exit lis3lv02d_exit_module(void)
-{
-	acpi_bus_unregister_driver(&lis3lv02d_driver);
-}
-
-MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
-MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
-MODULE_LICENSE("GPL");
-
-module_init(lis3lv02d_init_module);
-module_exit(lis3lv02d_exit_module);
-
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/drivers/platform/x86/hp_accel.c	2011-02-20 12:58:24.000000000 +0100
@@ -0,0 +1,405 @@
+/*
+ *  hp_accel.c - Interface between LIS3LV02DL driver and HP ACPI BIOS
+ *
+ *  Copyright (C) 2007-2008 Yan Burman
+ *  Copyright (C) 2008 Eric Piel
+ *  Copyright (C) 2008-2009 Pavel Machek
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/dmi.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/freezer.h>
+#include <linux/uaccess.h>
+#include <linux/leds.h>
+#include <linux/atomic.h>
+#include <acpi/acpi_drivers.h>
+#include "../../hwmon/lis3lv02d.h"
+
+#define DRIVER_NAME     "lis3lv02d"
+#define ACPI_MDPS_CLASS "accelerometer"
+
+/* Delayed LEDs infrastructure ------------------------------------ */
+
+/* Special LED class that can defer work */
+struct delayed_led_classdev {
+	struct led_classdev led_classdev;
+	struct work_struct work;
+	enum led_brightness new_brightness;
+
+	unsigned int led;		/* For driver */
+	void (*set_brightness)(struct delayed_led_classdev *data, enum led_brightness value);
+};
+
+static inline void delayed_set_status_worker(struct work_struct *work)
+{
+	struct delayed_led_classdev *data +			container_of(work, struct delayed_led_classdev, work);
+
+	data->set_brightness(data, data->new_brightness);
+}
+
+static inline void delayed_sysfs_set(struct led_classdev *led_cdev,
+			      enum led_brightness brightness)
+{
+	struct delayed_led_classdev *data = container_of(led_cdev,
+			     struct delayed_led_classdev, led_classdev);
+	data->new_brightness = brightness;
+	schedule_work(&data->work);
+}
+
+/* HP-specific accelerometer driver ------------------------------------ */
+
+/* For automatic insertion of the module */
+static struct acpi_device_id lis3lv02d_device_ids[] = {
+	{"HPQ0004", 0}, /* HP Mobile Data Protection System PNP */
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, lis3lv02d_device_ids);
+
+
+/**
+ * lis3lv02d_acpi_init - ACPI _INI method: initialize the device.
+ * @lis3: pointer to the device struct
+ *
+ * Returns 0 on success.
+ */
+int lis3lv02d_acpi_init(struct lis3lv02d *lis3)
+{
+	struct acpi_device *dev = lis3->bus_priv;
+	if (acpi_evaluate_object(dev->handle, METHOD_NAME__INI,
+				 NULL, NULL) != AE_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * lis3lv02d_acpi_read - ACPI ALRD method: read a register
+ * @lis3: pointer to the device struct
+ * @reg:    the register to read
+ * @ret:    result of the operation
+ *
+ * Returns 0 on success.
+ */
+int lis3lv02d_acpi_read(struct lis3lv02d *lis3, int reg, u8 *ret)
+{
+	struct acpi_device *dev = lis3->bus_priv;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+	unsigned long long lret;
+	acpi_status status;
+
+	arg0.integer.value = reg;
+
+	status = acpi_evaluate_integer(dev->handle, "ALRD", &args, &lret);
+	*ret = lret;
+	return (status != AE_OK) ? -EINVAL : 0;
+}
+
+/**
+ * lis3lv02d_acpi_write - ACPI ALWR method: write to a register
+ * @lis3: pointer to the device struct
+ * @reg:    the register to write to
+ * @val:    the value to write
+ *
+ * Returns 0 on success.
+ */
+int lis3lv02d_acpi_write(struct lis3lv02d *lis3, int reg, u8 val)
+{
+	struct acpi_device *dev = lis3->bus_priv;
+	unsigned long long ret; /* Not used when writting */
+	union acpi_object in_obj[2];
+	struct acpi_object_list args = { 2, in_obj };
+
+	in_obj[0].type          = ACPI_TYPE_INTEGER;
+	in_obj[0].integer.value = reg;
+	in_obj[1].type          = ACPI_TYPE_INTEGER;
+	in_obj[1].integer.value = val;
+
+	if (acpi_evaluate_integer(dev->handle, "ALWR", &args, &ret) != AE_OK)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int lis3lv02d_dmi_matched(const struct dmi_system_id *dmi)
+{
+	lis3_dev.ac = *((union axis_conversion *)dmi->driver_data);
+	pr_info("hardware type %s found\n", dmi->ident);
+
+	return 1;
+}
+
+/* Represents, for each axis seen by userspace, the corresponding hw axis (+1).
+ * If the value is negative, the opposite of the hw value is used. */
+#define DEFINE_CONV(name, x, y, z)			      \
+	static union axis_conversion lis3lv02d_axis_##name = \
+		{ .as_array = { x, y, z } }
+DEFINE_CONV(normal, 1, 2, 3);
+DEFINE_CONV(y_inverted, 1, -2, 3);
+DEFINE_CONV(x_inverted, -1, 2, 3);
+DEFINE_CONV(z_inverted, 1, 2, -3);
+DEFINE_CONV(xy_swap, 2, 1, 3);
+DEFINE_CONV(xy_rotated_left, -2, 1, 3);
+DEFINE_CONV(xy_rotated_left_usd, -2, 1, -3);
+DEFINE_CONV(xy_swap_inverted, -2, -1, 3);
+DEFINE_CONV(xy_rotated_right, 2, -1, 3);
+DEFINE_CONV(xy_swap_yz_inverted, 2, -1, -3);
+
+#define AXIS_DMI_MATCH(_ident, _name, _axis) {		\
+	.ident = _ident,				\
+	.callback = lis3lv02d_dmi_matched,		\
+	.matches = {					\
+		DMI_MATCH(DMI_PRODUCT_NAME, _name)	\
+	},						\
+	.driver_data = &lis3lv02d_axis_##_axis		\
+}
+
+#define AXIS_DMI_MATCH2(_ident, _class1, _name1,	\
+				_class2, _name2,	\
+				_axis) {		\
+	.ident = _ident,				\
+	.callback = lis3lv02d_dmi_matched,		\
+	.matches = {					\
+		DMI_MATCH(DMI_##_class1, _name1),	\
+		DMI_MATCH(DMI_##_class2, _name2),	\
+	},						\
+	.driver_data = &lis3lv02d_axis_##_axis		\
+}
+static struct dmi_system_id lis3lv02d_dmi_ids[] = {
+	/* product names are truncated to match all kinds of a same model */
+	AXIS_DMI_MATCH("NC64x0", "HP Compaq nc64", x_inverted),
+	AXIS_DMI_MATCH("NC84x0", "HP Compaq nc84", z_inverted),
+	AXIS_DMI_MATCH("NX9420", "HP Compaq nx9420", x_inverted),
+	AXIS_DMI_MATCH("NW9440", "HP Compaq nw9440", x_inverted),
+	AXIS_DMI_MATCH("NC2510", "HP Compaq 2510", y_inverted),
+	AXIS_DMI_MATCH("NC2710", "HP Compaq 2710", xy_swap),
+	AXIS_DMI_MATCH("NC8510", "HP Compaq 8510", xy_swap_inverted),
+	AXIS_DMI_MATCH("HP2133", "HP 2133", xy_rotated_left),
+	AXIS_DMI_MATCH("HP2140", "HP 2140", xy_swap_inverted),
+	AXIS_DMI_MATCH("NC653x", "HP Compaq 653", xy_rotated_left_usd),
+	AXIS_DMI_MATCH("NC6730b", "HP Compaq 6730b", xy_rotated_left_usd),
+	AXIS_DMI_MATCH("NC6730s", "HP Compaq 6730s", xy_swap),
+	AXIS_DMI_MATCH("NC651xx", "HP Compaq 651", xy_rotated_right),
+	AXIS_DMI_MATCH("NC6710x", "HP Compaq 6710", xy_swap_yz_inverted),
+	AXIS_DMI_MATCH("NC6715x", "HP Compaq 6715", y_inverted),
+	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 693", xy_rotated_right),
+	AXIS_DMI_MATCH("NC693xx", "HP EliteBook 853", xy_swap),
+	/* Intel-based HP Pavilion dv5 */
+	AXIS_DMI_MATCH2("HPDV5_I",
+			PRODUCT_NAME, "HP Pavilion dv5",
+			BOARD_NAME, "3603",
+			x_inverted),
+	/* AMD-based HP Pavilion dv5 */
+	AXIS_DMI_MATCH2("HPDV5_A",
+			PRODUCT_NAME, "HP Pavilion dv5",
+			BOARD_NAME, "3600",
+			y_inverted),
+	AXIS_DMI_MATCH("DV7", "HP Pavilion dv7", x_inverted),
+	AXIS_DMI_MATCH("HP8710", "HP Compaq 8710", y_inverted),
+	AXIS_DMI_MATCH("HDX18", "HP HDX 18", x_inverted),
+	AXIS_DMI_MATCH("HPB432x", "HP ProBook 432", xy_rotated_left),
+	AXIS_DMI_MATCH("HPB442x", "HP ProBook 442", xy_rotated_left),
+	AXIS_DMI_MATCH("HPB452x", "HP ProBook 452", y_inverted),
+	AXIS_DMI_MATCH("HPB522x", "HP ProBook 522", xy_swap),
+	AXIS_DMI_MATCH("HPB532x", "HP ProBook 532", y_inverted),
+	AXIS_DMI_MATCH("Mini510x", "HP Mini 510", xy_rotated_left_usd),
+	{ NULL, }
+/* Laptop models without axis info (yet):
+ * "NC6910" "HP Compaq 6910"
+ * "NC2400" "HP Compaq nc2400"
+ * "NX74x0" "HP Compaq nx74"
+ * "NX6325" "HP Compaq nx6325"
+ * "NC4400" "HP Compaq nc4400"
+ */
+};
+
+static void hpled_set(struct delayed_led_classdev *led_cdev, enum led_brightness value)
+{
+	struct acpi_device *dev = lis3_dev.bus_priv;
+	unsigned long long ret; /* Not used when writing */
+	union acpi_object in_obj[1];
+	struct acpi_object_list args = { 1, in_obj };
+
+	in_obj[0].type          = ACPI_TYPE_INTEGER;
+	in_obj[0].integer.value = !!value;
+
+	acpi_evaluate_integer(dev->handle, "ALED", &args, &ret);
+}
+
+static struct delayed_led_classdev hpled_led = {
+	.led_classdev = {
+		.name			= "hp::hddprotect",
+		.default_trigger	= "none",
+		.brightness_set		= delayed_sysfs_set,
+		.flags                  = LED_CORE_SUSPENDRESUME,
+	},
+	.set_brightness = hpled_set,
+};
+
+static acpi_status
+lis3lv02d_get_resource(struct acpi_resource *resource, void *context)
+{
+	if (resource->type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
+		struct acpi_resource_extended_irq *irq;
+		u32 *device_irq = context;
+
+		irq = &resource->data.extended_irq;
+		*device_irq = irq->interrupts[0];
+	}
+
+	return AE_OK;
+}
+
+static void lis3lv02d_enum_resources(struct acpi_device *device)
+{
+	acpi_status status;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+					lis3lv02d_get_resource, &lis3_dev.irq);
+	if (ACPI_FAILURE(status))
+		printk(KERN_DEBUG DRIVER_NAME ": Error getting resources\n");
+}
+
+static int lis3lv02d_add(struct acpi_device *device)
+{
+	int ret;
+
+	if (!device)
+		return -EINVAL;
+
+	lis3_dev.bus_priv = device;
+	lis3_dev.init = lis3lv02d_acpi_init;
+	lis3_dev.read = lis3lv02d_acpi_read;
+	lis3_dev.write = lis3lv02d_acpi_write;
+	strcpy(acpi_device_name(device), DRIVER_NAME);
+	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
+	device->driver_data = &lis3_dev;
+
+	/* obtain IRQ number of our device from ACPI */
+	lis3lv02d_enum_resources(device);
+
+	/* If possible use a "standard" axes order */
+	if (lis3_dev.ac.x && lis3_dev.ac.y && lis3_dev.ac.z) {
+		pr_info("Using custom axes %d,%d,%d\n",
+			lis3_dev.ac.x, lis3_dev.ac.y, lis3_dev.ac.z);
+	} else if (dmi_check_system(lis3lv02d_dmi_ids) = 0) {
+		pr_info("laptop model unknown, using default axes configuration\n");
+		lis3_dev.ac = lis3lv02d_axis_normal;
+	}
+
+	/* call the core layer do its init */
+	ret = lis3lv02d_init_device(&lis3_dev);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
+	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
+	if (ret) {
+		lis3lv02d_joystick_disable();
+		lis3lv02d_poweroff(&lis3_dev);
+		flush_work(&hpled_led.work);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int lis3lv02d_remove(struct acpi_device *device, int type)
+{
+	if (!device)
+		return -EINVAL;
+
+	lis3lv02d_joystick_disable();
+	lis3lv02d_poweroff(&lis3_dev);
+
+	led_classdev_unregister(&hpled_led.led_classdev);
+	flush_work(&hpled_led.work);
+
+	return lis3lv02d_remove_fs(&lis3_dev);
+}
+
+
+#ifdef CONFIG_PM
+static int lis3lv02d_suspend(struct acpi_device *device, pm_message_t state)
+{
+	/* make sure the device is off when we suspend */
+	lis3lv02d_poweroff(&lis3_dev);
+	return 0;
+}
+
+static int lis3lv02d_resume(struct acpi_device *device)
+{
+	lis3lv02d_poweron(&lis3_dev);
+	return 0;
+}
+#else
+#define lis3lv02d_suspend NULL
+#define lis3lv02d_resume NULL
+#endif
+
+/* For the HP MDPS aka 3D Driveguard */
+static struct acpi_driver lis3lv02d_driver = {
+	.name  = DRIVER_NAME,
+	.class = ACPI_MDPS_CLASS,
+	.ids   = lis3lv02d_device_ids,
+	.ops = {
+		.add     = lis3lv02d_add,
+		.remove  = lis3lv02d_remove,
+		.suspend = lis3lv02d_suspend,
+		.resume  = lis3lv02d_resume,
+	}
+};
+
+static int __init lis3lv02d_init_module(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	ret = acpi_bus_register_driver(&lis3lv02d_driver);
+	if (ret < 0)
+		return ret;
+
+	pr_info("driver loaded\n");
+
+	return 0;
+}
+
+static void __exit lis3lv02d_exit_module(void)
+{
+	acpi_bus_unregister_driver(&lis3lv02d_driver);
+}
+
+MODULE_DESCRIPTION("Glue between LIS3LV02Dx and HP ACPI BIOS and support for disk protection LED.");
+MODULE_AUTHOR("Yan Burman, Eric Piel, Pavel Machek");
+MODULE_LICENSE("GPL");
+
+module_init(lis3lv02d_init_module);
+module_exit(lis3lv02d_exit_module);
+
--- linux-2.6.38-rc5.orig/drivers/hwmon/Kconfig	2011-02-20 12:58:24.000000000 +0100
+++ linux-2.6.38-rc5/drivers/hwmon/Kconfig	2011-02-20 12:58:24.000000000 +0100
@@ -2,12 +2,6 @@
 # Hardware monitoring chip drivers configuration
 #
 
-config SENSORS_LIS3LV02D
-	tristate
-	depends on INPUT
-	select INPUT_POLLDEV
-	default n
-
 menuconfig HWMON
 	tristate "Hardware Monitoring support"
 	depends on HAS_IOMEM
@@ -1132,40 +1126,6 @@ config SENSORS_ULTRA45
 	  This driver provides support for the Ultra45 workstation environmental
 	  sensors.
 
-config SENSORS_LIS3_SPI
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
-	depends on !ACPI && SPI_MASTER && INPUT
-	select SENSORS_LIS3LV02D
-	default n
-	help
-	  This driver provides support for the LIS3LV02Dx accelerometer connected
-	  via SPI. The accelerometer data is readable via
-	  /sys/devices/platform/lis3lv02d.
-
-	  This driver also provides an absolute input class device, allowing
-	  the laptop to act as a pinball machine-esque joystick.
-
-	  This driver can also be built as modules.  If so, the core module
-	  will be called lis3lv02d and a specific module for the SPI transport
-	  is called lis3lv02d_spi.
-
-config SENSORS_LIS3_I2C
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
-	depends on I2C && INPUT
-	select SENSORS_LIS3LV02D
-	default n
-	help
-	  This driver provides support for the LIS3LV02Dx accelerometer connected
-	  via I2C. The accelerometer data is readable via
-	  /sys/devices/platform/lis3lv02d.
-
-	  This driver also provides an absolute input class device, allowing
-	  the device to act as a pinball machine-esque joystick.
-
-	  This driver can also be built as modules.  If so, the core module
-	  will be called lis3lv02d and a specific module for the I2C transport
-	  is called lis3lv02d_i2c.
-
 config SENSORS_APPLESMC
 	tristate "Apple SMC (Motion sensor, light sensor, keyboard backlight)"
 	depends on INPUT && X86
@@ -1213,25 +1173,6 @@ config SENSORS_ATK0110
 	  This driver can also be built as a module. If so, the module
 	  will be called asus_atk0110.
 
-config HP_ACCEL
-	tristate "HP laptop accelerometer"
-	depends on INPUT
-	select SENSORS_LIS3LV02D
-	select NEW_LEDS
-	select LEDS_CLASS
-	default n
-	help
-	  This driver provides support for the "Mobile Data Protection System 3D"
-	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
-	  should load automatically (via ACPI alias).
-
-	  Support for a led indicating disk protection will be provided as
-	  hp::hddprotect. For more information on the feature, refer to
-	  Documentation/hwmon/lis3lv02d.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called hp_accel.
-
 endif # ACPI
 
 endif # HWMON
--- linux-2.6.38-rc5.orig/drivers/hwmon/Makefile	2011-02-20 12:58:24.000000000 +0100
+++ linux-2.6.38-rc5/drivers/hwmon/Makefile	2011-02-20 12:58:24.000000000 +0100
@@ -10,7 +10,6 @@ obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3l
 
 # APCI drivers
 obj-$(CONFIG_SENSORS_ATK0110)	+= asus_atk0110.o
-obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 
 # Native drivers
 # asb100, then w83781d go first, as they can override other drivers' addresses.
--- linux-2.6.38-rc5.orig/drivers/platform/x86/Kconfig	2011-02-19 16:50:32.000000000 +0100
+++ linux-2.6.38-rc5/drivers/platform/x86/Kconfig	2011-02-20 12:58:24.000000000 +0100
@@ -138,6 +138,24 @@ config TC1100_WMI
 	  This is a driver for the WMI extensions (wireless and bluetooth power
 	  control) of the HP Compaq TC1100 tablet.
 
+config HP_ACCEL
+	tristate "HP laptop accelerometer"
+	depends on INPUT && ACPI
+	select SENSORS_LIS3LV02D
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  This driver provides support for the "Mobile Data Protection System 3D"
+	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
+	  should load automatically (via ACPI alias).
+
+	  Support for a led indicating disk protection will be provided as
+	  hp::hddprotect. For more information on the feature, refer to
+	  Documentation/hwmon/lis3lv02d.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp_accel.
+
 config HP_WMI
 	tristate "HP WMI extras"
 	depends on ACPI_WMI
--- linux-2.6.38-rc5.orig/drivers/platform/x86/Makefile	2011-02-19 16:50:32.000000000 +0100
+++ linux-2.6.38-rc5/drivers/platform/x86/Makefile	2011-02-20 12:58:24.000000000 +0100
@@ -12,6 +12,7 @@ obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop
 obj-$(CONFIG_DELL_WMI)		+= dell-wmi.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
+obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
--- linux-2.6.38-rc5.orig/Documentation/hwmon/hpfall.c	2011-01-05 21:20:44.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,146 +0,0 @@
-/* Disk protection for HP machines.
- *
- * Copyright 2008 Eric Piel
- * Copyright 2009 Pavel Machek <pavel@ucw.cz>
- *
- * GPLv2.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <string.h>
-#include <stdint.h>
-#include <errno.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <sched.h>
-
-char unload_heads_path[64];
-
-int set_unload_heads_path(char *device)
-{
-	char devname[64];
-
-	if (strlen(device) <= 5 || strncmp(device, "/dev/", 5) != 0)
-		return -EINVAL;
-	strncpy(devname, device + 5, sizeof(devname));
-
-	snprintf(unload_heads_path, sizeof(unload_heads_path),
-				"/sys/block/%s/device/unload_heads", devname);
-	return 0;
-}
-int valid_disk(void)
-{
-	int fd = open(unload_heads_path, O_RDONLY);
-	if (fd < 0) {
-		perror(unload_heads_path);
-		return 0;
-	}
-
-	close(fd);
-	return 1;
-}
-
-void write_int(char *path, int i)
-{
-	char buf[1024];
-	int fd = open(path, O_RDWR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
-	sprintf(buf, "%d", i);
-	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
-		perror("write");
-		exit(1);
-	}
-	close(fd);
-}
-
-void set_led(int on)
-{
-	write_int("/sys/class/leds/hp::hddprotect/brightness", on);
-}
-
-void protect(int seconds)
-{
-	write_int(unload_heads_path, seconds*1000);
-}
-
-int on_ac(void)
-{
-//	/sys/class/power_supply/AC0/online
-}
-
-int lid_open(void)
-{
-//	/proc/acpi/button/lid/LID/state
-}
-
-void ignore_me(void)
-{
-	protect(0);
-	set_led(0);
-}
-
-int main(int argc, char **argv)
-{
-	int fd, ret;
-	struct sched_param param;
-
-	if (argc = 1)
-		ret = set_unload_heads_path("/dev/sda");
-	else if (argc = 2)
-		ret = set_unload_heads_path(argv[1]);
-	else
-		ret = -EINVAL;
-
-	if (ret || !valid_disk()) {
-		fprintf(stderr, "usage: %s <device> (default: /dev/sda)\n",
-				argv[0]);
-		exit(1);
-	}
-
-	fd = open("/dev/freefall", O_RDONLY);
-	if (fd < 0) {
-		perror("/dev/freefall");
-		return EXIT_FAILURE;
-	}
-
-	daemon(0, 0);
-	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
-	sched_setscheduler(0, SCHED_FIFO, &param);
-	mlockall(MCL_CURRENT|MCL_FUTURE);
-
-	signal(SIGALRM, ignore_me);
-
-	for (;;) {
-		unsigned char count;
-
-		ret = read(fd, &count, sizeof(count));
-		alarm(0);
-		if ((ret = -1) && (errno = EINTR)) {
-			/* Alarm expired, time to unpark the heads */
-			continue;
-		}
-
-		if (ret != sizeof(count)) {
-			perror("read");
-			break;
-		}
-
-		protect(21);
-		set_led(1);
-		if (1 || on_ac() || lid_open())
-			alarm(2);
-		else
-			alarm(20);
-	}
-
-	close(fd);
-	return EXIT_SUCCESS;
-}
--- linux-2.6.38-rc5.orig/Documentation/hwmon/lis3lv02d	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.38-rc5/Documentation/hwmon/lis3lv02d	2011-02-20 12:59:02.000000000 +0100
@@ -17,8 +17,8 @@ Description
 This driver provides support for the accelerometer found in various HP laptops
 sporting the feature officially called "HP Mobile Data Protection System 3D" or
 "HP 3D DriveGuard". It detects automatically laptops with this sensor. Known
-models (full list can be found in drivers/hwmon/hp_accel.c) will have their
-axis automatically oriented on standard way (eg: you can directly play
+models (full list can be found in drivers/platform/x86/hp_accel.c) will have
+their axis automatically oriented on standard way (eg: you can directly play
 neverball). The accelerometer data is readable via
 /sys/devices/platform/lis3lv02d. Reported values are scaled
 to mg values (1/1000th of earth gravity).
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.38-rc5/Documentation/laptops/hpfall.c	2011-01-05 21:20:44.000000000 +0100
@@ -0,0 +1,146 @@
+/* Disk protection for HP machines.
+ *
+ * Copyright 2008 Eric Piel
+ * Copyright 2009 Pavel Machek <pavel@ucw.cz>
+ *
+ * GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <string.h>
+#include <stdint.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sched.h>
+
+char unload_heads_path[64];
+
+int set_unload_heads_path(char *device)
+{
+	char devname[64];
+
+	if (strlen(device) <= 5 || strncmp(device, "/dev/", 5) != 0)
+		return -EINVAL;
+	strncpy(devname, device + 5, sizeof(devname));
+
+	snprintf(unload_heads_path, sizeof(unload_heads_path),
+				"/sys/block/%s/device/unload_heads", devname);
+	return 0;
+}
+int valid_disk(void)
+{
+	int fd = open(unload_heads_path, O_RDONLY);
+	if (fd < 0) {
+		perror(unload_heads_path);
+		return 0;
+	}
+
+	close(fd);
+	return 1;
+}
+
+void write_int(char *path, int i)
+{
+	char buf[1024];
+	int fd = open(path, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+	sprintf(buf, "%d", i);
+	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
+		perror("write");
+		exit(1);
+	}
+	close(fd);
+}
+
+void set_led(int on)
+{
+	write_int("/sys/class/leds/hp::hddprotect/brightness", on);
+}
+
+void protect(int seconds)
+{
+	write_int(unload_heads_path, seconds*1000);
+}
+
+int on_ac(void)
+{
+//	/sys/class/power_supply/AC0/online
+}
+
+int lid_open(void)
+{
+//	/proc/acpi/button/lid/LID/state
+}
+
+void ignore_me(void)
+{
+	protect(0);
+	set_led(0);
+}
+
+int main(int argc, char **argv)
+{
+	int fd, ret;
+	struct sched_param param;
+
+	if (argc = 1)
+		ret = set_unload_heads_path("/dev/sda");
+	else if (argc = 2)
+		ret = set_unload_heads_path(argv[1]);
+	else
+		ret = -EINVAL;
+
+	if (ret || !valid_disk()) {
+		fprintf(stderr, "usage: %s <device> (default: /dev/sda)\n",
+				argv[0]);
+		exit(1);
+	}
+
+	fd = open("/dev/freefall", O_RDONLY);
+	if (fd < 0) {
+		perror("/dev/freefall");
+		return EXIT_FAILURE;
+	}
+
+	daemon(0, 0);
+	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	sched_setscheduler(0, SCHED_FIFO, &param);
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	signal(SIGALRM, ignore_me);
+
+	for (;;) {
+		unsigned char count;
+
+		ret = read(fd, &count, sizeof(count));
+		alarm(0);
+		if ((ret = -1) && (errno = EINTR)) {
+			/* Alarm expired, time to unpark the heads */
+			continue;
+		}
+
+		if (ret != sizeof(count)) {
+			perror("read");
+			break;
+		}
+
+		protect(21);
+		set_led(1);
+		if (1 || on_ac() || lid_open())
+			alarm(2);
+		else
+			alarm(20);
+	}
+
+	close(fd);
+	return EXIT_SUCCESS;
+}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
