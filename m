From: Ramesh Agarwal <notagarwal@gmail.com>
Date: Thu, 13 Aug 2009 08:59:31 +0000
Subject: [lm-sensors] Intel Moorestown Analog Accelerometer driver
Message-Id: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Attached is the patch that adds support for the Analog accelerometer
on Intel's Moorestown platform. This has a dependency on the  Langwell
driver that was submitted to the kernel mailing list but is still not
in the mainstream. The patch can be found at
http://lkml.org/lkml/2009/7/20/396. Sending this out here to get any
early review comments on the code.

Thanks,
Ramesh
------------------------------------------------------------------------------------
From 3bd9a4332cfd7ec1471cc8beb9495fb2fe7ff84b Mon Sep 17 00:00:00 2001
From: Ramesh Agarwal <ramesh.agarwal@intel.com>
Date: Mon, 10 Aug 2009 11:09:43 +0530
Subject: [PATCH] Intel Moorestown Analog Accelerometer Driver

This patch adds the driver support for the Analog accelerometer
on the Moorestown platform. The acceleromater output is hooked to the
ADC lines on the PMIC and the driver uses the Langwell IPC to communicate
with the PMIC to get the output from the accelerometer.

Signed-off-by: Ramesh Agarwal <ramesh.agarwal@intel.com>
---
 Documentation/hwmon/mrst_analog_accel |   29 +++
 drivers/hwmon/Kconfig                 |    7 +
 drivers/hwmon/Makefile                |    1 +
 drivers/hwmon/mrst_analog_accel.c     |  331 +++++++++++++++++++++++++++++++++
 4 files changed, 368 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/mrst_analog_accel
 create mode 100644 drivers/hwmon/mrst_analog_accel.c

diff --git a/Documentation/hwmon/mrst_analog_accel
b/Documentation/hwmon/mrst_analog_accel
new file mode 100644
index 0000000..a98a861
--- /dev/null
+++ b/Documentation/hwmon/mrst_analog_accel
@@ -0,0 +1,29 @@
+Kernel driver mrst_analog_accel
+===============+
+Supported chips:
+  * PMIC accelerometer for Langwell
+    Prefix: 'mrst_analog_accel'
+
+Author: Ramesh Agarwal <ramesh.agarwal@intel.com>
+
+Description
+-----------
+
+This driver provides support for the analog accelerometer connected
+to the Moorestown Platform. The accelerometer is a Freescale MMA7341L
+analog device whose Xout, Yout and Zout are connected to the ADC on the
+PMIC of the Moorestown platform.
+
+The driver registers as a platform device driver and presents a single
+attribute 'position'. This attribute contains the uncalibrated values
+for the x, y and z co-ordinates as read from the ADC. The driver uses
+the Langwell IPC driver (LANGWELL_IPC)to read the values from the ADC.
+The accelerometer data is readable at /sys/devices/platform/mrst_analog_accel
+
+The accelerometer operates in the polling mode. This is to say that sampling
+by the driver will be done only if a user application has requested for the
+values.  The driver does not  register as an input device, and hence input
+calibration and fixing the sampling rate is left to the user level
+framework/application. The sysfs interface only provides the decimal values
+of the voltage read from the ADC where each bit is equivalent to 2mV.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..8993e55 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -652,6 +652,13 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.

