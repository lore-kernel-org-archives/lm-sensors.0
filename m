From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 18 Apr 2013 22:28:21 +0000
Subject: [lm-sensors] [PATCH 1/3] Add support for GMT G72/G763 PWM fan controller
Message-Id: <4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
In-Reply-To: <cover.1366322287.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
Tested-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/hwmon/Kconfig  |   10 +
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/g762.c   | 1159 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1170 insertions(+)
 create mode 100644 drivers/hwmon/g762.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 89ac1cb..0c6ddee 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -423,6 +423,16 @@ config SENSORS_G760A
 	  This driver can also be built as a module.  If so, the module
 	  will be called g760a.
 
+config SENSORS_G762
+	tristate "GMT G762"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G762 fan speed PWM controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g762a.
+
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8d6d97e..4b49504 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
 obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
+obj-$(CONFIG_SENSORS_G762)	+= g762.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
new file mode 100644
index 0000000..8c4cb39
--- /dev/null
+++ b/drivers/hwmon/g762.c
@@ -0,0 +1,1159 @@
+/*
+ * g762 - Driver for the Global Mixed-mode Technology Inc. fan speed PWM
+ *        controller chips from G762 family, i.e. G762 and G763
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This work is based on a basic version for 2.6.31 kernel developed
+ * by Olivier Mouchet for LaCie NAS. Updates have been performed to run
+ * on recent kernels. Supported has been completed and additional
+ * features added: ability to configure various characteristics from
+ * .dts file, better initialization, alarms and error reporting support,
+ * gear mode, polarity, fan pulse per revolution, fan startup voltage
+ * control. The following detailed datasheet has been used as a basis
+ * for this work:
+ *
+ *  http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf
+ *
+ * Headers from previous developments have been kept below:
+ *
+ * Copyright (c) 2009 LaCie
+ *
+ * Author: Olivier Mouchet <olivier.mouchet@gmail.com>
+ *
+ * based on g760a code written by Herbert Valerio Riedel <hvr@gnu.org>
+ * Copyright (C) 2007  Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * g762: minimal datasheet available at:
+ *       http://www.gmt.com.tw/product/datasheet/EDS-762_3.pdf
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#define DRVNAME "g762"
+
+static const struct i2c_device_id g762_id[] = {
+	{ DRVNAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, g762_id);
+
+enum g762_regs {
+	G762_REG_SET_CNT  = 0x00,
+	G762_REG_ACT_CNT  = 0x01,
+	G762_REG_FAN_STA  = 0x02,
+	G762_REG_SET_OUT  = 0x03,
+	G762_REG_FAN_CMD1 = 0x04,
+	G762_REG_FAN_CMD2 = 0x05,
+};
+
+/* Config register bits */
+#define G762_REG_FAN_CMD1_DET_FAN_FAIL 	0x80 /* enable fan_fail signal */
+#define G762_REG_FAN_CMD1_DET_FAN_OOC 	0x40 /* enable fan_out_of_control */
+#define G762_REG_FAN_CMD1_OUT_MODE 	0x20 /* out mode, pwm or dac */
+#define G762_REG_FAN_CMD1_FAN_MODE 	0x10 /* fan mode: close or open loop */
+#define G762_REG_FAN_CMD1_CLK_DIV_ID1   0x08 /* clock divisor value */
+#define G762_REG_FAN_CMD1_CLK_DIV_ID0 	0x04
+#define G762_REG_FAN_CMD1_PWM_POLARITY	0x02 /* pwm polarity */
+#define G762_REG_FAN_CMD1_PULSE_PER_REV	0x01 /* pulse per fan revolution */
+
+#define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
+#define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
+#define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
+#define G762_REG_FAN_CMD2_FAN_STARTV_0  0x01
+
+#define G762_REG_FAN_STA_FAIL           0x02 /* fan fail */
+#define G762_REG_FAN_STA_OOC            0x01 /* fan out of control */
+
+/* config register values */
+#define OUT_MODE_PWM 		1
+#define OUT_MODE_DAC 		0
+
+#define FAN_MODE_CLOSED_LOOP 	1
+#define FAN_MODE_OPEN_LOOP 	0
+
+/* g762 default values: it is assumed that the fan is set for a 32KHz clock
+ * source, a fan clock divisor of 1 and two pulses per revolution. Default
+ * fan driving mode is linear mode (g762 also supports PWM mode) */
+#define G762_DEFAULT_CLK 	    32768
+#define G762_DEFAULT_FAN_CLK_DIV    1
+#define G762_DEFAULT_PULSE_PER_REV  2
+#define G762_DEFAULT_OUT_MODE       0
+#define G762_DEFAULT_FAN_MODE       1
+
+/* register data is read (and cached) at most once per second */
+#define G762_UPDATE_INTERVAL (HZ)
+
+/* extract pulse count per fan revolution value (2 or 4) from given
+ * FAN_CMD1 register value */
+#define PULSE_FROM_REG(reg) \
+	(((reg & G762_REG_FAN_CMD1_PULSE_PER_REV)+1) << 1)
+
+/* extract fan clock divisor (1, 2, 4 or 8) from given FAN_CMD1
+ * register value */
+#define CLKDIV_FROM_REG(reg) \
+	(1 << ((reg & (G762_REG_FAN_CMD1_CLK_DIV_ID0 | \
+		       G762_REG_FAN_CMD1_CLK_DIV_ID1)) >> 2))
+
+/* extract fan gear mode value (0, 1 or 2) from given FAN_CMD2
+ * register value */
+#define GEARMODE_FROM_REG(reg) \
+	(1 << ((reg & (G762_REG_FAN_CMD2_GEAR_MODE_0 | \
+		       G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
+
+struct g762_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+
+	/* update mutex */
+	struct mutex update_lock;
+
+	/* board specific parameters. */
+	u32 clk; /* default 32kHz */
+
+	/* g762 register cache */
+	unsigned int valid:1;
+	unsigned long last_updated; /* in jiffies */
+
+	u8 set_cnt;  /* RPM cmd in close loop control */
+	u8 act_cnt;  /* formula: cnt = (CLK * 30)/(rpm * P) */
+	u8 fan_sta;  /* bit 0: set when actual fan speed is more than
+		      *        25% outside requested fan speed
+		      * bit 1: set when no transition occurs on fan
+                      *        pin for 0.7s */
+	u8 set_out;  /* output voltage/PWM duty in open loop control */
+	u8 fan_cmd1; /*   0: FG_PLS_ID0 FG pulses count per revolution
+		      *      0: 2 counts per revolution
+		      *      1: 4 counts per revolution
+		      *   1: PWM_POLARITY 1: negative_duty
+		      *                   0: positive_duty
+		      * 2,3: [FG_CLOCK_ID0, FG_CLK_ID1]
+		      * 	00: Divide fan clock by 1
+		      * 	01: Divide fan clock by 2
+		      * 	10: Divide fan clock by 4
+		      * 	11: Divide fan clock by 8
+		      *   4: FAN_MODE 1:close-loop, 0:open-loop
+		      *   5: OUT_MODE 1:PWM, 0:DAC
+		      *   6: DET_FAN_OOC enable "fan ooc" status
+		      *   7: DET_FAN_FAIL enable "fan fail" status */
+	u8 fan_cmd2; /* 0,1: FAN_STARTV 0,1,2,3 -> 0,32,64,96 dac_code
+		      * 2,3: FG_GEAR_MODE
+		      *         00: div = 1
+		      *         01: div = 2
+		      *         10: div = 4
+		      *   4: Mask ALERT# (g763 only) */
+};
+
+/* sysfs PWM interface uses value from 0 to 255 when g762 FAN_SET_CNT register
+ * uses values from 255 (off) to 0 (full speed). */
+#define PWM_FROM_CNT(cnt)	(0xff-(cnt))
+#define PWM_TO_CNT(pwm)		(0xff-(pwm))
+
+/* Convert count value from fan controller register into fan speed RPM value.
+ * Note that the datasheet documents a basic formula. Influence of additional
+ * parameters have been infered from examples in the datasheet and tests:
+ * fan clock divisor, fan gear mode. */
+static inline unsigned int rpm_from_cnt(u8 cnt,	u32 clk, u16 p,
+					u8 clk_div, u8 gear_mode)
+{
+	if (cnt = 0 || cnt = 0xff)
+		return 0;
+
+	return (clk*30*(gear_mode+1))/(cnt*p*clk_div);
+}
+
+/* Convert fan RPM value from sysfs into count value */
+static inline unsigned char cnt_from_rpm(u32 rpm, u32 clk, u16 p,
+					 u8 clk_div, u8 gear_mode)
+{
+	return (rpm = 0) ? 0xff : (clk*30*(gear_mode+1))/(rpm*p*clk_div);
+}
+
+#ifdef CONFIG_OF
+static struct of_device_id g762_dt_match[] = {
+	{ .compatible = "gmt,g762" },
+	{ .compatible = "gmt,g763" },
+	{ },
+};
+#endif
+
+static int g762_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id);
+static int g762_remove(struct i2c_client *client);
+
+static struct i2c_driver g762_driver = {
+	.driver = {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(g762_dt_match),
+	},
+	.probe	  = g762_probe,
+	.remove	  = g762_remove,
+	.id_table = g762_id,
+};
+
+static inline int g762_read_value(struct i2c_client *client,
+				  enum g762_regs reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static inline int g762_write_value(struct i2c_client *client,
+				   enum g762_regs reg, u16 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/*
+ * sysfs attributes
+ */
+
+/* helper to grab and cache data, at most one time per second */
+static struct g762_data *g762_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + G762_UPDATE_INTERVAL) ||
+	    unlikely(!data->valid)) {
+		data->set_cnt =  g762_read_value(client, G762_REG_SET_CNT);
+		data->act_cnt =  g762_read_value(client, G762_REG_ACT_CNT);
+		data->fan_sta =  g762_read_value(client, G762_REG_FAN_STA);
+		data->set_out =  g762_read_value(client, G762_REG_SET_OUT);
+		data->fan_cmd1 = g762_read_value(client, G762_REG_FAN_CMD1);
+		data->fan_cmd2 = g762_read_value(client, G762_REG_FAN_CMD2);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+/* Read function for fan1_input sysfs file. Return current fan RPM value, or
+ * 0 if fan is out of control */
+static ssize_t get_fan_rpm(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int rpm = 0;
+
+	mutex_lock(&data->update_lock);
+	/* reverse logic: fan out of control reporting is enabled low */
+	if (data->fan_sta & G762_REG_FAN_STA_OOC) {
+		rpm = rpm_from_cnt(data->act_cnt, data->clk,
+				   PULSE_FROM_REG(data->fan_cmd1),
+				   CLKDIV_FROM_REG(data->fan_cmd1),
+				   GEARMODE_FROM_REG(data->fan_cmd2));
+	}
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%u\n", rpm);
+}
+
+/* Read function for pwm1_mode sysfs file. Get fan speed control
+ * mode i.e. pwm (1) or linear (0) */
+static ssize_t get_pwm_mode(struct device *dev, struct device_attribute *da,
+			    char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	int pwm_mode;
+
+	pwm_mode = (data->fan_cmd1 & G762_REG_FAN_CMD1_OUT_MODE) ? 1 : 0;
+
+	return sprintf(buf, "%d\n", pwm_mode);
+}
+
+static ssize_t do_set_pwm_mode(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case OUT_MODE_PWM:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_OUT_MODE;
+		break;
+	case OUT_MODE_DAC: /* i.e. linear */
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_OUT_MODE;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+/* Write function for pwm1_mode sysfs file. Set fan speed control
+ * mode as pwm (1) or linear (0) */
+static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_pwm_mode(dev, (u8)val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Read function for pwm1_freq sysfs file. */
+static ssize_t get_pwm_freq(struct device *dev,
+			    struct device_attribute *da, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = i2c_get_clientdata(client);
+
+	return sprintf(buf, "%d\n", data->clk);
+}
+
+/* Write function for pwm1_freq sysfs file. */
+static ssize_t set_pwm_freq(struct device *dev,
+			    struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val) || !val)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->clk = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/* Read function for fan1_div sysfs file. Get fan controller prescaler */
+static ssize_t get_fan_clk_div(struct device *dev,
+			       struct device_attribute *da, char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	return sprintf(buf, "%d\n", CLKDIV_FROM_REG(data->fan_cmd1));
+}
+
+static ssize_t do_set_fan_clk_div(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 1:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 2:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 4:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 8:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, (u16)data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+/* Write function for fan1_div file. Set fan controller prescaler */
+static ssize_t set_fan_clk_div(struct device *dev,
+			       struct device_attribute *da,
+			       const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_fan_clk_div(dev, (u8) val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Read function for fan1_gear_mode sysfs file. Get fan gear mode */
+static ssize_t get_fan_gear_mode(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	u8 fan_gear_mode;
+
+	fan_gear_mode = data->fan_cmd2 & (G762_REG_FAN_CMD2_GEAR_MODE_0 |
+					  G762_REG_FAN_CMD2_GEAR_MODE_1);
+	fan_gear_mode = fan_gear_mode >> 2;
+
+	return sprintf(buf, "%d\n", fan_gear_mode);
+}
+
+static ssize_t do_set_fan_gear_mode(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0:
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	case 1:
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	case 2:
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD2, (u16)data->fan_cmd2);
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+/* Write function for fan1_gear_mode sysfs file. Write fan gear mode */
+static ssize_t set_fan_gear_mode(struct device *dev,
+				 struct device_attribute *da,
+				 const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_fan_gear_mode(dev, (u8) val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Read function for fan1_pulses. Returns either 2 or 4 */
+static ssize_t get_fan_pulses(struct device *dev, struct device_attribute *da,
+			      char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	return sprintf(buf, "%d\n", PULSE_FROM_REG(data->fan_cmd1));
+}
+
+/* Set pulse per revolution value. Accepts either 2 or 4. */
+static ssize_t do_set_fan_pulses(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 2:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_PULSE_PER_REV;
+		break;
+	case 4:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_PULSE_PER_REV;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, (u16)data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+/* Write function for fan1_pulses. Accepts either 2 or 4 */
+static ssize_t set_fan_pulses(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val) || (val != 2 && val != 4))
+		return -EINVAL;
+
+	ret = do_set_fan_pulses(dev, (u8) val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Following documentation about hwmon's sysfs interface, a pwm1_enable node
+ * should accept followings:
+ *
+ *  0 : no fan speed control (i.e. fan at full speed)
+ *  1 : manual fan speed control enabled (use pwm[1-*]) (open-loop)
+ *  2+: automatic fan speed control enabled (use fan[1-*]_enable)(close-loop)
+ *
+ * but we do not accept 0 as "no-control" mode is not supported by g762,
+ * -EINVAL is returned in this case. */
+static ssize_t get_speed_control_mode(struct device *dev,
+				      struct device_attribute *da, char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	int fan_mode;
+
+	fan_mode = (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) ? 2 : 1;
+
+	return sprintf(buf, "%d\n", fan_mode);
+}
+
+static ssize_t do_set_speed_control_mode(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	if (!val)
+		return -EINVAL;
+	val -= 1;
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case FAN_MODE_CLOSED_LOOP:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_FAN_MODE;
+		break;
+	case FAN_MODE_OPEN_LOOP:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_FAN_MODE;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+
+	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+static ssize_t set_speed_control_mode(struct device *dev,
+				      struct device_attribute *da,
+				      const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_speed_control_mode(dev, val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Read function for pwm1_polarity (0: negative duty, 1: positive duty) */
+static ssize_t get_pwm_polarity(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	u8 pwm_polarity;
+
+	pwm_polarity = (data->fan_cmd1 & G762_REG_FAN_CMD1_PWM_POLARITY) >> 1;
+
+	return sprintf(buf, "%d\n", pwm_polarity);
+}
+
+/* Write function for pwm1_polarity (0: negative duty, 1: positive duty) */
+static ssize_t set_pwm_polarity(struct device *dev, struct device_attribute *da,
+		       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0: /* i.e. negative duty */
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_PWM_POLARITY;
+		break;
+	case 1: /* i.e. positive duty */
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_PWM_POLARITY;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/* Get/set the fan speed in open-loop mode using pwm1 sysfs file. Speed is
+ * given as a relative value from 0 to 255, where 255 is maximum speed. Note
+ * that this is done by writing directly to the chip's DAC, it won't change
+ * the closed loop speed set by fan1_target. Also note that due to rounding
+ * errors it is possible that you don't read back exactly the value you have
+ * set. */
+static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	int val;
+
+	mutex_lock(&data->update_lock);
+	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
+		val = PWM_FROM_CNT(data->set_cnt);
+	} else {                                            /* open-loop */
+		val = data->set_out;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t do_set_pwm(struct device *dev, u8 val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
+		val = PWM_TO_CNT(clamp_val(val, 0, 255));
+		data->set_cnt = val;
+		g762_write_value(client, G762_REG_SET_CNT, val);
+	} else {                                           /* open-loop */
+		data->set_out = val;
+		g762_write_value(client, G762_REG_SET_OUT, val);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return val;
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
+		       const char *buf, size_t count)
+{
+	unsigned long val;
+	ssize_t ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_pwm(dev, (u8)val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* Get/set the fan speed in closed-loop mode using fan1_target sysfs file. Speed
+ * is given as a rpm value, then G762 will automatically regulate the fan speed
+ * using pulses from fan tachometer.
+ *
+ * Refer to rpm_from_cnt implementation to get info about count number
+ * calculation.
+ *
+ * Also note that due to rounding errors it is possible that you don't read
+ * back exactly the value you have set. */
+static ssize_t get_fan_target(struct device *dev, struct device_attribute *da,
+			      char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int rpm;
+	ssize_t err;
+
+	mutex_lock(&data->update_lock);
+	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
+		rpm = rpm_from_cnt(data->set_cnt, data->clk,
+				   PULSE_FROM_REG(data->fan_cmd1),
+				   CLKDIV_FROM_REG(data->fan_cmd1),
+				   GEARMODE_FROM_REG(data->fan_cmd2));
+		err = sprintf(buf, "%u\n", rpm);
+	} else {                                           /* open-loop */
+		err = -EINVAL;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return err;
+}
+
+static ssize_t do_set_fan_target(struct device *dev, unsigned int val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	ssize_t err;
+
+	mutex_lock(&data->update_lock);
+	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
+		data->set_cnt = cnt_from_rpm(val, data->clk,
+					     PULSE_FROM_REG(data->fan_cmd1),
+					     CLKDIV_FROM_REG(data->fan_cmd1),
+					     GEARMODE_FROM_REG(data->fan_cmd2));
+		g762_write_value(client, G762_REG_SET_CNT, data->set_cnt);
+		err = val;
+	} else {
+		err = -EINVAL;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return err;
+}
+
+static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	unsigned int val;
+	ssize_t ret;
+
+	if (sscanf(buf, "%u", &val) != 1)
+		return -EINVAL;
+
+	ret = do_set_fan_target(dev, val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* read function for 'fan1_fault_detection' sysfs file */
+static ssize_t get_fan_failure_detection(struct device *dev,
+					 struct device_attribute *da,
+					 char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int enabled;
+
+	enabled = (data->fan_cmd1 & G762_REG_FAN_CMD1_DET_FAN_FAIL) ? 1 : 0;
+
+	return sprintf(buf, "%u\n", enabled);
+}
+
+/* enable (or disable) fan failure detection */
+static ssize_t do_fan_failure_detection_toggle(struct device *dev,
+					    unsigned int enable)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (enable) {
+	case 0:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_DET_FAN_FAIL;
+		break;
+	case 1:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_FAIL;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return enable;
+}
+
+/* write function for 'fan1_fault_detection' sysfs file */
+static ssize_t set_fan_failure_detection(struct device *dev,
+					 struct device_attribute *da,
+					 const char *buf, size_t count)
+{
+	unsigned int val;
+	ssize_t ret;
+
+	if (sscanf(buf, "%u", &val) != 1)
+		return -EINVAL;
+
+	ret = do_fan_failure_detection_toggle(dev, val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* read function for fan1_fault sysfs file. */
+static ssize_t get_fan_failure(struct device *dev, struct device_attribute *da,
+			       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int val;
+
+	val = (data->fan_sta & G762_REG_FAN_STA_FAIL) ? 1 : 0;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+/* read function for 'fan1_alarm_detection' sysfs file */
+static ssize_t get_fan_ooc_detection(struct device *dev,
+				     struct device_attribute *da,
+				     char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int enabled;
+
+	enabled = (data->fan_cmd1 & G762_REG_FAN_CMD1_DET_FAN_FAIL) ? 1 : 0;
+
+	return sprintf(buf, "%u\n", enabled);
+}
+
+/* enable (or disable) fan out of control detection */
+static ssize_t do_fan_ooc_detection_toggle(struct device *dev,
+					   unsigned int enable)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+
+	mutex_lock(&data->update_lock);
+	switch (enable) {
+	case 0:
+		data->fan_cmd1 &= (u8) ~G762_REG_FAN_CMD1_DET_FAN_OOC;
+		break;
+	case 1:
+		data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
+	mutex_unlock(&data->update_lock);
+
+	return enable;
+}
+
+/* write function for 'fan1_alarm_detection' sysfs file */
+static ssize_t set_fan_ooc_detection(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
+{
+	unsigned int val;
+	ssize_t ret;
+
+	if (sscanf(buf, "%u", &val) != 1)
+		return -EINVAL;
+
+	ret = do_fan_ooc_detection_toggle(dev, val);
+	if (ret < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+/* read function for fan1_alarm sysfs file. */
+static ssize_t get_fan_ooc(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int val;
+
+	/* ooc condition is enabled low */
+	val = (data->fan_sta & G762_REG_FAN_STA_OOC) ? 0 : 1;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+/* Read function for fan1_startup_voltage */
+static ssize_t get_fan_startup_voltage(struct device *dev,
+				       struct device_attribute *da,
+				       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	u8 val;
+
+	val = data->fan_cmd2 & (G762_REG_FAN_CMD2_FAN_STARTV_1 |
+				G762_REG_FAN_CMD2_FAN_STARTV_0);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+/* Write function for fan1_startup_voltage */
+static ssize_t set_fan_startup_voltage(struct device *dev,
+				       struct device_attribute *da,
+				       const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0:
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_FAN_STARTV_1;
+		break;
+	case 1:
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_FAN_STARTV_1;
+		break;
+	case 2:
+		data->fan_cmd2 &= (u8) ~G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_FAN_STARTV_1;
+		break;
+	case 3:
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 |= G762_REG_FAN_CMD2_FAN_STARTV_1;
+		break;
+	default:
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
+	}
+	g762_write_value(client, G762_REG_FAN_CMD2, (u16)data->fan_cmd2);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR(pwm1_polarity, S_IWUSR | S_IRUGO,
+		   get_pwm_polarity, set_pwm_polarity);
+static DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
+		   get_pwm_mode, set_pwm_mode);
+static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+		   get_speed_control_mode, set_speed_control_mode);
+static DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO,
+		   get_pwm_freq, set_pwm_freq);
+
+static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
+static DEVICE_ATTR(fan1_alarm, S_IRUGO, get_fan_ooc, NULL);
+static DEVICE_ATTR(fan1_alarm_detection, S_IWUSR | S_IRUGO,
+		   get_fan_ooc_detection, set_fan_ooc_detection);
+static DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan_failure, NULL);
+static DEVICE_ATTR(fan1_fault_detection, S_IWUSR | S_IRUGO,
+		   get_fan_failure_detection, set_fan_failure_detection);
+static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
+		   get_fan_target, set_fan_target);
+static DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO,
+		   get_fan_pulses, set_fan_pulses);
+static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
+		   get_fan_clk_div, set_fan_clk_div);
+static DEVICE_ATTR(fan1_gear_mode, S_IWUSR | S_IRUGO,
+		   get_fan_gear_mode, set_fan_gear_mode);
+static DEVICE_ATTR(fan1_startup_voltage, S_IWUSR | S_IRUGO,
+		   get_fan_startup_voltage, set_fan_startup_voltage);
+
+/* Driver data */
+static struct attribute *g762_attributes[] = {
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_alarm.attr,
+	&dev_attr_fan1_alarm_detection.attr,
+	&dev_attr_fan1_fault.attr,
+	&dev_attr_fan1_fault_detection.attr,
+	&dev_attr_fan1_target.attr,
+	&dev_attr_fan1_pulses.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_fan1_gear_mode.attr,
+	&dev_attr_fan1_startup_voltage.attr,
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_polarity.attr,
+	&dev_attr_pwm1_mode.attr,
+	&dev_attr_pwm1_enable.attr,
+	&dev_attr_pwm1_freq.attr,
+	NULL
+};
+
+static const struct attribute_group g762_group = {
+	.attrs = g762_attributes,
+};
+
+static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	u32 pwm_freq, fan_clk_div, fan_pulses, pwm_mode, fan_target, pwm_enable;
+	struct g762_data *data;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct g762_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	i2c_set_clientdata(client, data);
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	/* Setup default configuration for now. Those may get modified below
+	 * in CONFIG_OF-protected block (via .dts file). Final values will
+	 * then be pushed to the device */
+	pwm_freq = G762_DEFAULT_CLK;
+	fan_clk_div = G762_DEFAULT_FAN_CLK_DIV;
+	fan_pulses = G762_DEFAULT_PULSE_PER_REV;
+	pwm_mode = G762_DEFAULT_OUT_MODE;
+	pwm_enable = G762_DEFAULT_FAN_MODE + 1; /* shift w/ sysfs interface */
+	fan_target = 0xffffffff; /* dummy value */
+
+	/* Enable fan protection and fan fail detection by default */
+	do_fan_ooc_detection_toggle(&client->dev, 1);
+	do_fan_failure_detection_toggle(&client->dev, 1);
+
+#ifdef CONFIG_OF
+	if (client->dev.of_node) {
+		const __be32 *prop;
+		int len;
+
+		prop = of_get_property(client->dev.of_node, "pwm_freq", &len);
+		if (prop && len = sizeof(u32)) {
+			pwm_freq = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found pwm_freq (%d)\n", pwm_freq);
+		}
+
+		prop = of_get_property(client->dev.of_node, "fan_div", &len);
+		if (prop && len = sizeof(u32)) {
+			fan_clk_div = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found fan_div (%d)\n",
+				 fan_clk_div);
+		}
+
+		prop = of_get_property(client->dev.of_node, "fan_pulses", &len);
+		if (prop && len = sizeof(u32)) {
+			fan_pulses = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found fan_pulses (%d)\n",
+				 fan_pulses);
+		}
+
+		prop = of_get_property(client->dev.of_node, "pwm_mode", &len);
+		if (prop && len = sizeof(u32)) {
+			pwm_mode = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found pwm_mode (%d)\n",
+				 pwm_mode);
+		}
+
+		prop = of_get_property(client->dev.of_node, "fan_target", &len);
+		if (prop && len = sizeof(u32)) {
+			fan_target = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found fan_target (%d)\n",
+				 fan_target);
+		}
+
+		prop = of_get_property(client->dev.of_node, "pwm_enable", &len);
+		if (prop && len = sizeof(u32)) {
+			pwm_enable = be32_to_cpu(prop[0]);
+			dev_info(&client->dev, "found pwm_enable (%d)\n",
+				 pwm_enable);
+		}
+	}
+#endif
+
+	/* Now, let's set final fan out mode (pwm or linear), loop mode (closed
+	 * or open loop), clock freq, pulse per rev, fan clock div, fan target
+	 * value, and speed control method (closed or open loop) */
+	err = do_set_pwm_mode(&client->dev, pwm_mode);
+	if (err < 0) {
+		dev_info(&client->dev, "unable to set pwm_mode (%d)\n",
+			 pwm_mode);
+	}
+
+	err = do_set_speed_control_mode(&client->dev, pwm_enable);
+	if (err < 0) {
+		dev_info(&client->dev, "unable to set pwm_enable (%d)\n",
+			 pwm_enable);
+	}
+
+	err = do_set_fan_clk_div(&client->dev, fan_clk_div);
+	if (err < 0) {
+		dev_info(&client->dev, "unable to set fan_clk_div (%d)\n",
+			 fan_clk_div);
+	}
+
+	err = do_set_fan_pulses(&client->dev, fan_pulses);
+	if (err < 0) {
+		dev_info(&client->dev, "unable to set fan_pulses (%d)\n",
+			 fan_pulses);
+	}
+
+	data->clk = pwm_freq;
+
+	if (fan_target != 0xffffffff) {
+		err = do_set_fan_target(&client->dev, fan_target);
+		if (err < 0) {
+			dev_info(&client->dev, "unable to set fan_target (%d)\n",
+				 fan_target);
+		}
+	}
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &g762_group);
+	if (err)
+		return err;
+	data->hwmon_dev = (struct device *)hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		sysfs_remove_group(&client->dev.kobj, &g762_group);
+		return err;
+	}
+
+	dev_info(&data->client->dev, "device successfully initialized\n");
+
+	return 0;
+}
+
+static int g762_remove(struct i2c_client *client)
+{
+	struct g762_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &g762_group);
+
+	dev_info(&data->client->dev, "device successfully removed\n");
+	return 0;
+}
+
+module_i2c_driver(g762_driver);
+
+MODULE_AUTHOR("Olivier Mouchet <olivier.mouchet@gmail.com>");
+MODULE_DESCRIPTION("GMT G762 driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
