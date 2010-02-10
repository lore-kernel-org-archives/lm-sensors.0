From: Rodolfo Giometti <giometti@linux.it>
Date: Wed, 10 Feb 2010 12:18:33 +0000
Subject: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support
Message-Id: <1265804313-28132-1-git-send-email-giometti@linux.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The drivers has been splitted up into two parts:

* drivers/mfd/w83627hf-core.c 	   - detects the chip and define proper
  				     platform devices into mfd support

* drivers/hwmon/w83627hf.c	   - implements the driver for hwmon
  				     functionality only

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
---

Jean, can you please take a look at this patch? It should apply over
your last patch.

If everything is ok I'm going to produce GPIO support too.

Rodolfo

 drivers/hwmon/Kconfig        |    1 +
 drivers/hwmon/w83627hf.c     |  374 ++++++++++++------------------------------
 drivers/mfd/Kconfig          |   15 ++
 drivers/mfd/Makefile         |    1 +
 drivers/mfd/w83627hf-core.c  |  186 +++++++++++++++++++++
 include/linux/mfd/w83627hf.h |  118 +++++++++++++
 6 files changed, 427 insertions(+), 268 deletions(-)
 create mode 100644 drivers/mfd/w83627hf-core.c
 create mode 100644 include/linux/mfd/w83627hf.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 700e93a..3d9b883 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -892,6 +892,7 @@ config SENSORS_W83L786NG
 
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	select MFD_W83627HF
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 2be28ac..811011e 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -6,6 +6,8 @@
     and Mark Studebaker <mdsxyz123@yahoo.com>
     Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
     Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
+    MFD support added by Rodolfo Giometti <giometti@linux.it>
+    Copyright (c) 2010 Rodolfo Giometti <giometti@linux.it>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -52,13 +54,11 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <asm/io.h>
+#include <linux/mfd/w83627hf.h>
 #include "lm75.h"
 
 static struct platform_device *pdev;
 
-#define DRVNAME "w83627hf"
-enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
-
 static u16 force_addr;
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
@@ -72,88 +72,8 @@ static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
-static unsigned short force_id;
-module_param(force_id, ushort, 0);
-MODULE_PARM_DESC(force_id, "Override the detected device ID");
-
-/* modified from kernel/include/traps.c */
-static int REG;		/* The register to read/write */
-#define	DEV	0x07	/* Register: Logical device select */
-static int VAL;		/* The value to read/write */
-
-/* logical device numbers for superio_select (below) */
-#define W83627HF_LD_FDC		0x00
-#define W83627HF_LD_PRT		0x01
-#define W83627HF_LD_UART1	0x02
-#define W83627HF_LD_UART2	0x03
-#define W83627HF_LD_KBC		0x05
-#define W83627HF_LD_CIR		0x06 /* w83627hf only */
-#define W83627HF_LD_GAME	0x07
-#define W83627HF_LD_MIDI	0x07
-#define W83627HF_LD_GPIO1	0x07
-#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
-#define W83627HF_LD_GPIO2	0x08
-#define W83627HF_LD_GPIO3	0x09
-#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
-#define W83627HF_LD_ACPI	0x0a
-#define W83627HF_LD_HWM		0x0b
-
-#define	DEVID	0x20	/* Register: Device ID */
-
-#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
-#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
-#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
-
-#define W83687THF_VID_EN	0x29 /* w83687thf only */
-#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
-#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
-
-static inline void
-superio_outb(int reg, int val)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
-static inline int
-superio_inb(int reg)
-{
-	outb(reg, REG);
-	return inb(VAL);
-}
-
-static inline void
-superio_select(int ld)
-{
-	outb(DEV, REG);
-	outb(ld, VAL);
-}
-
-static inline void
-superio_enter(void)
-{
-	outb(0x87, REG);
-	outb(0x87, REG);
-}
-
-static inline void
-superio_exit(void)
-{
-	outb(0xAA, REG);
-}
-
-#define W627_DEVID 0x52
-#define W627THF_DEVID 0x82
-#define W697_DEVID 0x60
-#define W637_DEVID 0x70
-#define W687THF_DEVID 0x85
-#define WINB_ACT_REG 0x30
-#define WINB_BASE_REG 0x60
 /* Constants specified below */
 
