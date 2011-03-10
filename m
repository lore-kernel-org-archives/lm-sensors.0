From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 10 Mar 2011 14:27:52 +0000
Subject: [lm-sensors] [PATCH] hmwon: New driver for SMSC SCH5627 hwmon
Message-Id: <1299767272-17398-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

SMSC SCH5627 Super I/O chips include complete hardware monitoring
capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperature
sensors.

The hardware monitoring part of the SMSC SCH5627 is accessed by talking
through an embedded microcontroller. An application note describing the
protocol for communicating with the microcontroller is available upon
request. Please mail me if you want a copy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/sch5627 |   23 ++
 drivers/hwmon/Kconfig       |    9 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/sch5627.c     |  833 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 866 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/sch5627
 create mode 100644 drivers/hwmon/sch5627.c

diff --git a/Documentation/hwmon/sch5627 b/Documentation/hwmon/sch5627
new file mode 100644
index 0000000..93ff3f5
--- /dev/null
+++ b/Documentation/hwmon/sch5627
@@ -0,0 +1,23 @@
+Kernel driver sch5627
+==========+
+Supported chips:
+  * SMSC SCH5627
+    Prefix: 'sch5627'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Application Note available upon request
+
+Author: Hans de Goede <hdegoede@redhat.com>
+
+
+Description
+-----------
+
+SMSC SCH5627 Super I/O chips include complete hardware monitoring
+capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperature
+sensors.
+
+The hardware monitoring part of the SMSC SCH5627 is accessed by talking
+through an embedded microcontroller. An application note describing the
+protocol for communicating with the microcontroller is available upon
+request. Please mail me if you want a copy.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 773e484..ec6d0fb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -871,6 +871,15 @@ config SENSORS_SMSC47B397
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47b397.
 
+config SENSORS_SCH5627
+	tristate "SMSC SCH5627"
+	help
+	  If you say yes here you get support for the hardware monitoring
+	  features of the SMSC SCH5627 Super-I/O chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sch5627.
+
 config SENSORS_ADS7828
 	tristate "Texas Instruments ADS7828"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index dde02d9..8b411b3 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
+obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
new file mode 100644
index 0000000..9488ec5
--- /dev/null
+++ b/drivers/hwmon/sch5627.c
@@ -0,0 +1,833 @@
+/***************************************************************************
+ *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>           *
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ *   This program is distributed in the hope that it will be useful,       *
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
+ *   GNU General Public License for more details.                          *
+ *                                                                         *
+ *   You should have received a copy of the GNU General Public License     *
+ *   along with this program; if not, write to the                         *
+ *   Free Software Foundation, Inc.,                                       *
+ *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
+ ***************************************************************************/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+
+#define DRVNAME "sch5627"
+
+#define SIO_SCH5627_EM_LD	0x0C	/* Embedded Microcontroller LD */
+#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
+
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID */
+#define SIO_REG_ENABLE		0x30	/* Logical device enable */
+#define SIO_REG_ADDR		0x66	/* Logical device address (2 bytes) */
+
+#define SIO_SCH5627_ID		0xC6	/* Chipset ID */
+
+#define REGION_LENGTH		9
+
+#define SCH5627_HWMON_ID		0xa5
+#define SCH5627_COMPANY_ID		0x5c
+#define SCH5627_PRIMARY_ID		0xa0
+
+#define SCH5627_REG_BUILD_CODE		0x39
+#define SCH5627_REG_BUILD_ID		0x3a
+#define SCH5627_REG_HWMON_ID		0x3c
+#define SCH5627_REG_HWMON_REV		0x3d
+#define SCH5627_REG_COMPANY_ID		0x3e
+#define SCH5627_REG_PRIMARY_ID		0x3f
+#define SCH5627_REG_CTRL		0x40
+
+#define SCH5627_NO_TEMPS		8
+#define SCH5627_NO_FANS			4
+#define SCH5627_NO_IN			5
+
+static const int SCH5627_REG_TEMP_MSB[SCH5627_NO_TEMPS] = {
+	0x2B, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x180, 0x181 };
+static const int SCH5627_REG_TEMP_LSN[SCH5627_NO_TEMPS] = {
+	0xE2, 0xE1, 0xE1, 0xE5, 0xE5, 0xE6, 0x182, 0x182 };
+static const int SCH5627_REG_TEMP_HIGH_NIBBLE[SCH5627_NO_TEMPS] = {
+	0, 0, 1, 1, 0, 0, 0, 1 };
+static const int SCH5627_REG_TEMP_HIGH[SCH5627_NO_TEMPS] = {
+	0x61, 0x57, 0x59, 0x5B, 0x5D, 0x5F, 0x184, 0x186 };
+static const int SCH5627_REG_TEMP_ABS[SCH5627_NO_TEMPS] = {
+	0x9B, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x1A8, 0x1A9 };
+
+static const int SCH5627_REG_FAN[SCH5627_NO_FANS] = {
+	0x2C, 0x2E, 0x30, 0x32 };
+static const int SCH5627_REG_FAN_MIN[SCH5627_NO_FANS] = {
+	0x62, 0x64, 0x66, 0x68 };
+
+static const int SCH5627_REG_IN_MSB[SCH5627_NO_IN] = {
+	0x22, 0x23, 0x24, 0x25, 0x189 };
+static const int SCH5627_REG_IN_LSN[SCH5627_NO_IN] = {
+	0xE4, 0xE4, 0xE3, 0xE3, 0x18A };
+static const int SCH5627_REG_IN_HIGH_NIBBLE[SCH5627_NO_IN] = {
+	1, 0, 1, 0, 1 };
+static const int SCH5627_REG_IN_FACTOR[SCH5627_NO_IN] = {
+	10745, 3660, 9765, 10745, 3660 };
+static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
+	"VCC", "VTT", "VBAT", "VTR", "V_IN" };
+
+struct sch5627_data {
+	unsigned short addr;
+	struct device *hwmon_dev;
+	u8 temp_max[SCH5627_NO_TEMPS];
+	u8 temp_crit[SCH5627_NO_TEMPS];
+	u16 fan_min[SCH5627_NO_FANS];
+
+	struct mutex update_lock;
+	char valid;			/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+	u16 temp[SCH5627_NO_TEMPS];
+	u16 fan[SCH5627_NO_FANS];
+	u16 in[SCH5627_NO_IN];
+};
+
+static int sch5627_remove(struct platform_device *pdev);
+
+static struct platform_device *sch5627_pdev;
+
+/* Super I/O functions */
+static inline int superio_inb(int base, int reg)
+{
+	outb(reg, base);
+	return inb(base + 1);
+}
+
+static inline int superio_enter(int base)
+{
+	/* Don't step on other drivers' I/O space by accident */
+	if (!request_muxed_region(base, 2, DRVNAME)) {
+		printk(KERN_ERR DRVNAME ": I/O address 0x%04x already in use\n",
+				base);
+		return -EBUSY;
+	}
+
+	outb(SIO_UNLOCK_KEY, base);
+
+	return 0;
+}
+
+static inline void superio_select(int base, int ld)
+{
+	outb(SIO_REG_LDSEL, base);
+	outb(ld, base + 1);
+}
+
+static inline void superio_exit(int base)
+{
+	outb(SIO_LOCK_KEY, base);
+	release_region(base, 2);
+}
+
+static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
+{
+	u8 val;
+	int i;
+	/* According to SMSC for the commands we use the maximum time for
+	   the EM to respond is 15 ms, but testing shows in practice it
+	   responds within 15-32 reads, so we first busy poll, and if
+	   that fails sleep a bit and try again until we are way past
+	   the 15 ms maximum response time */
+	const int max_busy_polls = 64;
+	const int max_lazy_polls = 32;
+
+	/* (Optional) Write-Clear the EC to Host Mailbox Register */
+	val = inb(data->addr + 1);
+	outb(val, data->addr + 1);
+
+	/* Set Mailbox Address Pointer to first location in Region 1 */
+	outb(0x00, data->addr + 2);
+	outb(0x80, data->addr + 3);
+
+	/* Write Request Packet Header */
+	outb(0x02, data->addr + 4); /* Access Type: VREG read */
+	outb(0x01, data->addr + 5); /* # of Entries: 1 Byte (8-bit) */
+	outb(0x04, data->addr + 2); /* Mailbox AP to first data entry loc. */
+
+	/* Write Address field */
+	outb(reg & 0xff, data->addr + 6);
+	outb(reg >> 8, data->addr + 7);
+
+	/* Execute the Random Access Command */
+	outb(0x01, data->addr); /* Write 01h to the Host-to-EC register */
+
+	/* EM Interface Polling "Algorithm" */
+	for (i = 0; i < max_busy_polls + max_lazy_polls; i++) {
+		if (i>= max_busy_polls)
+			msleep(1);
+		/* Read Interrupt source Register */
+		val = inb(data->addr + 8);
+		/* Write Clear the interrupt source bits */
+		if (val)
+			outb(val, data->addr + 8); 
+		/* Command Completed ? */
+		if (val & 0x01)
+			break;
+	}
+	if (i = max_busy_polls + max_lazy_polls) {
+		printk(KERN_ERR DRVNAME ": Max retries exceeded reading "
+		       "virtual register 0x%04x (1)\n", (unsigned int)reg);
+		return -EIO;
+	}
+
+	/* According to SMSC we may need to retry this, but sofar I've always
+	   seen this succeed in 1 try */
+	for (i = 0; i < max_busy_polls; i++) {
+		/* Read EC-to-Host Register */
+		val = inb(data->addr + 1);
+		/* Command Completed ? */
+		if (val = 0x01)
+			break;
+
+		printk(KERN_WARNING DRVNAME ": EC reports: %02x reading "
+		       "virtual register 0x%04x\n",
+		       (unsigned int)val, (unsigned int)reg);
+	}
+	if (i = max_busy_polls) {
+		printk(KERN_ERR DRVNAME ": Max retries exceeded reading "
+		       "virtual register 0x%04x (2)\n", (unsigned int)reg);
+		return -EIO;
+	}
+
+	/* Read Data from Mailbox */
+	return inb(data->addr + 4);
+}
+
+static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
+{
+	int lsb, msb;
+
+	/* Read LSB first, this will cause the matching MSB to be latched */
+	lsb = sch5627_read_virtual_reg(data, reg);
+	if (lsb < 0)
+		return lsb;
+
+	msb = sch5627_read_virtual_reg(data, reg + 1);
+	if (msb < 0)
+		return msb;
+
+	return lsb | (msb << 8);
+}
+
+static int sch5627_read_virtual_reg12(struct sch5627_data *data, u16 msb_reg,
+				      u16 lsn_reg, int high_nibble)
+{
+	int msb, lsn = -1;
+
+	/* Read MSB first, this will cause the matching LSN to be latched */
+	msb = sch5627_read_virtual_reg(data, msb_reg);
+	if (msb < 0)
+		return msb;
+
+	lsn = sch5627_read_virtual_reg(data, lsn_reg);
+	if (lsn < 0)
+		return lsn;
+
+	if (high_nibble)
+		return (msb << 4) | (lsn >> 4);
+	else
+		return (msb << 4) | (lsn & 0x0f);
+}
+
+static struct sch5627_data *sch5627_update_device(struct device *dev)
+{
+	struct sch5627_data *data = dev_get_drvdata(dev);
+	struct sch5627_data *ret = data;
+	int i, val;
+
+	mutex_lock(&data->update_lock);
+
+	/* Update every second */
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		for (i = 0; i < SCH5627_NO_TEMPS; i++) {
+			val = sch5627_read_virtual_reg12(data,
+				SCH5627_REG_TEMP_MSB[i],
+				SCH5627_REG_TEMP_LSN[i],
+				SCH5627_REG_TEMP_HIGH_NIBBLE[i]);
+			if (unlikely(val < 0)) {
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->temp[i] = val;
+		}
+
+		for (i = 0; i < SCH5627_NO_FANS; i++) {
+			val = sch5627_read_virtual_reg16(data,
+							 SCH5627_REG_FAN[i]);
+			if (unlikely(val < 0)) {
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->fan[i] = val;
+		}
+
+		for (i = 0; i < SCH5627_NO_IN; i++) {
+			val = sch5627_read_virtual_reg12(data,
+				SCH5627_REG_IN_MSB[i],
+				SCH5627_REG_IN_LSN[i],
+				SCH5627_REG_IN_HIGH_NIBBLE[i]);
+			if (unlikely(val < 0)) {
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->in[i] = val;
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+static int reg_to_temp(u16 reg)
+{
+	return (reg * 625) / 10 - 64000;
+}
+
+static int reg_to_temp_limit(u8 reg)
+{
+	return (reg - 64) * 1000;
+}
+
+static int reg_to_rpm(u16 reg)
+{
+	return 5400540 / reg;
+}
+
+static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", DRVNAME);
+}
+
+static ssize_t show_temp(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = sch5627_update_device(dev);
+	int val;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	val = reg_to_temp(data->temp[attr->index]);
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = sch5627_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (data->temp[attr->index] = 0)
+		return snprintf(buf, PAGE_SIZE, "1\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
+static ssize_t show_temp_max(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = dev_get_drvdata(dev);
+	int val;
+
+	val = reg_to_temp_limit(data->temp_max[attr->index]);
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_temp_crit(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = dev_get_drvdata(dev);
+	int val;
+
+	val = reg_to_temp_limit(data->temp_crit[attr->index]);
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_fan(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = sch5627_update_device(dev);
+	int val;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	val = reg_to_rpm(data->fan[attr->index]);
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_fan_fault(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = sch5627_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (data->fan[attr->index] = 0xffff)
+		return snprintf(buf, PAGE_SIZE, "1\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "0\n");
+}
+
+static ssize_t show_fan_min(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = dev_get_drvdata(dev);
+	int val = reg_to_rpm(data->fan_min[attr->index]);
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_in(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sch5627_data *data = sch5627_update_device(dev);
+	int val;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	val = (data->in[attr->index] * SCH5627_REG_IN_FACTOR[attr->index]) /
+		10000;
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t show_in_label(struct device *dev, struct device_attribute
+	*devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			SCH5627_IN_LABELS[attr->index]);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_temp_fault, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_temp_fault, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_temp_fault, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_temp_fault, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO, show_temp_max, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_max, S_IRUGO, show_temp_max, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_max, S_IRUGO, show_temp_max, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO, show_temp_crit, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO, show_temp_crit, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_crit, S_IRUGO, show_temp_crit, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_crit, S_IRUGO, show_temp_crit, NULL, 7);
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_fan_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_fault, S_IRUGO, show_fan_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_fault, S_IRUGO, show_fan_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan_min, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan_min, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO, show_fan_min, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_min, S_IRUGO, show_fan_min, NULL, 3);
+
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
+static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_in_label, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_in_label, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_in_label, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_in_label, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, show_in_label, NULL, 4);
+
+static struct attribute *sch5627_attributes[] = {
+	&dev_attr_name.attr,
+
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+	&sensor_dev_attr_temp6_fault.dev_attr.attr,
+	&sensor_dev_attr_temp7_fault.dev_attr.attr,
+	&sensor_dev_attr_temp8_fault.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp6_max.dev_attr.attr,
+	&sensor_dev_attr_temp7_max.dev_attr.attr,
+	&sensor_dev_attr_temp8_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit.dev_attr.attr,
+	&sensor_dev_attr_temp5_crit.dev_attr.attr,
+	&sensor_dev_attr_temp6_crit.dev_attr.attr,
+	&sensor_dev_attr_temp7_crit.dev_attr.attr,
+	&sensor_dev_attr_temp8_crit.dev_attr.attr,
+
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
+	&sensor_dev_attr_fan2_fault.dev_attr.attr,
+	&sensor_dev_attr_fan3_fault.dev_attr.attr,
+	&sensor_dev_attr_fan4_fault.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in0_label.dev_attr.attr,
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in4_label.dev_attr.attr,
+
+	NULL
+};
+
+static const struct attribute_group sch5627_group = {
+	.attrs = sch5627_attributes,
+};
+
+static int __devinit sch5627_probe(struct platform_device *pdev)
+{
+	struct sch5627_data *data;
+	int i, err, build_code, build_id, hwmon_rev, val;
+
+	data = kzalloc(sizeof(struct sch5627_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
+	mutex_init(&data->update_lock);
+	platform_set_drvdata(pdev, data);
+
+	val = sch5627_read_virtual_reg(data, SCH5627_REG_HWMON_ID);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	if (val != SCH5627_HWMON_ID) {
+		printk(KERN_ERR DRVNAME
+		       ": invalid hwmon id: %02X (expected %02X)\n",
+		       val, SCH5627_HWMON_ID);
+		err = -ENODEV;
+		goto error;
+	}
+
+	val = sch5627_read_virtual_reg(data, SCH5627_REG_COMPANY_ID);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	if (val != SCH5627_COMPANY_ID) {
+		printk(KERN_ERR DRVNAME
+		       ": invalid company id: %02X (expected %02X)\n",
+		       val, SCH5627_COMPANY_ID);
+		err = -ENODEV;
+		goto error;
+	}
+
+	val = sch5627_read_virtual_reg(data, SCH5627_REG_PRIMARY_ID);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	if (val != SCH5627_PRIMARY_ID) {
+		printk(KERN_ERR DRVNAME
+		       ": invalid primary id: %02X (expected %02X)\n",
+		       val, SCH5627_PRIMARY_ID);
+		err = -ENODEV;
+		goto error;
+	}
+
+	build_code = sch5627_read_virtual_reg(data, SCH5627_REG_BUILD_CODE);
+	if (build_code < 0) {
+		err = build_code;
+		goto error;
+	}
+
+	build_id = sch5627_read_virtual_reg16(data, SCH5627_REG_BUILD_ID);
+	if (build_id < 0) {
+		err = build_id;
+		goto error;
+	}
+
+	hwmon_rev = sch5627_read_virtual_reg(data, SCH5627_REG_HWMON_REV);
+	if (hwmon_rev < 0) {
+		err = hwmon_rev;
+		goto error;
+	}
+
+	val = sch5627_read_virtual_reg(data, SCH5627_REG_CTRL);
+	if (val < 0) {
+		err = val;
+		goto error;
+	}
+	if (!(val & 0x01)) {
+		printk(KERN_ERR DRVNAME ": hardware monitoring not enabled\n");
+		err = -ENODEV;
+		goto error;
+	}
+
+	/* Read limits, we do this only once as reading a register on
+	   the sch5627 is quite expensive (and they don't change) */
+	for (i = 0; i < SCH5627_NO_TEMPS; i++) {
+		/* Note what SMSC calls ABS, is what lm_sensors calls max
+		   (aka high), and HIGH is what lm_sensors calls crit. */
+		val = sch5627_read_virtual_reg(data, SCH5627_REG_TEMP_ABS[i]);
+		if (val < 0) {
+			err = val;
+			goto error;
+		}
+		data->temp_max[i] = val;
+
+		val = sch5627_read_virtual_reg(data, SCH5627_REG_TEMP_HIGH[i]);
+		if (val < 0) {
+			err = val;
+			goto error;
+		}
+		data->temp_crit[i] = val;
+	}
+	for (i = 0; i < SCH5627_NO_FANS; i++) {
+		val = sch5627_read_virtual_reg16(data, SCH5627_REG_FAN_MIN[i]);
+		if (val < 0) {
+			err = val;
+			goto error;
+		}
+		data->fan_min[i] = val;
+	}
+
+	printk(KERN_INFO DRVNAME
+	       ": firmware build: code %02X, id %04X. hwmon: rev %02X.\n",
+	       build_code, build_id, hwmon_rev);
+
+	/* Register sysfs interface files */
+	err = sysfs_create_group(&pdev->dev.kobj, &sch5627_group);
+	if (err)
+		goto error;
+
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+		goto error;
+	}
+
+	return 0;
+
+error:
+	sch5627_remove(pdev);
+	return err;
+}
+
+static int sch5627_remove(struct platform_device *pdev)
+{
+	struct sch5627_data *data = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	if (data->hwmon_dev)
+		hwmon_device_unregister(data->hwmon_dev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &sch5627_group);
+	kfree(data);
+
+	return 0;
+}
+
+static int __init sch5627_find(int sioaddr, unsigned short *address)
+{
+	u8 devid;
+	int err = superio_enter(sioaddr);
+	if (err)
+		return err;
+
+	devid = superio_inb(sioaddr, SIO_REG_DEVID);
+	if (devid != SIO_SCH5627_ID) {
+		printk(KERN_INFO DRVNAME ": Unsupported device id: %02x\n",
+		       (unsigned int)devid);
+		err = -ENODEV;
+		goto exit;
+	}
+
+	superio_select(sioaddr, SIO_SCH5627_EM_LD);
+
+	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
+		printk(KERN_WARNING DRVNAME ": Device not activated\n");
+		err = -ENODEV;
+		goto exit;
+	}
+
+	/* Warning the order of the low / high byte is the other way around
+	   as on most other superio devices!! */
+	*address = superio_inb(sioaddr, SIO_REG_ADDR) |
+		   superio_inb(sioaddr, SIO_REG_ADDR + 1) << 8;
+	if (*address = 0) {
+		printk(KERN_WARNING DRVNAME ": Base address not set\n");
+		err = -ENODEV;
+		goto exit;
+	}
+
+	err = 0;
+	printk(KERN_INFO DRVNAME ": Found %s chip at %#x\n",
+		DRVNAME, (unsigned int)*address);
+exit:
+	superio_exit(sioaddr);
+	return err;
+}
+
+static int __init sch5627_device_add(unsigned short address)
+{
+	struct resource res = {
+		.start	= address,
+		.end	= address + REGION_LENGTH - 1,
+		.flags	= IORESOURCE_IO,
+	};
+	int err;
+
+	sch5627_pdev = platform_device_alloc(DRVNAME, address);
+	if (!sch5627_pdev)
+		return -ENOMEM;
+
+	res.name = sch5627_pdev->name;
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit_device_put;
+
+	err = platform_device_add_resources(sch5627_pdev, &res, 1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device resource addition failed\n");
+		goto exit_device_put;
+	}
+
+	err = platform_device_add(sch5627_pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed\n");
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(sch5627_pdev);
+
+	return err;
+}
+
+static struct platform_driver sch5627_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DRVNAME,
+	},
+	.probe		= sch5627_probe,
+	.remove		= sch5627_remove,
+};
+
+static int __init sch5627_init(void)
+{
+	int err = -ENODEV;
+	unsigned short address;
+
+	if (sch5627_find(0x4e, &address) &&
+	    sch5627_find(0x2e, &address))
+		goto exit;
+
+	err = platform_driver_register(&sch5627_driver);
+	if (err)
+		goto exit;
+
+	err = sch5627_device_add(address);
+	if (err)
+		goto exit_driver;
+
+	return 0;
+
+exit_driver:
+	platform_driver_unregister(&sch5627_driver);
+exit:
+	return err;
+}
+
+static void __exit sch5627_exit(void)
+{
+	platform_device_unregister(sch5627_pdev);
+	platform_driver_unregister(&sch5627_driver);
+}
+
+MODULE_DESCRIPTION("SMSC SCH5627 Hardware Monitoring Driver");
+MODULE_AUTHOR("Hans de Goede (hdegoede@redhat.com)");
+MODULE_LICENSE("GPL");
+
+module_init(sch5627_init);
+module_exit(sch5627_exit);
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
