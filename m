From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Sep 2013 07:26:37 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <20130910092637.17e7464a@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/IwI0vCaeBOwVIaxP7zxNW4s"
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
To: lm-sensors@vger.kernel.org

--MP_/IwI0vCaeBOwVIaxP7zxNW4s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guenter, Ivan,

On Sat, 31 Aug 2013 06:51:14 -0700, Guenter Roeck wrote:
> > For reference, lm90 vs. new driver was already discussed here:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025132.html
> 
> the lm90 driver changed significantly since then, though. Support for
> the third sensor is there now, and adding a new sensor type is much easier.
> I only had a quick glance, but ADT7481 looks pretty similar to MAX6696.
> 
> Guenter
> 
> > Back then, Malcolm Crossley (Cc'd) was working on adding support for
> > the ADT7481. It was four years ago, I have no idea if it actually
> > happened or not.

I got my hands on the code originally written by Malcolm. The code has
been used so it must be working, but it was never submitted for
upstream inclusion. I am attaching it for reference.

That being said, as Guenter mentioned, the lm90 driver evolved a lot
since then, so while a separate driver made more sense back then, it
may no longer be the case.

-- 
Jean Delvare

--MP_/IwI0vCaeBOwVIaxP7zxNW4s
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=add-adt7481-driver.patch

Add support for the ADT7481 temperature sensor chip including extended

From: Malcolm Crossley <malcolm.crossley@ge.com>

temperature range support on the remote sensors.
---

 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1 
 drivers/hwmon/adt7481.c |  730 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 741 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/adt7481.c


diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9be8e17..5d7898a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -190,6 +190,16 @@ config SENSORS_ADT7462
 	  This driver can also be built as a module. If so, the module
 	  will be called adt7462.
 
+config SENSORS_ADT7481
+	tristate "Analog Devices ADT7481"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7481 temperature monitoring chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called adt7481.
+
 config SENSORS_ADT7470
 	tristate "Analog Devices ADT7470"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4aa1a3d..b68379f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SENSORS_ADT7411)	+= adt7411.o
 obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
