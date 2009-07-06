From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Mon, 06 Jul 2009 10:49:30 +0000
Subject: [lm-sensors] Intel Moorestown Platform Thermal Driver
Message-Id: <20090706212531.GA15120@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From 67d01c75ead0af5565d649e234e3f8c085871016 Mon Sep 17 00:00:00 2001
From: Kalhan Trisal <kalhan.trisal@intel.com>
Date: Mon, 6 Jul 2009 16:50:08 -0400
Subject: [PATCH] Intel Moorestown Platform thermal driver

Moorestown Platform has EMC1403 chip which support three thermal devices, one thermal zone is used by the EMC1403 chip itself and second is used by processor and third one is used for platform (skin temperature).Driver support poll and interrupt mode,min/max/crit configuration can be done using sysfs interface. 
The driver also support interrupt mode when the temperature crosses the threshold configured value the min/max/crit. ALERT/THERM interrupt will be triggered and driver register its callback with GPE driver, and send the events to OSPM power management to take action. OSPM will take action and set the new threshold values till it doesnot get ALERT/THERM events.temp1 is used for configuring internal EMC1403 chip diode, temp2 is used to configure processor diode and temp3 is used to configure the platform diode.

The interrupt mode code  has dependency MRST GPIO/GPE/OSPM drivers. Interupt code is under FLAG  once these drivers are accepted the FLAG will be enabled and this part of functionality will also work.  

Signed-off-by: Kalhan Trisal <kalhan.trisal@intel.com>

---
 drivers/hwmon/Kconfig        |   10 +
 drivers/hwmon/Makefile       |    1 +
 drivers/hwmon/mrst_thermal.c |  732 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 743 insertions(+), 0 deletions(-)
 create mode 100755 drivers/hwmon/mrst_thermal.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..0b730c8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1017,6 +1017,16 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_MRST_THERMAL
