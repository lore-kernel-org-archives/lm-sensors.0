From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 13:55:00 +0000
Subject: [lm-sensors] [RFC PATCH 2/8] regulator: Add Dialog DA906x voltage regulators support.
Message-Id: <201208241455@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241450@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241450@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

The driver adds support for the following DA9063 PMIC regulators:
 - 11x LDOs (named LDO1 - LDO11),
 - 6x buck converters (BCORE1, BCORE2, BPRO, BMEM, BIO, BPERI),
 - 1x power switch to switch on/off 32 KHz oscilator output (32K_OUT).

Regulators provide following operations:
 - REGULATOR_CHANGE_STATUS for all regulators,
 - REGULATOR_CHANGE_VOLTAGE for LDOs and buck converters,
 - REGULATOR_CHANGE_MODE for LDOs and buck converters, where:
     - LDOs allow REGULATOR_MODE_NORMAL and REGULATOR_MODE_STANDBY,
     - buck converters allow REGULATOR_MODE_FAST, REGULATOR_MODE_NORMAL
       and REGULATOR_MODE_STANDBY,
 - REGULATOR_CHANGE_CURRENT for buck converters (current limits).

The driver generates REGULATOR_EVENT_OVER_CURRENT for LDO3, LDO4, LDO7, LDO8
and LDO11.

Internally, PMIC provides two voltage configurations for normal and suspend
system state for each regulator. The driver switches between those on
suspend/wake-up to provide quick and fluent output voltage change.

This driver requires MFD core driver for operation.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/regulator/Kconfig            |    6 +
 drivers/regulator/Makefile           |    1 +
 drivers/regulator/da906x-regulator.c | 1018 ++++++++++++++++++++++++++++++++++
 3 files changed, 1025 insertions(+), 0 deletions(-)
 create mode 100644 drivers/regulator/da906x-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4e932cc..b57b6c6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -110,6 +110,12 @@ config REGULATOR_DA9052
 	  This driver supports the voltage regulators of DA9052-BC and
 	  DA9053-AA/Bx PMIC.
 
+config REGULATOR_DA906X
+	bool "Dialog DA906X Regulator family chip"
+	depends on MFD_DA906X
+	help
+	  Support for Dialog Semiconductor DA906x chip.
+
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
 	depends on MFD_ANATOP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3342615..46a503a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA) += arizona-micsupp.o arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
+obj-$(CONFIG_REGULATOR_DA906X) += da906x-regulator.o
 obj-$(CONFIG_REGULATOR_DBX500_PRCMU) += dbx500-prcmu.o
 obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