-/* Alignment of the base address */
-#define WINB_ALIGNMENT		~7
-
 /* Offset & size of I/O region we are interested in */
 #define WINB_REGION_OFFSET	5
 #define WINB_REGION_SIZE	2
@@ -380,10 +300,6 @@ struct w83627hf_data {
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
 
-struct w83627hf_sio_data {
-	enum chips type;
-};
-
 
 static int w83627hf_probe(struct platform_device *pdev);
 static int __devexit w83627hf_remove(struct platform_device *pdev);
@@ -397,7 +313,7 @@ static void w83627hf_init_device(struct platform_device *pdev);
 static struct platform_driver w83627hf_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
-		.name	= DRVNAME,
+		.name	= DRVNAME "_hwmon",
 	},
 	.probe		= w83627hf_probe,
 	.remove		= __devexit_p(w83627hf_remove),
@@ -1126,80 +1042,6 @@ show_name(struct device *dev, struct device_attribute *devattr, char *buf)
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static int __init w83627hf_find(int sioaddr, unsigned short *addr,
-				struct w83627hf_sio_data *sio_data)
-{
-	int err = -ENODEV;
-	u16 val;
-
-	static const __initdata char *names[] = {
-		"W83627HF",
-		"W83627THF",
-		"W83697HF",
-		"W83637HF",
-		"W83687THF",
-	};
-
-	REG = sioaddr;
-	VAL = sioaddr + 1;
-
-	superio_enter();
-	val = force_id ? force_id : superio_inb(DEVID);
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
-	superio_select(W83627HF_LD_HWM);
-	force_addr &= WINB_ALIGNMENT;
-	if (force_addr) {
-		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
-		       force_addr);
-		superio_outb(WINB_BASE_REG, force_addr >> 8);
-		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
-	}
-	val = (superio_inb(WINB_BASE_REG) << 8) |
-	       superio_inb(WINB_BASE_REG + 1);
-	*addr = val & WINB_ALIGNMENT;
-	if (*addr = 0) {
-		printk(KERN_WARNING DRVNAME ": Base address not set, "
-		       "skipping\n");
-		goto exit;
-	}
-
-	val = superio_inb(WINB_ACT_REG);
-	if (!(val & 0x01)) {
-		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
-		superio_outb(WINB_ACT_REG, val | 0x01);
-	}
-
-	err = 0;
-	pr_info(DRVNAME ": Found %s chip at %#x\n",
-		names[sio_data->type], *addr);
-
- exit:
-	superio_exit();
-	return err;
-}
-
 #define VIN_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
 	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
@@ -1278,27 +1120,89 @@ static const struct attribute_group w83627hf_group_opt = {
 	.attrs = w83627hf_attributes_opt,
 };
 
+static int w83627hf_enable_hwmon(struct w83627hf_sio_data *sio_data)
+{
+	u16 val;
+	int ret;
+
+	superio_enter(sio_data);
+
+	superio_select(sio_data, W83627HF_LD_HWM);
+
+	force_addr &= (~7);
+	if (force_addr) {
+		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
+			force_addr);
+		superio_outb(sio_data, 0x60, force_addr >> 8);
+		superio_outb(sio_data, 0x60 + 1, force_addr & 0xff);
+	}
+
+	val = (superio_inb(sio_data, 0x60) << 8) |
+	       superio_inb(sio_data, 0x60 + 1);
+	ret = val & (~7);
+	pr_info(DRVNAME ": hwmon chip %s at %#x\n", sio_data->name, ret);
+
+	if (ret = 0) {
+		printk(KERN_WARNING DRVNAME ": Base address not set, "
+		       "skipping\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	val = superio_inb(sio_data, 0x30);
+	superio_outb(sio_data, 0x30, val | 0x01);
+
+exit:
+	superio_exit(sio_data);
+
+	return ret;
+}
+
+static void w83627hf_disable_hwmon(struct w83627hf_sio_data *sio_data)
+{
+	u16 val;
+
+	superio_enter(sio_data);
+
+	superio_select(sio_data, W83627HF_LD_HWM);
+
+	val = superio_inb(sio_data, 0x30);
+	superio_outb(sio_data, 0x30, val & ~0x01);
+
+	superio_exit(sio_data);
+}
+
 static int __devinit w83627hf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct w83627hf_sio_data *sio_data = dev->platform_data;
+	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
 	struct w83627hf_data *data;
-	struct resource *res;
 	int err, i;
 
-	static const char *names[] = {
-		"w83627hf",
-		"w83627thf",
-		"w83697hf",
-		"w83637hf",
-		"w83687thf",
+	struct resource res = {
+		.start  = /* address + */ WINB_REGION_OFFSET,
+		.end    = /* address + */ WINB_REGION_OFFSET +
+						WINB_REGION_SIZE - 1,
+		.name   = DRVNAME "_hwmon",
+		.flags  = IORESOURCE_IO,
 	};
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, WINB_REGION_SIZE, DRVNAME)) {
+	err = w83627hf_enable_hwmon(sio_data);
+	if (err < 0)
+		return err;
+
+	/* Before doing our job we should fixup ioport range */
+	res.start += err;
+	res.end += err;
+
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto ERROR0;
+
+	if (!request_region(res.start, WINB_REGION_SIZE, DRVNAME "_hwmon")) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
-			(unsigned long)res->start,
-			(unsigned long)(res->start + WINB_REGION_SIZE - 1));
+			(unsigned long) res.start,
+			(unsigned long) (res.start + WINB_REGION_SIZE - 1));
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -1307,9 +1211,9 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	data->addr = res->start;
+	data->addr = res.start;
 	data->type = sio_data->type;
