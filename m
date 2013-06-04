From: Arnaud Ebalard <arno@natisbad.org>
Date: Tue, 04 Jun 2013 07:14:29 +0000
Subject: [lm-sensors] [PATCHv4 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <4143a04cb797c2313d2d92bbf30c16c493df80e0.1370327864.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1370327864.git.arno@natisbad.org>
In-Reply-To: <cover.1340327864.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 drivers/hwmon/Kconfig              |   10 +
 drivers/hwmon/Makefile             |    1 +
 drivers/hwmon/g762.c               | 1111 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/g762.h |   47 ++
 4 files changed, 1169 insertions(+)
 create mode 100644 drivers/hwmon/g762.c
 create mode 100644 include/linux/platform_data/g762.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0428e8a..142bdf8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -456,6 +456,16 @@ config SENSORS_G760A
 	  This driver can also be built as a module.  If so, the module
 	  will be called g760a.
 
+config SENSORS_G762
+	tristate "GMT G762 and G763"
+	depends on I2C
+	help
+	  If you say yes here you get support for Global Mixed-mode
+	  Technology Inc G762 and G763 fan speed PWM controller chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called g762.
+
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d17d3e6..4f0fb52 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
 obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
 obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
 obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
+obj-$(CONFIG_SENSORS_G762)	+= g762.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
new file mode 100644
index 0000000..194be43
--- /dev/null
+++ b/drivers/hwmon/g762.c
@@ -0,0 +1,1111 @@
+/*
+ * g762 - Driver for the Global Mixed-mode Technology Inc. fan speed
+ *        PWM controller chips from G762 family, i.e. G762 and G763
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This work is based on a basic version for 2.6.31 kernel developed
+ * by Olivier Mouchet for LaCie. Updates and correction have been
+ * performed to run on recent kernels. Additional features, like the
+ * ability to configure various characteristics via .dts file, have
+ * been added. Detailed datasheet on which this development is based
+ * is available here:
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
+ * Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_data/g762.h>
+
+#define DRVNAME "g762"
+
+static const struct i2c_device_id g762_id[] = {
+	{ "g762", 0 },
+	{ "g763", 0 },
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
+#define G762_REG_FAN_CMD1_DET_FAN_FAIL  0x80 /* enable fan_fail signal */
+#define G762_REG_FAN_CMD1_DET_FAN_OOC   0x40 /* enable fan_out_of_control */
+#define G762_REG_FAN_CMD1_OUT_MODE      0x20 /* out mode, PWM or DC */
+#define G762_REG_FAN_CMD1_FAN_MODE      0x10 /* fan mode: closed/open loop */
+#define G762_REG_FAN_CMD1_CLK_DIV_ID1   0x08 /* clock divisor value */
+#define G762_REG_FAN_CMD1_CLK_DIV_ID0   0x04
+#define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* PWM polarity */
+#define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution */
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
+#define OUT_MODE_PWM            1
+#define OUT_MODE_DC             0
+
+#define FAN_MODE_CLOSED_LOOP    2
+#define FAN_MODE_OPEN_LOOP      1
+
+/* register data is read (and cached) at most once per second */
+#define G762_UPDATE_INTERVAL    HZ
+
+/*
+ * extract pulse count per fan revolution value (2 or 4) from given
+ * FAN_CMD1 register value
+ */
+#define PULSE_FROM_REG(reg) \
+	((((reg) & G762_REG_FAN_CMD1_PULSE_PER_REV) + 1) << 1)
+
+/*
+ * extract fan clock divisor (1, 2, 4 or 8) from given FAN_CMD1
+ * register value
+ */
+#define CLKDIV_FROM_REG(reg) \
+	(1 << (((reg) & (G762_REG_FAN_CMD1_CLK_DIV_ID0 |	\
+			 G762_REG_FAN_CMD1_CLK_DIV_ID1)) >> 2))
+
+/*
+ * extract fan gear mode multiplier value (0, 2 or 4) from given
+ * FAN_CMD2 register value
+ */
+#define GEARMULT_FROM_REG(reg) \
+	(1 << (((reg) & (G762_REG_FAN_CMD2_GEAR_MODE_0 |	\
+			 G762_REG_FAN_CMD2_GEAR_MODE_1)) >> 2))
+
+struct g762_data {
+	struct i2c_client *client;
+	struct device *hwmon_dev;
+
+	/* update mutex */
+	struct mutex update_lock;
+
+	/* board specific parameters. */
+	u32 clk;
+
+	/* g762 register cache */
+	bool valid;
+	unsigned long last_updated; /* in jiffies */
+
+	u8 set_cnt;  /* controls fan rotation speed in closed-loop mode */
+	u8 act_cnt;  /* provides access to current fan RPM value */
+	u8 fan_sta;  /* bit 0: set when actual fan speed is more than
+		      *        25% outside requested fan speed
+		      * bit 1: set when no transition occurs on fan
+		      *        pin for 0.7s
+		      */
+	u8 set_out;  /* controls fan rotation speed in open-loop mode */
+	u8 fan_cmd1; /*   0: FG_PLS_ID0 FG pulses count per revolution
+		      *      0: 2 counts per revolution
+		      *      1: 4 counts per revolution
+		      *   1: PWM_POLARITY 1: negative_duty
+		      *                   0: positive_duty
+		      * 2,3: [FG_CLOCK_ID0, FG_CLK_ID1]
+		      *         00: Divide fan clock by 1
+		      *         01: Divide fan clock by 2
+		      *         10: Divide fan clock by 4
+		      *         11: Divide fan clock by 8
+		      *   4: FAN_MODE 1:closed-loop, 0:open-loop
+		      *   5: OUT_MODE 1:PWM, 0:DC
+		      *   6: DET_FAN_OOC enable "fan ooc" status
+		      *   7: DET_FAN_FAIL enable "fan fail" status
+		      */
+	u8 fan_cmd2; /* 0,1: FAN_STARTV 0,1,2,3 -> 0,32,64,96 dac_code
+		      * 2,3: FG_GEAR_MODE
+		      *         00: multiplier = 1
+		      *         01: multiplier = 2
+		      *         10: multiplier = 4
+		      *   4: Mask ALERT# (g763 only)
+		      */
+};
+
+/*
+ * sysfs PWM interface uses value from 0 to 255 when g762 FAN_SET_CNT register
+ * uses values from 255 (off) to 0 (full speed). Note that FAN_SET_OUT register
+ * uses values from 0 (off) to 255 (full speed), i.e. does not need translation.
+ */
+#define PWM_FROM_CNT(cnt)       (0xff - (cnt))
+#define PWM_TO_CNT(pwm)         (0xff - (pwm))
+
+/*
+ * Convert count value from fan controller register (FAN_SET_CNT) into fan
+ * speed RPM value. Note that the datasheet documents a basic formula.
+ * Influence of additional parameters (fan clock divisor, fan gear mode)
+ * have been infered from examples in the datasheet and tests.
+ */
+static inline unsigned int rpm_from_cnt(u8 cnt, u32 clk, u16 p,
+					u8 clk_div, u8 gear_mult)
+{
+	if (cnt = 0xff)  /* cnt to 255 stops the fan */
+		return 0;
+
+	return (clk * 30 * gear_mult) / ((cnt ? cnt : 1) * p * clk_div);
+}
+
+/*
+ * Convert fan RPM value from sysfs into count value for fan controller
+ * register (FAN_SET_CNT).
+ */
+static inline unsigned char cnt_from_rpm(u32 rpm, u32 clk, u16 p,
+					 u8 clk_div, u8 gear_mult)
+{
+	if (!rpm)         /* to stop the fan, set cnt to 255 */
+		return 0xff;
+
+	return clamp_val(((clk * 30 * gear_mult) / (rpm * p * clk_div)),
+			 0, 255);
+}
+
+/* helper to grab and cache data, at most one time per second */
+static struct g762_data *g762_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = i2c_get_clientdata(client);
+	int ret = 0;
+
+	mutex_lock(&data->update_lock);
+	if (time_before(jiffies, data->last_updated + G762_UPDATE_INTERVAL) &&
+	    likely(data->valid))
+		goto out;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_SET_CNT);
+	if (ret < 0)
+		goto out;
+	data->set_cnt = ret;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_ACT_CNT);
+	if (ret < 0)
+		goto out;
+	data->act_cnt = ret;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_STA);
+	if (ret < 0)
+		goto out;
+	data->fan_sta = ret;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_SET_OUT);
+	if (ret < 0)
+		goto out;
+	data->set_out = ret;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD1);
+	if (ret < 0)
+		goto out;
+	data->fan_cmd1 = ret;
+
+	ret = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD2);
+	if (ret < 0)
+		goto out;
+	data->fan_cmd2 = ret;
+
+	data->last_updated = jiffies;
+	data->valid = true;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	if (ret < 0) /* upon error, encode it in return value */
+		data = ERR_PTR(ret);
+
+	return data;
+}
+
+/*
+ * helpers for passing hardware characteristics via DT. Some of those
+ * are also used by sysfs handlers (write functions) later in the file.
+ */
+
+/* Set pwm mode. Accepts either 0 (PWM mode) or 1 (DC mode) */
+static int do_set_pwm_mode(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case OUT_MODE_PWM:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_OUT_MODE;
+		break;
+	case OUT_MODE_DC:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_OUT_MODE;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/*
+ * Set reference clock. Accepted values are between 0 and 0xffffff.
+ * Note that this is a characteristic of the system but an internal
+ * parameter, i.e. value is not passed to the device.
+ */
+static int do_set_pwm_freq(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = i2c_get_clientdata(client);
+
+	if (val > 0xffffff)
+		return -EINVAL;
+
+	data->clk = val;
+
+	return 0;
+}
+
+/* Set fan clock divisor. Accepted values are 1, 2, 4 and 8. */
+static int do_set_fan_div(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 1:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 2:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 4:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	case 8:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set fan gear mode. Accepted values are either 0, 1 or 2. */
+static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0:
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	case 1:
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	case 2:
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_1;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
+					data->fan_cmd2);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set pulse per revolution value. Accepts either 2 or 4. */
+static int do_set_fan_pulses(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 2:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PULSE_PER_REV;
+		break;
+	case 4:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PULSE_PER_REV;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set fan mode. Accepts either 1 (open-loop) or 2 (closed-loop). */
+static int do_set_pwm_enable(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case FAN_MODE_OPEN_LOOP:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_FAN_MODE;
+		break;
+	case FAN_MODE_CLOSED_LOOP:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_FAN_MODE;
+		break;
+	default:
+		goto out;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set PWM polarity (0 for negative duty, 1 for positive duty) */
+static int do_set_pwm_polarity(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0: /* i.e. negative duty */
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PWM_POLARITY;
+		break;
+	case 1: /* i.e. positive duty */
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PWM_POLARITY;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/*
+ * Set pwm value. Accepted values are between 0 (stops the fan) and
+ * 255 (full speed). This only makes sense in open-loop mode.
+ */
+static int do_set_pwm(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (val > 255)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->set_out = val;
+	ret = i2c_smbus_write_byte_data(client, G762_REG_SET_OUT, val);
+	data->valid = false;
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set fan RPM value. This only makes sense in closed-loop mode. */
+static int do_set_fan_target(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	data->set_cnt = cnt_from_rpm(val, data->clk,
+				     PULSE_FROM_REG(data->fan_cmd1),
+				     CLKDIV_FROM_REG(data->fan_cmd1),
+				     GEARMULT_FROM_REG(data->fan_cmd2));
+	ret = i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
+					data->set_cnt);
+	data->valid = false;
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Enable/disable fan failure detection. Accepted values are 1 and 0. */
+static int do_fan_failure_detection_toggle(struct device *dev,
+					   unsigned long enable)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (enable) {
+	case 0:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_FAIL;
+		break;
+	case 1:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_FAIL;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Enable/disable fan out of control detection. Accepted values are 1 and 0 */
+static int do_fan_ooc_detection_toggle(struct device *dev, unsigned int enable)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (enable) {
+	case 0:
+		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_OOC;
+		break;
+	case 1:
+		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_OOC;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD1,
+					data->fan_cmd1);
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/* Set fan startup voltage. Accepted values are either 0, 1, 2 or 3. */
+static int do_set_fan_startv(struct device *dev, unsigned long val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct g762_data *data = g762_update_client(dev);
+	int ret = -EINVAL;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0:
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
+		data->valid = false;
+		break;
+	case 1:
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
+		data->valid = false;
+		break;
+	case 2:
+		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
+		data->valid = false;
+		break;
+	case 3:
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
+		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
+		data->valid = false;
+		break;
+	default:
+		goto out;
+	}
+	ret = i2c_smbus_write_byte_data(client, G762_REG_FAN_CMD2,
+					data->fan_cmd2);
+	data->valid = false;
+ out:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+/*
+ * Configuration-related definitions
+ */
+
+/*
+ * Recover and set given property value from platform_data. In order to
+ * distinguish initialized values from uninitialized ones passed in a
+ * sparse structure using G762_ATTR_VAL(), MSB is checked.
+ */
+static inline int g762_one_prop_commit(struct i2c_client *client,
+				       u32 pval, const char *pname,
+				       int (*psetter)(struct device *dev,
+						      unsigned long val))
+{
+	int ret = 0;
+
+	if (pval & G762_VAL_TEST_BIT) {
+		pval &= G762_VAL_TEST_MASK; /* recover val (clear test bit) */
+		if ((*psetter)(&client->dev, pval)) {
+			dev_err(&client->dev, "unable to set %s (%d)\n",
+				pname, pval);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int g762_platform_data_commit(struct i2c_client *client,
+				     struct g762_platform_data *pdata)
+{
+	int ret;
+
+	ret = g762_one_prop_commit(client, pdata->fan_startv,
+				   "fan_startv", do_set_fan_startv);
+	if (ret < 0)
+		return ret;
+
+	ret = g762_one_prop_commit(client, pdata->fan_pulses,
+				   "fan_pulses", do_set_fan_pulses);
+	if (ret < 0)
+		return ret;
+
+	ret = g762_one_prop_commit(client, pdata->pwm_freq,
+				   "pwm_freq", do_set_pwm_freq);
+	if (ret < 0)
+		return ret;
+
+	ret = g762_one_prop_commit(client, pdata->fan_gear_mode,
+				   "fan_gear_mode", do_set_fan_gear_mode);
+	if (ret < 0)
+		return ret;
+
+	ret = g762_one_prop_commit(client, pdata->pwm_polarity,
+				   "pwm_polarity", do_set_pwm_polarity);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Helpers to import hardware characteristics from .dts file and overload
+ * default platform data values.
+ */
+
+#ifdef CONFIG_OF
+static struct of_device_id g762_dt_match[] = {
+	{ .compatible = "gmt,g762" },
+	{ .compatible = "gmt,g763" },
+	{ },
+};
+
+static inline void g762_of_import_one_prop(struct i2c_client *client,
+					   u32 *dest, const char *pname)
+{
+	const __be32 *prop;
+	int len;
+
+	prop = of_get_property(client->dev.of_node, pname, &len);
+	if (prop && len = sizeof(u32)) {
+		*dest = G762_ATTR_VAL(be32_to_cpu(prop[0]));
+		dev_dbg(&client->dev, "found %s (%d)\n", pname, *dest);
+	}
+}
+
+static void g762_platform_data_of_overload(struct i2c_client *client,
+					   struct g762_platform_data *pdata)
+{
+	if (!client->dev.of_node)
+		return;
+
+	g762_of_import_one_prop(client, &pdata->fan_startv, "fan_startv");
+	g762_of_import_one_prop(client, &pdata->fan_gear_mode, "fan_gear_mode");
+	g762_of_import_one_prop(client, &pdata->fan_pulses, "fan_pulses");
+	g762_of_import_one_prop(client, &pdata->pwm_polarity, "pwm_polarity");
+	g762_of_import_one_prop(client, &pdata->pwm_freq, "pwm_freq");
+}
+#else
+static void g762_platform_data_of_overload(struct i2c_client *client,
+				    struct g762_platform_data *pdata) { }
+#endif
+
+/*
+ * helper to overload driver parameters from board init file for those
+ * not already converted to device tree
+ */
+static void g762_platform_data_overload(struct i2c_client *client,
+					struct g762_platform_data *pdata)
+{
+	struct g762_platform_data *opdata = client->dev.platform_data;
+
+	if (!opdata)
+		return;
+
+	if (opdata->fan_startv & G762_VAL_TEST_BIT)
+		pdata->fan_startv = opdata->fan_startv;
+	if (opdata->fan_gear_mode & G762_VAL_TEST_BIT)
+		pdata->fan_gear_mode = opdata->fan_gear_mode;
+	if (opdata->fan_pulses & G762_VAL_TEST_BIT)
+		pdata->fan_pulses = opdata->fan_pulses;
+	if (opdata->pwm_polarity & G762_VAL_TEST_BIT)
+		pdata->pwm_polarity = opdata->pwm_polarity;
+	if (opdata->pwm_freq & G762_VAL_TEST_BIT)
+		pdata->pwm_freq = opdata->pwm_freq;
+}
+
+/*
+ * sysfs attributes
+ */
+
+/*
+ * Read function for fan1_input sysfs file. Return current fan RPM value, or
+ * 0 if fan is out of control.
+ */
+static ssize_t get_fan_rpm(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	unsigned int rpm = 0;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	/* reverse logic: fan out of control reporting is enabled low */
+	if (data->fan_sta & G762_REG_FAN_STA_OOC) {
+		rpm = rpm_from_cnt(data->act_cnt, data->clk,
+				   PULSE_FROM_REG(data->fan_cmd1),
+				   CLKDIV_FROM_REG(data->fan_cmd1),
+				   GEARMULT_FROM_REG(data->fan_cmd2));
+	}
+	mutex_unlock(&data->update_lock);
+
+	return sprintf(buf, "%u\n", rpm);
+}
+
+/*
+ * Read and write functions for pwm1_mode sysfs file. Get and set fan speed
+ * control mode i.e. PWM (1) or DC (0).
+ */
+static ssize_t get_pwm_mode(struct device *dev, struct device_attribute *da,
+			    char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n",
+		       !!(data->fan_cmd1 & G762_REG_FAN_CMD1_OUT_MODE));
+}
+
+static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_pwm_mode(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+/*
+ * Read and write functions for fan1_div sysfs file. Get and set fan
+ * controller prescaler value
+ */
+static ssize_t get_fan_div(struct device *dev,
+			   struct device_attribute *da, char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", CLKDIV_FROM_REG(data->fan_cmd1));
+}
+
+static ssize_t set_fan_div(struct device *dev,
+			   struct device_attribute *da,
+			   const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_fan_div(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+/*
+ * Read and write functions for pwm1_enable. Get and set the fan speed control
+ * mode (i.e. closed or open-loop).
+ *
+ * Following documentation about hwmon's sysfs interface, a pwm1_enable node
+ * should accept followings:
+ *
+ *  0 : no fan speed control (i.e. fan at full speed)
+ *  1 : manual fan speed control enabled (use pwm[1-*]) (open-loop)
+ *  2+: automatic fan speed control enabled (use fan[1-*]_target) (closed-loop)
+ *
+ * but we do not accept 0 as "no-control" mode is not supported by g762,
+ * -EINVAL is returned in this case.
+ */
+static ssize_t get_pwm_enable(struct device *dev,
+			      struct device_attribute *da, char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n",
+		       (!!(data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE)) + 1);
+}
+
+static ssize_t set_pwm_enable(struct device *dev,
+			      struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_pwm_enable(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+/*
+ * Read and write functions for pwm1 sysfs file. Get and set the fan speed
+ * in both open-loop mode. Speed is given as a value between 0 and 255:
+ * 0 stops the fan and 255 makes it run at full speed.
+ */
+static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
+		       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", data->set_out);
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
+		       const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_pwm(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+/*
+ * Read and write function for fan1_target sysfs file. Get/set the fan speed in
+ * closed-loop mode. Speed is given as a RPM value; then the chip will regulate
+ * the fan speed using pulses from fan tachometer.
+ *
+ * Refer to rpm_from_cnt() implementation above to get info about count number
+ * calculation.
+ *
+ * Also note that due to rounding errors it is possible that you don't read
+ * back exactly the value you have set.
+ */
+static ssize_t get_fan_target(struct device *dev, struct device_attribute *da,
+			      char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+	ssize_t ret = -EINVAL;
+	unsigned int rpm;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	mutex_lock(&data->update_lock);
+	rpm = rpm_from_cnt(data->set_cnt, data->clk,
+			   PULSE_FROM_REG(data->fan_cmd1),
+			   CLKDIV_FROM_REG(data->fan_cmd1),
+			   GEARMULT_FROM_REG(data->fan_cmd2));
+	ret = sprintf(buf, "%u\n", rpm);
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	ret = do_set_fan_target(dev, val);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+/* read function for fan1_fault sysfs file. */
+static ssize_t get_fan_failure(struct device *dev, struct device_attribute *da,
+			       char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%u\n", !!(data->fan_sta & G762_REG_FAN_STA_FAIL));
+}
+
+/*
+ * read function for fan1_alarm sysfs file. Note that OOC condition is
+ * enabled low
+ */
+static ssize_t get_fan_ooc(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct g762_data *data = g762_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%u\n", !(data->fan_sta & G762_REG_FAN_STA_OOC));
+}
+
+static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, get_pwm_mode, set_pwm_mode);
+static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
+		   get_pwm_enable, set_pwm_enable);
+static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
+static DEVICE_ATTR(fan1_alarm, S_IRUGO, get_fan_ooc, NULL);
+static DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan_failure, NULL);
+static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
+		   get_fan_target, set_fan_target);
+static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_fan_div, set_fan_div);
+
+/* Driver data */
+static struct attribute *g762_attributes[] = {
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan1_alarm.attr,
+	&dev_attr_fan1_fault.attr,
+	&dev_attr_fan1_target.attr,
+	&dev_attr_fan1_div.attr,
+	&dev_attr_pwm1.attr,
+	&dev_attr_pwm1_mode.attr,
+	&dev_attr_pwm1_enable.attr,
+	NULL
+};
+
+static const struct attribute_group g762_group = {
+	.attrs = g762_attributes,
+};
+
+static int g762_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct g762_platform_data pdata = { .pwm_freq = G762_ATTR_VAL(32768) };
+	struct g762_data *data;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct g762_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+
+	data->client = client;
+	mutex_init(&data->update_lock);
+
+	/* Enable fan protection and fan fail detection by default */
+	do_fan_ooc_detection_toggle(&client->dev, 1);
+	do_fan_failure_detection_toggle(&client->dev, 1);
+
+	/*
+	 * Set default configuration values before passing the structure
+	 * first to overload routine used by boards non converted to DT and
+	 * then to OF helper (to overload them using those provided by .dts
+	 * file, if any). Final result is then commited.
+	 */
+	g762_platform_data_overload(client, &pdata);
+	g762_platform_data_of_overload(client, &pdata);
+	err = g762_platform_data_commit(client, &pdata);
+	if (err)
+		return err;
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &g762_group);
+	if (err)
+		return err;
+
+	data->hwmon_dev = (struct device *)hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto err_out;
+	}
+
+	return 0;
+
+ err_out:
+	sysfs_remove_group(&client->dev.kobj, &g762_group);
+	return err;
+}
+
+static int g762_remove(struct i2c_client *client)
+{
+	struct g762_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &g762_group);
+
+	return 0;
+}
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
+module_i2c_driver(g762_driver);
+
+MODULE_AUTHOR("Arnaud EBALARD <arno@natisbad.org>");
+MODULE_DESCRIPTION("GMT G762/G763 driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/g762.h b/include/linux/platform_data/g762.h
new file mode 100644
index 0000000..cfaf2f3
--- /dev/null
+++ b/include/linux/platform_data/g762.h
@@ -0,0 +1,47 @@
+/*
+ * Platform data structure for g762 fan controller driver
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
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
+#ifndef __LINUX_PLATFORM_DATA_G762_H__
+#define __LINUX_PLATFORM_DATA_G762_H__
+
+/*
+ * Following structure can be used to set g762 driver platform specific data
+ * during board init. Attributes must *always* be set using G762_ATTR_VAL()
+ * macro defined below, i.e. it is not possible to pass a value directly.
+ * Defining a sparse structure is possible. For instance, if one only needs
+ * to set pwm_freq to 8192 and fan_pulses to 2, the following can be done:
+ *
+ * static struct g762_platform_data pdata = { .pwm_freq = G762_ATTR_VAL(8192),
+ *                                            .fan_pulses = G762_ATTR_VAL(2), };
+ *
+ */
+
+#define G762_VAL_TEST_BIT  (1 << 31)
+#define G762_VAL_TEST_MASK (~G762_VAL_TEST_BIT)
+#define G762_ATTR_VAL(val) ((val) | G762_VAL_TEST_BIT)
+
+struct g762_platform_data {
+	u32 fan_startv;
+	u32 fan_gear_mode;
+	u32 fan_pulses;
+	u32 pwm_polarity;
+	u32 pwm_freq;
+};
+
+#endif /* __LINUX_PLATFORM_DATA_G762_H__ */
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
