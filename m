From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: new adm9240 driver
Message-Id: <1v4861l0755o0ghph0dmb0rv5u69q45r52@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, Greg,

Another update of new adm9240 driver, completing Michiel Rook's port 
to 2.6.  This driver adds auto new fan clock divider that is set by 
the driver in response to fan speed limit and adjusted on fan measurement 
overflow to always display fan speeds within measurement range without 
further user intervention.

This patch includes changes based on Jean Delvare's feedback and fixes 
auto fan clock divider operation, also catches a nasty div/0 overrange
response that segfaulted and locked driver once during testing yesterday.

Added:
Chassis Intrusion latch clear write only accessor
Removed:
Fan divider write accessor, read accessor left in to not break 
existing libsensors.

Developed on 2.6.11.7, patch compile tested on 2.6.12rc2-mm3.

Signed-Off-By: Grant Coady <gcoady@gmail.com>



---
 Kconfig   |   11 
 Makefile  |    1 
 adm9240.c |  741 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 753 insertions(+)

diff -Nrup -X dontdiff linux-2.6.12-rc2-mm3/drivers/i2c/chips/Kconfig linux-2.6.12-rc2-mm3k/drivers/i2c/chips/Kconfig
--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/Kconfig	2005-04-11 20:54:56.000000000 +1000
+++ linux-2.6.12-rc2-mm3k/drivers/i2c/chips/Kconfig	2005-04-18 18:30:30.000000000 +1000
@@ -51,6 +51,17 @@ config SENSORS_ADM1031
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1031.
 
+config SENSORS_ADM9240
+	tristate "Analog Devices ADM9240, Dallas DS1780 and NatSemi LM81"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM9240,
+	  Dallas DS1780, National Semiconductor LM81 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm9240.
+
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
 	depends on I2C && EXPERIMENTAL