-	data->name = names[sio_data->type];
+	data->name = sio_data->name;
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
@@ -1442,15 +1346,20 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
       ERROR1:
-	release_region(res->start, WINB_REGION_SIZE);
+	release_region(res.start, WINB_REGION_SIZE);
       ERROR0:
+	w83627hf_disable_hwmon(sio_data);
 	return err;
 }
 
 static int __devexit w83627hf_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
+	unsigned int addr = data->addr;
+
+	w83627hf_disable_hwmon(sio_data);
 
 	hwmon_device_unregister(data->hwmon_dev);
 
@@ -1459,8 +1368,7 @@ static int __devexit w83627hf_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, WINB_REGION_SIZE);
+	release_region(addr, WINB_REGION_SIZE);
 
 	return 0;
 }
@@ -1511,20 +1419,22 @@ static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 
 static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
 	int res = 0xff, sel;
 
-	superio_enter();
-	superio_select(W83627HF_LD_GPIO5);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_GPIO5);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
 		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
-	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
+	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
 		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
 			"function\n");
@@ -1532,37 +1442,39 @@ static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
-	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
 
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
 
 static int __devinit w83687thf_read_vid(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
 	int res = 0xff;
 
-	superio_enter();
-	superio_select(W83627HF_LD_HWM);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_HWM);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
 		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input */
-	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
 		dev_dbg(&pdev->dev, "VID configured as output, "
 			"no VID function\n");
 		goto exit;
 	}
 
-	res = superio_inb(W83687THF_VID_DATA) & 0x3f;
+	res = superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
 
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
 
@@ -1783,94 +1695,20 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
 	return data;
 }
 
