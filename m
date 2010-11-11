From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 11 Nov 2010 15:49:08 +0000
Subject: [lm-sensors] [PATCH 1/2] intel medfield: thermal_driver
Message-Id: <20101111154902.12776.31489.stgit@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Durgadoss <durgadoss.r@intel.com>

This is the basic thermal sensor driver for Intel MID platform using the
Medfield chipset. It plugs in via the thermal drivers and provides sensor
readings for the device sensors.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hwmon/Kconfig             |    7 
 drivers/hwmon/Makefile            |    1 
 drivers/hwmon/intel_mid_thermal.c |  549 +++++++++++++++++++++++++++++++++++++
 3 files changed, 557 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/intel_mid_thermal.c


diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a56f6ad..d20aafd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1171,6 +1171,13 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
 
+config SENSORS_THERMAL_MFLD
+        tristate "Thermal driver for Intel Medfield platform"
+        depends on INTEL_SCU_IPC && THERMAL
+        help
+          Say Y here to enable thermal driver for the  Intel Medfield
+          platform.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2479b3d..e1f42f3 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
+obj-$(CONFIG_SENSORS_THERMAL_MFLD)   += intel_mid_thermal.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/intel_mid_thermal.c b/drivers/hwmon/intel_mid_thermal.c
new file mode 100644
index 0000000..da9da1d
--- /dev/null
+++ b/drivers/hwmon/intel_mid_thermal.c
@@ -0,0 +1,549 @@
+/*
+ * intel_mid_thermal.c - Intel MID platform thermal driver
+ *
+ * Copyright (C) 2010 Intel Corporation
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * Author: Ananth Krishna <ananth.krishna.r@intel.com>
+ * Author: Durgadoss <durgadoss.r@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/param.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pm.h>
+#include <linux/thermal.h>
+
+#include <asm/intel_scu_ipc.h>
+
+MODULE_AUTHOR("Durgadoss <durgadoss.r@intel.com>");
+MODULE_DESCRIPTION("Intel Medfield Platform Thermal Driver");
+MODULE_LICENSE("GPL");
+
+#define DRIVER_NAME "msic_sensor"
+#define PREFIX "intel_mid_thermal:"
+
+/*No of Thermal sensors */
+#define MSIC_THERMAL_SENSORS	4
+
+/* ADC1 - thermal registers */
+#define MSIC_THERM_ADC1CNTL1	0x1C0
+#define MSIC_ADC_ENBL		0x10
+#define MSIC_ADC_START		0x08
+
+#define MSIC_THERM_ADC1CNTL3	0x1C2
+#define MSIC_ADCTHERM_ENBL	0x04
+#define MSIC_ADCRRDATA_ENBL	0x05
+#define MSIC_CHANL_MASK_VAL	0x0F
+
+#define MSIC_STOPBIT_MASK	16
+#define MSIC_ADCTHERM_MASK	4
+#define ADC_CHANLS_MAX		15 /*no of adc channels*/
+#define ADC_LOOP_MAX		(ADC_CHANLS_MAX - MSIC_THERMAL_SENSORS)
+
+#define MSIC_VAUDA		0x0DB
+#define MSIC_VAUDA_VAL		0xFF
+
+/* adc channel code values */
+#define SKIN_SENSOR0_CODE		0x08
+#define SKIN_SENSOR1_CODE		0x09
+#define SYS_SENSOR_CODE			0x0A
+#define MSIC_DIE_SENSOR_CODE		0x03
+
+#define SKIN_THERM_SENSOR0	0
+#define SKIN_THERM_SENSOR1	1
+#define SYS_THERM_SENSOR2	2
+#define MSIC_DIE_THERM_SENSOR3	3
+
+/* ADC code range */
+#define ADC_MAX		977
+#define ADC_MIN		162
+#define ADC_VAL1	887
+#define ADC_VAL2	720
+#define ADC_VAL3	508
+#define ADC_VAL4	315
+
+/* ADC base addresses */
+#define ADC_CHNL_START_ADDR	0x1C5	/* increments by 1 */
+#define ADC_DATA_START_ADDR     0x1D4   /* increments by 2 */
+
+/*MSIC die attributes*/
+#define MSIC_DIE_ADC_MIN		488
+#define MSIC_DIE_ADC_MAX		1004
+
+/*convert adc_val to die temperature */
+#define TO_MSIC_DIE_TEMP(adc_val)	((368 * (adc_val) / 1000) - 220)
+
+static int channel_index;
+
+struct platform_info {
+	struct platform_device *pdev;
+	struct thermal_zone_device *tzd[MSIC_THERMAL_SENSORS];
+};
+
+struct thermal_device_info {
+	unsigned int chnl_addr;
+	long curr_temp;
+};
+
+static int read_curr_temp(struct thermal_zone_device *, unsigned long *);
+
+struct thermal_zone_device_ops tzd_ops = {
+	.get_temp = read_curr_temp,
+};
+
+static char *name[MSIC_THERMAL_SENSORS] = {"skin0", "skin1",
+					"sys", "msicdie"};
+/**
+ * is_valid_adc - checks whether the adc code is within the defined range
+ * @min: minimum value for the sensor
+ * @max: maximum value for the sensor
+ * context: can sleep
+ */
+static int is_valid_adc(uint16_t adc_val, uint16_t min, uint16_t max)
+{
+	return (adc_val >= min) && (adc_val <= max);
+}
+
+/**
+ * adc_to_temp - converts the ADC code to temperature in C
+ * @adc_val: the adc_val needs to be converted
+ *
+ * Linear approximation is used to covert the skin adc value into temperature.
+ * This technique is used to avoid very long look-up table to get
+ * the appropriate temp value from ADC value.
+ * The adc code vs sensor temp curve is split into five parts
+ * to achieve very close approximate temp value with less than
+ * 0.5C error
+ */
+static int adc_to_temp(char *type, uint16_t adc_val)
+{
+	int temp;
+
+	/* direct conversion for die temperature*/
+	if (!strcmp(type, name[MSIC_DIE_THERM_SENSOR3])) {
+		if (is_valid_adc(adc_val, MSIC_DIE_ADC_MIN, MSIC_DIE_ADC_MAX))
+			return  (int)(TO_MSIC_DIE_TEMP(adc_val) * 1000);
+		else
+			return -ERANGE;
+	}
+
+	if (!is_valid_adc(adc_val, ADC_MIN, ADC_MAX))
+		return -ERANGE;
+
+	/* linear approximation for skin temperature*/
+	if (adc_val > ADC_VAL1) /* -20 to 0C */
+		temp = 177 - (adc_val/5);
+	else if ((adc_val <= ADC_VAL1) && (adc_val > ADC_VAL2)) /* 0C to 20C */
+		temp = 111 - (adc_val/8);
+	else if ((adc_val <= ADC_VAL2) && (adc_val > ADC_VAL3)) /* 20C to 40C */
+		temp = 92 - (adc_val/10);
+	else if ((adc_val <= ADC_VAL3) && (adc_val > ADC_VAL4)) /* 40C to 60C */
+		temp = 91 - (adc_val/10);
+	else
+		temp = 112 - (adc_val/6); /* 60C to 85C */
+
+	/*convert tempertaure in celsius to milli degree celsius*/
+	return temp * 1000;
+}
+
+/**
+ * mid_read_temp - read sensors for temperature
+ * @temp: holds the current temperature for the sensor after reading
+ * Context: can sleep
+ *
+ * reads the adc_code from the channel and converts it to real
+ * temperature. The converted value is stored in temp.
+ */
+static int mid_read_temp(struct thermal_zone_device *tzd, unsigned long *temp)
+{
+	uint16_t adc_val, addr;
+	uint8_t data = 0;
+	int ret;
+	unsigned long curr_temp;
+
+	struct thermal_device_info *td_info +				(struct thermal_device_info *)tzd->devdata;
+
+	addr = td_info->chnl_addr;
+
+	/* enable the msic for conversion before reading */
+	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCRRDATA_ENBL);
+	if (ret)
+		return ret;
+
+	/* re-toggle the RRDATARD bit
+	 * temporary workaround */
+	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL3, MSIC_ADCTHERM_ENBL);
+	if (ret)
+		return ret;
+
+	/* reading the higher bits of data */
+	ret = intel_scu_ipc_ioread8(addr, &data);
+	if (ret)
+		return ret;
+
+	/* shifting bits to accomodate the lower two data bits */
+	adc_val = (data << 2);
+	addr++;
+
+	ret = intel_scu_ipc_ioread8(addr, &data);/* reading lower bits */
+	if (ret)
+		return ret;
+
+	/*adding lower two bits to the higher bits*/
+	data &= 03;
+	adc_val += data;
+
+	/*convert adc value to temperature*/
+	curr_temp = adc_to_temp(tzd->type, adc_val);
+	if (curr_temp = -ERANGE)
+		return -ERANGE;
+
+	*temp = td_info->curr_temp = curr_temp;
+	return 0;
+}
+
+/**
+ * configure_adc - enables/disables adc for conversion
+ * @val: zero: disables the adc non-zero:enables the adc
+ * Context: can sleep
+ *
+ * Enable/Disable the adc depending on the argument
+ */
+static int configure_adc(int val)
+{
+	int ret;
+	uint8_t data;
+
+	ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL1, &data);
+	if (ret)
+		return ret;
+
+	if (val)
+		/* enable and start the adc */
+		data |= (MSIC_ADC_ENBL | MSIC_ADC_START);
+	else
+		/* just stop the adc */
+		data &= (~MSIC_ADC_START);
+
+	ret = intel_scu_ipc_iowrite8(MSIC_THERM_ADC1CNTL1, data);
+	return ret;
+}
+
+/**
+ * set_up_therm_chnl - enable thermal channel for conversion
+ * @base_addr: index of free msic adc channel
+ * Context: can sleep
+ *
+ * Enable all the three channels for conversion
+ */
+static int set_up_therm_chnl(u16 base_addr)
+{
+	int ret;
+
+	/* enabling all the sensor channels */
+	ret = intel_scu_ipc_iowrite8(base_addr, SKIN_SENSOR0_CODE);
+	if (ret)
+		return ret;
+
+	ret = intel_scu_ipc_iowrite8(base_addr + 1, SKIN_SENSOR1_CODE);
+	if (ret)
+		return ret;
+
+	ret = intel_scu_ipc_iowrite8(base_addr + 2, SYS_SENSOR_CODE);
+	if (ret)
+		return ret;
+
+	/*since this is the last channel, set the stop bit
+	to 1 by ORing the DIE_SENSOR_CODE with 0x10*/
+	ret = intel_scu_ipc_iowrite8(base_addr + 3,
+					(MSIC_DIE_SENSOR_CODE | 0x10));
+	if (ret)
+		return ret;
+
+	/* enable VAUDA line: temporary workaround for MSIC issue */
+	ret = intel_scu_ipc_iowrite8(MSIC_VAUDA, MSIC_VAUDA_VAL);
+	if (ret)
+		return ret;
+
+	/* enable adc and start it*/
+	ret = configure_adc(1);
+
+	return ret;
+}
+
+/**
+ * reset_stopbit - sets the stop bit to 0 on the given channel
+ * @addr: address of the channel
+ * context: can sleep
+ */
+static int reset_stopbit(uint16_t addr)
+{
+	int ret;
+	uint8_t data;
+	ret = intel_scu_ipc_ioread8(addr, &data);
+	if (ret)
+		return ret;
+	/*setting the stop bit to zero*/
+	ret = intel_scu_ipc_iowrite8(addr, (data & 0xEF));
+	return ret;
+}
+
+/**
+ * find_free_channel - finds an empty channel for conversion
+ * Context: can sleep
+ *
+ * If adc is not enabled then start using 0th channel
+ * itself. Otherwise find an empty channel by looking for a
+ * channel in which the stopbit is set to 1. returns the index
+ * of the first free channel if succeeds,-EINVAL otherwise
+ */
+static int find_free_channel(void)
+{
+	int ret;
+	int i;
+	uint8_t data;
+
+	/*check whether ADC is enabled */
+	ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL1, &data);
+	if (ret)
+		return ret;
+
+	if ((data & MSIC_ADC_ENBL) = 0)
+		return 0;
+
+	/*ADC is already enabled; Looping for empty channel */
+	for (i = 0; i < ADC_CHANLS_MAX; i++) {
+		ret = intel_scu_ipc_ioread8(ADC_CHNL_START_ADDR + i, &data);
+		if (ret)
+			return ret;
+
+		if (data & MSIC_STOPBIT_MASK) {
+			ret = i;
+			break;
+		}
+	}
+	return (ret > ADC_LOOP_MAX) ? (-EINVAL) : ret;
+}
+
+/**
+ * mid_initialize_adc - initializing the adc
+ * Context: can sleep
+ *
+ * Initialize the adc for reading thermistor values
+ */
+static int mid_initialize_adc(struct device *dev)
+{
+	u8  data;
+	u16 base_addr;
+	int ret;
+
+	/* ensure that adctherm is disabled before we
+	 * initialize the adc */
+	ret = intel_scu_ipc_ioread8(MSIC_THERM_ADC1CNTL3, &data);
+	if (ret)
+		return ret;
+
+	if (data & MSIC_ADCTHERM_MASK)
+		dev_warn(dev, PREFIX "%s:ADCTHERM already set", __func__);
+
+	/* Index of the first channel in which the stop bit is set */
+	channel_index = find_free_channel();
+	if (channel_index = -EINVAL) {
+		dev_warn(dev, PREFIX "%s:No free channels", __func__);
+		return -EINVAL;
+	}
+
+	base_addr = ADC_CHNL_START_ADDR + channel_index;
+
+	if (!(channel_index = 0 || channel_index = ADC_LOOP_MAX)) {
+		/* reset stop bit for channels other than 0 and 12 */
+		ret = reset_stopbit(base_addr);
+		if (ret)
+			return ret;
+
+		/* Index of the first free channel */
+		base_addr++;
+		channel_index++;
+	}
+
+	ret = set_up_therm_chnl(base_addr);
+	if (ret) {
+		dev_warn(dev, PREFIX "%s:adc enabling failed", __func__);
+		return ret;
+	}
+
+	dev_info(dev, PREFIX "adc initialization successfull");
+	return ret;
+}
+
+/**
+ * initialize_sensor - sets default temp and timer ranges
+ * @index: index of the sensor
+ * Context: can sleep
+ */
+static struct thermal_device_info *initialize_sensor(int index)
+{
+	struct thermal_device_info *td_info +		kzalloc(sizeof(struct thermal_device_info), GFP_KERNEL);
+
+	if (!td_info)
+		return NULL;
+
+	/*setting the base addr of the channel for this sensor*/
+	td_info->chnl_addr = ADC_DATA_START_ADDR+2*(channel_index+index);
+
+	return td_info;
+}
+
+/**
+ * mid_thermal_resume - resume routine
+ * @pdev: platform device structure
+ * Context: can sleep
+ *
+ * mid thermal resume: re-initializes the adc
+ */
+static int mid_thermal_resume(struct platform_device *pdev)
+{
+	return mid_initialize_adc(&pdev->dev);
+}
+
+/**
+ * mid_thermal_suspend - suspend routine
+ * @pdev: platform device structure
+ * Context: can sleep
+ *
+ * mid thermal suspend implements the suspend functionality
+ * by stopping the adc
+ */
+static int mid_thermal_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	/* this just stops adc and does not disable it.
+	 * temporary workaround until a generic adc driver comes.
+	 * If 0 is passed, it disables the adc.
+	 */
+	return configure_adc(0);
+}
+
+/**
+ * read_curr_temp - reads the current temperature and stores in temp
+ * @temp: holds the current temperature value after reading
+ * context: can sleep
+ */
+static int read_curr_temp(struct thermal_zone_device *tzd, unsigned long *temp)
+{
+	WARN_ON(tzd = NULL);
+	return mid_read_temp(tzd, temp);
+}
+
+/**
+ * mid_thermal_probe - mfld thermal initialize
+ * @pdev: platform device structure
+ * Context: can sleep
+ *
+ * mid thermal probe initializes the hardware and registers
+ * all the sensors with the generic thermal framework.
+ */
+static int mid_thermal_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct platform_info *pinfo;
+
+	pinfo = kzalloc(sizeof(struct platform_info), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	/* Initializing the hardware */
+	ret = mid_initialize_adc(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, PREFIX "%s: adc init failed", __func__);
+		return ret;
+	}
+
+	/* register each sensor with the generic thermal framework*/
+	for (i = 0; i < MSIC_THERMAL_SENSORS; i++)
+		pinfo->tzd[i] = thermal_zone_device_register(name[i],
+					0, initialize_sensor(i),
+					&tzd_ops, 0, 0, 0, 0);
+
+	pinfo->pdev = pdev;
+	platform_set_drvdata(pdev, pinfo);
+
+	return ret;
+}
+
+/**
+ * mid_thermal_remove - mfld thermal finalize
+ * @dev: platform device structure
+ * Context: can sleep
+ *
+ * MLFD thermal remove unregisters all the sensors from the generic
+ * thermal framework.
+ */
+static int mid_thermal_remove(struct platform_device *pdev)
+{
+	int i;
+	struct platform_info *pinfo = platform_get_drvdata(pdev);
+
+	for (i = 0; i < MSIC_THERMAL_SENSORS; i++)
+		thermal_zone_device_unregister(pinfo->tzd[i]);
+
+	platform_set_drvdata(pdev, NULL);
+
+	/* stop the adc */
+	configure_adc(0);
+	return 0;
+}
+
+/*********************************************************************
+ *		Driver initialisation and finalization
+ *********************************************************************/
+static const struct platform_device_id therm_id_table[] = {
+	{ DRIVER_NAME, 1 },
+};
+
+static struct platform_driver mid_thermal_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = mid_thermal_probe,
+	.suspend = mid_thermal_suspend,
+	.resume = mid_thermal_resume,
+	.remove = __devexit_p(mid_thermal_remove),
+	.id_table = therm_id_table,
+};
+
+static int __init mid_thermal_module_init(void)
+{
+	return platform_driver_register(&mid_thermal_driver);
+}
+
+static void __exit mid_thermal_module_exit(void)
+{
+	platform_driver_unregister(&mid_thermal_driver);
+}
+
+module_init(mid_thermal_module_init);
+module_exit(mid_thermal_module_exit);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