diff --git a/drivers/regulator/da906x-regulator.c b/drivers/regulator/da906x-regulator.c
new file mode 100644
index 0000000..1b68de0
--- /dev/null
+++ b/drivers/regulator/da906x-regulator.c
@@ -0,0 +1,1018 @@
+/*
+ * Regulator driver for DA906x PMIC series
+ *
+ * Copyright 2012 Dialog Semiconductors Ltd.
+ *
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+#include <linux/mfd/da906x/registers.h>
+
+
+/* Definition for registering bit fields */
+struct bfield {
+	unsigned short	addr;
+	unsigned char	mask;
+};
+#define BFIELD(_addr, _mask) \
+	{ .addr = _addr, .mask = _mask }
+
+struct field {
+	unsigned short	addr;
+	unsigned char	mask;
+	unsigned char	shift;
+	unsigned char	offset;
+};
+#define FIELD(_addr, _mask, _shift, _offset) \
+	{ .addr = _addr, .mask = _mask, .shift = _shift, .offset = _offset }
+
+/* Regulator capabilities and registers description */
+struct da906x_regulator_info {
+	int			id;
+	char			*name;
+	struct regulator_ops	*ops;
+
+	/* Voltage adjust range */
+	int		min_uV;
+	int		max_uV;
+	unsigned	step_uV;
+	unsigned	n_steps;
+
+	/* Current limiting */
+	unsigned	n_current_limits;
+	const int	*current_limits;
+
+	/* DA906x main register fields */
+	struct bfield	enable;		/* bit used to enable regulator,
+					   it returns actual state when read */
+	struct field	mode;		/* buck mode of operation */
+	struct bfield	suspend;
+	struct bfield	sleep;
+	struct bfield	suspend_sleep;
+	struct field	voltage;
+	struct field	suspend_voltage;
+	struct field	ilimit;
+
+	/* DA906x event detection bit */
+	struct bfield	oc_event;
+};
+
+/* Macro for switch regulator */
+#define DA906X_SWITCH(chip, regl_name) \
+	.id = chip##_ID_##regl_name, \
+	.name = __stringify(chip##_##regl_name), \
+	.ops = &da906x_switch_ops, \
+	.n_steps = 0
+
+/* Macros for LDO */
+#define DA906X_LDO(chip, regl_name, min_mV, step_mV, max_mV) \
+	.id = chip##_ID_##regl_name, \
+	.name = __stringify(chip##_##regl_name), \
+	.ops = &da906x_ldo_ops, \
+	.min_uV = (min_mV) * 1000, \
+	.max_uV = (max_mV) * 1000, \
+	.step_uV = (step_mV) * 1000, \
+	.n_steps = (((max_mV) - (min_mV))/(step_mV) + 1)
+
+#define DA906X_LDO_COMMON_FIELDS(regl_name) \
+	.enable = BFIELD(DA906X_REG_##regl_name##_CONT, DA906X_LDO_EN), \
+	.sleep = BFIELD(DA906X_REG_V##regl_name##_A, DA906X_LDO_SL), \
+	.suspend_sleep = BFIELD(DA906X_REG_V##regl_name##_B, DA906X_LDO_SL), \
+	.voltage = FIELD(DA906X_REG_V##regl_name##_A, \
+			DA906X_V##regl_name##_MASK, \
+			DA906X_V##regl_name##_SHIFT, \
+			DA906X_V##regl_name##_BIAS), \
+	.suspend_voltage = FIELD(DA906X_REG_V##regl_name##_B, \
+			DA906X_V##regl_name##_MASK,\
+			DA906X_V##regl_name##_SHIFT, \
+			DA906X_V##regl_name##_BIAS)
+
+/* Macros for voltage DC/DC converters (BUCKs) */
+#define DA906X_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array) \
+	.id = chip##_ID_##regl_name, \
+	.name = __stringify(chip##_##regl_name), \
+	.ops = &da906x_buck_ops, \
+	.min_uV = (min_mV) * 1000, \
+	.max_uV = (max_mV) * 1000, \
+	.step_uV = (step_mV) * 1000, \
+	.n_steps = ((max_mV) - (min_mV))/(step_mV) + 1, \
+	.current_limits = limits_array, \
+	.n_current_limits = ARRAY_SIZE(limits_array)
+
+#define DA906X_BUCK_COMMON_FIELDS(regl_name) \
+	.enable = BFIELD(DA906X_REG_##regl_name##_CONT, DA906X_BUCK_EN), \
+	.sleep = BFIELD(DA906X_REG_V##regl_name##_A, DA906X_BUCK_SL), \
+	.suspend_sleep = BFIELD(DA906X_REG_V##regl_name##_B, DA906X_BUCK_SL), \
+	.voltage = FIELD(DA906X_REG_V##regl_name##_A, \
+			 DA906X_VBUCK_MASK, \
+			 DA906X_VBUCK_SHIFT, \
+			 DA906X_VBUCK_BIAS), \
+	.suspend_voltage = FIELD(DA906X_REG_V##regl_name##_B, \
+				 DA906X_VBUCK_MASK,\
+				 DA906X_VBUCK_SHIFT, \
+				 DA906X_VBUCK_BIAS), \
+	.mode = FIELD(DA906X_REG_##regl_name##_CFG, DA906X_BUCK_MODE_MASK, \
+		      DA906X_BUCK_MODE_SHIFT, 0)
+
+/* Defines asignment of regulators info table to chip model */
+struct da906x_dev_model {
+	const struct da906x_regulator_info	*regulator_info;
+	unsigned				n_regulators;
+	unsigned				dev_model;
+};
+
+/* Single regulator settings */
+struct da906x_regulator {
+	struct regulator_desc			desc;
+	struct regulator_dev			*rdev;
+	struct da906x				*hw;
+	const struct da906x_regulator_info	*info;
+
+	unsigned				mode;
+	unsigned				suspend_mode;
+};
+
+/* Encapsulates all information for the regulators driver */
+struct da906x_regulators {
+	int					irq_ldo_lim;
+	int					irq_uvov;
+
+	unsigned				n_regulators;
+	/* Array size to be defined during init. Keep at end. */
+	struct da906x_regulator			regulator[0];
+};
+
+/* System states for da906x_update_mode_internal()
+   and for da906x_get_mode_internal() */
+enum {
+	SYS_STATE_NORMAL,
+	SYS_STATE_SUSPEND,
+	SYS_STATE_CURRENT
+};
+
+/* BUCK modes for DA906x */
+enum {
+	BUCK_MODE_MANUAL,	/* 0 */
+	BUCK_MODE_SLEEP,	/* 1 */
+	BUCK_MODE_SYNC,		/* 2 */
+	BUCK_MODE_AUTO		/* 3 */
+};
+
+/* Regulator operations */
+static int da906x_set_voltage(struct regulator_dev *rdev, int min_uV,
+			      int max_uV, unsigned *selector);
+static int da906x_get_voltage_sel(struct regulator_dev *rdev);
+static int da906x_set_current_limit(struct regulator_dev *rdev,
+				    int min_uA, int max_uA);
+static int da906x_get_current_limit(struct regulator_dev *rdev);
+static int da906x_enable(struct regulator_dev *rdev);
+static int da906x_set_mode(struct regulator_dev *rdev, unsigned int mode);
+static unsigned da906x_get_mode(struct regulator_dev *rdev);
+static int da906x_get_status(struct regulator_dev *rdev);
+static int da906x_set_suspend_voltage(struct regulator_dev *rdev, int uV);
+static int da906x_suspend_enable(struct regulator_dev *rdev);
+static int da906x_set_suspend_mode(struct regulator_dev *rdev, unsigned mode);
+
+static struct regulator_ops da906x_switch_ops = {
+	.enable			= da906x_enable,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_suspend_enable	= da906x_enable,
+	.set_suspend_disable	= regulator_disable_regmap,
+};
+
+static struct regulator_ops da906x_ldo_ops = {
+	.enable			= da906x_enable,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage		= da906x_set_voltage,
+	.get_voltage_sel	= da906x_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear,
+	.set_mode		= da906x_set_mode,
+	.get_mode		= da906x_get_mode,
+	.get_status		= da906x_get_status,
+	.set_suspend_voltage	= da906x_set_suspend_voltage,
+	.set_suspend_enable	= da906x_suspend_enable,
+	.set_suspend_disable	= regulator_disable_regmap,
+	.set_suspend_mode	= da906x_set_suspend_mode,
+};
+
+static struct regulator_ops da906x_buck_ops = {
+	.enable			= da906x_enable,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.set_voltage		= da906x_set_voltage,
+	.get_voltage_sel	= da906x_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear,
+	.set_current_limit	= da906x_set_current_limit,
+	.get_current_limit	= da906x_get_current_limit,
+	.set_mode		= da906x_set_mode,
+	.get_mode		= da906x_get_mode,
+	.get_status		= da906x_get_status,
+	.set_suspend_voltage	= da906x_set_suspend_voltage,
+	.set_suspend_enable	= da906x_suspend_enable,
+	.set_suspend_disable	= regulator_disable_regmap,
+	.set_suspend_mode	= da906x_set_suspend_mode,
+};
+
+/* Current limits array (in uA) for BCORE1, BCORE2, BPRO.
+   Entry indexes corresponds to register values. */
+static const int da9063_buck_a_limits[] = {
+	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
+	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
+};
+
+/* Current limits array (in uA) for BMEM, BIO, BPERI.
+   Entry indexes corresponds to register values. */
+static const int da9063_buck_b_limits[] = {
+	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
+	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
+};
+
+/* Current limits array (in uA) for merged BCORE1 and BCORE2.
+   Entry indexes corresponds to register values. */
+static const int da9063_bcores_merged_limits[] = {
+	1000000, 1200000, 1400000, 1600000, 1800000, 2000000, 2200000, 2400000,
+	2600000, 2800000, 3000000, 3200000, 3400000, 3600000, 3800000, 4000000
+};
+
+/* Current limits array (in uA) for merged BMEM and BIO.
+   Entry indexes corresponds to register values. */
+static const int da9063_bmem_bio_merged_limits[] = {
+	3000000, 3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000,
+	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
+};
+
+/* Info of regulators for DA9063 */
+static const struct da906x_regulator_info da9063_regulator_info[] = {
+	{
+		DA906X_BUCK(DA9063, BCORE1, 300, 10, 1570,
+			    da9063_buck_a_limits),
+		DA906X_BUCK_COMMON_FIELDS(BCORE1),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBCORE1_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_C, DA906X_BCORE1_ILIM_MASK,
+				DA906X_BCORE1_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BCORE2, 300, 10, 1570,
+			    da9063_buck_a_limits),
+		DA906X_BUCK_COMMON_FIELDS(BCORE2),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBCORE2_SEL),
+
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_C,
+				DA906X_BCORE2_ILIM_MASK,
+				DA906X_BCORE2_ILIM_SHIFT,
+				0),
+	},
+	{
+		DA906X_BUCK(DA9063, BPRO, 530, 10, 1800,
+			    da9063_buck_a_limits),
+		DA906X_BUCK_COMMON_FIELDS(BPRO),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBPRO_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_B, DA906X_BPRO_ILIM_MASK,
+				DA906X_BPRO_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BMEM, 800, 20, 3340,
+			    da9063_buck_b_limits),
+		DA906X_BUCK_COMMON_FIELDS(BMEM),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBMEM_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_A, DA906X_BMEM_ILIM_MASK,
+				DA906X_BMEM_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BIO, 800, 20, 3340,
+			    da9063_buck_b_limits),
+		DA906X_BUCK_COMMON_FIELDS(BIO),
+		.suspend = BFIELD(DA906X_REG_DVC_2, DA906X_VBIO_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_A, DA906X_BIO_ILIM_MASK,
+				DA906X_BIO_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BPERI, 800, 20, 3340,
+			    da9063_buck_b_limits),
+		DA906X_BUCK_COMMON_FIELDS(BPERI),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBPERI_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_B, DA906X_BPERI_ILIM_MASK,
+				DA906X_BPERI_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
+			    da9063_bcores_merged_limits),
+		/* BCORES_MERGED uses the same register fields as BCORE1 */
+		DA906X_BUCK_COMMON_FIELDS(BCORE1),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBCORE1_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_C, DA906X_BCORE1_ILIM_MASK,
+				DA906X_BCORE1_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
+			    da9063_bmem_bio_merged_limits),
+		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
+		DA906X_BUCK_COMMON_FIELDS(BMEM),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VBMEM_SEL),
+		.ilimit = FIELD(DA906X_REG_BUCK_ILIM_A, DA906X_BMEM_ILIM_MASK,
+				DA906X_BMEM_ILIM_SHIFT, 0),
+	},
+	{
+		DA906X_LDO(DA9063, LDO1, 600, 20, 1860),
+		DA906X_LDO_COMMON_FIELDS(LDO1),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VLDO1_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO2, 600, 20, 1860),
+		DA906X_LDO_COMMON_FIELDS(LDO2),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VLDO2_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO3, 900, 20, 3440),
+		DA906X_LDO_COMMON_FIELDS(LDO3),
+		.suspend = BFIELD(DA906X_REG_DVC_1, DA906X_VLDO3_SEL),
+		.oc_event = BFIELD(DA906X_REG_STATUS_D, DA906X_LDO3_LIM),
+	},
+	{
+		DA906X_LDO(DA9063, LDO4, 900, 20, 3440),
+		DA906X_LDO_COMMON_FIELDS(LDO4),
+		.suspend = BFIELD(DA906X_REG_DVC_2, DA906X_VLDO4_SEL),
+		.oc_event = BFIELD(DA906X_REG_STATUS_D, DA906X_LDO4_LIM),
+	},
+	{
+		DA906X_LDO(DA9063, LDO5, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO5),
+		.suspend = BFIELD(DA906X_REG_LDO5_CONT, DA906X_VLDO5_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO6, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO6),
+		.suspend = BFIELD(DA906X_REG_LDO6_CONT, DA906X_VLDO6_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO7, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO7),
+		.suspend = BFIELD(DA906X_REG_LDO7_CONT, DA906X_VLDO7_SEL),
+		.oc_event = BFIELD(DA906X_REG_STATUS_D, DA906X_LDO7_LIM),
+	},
+	{
+		DA906X_LDO(DA9063, LDO8, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO8),
+		.suspend = BFIELD(DA906X_REG_LDO8_CONT, DA906X_VLDO8_SEL),
+		.oc_event = BFIELD(DA906X_REG_STATUS_D, DA906X_LDO8_LIM),
+	},
+	{
+		DA906X_LDO(DA9063, LDO9, 950, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO9),
+		.suspend = BFIELD(DA906X_REG_LDO9_CONT, DA906X_VLDO9_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO10, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO10),
+		.suspend = BFIELD(DA906X_REG_LDO10_CONT, DA906X_VLDO10_SEL),
+	},
+	{
+		DA906X_LDO(DA9063, LDO11, 900, 50, 3600),
+		DA906X_LDO_COMMON_FIELDS(LDO11),
+		.suspend = BFIELD(DA906X_REG_LDO11_CONT, DA906X_VLDO11_SEL),
+		.oc_event = BFIELD(DA906X_REG_STATUS_D, DA906X_LDO11_LIM),
+	},
+	{
+		DA906X_SWITCH(DA9063, 32K_OUT),
+		.enable = BFIELD(DA906X_REG_EN_32K, DA906X_OUT_32K_EN),
+	},
+};
+
+/* Link chip model with regulators info table */
+static struct da906x_dev_model regulators_models[] = {
+	{
+		.regulator_info = da9063_regulator_info,
+		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
+		.dev_model = PMIC_DA9063,
+	},
+	{NULL, 0, 0}	/* End of list */
+};
+
+
+/*
+ * Regulator internal functions
+ */
+static int da906x_update_mode_internal(struct da906x_regulator *regl,
+				       int sys_state)
+{
+	const struct da906x_regulator_info *rinfo = regl->info;
+	unsigned val;
+	unsigned mode;
+	int ret;
+
+	if (sys_state = SYS_STATE_SUSPEND)
+		/* Get mode for regulator in suspend state */
+		mode = regl->suspend_mode;
+	else
+		/* Get mode for regulator in normal operation */
+		mode = regl->mode;
+
+	/* LDOs use sleep flags - one for normal and one for suspend state.
+	   For BUCKs single mode register field is used in normal and
+	   suspend state. */
+	if (rinfo->mode.addr) {
+		/* Set mode for BUCK - 3 modes are supported */
+		switch (mode) {
+		case REGULATOR_MODE_FAST:
+			val = BUCK_MODE_SYNC;
+			break;
+		case REGULATOR_MODE_NORMAL:
+			val = BUCK_MODE_AUTO;
+			break;
+		case REGULATOR_MODE_STANDBY:
+			val = BUCK_MODE_SLEEP;
+			break;
+		default:
+			return -EINVAL;
+		}
+		val = val << rinfo->mode.shift;
+
+		ret = da906x_reg_update(regl->hw, rinfo->mode.addr,
+					rinfo->mode.mask, val);
+	} else {
+		/* Set mode for LDO - 2 modes are supported */
+		switch (mode) {
+		case REGULATOR_MODE_NORMAL:
+			val = 0;
+			break;
+		case REGULATOR_MODE_STANDBY:
+			val = DA906X_LDO_SL;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (sys_state = SYS_STATE_SUSPEND) {
+			if (!rinfo->suspend_sleep.addr)
+				return -EINVAL;
+			ret = da906x_reg_update(regl->hw,
+						rinfo->suspend_sleep.addr,
+						rinfo->suspend_sleep.mask,
+						val);
+		} else {
+			if (!rinfo->sleep.addr)
+				return -EINVAL;
+			ret = da906x_reg_update(regl->hw,
+						rinfo->sleep.addr,
+						rinfo->sleep.mask, val);
+		}
+	}
+
+	return ret;
+}
+
+static unsigned da906x_get_mode_internal(struct da906x_regulator *regl,
+					 int sys_state)
+{
+	const struct da906x_regulator_info *rinfo = regl->info;
+	int val;
+	int addr;
+	int mask;
+	unsigned mode = 0;
+
+	/* Bucks use single mode register field for normal operation
+	   and suspend state. LDOs use sleep flags - one for normal
+	   and one for suspend state. */
+	if (rinfo->mode.addr) {
+		/* For BUCKs, there are 3 modes to map to */
+		val = da906x_reg_read(regl->hw, rinfo->mode.addr);
+		if (val < 0)
+			return val;
+
+		val = (val & rinfo->mode.mask) >> rinfo->mode.shift;
+		switch (val) {
+		default:
+		case BUCK_MODE_MANUAL:
+			mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
+			/* Sleep flag bit decides the mode */
+			break;
+		case BUCK_MODE_SLEEP:
+			return REGULATOR_MODE_STANDBY;
+		case BUCK_MODE_SYNC:
+			return REGULATOR_MODE_FAST;
+		case BUCK_MODE_AUTO:
+			return REGULATOR_MODE_NORMAL;
+		}
+	} else if (rinfo->sleep.addr) {
+		/* For LDOs there are 2 modes to map to */
+		mode = REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
+		/* Sleep flag bit decides the mode */
+	} else {
+		/* No support */
+		return 0;
+	}
+
+	/* If sys_state = SYS_STATE_CURRENT, current regulator state
+	   is detected. */
+	if (sys_state = SYS_STATE_CURRENT && rinfo->suspend.addr) {
+		val = da906x_reg_read(regl->hw,
+					  rinfo->suspend.addr);
+		if (val < 0)
+			return val;
+
+		if (val & rinfo->suspend.mask)
+			sys_state = SYS_STATE_SUSPEND;
+		else
+			sys_state = SYS_STATE_NORMAL;
+	}
+
+	/* Read regulator mode from proper register,
+	   depending on selected system state */
+	if (sys_state = SYS_STATE_SUSPEND && rinfo->suspend_sleep.addr) {
+		addr = rinfo->suspend_sleep.addr;
+		mask = rinfo->suspend_sleep.mask;
+	} else {
+		addr = rinfo->sleep.addr;
+		mask = rinfo->sleep.mask;
+	}
+
+	val = da906x_reg_read(regl->hw, addr);
+	if (val < 0)
+		return val;
+
+	if (val & mask)
+		mode &= REGULATOR_MODE_STANDBY;
+	else
+		mode &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_FAST;
+
+	return mode;
+}
+
+static int da906x_set_voltage(struct regulator_dev *rdev,
+				int min_uV, int max_uV, unsigned *selector)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct field *fvol = &regl->info->voltage;
+	int ret;
+	unsigned val;
+
+	val = regulator_map_voltage_linear(rdev, min_uV, max_uV);
+	if (val < 0)
+		return -EINVAL;
+
+	val = (val + fvol->offset) << fvol->shift;
+	ret = da906x_reg_update(regl->hw, fvol->addr, fvol->mask, val);
+	if (ret >= 0)
+		*selector = val;
+
+	return ret;
+}
+
+static int da906x_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct da906x_regulator_info *rinfo = regl->info;
+	int sel;
+
+	sel = da906x_reg_read(regl->hw, rinfo->voltage.addr);
+	if (sel < 0)
+		return sel;
+
+	sel = (sel & rinfo->voltage.mask) >> rinfo->voltage.shift;
+	sel -= rinfo->voltage.offset;
+	if (sel < 0)
+		sel = 0;
+	if (sel >= rinfo->n_steps)
+		sel = rinfo->n_steps - 1;
+
+	return sel;
+}
+
+static int da906x_set_current_limit(struct regulator_dev *rdev,
+							int min_uA, int max_uA)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct da906x_regulator_info *rinfo = regl->info;
+	int val = INT_MAX;
+	unsigned sel = 0;
+	int n;
+	int tval;
+
+	if (!rinfo->current_limits)
+		return -EINVAL;
+
+	for (n = 0; n < rinfo->n_current_limits; n++) {
+		tval = rinfo->current_limits[n];
+		if (tval >= min_uA && tval <= max_uA && val > tval) {
+			val = tval;
+			sel = n;
+		}
+	}
+	if (val = INT_MAX)
+		return -EINVAL;
+
+	sel = (sel + rinfo->ilimit.offset) << rinfo->ilimit.shift;
+	return da906x_reg_update(regl->hw, rinfo->ilimit.addr,
+						rinfo->ilimit.mask, sel);
+}
+
+static int da906x_get_current_limit(struct regulator_dev *rdev)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct da906x_regulator_info *rinfo = regl->info;
+	int sel;
+
+	sel = da906x_reg_read(regl->hw, rinfo->ilimit.addr);
+	if (sel < 0)
+		return sel;
+
+	sel = (sel & rinfo->ilimit.mask) >> rinfo->ilimit.shift;
+	sel -= rinfo->ilimit.offset;
+	if (sel < 0)
+		sel = 0;
+	if (sel >= rinfo->n_current_limits)
+		sel = rinfo->n_current_limits - 1;
+
+	return rinfo->current_limits[sel];
+}
+
+static int da906x_enable(struct regulator_dev *rdev)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	int ret;
+
+	if (regl->info->suspend.mask) {
+		/* Make sure to exit from suspend mode on enable */
+		ret = da906x_reg_clear_bits(regl->hw, regl->info->suspend.addr,
+					    regl->info->suspend.mask);
+		if (ret < 0)
+			return ret;
+
+		/* BUCKs need mode update after wake-up from suspend state. */
+		ret = da906x_update_mode_internal(regl, SYS_STATE_NORMAL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return regulator_enable_regmap(rdev);
+}
+
+static int da906x_set_mode(struct regulator_dev *rdev, unsigned mode)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	unsigned orig_mode = regl->mode;
+	int ret;
+
+	regl->mode = mode;
+	ret = da906x_update_mode_internal(regl, SYS_STATE_NORMAL);
+	if (ret)
+		regl->mode = orig_mode;
+
+	return ret;
+}
+
+static unsigned da906x_get_mode(struct regulator_dev *rdev)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+
+	return da906x_get_mode_internal(regl, SYS_STATE_CURRENT);
+}
+
+static int da906x_get_status(struct regulator_dev *rdev)
+{
+	int ret = regulator_is_enabled_regmap(rdev);
+
+	if (ret = 0) {
+		ret = REGULATOR_STATUS_OFF;
+	} else if (ret > 0) {
+		ret = da906x_get_mode(rdev);
+		if (ret > 0)
+			ret = regulator_mode_to_status(ret);
+		else if (ret = 0)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int da906x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct da906x_regulator_info *rinfo = regl->info;
+	const struct field *fsusvol = &rinfo->suspend_voltage;
+	int val;
+	int ret;
+
+	val = regulator_map_voltage_linear(rdev, uV, uV);
+	if (val < 0)
+		return -EINVAL;
+
+	val = (val + fsusvol->offset) << fsusvol->shift;
+	ret = da906x_reg_update(regl->hw, fsusvol->addr, fsusvol->mask, val);
+
+	return ret;
+}
+
+static int da906x_suspend_enable(struct regulator_dev *rdev)
+{
+	int ret;
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	const struct bfield *bsuspend = &regl->info->suspend;
+
+	ret = da906x_reg_set_bits(regl->hw, bsuspend->addr, bsuspend->mask);
+	return ret;
+}
+
+static int da906x_set_suspend_mode(struct regulator_dev *rdev, unsigned mode)
+{
+	struct da906x_regulator *regl = rdev_get_drvdata(rdev);
+	int ret;
+
+	regl->suspend_mode = mode;
+	ret = da906x_update_mode_internal(regl, SYS_STATE_SUSPEND);
+	return ret;
+}
+
+/* Regulator event handlers */
+irqreturn_t da906x_ldo_lim_event(int irq, void *data)
+{
+	struct da906x_regulators *regulators = data;
+	struct da906x *hw = regulators->regulator[0].hw;
+	struct da906x_regulator *regl;
+	int bits;
+	int i;
+
+	bits = da906x_reg_read(hw, DA906X_REG_STATUS_D);
+	if (bits < 0)
+		return IRQ_HANDLED;
+
+	for (i = regulators->n_regulators - 1; i >= 0; i--) {
+		regl = &regulators->regulator[i];
+		if (regl->info->oc_event.addr != DA906X_REG_STATUS_D)
+			continue;
+
+		if (regl->info->oc_event.mask & bits)
+			regulator_notifier_call_chain(regl->rdev,
+					REGULATOR_EVENT_OVER_CURRENT, NULL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Probing and Initialisation functions
+ */
+static __devinit const struct da906x_regulator_info *
+da906x_get_regl_info(const struct da906x *da906x,
+		     const struct da906x_dev_model *model, int id)
+{
+	int m;
+
+	for (m = model->n_regulators - 1;
+	     model->regulator_info[m].id != id; m--) {
+		if (m <= 0)
+			return NULL;
+	}
+	return &model->regulator_info[m];
+}
+
+static __devinit int da906x_regulator_probe(struct platform_device *pdev)
+{
+	struct da906x *da906x = dev_get_drvdata(pdev->dev.parent);
+	struct da906x_pdata *da906x_pdata = dev_get_platdata(da906x->dev);
+	struct da906x_regulators_pdata *regl_pdata;
+	struct da906x_regulator_data *rdata;
+	const struct da906x_dev_model *model;
+	struct da906x_regulators *regulators;
+	struct da906x_regulator *regl;
+	struct regulator_config config;
+	bool bcores_merged, bmem_bio_merged;
+	size_t size;
+	int n;
+	int ret;
+
+	if (!da906x_pdata) {
+		dev_err(&pdev->dev, "No platform init data supplied\n");
+		return -ENODEV;
+	}
+	regl_pdata = da906x_pdata->regulators_pdata;
+
+	if (!regl_pdata || regl_pdata->n_regulators = 0) {
+		dev_err(&pdev->dev,
+			"No regulators defined for the platform\n");
+		return -ENODEV;
+	}
+
+	/* Find regulators set for particular device model */
+	for (model = regulators_models; model->regulator_info; model++) {
+		if (model->dev_model = da906x_model(da906x))
+			break;
+	}
+	if (!model->regulator_info) {
+		dev_err(&pdev->dev, "Chip model not recognised (%u)\n",
+			da906x_model(da906x));
+		return -ENODEV;
+	}
+
+	ret = da906x_reg_read(da906x, DA906X_REG_CONFIG_H);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Error while reading BUCKs configuration\n");
+		return -EIO;
+	}
+	bcores_merged = (ret & DA906X_BCORE_MERGE) ? true : false;
+	bmem_bio_merged = (ret & DA906X_BUCK_MERGE) ? true : false;
+
+	/* Allocate memory required by usable regulators */
+	size = sizeof(struct da906x_regulators) +
+		regl_pdata->n_regulators * sizeof(struct da906x_regulator);
+	regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!regulators) {
+		dev_err(&pdev->dev, "No memory for regulators\n");
+		return -ENOMEM;
+	}
+
+	regulators->n_regulators = regl_pdata->n_regulators;
+	platform_set_drvdata(pdev, regulators);
+
+	/* Register all regulators declared in platform information */
+	n = 0;
+	while (n < regulators->n_regulators) {
+		rdata = &regl_pdata->regulator_data[n];
+
+		/* Check regulator ID against merge mode configuration */
+		switch (rdata->id) {
+		case DA9063_ID_BCORE1:
+		case DA9063_ID_BCORE2:
+			if (bcores_merged) {
+				dev_err(&pdev->dev,
+					"Cannot use BCORE1 and BCORE2 separately, when in merge mode\n");
+				ret = -EINVAL;
+				goto err;
+			}
+			break;
+		case DA9063_ID_BMEM:
+		case DA9063_ID_BIO:
+			if (bmem_bio_merged) {
+				dev_err(&pdev->dev,
+					"Cannot use BMEM and BIO separately, when in merge mode\n");
+				ret = -EINVAL;
+				goto err;
+			}
+			break;
+		case DA9063_ID_BCORES_MERGED:
+			if (!bcores_merged) {
+				dev_err(&pdev->dev,
+					"BCORE1 and BCORE2 are unavailable in merge mode\n");
+				ret = -EINVAL;
+				goto err;
+			}
+			break;
+		case DA9063_ID_BMEM_BIO_MERGED:
+			if (!bmem_bio_merged) {
+				dev_err(&pdev->dev,
+					"BMEM and BIO are unavailable in merge mode\n");
+				ret = -EINVAL;
+				goto err;
+			}
+			break;
+		}
+
+		/* Initialise regulator structure */
+		regl = &regulators->regulator[n];
+		regl->hw = da906x;
+		regl->info = da906x_get_regl_info(da906x, model, rdata->id);
+		if (!regl->info) {
+			dev_err(&pdev->dev,
+				"Invalid regulator ID in platform data\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		regl->desc.type = REGULATOR_VOLTAGE;
+		regl->desc.owner = THIS_MODULE;
+		regl->desc.name = regl->info->name;
+		regl->desc.id = rdata->id;
+		regl->desc.ops = regl->info->ops;
+		regl->desc.n_voltages = regl->info->n_steps;
+		regl->desc.min_uV = regl->info->min_uV;
+		regl->desc.uV_step = regl->info->step_uV;
+		regl->desc.enable_reg = regl->info->enable.addr +
+					DA906X_MAPPING_BASE;
+		regl->desc.enable_mask = regl->info->enable.mask;
+
+		/* Register regulator */
+		config.dev = &pdev->dev;
+		config.init_data = rdata->initdata;
+		config.driver_data = regl;
+		config.regmap = da906x->regmap;
+		regl->rdev = regulator_register(&regl->desc, &config);
+		if (IS_ERR_OR_NULL(regl->rdev)) {
+			dev_err(&pdev->dev,
+				"Failed to register %s regulator\n",
+				regl->info->name);
+			ret = PTR_ERR(regl->rdev);
+			goto err;
+		}
+		n++;
+
+		/* Get current modes of operation (A/B voltage selection)
+		   for normal and suspend states */
+		ret = da906x_get_mode_internal(regl, SYS_STATE_NORMAL);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to read %s regulator's mode\n",
+				regl->info->name);
+			goto err;
+		}
+		if (ret = 0)
+			regl->mode = REGULATOR_MODE_NORMAL;
+		else
+			regl->mode = ret;
+
+		ret = da906x_get_mode_internal(regl, SYS_STATE_SUSPEND);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to read %s regulator's mode\n",
+				regl->info->name);
+			goto err;
+		}
+		if (ret = 0)
+			regl->suspend_mode = REGULATOR_MODE_NORMAL;
+		else
+			regl->mode = ret;
+	}
+
+	/* LDOs overcurrent event support */
+	regulators->irq_ldo_lim = platform_get_irq_byname(pdev, "LDO_LIM");
+	if (regulators->irq_ldo_lim >= 0) {
+		ret = request_threaded_irq(regulators->irq_ldo_lim,
+					   NULL, da906x_ldo_lim_event,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   "LDO_LIM", regulators);
+		if (ret) {
+			dev_err(&pdev->dev,
+					"Failed to request LDO_LIM IRQ.\n");
+			regulators->irq_ldo_lim = -ENXIO;
+		}
+	}
+
+	return 0;
+
+err:
+	/* Wind back regulators registeration */
+	while (--n >= 0) {
+		regulator_unregister(regulators->regulator[n].rdev);
+	}
+
+	return ret;
+}
+
+static int __devexit da906x_regulator_remove(struct platform_device *pdev)
+{
+	struct da906x_regulators *regulators = platform_get_drvdata(pdev);
+	struct da906x_regulator *regl;
+
+	free_irq(regulators->irq_ldo_lim, regulators);
+	free_irq(regulators->irq_uvov, regulators);
+
+	for (regl = &regulators->regulator[regulators->n_regulators - 1];
+	     regl >= &regulators->regulator[0]; regl--)
+		regulator_unregister(regl->rdev);
+
+	return 0;
+}
+
+static struct platform_driver da906x_regulator_driver = {
+	.driver = {
+		.name = DA906X_DRVNAME_REGULATORS,
+		.owner = THIS_MODULE,
+	},
+	.probe = da906x_regulator_probe,
+	.remove = __devexit_p(da906x_regulator_remove),
+};
+
+static int __init da906x_regulator_init(void)
+{
+	return platform_driver_register(&da906x_regulator_driver);
+}
+subsys_initcall(da906x_regulator_init);
+
+static void __exit da906x_regulator_cleanup(void)
+{
+	platform_driver_unregister(&da906x_regulator_driver);
+}
+module_exit(da906x_regulator_cleanup);
+
+
+/* Module information */
+MODULE_AUTHOR("Krystian Garbaciak <krystian.garbaciak@diasemi.com>");
+MODULE_DESCRIPTION("DA906x regulators driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("paltform:" DA906X_DRVNAME_REGULATORS);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