-static int __init w83627hf_device_add(unsigned short address,
-				      const struct w83627hf_sio_data *sio_data)
-{
-	struct resource res = {
-		.start	= address + WINB_REGION_OFFSET,
-		.end	= address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
-		.name	= DRVNAME,
-		.flags	= IORESOURCE_IO,
-	};
-	int err;
-
-	err = acpi_check_resource_conflict(&res);
-	if (err)
-		goto exit;
-
-	pdev = platform_device_alloc(DRVNAME, address);
-	if (!pdev) {
-		err = -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
-		goto exit;
-	}
-
-	err = platform_device_add_resources(pdev, &res, 1);
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed "
-		       "(%d)\n", err);
-		goto exit_device_put;
-	}
-
-	err = platform_device_add_data(pdev, sio_data,
-				       sizeof(struct w83627hf_sio_data));
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
-		goto exit_device_put;
-	}
-
-	err = platform_device_add(pdev);
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
-		       err);
-		goto exit_device_put;
-	}
-
-	return 0;
-
-exit_device_put:
-	platform_device_put(pdev);
-exit:
-	return err;
-}
-
 static int __init sensors_w83627hf_init(void)
 {
-	int err;
-	unsigned short address;
-	struct w83627hf_sio_data sio_data;
-
-	if (w83627hf_find(0x2e, &address, &sio_data)
-	 && w83627hf_find(0x4e, &address, &sio_data))
-		return -ENODEV;
-
-	err = platform_driver_register(&w83627hf_driver);
-	if (err)
-		goto exit;
-
-	/* Sets global pdev as a side effect */
-	err = w83627hf_device_add(address, &sio_data);
-	if (err)
-		goto exit_driver;
-
-	return 0;
-
-exit_driver:
-	platform_driver_unregister(&w83627hf_driver);
-exit:
-	return err;
+	return platform_driver_register(&w83627hf_driver);
 }
 
 static void __exit sensors_w83627hf_exit(void)
 {
-	platform_device_unregister(pdev);
 	platform_driver_unregister(&w83627hf_driver);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
 	      "Philip Edelbrock <phil@netroedge.com>, "
 	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
-MODULE_DESCRIPTION("W83627HF driver");
+MODULE_DESCRIPTION("W83627HF hwmon driver");
 MODULE_LICENSE("GPL");
 
 module_init(sensors_w83627hf_init);
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 570be13..1c875ed 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -305,6 +305,21 @@ config EZX_PCAP
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..
 
+config MFD_W83627HF
+	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on MFD_CORE
+	help
+	  If you say yes here you add support for the Winbond W836X7 series
+	  of super-IO chips: the W83627HF, W83627THF, W83637HF, W83687THF and
+	  W83697HF to your platform.
+
+	  This is a multi functional device and this support defines a new
+	  platform device only. See other configuration submenus in order to
+	  enable the drivers of Winbond chip's functionalities.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83627hf-core.
+
 endmenu
 
 menu "Multimedia Capabilities Port drivers"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f3b277b..1b25d37 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MFD_MC13783)	+= mc13783-core.o
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
+obj-$(CONFIG_MFD_W83627HF)	+= w83627hf-core.o
 
 obj-$(CONFIG_MCP)		+= mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