+	tristate "Moorestown Thermal"
+#	depends on I2C_MRST && GPE && GPIO_MAX7315 && MSTWN_POWER_MGMT
+	help
+	  If you say yes here you get support for the SMSC Devices
+	  EMC1403 temperature monitoring chip.
+
+	  Threshold values can be configured using sysfs.
+	  Data from the different diode are  accessible via sysfs.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..4f724da 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
+obj-$(CONFIG_SENSORS_MRST_THERMAL)	+= mrst_thermal.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/mrst_thermal.c b/drivers/hwmon/mrst_thermal.c
new file mode 100755
index 0000000..0e1f431
--- /dev/null
+++ b/drivers/hwmon/mrst_thermal.c
@@ -0,0 +1,732 @@
+/*
+ * mrst_thermal.c - Intel Thermal Driver
+ *
+ * Copyright (C) 2008 Intel Corp
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
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+#ifdef MSTWN_POWER_MGMT
+#include <linux/gpe.h>
+#include <linux/intel_mid.h>
+#endif
+
+
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_DESCRIPTION("Intel Moorestown Platform Thermal Driver");
+MODULE_LICENSE("GPL v2");
+
+/* Limit status reg Therm/High/Low/Fault*/
+static const u8 THM_STAT_REG_TEMP[] = { 0x37, 0x35, 0x36, 0x1B, 0x02};
+
+/* Channel  diode temp set */
+static const u8 THM_CHAN_TEMP[] = { 0x10, 0x08, 0x04, 0x02, 0x01 };
+
+/* Therm Limit reg store values */
+static const u8 THM_LIMIT_REG_TEMP[] = { 0x05, 0x06, 0x07, 0x08, 0x15, 0x16,
+						0x19, 0x1A, 0x20, 0x21 };
+
+/* DATA REGISTERS */
+static const u8 THM_REG_CURR_TEMP[] = { 0x00, 0x01, 0x23 };
+
+#define THERMAL_PID_REG            0xfd
+#define THERMAL_SMSC_ID_REG        0xfe
+#define THERMAL_REVISION_REG       0xff
+#define THERMAL_ADC_UPDATE_BUSY    0x80
+#define I2C_THERMAL_SLAVE_ADDR     0x4C
+#define TEMP1			1
+#define TEMP2        		2
+#define TEMP3           	4
+#define IRQ_TYPE_MASK         (1 << 15)
+#define HIGH_EVENT             	1
+#define LOW_EVENT             	2
+#define THERM_EVENT             3
+#define FAULT_EVENT             4
+#define ALERT_EVENT             1
+#define POWER_STA_ENABLE	0
+#define POWER_STA_DISABLE	1
+#define INTERRUPT_MODE_ENABLE   0
+#define INTERRUPT_MODE_DISABLE  1
+
+struct thermal_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+	int therm_irq;
+	int alert_irq;
+	struct work_struct therm_handler;
+	struct work_struct alert_handler;
+};
+
+#ifdef MSTWN_POWER_MGMT
+static irqreturn_t mrst_therm_interrupt_handler(int id, void *dev)
+{
+	struct thermal_data *data = (struct thermal_data *)dev;
+	schedule_work(&data->therm_handler);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mrst_alert_interrupt_handler(int id, void *dev)
+{
+	struct thermal_data *data = (struct thermal_data *)dev;
+	schedule_work(&data->alert_handler);
+
+	return IRQ_HANDLED;
+}
+#endif
+
+static unsigned int i2c_read_current_data(struct i2c_client *client, u8 reg)
+{
+	unsigned int ret_val;
+
+	ret_val = i2c_smbus_read_byte_data(client, reg);
+	return ret_val;
+}
+
+static unsigned int i2c_write_current_data(struct i2c_client *client,
+					unsigned int reg, unsigned int value)
+{
+	int ret_val;
+
+	ret_val = i2c_smbus_write_byte_data(client, reg, value);
+	return ret_val;
+}
+
+static int mrst_calculate_offset(int type, int temp_ofs)
+{
+	int offset = 0;
+
+	switch (type) {
+	case TEMP1:
+		if (temp_ofs = 0)
+			offset = 1;
+		else if (temp_ofs = 1)
+			offset = 0;
+		else if (temp_ofs = 2)
+			offset = 8;
+		break;
+	case TEMP2:
+		if (temp_ofs = 0)
+			offset = 3;
+		else if (temp_ofs = 1)
+			offset = 2;
+		else if (temp_ofs = 2)
+			offset = 6;
+		break;
+	case TEMP3:
+		if (temp_ofs = 0)
+			offset = 5;
+		else if (temp_ofs = 1)
+			offset = 4;
+		else if (temp_ofs = 2)
+			offset = 7;
+		break;
+	default:
+		offset = -1;
+		printk(KERN_WARNING "mrst_thermal: Invalid arg \n");
+		break;
+	}
+	return offset;
+
+}
+
+static void mrst_status_reg_read(struct i2c_client *client)
+{
+	i2c_read_current_data(client, 0x36);
+	i2c_read_current_data(client, 0x35);
+	i2c_read_current_data(client, 0x1B);
+}
+
+/* when the thermal governor takes action we unmask the bit
+ * if the temp is lower tham threshold values then no new event will
+ * be raised else if the current temperature is still high the interrupt
+ * will be sent again */
+
+static void mrst_reg_unmask_intr(struct i2c_client  *client, int offset,
+				int value)
+{
+	u8 ret_val, set_mask, ret = 0, alert = 0;
+
+	ret_val = i2c_read_current_data(client, 0x1F);
+	if (offset = 6 || offset = 7 || offset = 8) {
+		ret = i2c_read_current_data(client, 0x37); /* Themal status */
+	} else if (offset = 2 || offset = 3) {
+		if (((ret_val >>  1) & 1)) {
+			set_mask = (ret_val & 0x05);
+			alert = 1;
+		}
+	} else if (offset = 4 || offset = 5) {
+		if (((ret_val >>  2) & 1)) {
+			set_mask = (ret_val & 0x03);
+			alert = 1;
+		}
+	} else if (offset = 0 || offset = 1) {
+		if (ret_val & 1) {
+			set_mask = (ret_val & 0x06);
+			alert = 1;
+		}
+	}
+	/* only rest set the mask for alert events */
+	if (alert = 1) {
+		mrst_status_reg_read(client);
+		i2c_write_current_data(client, 0x1F, set_mask);
+	}
+}
+
+static ssize_t show_temp_auto_offset(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
+	int temp_index = s_attr->index;
+	int temp_ofs = s_attr->nr;
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val = 0;
+	int ret_offset = 0;
+
+	ret_offset = mrst_calculate_offset(temp_index, temp_ofs);
+	if (ret_offset != -1) {
+		ret_val = i2c_read_current_data(client,
+					THM_LIMIT_REG_TEMP[ret_offset]);
+		return sprintf(buf, "%d\n", ret_val);
+	} else {
+		return -EINVAL;
+	}
+}
+
+static ssize_t store_temp_auto_offset(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
+	int temp_index = s_attr->index;
+	int temp_ofs = s_attr->nr;
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val;
+	int ret_offset = 0;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret_offset = mrst_calculate_offset(temp_index, temp_ofs);
+	if (ret_offset != -1) {
+		i2c_write_current_data(client,
+					THM_LIMIT_REG_TEMP[ret_offset], val);
+		mrst_reg_unmask_intr(client, ret_offset, val);
+		return count;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static ssize_t show_temp_hyst(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, THM_LIMIT_REG_TEMP[9]);
+	return sprintf(buf, "%d\n", ret_val);
+}
+
+static ssize_t store_temp_hyst(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	i2c_write_current_data(client, THM_LIMIT_REG_TEMP[9], val);
+	return count;
+}
+
+static ssize_t show_temp1_curr_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[0]);
+	return sprintf(buf, "%d\n", ret_val);
+}
+
+static ssize_t show_temp2_curr_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[1]);
+	return sprintf(buf, "%d\n", ret_val);
+}
+
+static ssize_t show_temp3_curr_temp(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+	ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[2]);
+	return sprintf(buf, "%d\n", ret_val);
+}
+
+static ssize_t show_alarm_status(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, 0x1F);
+	return sprintf(buf, "%x", ret_val);
+}
+
+static ssize_t store_alarm_status(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	i2c_write_current_data(client, 0x1F, val);
+	return count;
+}
+
+static ssize_t show_power_state(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, 0x03);
+	ret_val = ret_val & 0x40;
+	if (ret_val = 0x40)
+		ret_val = 1;
+	return sprintf(buf, "%x", ret_val);
+}
+
+static ssize_t store_power_state(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+	char curr_val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	curr_val = i2c_read_current_data(client, 0x03);
+	if (val = POWER_STA_ENABLE)
+		curr_val = curr_val & 0xBF;
+	else if (val = POWER_STA_DISABLE)
+		curr_val = curr_val | 0x40;
+	else
+		return -EINVAL;
+	i2c_write_current_data(client, 0x03, curr_val);
+	return count;
+}
+
+static ssize_t show_mode(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret_val;
+
+	ret_val = i2c_read_current_data(client, 0x03);
+	ret_val = ret_val & 0x80;
+	if (ret_val = 0x80)
+		ret_val = 1;
+	return sprintf(buf, "%x", ret_val);
+}
+
+static ssize_t store_mode(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+	char curr_val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+
+	curr_val = i2c_read_current_data(client, 0x03);
+	if (val = INTERRUPT_MODE_ENABLE)
+		curr_val = curr_val & 0x7F;
+	else if (val = INTERRUPT_MODE_DISABLE)
+		curr_val = curr_val | 0x80;
+	else
+		return -EINVAL;
+	i2c_write_current_data(client, 0x03, curr_val);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 0, 1);
+static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 1, 1);
+static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 2, 1);
+static DEVICE_ATTR(temp1_curr, S_IRUGO, show_temp1_curr_temp, NULL);
+
+static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 0, 2);
+static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 1, 2);
+static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 2, 2);
+static DEVICE_ATTR(temp2_curr, S_IRUGO, show_temp2_curr_temp, NULL);
+
+static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 0, 4);
+static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 1, 4);
+static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR,
+	show_temp_auto_offset, store_temp_auto_offset, 2, 4);
+static DEVICE_ATTR(temp3_curr, S_IRUGO, show_temp3_curr_temp, NULL);
+
+static DEVICE_ATTR(hyster, S_IRUGO | S_IWUSR, show_temp_hyst, store_temp_hyst);
+static DEVICE_ATTR(alarm_status, S_IRUGO | S_IWUSR,
+	show_alarm_status, store_alarm_status);
+
+static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
+	show_power_state, store_power_state);
+static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode);
+
+static struct attribute *mid_att_thermal[] = {
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&dev_attr_temp1_curr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&dev_attr_temp2_curr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&dev_attr_temp3_curr.attr,
+	&dev_attr_hyster.attr,
+	&dev_attr_alarm_status.attr,
+	&dev_attr_power_state.attr,
+	&dev_attr_mode.attr,
+	NULL
+};
+
+static struct attribute_group m_thermal_gr = {
+	.name = "mrst_thermal",
+	.attrs = mid_att_thermal
+};
+
+static void mrst_thermal_set_default_config(struct i2c_client *client)
+{
+	i2c_smbus_write_byte_data(client, 0x03, 0x00);
+	i2c_smbus_write_byte_data(client, 0x04, 0x02);
+	i2c_smbus_write_byte_data(client, 0x22, 0x00);
+}
+
+#ifdef MSTWN_POWER_MGMT
+/* when the device raise the interrupt we mask the interrupt
+ * bit for that device as the status register is R-C
+ * so that till thermal governor doesnot take action  we need
+ * not to send continuous events */
+
+static int mrst_interrupt_status(struct i2c_client *client, u8 diode_reg_val,
+				u8 *status, u8 event)
+{
+	u8 crit_st = 0, set_mask = 0;
+
+	set_mask = i2c_read_current_data(client, 0x1F);
+	if (diode_reg_val & THM_CHAN_TEMP[3]) {
+		set_mask = (set_mask | 0x02);
+		crit_st = (crit_st  | 2);
+	}
+	if (diode_reg_val & THM_CHAN_TEMP[2]) {
+		set_mask = (set_mask | 0x04);
+		crit_st = (crit_st  | 4);
+	}
+	if (diode_reg_val & THM_CHAN_TEMP[4]) {
+		set_mask = (set_mask | 0x01);
+		crit_st = (crit_st  | 1);
+	}
+	if (event = ALERT_EVENT)
+		i2c_smbus_write_byte_data(client, 0x1F, set_mask);
+	*status = crit_st;
+	return 0;
+}
+static void mrst_ospm_event(int event_id, int sensor_id, int curr_temp)
+{
+	if (event_id = THERM_EVENT) {
+		printk(KERN_ALERT "mrst_thermal: Sensor Id = %d crit event \
+					temp = %d \n", sensor_id, curr_temp);
+		ospm_generate_netlink_event(sensor_id,
+					OSPM_EVENT_THERMAL_CRITICAL);
+	}
+	if (event_id = HIGH_EVENT) {
+		printk(KERN_ALERT "mrst_thermal: Sensor Id = %d AUX1 event \
+					temp = %d \n", sensor_id, curr_temp);
+		ospm_generate_netlink_event(sensor_id,
+					OSPM_EVENT_THERMAL_AUX1);
+	}
+	if (event_id = LOW_EVENT) {
+		printk(KERN_ALERT "mrst_thermal: Sensor Id = %d AUX0 event \
+					temp = %d \n", sensor_id, curr_temp);
+	ospm_generate_netlink_event(sensor_id,
+					OSPM_EVENT_THERMAL_AUX0);
+	}
+	if (event_id = FAULT_EVENT) {
+		printk(KERN_ALERT "mrst_thermal: Sensor Id  = %d Fault event \
+					temp = %d \n", sensor_id, curr_temp);
+		ospm_generate_netlink_event(sensor_id,
+					OSPM_EVENT_THERMAL_DEV_FAULT);
+	}
+}
+
+static void mrst_send_event(struct i2c_client *client, int status, int event_id)
+{
+	int ret_val;
+
+	if (status & TEMP1) {
+		ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[0]);
+		mrst_ospm_event(event_id, TEMP_DEV_ID1, ret_val);
+	}
+	if (status & TEMP2) {
+		ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[1]);
+		mrst_ospm_event(event_id, TEMP_DEV_ID2, ret_val);
+	}
+	if (status & TEMP3) {
+		ret_val = i2c_read_current_data(client, THM_REG_CURR_TEMP[2]);
+		mrst_ospm_event(event_id, TEMP_DEV_ID3, ret_val);
+	}
+}
+
+static void mrst_therm_handle_intrpt(struct work_struct *work)
+{
+	u8 status, reg_val;
+	struct thermal_data *data = container_of(work,
+					struct thermal_data, therm_handler);
+
+	/* check if therm_module_info is initialized */
+	if (!data)
+		return;
+	/* Which DIODE has raised the interrupt 0x1B
+		internal/External1/External2 */
+	reg_val = i2c_smbus_read_byte_data(data->client,
+						THM_STAT_REG_TEMP[0]);
+	mrst_interrupt_status(data->client, reg_val, &status, THERM_EVENT);
+	mrst_send_event(data->client, status, THERM_EVENT);
+}
+
+static void mrst_alert_handle_intrpt(struct work_struct *work)
+{
+	int sta_reg_val, reg_val;
+	u8 status;
+	struct thermal_data *data = container_of(work,
+					struct thermal_data, alert_handler);
+	if (!data)
+		return;
+	/* HIGH/ LOW / FAULT Alert has occured for */
+	reg_val = i2c_smbus_read_byte_data(data->client, THM_STAT_REG_TEMP[4]);
+	/* High status bit is set */
+	if (reg_val & THM_CHAN_TEMP[0]) {
+		/* Which DIODE has raised the interrupt 0x1B
+		internal/External1/External2 */
+		sta_reg_val = i2c_smbus_read_byte_data(data->client,
+					THM_STAT_REG_TEMP[1]);
+		mrst_interrupt_status(data->client, sta_reg_val, &status,
+					ALERT_EVENT);
+		mrst_send_event(data->client, status, HIGH_EVENT);
+	}
+	/* Low status bit is set */
+	if (reg_val & THM_CHAN_TEMP[1]) {
+		sta_reg_val = i2c_smbus_read_byte_data(data->client,
+					THM_STAT_REG_TEMP[2]);
+		mrst_interrupt_status(data->client, sta_reg_val, &status,
+					ALERT_EVENT);
+		mrst_send_event(data->client, status, LOW_EVENT);
+	}
+	/* Fault status bit is set */
+	if (reg_val & THM_CHAN_TEMP[2]) {
+		sta_reg_val = i2c_smbus_read_byte_data(data->client,
+					THM_STAT_REG_TEMP[3]);
+		mrst_interrupt_status(data->client, sta_reg_val, &status,
+					ALERT_EVENT);
+		mrst_send_event(data->client, status, FAULT_EVENT);
+	}
+}
+#endif
+
+static int  mrst_thermal_probe(struct i2c_client *new_client,
+			const struct i2c_device_id *id)
+{
+	int res = 0;
+	struct thermal_data *data;
+	u16 pid, smsc_id, revision, t_irq, a_irq;
+
+	data = kzalloc(sizeof(struct thermal_data), GFP_KERNEL);
+
+	if (data = NULL) {
+		printk(KERN_WARNING "mrst_thermal: Memory allocation failed");
+		return -ENOMEM;
+	}
+	t_irq = new_client->irq;
+	a_irq = *(short *)new_client->dev.platform_data;
+	data->therm_irq = t_irq & ~IRQ_TYPE_MASK;
+	data->alert_irq = a_irq & ~IRQ_TYPE_MASK;
+	data->client = new_client;
+	i2c_set_clientdata(new_client, data);
+
+	/* Check if thermal chip is SMSC and EMC1403 */
+	smsc_id = i2c_read_current_data(new_client,
+					THERMAL_SMSC_ID_REG);
+	if (smsc_id != 0x5d) {
+		printk(KERN_WARNING "mrst_thermal: vendor id mismatch \n");
+		goto thermal_error1;
+	}
+	pid = i2c_read_current_data(new_client, THERMAL_PID_REG);
+	if (pid != 0x21)  {
+		printk(KERN_WARNING "mrst_thermal: Prod id mismatch \n");
+		goto thermal_error1;
+	}
+	revision = i2c_read_current_data(new_client,
+				THERMAL_REVISION_REG);
+	if (revision != 0x01) {
+		printk(KERN_WARNING "mrst_thermal: Rev id mismatch is \n");
+		goto thermal_error1;
+	}
+	res = sysfs_create_group(&new_client->dev.kobj, &m_thermal_gr);
+	if (res) {
+		printk(KERN_WARNING "mrst_thermal: create group  failed! \n");
+		hwmon_device_unregister(data->hwmon_dev);
+		goto thermal_error1;
+	}
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
+		data->hwmon_dev = NULL;
+		printk(KERN_WARNING "mrst_thermal:Register hwmon dev Failed\n");
+		goto thermal_error1;
+	}
+#ifdef MSTWN_POWER_MGMT
+	INIT_WORK(&data->therm_handler, (void *)mrst_therm_handle_intrpt);
+	INIT_WORK(&data->alert_handler, (void *)mrst_alert_handle_intrpt);
+	/* interpret irq field */
+	int retval = 0;
+	if (data->therm_irq = 0x113) {
+		if (t_irq & IRQ_TYPE_MASK) {
+			/* irq -> GPE_ID */
+			retval = request_gpe(data->therm_irq,
+				(gpio_function_t)mrst_therm_interrupt_handler,
+				 data, DETECT_LEVEL_LOW);
+			if (retval)
+				dev_crit(&new_client->dev, "%s(): cannot \
+					register therm gpe  \n", __func__);
+			} else {
+				retval = request_irq(data->therm_irq,
+					mrst_therm_interrupt_handler,
+					DETECT_LEVEL_LOW, "mrst_thermal", data);
+				if (retval)
+					dev_crit(&new_client->dev, "%s(): \
+					cannot get therm IRQ\n", __func__);
+			}
+		} else {
+			printk(KERN_WARNING"mrst_thermal: IRQ mismatch  \
+						sent for therm registration");
+		}
+		if (data->alert_irq = 0x114) {
+			if (a_irq & IRQ_TYPE_MASK) {
+				/* irq -> GPE_ID */
+				retval = request_gpe(data->alert_irq,
+				(gpio_function_t)mrst_alert_interrupt_handler,
+				 data, DETECT_LEVEL_LOW);
+				if (retval)
+					dev_crit(&new_client->dev, "%s(): \
+				cannot register alert gpe \n", __func__);
+			} else {
+				retval = request_irq(data->alert_irq,
+				mrst_alert_interrupt_handler, DETECT_LEVEL_LOW,
+				"mrst_thermal", data);
+			if (retval)
+				dev_crit(&new_client->dev, "%s():  cannot \
+					get alert IRQ\n", __func__);
+			}
+		} else {
+			printk(KERN_WARNING"mrst_thermal: IRQ mismatch \
+						sent for alert registration");
+		}
+#endif
+	mrst_thermal_set_default_config(new_client);
+	dev_info(&new_client->dev, "%s MRST Thermal chip found \n",
+							new_client->name);
+	return res;
+thermal_error1:
+	kfree(data);
+	i2c_set_clientdata(new_client, NULL);
+	return res;
+}
+
+static int mrst_thermal_remove(struct i2c_client *client)
+{
+	struct thermal_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &m_thermal_gr);
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_device_id mrst_thermal_idtable[] = {
+	{ "i2c_thermal", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, mrst_thermal_idtable);
+
+static struct i2c_driver mrst_thermal_driver = {
+	.driver = {
+		.name = "mrst_thermal",
+	},
+	.probe = mrst_thermal_probe,
+	.remove = mrst_thermal_remove,
+	.id_table = mrst_thermal_idtable,
+};
+
+static int __init mrst_thermal_driver_init(void)
+{
+	return i2c_add_driver(&mrst_thermal_driver);
+}
+
+static void  __exit mrst_thermal_driver_exit(void)
+{
+	i2c_del_driver(&mrst_thermal_driver);
+}
+
+module_init(mrst_thermal_driver_init);
+module_exit(mrst_thermal_driver_exit);
-- 
1.6.0.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
