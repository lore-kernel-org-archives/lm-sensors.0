From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 13:50:00 +0000
Subject: [lm-sensors] [PATCH 1/8] mfd: Add Dialog DA906x core driver.
Message-Id: <201208241450@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241445@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241445@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

This is MFD module providing access to registers and interrupts of DA906x
series PMIC. It is used by other functional modules, registered as MFD cells.
Driver uses regmap with paging to access extended register list. Register map
is divided into two pages, where the second page is used during initialisation.

This module provides support to following functional cells:
 - Regulators
 - RTC
 - HWMON
 - OnKey (power key misc input device)
 - Vibration (force-feedback input device)
 - Watchdog
 - LEDs

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/mfd/Kconfig                  |   11 +
 drivers/mfd/Makefile                 |    4 +
 drivers/mfd/da906x-core.c            |  228 +++++++
 drivers/mfd/da906x-i2c.c             |  389 ++++++++++++
 drivers/mfd/da906x-irq.c             |  192 ++++++
 include/linux/mfd/da906x/core.h      |  121 ++++
 include/linux/mfd/da906x/pdata.h     |  114 ++++
 include/linux/mfd/da906x/registers.h | 1093 ++++++++++++++++++++++++++++++++++
 8 files changed, 2152 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/da906x-core.c
 create mode 100644 drivers/mfd/da906x-i2c.c
 create mode 100644 drivers/mfd/da906x-irq.c
 create mode 100644 include/linux/mfd/da906x/core.h
 create mode 100644 include/linux/mfd/da906x/pdata.h
 create mode 100644 include/linux/mfd/da906x/registers.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b1a1462..bf2a766 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -441,6 +441,17 @@ config MFD_DA9052_I2C
 	  for accessing the device, additional drivers must be enabled in
 	  order to use the functionality of the device.
 
+config MFD_DA906X
+	bool "Dialog Semiconductor DA906X PMIC Support"
+	depends on I2C=y
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Support for the Dialog Semiconductor DA906X PMIC. This includes
+	  I2C driver and core APIs, additional drivers must be enabled in
+	  order to use the functionality of the device.
+
 config PMIC_ADP5520
 	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
 	depends on I2C=y
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 79dd22d..f5a8432 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -90,8 +90,12 @@ obj-$(CONFIG_PMIC_DA9052)	+= da9052-core.o
 obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
 obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
 
+da906x-objs			:= da906x-core.o da906x-irq.o da906x-i2c.o
+obj-$(CONFIG_MFD_DA906X)	+= da906x.o
+
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o max77686-irq.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o max77693-irq.o
+
 max8925-objs			:= max8925-core.o max8925-i2c.o
 obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
 obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