+obj-$(CONFIG_SENSORS_ADT7481)   += adt7481.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_AMS)	+= ams/
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
diff --git a/drivers/hwmon/adt7481.c b/drivers/hwmon/adt7481.c
new file mode 100644
index 0000000..86a644e
--- /dev/null
+++ b/drivers/hwmon/adt7481.c
@@ -0,0 +1,730 @@
+/*
+ * adt7481.c - Part of lm_sensors, Linux kernel modules for hardware
+ *          monitoring
+ * Copyright (C) 2010 GE Intelligent Platforms
+ * Author: Malcolm Crossley <malcolm.crossley@ge.com>
+ * Based upon ADT7462 and LM90 driver
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+/*
+ * Addresses to scan
+ * The ADT7481 is at address 0x4c and the ADT7481-1 is at address
+ * 0x4d.
+ */
+
+static const unsigned short normal_i2c[] = {
+	 0x4c, 0x4d, I2C_CLIENT_END };
+
+/*
+ * The ADT7481 registers
+ */
+
+#define ADT7481_REG_R_MAN_ID		0x3E
+#define ADT7481_REG_R_CHIP_ID		0x3D
+#define ADT7481_REG_R_CONFIG1		0x03
+#define ADT7481_REG_W_CONFIG1		0x09
+#define ADT7481_REG_R_CONFIG2		0x24
+#define ADT7481_REG_W_CONFIG2		0x24
+#define ADT7481_REG_R_CONVRATE		0x04
+#define ADT7481_REG_W_CONVRATE		0x0A
+#define ADT7481_REG_R_STATUS		0x02
+#define ADT7481_REG_R_LOCAL_TEMP	0x00
+#define ADT7481_REG_R_LOCAL_HIGH	0x05
+#define ADT7481_REG_W_LOCAL_HIGH	0x0B
+#define ADT7481_REG_R_LOCAL_LOW		0x06
+#define ADT7481_REG_W_LOCAL_LOW		0x0C
+#define ADT7481_REG_R_LOCAL_CRIT	0x20
+#define ADT7481_REG_W_LOCAL_CRIT	0x20
+#define ADT7481_REG_R_REMOTE1_TEMPH	0x01
+#define ADT7481_REG_R_REMOTE1_TEMPL	0x10
+#define ADT7481_REG_R_REMOTE1_OFFSH	0x11
+#define ADT7481_REG_W_REMOTE1_OFFSH	0x11
+#define ADT7481_REG_R_REMOTE1_OFFSL	0x12
+#define ADT7481_REG_W_REMOTE1_OFFSL	0x12
+#define ADT7481_REG_R_REMOTE1_HIGHH	0x07
+#define ADT7481_REG_W_REMOTE1_HIGHH	0x0D
+#define ADT7481_REG_R_REMOTE1_HIGHL	0x13
+#define ADT7481_REG_W_REMOTE1_HIGHL	0x13
+#define ADT7481_REG_R_REMOTE1_LOWH	0x08
+#define ADT7481_REG_W_REMOTE1_LOWH	0x0E
+#define ADT7481_REG_R_REMOTE1_LOWL	0x14
+#define ADT7481_REG_W_REMOTE1_LOWL	0x14
+#define ADT7481_REG_R_REMOTE1_CRIT	0x19
+#define ADT7481_REG_W_REMOTE1_CRIT	0x19
+#define ADT7481_REG_R_REMOTE2_TEMPH	0x30
+#define ADT7481_REG_R_REMOTE2_TEMPL	0x33
+#define ADT7481_REG_R_REMOTE2_OFFSH	0x34
+#define ADT7481_REG_W_REMOTE2_OFFSH	0x34
+#define ADT7481_REG_R_REMOTE2_OFFSL	0x35
+#define ADT7481_REG_W_REMOTE2_OFFSL	0x35
+#define ADT7481_REG_R_REMOTE2_HIGHH	0x31
+#define ADT7481_REG_W_REMOTE2_HIGHH	0x31
+#define ADT7481_REG_R_REMOTE2_HIGHL	0x36
+#define ADT7481_REG_W_REMOTE2_HIGHL	0x36
+#define ADT7481_REG_R_REMOTE2_LOWH	0x32
+#define ADT7481_REG_W_REMOTE2_LOWH	0x32
+#define ADT7481_REG_R_REMOTE2_LOWL	0x37
+#define ADT7481_REG_W_REMOTE2_LOWL	0x37
+#define ADT7481_REG_R_REMOTE2_CRIT	0x39
+#define ADT7481_REG_W_REMOTE2_CRIT	0x39
+
+#define ADT7481_REG_R_TCRIT_HYST		0x21
+#define ADT7481_REG_W_TCRIT_HYST		0x21
+
+/*
+ * Device flags
+ */
+#define ADT7481_FLAG_ADT7461_EXT	0x01	/* ADT7461 extended mode */
+
+/*
+ * Functions declaration
+ */
+
+static int adt7481_detect(struct i2c_client *client,
+		       struct i2c_board_info *info);
+static int adt7481_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id);
+static void adt7481_init_client(struct i2c_client *client);
+static int adt7481_remove(struct i2c_client *client);
+static struct adt7481_data *adt7481_update_device(struct device *dev);
+
+/*
+ * Driver data (common to all clients)
+ */
+
+static const struct i2c_device_id adt7481_id[] = {
+	{ "adt7481", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adt7481_id);
+
+static struct i2c_driver adt7481_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "adt7481",
+	},
+	.probe		= adt7481_probe,
+	.remove		= adt7481_remove,
+	.id_table	= adt7481_id,
+	.detect		= adt7481_detect,
+	.address_list	= normal_i2c,
+};
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct adt7481_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	char valid; /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+	int flags;
+
+	/* registers values */
+	s8 temp8[5];	/* 0: local low limit
+			   1: local high limit
+			   2: local critical limit
+			   3: remote1 critical limit
+			   4: remote2 critical limit */
+	s16 temp11[9];	/* 0: remote1 input
+			   1: remote1 low limit
+			   2: remote1 high limit
+			   3: remote1 offset
+			   4: remote2 input
+			   5: remote2 low limit
+			   6: remote2 high limit
+			   7: remote2 offset
+			   8: local input */
+	u8 temp_hyst;
+	u8 alarms; /* bitvector */
+};
+
+/*
+ * Conversions
+ * For local temperatures and limits, critical limits and the hysteresis
+ * value, the ADT7481 uses signed 8-bit values with LSB = 1 degree Celsius.
+ * For remote temperatures and limits, it uses signed 11-bit values with
+ * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.  Some
+ * Maxim chips use unsigned values.
+ */
+
+
+static inline int temp_from_u8(u8 val)
+{
+	return val * 1000;
+}
+
+static inline int temp_from_u16(u16 val)
+{
+	return val / 32 * 125;
+}
+
+static u8 hyst_to_reg(long val)
+{
+	if (val <= 0)
+		return 0;
+	if (val >= 30500)
+		return 31;
+	return (val + 500) / 1000;
+}
+
+/*
+ * ADT7461 in compatibility mode is almost identical to ADT7481 except that
+ * attempts to write values that are outside the range 0 < temp < 127 are
+ * treated as the boundary value.
+ *
+ * ADT7461 in "extended mode" operation uses unsigned integers offset by
+ * 64 (e.g., 0 -> -64 degC).  The range is restricted to -64..191 degC.
+ */
+static inline int temp_from_u8_adt7461(struct adt7481_data *data, u8 val)
+{
+	if (data->flags & ADT7481_FLAG_ADT7461_EXT)
+		return (val - 64) * 1000;
+	else
+		return temp_from_u8(val);
+}
+
+static inline int temp_from_u16_adt7461(struct adt7481_data *data, u16 val)
+{
+	if (data->flags & ADT7481_FLAG_ADT7461_EXT)
+		return (val - 0x4000) / 64 * 250;
+	else
+		return temp_from_u16(val);
+}
+
+static u8 temp_to_u8_adt7461(struct adt7481_data *data, long val)
+{
+	if (data->flags & ADT7481_FLAG_ADT7461_EXT) {
+		if (val <= -64000)
+			return 0;
+		if (val >= 191000)
+			return 0xFF;
+		return (val + 500 + 64000) / 1000;
+	} else {
+		if (val <= 0)
+			return 0;
+		if (val >= 127000)
+			return 127;
+		return (val + 500) / 1000;
+	}
+}
+
+static u16 temp_to_u16_adt7461(struct adt7481_data *data, long val)
+{
+	if (data->flags & ADT7481_FLAG_ADT7461_EXT) {
+		if (val <= -64000)
+			return 0;
+		if (val >= 191750)
+			return 0xFFC0;
+		return (val + 64000 + 125) / 250 * 64;
+	} else {
+		if (val <= 0)
+			return 0;
+		if (val >= 127750)
+			return 0x7FC0;
+		return (val + 125) / 250 * 64;
+	}
+}
+
+/*
+ * Sysfs stuff
+ */
+
+static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7481_data *data = adt7481_update_device(dev);
+	int temp;
+
+	temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
+}
+
+static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	static const u8 reg[5] = {
+		ADT7481_REG_W_LOCAL_LOW,
+		ADT7481_REG_W_LOCAL_HIGH,
+		ADT7481_REG_W_LOCAL_CRIT,
+		ADT7481_REG_W_REMOTE1_CRIT,
+		ADT7481_REG_W_REMOTE2_CRIT
+	};
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7481_data *data = i2c_get_clientdata(client);
+	long val;
+	int nr = attr->index;
+	strict_strtol(buf, 10, &val);
+
+	mutex_lock(&data->update_lock);
+	data->temp8[nr] = temp_to_u8_adt7461(data, val);
+	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7481_data *data = adt7481_update_device(dev);
+	int temp;
+
+	temp = temp_from_u16_adt7461(data, data->temp11[attr->index]);
+
+	return sprintf(buf, "%d\n", temp);
+}
+
+static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	static const u8 reg[6] = {
+		ADT7481_REG_W_REMOTE1_LOWH,
+		ADT7481_REG_W_REMOTE1_LOWL,
+		ADT7481_REG_W_REMOTE1_HIGHH,
+		ADT7481_REG_W_REMOTE1_HIGHL,
+		ADT7481_REG_W_REMOTE1_OFFSH,
+		ADT7481_REG_W_REMOTE1_OFFSL,
+	};
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7481_data *data = i2c_get_clientdata(client);
+	long val;
+	int nr = attr->index;
+	strict_strtol(buf, 10, &val);
+
+
+	mutex_lock(&data->update_lock);
+	data->temp11[nr] = temp_to_u16_adt7461(data, val);
+	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
+				  data->temp11[nr] >> 8);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_temphyst(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7481_data *data = adt7481_update_device(dev);
+	int temp;
+
+	temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
+	return sprintf(buf, "%d\n", temp - temp_from_u8(data->temp_hyst));
+}
+
+static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
+			    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7481_data *data = i2c_get_clientdata(client);
+	long val;
+	int temp;
+	strict_strtol(buf, 10, &val);
+
+	mutex_lock(&data->update_lock);
+	temp = temp_from_u8_adt7461(data, data->temp8[2]);
+	data->temp_hyst = hyst_to_reg(temp - val);
+	i2c_smbus_write_byte_data(client, ADT7481_REG_W_TCRIT_HYST,
+				  data->temp_hyst);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+			   char *buf)
+{
+	struct adt7481_data *data = adt7481_update_device(dev);
+	return sprintf(buf, "%d\n", data->alarms);
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute
+			  *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7481_data *data = adt7481_update_device(dev);
+	int bitnr = attr->index;
+
+	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp11, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 1);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 2);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 6);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 2);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 3);
+static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 4);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temphyst,
+	set_temphyst, 2);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 3);
+static SENSOR_DEVICE_ATTR(temp3_offset, S_IWUSR | S_IRUGO, show_temp11,
+	set_temp11, 3);
+
+/* Individual alarm files */
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+/* Raw alarm file for compatibility */
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static struct attribute *adt7481_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&dev_attr_alarms.attr,
+	NULL
+};
+
+static const struct attribute_group adt7481_group = {
+	.attrs = adt7481_attributes,
+};
+
+/* pec used for ADM1032 only */
+static ssize_t show_pec(struct device *dev, struct device_attribute *dummy,
+			char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
+}
+
+static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
+		       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	long val;
+	strict_strtol(buf, 10, &val);
+
+	switch (val) {
+	case 0:
+		client->flags &= ~I2C_CLIENT_PEC;
+		break;
+	case 1:
+		client->flags |= I2C_CLIENT_PEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
+
+/* It is assumed that client->update_lock is held (unless we are in
+   detection or initialization steps). This matters when PEC is enabled,
+   because we don't want the address pointer to change between the write
+   byte and the read byte transactions. */
+static int adt7481_read_reg(struct i2c_client *client, u8 reg, u8 *value)
+{
+	int err;
+
+	err = i2c_smbus_read_byte_data(client, reg);
+
+	if (err < 0) {
+		dev_warn(&client->dev, "Register %#02x read failed (%d)\n",
+			 reg, err);
+		return err;
+	}
+	*value = err;
+
+	return 0;
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int adt7481_detect(struct i2c_client *new_client,
+						struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = new_client->adapter;
+	int man_id, chip_id;
+	const char *name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	man_id = i2c_smbus_read_byte_data(new_client, ADT7481_REG_R_MAN_ID);
+	if (man_id < 0)
+		return -ENODEV;
+
+	chip_id = i2c_smbus_read_byte_data(new_client, ADT7481_REG_R_CHIP_ID);
+	if (chip_id < 0)
+		return -ENODEV;
+
+	if ((man_id == 0x41) && (chip_id  == 0x81)) { /* ADT7481 */
+		if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+			info->flags |= I2C_CLIENT_PEC;
+	} else {
+		return -ENODEV;
+	}
+
+	/* Fill the i2c board info */
+	name = "adt7481";
+	strlcpy(info->type, name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int adt7481_probe(struct i2c_client *new_client,
+		      const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(new_client->dev.parent);
+	struct adt7481_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct adt7481_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	i2c_set_clientdata(new_client, data);
+	mutex_init(&data->update_lock);
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		new_client->flags &= ~I2C_CLIENT_PEC;
+
+	/* Initialize the ADT7481 chip */
+	adt7481_init_client(new_client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&new_client->dev.kobj, &adt7481_group);
+	if (err)
+		goto exit_free;
+	if (new_client->flags & I2C_CLIENT_PEC) {
+		err = device_create_file(&new_client->dev, &dev_attr_pec);
+		if (err)
+			goto exit_remove_files;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_files;
+	}
+
+	return 0;
+
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &adt7481_group);
+	device_remove_file(&new_client->dev, &dev_attr_pec);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static void adt7481_init_client(struct i2c_client *client)
+{
+	u8 config, config_orig;
+	struct adt7481_data *data = i2c_get_clientdata(client);
+
+	/*
+	 * Start the conversions.
+	 */
+	i2c_smbus_write_byte_data(client, ADT7481_REG_W_CONVRATE,
+				  5); /* 2 Hz */
+	if (adt7481_read_reg(client, ADT7481_REG_R_CONFIG1, &config) < 0) {
+		dev_warn(&client->dev, "Initialization failed!\n");
+		return;
+	}
+	config_orig = config;
+
+	/* Check Temperature Range Select */
+	if (config & 0x04)
+		data->flags |= ADT7481_FLAG_ADT7461_EXT;
+
+	config &= 0xBF;	/* run */
+	if (config != config_orig) /* Only write if changed */
+		i2c_smbus_write_byte_data(client, ADT7481_REG_W_CONFIG1,
+					  config);
+}
+
+static int adt7481_remove(struct i2c_client *client)
+{
+	struct adt7481_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &adt7481_group);
+	device_remove_file(&client->dev, &dev_attr_pec);
+	kfree(data);
+	return 0;
+}
+
+static int adt7481_read16(struct i2c_client *client, u8 regh, u8 regl,
+								u16 *value)
+{
+	int err;
+	u8 oldh, newh, l;
+
+	/*
+	 * There is a trick here. We have to read two registers to have the
+	 * sensor temperature, but we have to beware a conversion could occur
+	 * inbetween the readings. The datasheet says we should either use
+	 * the one-shot conversion register, which we don't want to do
+	 * (disables hardware monitoring) or monitor the busy bit, which is
+	 * impossible (we can't read the values and monitor that bit at the
+	 * exact same time). So the solution used here is to read the high
+	 * byte once, then the low byte, then the high byte again. If the new
+	 * high byte matches the old one, then we have a valid reading. Else
+	 * we have to read the low byte again, and now we believe we have a
+	 * correct reading.
+	 */
+	err = adt7481_read_reg(client, regh, &oldh);
+	if (err)
+		return err;
+
+	err = adt7481_read_reg(client, regl, &l);
+	if (err)
+		return err;
+	err = adt7481_read_reg(client, regh, &newh);
+	if (err)
+		return err;
+	if (oldh != newh) {
+		err = adt7481_read_reg(client, regl, &l);
+		if (err)
+			return err;
+	}
+	*value = (newh << 8) | l;
+
+	return 0;
+}
+
+static struct adt7481_data *adt7481_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7481_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
+		u8 h;
+
+		dev_dbg(&client->dev, "Updating adt7481 data.\n");
+		adt7481_read_reg(client, ADT7481_REG_R_LOCAL_LOW,
+				 &data->temp8[0]);
+		adt7481_read_reg(client, ADT7481_REG_R_LOCAL_HIGH,
+				 &data->temp8[1]);
+		adt7481_read_reg(client, ADT7481_REG_R_LOCAL_CRIT,
+				 &data->temp8[2]);
+		adt7481_read_reg(client, ADT7481_REG_R_REMOTE1_CRIT,
+				 &data->temp8[3]);
+		adt7481_read_reg(client, ADT7481_REG_R_REMOTE2_CRIT,
+				 &data->temp8[4]);
+		adt7481_read_reg(client, ADT7481_REG_R_TCRIT_HYST,
+				 &data->temp_hyst);
+
+		if (adt7481_read_reg(client, ADT7481_REG_R_LOCAL_TEMP, &h) == 0)
+			data->temp11[8] = h << 8;
+
+		adt7481_read16(client, ADT7481_REG_R_REMOTE1_TEMPH,
+			    ADT7481_REG_R_REMOTE1_TEMPL, &data->temp11[0]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE2_TEMPH,
+			    ADT7481_REG_R_REMOTE2_TEMPL, &data->temp11[4]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE1_LOWH,
+			    ADT7481_REG_R_REMOTE1_LOWL, &data->temp11[1]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE2_LOWH,
+			    ADT7481_REG_R_REMOTE2_LOWL, &data->temp11[5]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE1_HIGHH,
+			    ADT7481_REG_R_REMOTE1_HIGHL, &data->temp11[2]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE2_HIGHH,
+			    ADT7481_REG_R_REMOTE2_HIGHL, &data->temp11[6]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE1_OFFSH,
+			    ADT7481_REG_R_REMOTE1_OFFSL, &data->temp11[3]);
+		adt7481_read16(client, ADT7481_REG_R_REMOTE2_OFFSH,
+			    ADT7481_REG_R_REMOTE2_OFFSL, &data->temp11[7]);
+
+
+		adt7481_read_reg(client, ADT7481_REG_R_STATUS, &data->alarms);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static int __init sensors_adt7481_init(void)
+{
+	return i2c_add_driver(&adt7481_driver);
+}
+
+static void __exit sensors_adt7481_exit(void)
+{
+	i2c_del_driver(&adt7481_driver);
+}
+
+MODULE_AUTHOR("Malcolm Crossley <malcolm.crossley@ge.com>");
+MODULE_DESCRIPTION("ADT7481 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_adt7481_init);
+module_exit(sensors_adt7481_exit);

--MP_/IwI0vCaeBOwVIaxP7zxNW4s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/IwI0vCaeBOwVIaxP7zxNW4s--