diff --git a/drivers/mfd/w83627hf-core.c b/drivers/mfd/w83627hf-core.c
new file mode 100644
index 0000000..e70e15e
--- /dev/null
+++ b/drivers/mfd/w83627hf-core.c
@@ -0,0 +1,186 @@
+/*
+ *  w83627hf.c - platform device support
+ *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
+ *
+ *  Based on drivers/hwmon/w83627hf.c
+ *
+ *  Original copyright note:
+ *    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
+ *    Philip Edelbrock <phil@netroedge.com>,
+ *    and Mark Studebaker <mdsxyz123@yahoo.com>
+ *    Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
+ *    Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/ioport.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/w83627hf.h>
+
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Override the detected device ID");
+
+/*
+ * Devices definitions
+ */
+
+static struct platform_device *pdev;
+
+static char *names[] = {
+	"w83627hf",
+	"w83627thf",
+	"w83697hf",
+	"w83637hf",
+	"w83687thf",
+};
+
+static struct mfd_cell cells[] = {
+	{
+		.name		= DRVNAME "_hwmon",
+	},
+};
+
+#define W627_DEVID		0x52
+#define W627THF_DEVID		0x82
+#define W697_DEVID		0x60
+#define W637_DEVID		0x70
+#define W687THF_DEVID		0x85
+
+static int __init w83627hf_find(int sioaddr, struct w83627hf_sio_data *sio_data)
+{
+	int err = -ENODEV;
+	u16 val;
+
+	sio_data->sioaddr = sioaddr;
+
+	superio_enter(sio_data);
+
+	val = force_id ? force_id : superio_inb(sio_data, 0x20);
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
+	err = 0;
+	sio_data->name = names[sio_data->type];
+
+	pr_info(DRVNAME ": Found %s chip at %#x\n", sio_data->name, sioaddr);
+
+exit:
+	superio_exit(sio_data);
+
+	return err;
+}
+
+static int __init w83627hf_device_add(const struct w83627hf_sio_data *sio_data)
+{
+	int err;
+
+	pdev = platform_device_alloc(DRVNAME, 0);
+	if (!pdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct w83627hf_sio_data));
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
+	err = mfd_add_devices(&pdev->dev, pdev->id, cells, ARRAY_SIZE(cells),
+			0, -1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Cannot add sub devices (%d)\n",
+			err);
+		goto exit_device_unregister;
+	}
+
+	return 0;
+
+exit_device_unregister:
+	platform_device_unregister(pdev);
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	return err;
+}
+
+static int __init w83627hf_init(void)
+{
+	struct w83627hf_sio_data sio_data;
+	int ret;
+
+	mutex_init(&sio_data.lock);
+
+	ret = w83627hf_find(0x2e, &sio_data);
+	if (ret) {
+		ret = w83627hf_find(0x4e, &sio_data);
+		if (ret)
+			return -ENODEV;
+	}
+
+	/* Sets global pdev as a side effect */
+	return w83627hf_device_add(&sio_data);
+}
+
+static void __exit w83627hf_exit(void)
+{
+	mfd_remove_devices(&pdev->dev);
+	platform_device_unregister(pdev);
+}
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
+MODULE_DESCRIPTION("W83627HF platform devices definitions");
+MODULE_LICENSE("GPL");
+
+module_init(w83627hf_init);
+module_exit(w83627hf_exit);
diff --git a/include/linux/mfd/w83627hf.h b/include/linux/mfd/w83627hf.h
new file mode 100644
index 0000000..5f4200b
--- /dev/null
+++ b/include/linux/mfd/w83627hf.h
@@ -0,0 +1,118 @@
+/*
+ *  w83627hf.h - platform device support, header file
+ *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
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
+#include <linux/mutex.h>
+#include <linux/io.h>
+
+#define DRVNAME "w83627hf"
+
+enum chips {
+	w83627hf,
+	w83627thf,
+	w83697hf,
+	w83637hf,
+	w83687thf
+};
+
+struct w83627hf_sio_data {
+	int sioaddr;
+	enum chips type;
+	char *name;
+
+	struct mutex lock;
+};
+
+/* logical device numbers for superio_select (below) */
+#define W83627HF_LD_FDC		0x00
+#define W83627HF_LD_PRT		0x01
+#define W83627HF_LD_UART1	0x02
+#define W83627HF_LD_UART2	0x03
+#define W83627HF_LD_KBC		0x05
+#define W83627HF_LD_CIR		0x06 /* w83627hf only */
+#define W83627HF_LD_GAME	0x07
+#define W83627HF_LD_MIDI	0x07
+#define W83627HF_LD_GPIO1	0x07
+#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
+#define W83627HF_LD_GPIO2	0x08
+#define W83627HF_LD_GPIO3	0x09
+#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
+#define W83627HF_LD_ACPI	0x0a
+#define W83627HF_LD_HWM		0x0b
+
+#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
+#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
+#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
+
+#define W83687THF_VID_EN	0x29 /* w83687thf only */
+#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
+#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
+
+/*
+ * Common configuration registers access functions.
+ *
+ * These registers are special and they must me accessed by using a well
+ * specified protocol. Client drivers __must__ do as follow in order to
+ * get access correctly to these registers:
+ *
+ *	superio_enter()
+ *
+ *	superio_select()/superio_outb()/superio_inb()
+ *
+ *	superio_exit();
+ *
+ */
+
+static inline void superio_enter(struct w83627hf_sio_data *sio)
+{
+	mutex_lock(&sio->lock);
+
+	outb(0x87, sio->sioaddr);
+	outb(0x87, sio->sioaddr);
+}
+
+static inline void superio_select(struct w83627hf_sio_data *sio, int ld)
+{
+	WARN_ON(!mutex_is_locked(&sio->lock));
+
+	outb(0x07, sio->sioaddr);
+	outb(ld, sio->sioaddr + 1);
+}
+
+static inline void superio_outb(struct w83627hf_sio_data *sio, int reg, int val)
+{
+	WARN_ON(!mutex_is_locked(&sio->lock));
+
+	outb(reg, sio->sioaddr);
+	outb(val, sio->sioaddr + 1);
+}
+
+static inline int superio_inb(struct w83627hf_sio_data *sio, int reg)
+{
+	WARN_ON(!mutex_is_locked(&sio->lock));
+
+	outb(reg, sio->sioaddr);
+	return inb(sio->sioaddr + 1);
+}
+
+static inline void superio_exit(struct w83627hf_sio_data *sio)
+{
+	outb(0xAA, sio->sioaddr);
+
+	mutex_unlock(&sio->lock);
+}
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