diff --git a/drivers/mfd/da906x-core.c b/drivers/mfd/da906x-core.c
new file mode 100644
index 0000000..fb3249f
--- /dev/null
+++ b/drivers/mfd/da906x-core.c
@@ -0,0 +1,228 @@
+/*
+ * da906x-core.c: Device access for Dialog DA906x modules
+ *
+ * Copyright 2012 Dialog Semiconductors Ltd.
+ *
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
+ *         Michal Hajduk <michal.hajduk@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/mfd/core.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+#include <linux/mfd/da906x/registers.h>
+
+#include <linux/proc_fs.h>
+#include <linux/kthread.h>
+#include <linux/uaccess.h>
+
+
+static struct resource da906x_regulators_resources[] = {
+	{
+		.name	= "LDO_LIM",
+		.start	= DA906X_IRQ_LDO_LIM,
+		.end	= DA906X_IRQ_LDO_LIM,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource da906x_rtc_resources[] = {
+	{
+		.name	= "ALARM",
+		.start	= DA906X_IRQ_ALARM,
+		.end	= DA906X_IRQ_ALARM,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "TICK",
+		.start	= DA906X_IRQ_TICK,
+		.end	= DA906X_IRQ_TICK,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource da906x_onkey_resources[] = {
+	{
+		.start	= DA906X_IRQ_ONKEY,
+		.end	= DA906X_IRQ_ONKEY,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource da906x_hwmon_resources[] = {
+	{
+		.start	= DA906X_IRQ_ADC_RDY,
+		.end	= DA906X_IRQ_ADC_RDY,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+
+static struct mfd_cell da906x_devs[] = {
+	{
+		.name		= DA906X_DRVNAME_REGULATORS,
+		.num_resources	= ARRAY_SIZE(da906x_regulators_resources),
+		.resources	= da906x_regulators_resources,
+	},
+	{
+		.name		= DA906X_DRVNAME_LEDS,
+	},
+	{
+		.name		= DA906X_DRVNAME_WATCHDOG,
+	},
+	{
+		.name		= DA906X_DRVNAME_HWMON,
+		.num_resources	= ARRAY_SIZE(da906x_hwmon_resources),
+		.resources	= da906x_hwmon_resources,
+	},
+	{
+		.name		= DA906X_DRVNAME_ONKEY,
+		.num_resources	= ARRAY_SIZE(da906x_onkey_resources),
+		.resources	= da906x_onkey_resources,
+	},
+	{
+		.name		= DA906X_DRVNAME_RTC,
+		.num_resources	= ARRAY_SIZE(da906x_rtc_resources),
+		.resources	= da906x_rtc_resources,
+	},
+	{
+		.name		= DA906X_DRVNAME_VIBRATION,
+	},
+};
+
+inline unsigned int da906x_to_range_reg(u16 reg)
+{
+	return reg + DA906X_MAPPING_BASE;
+}
+
+int da906x_reg_read(struct da906x *da906x, u16 reg)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(da906x->regmap, da906x_to_range_reg(reg), &val);
+	if (ret < 0)
+		return ret;
+
+	return val;
+}
+
+int da906x_reg_write(struct da906x *da906x, u16 reg, u8 val)
+{
+	return regmap_write(da906x->regmap, da906x_to_range_reg(reg), val);
+}
+
+int da906x_block_read(struct da906x *da906x, u16 reg, int bytes, u8 *dst)
+{
+	return regmap_bulk_read(da906x->regmap, da906x_to_range_reg(reg),
+				dst, bytes);
+}
+
+int da906x_block_write(struct da906x *da906x, u16 reg, int bytes, const u8 *src)
+{
+	return regmap_bulk_write(da906x->regmap, da906x_to_range_reg(reg),
+				 src, bytes);
+}
+
+int da906x_reg_update(struct da906x *da906x, u16 reg, u8 mask, u8 val)
+{
+	return regmap_update_bits(da906x->regmap, da906x_to_range_reg(reg),
+				  mask, val);
+}
+
+int da906x_reg_set_bits(struct da906x *da906x, u16 reg, u8 mask)
+{
+	return da906x_reg_update(da906x, reg, mask, mask);
+}
+
+int da906x_reg_clear_bits(struct da906x *da906x, u16 reg, u8 mask)
+{
+	return da906x_reg_update(da906x, reg, mask, 0);
+}
+
+int da906x_device_init(struct da906x *da906x, unsigned int irq)
+{
+	struct da906x_pdata *pdata = da906x->dev->platform_data;
+	int ret = 0;
+	int model;
+	unsigned short revision;
+
+	mutex_init(&da906x->io_mutex);
+
+	if (pdata = NULL) {
+		dev_err(da906x->dev, "Platform data not specified.\n");
+		return -EINVAL;
+	}
+	da906x->flags = pdata->flags;
+	da906x->irq_base = pdata->irq_base;
+	da906x->chip_irq = irq;
+
+	if (pdata->init != NULL) {
+		ret = pdata->init(da906x);
+		if (ret != 0) {
+			dev_err(da906x->dev,
+				"Platform initialization failed.\n");
+			return ret;
+		}
+	}
+
+	model = da906x_reg_read(da906x, DA906X_REG_CHIP_ID);
+	if (model < 0) {
+		dev_err(da906x->dev, "Cannot read chip model id.\n");
+		return -EIO;
+	}
+
+	ret = da906x_reg_read(da906x, DA906X_REG_CHIP_VARIANT);
+	if (ret < 0) {
+		dev_err(da906x->dev, "Cannot read chip revision id.\n");
+		return -EIO;
+	}
+
+	revision = ret >> DA906X_CHIP_VARIANT_SHIFT;
+
+	da906x_set_model_rev(da906x, model, revision);
+
+	dev_info(da906x->dev,
+		 "Device detected (model-ID: 0x%02X  rev-ID: 0x%02X)\n",
+		 model, revision);
+
+	ret = da906x_irq_init(da906x);
+	if (ret) {
+		dev_err(da906x->dev, "Cannot initialize interrupts.\n");
+		return ret;
+	}
+
+	ret = mfd_add_devices(da906x->dev, -1, da906x_devs,
+			      ARRAY_SIZE(da906x_devs), NULL, da906x->irq_base);
+	if (ret)
+		dev_err(da906x->dev, "Cannot add MFD cells\n");
+
+	return ret;
+}
+
+void da906x_device_exit(struct da906x *da906x)
+{
+	mfd_remove_devices(da906x->dev);
+	da906x_irq_exit(da906x);
+}
+
+MODULE_DESCRIPTION("PMIC driver for Dialog DA906X");
+MODULE_AUTHOR("Krystian Garbaciak <krystian.garbaciak@diasemi.com>, Michal Hajduk <michal.hajduk@diasemi.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DA906X_DRVNAME_CORE);
diff --git a/drivers/mfd/da906x-i2c.c b/drivers/mfd/da906x-i2c.c
new file mode 100644
index 0000000..90b9e23
--- /dev/null
+++ b/drivers/mfd/da906x-i2c.c
@@ -0,0 +1,389 @@
+/* da906x-i2c.c: Interrupt support for Dialog DA906x
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+#include <linux/mfd/da906x/registers.h>
+
+
+#define RD		0x01	/* Readable register */
+#define WR		0x02	/* Writable register */
+#define VOL		0x04	/* Volatile register */
+
+/* Flags for virtual registers (mapped starting from DA906X_MAPPING_BASE) */
+const unsigned char da906x_reg_flg[] = {
+	[DA906X_REG_STATUS_A] =		RD | VOL,
+	[DA906X_REG_STATUS_B] =		RD | VOL,
+	[DA906X_REG_STATUS_C] =		RD | VOL,
+	[DA906X_REG_STATUS_D] =		RD | VOL,
+	[DA906X_REG_FAULT_LOG] =	RD | WR | VOL,
+	[DA906X_REG_EVENT_A] =		RD | WR | VOL,
+	[DA906X_REG_EVENT_B] =		RD | WR | VOL,
+	[DA906X_REG_EVENT_C] =		RD | WR | VOL,
+	[DA906X_REG_EVENT_D] =		RD | WR | VOL,
+	[DA906X_REG_IRQ_MASK_A] =	RD | WR,
+	[DA906X_REG_IRQ_MASK_B] =	RD | WR,
+	[DA906X_REG_IRQ_MASK_C] =	RD | WR,
+	[DA906X_REG_IRQ_MASK_D] =	RD | WR,
+	[DA906X_REG_CONTROL_A] =	RD | WR,
+	[DA906X_REG_CONTROL_B] =	RD | WR,
+	[DA906X_REG_CONTROL_C] =	RD | WR,
+	[DA906X_REG_CONTROL_D] =	RD | WR,
+	[DA906X_REG_CONTROL_E] =	RD | WR,
+	[DA906X_REG_CONTROL_F] =	RD | WR | VOL,
+	[DA906X_REG_PD_DIS] =		RD | WR,
+
+	[DA906X_REG_GPIO_0_1] =		RD | WR,
+	[DA906X_REG_GPIO_2_3] =		RD | WR,
+	[DA906X_REG_GPIO_4_5] =		RD | WR,
+	[DA906X_REG_GPIO_6_7] =		RD | WR,
+	[DA906X_REG_GPIO_8_9] =		RD | WR,
+	[DA906X_REG_GPIO_10_11] =	RD | WR,
+	[DA906X_REG_GPIO_12_13] =	RD | WR,
+	[DA906X_REG_GPIO_14_15] =	RD | WR,
+	[DA906X_REG_GPIO_MODE_0_7] =	RD | WR,
+	[DA906X_REG_GPIO_MODE_8_15] =	RD | WR,
+	[DA906X_REG_GPIO_SWITCH_CONT] =	RD | WR,
+
+	[DA906X_REG_BCORE2_CONT] =	RD | WR,
+	[DA906X_REG_BCORE1_CONT] =	RD | WR,
+	[DA906X_REG_BPRO_CONT] =	RD | WR,
+	[DA906X_REG_BMEM_CONT] =	RD | WR,
+	[DA906X_REG_BIO_CONT] =		RD | WR,
+	[DA906X_REG_BPERI_CONT] =	RD | WR,
+	[DA906X_REG_LDO1_CONT] =	RD | WR,
+	[DA906X_REG_LDO2_CONT] =	RD | WR,
+	[DA906X_REG_LDO3_CONT] =	RD | WR,
+	[DA906X_REG_LDO4_CONT] =	RD | WR,
+	[DA906X_REG_LDO5_CONT] =	RD | WR,
+	[DA906X_REG_LDO6_CONT] =	RD | WR,
+	[DA906X_REG_LDO7_CONT] =	RD | WR,
+	[DA906X_REG_LDO8_CONT] =	RD | WR,
+	[DA906X_REG_LDO9_CONT] =	RD | WR,
+	[DA906X_REG_LDO10_CONT] =	RD | WR,
+	[DA906X_REG_LDO11_CONT] =	RD | WR,
+	[DA906X_REG_VIB] =		RD | WR,
+	[DA906X_REG_DVC_1] =		RD | WR,
+	[DA906X_REG_DVC_2] =		RD | WR,
+
+	[DA906X_REG_ADC_MAN] =		RD | WR | VOL,
+	[DA906X_REG_ADC_CONT] =		RD | WR,
+	[DA906X_REG_VSYS_MON] =		RD | WR,
+	[DA906X_REG_ADC_RES_L] =	RD | VOL,
+	[DA906X_REG_ADC_RES_H] =	RD | VOL,
+	[DA906X_REG_VSYS_RES] =		RD | VOL,
+	[DA906X_REG_ADCIN1_RES] =	RD | VOL,
+	[DA906X_REG_ADCIN2_RES] =	RD | VOL,
+	[DA906X_REG_ADCIN3_RES] =	RD | VOL,
+	[DA906X_REG_MON1_RES] =		RD | VOL,
+	[DA906X_REG_MON2_RES] =		RD | VOL,
+	[DA906X_REG_MON3_RES] =		RD | VOL,
+
+	[DA906X_REG_COUNT_S] =		RD | WR | VOL,
+	[DA906X_REG_COUNT_MI] =		RD | WR | VOL,
+	[DA906X_REG_COUNT_H] =		RD | WR | VOL,
+	[DA906X_REG_COUNT_D] =		RD | WR | VOL,
+	[DA906X_REG_COUNT_MO] =		RD | WR | VOL,
+	[DA906X_REG_COUNT_Y] =		RD | WR | VOL,
+	[DA906X_REG_ALARM_MI] =		RD | WR | VOL,
+	[DA906X_REG_ALARM_H] =		RD | WR | VOL,
+	[DA906X_REG_ALARM_D] =		RD | WR | VOL,
+	[DA906X_REG_ALARM_MO] =		RD | WR | VOL,
+	[DA906X_REG_ALARM_Y] =		RD | WR | VOL,
+	[DA906X_REG_SECOND_A] =		RD | VOL,
+	[DA906X_REG_SECOND_B] =		RD | VOL,
+	[DA906X_REG_SECOND_C] =		RD | VOL,
+	[DA906X_REG_SECOND_D] =		RD | VOL,
+
+	[DA906X_REG_SEQ] =		RD | WR,
+	[DA906X_REG_SEQ_TIMER] =	RD | WR,
+	[DA906X_REG_ID_2_1] =		RD | WR,
+	[DA906X_REG_ID_4_3] =		RD | WR,
+	[DA906X_REG_ID_6_5] =		RD | WR,
+	[DA906X_REG_ID_8_7] =		RD | WR,
+	[DA906X_REG_ID_10_9] =		RD | WR,
+	[DA906X_REG_ID_12_11] =		RD | WR,
+	[DA906X_REG_ID_14_13] =		RD | WR,
+	[DA906X_REG_ID_16_15] =		RD | WR,
+	[DA906X_REG_ID_18_17] =		RD | WR,
+	[DA906X_REG_ID_20_19] =		RD | WR,
+	[DA906X_REG_ID_22_21] =		RD | WR,
+	[DA906X_REG_ID_24_23] =		RD | WR,
+	[DA906X_REG_ID_26_25] =		RD | WR,
+	[DA906X_REG_ID_28_27] =		RD | WR,
+	[DA906X_REG_ID_30_29] =		RD | WR,
+	[DA906X_REG_ID_32_31] =		RD | WR,
+	[DA906X_REG_SEQ_A] =		RD | WR,
+	[DA906X_REG_SEQ_B] =		RD | WR,
+	[DA906X_REG_WAIT] =		RD | WR,
+	[DA906X_REG_EN_32K] =		RD | WR,
+	[DA906X_REG_RESET] =		RD | WR,
+
+	[DA906X_REG_BUCK_ILIM_A] =	RD | WR,
+	[DA906X_REG_BUCK_ILIM_B] =	RD | WR,
+	[DA906X_REG_BUCK_ILIM_C] =	RD | WR,
+	[DA906X_REG_BCORE2_CFG] =	RD | WR,
+	[DA906X_REG_BCORE1_CFG] =	RD | WR,
+	[DA906X_REG_BPRO_CFG] =		RD | WR,
+	[DA906X_REG_BIO_CFG] =		RD | WR,
+	[DA906X_REG_BMEM_CFG] =		RD | WR,
+	[DA906X_REG_BPERI_CFG] =	RD | WR,
+	[DA906X_REG_VBCORE2_A] =	RD | WR,
+	[DA906X_REG_VBCORE1_A] =	RD | WR,
+	[DA906X_REG_VBPRO_A] =		RD | WR,
+	[DA906X_REG_VBMEM_A] =		RD | WR,
+	[DA906X_REG_VBIO_A] =		RD | WR,
+	[DA906X_REG_VBPERI_A] =		RD | WR,
+	[DA906X_REG_VLDO1_A] =		RD | WR,
+	[DA906X_REG_VLDO2_A] =		RD | WR,
+	[DA906X_REG_VLDO3_A] =		RD | WR,
+	[DA906X_REG_VLDO4_A] =		RD | WR,
+	[DA906X_REG_VLDO5_A] =		RD | WR,
+	[DA906X_REG_VLDO6_A] =		RD | WR,
+	[DA906X_REG_VLDO7_A] =		RD | WR,
+	[DA906X_REG_VLDO8_A] =		RD | WR,
+	[DA906X_REG_VLDO9_A] =		RD | WR,
+	[DA906X_REG_VLDO10_A] =		RD | WR,
+	[DA906X_REG_VLDO11_A] =		RD | WR,
+	[DA906X_REG_VBCORE2_B] =	RD | WR,
+	[DA906X_REG_VBCORE1_B] =	RD | WR,
+	[DA906X_REG_VBPRO_B] =		RD | WR,
+	[DA906X_REG_VBMEM_B] =		RD | WR,
+	[DA906X_REG_VBIO_B] =		RD | WR,
+	[DA906X_REG_VBPERI_B] =		RD | WR,
+	[DA906X_REG_VLDO1_B] =		RD | WR,
+	[DA906X_REG_VLDO2_B] =		RD | WR,
+	[DA906X_REG_VLDO3_B] =		RD | WR,
+	[DA906X_REG_VLDO4_B] =		RD | WR,
+	[DA906X_REG_VLDO5_B] =		RD | WR,
+	[DA906X_REG_VLDO6_B] =		RD | WR,
+	[DA906X_REG_VLDO7_B] =		RD | WR,
+	[DA906X_REG_VLDO8_B] =		RD | WR,
+	[DA906X_REG_VLDO9_B] =		RD | WR,
+	[DA906X_REG_VLDO10_B] =		RD | WR,
+	[DA906X_REG_VLDO11_B] =		RD | WR,
+
+	[DA906X_REG_BBAT_CONT] =	RD | WR,
+
+	[DA906X_REG_GPO11_LED] =	RD | WR,
+	[DA906X_REG_GPO14_LED] =	RD | WR,
+	[DA906X_REG_GPO15_LED] =	RD | WR,
+
+	[DA906X_REG_ADC_CFG] =		RD | WR,
+	[DA906X_REG_AUTO1_HIGH] =	RD | WR,
+	[DA906X_REG_AUTO1_LOW] =	RD | WR,
+	[DA906X_REG_AUTO2_HIGH] =	RD | WR,
+	[DA906X_REG_AUTO2_LOW] =	RD | WR,
+	[DA906X_REG_AUTO3_HIGH] =	RD | WR,
+	[DA906X_REG_AUTO3_LOW] =	RD | WR,
+
+	[DA906X_REG_T_OFFSET] =		RD,
+	[DA906X_REG_CONFIG_H] =		RD,
+	[DA906X_REG_CONFIG_I] =		RD | WR,
+	[DA906X_REG_MON_REG_1] =	RD | WR,
+	[DA906X_REG_MON_REG_2] =	RD | WR,
+	[DA906X_REG_MON_REG_3] =	RD | WR,
+	[DA906X_REG_MON_REG_4] =	RD | WR,
+	[DA906X_REG_MON_REG_5] =	RD | VOL,
+	[DA906X_REG_MON_REG_6] =	RD | VOL,
+	[DA906X_REG_TRIM_CLDR] =	RD,
+
+	[DA906X_REG_GP_ID_0] =		RD | WR,
+	[DA906X_REG_GP_ID_1] =		RD | WR,
+	[DA906X_REG_GP_ID_2] =		RD | WR,
+	[DA906X_REG_GP_ID_3] =		RD | WR,
+	[DA906X_REG_GP_ID_4] =		RD | WR,
+	[DA906X_REG_GP_ID_5] =		RD | WR,
+	[DA906X_REG_GP_ID_6] =		RD | WR,
+	[DA906X_REG_GP_ID_7] =		RD | WR,
+	[DA906X_REG_GP_ID_8] =		RD | WR,
+	[DA906X_REG_GP_ID_9] =		RD | WR,
+	[DA906X_REG_GP_ID_10] =		RD | WR,
+	[DA906X_REG_GP_ID_11] =		RD | WR,
+	[DA906X_REG_GP_ID_12] =		RD | WR,
+	[DA906X_REG_GP_ID_13] =		RD | WR,
+	[DA906X_REG_GP_ID_14] =		RD | WR,
+	[DA906X_REG_GP_ID_15] =		RD | WR,
+	[DA906X_REG_GP_ID_16] =		RD | WR,
+	[DA906X_REG_GP_ID_17] =		RD | WR,
+	[DA906X_REG_GP_ID_18] =		RD | WR,
+	[DA906X_REG_GP_ID_19] =		RD | WR,
+
+	[DA906X_REG_CHIP_ID] =		RD,
+	[DA906X_REG_CHIP_VARIANT] =	RD,
+};
+
+static bool da906x_reg_readable(struct device *dev, unsigned int reg)
+{
+	if (reg < DA906X_MAPPING_BASE) {
+		return true;
+	} else {
+		reg -= DA906X_MAPPING_BASE;
+		if (da906x_reg_flg[reg] & RD)
+			return true;
+		else
+			return false;
+	}
+}
+
+static bool da906x_reg_writable(struct device *dev, unsigned int reg)
+{
+	if (reg < DA906X_MAPPING_BASE) {
+		return true;
+	} else {
+		reg -= DA906X_MAPPING_BASE;
+		if (da906x_reg_flg[reg] & WR)
+			return true;
+		else
+			return false;
+	}
+}
+
+static bool da906x_reg_volatile(struct device *dev, unsigned int reg)
+{
+	if (reg < DA906X_MAPPING_BASE) {
+		switch (reg) {
+		case DA906X_REG_PAGE_CON:    /* Use cache for page selector */
+			return false;
+		default:
+			return true;
+		}
+	} else {
+		reg -= DA906X_MAPPING_BASE;
+		if (da906x_reg_flg[reg] & VOL)
+			return true;
+		else
+			return false;
+	}
+}
+
+static const struct regmap_range_cfg da906x_range_cfg[] = {
+	{
+		.range_min = DA906X_MAPPING_BASE,
+		.range_max = DA906X_MAPPING_BASE +
+			     ARRAY_SIZE(da906x_reg_flg) - 1,
+		.selector_reg = DA906X_REG_PAGE_CON,
+		.selector_mask = 1 << DA906X_I2C_PAGE_SEL_SHIFT,
+		.selector_shift = DA906X_I2C_PAGE_SEL_SHIFT,
+		.window_start = 0,
+		.window_len = 256,
+	}
+};
+
+struct regmap_config da906x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.ranges = da906x_range_cfg,
+	.n_ranges = ARRAY_SIZE(da906x_range_cfg),
+	.max_register = DA906X_MAPPING_BASE + ARRAY_SIZE(da906x_reg_flg) - 1,
+
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = &da906x_reg_writable,
+	.readable_reg = &da906x_reg_readable,
+	.volatile_reg = &da906x_reg_volatile,
+};
+
+struct regmap_config da906x_no_cache_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.ranges = da906x_range_cfg,
+	.n_ranges = ARRAY_SIZE(da906x_range_cfg),
+	.max_register = DA906X_MAPPING_BASE + ARRAY_SIZE(da906x_reg_flg) - 1,
+
+	.cache_type = REGCACHE_NONE,
+
+	.writeable_reg = &da906x_reg_writable,
+	.readable_reg = &da906x_reg_readable,
+};
+
+static int da906x_i2c_probe(struct i2c_client *i2c,
+	const struct i2c_device_id *id)
+{
+	struct da906x *da906x;
+	struct regmap_config *config = &da906x_regmap_config;
+	struct da906x_pdata *pdata = i2c->dev.platform_data;
+	int ret;
+
+	da906x = devm_kzalloc(&i2c->dev, sizeof(struct da906x), GFP_KERNEL);
+	if (da906x = NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, da906x);
+	da906x->dev = &i2c->dev;
+
+	if (pdata->flags & DA906X_FLG_NO_CACHE)
+		config = &da906x_no_cache_regmap_config;
+
+	da906x->regmap = devm_regmap_init_i2c(i2c, config);
+	if (IS_ERR(da906x->regmap)) {
+		ret = PTR_ERR(da906x->regmap);
+		dev_err(da906x->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	return da906x_device_init(da906x, i2c->irq);
+}
+
+static int da906x_i2c_remove(struct i2c_client *i2c)
+{
+	struct da906x *da906x = i2c_get_clientdata(i2c);
+
+	da906x_device_exit(da906x);
+
+	return 0;
+}
+
+static const struct i2c_device_id da906x_i2c_id[] = {
+	{"da906x", PMIC_DA9063},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, da906x_i2c_id);
+
+static struct i2c_driver da906x_i2c_driver = {
+	.driver = {
+		.name = "da906x",
+		.owner = THIS_MODULE,
+	},
+	.probe    = da906x_i2c_probe,
+	.remove   = da906x_i2c_remove,
+	.id_table = da906x_i2c_id,
+};
+
+static int __init da906x_i2c_init(void)
+{
+	int ret;
+
+	ret = i2c_add_driver(&da906x_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register da906x I2C driver\n");
+
+	return ret;
+}
+subsys_initcall(da906x_i2c_init);
+
+static void __exit da906x_i2c_exit(void)
+{
+	i2c_del_driver(&da906x_i2c_driver);
+}
+module_exit(da906x_i2c_exit);
diff --git a/drivers/mfd/da906x-irq.c b/drivers/mfd/da906x-irq.c
new file mode 100644
index 0000000..18d2796
--- /dev/null
+++ b/drivers/mfd/da906x-irq.c
@@ -0,0 +1,192 @@
+/* da906x-irq.c: Interrupts support for Dialog DA906X
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Michal Hajduk <michal.hajduk@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+
+#define	DA906X_REG_EVENT_A_OFFSET	0
+#define	DA906X_REG_EVENT_B_OFFSET	1
+#define	DA906X_REG_EVENT_C_OFFSET	2
+#define	DA906X_REG_EVENT_D_OFFSET	3
+#define EVENTS_BUF_LEN			4
+
+static const u8 mask_events_buf[] = { [0 ... (EVENTS_BUF_LEN - 1)] = ~0 };
+
+struct da906x_irq_data {
+	u16 reg;
+	u8 mask;
+};
+
+static struct regmap_irq da906x_irqs[] = {
+	/* DA906x event A register */
+	[DA906X_IRQ_ONKEY] = {
+		.reg_offset = DA906X_REG_EVENT_A_OFFSET,
+		.mask = DA906X_M_ONKEY,
+	},
+	[DA906X_IRQ_ALARM] = {
+		.reg_offset = DA906X_REG_EVENT_A_OFFSET,
+		.mask = DA906X_M_ALARM,
+	},
+	[DA906X_IRQ_TICK] = {
+		.reg_offset = DA906X_REG_EVENT_A_OFFSET,
+		.mask = DA906X_M_TICK,
+	},
+	[DA906X_IRQ_ADC_RDY] = {
+		.reg_offset = DA906X_REG_EVENT_A_OFFSET,
+		.mask = DA906X_M_ADC_RDY,
+	},
+	[DA906X_IRQ_SEQ_RDY] = {
+		.reg_offset = DA906X_REG_EVENT_A_OFFSET,
+		.mask = DA906X_M_SEQ_RDY,
+	},
+	/* DA906x event B register */
+	[DA906X_IRQ_WAKE] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_WAKE,
+	},
+	[DA906X_IRQ_TEMP] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_TEMP,
+	},
+	[DA906X_IRQ_COMP_1V2] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_COMP_1V2,
+	},
+	[DA906X_IRQ_LDO_LIM] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_LDO_LIM,
+	},
+	[DA906X_IRQ_REG_UVOV] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_UVOV,
+	},
+	[DA906X_IRQ_VDD_MON] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_VDD_MON,
+	},
+	[DA906X_IRQ_WARN] = {
+		.reg_offset = DA906X_REG_EVENT_B_OFFSET,
+		.mask = DA906X_M_VDD_WARN,
+	},
+	/* DA906x event C register */
+	[DA906X_IRQ_GPI0] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI0,
+	},
+	[DA906X_IRQ_GPI1] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI1,
+	},
+	[DA906X_IRQ_GPI2] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI2,
+	},
+	[DA906X_IRQ_GPI3] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI3,
+	},
+	[DA906X_IRQ_GPI4] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI4,
+	},
+	[DA906X_IRQ_GPI5] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI5,
+	},
+	[DA906X_IRQ_GPI6] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI6,
+	},
+	[DA906X_IRQ_GPI7] = {
+		.reg_offset = DA906X_REG_EVENT_C_OFFSET,
+		.mask = DA906X_M_GPI7,
+	},
+	/* DA906x event D register */
+	[DA906X_IRQ_GPI8] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI8,
+	},
+	[DA906X_IRQ_GPI9] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI9,
+	},
+	[DA906X_IRQ_GPI10] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI10,
+	},
+	[DA906X_IRQ_GPI11] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI11,
+	},
+	[DA906X_IRQ_GPI12] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI12,
+	},
+	[DA906X_IRQ_GPI13] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI13,
+	},
+	[DA906X_IRQ_GPI14] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI14,
+	},
+	[DA906X_IRQ_GPI15] = {
+		.reg_offset = DA906X_REG_EVENT_D_OFFSET,
+		.mask = DA906X_M_GPI15,
+	},
+};
+
+static struct regmap_irq_chip da906x_irq_chip = {
+	.name = "da906x-irq",
+	.irqs = da906x_irqs,
+	.num_irqs = DA906X_NUM_IRQ,
+
+	.num_regs = 4,
+	.status_base = DA906X_REG_EVENT_A + DA906X_MAPPING_BASE,
+	.mask_base = DA906X_REG_IRQ_MASK_A + DA906X_MAPPING_BASE,
+	.ack_base = DA906X_REG_EVENT_A + DA906X_MAPPING_BASE,
+};
+
+int da906x_irq_init(struct da906x *da906x)
+{
+	int ret;
+
+	if (!da906x->chip_irq) {
+		dev_err(da906x->dev, "No IRQ configured\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_add_irq_chip(da906x->regmap, da906x->chip_irq,
+			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+			da906x->irq_base, &da906x_irq_chip,
+			&da906x->regmap_irq);
+	if (ret) {
+		dev_err(da906x->dev, "Failed to reguest IRQ %d: %d\n",
+				da906x->chip_irq, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void da906x_irq_exit(struct da906x *da906x)
+{
+	regmap_del_irq_chip(da906x->chip_irq, da906x->regmap_irq);
+}
+
diff --git a/include/linux/mfd/da906x/core.h b/include/linux/mfd/da906x/core.h
new file mode 100644
index 0000000..abd916d
--- /dev/null
+++ b/include/linux/mfd/da906x/core.h
@@ -0,0 +1,121 @@
+/*
+ * Definitions for DA906X MFD driver
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Michal Hajduk <michal.hajduk@diasemi.com>
+ *	   Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __MFD_DA906X_CORE_H__
+#define __MFD_DA906X_CORE_H__
+
+#include <linux/interrupt.h>
+#include <linux/mfd/da906x/registers.h>
+
+/* DA906x modules */
+#define DA906X_DRVNAME_CORE		"da906x-core"
+#define DA906X_DRVNAME_REGULATORS	"da906x-regulators"
+#define DA906X_DRVNAME_LEDS		"da906x-leds"
+#define DA906X_DRVNAME_WATCHDOG		"da906x-watchdog"
+#define DA906X_DRVNAME_HWMON		"da906x-hwmon"
+#define DA906X_DRVNAME_ONKEY		"da906x-onkey"
+#define DA906X_DRVNAME_RTC		"da906x-rtc"
+#define DA906X_DRVNAME_VIBRATION	"da906x-vibration"
+
+enum da906x_models {
+	PMIC_DA9063 = 0x61,
+};
+
+/* Interrupts */
+enum da906x_irqs {
+	DA906X_IRQ_ONKEY = 0,
+	DA906X_IRQ_ALARM,
+	DA906X_IRQ_TICK,
+	DA906X_IRQ_ADC_RDY,
+	DA906X_IRQ_SEQ_RDY,
+	DA906X_IRQ_WAKE,
+	DA906X_IRQ_TEMP,
+	DA906X_IRQ_COMP_1V2,
+	DA906X_IRQ_LDO_LIM,
+	DA906X_IRQ_REG_UVOV,
+	DA906X_IRQ_VDD_MON,
+	DA906X_IRQ_WARN,
+	DA906X_IRQ_GPI0,
+	DA906X_IRQ_GPI1,
+	DA906X_IRQ_GPI2,
+	DA906X_IRQ_GPI3,
+	DA906X_IRQ_GPI4,
+	DA906X_IRQ_GPI5,
+	DA906X_IRQ_GPI6,
+	DA906X_IRQ_GPI7,
+	DA906X_IRQ_GPI8,
+	DA906X_IRQ_GPI9,
+	DA906X_IRQ_GPI10,
+	DA906X_IRQ_GPI11,
+	DA906X_IRQ_GPI12,
+	DA906X_IRQ_GPI13,
+	DA906X_IRQ_GPI14,
+	DA906X_IRQ_GPI15,
+};
+
+#define DA906X_IRQ_BASE_OFFSET	0
+#define DA906X_NUM_IRQ		(DA906X_IRQ_GPI15 + 1 - DA906X_IRQ_BASE_OFFSET)
+
+struct da906x {
+	/* Device */
+	struct device	*dev;
+	unsigned short	model;
+	unsigned short	revision;
+	unsigned int	flags;
+
+	/* Control interface */
+	struct mutex	io_mutex;
+	struct regmap	*regmap;
+
+	/* Interrupts */
+	int		chip_irq;
+	unsigned int	irq_base;
+	struct regmap_irq_chip_data *regmap_irq;
+};
+
+static inline unsigned da906x_model(struct da906x *da906x)
+{
+	return da906x->model;
+}
+
+static inline unsigned da906x_revision(struct da906x *da906x)
+{
+	return da906x->revision;
+}
+
+static inline void da906x_set_model_rev(struct da906x *da906x,
+			enum da906x_models model, unsigned short revision)
+{
+	da906x->model = model;
+	da906x->revision = revision;
+}
+
+int da906x_reg_read(struct da906x *da906x, u16 reg);
+int da906x_reg_write(struct da906x *da906x, u16 reg, u8 val);
+
+int da906x_block_write(struct da906x *da906x, u16 reg, int bytes, const u8 *buf);
+int da906x_block_read(struct da906x *da906x, u16 reg, int bytes, u8 *buf);
+
+int da906x_reg_set_bits(struct da906x *da906x, u16 reg, u8 mask);
+int da906x_reg_clear_bits(struct da906x *da906x, u16 reg, u8 mask);
+int da906x_reg_update(struct da906x*, u16 reg, u8 mask, u8 val);
+
+int da906x_device_init(struct da906x *da906x, unsigned int irq);
+int da906x_irq_init(struct da906x *da906x);
+
+void da906x_device_exit(struct da906x *da906x);
+void da906x_irq_exit(struct da906x *da906x);
+
+#endif /* __MFD_DA906X_CORE_H__ */
diff --git a/include/linux/mfd/da906x/pdata.h b/include/linux/mfd/da906x/pdata.h
new file mode 100644
index 0000000..97ae242
--- /dev/null
+++ b/include/linux/mfd/da906x/pdata.h
@@ -0,0 +1,114 @@
+/*
+ * Platform configuration options for DA906x
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Michal Hajduk <michal.hajduk@diasemi.com>
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __MFD_DA906X_PDATA_H__
+#define __MFD_DA906X_PDATA_H__
+
+#include <linux/regulator/machine.h>
+
+/*
+ * Regulator configuration
+ */
+/* DA9063 regulator IDs */
+enum {
+	/* BUCKs */
+	DA9063_ID_BCORE1,
+	DA9063_ID_BCORE2,
+	DA9063_ID_BPRO,
+	DA9063_ID_BMEM,
+	DA9063_ID_BIO,
+	DA9063_ID_BPERI,
+
+	/* BCORE1 and BCORE2 in merged mode */
+	DA9063_ID_BCORES_MERGED,
+	/* BMEM and BIO in merged mode */
+	DA9063_ID_BMEM_BIO_MERGED,
+	/* When two BUCKs are merged, they cannot be reused separately */
+
+	/* LDOs */
+	DA9063_ID_LDO1,
+	DA9063_ID_LDO2,
+	DA9063_ID_LDO3,
+	DA9063_ID_LDO4,
+	DA9063_ID_LDO5,
+	DA9063_ID_LDO6,
+	DA9063_ID_LDO7,
+	DA9063_ID_LDO8,
+	DA9063_ID_LDO9,
+	DA9063_ID_LDO10,
+	DA9063_ID_LDO11,
+
+	/* RTC internal oscilator switch */
+	DA9063_ID_32K_OUT,
+};
+
+/* Regulators platform data */
+struct da906x_regulator_data {
+	int				id;
+	struct regulator_init_data	*initdata;
+};
+
+struct da906x_regulators_pdata {
+	unsigned			n_regulators;
+	struct da906x_regulator_data	*regulator_data;
+};
+
+
+/*
+ * RGB LED configuration
+ */
+/* LED IDs for flags in struct led_info. */
+enum {
+	DA906X_GPIO11_LED,
+	DA906X_GPIO14_LED,
+	DA906X_GPIO15_LED,
+
+	DA906X_LED_NUM
+};
+#define DA906X_LED_ID_MASK		0x3
+
+/* LED polarity for flags in struct led_info. */
+#define DA906X_LED_HIGH_LEVEL_ACTIVE	0x0
+#define DA906X_LED_LOW_LEVEL_ACTIVE	0x4
+
+
+/*
+ * General PMIC configuration
+ */
+/* HWMON ADC channels configuration */
+#define DA906X_FLG_FORCE_IN0_MANUAL_MODE	0x0010
+#define DA906X_FLG_FORCE_IN0_AUTO_MODE		0x0020
+#define DA906X_FLG_FORCE_IN1_MANUAL_MODE	0x0040
+#define DA906X_FLG_FORCE_IN1_AUTO_MODE		0x0080
+#define DA906X_FLG_FORCE_IN2_MANUAL_MODE	0x0100
+#define DA906X_FLG_FORCE_IN2_AUTO_MODE		0x0200
+#define DA906X_FLG_FORCE_IN3_MANUAL_MODE	0x0400
+#define DA906X_FLG_FORCE_IN3_AUTO_MODE		0x0800
+
+/* Disable register caching. */
+#define DA906X_FLG_NO_CACHE			0x0008
+
+struct da906x;
+
+/* DA906x platform data */
+struct da906x_pdata {
+	int				(*init)(struct da906x *da906x);
+	int				irq_base;
+	unsigned			flags;
+	struct da906x_regulators_pdata	*regulators_pdata;
+	struct led_platform_data	*leds_pdata;
+};
+
+#endif	/* __MFD_DA906X_PDATA_H__ */
diff --git a/include/linux/mfd/da906x/registers.h b/include/linux/mfd/da906x/registers.h
new file mode 100644
index 0000000..6808977
--- /dev/null
+++ b/include/linux/mfd/da906x/registers.h
@@ -0,0 +1,1093 @@
+/*
+ * Registers definition for DA906X modules
+ *
+ * Copyright 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Michal Hajduk <michal.hajduk@diasemi.com>
+ *	   Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef _DA906X_REG_H
+#define	_DA906X_REG_H
+
+#define DA906X_I2C_PAGE_SEL_SHIFT	1
+#define DA906X_I2C_PAGE(v)		(((v) >> 8) << \
+						DA906X_I2C_PAGE_SEL_SHIFT)
+#define DA906X_I2C_REG(v)		((v) & 0xFF)
+
+#define	DA906X_EVENT_REG_NUM		4
+#define	DA9210_EVENT_REG_NUM		2
+#define	DA906X_EXT_EVENT_REG_NUM	(DA906X_EVENT_REG_NUM + \
+						DA9210_EVENT_REG_NUM)
+
+/* Page selection I2C or SPI always in the begining of any page. */
+/* Page 0 : I2C access 0x000 - 0x0FF	SPI access 0x000 - 0x07F */
+/* Page 1 :				SPI access 0x080 - 0x0FF */
+/* Page 2 : I2C access 0x100 - 0x1FF	SPI access 0x100 - 0x17F */
+/* Page 3 :				SPI access 0x180 - 0x1FF */
+#define	DA906X_REG_PAGE_CON		0x00
+
+/* Create virtual range for pageable registers just above physical range */
+#define DA906X_MAPPING_BASE		0x100
+
+/* System Control and Event Registers */
+#define	DA906X_REG_STATUS_A		0x01
+#define	DA906X_REG_STATUS_B		0x02
+#define	DA906X_REG_STATUS_C		0x03
+#define	DA906X_REG_STATUS_D		0x04
+#define	DA906X_REG_FAULT_LOG		0x05
+#define	DA906X_REG_EVENT_A		0x06
+#define	DA906X_REG_EVENT_B		0x07
+#define	DA906X_REG_EVENT_C		0x08
+#define	DA906X_REG_EVENT_D		0x09
+#define	DA906X_REG_IRQ_MASK_A		0x0A
+#define	DA906X_REG_IRQ_MASK_B		0x0B
+#define	DA906X_REG_IRQ_MASK_C		0x0C
+#define	DA906X_REG_IRQ_MASK_D		0x0D
+#define	DA906X_REG_CONTROL_A		0x0E
+#define	DA906X_REG_CONTROL_B		0x0F
+#define	DA906X_REG_CONTROL_C		0x10
+#define	DA906X_REG_CONTROL_D		0x11
+#define	DA906X_REG_CONTROL_E		0x12
+#define	DA906X_REG_CONTROL_F		0x13
+#define	DA906X_REG_PD_DIS		0x14
+
+/* GPIO Control Registers */
+#define	DA906X_REG_GPIO_0_1		0x15
+#define	DA906X_REG_GPIO_2_3		0x16
+#define	DA906X_REG_GPIO_4_5		0x17
+#define	DA906X_REG_GPIO_6_7		0x18
+#define	DA906X_REG_GPIO_8_9		0x19
+#define	DA906X_REG_GPIO_10_11		0x1A
+#define	DA906X_REG_GPIO_12_13		0x1B
+#define	DA906X_REG_GPIO_14_15		0x1C
+#define	DA906X_REG_GPIO_MODE_0_7	0x1D
+#define	DA906X_REG_GPIO_MODE_8_15	0x1E
+#define	DA906X_REG_GPIO_SWITCH_CONT	0x1F
+
+/* Regulator Control Registers */
+#define	DA906X_REG_BCORE2_CONT		0x20
+#define	DA906X_REG_BCORE1_CONT		0x21
+#define	DA906X_REG_BPRO_CONT		0x22
+#define	DA906X_REG_BMEM_CONT		0x23
+#define	DA906X_REG_BIO_CONT		0x24
+#define	DA906X_REG_BPERI_CONT		0x25
+#define	DA906X_REG_LDO1_CONT		0x26
+#define	DA906X_REG_LDO2_CONT		0x27
+#define	DA906X_REG_LDO3_CONT		0x28
+#define	DA906X_REG_LDO4_CONT		0x29
+#define	DA906X_REG_LDO5_CONT		0x2A
+#define	DA906X_REG_LDO6_CONT		0x2B
+#define	DA906X_REG_LDO7_CONT		0x2C
+#define	DA906X_REG_LDO8_CONT		0x2D
+#define	DA906X_REG_LDO9_CONT		0x2E
+#define	DA906X_REG_LDO10_CONT		0x2F
+#define	DA906X_REG_LDO11_CONT		0x30
+#define	DA906X_REG_VIB			0x31
+#define	DA906X_REG_DVC_1		0x32
+#define	DA906X_REG_DVC_2		0x33
+
+/* GP-ADC Control Registers */
+#define	DA906X_REG_ADC_MAN		0x34
+#define	DA906X_REG_ADC_CONT		0x35
+#define	DA906X_REG_VSYS_MON		0x36
+#define	DA906X_REG_ADC_RES_L		0x37
+#define	DA906X_REG_ADC_RES_H		0x38
+#define	DA906X_REG_VSYS_RES		0x39
+#define	DA906X_REG_ADCIN1_RES		0x3A
+#define	DA906X_REG_ADCIN2_RES		0x3B
+#define	DA906X_REG_ADCIN3_RES		0x3C
+#define	DA906X_REG_MON1_RES		0x3D
+#define	DA906X_REG_MON2_RES		0x3E
+#define	DA906X_REG_MON3_RES		0x3F
+
+/* RTC Calendar and Alarm Registers */
+#define	DA906X_REG_COUNT_S		0x40
+#define	DA906X_REG_COUNT_MI		0x41
+#define	DA906X_REG_COUNT_H		0x42
+#define	DA906X_REG_COUNT_D		0x43
+#define	DA906X_REG_COUNT_MO		0x44
+#define	DA906X_REG_COUNT_Y		0x45
+#define	DA906X_REG_ALARM_MI		0x46
+#define	DA906X_REG_ALARM_H		0x47
+#define	DA906X_REG_ALARM_D		0x48
+#define	DA906X_REG_ALARM_MO		0x49
+#define	DA906X_REG_ALARM_Y		0x4A
+#define	DA906X_REG_SECOND_A		0x4B
+#define	DA906X_REG_SECOND_B		0x4C
+#define	DA906X_REG_SECOND_C		0x4D
+#define	DA906X_REG_SECOND_D		0x4E
+
+/* Sequencer Control Registers */
+#define	DA906X_REG_SEQ			0x81
+#define	DA906X_REG_SEQ_TIMER		0x82
+#define	DA906X_REG_ID_2_1		0x83
+#define	DA906X_REG_ID_4_3		0x84
+#define	DA906X_REG_ID_6_5		0x85
+#define	DA906X_REG_ID_8_7		0x86
+#define	DA906X_REG_ID_10_9		0x87
+#define	DA906X_REG_ID_12_11		0x88
+#define	DA906X_REG_ID_14_13		0x89
+#define	DA906X_REG_ID_16_15		0x8A
+#define	DA906X_REG_ID_18_17		0x8B
+#define	DA906X_REG_ID_20_19		0x8C
+#define	DA906X_REG_ID_22_21		0x8D
+#define	DA906X_REG_ID_24_23		0x8E
+#define	DA906X_REG_ID_26_25		0x8F
+#define	DA906X_REG_ID_28_27		0x90
+#define	DA906X_REG_ID_30_29		0x91
+#define	DA906X_REG_ID_32_31		0x92
+#define	DA906X_REG_SEQ_A		0x95
+#define	DA906X_REG_SEQ_B		0x96
+#define	DA906X_REG_WAIT			0x97
+#define	DA906X_REG_EN_32K		0x98
+#define	DA906X_REG_RESET		0x99
+
+/* Regulator Setting Registers */
+#define	DA906X_REG_BUCK_ILIM_A		0x9A
+#define	DA906X_REG_BUCK_ILIM_B		0x9B
+#define	DA906X_REG_BUCK_ILIM_C		0x9C
+#define	DA906X_REG_BCORE2_CFG		0x9D
+#define	DA906X_REG_BCORE1_CFG		0x9E
+#define	DA906X_REG_BPRO_CFG		0x9F
+#define	DA906X_REG_BIO_CFG		0xA0
+#define	DA906X_REG_BMEM_CFG		0xA1
+#define	DA906X_REG_BPERI_CFG		0xA2
+#define	DA906X_REG_VBCORE2_A		0xA3
+#define	DA906X_REG_VBCORE1_A		0xA4
+#define	DA906X_REG_VBPRO_A		0xA5
+#define	DA906X_REG_VBMEM_A		0xA6
+#define	DA906X_REG_VBIO_A		0xA7
+#define	DA906X_REG_VBPERI_A		0xA8
+#define	DA906X_REG_VLDO1_A		0xA9
+#define	DA906X_REG_VLDO2_A		0xAA
+#define	DA906X_REG_VLDO3_A		0xAB
+#define	DA906X_REG_VLDO4_A		0xAC
+#define	DA906X_REG_VLDO5_A		0xAD
+#define	DA906X_REG_VLDO6_A		0xAE
+#define	DA906X_REG_VLDO7_A		0xAF
+#define	DA906X_REG_VLDO8_A		0xB0
+#define	DA906X_REG_VLDO9_A		0xB1
+#define	DA906X_REG_VLDO10_A		0xB2
+#define	DA906X_REG_VLDO11_A		0xB3
+#define	DA906X_REG_VBCORE2_B		0xB4
+#define	DA906X_REG_VBCORE1_B		0xB5
+#define	DA906X_REG_VBPRO_B		0xB6
+#define	DA906X_REG_VBMEM_B		0xB7
+#define	DA906X_REG_VBIO_B		0xB8
+#define	DA906X_REG_VBPERI_B		0xB9
+#define	DA906X_REG_VLDO1_B		0xBA
+#define	DA906X_REG_VLDO2_B		0xBB
+#define	DA906X_REG_VLDO3_B		0xBC
+#define	DA906X_REG_VLDO4_B		0xBD
+#define	DA906X_REG_VLDO5_B		0xBE
+#define	DA906X_REG_VLDO6_B		0xBF
+#define	DA906X_REG_VLDO7_B		0xC0
+#define	DA906X_REG_VLDO8_B		0xC1
+#define	DA906X_REG_VLDO9_B		0xC2
+#define	DA906X_REG_VLDO10_B		0xC3
+#define	DA906X_REG_VLDO11_B		0xC4
+
+/* Backup Battery Charger Control Register */
+#define	DA906X_REG_BBAT_CONT		0xC5
+
+/* GPIO PWM (LED) */
+#define	DA906X_REG_GPO11_LED		0xC6
+#define	DA906X_REG_GPO14_LED		0xC7
+#define	DA906X_REG_GPO15_LED		0xC8
+
+/* GP-ADC Threshold Registers */
+#define	DA906X_REG_ADC_CFG		0xC9
+#define	DA906X_REG_AUTO1_HIGH		0xCA
+#define	DA906X_REG_AUTO1_LOW		0xCB
+#define	DA906X_REG_AUTO2_HIGH		0xCC
+#define	DA906X_REG_AUTO2_LOW		0xCD
+#define	DA906X_REG_AUTO3_HIGH		0xCE
+#define	DA906X_REG_AUTO3_LOW		0xCF
+
+/* DA906x Configuration registers */
+/* OTP */
+#define	DA906X_REG_OPT_COUNT		0x101
+#define	DA906X_REG_OPT_ADDR		0x102
+#define	DA906X_REG_OPT_DATA		0x103
+
+/* Customer Trim and Configuration */
+#define	DA906X_REG_T_OFFSET		0x104
+#define	DA906X_REG_INTERFACE		0x105
+#define	DA906X_REG_CONFIG_A		0x106
+#define	DA906X_REG_CONFIG_B		0x107
+#define	DA906X_REG_CONFIG_C		0x108
+#define	DA906X_REG_CONFIG_D		0x109
+#define	DA906X_REG_CONFIG_E		0x10A
+#define	DA906X_REG_CONFIG_F		0x10B
+#define	DA906X_REG_CONFIG_G		0x10C
+#define	DA906X_REG_CONFIG_H		0x10D
+#define	DA906X_REG_CONFIG_I		0x10E
+#define	DA906X_REG_CONFIG_J		0x10F
+#define	DA906X_REG_CONFIG_K		0x110
+#define	DA906X_REG_CONFIG_L		0x111
+#define	DA906X_REG_MON_REG_1		0x112
+#define	DA906X_REG_MON_REG_2		0x113
+#define	DA906X_REG_MON_REG_3		0x114
+#define	DA906X_REG_MON_REG_4		0x115
+#define	DA906X_REG_MON_REG_5		0x116
+#define	DA906X_REG_MON_REG_6		0x117
+#define	DA906X_REG_TRIM_CLDR		0x118
+
+/* General Purpose Registers */
+#define	DA906X_REG_GP_ID_0		0x119
+#define	DA906X_REG_GP_ID_1		0x11A
+#define	DA906X_REG_GP_ID_2		0x11B
+#define	DA906X_REG_GP_ID_3		0x11C
+#define	DA906X_REG_GP_ID_4		0x11D
+#define	DA906X_REG_GP_ID_5		0x11E
+#define	DA906X_REG_GP_ID_6		0x11F
+#define	DA906X_REG_GP_ID_7		0x120
+#define	DA906X_REG_GP_ID_8		0x121
+#define	DA906X_REG_GP_ID_9		0x122
+#define	DA906X_REG_GP_ID_10		0x123
+#define	DA906X_REG_GP_ID_11		0x124
+#define	DA906X_REG_GP_ID_12		0x125
+#define	DA906X_REG_GP_ID_13		0x126
+#define	DA906X_REG_GP_ID_14		0x127
+#define	DA906X_REG_GP_ID_15		0x128
+#define	DA906X_REG_GP_ID_16		0x129
+#define	DA906X_REG_GP_ID_17		0x12A
+#define	DA906X_REG_GP_ID_18		0x12B
+#define	DA906X_REG_GP_ID_19		0x12C
+
+/* Chip ID and variant */
+#define	DA906X_REG_CHIP_ID		0x181
+#define	DA906X_REG_CHIP_VARIANT		0x182
+
+/*
+ * PMIC registers bits
+ */
+/* DA906X_REG_PAGE_CON (addr=0x00) */
+#define	DA906X_PEG_PAGE_SHIFT			0
+#define	DA906X_REG_PAGE_MASK			0x07
+#define		DA906X_REG_PAGE0		0x00
+#define		DA906X_REG_PAGE2		0x02
+#define	DA906X_PAGE_WRITE_MODE			0x00
+#define	DA906X_REPEAT_WRITE_MODE		0x40
+#define	DA906X_PAGE_REVERT			0x80
+
+/* DA906X_REG_STATUS_A (addr=0x01) */
+#define	DA906X_NONKEY				0x01
+#define	DA906X_WAKE				0x02
+#define	DA906X_DVC_BUSY				0x04
+#define	DA906X_COMP_1V2				0x08
+
+/* DA906X_REG_STATUS_B (addr=0x02) */
+#define	DA906X_GPI0				0x01
+#define	DA906X_GPI1				0x02
+#define	DA906X_GPI2				0x04
+#define	DA906X_GPI3				0x08
+#define	DA906X_GPI4				0x10
+#define	DA906X_GPI5				0x20
+#define	DA906X_GPI6				0x40
+#define	DA906X_GPI7				0x80
+
+/* DA906X_REG_STATUS_C (addr=0x03) */
+#define	DA906X_GPI8				0x01
+#define	DA906X_GPI9				0x02
+#define	DA906X_GPI10				0x04
+#define	DA906X_GPI11				0x08
+#define	DA906X_GPI12				0x10
+#define	DA906X_GPI13				0x20
+#define	DA906X_GPI14				0x40
+#define	DA906X_GPI15				0x80
+
+/* DA906X_REG_STATUS_D (addr=0x04) */
+#define	DA906X_LDO3_LIM				0x08
+#define	DA906X_LDO4_LIM				0x10
+#define	DA906X_LDO7_LIM				0x20
+#define	DA906X_LDO8_LIM				0x40
+#define	DA906X_LDO11_LIM			0x80
+
+/* DA906X_REG_FAULT_LOG (addr=0x05) */
+#define	DA906X_TWD_ERROR			0x01
+#define	DA906X_POR				0x02
+#define	DA906X_VDD_FAULT			0x04
+#define	DA906X_VDD_START			0x08
+#define	DA906X_TEMP_CRIT			0x10
+#define	DA906X_KEY_RESET			0x20
+#define	DA906X_NSHUTDOWN			0x40
+#define	DA906X_WAIT_SHUT			0x80
+
+/* DA906X_REG_EVENT_A (addr=0x06) */
+#define	DA906X_E_NONKEY				0x01
+#define	DA906X_E_ALARM				0x02
+#define	DA906X_E_TICK				0x04
+#define	DA906X_E_ADC_RDY			0x08
+#define	DA906X_E_SEQ_RDY			0x10
+#define	DA906X_EVENTS_B				0x20
+#define	DA906X_EVENTS_C				0x40
+#define	DA906X_EVENTS_D				0x80
+
+/* DA906X_REG_EVENT_B (addr=0x07) */
+#define	DA906X_E_WAKE				0x01
+#define	DA906X_E_TEMP				0x02
+#define	DA906X_E_COMP_1V2			0x04
+#define	DA906X_E_LDO_LIM			0x08
+#define	DA906X_E_REG_UVOV			0x10
+#define	DA906X_E_DVC_RDY			0x20
+#define	DA906X_E_VDD_MON			0x40
+#define	DA906X_E_VDD_WARN			0x80
+
+/* DA906X_REG_EVENT_C (addr=0x08) */
+#define	DA906X_E_GPI0				0x01
+#define	DA906X_E_GPI1				0x02
+#define	DA906X_E_GPI2				0x04
+#define	DA906X_E_GPI3				0x08
+#define	DA906X_E_GPI4				0x10
+#define	DA906X_E_GPI5				0x20
+#define	DA906X_E_GPI6				0x40
+#define	DA906X_E_GPI7				0x80
+
+/* DA906X_REG_EVENT_D (addr=0x09) */
+#define	DA906X_E_GPI8				0x01
+#define	DA906X_E_GPI9				0x02
+#define	DA906X_E_GPI10				0x04
+#define	DA906X_E_GPI11				0x08
+#define	DA906X_E_GPI12				0x10
+#define	DA906X_E_GPI13				0x20
+#define	DA906X_E_GPI14				0x40
+#define	DA906X_E_GPI15				0x80
+
+/* DA906X_REG_IRQ_MASK_A (addr=0x0A) */
+#define	DA906X_M_ONKEY				0x01
+#define	DA906X_M_ALARM				0x02
+#define	DA906X_M_TICK				0x04
+#define	DA906X_M_ADC_RDY			0x08
+#define	DA906X_M_SEQ_RDY			0x10
+
+/* DA906X_REG_IRQ_MASK_B (addr=0x0B) */
+#define	DA906X_M_WAKE				0x01
+#define	DA906X_M_TEMP				0x02
+#define	DA906X_M_COMP_1V2			0x04
+#define	DA906X_M_LDO_LIM			0x08
+#define	DA906X_M_UVOV				0x10
+#define	DA906X_M_DVC_RDY			0x20
+#define	DA906X_M_VDD_MON			0x40
+#define	DA906X_M_VDD_WARN			0x80
+
+/* DA906X_REG_IRQ_MASK_C (addr=0x0C) */
+#define	DA906X_M_GPI0				0x01
+#define	DA906X_M_GPI1				0x02
+#define	DA906X_M_GPI2				0x04
+#define	DA906X_M_GPI3				0x08
+#define	DA906X_M_GPI4				0x10
+#define	DA906X_M_GPI5				0x20
+#define	DA906X_M_GPI6				0x40
+#define	DA906X_M_GPI7				0x80
+
+/* DA906X_REG_IRQ_MASK_D (addr=0x0D) */
+#define	DA906X_M_GPI8				0x01
+#define	DA906X_M_GPI9				0x02
+#define	DA906X_M_GPI10				0x04
+#define	DA906X_M_GPI11				0x08
+#define	DA906X_M_GPI12				0x10
+#define	DA906X_M_GPI13				0x20
+#define	DA906X_M_GPI14				0x40
+#define	DA906X_M_GPI15				0x80
+
+/* DA906X_REG_CONTROL_A (addr=0x0E) */
+#define	DA906X_SYSTEM_EN			0x01
+#define	DA906X_POWER_EN				0x02
+#define	DA906X_POWER1_EN			0x04
+#define	DA906X_STANDBY				0x08
+#define	DA906X_M_SYSTEM_EN			0x10
+#define	DA906X_M_POWER_EN			0x20
+#define	DA906X_M_POWER1_EN			0x40
+#define	DA906X_CP_EN				0x80
+
+/* DA906X_REG_CONTROL_B (addr=0x0F) */
+#define	DA906X_CHG_SEL				0x01
+#define	DA906X_WATCHDOG_PD			0x02
+#define	DA906X_NRES_MODE			0x08
+#define	DA906X_NONKEY_LOCK			0x10
+
+/* DA906X_REG_CONTROL_C (addr=0x10) */
+#define	DA906X_DEBOUNCING_SHIFT			0
+#define	DA906X_DEBOUNCING_MASK			0x07
+#define		DA906X_DEBOUNCING_OFF		0x0
+#define		DA906X_DEBOUNCING_0MS1		0x1
+#define		DA906X_DEBOUNCING_1MS		0x2
+#define		DA906X_DEBOUNCING_10MS24	0x3
+#define		DA906X_DEBOUNCING_51MS2		0x4
+#define		DA906X_DEBOUNCING_256MS		0x5
+#define		DA906X_DEBOUNCING_512MS		0x6
+#define		DA906X_DEBOUNCING_1024MS	0x7
+
+#define	DA906X_AUTO_BOOT			0x08
+#define	DA906X_OTPREAD_EN			0x10
+#define	DA906X_SLEW_RATE_SHIFT			5
+#define	DA906X_SLEW_RATE_MASK			0x60
+#define		DA906X_SLEW_RATE_4US		0x00
+#define		DA906X_SLEW_RATE_3US		0x20
+#define		DA906X_SLEW_RATE_1US		0x40
+#define		DA906X_SLEW_RATE_0US5		0x60
+#define	DA906X_DEF_SUPPLY			0x80
+
+/* DA906X_REG_CONTROL_D (addr=0x11) */
+#define	DA906X_TWDSCALE_SHIFT			0
+#define	DA906X_TWDSCALE_MASK			0x07
+#define	DA906X_BLINK_FRQ_SHIFT			3
+#define	DA906X_BLINK_FRQ_MASK			0x38
+#define		DA906X_BLINK_FRQ_OFF		0x00
+#define		DA906X_BLINK_FRQ_1S0		0x08
+#define		DA906X_BLINK_FRQ_2S0		0x10
+#define		DA906X_BLINK_FRQ_4S0		0x18
+#define		DA906X_BLINK_FRQ_0S18		0x20
+#define		DA906X_BLINK_FRQ_2S0_VDD	0x28
+#define		DA906X_BLINK_FRQ_4S0_VDD	0x30
+#define		DA906X_BLINK_FRQ_0S18_VDD	0x38
+
+#define	DA906X_BLINK_DUR_SHIFT			6
+#define	DA906X_BLINK_DUR_MASK			0xC0
+#define		DA906X_BLINK_DUR_10MS		0x00
+#define		DA906X_BLINK_DUR_20MS		0x40
+#define		DA906X_BLINK_DUR_40MS		0x80
+#define		DA906X_BLINK_DUR_20MSDBL	0xC0
+
+/* DA906X_REG_CONTROL_E (addr=0x12) */
+#define	DA906X_RTC_MODE_PD			0x01
+#define	DA906X_RTC_MODE_SD			0x02
+#define	DA906X_RTC_EN				0x04
+#define	DA906X_ECO_MODE				0x08
+#define	DA906X_PM_FB1_PIN			0x10
+#define	DA906X_PM_FB2_PIN			0x20
+#define	DA906X_PM_FB3_PIN			0x40
+#define	DA906X_V_LOCK				0x80
+
+/* DA906X_REG_CONTROL_F (addr=0x13) */
+#define	DA906X_WATCHDOG				0x01
+#define	DA906X_SHUTDOWN				0x02
+#define	DA906X_WAKE_UP				0x04
+
+/* DA906X_REG_PD_DIS (addr=0x14) */
+#define	DA906X_GPI_DIS				0x01
+#define	DA906X_GPADC_PAUSE			0x02
+#define	DA906X_PMIF_DIS				0x04
+#define	DA906X_HS2WIRE_DIS			0x08
+#define	DA906X_BBAT_DIS				0x20
+#define	DA906X_OUT_32K_PAUSE			0x40
+#define	DA906X_PMCONT_DIS			0x80
+
+/* DA906X_REG_GPIO_0_1 (addr=0x15) */
+#define	DA906X_GPIO0_PIN_SHIFT			0
+#define	DA906X_GPIO0_PIN_MASK			0x03
+#define		DA906X_GPIO0_PIN_ADCIN1		0x00
+#define		DA906X_GPIO0_PIN_GPI		0x01
+#define		DA906X_GPIO0_PIN_GPO_OD		0x02
+#define		DA906X_GPIO0_PIN_GPO		0x03
+#define	DA906X_GPIO0_TYPE			0x04
+#define		DA906X_GPIO0_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO0_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO0_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO0_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO0_NO_WAKEUP			0x08
+#define	DA906X_GPIO1_PIN_SHIFT			4
+#define	DA906X_GPIO1_PIN_MASK			0x30
+#define		DA906X_GPIO1_PIN_ADCIN2_COMP	0x00
+#define		DA906X_GPIO1_PIN_GPI		0x10
+#define		DA906X_GPIO1_PIN_GPO_OD		0x20
+#define		DA906X_GPIO1_PIN_GPO		0x30
+#define	DA906X_GPIO1_TYPE			0x40
+#define		DA906X_GPIO1_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO1_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO1_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO1_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO1_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_2_3 (addr=0x16) */
+#define	DA906X_GPIO2_PIN_SHIFT			0
+#define	DA906X_GPIO2_PIN_MASK			0x03
+#define		DA906X_GPIO2_PIN_ADCIN3		0x00
+#define		DA906X_GPIO2_PIN_GPI		0x01
+#define		DA906X_GPIO2_PIN_GPO_PSS	0x02
+#define		DA906X_GPIO2_PIN_GPO		0x03
+#define	DA906X_GPIO2_TYPE			0x04
+#define		DA906X_GPIO2_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO2_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO2_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO2_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO2_NO_WAKEUP			0x08
+#define	DA906X_GPIO3_PIN_SHIFT			4
+#define	DA906X_GPIO3_PIN_MASK			0x30
+#define		DA906X_GPIO3_PIN_CORE_SW_G	0x00
+#define		DA906X_GPIO3_PIN_GPI		0x10
+#define		DA906X_GPIO3_PIN_GPO_OD		0x20
+#define		DA906X_GPIO3_PIN_GPO		0x30
+#define	DA906X_GPIO3_TYPE			0x40
+#define		DA906X_GPIO3_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO3_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO3_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO3_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO3_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_4_5 (addr=0x17) */
+#define	DA906X_GPIO4_PIN_SHIFT			0
+#define	DA906X_GPIO4_PIN_MASK			0x03
+#define		DA906X_GPIO4_PIN_CORE_SW_S	0x00
+#define		DA906X_GPIO4_PIN_GPI		0x01
+#define		DA906X_GPIO4_PIN_GPO_OD		0x02
+#define		DA906X_GPIO4_PIN_GPO		0x03
+#define	DA906X_GPIO4_TYPE			0x04
+#define		DA906X_GPIO4_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO4_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO4_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO4_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO4_NO_WAKEUP			0x08
+#define	DA906X_GPIO5_PIN_SHIFT			4
+#define	DA906X_GPIO5_PIN_MASK			0x30
+#define		DA906X_GPIO5_PIN_PERI_SW_G	0x00
+#define		DA906X_GPIO5_PIN_GPI		0x10
+#define		DA906X_GPIO5_PIN_GPO_OD		0x20
+#define		DA906X_GPIO5_PIN_GPO		0x30
+#define	DA906X_GPIO5_TYPE			0x40
+#define		DA906X_GPIO5_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO5_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO5_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO5_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO5_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_6_7 (addr=0x18) */
+#define	DA906X_GPIO6_PIN_SHIFT			0
+#define	DA906X_GPIO6_PIN_MASK			0x03
+#define		DA906X_GPIO6_PIN_PERI_SW_S	0x00
+#define		DA906X_GPIO6_PIN_GPI		0x01
+#define		DA906X_GPIO6_PIN_GPO_OD		0x02
+#define		DA906X_GPIO6_PIN_GPO		0x03
+#define	DA906X_GPIO6_TYPE			0x04
+#define		DA906X_GPIO6_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO6_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO6_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO6_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO6_NO_WAKEUP			0x08
+#define	DA906X_GPIO7_PIN_SHIFT			4
+#define	DA906X_GPIO7_PIN_MASK			0x30
+#define		DA906X_GPIO7_PIN_GPI		0x10
+#define		DA906X_GPIO7_PIN_GPO_PSS	0x20
+#define		DA906X_GPIO7_PIN_GPO		0x30
+#define	DA906X_GPIO7_TYPE			0x40
+#define		DA906X_GPIO7_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO7_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO7_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO7_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO7_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_8_9 (addr=0x19) */
+#define	DA906X_GPIO8_PIN_SHIFT			0
+#define	DA906X_GPIO8_PIN_MASK			0x03
+#define		DA906X_GPIO8_PIN_GPI_SYS_EN	0x00
+#define		DA906X_GPIO8_PIN_GPI		0x01
+#define		DA906X_GPIO8_PIN_GPO_PSS	0x02
+#define		DA906X_GPIO8_PIN_GPO		0x03
+#define	DA906X_GPIO8_TYPE			0x04
+#define		DA906X_GPIO8_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO8_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO8_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO8_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO8_NO_WAKEUP			0x08
+#define	DA906X_GPIO9_PIN_SHIFT			4
+#define	DA906X_GPIO9_PIN_MASK			0x30
+#define		DA906X_GPIO9_PIN_GPI_PWR_EN	0x00
+#define		DA906X_GPIO9_PIN_GPI		0x10
+#define		DA906X_GPIO9_PIN_GPO_PSS	0x20
+#define		DA906X_GPIO9_PIN_GPO		0x30
+#define	DA906X_GPIO9_TYPE			0x40
+#define		DA906X_GPIO9_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO9_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO9_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO9_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO9_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_10_11 (addr=0x1A) */
+#define	DA906X_GPIO10_PIN_SHIFT			0
+#define	DA906X_GPIO10_PIN_MASK			0x03
+#define		DA906X_GPIO10_PIN_GPI_PWR1_EN	0x00
+#define		DA906X_GPIO10_PIN_GPI		0x01
+#define		DA906X_GPIO10_PIN_GPO_OD	0x02
+#define		DA906X_GPIO10_PIN_GPO		0x03
+#define	DA906X_GPIO10_TYPE			0x04
+#define		DA906X_GPIO10_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO10_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO10_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO10_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO10_NO_WAKEUP			0x08
+#define	DA906X_GPIO11_PIN_SHIFT			4
+#define	DA906X_GPIO11_PIN_MASK			0x30
+#define		DA906X_GPIO11_PIN_GPO_OD	0x00
+#define		DA906X_GPIO11_PIN_GPI		0x10
+#define		DA906X_GPIO11_PIN_GPO_PSS	0x20
+#define		DA906X_GPIO11_PIN_GPO		0x30
+#define	DA906X_GPIO11_TYPE			0x40
+#define		DA906X_GPIO11_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO11_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO11_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO11_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO11_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_12_13 (addr=0x1B) */
+#define	DA906X_GPIO12_PIN_SHIFT			0
+#define	DA906X_GPIO12_PIN_MASK			0x03
+#define		DA906X_GPIO12_PIN_NVDDFLT_OUT	0x00
+#define		DA906X_GPIO12_PIN_GPI		0x01
+#define		DA906X_GPIO12_PIN_VSYSMON_OUT	0x02
+#define		DA906X_GPIO12_PIN_GPO		0x03
+#define	DA906X_GPIO12_TYPE			0x04
+#define		DA906X_GPIO12_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO12_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO12_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO12_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO12_NO_WAKEUP			0x08
+#define	DA906X_GPIO13_PIN_SHIFT			4
+#define	DA906X_GPIO13_PIN_MASK			0x30
+#define		DA906X_GPIO13_PIN_GPFB1_OUT	0x00
+#define		DA906X_GPIO13_PIN_GPI		0x10
+#define		DA906X_GPIO13_PIN_GPFB1_OUTOD	0x20
+#define		DA906X_GPIO13_PIN_GPO		0x30
+#define	DA906X_GPIO13_TYPE			0x40
+#define		DA906X_GPIO13_TYPE_GPFB1_OUT	0x00
+#define		DA906X_GPIO13_TYPE_GPI		0x00
+#define		DA906X_GPIO13_TYPE_GPFB1_OUTOD	0x04
+#define		DA906X_GPIO13_TYPE_GPO		0x04
+#define	DA906X_GPIO13_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_14_15 (addr=0x1C) */
+#define	DA906X_GPIO14_PIN_SHIFT			0
+#define	DA906X_GPIO14_PIN_MASK			0x03
+#define		DA906X_GPIO14_PIN_GPO_OD	0x00
+#define		DA906X_GPIO14_PIN_GPI		0x01
+#define		DA906X_GPIO14_PIN_HS2DATA	0x02
+#define		DA906X_GPIO14_PIN_GPO		0x03
+#define	DA906X_GPIO14_TYPE			0x04
+#define		DA906X_GPIO14_TYPE_GPI_ACT_LOW	0x00
+#define		DA906X_GPIO14_TYPE_GPO_VDD_IO1	0x00
+#define		DA906X_GPIO14_TYPE_GPI_ACT_HIGH	0x04
+#define		DA906X_GPIO14_TYPE_GPO_VDD_IO2	0x04
+#define	DA906X_GPIO14_NO_WAKEUP			0x08
+#define	DA906X_GPIO15_PIN_SHIFT			4
+#define	DA906X_GPIO15_PIN_MASK			0x30
+#define		DA906X_GPIO15_PIN_GPO_OD	0x00
+#define		DA906X_GPIO15_PIN_GPI		0x10
+#define		DA906X_GPIO15_PIN_GPO		0x30
+#define	DA906X_GPIO15_TYPE			0x40
+#define		DA906X_GPIO15_TYPE_GPFB1_OUT	0x00
+#define		DA906X_GPIO15_TYPE_GPI		0x00
+#define		DA906X_GPIO15_TYPE_GPFB1_OUTOD	0x04
+#define		DA906X_GPIO15_TYPE_GPO		0x04
+#define	DA906X_GPIO15_NO_WAKEUP			0x80
+
+/* DA906X_REG_GPIO_MODE_0_7 (addr=0x1D) */
+#define	DA906X_GPIO0_MODE			0x01
+#define	DA906X_GPIO1_MODE			0x02
+#define	DA906X_GPIO2_MODE			0x04
+#define	DA906X_GPIO3_MODE			0x08
+#define	DA906X_GPIO4_MODE			0x10
+#define	DA906X_GPIO5_MODE			0x20
+#define	DA906X_GPIO6_MODE			0x40
+#define	DA906X_GPIO7_MODE			0x80
+
+/* DA906X_REG_GPIO_MODE_8_15 (addr=0x1E) */
+#define	DA906X_GPIO8_MODE			0x01
+#define	DA906X_GPIO9_MODE			0x02
+#define	DA906X_GPIO10_MODE			0x04
+#define	DA906X_GPIO11_MODE			0x08
+#define		DA906X_GPIO11_MODE_LED_ACT_HIGH	0x00
+#define		DA906X_GPIO11_MODE_LED_ACT_LOW	0x08
+#define	DA906X_GPIO12_MODE			0x10
+#define	DA906X_GPIO13_MODE			0x20
+#define	DA906X_GPIO14_MODE			0x40
+#define		DA906X_GPIO14_MODE_LED_ACT_HIGH	0x00
+#define		DA906X_GPIO14_MODE_LED_ACT_LOW	0x40
+#define	DA906X_GPIO15_MODE			0x80
+#define		DA906X_GPIO15_MODE_LED_ACT_HIGH	0x00
+#define		DA906X_GPIO15_MODE_LED_ACT_LOW	0x80
+
+/* DA906X_REG_SWITCH_CONT (addr=0x1F) */
+#define	DA906X_CORE_SW_GPI_SHIFT		0
+#define	DA906X_CORE_SW_GPI_MASK			0x03
+#define		DA906X_CORE_SW_GPI_OFF		0x00
+#define		DA906X_CORE_SW_GPI_GPIO1	0x01
+#define		DA906X_CORE_SW_GPI_GPIO2	0x02
+#define		DA906X_CORE_SW_GPI_GPIO13	0x03
+#define	DA906X_PERI_SW_GPI_SHIFT		2
+#define	DA906X_PERI_SW_GPI_MASK			0x0C
+#define		DA906X_PERI_SW_GPI_OFF		0x00
+#define		DA906X_PERI_SW_GPI_GPIO1	0x04
+#define		DA906X_PERI_SW_GPI_GPIO2	0x08
+#define		DA906X_PERI_SW_GPI_GPIO13	0x0C
+#define	DA906X_SWITCH_SR_SHIFT			4
+#define	DA906X_SWITCH_SR_MASK			0x30
+#define		DA906X_SWITCH_SR_1MV		0x00
+#define		DA906X_SWITCH_SR_5MV		0x10
+#define		DA906X_SWITCH_SR_10MV		0x20
+#define		DA906X_SWITCH_SR_50MV		0x30
+#define	DA906X_SWITCH_SR_DIS			0x40
+#define	DA906X_CP_EN_MODE			0x80
+
+/* DA906X_REGL_Bxxxx_CONT common bits (addr=0x20-0x25) */
+#define	DA906X_BUCK_EN				0x01
+#define	DA906X_BUCK_GPI_SHIFT			1
+#define DA906X_BUCK_GPI_MASK			0x06
+#define		DA906X_BUCK_GPI_OFF		0x00
+#define		DA906X_BUCK_GPI_GPIO1		0x02
+#define		DA906X_BUCK_GPI_GPIO2		0x04
+#define		DA906X_BUCK_GPI_GPIO13		0x06
+#define	DA906X_BUCK_CONF			0x08
+#define	DA906X_VBUCK_GPI_SHIFT			5
+#define	DA906X_VBUCK_GPI_MASK			0x60
+#define		DA906X_VBUCK_GPI_OFF		0x00
+#define		DA906X_VBUCK_GPI_GPIO1		0x20
+#define		DA906X_VBUCK_GPI_GPIO2		0x40
+#define		DA906X_VBUCK_GPI_GPIO13		0x60
+
+/* DA906X_REG_BCORE1_CONT specific bits (addr=0x21) */
+#define	DA906X_CORE_SW_EN			0x10
+#define	DA906X_CORE_SW_CONF			0x80
+
+/* DA906X_REG_BPERI_CONT specific bits (addr=0x25) */
+#define	DA906X_PERI_SW_EN			0x10
+#define	DA906X_PERI_SW_CONF			0x80
+
+/* DA906X_REG_LDOx_CONT common bits (addr=0x26-0x30) */
+#define	DA906X_LDO_EN				0x01
+#define	DA906X_LDO_GPI_SHIFT			1
+#define DA906X_LDO_GPI_MASK			0x06
+#define		DA906X_LDO_GPI_OFF		0x00
+#define		DA906X_LDO_GPI_GPIO1		0x02
+#define		DA906X_LDO_GPI_GPIO2		0x04
+#define		DA906X_LDO_GPI_GPIO13		0x06
+#define	DA906X_LDO_PD_DIS			0x08
+#define	DA906X_VLDO_GPI_SHIFT			5
+#define	DA906X_VLDO_GPI_MASK			0x60
+#define		DA906X_VLDO_GPI_OFF		0x00
+#define		DA906X_VLDO_GPI_GPIO1		0x20
+#define		DA906X_VLDO_GPI_GPIO2		0x40
+#define		DA906X_VLDO_GPI_GPIO13		0x60
+#define	DA906X_LDO_CONF				0x80
+
+/* DA906X_REG_LDO5_CONT specific bits (addr=0x2A) */
+#define	DA906X_VLDO5_SEL			0x10
+
+/* DA906X_REG_LDO6_CONT specific bits (addr=0x2B) */
+#define	DA906X_VLDO6_SEL			0x10
+
+/* DA906X_REG_LDO7_CONT specific bits (addr=0x2C) */
+#define	DA906X_VLDO7_SEL			0x10
+
+/* DA906X_REG_LDO8_CONT specific bits (addr=0x2D) */
+#define	DA906X_VLDO8_SEL			0x10
+
+/* DA906X_REG_LDO9_CONT specific bits (addr=0x2E) */
+#define	DA906X_VLDO9_SEL			0x10
+
+/* DA906X_REG_LDO10_CONT specific bits (addr=0x2F) */
+#define	DA906X_VLDO10_SEL			0x10
+
+/* DA906X_REG_LDO11_CONT specific bits (addr=0x30) */
+#define	DA906X_VLDO11_SEL			0x10
+
+/* DA906X_REG_VIB (addr=0x31) */
+#define DA906X_VIB_SET_MASK			0x3F
+#define		DA906X_VIB_SET_OFF		0
+#define		DA906X_VIB_SET_MAX		0x3F
+
+/* DA906X_REG_DVC_1 (addr=0x32) */
+#define	DA906X_VBCORE1_SEL			0x01
+#define	DA906X_VBCORE2_SEL			0x02
+#define	DA906X_VBPRO_SEL			0x04
+#define	DA906X_VBMEM_SEL			0x08
+#define	DA906X_VBPERI_SEL			0x10
+#define	DA906X_VLDO1_SEL			0x20
+#define	DA906X_VLDO2_SEL			0x40
+#define	DA906X_VLDO3_SEL			0x80
+
+/* DA906X_REG_DVC_2 (addr=0x33) */
+#define	DA906X_VBIO_SEL				0x01
+#define	DA906X_VLDO4_SEL			0x80
+
+/* DA906X_REG_ADC_MAN (addr=0x34) */
+#define	DA906X_ADC_MUX_SHIFT			0
+#define	DA906X_ADC_MUX_MASK			0x0F
+#define		DA906X_ADC_MUX_VSYS		0x00
+#define		DA906X_ADC_MUX_ADCIN1		0x01
+#define		DA906X_ADC_MUX_ADCIN2		0x02
+#define		DA906X_ADC_MUX_ADCIN3		0x03
+#define		DA906X_ADC_MUX_T_SENSE		0x04
+#define		DA906X_ADC_MUX_VBBAT		0x05
+#define		DA906X_ADC_MUX_LDO_G1		0x08
+#define		DA906X_ADC_MUX_LDO_G2		0x09
+#define		DA906X_ADC_MUX_LDO_G3		0x0A
+#define	DA906X_ADC_MAN				0x10
+#define	DA906X_ADC_MODE				0x20
+
+/* DA906X_REG_ADC_CONT (addr=0x35) */
+#define	DA906X_ADC_AUTO_VSYS_EN			0x01
+#define	DA906X_ADC_AUTO_AD1_EN			0x02
+#define	DA906X_ADC_AUTO_AD2_EN			0x04
+#define	DA906X_ADC_AUTO_AD3_EN			0x08
+#define	DA906X_ADC_AD1_ISRC_EN			0x10
+#define	DA906X_ADC_AD2_ISRC_EN			0x20
+#define	DA906X_ADC_AD3_ISRC_EN			0x40
+#define	DA906X_COMP1V2_EN			0x80
+
+/* DA906X_REG_VSYS_MON (addr=0x36) */
+#define	DA906X_VSYS_VAL_SHIFT			0
+#define	DA906X_VSYS_VAL_MASK			0xFF
+#define	DA906X_VSYS_VAL_BASE			0x00
+
+/* DA906X_REG_ADC_RES_L (addr=0x37) */
+#define	DA906X_ADC_RES_L_SHIFT			6
+#define	DA906X_ADC_RES_L_BITS			2
+#define	DA906X_ADC_RES_L_MASK			0xC0
+
+/* DA906X_REG_ADC_RES_H (addr=0x38) */
+#define	DA906X_ADC_RES_M_SHIFT			0
+#define	DA906X_ADC_RES_M_BITS			8
+#define	DA906X_ADC_RES_M_MASK			0xFF
+
+/* DA906X_REG_(xxx_RES/ADC_RES_H) (addr=0x39-0x3F) */
+#define	DA906X_ADC_VAL_SHIFT			0
+#define	DA906X_ADC_VAL_MASK			0xFF
+
+/* DA906X_REG_COUNT_S (addr=0x40) */
+#define DA906X_RTC_READ				0x80
+#define DA906X_COUNT_SEC_MASK			0x3F
+
+/* DA906X_REG_COUNT_MI (addr=0x41) */
+#define DA906X_COUNT_MIN_MASK			0x3F
+
+/* DA906X_REG_COUNT_H (addr=0x42) */
+#define DA906X_COUNT_HOUR_MASK			0x1F
+
+/* DA906X_REG_COUNT_D (addr=0x43) */
+#define DA906X_COUNT_DAY_MASK			0x1F
+
+/* DA906X_REG_COUNT_MO (addr=0x44) */
+#define DA906X_COUNT_MONTH_MASK			0x0F
+
+/* DA906X_REG_COUNT_Y (addr=0x45) */
+#define DA906X_COUNT_YEAR_MASK			0x3F
+#define DA906X_MONITOR				0x40
+
+/* DA906X_REG_ALARM_MI (addr=0x46) */
+#define DA906X_ALARM_STATUS_ALARM		0x80
+#define DA906X_ALARM_STATUS_TICK		0x40
+#define DA906X_ALARM_MIN_MASK			0x3F
+
+/* DA906X_REG_ALARM_H (addr=0x47) */
+#define DA906X_ALARM_HOUR_MASK			0x1F
+
+/* DA906X_REG_ALARM_D (addr=0x48) */
+#define DA906X_ALARM_DAY_MASK			0x1F
+
+/* DA906X_REG_ALARM_MO (addr=0x49) */
+#define DA906X_TICK_WAKE			0x20
+#define DA906X_TICK_TYPE			0x10
+#define		DA906X_TICK_TYPE_SEC		0x00
+#define		DA906X_TICK_TYPE_MIN		0x10
+#define DA906X_ALARM_MONTH_MASK			0x0F
+
+/* DA906X_REG_ALARM_Y (addr=0x4A) */
+#define DA906X_TICK_ON				0x80
+#define DA906X_ALARM_ON				0x40
+#define DA906X_ALARM_YEAR_MASK			0x3F
+
+/* DA906X_REG_WAIT (addr=0x97)*/
+#define	DA906X_REG_WAIT_TIME_SHIFT		0
+#define	DA906X_REG_WAIT_TIME_MASK		0xF
+#define	DA906X_WAIT_TIME_0_US			0x0
+#define	DA906X_WAIT_TIME_512_US			0x1
+#define	DA906X_WAIT_TIME_1_MS			0x2
+#define	DA906X_WAIT_TIME_2_MS			0x3
+#define	DA906X_WAIT_TIME_4_1_MS			0x4
+#define	DA906X_WAIT_TIME_8_2_MS			0x5
+#define	DA906X_WAIT_TIME_16_4_MS		0x6
+#define	DA906X_WAIT_TIME_32_8_MS		0x7
+#define	DA906X_WAIT_TIME_65_5_MS		0x8
+#define	DA906X_WAIT_TIME_128_MS			0x9
+#define	DA906X_WAIT_TIME_256_MS			0xA
+#define	DA906X_WAIT_TIME_512_MS			0xB
+#define	DA906X_WAIT_TIME_1_S			0xC
+#define	DA906X_WAIT_TIME_2_1_S			0xD
+
+/* DA906X_REG_EN_32K  (addr=0x98)*/
+#define	DA906X_STABILIZ_TIME_SHIFT		0
+#define	DA906X_STABILIZ_TIME_MASK		0x7
+#define	DA906X_CRYSTAL				0x08
+#define	DA906X_DELAY_MODE			0x10
+#define	DA906X_OUT_CLOCK			0x20
+#define	DA906X_RTC_CLOCK			0x40
+#define	DA906X_OUT_32K_EN			0x80
+
+/* DA906X_REG_CHIP_VARIANT */
+#define	DA906X_CHIP_VARIANT_SHIFT		4
+
+/* DA906X_REG_BUCK_ILIM_A (addr=0x9A) */
+#define DA906X_BIO_ILIM_SHIFT			0
+#define DA906X_BIO_ILIM_MASK			0x0F
+#define DA906X_BMEM_ILIM_SHIFT			4
+#define DA906X_BMEM_ILIM_MASK			0x0F
+
+/* DA906X_REG_BUCK_ILIM_B (addr=0x9B) */
+#define DA906X_BPRO_ILIM_SHIFT			0
+#define DA906X_BPRO_ILIM_MASK			0x0F
+#define DA906X_BPERI_ILIM_SHIFT			4
+#define DA906X_BPERI_ILIM_MASK			0x0F
+
+/* DA906X_REG_BUCK_ILIM_C (addr=0x9C) */
+#define DA906X_BCORE1_ILIM_SHIFT		0
+#define DA906X_BCORE1_ILIM_MASK			0x0F
+#define DA906X_BCORE2_ILIM_SHIFT		4
+#define DA906X_BCORE2_ILIM_MASK			0x0F
+
+/* DA906X_REG_Bxxxx_CFG common bits (addr=0x9D-0xA2) */
+#define DA906X_BUCK_FB_MASK			0x07
+#define DA906X_BUCK_PD_DIS_SHIFT		5
+#define DA906X_BUCK_MODE_SHIFT			6
+#define DA906X_BUCK_MODE_MASK			0xC0
+#define		DA906X_BUCK_MODE_MANUAL		0x00
+#define		DA906X_BUCK_MODE_SLEEP		0x40
+#define		DA906X_BUCK_MODE_SYNC		0x80
+#define		DA906X_BUCK_MODE_AUTO		0xC0
+
+/* DA906X_REG_BPRO_CFG (addr=0x9F) */
+#define	DA906X_BPRO_VTTR_EN			0x08
+#define	DA906X_BPRO_VTT_EN			0x10
+
+/* DA906X_REG_VBxxxx_A/B (addr=0xA3-0xA8, 0xB4-0xB9) */
+#define DA906X_VBUCK_SHIFT			0
+#define DA906X_VBUCK_MASK			0x7F
+#define DA906X_VBUCK_BIAS			0
+#define DA906X_BUCK_SL				0x80
+
+/* DA906X_REG_VLDOx_A/B (addr=0xA9-0x3, 0xBA-0xC4) */
+#define DA906X_LDO_SL				0x80
+
+/* DA906X_REG_VLDO1_A/B (addr=0xA9, 0xBA) */
+#define DA906X_VLDO1_MASK			0x3F
+#define DA906X_VLDO1_SHIFT			0
+#define DA906X_VLDO1_BIAS			0
+
+/* DA906X_REG_VLDO2_A/B (addr=0xAA, 0xBB) */
+#define DA906X_VLDO2_MASK			0x3F
+#define DA906X_VLDO2_SHIFT			0
+#define DA906X_VLDO2_BIAS			0
+
+/* DA906X_REG_VLDO3_A/B (addr=0xAB, 0xBC) */
+#define DA906X_VLDO3_MASK			0x7F
+#define DA906X_VLDO3_SHIFT			0
+#define DA906X_VLDO3_BIAS			0
+
+/* DA906X_REG_VLDO4_A/B (addr=0xAC, 0xBD) */
+#define DA906X_VLDO4_MASK			0x7F
+#define DA906X_VLDO4_SHIFT			0
+#define DA906X_VLDO4_BIAS			0
+
+/* DA906X_REG_VLDO5_A/B (addr=0xAD, 0xBE) */
+#define DA906X_VLDO5_MASK			0x3F
+#define DA906X_VLDO5_SHIFT			0
+#define DA906X_VLDO5_BIAS			2
+
+/* DA906X_REG_VLDO6_A/B (addr=0xAE, 0xBF) */
+#define DA906X_VLDO6_MASK			0x3F
+#define DA906X_VLDO6_SHIFT			0
+#define DA906X_VLDO6_BIAS			2
+
+/* DA906X_REG_VLDO7_A/B (addr=0xAF, 0xC0) */
+#define DA906X_VLDO7_MASK			0x3F
+#define DA906X_VLDO7_SHIFT			0
+#define DA906X_VLDO7_BIAS			2
+
+/* DA906X_REG_VLDO8_A/B (addr=0xB0, 0xC1) */
+#define DA906X_VLDO8_MASK			0x3F
+#define DA906X_VLDO8_SHIFT			0
+#define DA906X_VLDO8_BIAS			2
+
+/* DA906X_REG_VLDO9_A/B (addr=0xB1, 0xC2) */
+#define DA906X_VLDO9_MASK			0x3F
+#define DA906X_VLDO9_SHIFT			0
+#define DA906X_VLDO9_BIAS			3
+
+/* DA906X_REG_VLDO10_A/B (addr=0xB2, 0xC3) */
+#define DA906X_VLDO10_MASK			0x3F
+#define DA906X_VLDO10_SHIFT			0
+#define DA906X_VLDO10_BIAS			2
+
+/* DA906X_REG_VLDO11_A/B (addr=0xB3, 0xC4) */
+#define DA906X_VLDO11_MASK			0x3F
+#define DA906X_VLDO11_SHIFT			0
+#define DA906X_VLDO11_BIAS			2
+
+/* DA906X_REG_GPO11_LED (addr=0xC6) */
+/* DA906X_REG_GPO14_LED (addr=0xC7) */
+/* DA906X_REG_GPO15_LED (addr=0xC8) */
+#define DA906X_GPIO_DIM				0x80
+#define DA906X_GPIO_PWM_SHIFT			0
+#define DA906X_GPIO_PWM_MASK			0x7F
+
+/* DA906X_REG_CONFIG_H (addr=0x10D) */
+#define DA906X_PWM_CLK_MASK			0x01
+#define		DA906X_PWM_CLK_PWM2MHZ		0x00
+#define		DA906X_PWM_CLK_PWM1MHZ		0x01
+#define DA906X_LDO8_MODE_MASK			0x02
+#define		DA906X_LDO8_MODE_LDO		0
+#define		DA906X_LDO8_MODE_VIBR		0x02
+#define DA906X_MERGE_SENSE_MASK			0x04
+#define 	DA906X_MERGE_SENSE_GP_FB2	0x00
+#define 	DA906X_MERGE_SENSE_GPIO4	0x04
+#define DA906X_BCORE_MERGE			0x08
+#define DA906X_BPRO_OD				0x10
+#define DA906X_BCORE2_OD			0x20
+#define DA906X_BCORE1_OD			0x40
+#define DA906X_BUCK_MERGE			0x80
+
+/* DA906X_REG_CONFIG_I (addr=0x10E) */
+#define DA906X_NONKEY_PIN_MASK			0x03
+#define		DA906X_NONKEY_PIN_PORT		0x00
+#define		DA906X_NONKEY_PIN_SWDOWN	0x01
+#define		DA906X_NONKEY_PIN_AUTODOWN	0x02
+#define		DA906X_NONKEY_PIN_AUTOFLPRT	0x03
+
+/* DA906X_REG_MON_REG_5 (addr=0x116) */
+#define DA906X_MON_A8_IDX_SHIFT			0
+#define DA906X_MON_A8_IDX_MASK			0x07
+#define		DA9063_MON_A8_IDX_NONE		0x00
+#define		DA9063_MON_A8_IDX_BCORE1	0x01
+#define		DA9063_MON_A8_IDX_BCORE2	0x02
+#define		DA9063_MON_A8_IDX_BPRO		0x03
+#define		DA9063_MON_A8_IDX_LDO3		0x04
+#define		DA9063_MON_A8_IDX_LDO4		0x05
+#define		DA9063_MON_A8_IDX_LDO11		0x06
+#define DA906X_MON_A9_IDX_SHIFT			4
+#define DA906X_MON_A9_IDX_MASK			0x70
+#define		DA9063_MON_A9_IDX_NONE		0x00
+#define		DA9063_MON_A9_IDX_BIO		0x01
+#define		DA9063_MON_A9_IDX_BMEM		0x02
+#define		DA9063_MON_A9_IDX_BPERI		0x03
+#define		DA9063_MON_A9_IDX_LDO1		0x04
+#define		DA9063_MON_A9_IDX_LDO2		0x05
+#define		DA9063_MON_A9_IDX_LDO5		0x06
+
+/* DA906X_REG_MON_REG_6 (addr=0x117) */
+#define DA906X_MON_A10_IDX_SHIFT		0
+#define DA906X_MON_A10_IDX_MASK			0x07
+#define		DA9063_MON_A10_IDX_NONE		0x00
+#define		DA9063_MON_A10_IDX_LDO6		0x01
+#define		DA9063_MON_A10_IDX_LDO7		0x02
+#define		DA9063_MON_A10_IDX_LDO8		0x03
+#define		DA9063_MON_A10_IDX_LDO9		0x04
+#define		DA9063_MON_A10_IDX_LDO10	0x05
+
+#endif /* _DA906X_REG_H */
+
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