diff -Nrup -X dontdiff linux-2.6.12-rc2-mm3/drivers/i2c/chips/Makefile linux-2.6.12-rc2-mm3k/drivers/i2c/chips/Makefile
--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/Makefile	2005-04-11 20:54:56.000000000 +1000
+++ linux-2.6.12-rc2-mm3k/drivers/i2c/chips/Makefile	2005-04-18 18:31:15.000000000 +1000
@@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
diff -Nrup -X dontdiff linux-2.6.12-rc2-mm3/drivers/i2c/chips/adm9240.c linux-2.6.12-rc2-mm3k/drivers/i2c/chips/adm9240.c
--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/adm9240.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.12-rc2-mm3k/drivers/i2c/chips/adm9240.c	2005-04-18 18:56:46.000000000 +1000
@@ -0,0 +1,741 @@
+/*
+ * adm9240.c	Part of lm_sensors, Linux kernel modules for hardware
+ * 		monitoring
+ *
+ * Copyright (C) 1999	Frodo Looijaard <frodol@dds.nl>
+ *			Philip Edelbrock <phil@netroedge.com>
+ * Copyright (C) 2003	Michiel Rook <michiel@grendelproject.nl>
+ * Copyright (C) 2005	Grant Coady <gcoady@gmail.com> with valuable
+ * 				guidance from Jean Delvare
+ *
+ * Driver supports	Analog Devices		ADM9240
+ *			Dallas Semiconductor	DS1780
+ *			National Semiconductor	LM81
+ *
+ * ADM9240 is the reference, DS1780 and LM81 are register compatibles
+ *
+ * Voltage	Six inputs are scaled by chip, VID also reported
+ * Temperature	Chip temperature to 0.5'C, maximum and max_hysteris
+ * Fans		2 fans, low speed alarm, automatic fan clock divider
+ * Alarms	16-bit map of active alarms
+ * 
+ * Analog Out	0..1250 mV output
+ * Intrusion	Chassis Intrusion, CI latch clear write only accessor
+ * 
+ * Test hardware: Intel SE440BX-2 desktop motherboard --Grant
+ *
+ * LM81 extended temp reading not implemented
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c,0x2d,0x2e,0x2f, I2C_CLIENT_END };
+
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_3(adm9240, ds1780, lm81);
+
+/* ADM9240 registers */
+#define ADM9240_REG_MAN_ID		0x3e
+#define ADM9240_REG_DIE_REV		0x3f
+#define ADM9240_REG_CONFIG		0x40
+
+#define ADM9240_REG_IN(nr)		(0x20 + (nr))   /* 0..5 */
+#define ADM9240_REG_IN_MAX(nr)		(0x2b + (nr) * 2)
+#define ADM9240_REG_IN_MIN(nr)		(0x2c + (nr) * 2)
+#define ADM9240_REG_FAN(nr)		(0x28 + (nr))   /* 0..1 */
+#define ADM9240_REG_FAN_MIN(nr)		(0x3b + (nr))
+#define ADM9240_REG_INT(nr)		(0x41 + (nr))
+#define ADM9240_REG_INT_MASK(nr)	(0x43 + (nr))
+#define ADM9240_REG_TEMP		0x27
+#define ADM9240_REG_TEMP_HIGH		0x39
+#define ADM9240_REG_TEMP_HYST		0x3a
+#define ADM9240_REG_ANALOG_OUT		0x19
+#define ADM9240_REG_CHASSIS_CLEAR	0x46
+#define ADM9240_REG_VID_FAN_DIV		0x47
+#define ADM9240_REG_I2C_ADDR		0x48
+#define ADM9240_REG_VID4		0x49
+#define ADM9240_REG_TEMP_CONF		0x4b
+
+/* generalised integer scaling with rounding (value, multiplier, divisor) */
+#define USCALE(v,m,d)		(((m) * (v) + (d) / 2) / (d))
+#define SCALE(v,m,d)		((v) < 0 ? ((m) * (v) - (d) / 2) / (d) :\
+					((m) * (v) + (d) / 2) / (d))
+
+/* adm9240 does internal voltage scaling */
+static const u16 nom[6] = {2500, 2700, 3300, 5000, 12000, 2700};
+
+#define IN_FROM_REG(reg,n)	(USCALE((reg), nom[n], 192))
+#define IN_TO_REG(val,n)	(SENSORS_LIMIT(\
+					USCALE((val), 192, nom[n]), 0, 255))
+
+/* temperature limits clamped to chip -ve = -40, 127 = disable */
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT(\
+					SCALE((val), 1, 1000), -40, 127))
+
+/* two fans, auto fan clock divider */
+#define FAN_FROM_REG(reg,div)	((reg) = 255 ? 0 : (reg) = 0 ? -1 :\
+					USCALE(1350000, 1, ((reg) * (div))))
+
+/* analog out */
+#define AOUT_TO_REG(val)	(SENSORS_LIMIT(\
+					USCALE((val), 255, 1250), 0, 255))
+
+static int adm9240_attach_adapter(struct i2c_adapter *adapter);
+static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind);
+static void adm9240_init_client(struct i2c_client *client);
+static int adm9240_detach_client(struct i2c_client *client);
+static struct adm9240_data *adm9240_update_device(struct device *dev);
+
+/* driver data */
+static struct i2c_driver adm9240_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "adm9240",
+	.id		= I2C_DRIVERID_ADM9240,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= adm9240_attach_adapter,
+	.detach_client	= adm9240_detach_client,
+};
+
+/* per client data */
+struct adm9240_data {
+	enum chips type;
+	struct i2c_client client;
+	struct semaphore update_lock;
+	char valid;
+	unsigned long last_updated_reading;
+	unsigned long last_updated_config;
+
+	u8 in[6];		/* ro	in0_input */
+	u8 in_max[6];		/* rw	in0_max */
+	u8 in_min[6];		/* rw	in0_min */
+	u8 fan[2];		/* ro	fan1_input */
+	u8 fan_min[2];		/* rw	fan1_min */
+	u8 fan_div[2];		/* rw	fan1_div, read-only to user */
+	s16 temp;		/* ro	temp1_input */
+	s8 temp_high;		/* rw	temp1_max */
+	s8 temp_hyst;		/* rw	temp1_max_hyst */
+	u8 alarms[2];		/* ro	alarms */
+	u8 intr_mask[2];	/* rw	FIXME this is useless, remove? */
+	u8 analog_out;		/* rw	analog_out */
+	u8 vid;			/* ro	vid */
+	u8 vrm;			/* --	vrm set on startup */
+};
+
+/* i2c byte read/write interface */
+static int adm9240_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int adm9240_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/* temperature */
+#define show_temp(value,scale)					\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct adm9240_data *data = adm9240_update_device(dev);	\
+	return sprintf(buf,"%d\n",data->value * scale);		\
+}
+show_temp(temp_high,1000);
+show_temp(temp_hyst,1000);
+show_temp(temp,500);
+
+#define set_temp(value, reg)					\
+static ssize_t set_##value(struct device *dev, const char *buf,	\
+		size_t count)					\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm9240_data *data = adm9240_update_device(dev);	\
+	long temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	down(&data->update_lock);				\
+	data->value = TEMP_TO_REG(temp);			\
+	adm9240_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
+	return count;						\
+}
+set_temp(temp_high, ADM9240_REG_TEMP_HIGH);
+set_temp(temp_hyst, ADM9240_REG_TEMP_HYST);
+
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+		show_temp_high, set_temp_high);
+static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
+		show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+
+/* voltage */
+static ssize_t show_in(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr], nr));
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr], nr));
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr], nr));
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[nr] = IN_TO_REG(val, nr);
+	adm9240_write_value(client, ADM9240_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_in_max(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[nr] = IN_TO_REG(val, nr);
+	adm9240_write_value(client, ADM9240_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_in_offset(offset)						\
+static ssize_t show_in##offset(struct device *dev, char *buf)		\
+{									\
+	return show_in(dev, buf, offset);				\
+}									\
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);	\
+static ssize_t show_in##offset##_min(struct device *dev, char *buf)	\
+{									\
+	return show_in_min(dev, buf, offset);				\
+}									\
+static ssize_t show_in##offset##_max(struct device *dev, char *buf)	\
+{									\
+	return show_in_max(dev, buf, offset);				\
+}									\
+static ssize_t								\
+set_in##offset##_min(struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_in_min(dev, buf, count, offset);			\
+}									\
+static ssize_t								\
+set_in##offset##_max(struct device *dev, const char *buf, size_t count)	\
+{									\
+	return set_in_max(dev, buf, count, offset);			\
+}									\
+static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,			\
+		show_in##offset##_min, set_in##offset##_min);		\
+static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,			\
+		show_in##offset##_max, set_in##offset##_max);
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+show_in_offset(5);
+
+/* fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
+				1 << data->fan_div[nr]));
+}
+
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
+				1 << data->fan_div[nr]));
+}
+
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf,"%d\n", 1 << data->fan_div[nr]);
+}
+
+/* write new fan div, callers must hold data->update_lock */
+static void adm9240_write_fan_div(struct i2c_client *client, int nr,
+		u8 fan_div)
+{
+	u8 reg, old, shift = (nr + 2) * 2; /* bit shift counter */
+
+	reg = adm9240_read_value(client, ADM9240_REG_VID_FAN_DIV);
+	old = (reg >> shift) & 3;
+	reg &= ~(3 << shift);
+	reg |= (fan_div << shift);
+	adm9240_write_value(client, ADM9240_REG_VID_FAN_DIV, reg);
+	dev_dbg(&client->dev, "fan%d clock divider changed from %u "
+			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
+}
+
+/* automatic fan clock divider selection when user sets fan_min */
+static ssize_t set_fan_min(struct device *dev, const char *buf,
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	u8 new_div = data->fan_div[nr];
+
+	down(&data->update_lock);
+
+	if (!val) {
+		/* setting fan_min to zero disables the fan_min alarm */
+		data->fan_min[nr] = 255;
+		dev_dbg(&client->dev, "fan%u low limit set disabled\n",
+				nr + 1);
+
+	} else if (val <= FAN_FROM_REG(8,254)) {
+		/* fan_min too low to measure, set max fan clock divider
+		 * and enable fan_min at slowest setting to assert alarm
+		 * when fan_speed < minimum measurable fan_min */
+		new_div = 3;
+		data->fan_min[nr] = 254;
+		dev_dbg(&client->dev, "fan%u low limit set minimum %u\n",
+				nr + 1, FAN_FROM_REG(1 << new_div, 254));
+
+	} else {
+		/* calculate fan clock divider to suit new fan_min, set
+		 * new fan_div to suit user low speed alarm point - the 
+		 * fan speed measurment section may adjust fan_div back 
+		 * up when fan speed measurement overflow is detected */
+		unsigned int new_min = FAN_FROM_REG(1,val);
+		new_div = 0;
+
+		while (new_min > 192 && new_div < 3) {
+			new_div++;
+			new_min++;
+			new_min >>= 1;
+		}
+
+		if (!new_min) /* enforce lower bound = 1 to avoid div/0 */
+			new_min++;
+
+		data->fan_min[nr] = new_min;
+		dev_dbg(&client->dev, "fan%u low limit set fan speed %u\n",
+				nr + 1, FAN_FROM_REG(1 << new_div, new_min));
+	}
+
+	if (new_div != data->fan_div[nr]) {
+		data->fan_div[nr] = new_div;
+		adm9240_write_fan_div(client, nr, new_div);
+	}
+
+	adm9240_write_value(client, ADM9240_REG_FAN_MIN(nr),
+			data->fan_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+{									\
+return show_fan(dev, buf, offset - 1);					\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+{									\
+return show_fan_div(dev, buf, offset - 1);				\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+{									\
+return show_fan_min(dev, buf, offset - 1);				\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev,		\
+const char *buf, size_t count)						\
+{									\
+return set_fan_min(dev, buf, count, offset - 1);			\
+}									\
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan_##offset, NULL);				\
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO,				\
+		show_fan_##offset##_div, NULL);				\
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_##offset##_min, set_fan_##offset##_min);
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* alarms */
+static ssize_t show_alarms(struct device *dev, char *buf)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%u\n", data->alarms[0] |
+			(data->alarms[1] << 8));
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+/* vid */
+static ssize_t show_vid(struct device *dev, char *buf)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+/* analog output */
+static ssize_t show_aout(struct device *dev, char *buf)
+{
+	struct adm9240_data *data = adm9240_update_device(dev);
+	return sprintf(buf, "%d\n", USCALE(data->analog_out, 1250, 255));
+}
+
+static ssize_t set_aout(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10); /* keep signed */
+
+	down(&data->update_lock);
+	data->analog_out = AOUT_TO_REG(val);
+	adm9240_write_value(client, ADM9240_REG_ANALOG_OUT, data->analog_out);
+	up(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_aout, set_aout);
+
+/* Chassis Intrusion latch clear */
+static ssize_t set_ci_clear(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = simple_strtol(buf, NULL, 10);
+
+	if (val = 1)
+		adm9240_write_value(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
+	return count;
+}
+static DEVICE_ATTR(ci_clear, S_IWUSR, NULL, set_ci_clear);
+
+/* sensor chip detection */
+static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct adm9240_data *data;
+	int err = 0;
+	const char *name = "";
+	u8 man_id, die_rev, config;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(data = kmalloc(sizeof(struct adm9240_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct adm9240_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &adm9240_driver;
+	new_client->flags = 0;
+
+	if (kind = 0) {
+		kind = adm9240;
+	}
+
+	if (kind < 0) {
+
+		/* verify chip: reg address should match i2c address */
+		if (adm9240_read_value(new_client, ADM9240_REG_I2C_ADDR)
+				!= address) {
+			dev_dbg(&adapter->dev, "detect fail: address match, "
+					"0x%02x\n", address);
+			goto exit_free;
+		}
+
+		/* check known chip manufacturer */
+		man_id = adm9240_read_value(new_client, ADM9240_REG_MAN_ID);
+
+		if (man_id = 0x23) {
+			kind = adm9240;
+		} else if (man_id = 0xda) {
+			kind = ds1780;
+		} else if (man_id = 0x01) {
+			kind = lm81;
+		} else {
+			dev_dbg(&adapter->dev, "detect fail: unknown manuf, "
+					"0x%02x\n", man_id);
+			goto exit_free;
+		}
+
+		/* successful detect, print chip info */
+		die_rev = adm9240_read_value(new_client, ADM9240_REG_DIE_REV);
+		config = adm9240_read_value(new_client, ADM9240_REG_CONFIG);
+		dev_info(&adapter->dev, "adm9240 found %s, revision 0x%02X,"
+				"config 0x%02X\n", man_id = 0x23 ? "ADM9240" :
+				man_id = 0xda ? "DS1780" : "LM81", die_rev,
+				config);
+	}
+
+	/* either forced or detected chip kind */
+	if (kind = adm9240) {
+		name = "adm9240";
+	} else if (kind = ds1780) {
+		name = "ds1780";
+	} else if (kind = lm81) {
+		name = "lm81";
+	}
+
+	/* fill in the remaining client fields and attach */
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	data->type = kind;
+	init_MUTEX(&data->update_lock);
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	adm9240_init_client(new_client);
+
+	/* populate sysfs filesystem */
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in0_min);
+	device_create_file(&new_client->dev, &dev_attr_in0_max);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_min);
+	device_create_file(&new_client->dev, &dev_attr_in1_max);
+	device_create_file(&new_client->dev, &dev_attr_in2_input);
+	device_create_file(&new_client->dev, &dev_attr_in2_min);
+	device_create_file(&new_client->dev, &dev_attr_in2_max);
+	device_create_file(&new_client->dev, &dev_attr_in3_input);
+	device_create_file(&new_client->dev, &dev_attr_in3_min);
+	device_create_file(&new_client->dev, &dev_attr_in3_max);
+	device_create_file(&new_client->dev, &dev_attr_in4_input);
+	device_create_file(&new_client->dev, &dev_attr_in4_min);
+	device_create_file(&new_client->dev, &dev_attr_in4_max);
+	device_create_file(&new_client->dev, &dev_attr_in5_input);
+	device_create_file(&new_client->dev, &dev_attr_in5_min);
+	device_create_file(&new_client->dev, &dev_attr_in5_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max);
+	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_input);
+	device_create_file(&new_client->dev, &dev_attr_fan1_div);
+	device_create_file(&new_client->dev, &dev_attr_fan1_min);
+	device_create_file(&new_client->dev, &dev_attr_fan2_input);
+	device_create_file(&new_client->dev, &dev_attr_fan2_div);
+	device_create_file(&new_client->dev, &dev_attr_fan2_min);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_analog_out);
+	device_create_file(&new_client->dev, &dev_attr_ci_clear);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+
+	return 0;
+
+exit_free:
+	kfree(new_client);
+exit:
+	return err;
+}
+
+static int adm9240_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_detect(adapter, &addr_data, adm9240_detect);
+}
+
+static int adm9240_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+				"client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+/*
+ * if we find chip is running, report config and mode, otherwise we open 
+ * out the limits to prevent alarms and set to 'default' interrupt mode 
+ * which seems the only method to get a temperature alarm status
+ */
+static void adm9240_init_client(struct i2c_client *client)
+{
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	u8 conf = adm9240_read_value(client, ADM9240_REG_CONFIG);
+	u8 mode = adm9240_read_value(client, ADM9240_REG_TEMP_CONF) & 3;
+
+	data->vrm = i2c_which_vrm(); /* need this to report vid as mV */
+
+	if (conf & 1) {
+		dev_dbg(&client->dev, "%s running: conf 0x%02x mode %u\n",
+				client->name, conf, mode);
+	} else {
+		int i;
+
+		for (i = 1; i < 6; i++) {
+			adm9240_write_value(client,
+					ADM9240_REG_IN_MIN(i), 0);
+			adm9240_write_value(client,
+					ADM9240_REG_IN_MAX(i), 255);
+		}
+
+		adm9240_write_value(client, ADM9240_REG_FAN_MIN(0), 255);
+		adm9240_write_value(client, ADM9240_REG_FAN_MIN(1), 255);
+		adm9240_write_value(client, ADM9240_REG_TEMP_HIGH, 127);
+		adm9240_write_value(client, ADM9240_REG_TEMP_HYST, 127);
+		adm9240_write_value(client, ADM9240_REG_TEMP_CONF, 0);
+		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);
+
+		dev_dbg(&client->dev, "%s start: old conf 0x%02x mode 0\n",
+				client->name, conf);
+	}
+}
+
+static struct adm9240_data *adm9240_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm9240_data *data = i2c_get_clientdata(client);
+	u8 i;
+
+	down(&data->update_lock);
+
+	/* min measurement cycle: 1.8 seconds for 'sleep 2' reading loop */
+	if (!data->valid || time_after(jiffies, data->last_updated_reading +
+				(HZ * 9 / 5))) {
+
+		for (i = 0; i < 6; i++) /* read voltages */
+		{
+			data->in[i] = adm9240_read_value(client,
+					ADM9240_REG_IN(i));
+		}
+
+		for (i = 0; i < 2; i++) /* read fans and alarms */
+		{
+			data->fan[i] = adm9240_read_value(client,
+					ADM9240_REG_FAN(i));
+
+			/* adjust fan clock divider when:
+			 * - measurement overflows, and
+			 * - auto fan_div enabled, and
+			 * - fan_div < max value
+			 * also adjust fan_min to suit new fan_div,
+			 * but do not let fan_min go to zero */
+			if (data->fan[i] = 255 && data->fan_min[i] < 255
+					&& data->fan_div[i] < 3) {
+
+				data->fan_div[i]++;
+				adm9240_write_fan_div(client, i,
+						data->fan_div[i]);
+
+				if (data->fan_min[i] > 1) {
+					data->fan_min[i]++;
+					data->fan_min[i] >>= 1;
+				}
+			}
+			data->alarms[i] = adm9240_read_value(client,
+					ADM9240_REG_INT(i));
+		}
+
+		/* Read temperature, assume temperature changes less than 
+		 * 0.5'C per two measurement cycles thus ignore possible 
+		 * aliasing error on lsb reading. */
+		data->temp = ((adm9240_read_value(client,
+					ADM9240_REG_TEMP) << 8) |
+					adm9240_read_value(client,
+					ADM9240_REG_TEMP_CONF)) / 128;
+		data->last_updated_reading = jiffies;
+	}
+
+	/* longer lockout between reading control settings */
+	if (!data->valid || time_after(jiffies,
+				data->last_updated_config + (HZ * 300))) {
+
+		for (i = 0; i < 6; i++)
+		{
+			data->in_min[i] = adm9240_read_value(client,
+					ADM9240_REG_IN_MIN(i));
+			data->in_max[i] = adm9240_read_value(client,
+					ADM9240_REG_IN_MAX(i));
+		}
+		for (i = 0; i < 2; i++)
+		{
+			data->fan_min[i] = adm9240_read_value(client,
+					ADM9240_REG_FAN_MIN(i));
+			data->intr_mask[i] = adm9240_read_value(client,
+					ADM9240_REG_INT_MASK(i));
+		}
+		data->temp_high = adm9240_read_value(client,
+				ADM9240_REG_TEMP_HIGH);
+		data->temp_hyst = adm9240_read_value(client,
+				ADM9240_REG_TEMP_HYST);
+
+		/* read fan divs and 5-bit VID */
+		i = adm9240_read_value(client,ADM9240_REG_VID_FAN_DIV);
+		data->fan_div[0] = (i >> 4) & 3;
+		data->fan_div[1] = (i >> 6) & 3;
+		data->vid = i & 0x0f;
+		data->vid |= (adm9240_read_value(client,
+					ADM9240_REG_VID4) & 1) << 4;
+		/* read analog out */
+		data->analog_out = adm9240_read_value(client,
+				ADM9240_REG_ANALOG_OUT);
+		data->last_updated_config = jiffies;
+		data->valid = 1;
+	}
+	up(&data->update_lock);
+	return data;
+}
+
+static int __init sensors_adm9240_init(void)
+{
+	return i2c_add_driver(&adm9240_driver);
+}
+
+static void __exit sensors_adm9240_exit(void)
+{
+	i2c_del_driver(&adm9240_driver);
+}
+
+MODULE_AUTHOR("Michiel Rook <michiel@grendelproject.nl>, "
+		"Grant Coady <gcoady@gmail.com> and others");
+MODULE_DESCRIPTION("ADM9240/DS1780/LM81 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_adm9240_init);
+module_exit(sensors_adm9240_exit);
+