+config SENSORS_MRST_ANALOG_ACCEL
+	tristate "Moorestown Analog Accelerometer"
+	depends on LANGWELL_IPC
+	help
+	  If you say yes here you get support for the Analog Accelerometer
+	  Device x y Z data can be accessed via sysfs.
+
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	select HWMON_VID
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..2bc0bbc 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
+obj-$(CONFIG_SENSORS_MRST_ANALOG_ACCEL)	+= mrst_analog_accel.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
diff --git a/drivers/hwmon/mrst_analog_accel.c
b/drivers/hwmon/mrst_analog_accel.c
new file mode 100644
index 0000000..366c086
--- /dev/null
+++ b/drivers/hwmon/mrst_analog_accel.c
@@ -0,0 +1,331 @@
+/*
+ * mrst_analog_accel.c - Intel analog accelerometer driver for Moorestown
+ *
+ * Copyright (C) 2009 Intel Corp
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <asm/mrst_ipcdefs.h>
+
+MODULE_AUTHOR("Ramesh Agarwal");
+MODULE_DESCRIPTION("Intel Moorestown Analog Accelerometer Driver");
+MODULE_LICENSE("GPL v2");
+
+/* PMIC ADC INTERRUPT REGISTERS */
+#define PMIC_ADC_ACC_REG_ADCINT		0x5F	/*ADC interrupt register */
+#define PMIC_ADC_ACC_REG_MADCINT	0x60	/*ADC interrupt mask register */
+
+/* PMIC ADC CONTROL REGISTERS */
+#define PMIC_ADC_ACC_REG_ADCCNTL1	0x61	/*ADC control register */
+#define PMIC_ADC_ACC_REG_ADCCNTL2	0x62	/*ADC gain regs channel 10-17 */
+#define PMIC_ADC_ACC_REG_ADCCNTL3	0x63	/*ADC gain regs channel 18-21 */
+
+/* PMIC Data Register base */
+#define PMIC_ADC_DATA_REG_BASE		0x64
+
+/* PMIC Channel Mapping Register base */
+#define PMIC_ADC_MAPPING_BASE		0xA4
+
+/* Register offsets for XYZ co-ordinates */
+#define PMIC_ADC_X_OFFSET		0x0
+#define PMIC_ADC_Y_OFFSET		0x2
+#define PMIC_ADC_Z_OFFSET		0x4
+
+/* Bit mask to check if ACD is enabled */
+#define PMIC_ADC_ENABLED_BIT_MASK	0x80
+
+/* Number of PMIC sample registers */
+#define PMIC_ADC_REG_MAX	32	/* Max no of available channel */
+
+#define PMIC_ADC_REG_HIGH(index, offset)	(PMIC_ADC_DATA_REG_BASE \
+						+ (index) * 2 + offset)
+#define PMIC_ADC_REG_LOW(index, offset)		(PMIC_ADC_DATA_REG_BASE \
+						+ (index) * 2 + offset + 1)
+
+/* Number of registers to read at a time */
+#define REG_READ_PER_IPC	4	/* Read 4 at a time although the */
+					/* IPC will support max 5 */
+
+#define END_OF_CHANNEL_VALUE	0x1F	/* Used to indicate the last */
+					/* channel being used */
+
+/* PMIC ADC channels for Accelero Meter */
+#define PMIC_ADC_ACC_ADC_ACC_CH14  0xE
+#define PMIC_ADC_ACC_ADC_ACC_CH15  0xF
+#define PMIC_ADC_ACC_ADC_ACC_CH16  0x10
+
+static unsigned int mrst_analog_reg_idx;
+
+static unsigned int analog_accel_read(int offset)
+{
+	unsigned int ret_val;
+	struct mrst_pmic_reg_data ipc_data;
+
+	ipc_data.ioc = 0;	/* No need to generate MSI */
+	ipc_data.num_entries = 2;
+	ipc_data.pmic_reg_data[0].register_address +		PMIC_ADC_REG_HIGH(mrst_analog_reg_idx,
+				offset); /* Higher 8 bits */
+	ipc_data.pmic_reg_data[1].register_address +		PMIC_ADC_REG_LOW(mrst_analog_reg_idx,
+				offset); /* Lower 3 bits */
+	if (mrst_pmic_ioread(&ipc_data) != 0) {
+		printk(KERN_ERR
+		"mrst_analog_accel:PMIC reg read using IPC failed\n");
+		return -1;
+	}
+	ret_val = ipc_data.pmic_reg_data[0].value << 3;
+	ret_val = ret_val | (ipc_data.pmic_reg_data[1].value & 0x07);
+	return ret_val;
+}
+
+/* Use IPC to read the value of the register and display */
+static ssize_t mrst_analog_accel_position_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d %d %d\n",
+				analog_accel_read(PMIC_ADC_X_OFFSET),
+				analog_accel_read(PMIC_ADC_Y_OFFSET),
+				analog_accel_read(PMIC_ADC_Z_OFFSET));
+}
+
+
+static DEVICE_ATTR(position, S_IRUGO,
+			mrst_analog_accel_position_show, NULL);
+
+static struct attribute *mid_att_acc[] = {
+	&dev_attr_position.attr,
+	NULL
+};
+
+static struct attribute_group m_analog_gr = {
+	.name = "mrst_analog_accel",
+	.attrs = mid_att_acc
+};
+
+static int mrst_analog_accel_initialize(void)
+{
+	struct mrst_pmic_mod_reg_data ipc_mod_data;
+	struct mrst_pmic_reg_data ipc_data;
+	u8 retval = 0;
+	u8 mad_cntrl = 0;	/* MADCINT register value */
+	u8 adc_cntrl1 = 0;	/* ADCCNTL2 register value */
+	int i, j;
+
+	/* Initialize the register index to use to be zero */
+	mrst_analog_reg_idx = 0;
+
+	/* check if the ADC is enabled or not
+	 * Read ADCCNTL1 registers */
+	ipc_data.ioc = 0;	/* No need to generate MSI */
+	ipc_data.num_entries = 1;
+	ipc_data.pmic_reg_data[0].register_address +		PMIC_ADC_ACC_REG_ADCCNTL1;
+	ipc_data.pmic_reg_data[0].value = 0;
+
+	retval = mrst_pmic_ioread(&ipc_data);
+	if (retval != 0) {
+		printk(KERN_ERR
+			"mrst_analog_accel:PMIC register read failed\n");
+		return retval;
+	}
+
+	adc_cntrl1 = ipc_data.pmic_reg_data[0].value;
+
+	if (adc_cntrl1 & PMIC_ADC_ENABLED_BIT_MASK) {
+		/* If the ADC is enabled find the set of registers to use
+		** Loop through the channel mapping register to find out the
+		** first free one
+		*/
+		for (i = 0;
+			(i < PMIC_ADC_REG_MAX) && (mrst_analog_reg_idx = 0);
+			i += REG_READ_PER_IPC) {
+
+			ipc_data.num_entries = REG_READ_PER_IPC;
+			ipc_data.ioc = 0;	/* No need to generate MSI */
+
+			/* Reading 4 regs at a time instead of reading each
+			 * reg one by one since IPC is an expensive operation
+			 */
+			for (j = 0; j < REG_READ_PER_IPC; j++) {
+				ipc_data.pmic_reg_data[j].register_address +					PMIC_ADC_MAPPING_BASE + i + j;
+				ipc_data.pmic_reg_data[j].value = 0;
+			}
+			retval = mrst_pmic_ioread(&ipc_data);
+			if (retval != 0) {
+				printk(KERN_ERR
+				"mrst_analog_accel:PMIC regs read failed\n");
+				return retval;
+			}
+			for (j = 0; j < REG_READ_PER_IPC; j++) {
+				if (ipc_data.pmic_reg_data[j].value
+					= END_OF_CHANNEL_VALUE) {
+					mrst_analog_reg_idx = i + j;
+					break;
+				}
+			}
+		}
+	}
+	/* Check to see if there are enough registers to map the channel */
+	if ((mrst_analog_reg_idx + 3) >= PMIC_ADC_REG_MAX) {
+		printk(KERN_ERR
+		"mrst_analog_accel:Not enough regs to map the channels\n");
+		return -1;
+	}
+
+	/* Update the mapping registers for the accelerometer*/
+	ipc_data.num_entries = 4;
+	ipc_data.ioc = 0;	/* No need to generate MSI */
+	ipc_data.pmic_reg_data[0].register_address +			PMIC_ADC_MAPPING_BASE + mrst_analog_reg_idx;
+	ipc_data.pmic_reg_data[0].value = PMIC_ADC_ACC_ADC_ACC_CH14;
+
+	ipc_data.pmic_reg_data[1].register_address +			PMIC_ADC_MAPPING_BASE + mrst_analog_reg_idx + 1;
+	ipc_data.pmic_reg_data[1].value = PMIC_ADC_ACC_ADC_ACC_CH15;
+
+	ipc_data.pmic_reg_data[2].register_address +			PMIC_ADC_MAPPING_BASE + mrst_analog_reg_idx + 2;
+	ipc_data.pmic_reg_data[2].value = PMIC_ADC_ACC_ADC_ACC_CH16;
+
+	ipc_data.pmic_reg_data[3].register_address +			PMIC_ADC_MAPPING_BASE + mrst_analog_reg_idx + 3 ;
+	ipc_data.pmic_reg_data[3].value = END_OF_CHANNEL_VALUE;
+
+	retval = mrst_pmic_iowrite(&ipc_data);
+	if (retval != 0) {
+		printk(KERN_ERR
+			"mrst_analog_accel:PMIC reg write failed\n");
+		return retval;
+	}
+
+	/* If the ADC was not enabled, enable it now */
+	if (!(adc_cntrl1 & PMIC_ADC_ENABLED_BIT_MASK)) {
+		/* Mask the round robin completion interrupt */
+		ipc_mod_data.ioc = 0;	/* No need to generate MSI */
+		ipc_mod_data.num_entries = 1;
+		mad_cntrl = 0x01;
+		ipc_mod_data.pmic_mod_reg_data[0].register_address +			PMIC_ADC_ACC_REG_MADCINT;
+		ipc_mod_data.pmic_mod_reg_data[0].value = mad_cntrl;
+		ipc_mod_data.pmic_mod_reg_data[0].bit_map = 0x01;
+
+		retval = mrst_pmic_ioread_modify(&ipc_mod_data);
+		if (retval != 0) {
+			printk(KERN_ERR
+			"mrst_analog_accel:PMIC reg modify failed\n");
+			return retval;
+		}
+
+		adc_cntrl1 = 0xc6;	/*27ms delay,start round robin,
+					   enable full power */
+		ipc_data.ioc = 0;	/* No need to generate MSI */
+		ipc_data.num_entries = 1;
+		ipc_data.pmic_reg_data[0].register_address +			PMIC_ADC_ACC_REG_ADCCNTL1;
+		ipc_data.pmic_reg_data[0].value = adc_cntrl1;
+		retval = mrst_pmic_iowrite(&ipc_data);
+		if (retval != 0)
+			return retval;
+	}
+	return retval;
+}
+
+static struct platform_device *mrst_analog_accel_pdev;
+static struct device *mrst_analog_accel_hwmon;
+
+static int mrst_analog_accel_unregister(void)
+{
+
+	hwmon_device_unregister(mrst_analog_accel_hwmon);
+	sysfs_remove_group(&mrst_analog_accel_pdev->dev.kobj, &m_analog_gr);
+	platform_device_unregister(mrst_analog_accel_pdev);
+	printk(KERN_INFO "mrst_analog_accel:Unregistered the device\n");
+	return 0;
+}
+
+
+static int __init mrst_analog_accel_module_init(void)
+{
+	int retval = 0;
+
+	mrst_analog_accel_pdev +		platform_device_register_simple("mrst_analog_accel",
+			0, NULL, 0);
+	if (IS_ERR(mrst_analog_accel_pdev)) {
+		retval = PTR_ERR(mrst_analog_accel_pdev);
+		printk(KERN_ERR
+		"mrst_analog_accel:Registration with the platform failed\n");
+		return retval;
+	}
+
+	retval = mrst_analog_accel_initialize();
+	if (retval = 0) {
+		retval = sysfs_create_group(&mrst_analog_accel_pdev->dev.kobj,
+			&m_analog_gr);
+		if (retval) {
+			printk(KERN_ERR
+			"mrst_analog_accel:device_create_file 1 failed\n");
+			goto accelero_reg_failed;
+		}
+		mrst_analog_accel_hwmon +			hwmon_device_register(&mrst_analog_accel_pdev->dev);
+		if (IS_ERR(mrst_analog_accel_hwmon)) {
+			retval = PTR_ERR(mrst_analog_accel_hwmon);
+			mrst_analog_accel_hwmon = NULL;
+			sysfs_remove_group(&mrst_analog_accel_pdev->dev.kobj,
+					&m_analog_gr);
+			printk(KERN_ERR
+			"mrst_analog_accel:Registration with hwmon failed\n");
+			goto accelero_reg_failed;
+		}
+	} else {
+		printk(KERN_ERR
+		"mrst_analog_accel:Initialization failed: %d\n", retval);
+		goto accelero_reg_failed;
+	}
+
+	printk(KERN_INFO
+		"mrst_analog_accel:Registered device with the platform\n");
+	return retval;
+
+accelero_reg_failed:
+	platform_device_unregister(mrst_analog_accel_pdev);
+	return retval;
+}
+
+static void __exit mrst_analog_accel_module_exit(void)
+{
+
+	mrst_analog_accel_unregister();
+}
+
+module_init(mrst_analog_accel_module_init);
+module_exit(mrst_analog_accel_module_exit);
-- 
1.5.6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
