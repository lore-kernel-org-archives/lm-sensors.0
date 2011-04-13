From: Zhang Jiejing <jiejing.zhang@freescale.com>
Date: Wed, 13 Apr 2011 11:56:53 +0000
Subject: [lm-sensors] [PATCH] hwmod: sensors: mma845x gravity sensor chips
Message-Id: <1302695813-9606-1-git-send-email-jiejing.zhang@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch add basic support for mma8450 mma8451 gravity
sensor chips, and will support mma8452, mma8453 in same
driver file.

They are i2c controller and support 3-axis gravity accelerator
sensor.

mma8450 have some different from mma845[1,2,3] in register map, so
there are some switch case between mma8450 and others.

Product Information can be found here:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8450Q
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MMA8451Q

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
---
 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/mma845x.c |  568 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 579 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/mma845x.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 773e484..110cf09 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -694,6 +694,16 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
+config SENSORS_MMA845X
+       tristate "Freescale MMA845X sensor chips"
+       depends on I2C
+       help
+         If you say yes here you get support for the Freescale
+	 MMA8450/MMA8451 gravity accelerator sensors chips.
+
+	 This driver can also be build as a module. If so, the module
+	 will be called mma845x.
+
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	select HWMON_VID
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index dde02d9..1264309 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
+obj-$(CONFIG_SENSORS_MMA845X)	+= mma845x.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
diff --git a/drivers/hwmon/mma845x.c b/drivers/hwmon/mma845x.c
new file mode 100644
index 0000000..2f8e8cc
--- /dev/null
+++ b/drivers/hwmon/mma845x.c
@@ -0,0 +1,568 @@
+/* Driver for Freescale mma845[0,1,2,3] 3-axis gravity accelerator sensors
+ *
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Author: Zhang Jiejing <jiejing.zhang@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * This driver currently only support mma8450 and mma8451.
+ * mma845x accelerator sensors are share same i2c slave address(7-bits): 0x1c
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/pm.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/input-polldev.h>
+
+#define MMA8450_ID		0xc6
+#define MMA8451_ID		0x1a
+#define MMA8452_ID		0x2a
+#define MMA8453_ID		0x3a
+
+#define POLL_INTERVAL_MIN	1
+#define POLL_INTERVAL_MAX	500
+#define POLL_INTERVAL		100 /* msecs */
+#define INPUT_FUZZ		32
+#define INPUT_FLAT		32
+#define MODE_CHANGE_DELAY_MS	100
+
+#define MMA845X_STATUS_ZYXDR	0x08
+#define MMA845X_BUF_SIZE	6
+
+/* mma8451 registers */
+enum mma8451_registers {
+	MMA8451_STATUS = 0x00,
+	MMA8451_OUT_X_MSB,
+	MMA8451_OUT_X_LSB,
+	MMA8451_OUT_Y_MSB,
+	MMA8451_OUT_Y_LSB,
+	MMA8451_OUT_Z_MSB,
+	MMA8451_OUT_Z_LSB,
+	MMA8451_F_SETUP = 0x09,
+	MMA8451_TRIG_CFG,
+	MMA8451_SYSMOD,
+	MMA8451_INT_SOURCE,
+	MMA8451_WHO_AM_I,
+	MMA8451_XYZ_DATA_CFG,
+	MMA8451_HP_FILTER_CUTOFF,
+	MMA8451_PL_STATUS,
+	MMA8451_PL_CFG,
+	MMA8451_PL_COUNT,
+	MMA8451_PL_BF_ZCOMP,
+	MMA8451_P_L_THS_REG,
+	MMA8451_FF_MT_CFG,
+	MMA8451_FF_MT_SRC,
+	MMA8451_FF_MT_THS,
+	MMA8451_FF_MT_COUNT,
+	MMA8451_TRANSIENT_CFG = 0x1D,
+	MMA8451_TRANSIENT_SRC,
+	MMA8451_TRANSIENT_THS,
+	MMA8451_TRANSIENT_COUNT,
+	MMA8451_PULSE_CFG,
+	MMA8451_PULSE_SRC,
+	MMA8451_PULSE_THSX,
+	MMA8451_PULSE_THSY,
+	MMA8451_PULSE_THSZ,
+	MMA8451_PULSE_TMLT,
+	MMA8451_PULSE_LTCY,
+	MMA8451_PULSE_WIND,
+	MMA8451_ASLP_COUNT,
+	MMA8451_CTRL_REG1,
+	MMA8451_CTRL_REG2,
+	MMA8451_CTRL_REG3,
+	MMA8451_CTRL_REG4,
+	MMA8451_CTRL_REG5,
+	MMA8451_OFF_X,
+	MMA8451_OFF_Y,
+	MMA8451_OFF_Z,
+	MMA8451_REG_END,
+};
+
+/* mma8450 registers */
+enum mma8450_registers {
+	MMA8450_STATUS1 = 0x00,
+	MMA8450_OUT_X8,
+	MMA8450_OUT_Y8,
+	MMA8450_OUT_Z8,
+	MMA8450_STATUS2,
+	MMA8450_OUT_X_LSB,
+	MMA8450_OUT_X_MSB,
+	MMA8450_OUT_Y_LSB,
+	MMA8450_OUT_Y_MSB,
+	MMA8450_OUT_Z_LSB,
+	MMA8450_OUT_Z_MSB,
+	MMA8450_STATUS3,
+	MMA8450_OUT_X_DELTA,
+	MMA8450_OUT_Y_DELTA,
+	MMA8450_OUT_Z_DELTA,
+	MMA8450_WHO_AM_I,
+	MMA8450_F_STATUS,
+	MMA8450_F_8DATA,
+	MMA8450_F_12DATA,
+	MMA8450_F_SETUP,
+	MMA8450_SYSMOD,
+	MMA8450_INT_SOURCE,
+	MMA8450_XYZ_DATA_CFG,
+	MMA8450_HP_FILTER_CUTOFF,
+	MMA8450_PL_STATUS,
+	MMA8450_PL_PRE_STATUS,
+	MMA8450_PL_CFG,
+	MMA8450_PL_COUNT,
+	MMA8450_PL_BF_ZCOMP,
+	MMA8450_PL_P_L_THS_REG1,
+	MMA8450_PL_P_L_THS_REG2,
+	MMA8450_PL_P_L_THS_REG3,
+	MMA8450_PL_L_P_THS_REG1,
+	MMA8450_PL_L_P_THS_REG2,
+	MMA8450_PL_L_P_THS_REG3,
+	MMA8450_FF_MT_CFG_1,
+	MMA8450_FF_MT_SRC_1,
+	MMA8450_FF_MT_THS_1,
+	MMA8450_FF_MT_COUNT_1,
+	MMA8450_FF_MT_CFG_2,
+	MMA8450_FF_MT_SRC_2,
+	MMA8450_FF_MT_THS_2,
+	MMA8450_FF_MT_COUNT_2,
+	MMA8450_TRANSIENT_CFG,
+	MMA8450_TRANSIENT_SRC,
+	MMA8450_TRANSIENT_THS,
+	MMA8450_TRANSIENT_COUNT,
+	MMA8450_PULSE_CFG,
+	MMA8450_PULSE_SRC,
+	MMA8450_PULSE_THSX,
+	MMA8450_PULSE_THSY,
+	MMA8450_PULSE_THSZ,
+	MMA8450_PULSE_TMLT,
+	MMA8450_PULSE_LTCY,
+	MMA8450_PULSE_WIND,
+	MMA8450_ASLP_COUNT,
+	MMA8450_CTRL_REG1,
+	MMA8450_CTRL_REG2,
+	MMA8450_CTRL_REG3,
+	MMA8450_CTRL_REG4,
+	MMA8450_CTRL_REG5,
+	MMA8450_OFF_X,
+	MMA8450_OFF_Y,
+	MMA8450_OFF_Z,
+	MMA8450_REG_END,
+};
+
+
+/* MMA845x have 3 different mode, each mode have different sensitivity
+ * as below */
+/* MODE_2G: sensitivity is 1024 counts/g
+ * MODE_4G: sensitivity is 512 counts/g
+ * MODE_8G: sensitivity is 256 counts/g
+ */
+enum mma845x_mode {
+	MODE_2G = 0,
+	MODE_4G,
+	MODE_8G,
+};
+
+enum mma845x_type {
+	MMA8450,
+	MMA8451,
+	MMA8452,
+	MMA8453,
+};
+
+struct mma845x_info {
+	int type;
+	u8 mode;
+	u8 ctl_reg;
+	struct i2c_client *client;
+	struct input_polled_dev *idev;
+	struct device *hwmon_dev;
+};
+
+static DEFINE_MUTEX(mma845x_lock);
+
+/* Default use 2G mode */
+#define DEFAULT_SENSTIVE_MODE MODE_2G
+
+static const char *get_mma845x_name(int type)
+{
+	switch (type) {
+	case MMA8450:
+		return "mma8450";
+	case MMA8451:
+		return "mma8451";
+	case MMA8452:
+		return "mma8452";
+	case MMA8453:
+		return "mma8453";
+	default:
+		return "unknown";
+	}
+}
+
+static int get_ctrl_register(int type)
+{
+	switch (type) {
+	case MMA8450:
+		return MMA8450_STATUS3;
+	case MMA8451:
+		return MMA8451_STATUS;
+	}
+	return -EINVAL;
+}
+
+static int mma8450_change_mode(struct mma845x_info *priv)
+{
+	int ret;
+	ret = i2c_smbus_write_byte_data(priv->client,
+					MMA8450_XYZ_DATA_CFG, 0x07);
+	ret |= i2c_smbus_write_byte_data(priv->client,
+					 MMA8450_CTRL_REG1, priv->mode + 1);
+	if (ret < 0) {
+		dev_err(&priv->client->dev, "mma8450 init error");
+		goto out;
+	}
+	mdelay(MODE_CHANGE_DELAY_MS);
+	return 0;
+out:
+	return ret;
+}
+
+static int mma8451_change_mode(struct mma845x_info *priv)
+{
+	int ret;
+	priv->ctl_reg |= 0x01;
+	ret = i2c_smbus_write_byte_data(priv->client, MMA8451_CTRL_REG1, 0);
+	if (ret < 0)
+		goto out;
+	ret = i2c_smbus_write_byte_data(priv->client,
+					MMA8451_XYZ_DATA_CFG, priv->mode);
+	ret |= i2c_smbus_write_byte_data(priv->client,
+					   MMA8451_CTRL_REG1, priv->ctl_reg);
+	if (ret < 0) {
+		dev_err(&priv->client->dev, "mma8451 init error");
+		goto out;
+	}
+
+	mdelay(MODE_CHANGE_DELAY_MS);
+	return 0;
+out:
+	return ret;
+}
+
+static int init_mma845x_chip(struct mma845x_info *priv)
+{
+	int ret;
+
+	switch (priv->type) {
+	case MMA8450:
+		ret = mma8450_change_mode(priv);
+		break;
+	case MMA8451:
+		ret = mma8451_change_mode(priv);
+		break;
+	default:
+		dev_err(&priv->client->dev, "sensor %s"
+			"is not supported by mma845x driver",
+			get_mma845x_name(priv->type));
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int mma845x_read_data(struct mma845x_info *priv, short *x,
+			     short *y, short *z)
+{
+	u8 buf[MMA845X_BUF_SIZE];
+	int reg_addr = -1;
+	int ret;
+
+	switch (priv->type) {
+	case MMA8450:
+		reg_addr = MMA8450_OUT_X_LSB;
+		break;
+	case MMA8451:
+		reg_addr = MMA8451_OUT_X_MSB;
+		break;
+	default:
+		break;
+	}
+
+	ret = i2c_smbus_read_i2c_block_data(priv->client, reg_addr,
+					    MMA845X_BUF_SIZE, buf);
+	if (ret < MMA845X_BUF_SIZE) {
+		dev_err(&priv->client->dev, "i2c block read failed\n");
+		return -EIO;
+	}
+
+	switch (priv->type) {
+	case MMA8450:
+		*x = (buf[1] << 8) | ((buf[0] << 4) & 0xf0);
+		*y = (buf[3] << 8) | ((buf[2] << 4) & 0xf0);
+		*z = (buf[5] << 8) | ((buf[4] << 4) & 0xf0);
+		*x >>= 4;
+		*y >>= 4;
+		*z >>= 4;
+		break;
+	case MMA8451:
+		*x = (buf[0] << 8) | buf[1];
+		*y = (buf[2] << 8) | buf[3];
+		*z = (buf[4] << 8) | buf[5];
+		*x >>= 2;
+		*y >>= 2;
+		*z >>= 2;
+		break;
+	}
+
+	if (priv->mode = MODE_4G) {
+		*x <<= 1;
+		*y <<= 1;
+		*z <<= 1;
+	} else if (priv->mode = MODE_8G) {
+		*x <<= 2;
+		*y <<= 2;
+		*z <<= 2;
+	}
+
+	return 0;
+}
+
+static void mma845x_dev_poll(struct input_polled_dev *dev)
+{
+	struct mma845x_info *priv = dev->private;
+
+	short x = -1, y = -1, z = -1;
+	int ret;
+	int reg_addr;
+
+	mutex_lock(&mma845x_lock);
+
+	reg_addr = get_ctrl_register(priv->type);
+
+	do
+		ret = i2c_smbus_read_byte_data(priv->client, reg_addr);
+	while (!(ret & MMA845X_STATUS_ZYXDR));
+
+	ret = mma845x_read_data(priv, &x, &y, &z);
+	if (!ret) {
+		input_report_abs(priv->idev->input, ABS_X, x);
+		input_report_abs(priv->idev->input, ABS_Y, y);
+		input_report_abs(priv->idev->input, ABS_Z, z);
+		input_sync(priv->idev->input);
+	}
+
+	mutex_unlock(&mma845x_lock);
+}
+
+/*
+ * detecting which chip is on board. mma845x are have same i2c address,
+ * it's impossible exists multiple instance on same board.
+ */
+static int get_device_type(struct i2c_client *client)
+{
+	int ret;
+	/* high 2-bits of MMA8450_WHO_AM_I(0x0f) register on
+	 * mma8451[2,3] will always zero, but MMA8450 Chip-ID's high
+	 * 2-bits not zero */
+	ret = i2c_smbus_read_byte_data(client, MMA8450_WHO_AM_I);
+	if (ret = MMA8450_ID)
+		return MMA8450;
+	ret = i2c_smbus_read_byte_data(client, MMA8451_WHO_AM_I);
+	switch (ret) {
+	case MMA8451_ID:
+		return MMA8451;
+	case MMA8452_ID:
+		return MMA8452;
+	case MMA8453_ID:
+		return MMA8453;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __devinit mma845x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	int ret;
+	struct input_dev *input_idev;
+	struct i2c_adapter *adapter;
+	struct mma845x_info *priv;
+
+	adapter = to_i2c_adapter(client->dev.parent);
+	ret = i2c_check_functionality(adapter,
+					 I2C_FUNC_SMBUS_BYTE |
+					 I2C_FUNC_SMBUS_BYTE_DATA);
+	if (!ret)
+		goto err_out;
+
+	priv = kzalloc(sizeof(struct mma845x_info), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&client->dev, "failed to alloc driver info\n");
+		goto err_out;
+	}
+
+	ret = get_device_type(client);
+	if (ret < 0)
+		goto err_out;
+
+	priv->type = ret;
+	priv->client = client;
+	priv->mode = DEFAULT_SENSTIVE_MODE;
+
+	dev_dbg(&client->dev, "found %s model accelerator\n",
+		 get_mma845x_name(priv->type));
+
+	ret = init_mma845x_chip(priv);
+
+	if (ret) {
+		dev_err(&client->dev,
+			"error when init %s chip:(%d)\n",
+			get_mma845x_name(priv->type), ret);
+		goto err_alloc_priv;
+	}
+
+	priv->hwmon_dev = hwmon_device_register(&client->dev);
+	if (!priv->hwmon_dev) {
+		ret = -ENOMEM;
+		dev_err(&client->dev,
+			"error register hwmon device\n");
+		goto err_alloc_priv;
+	}
+
+	priv->idev = input_allocate_polled_device();
+	if (!priv->idev) {
+		ret = -ENOMEM;
+		dev_err(&client->dev, "alloc poll device failed!\n");
+		goto err_alloc_poll_device;
+	}
+	priv->idev->private = priv;
+	priv->idev->poll = mma845x_dev_poll;
+	priv->idev->poll_interval = POLL_INTERVAL;
+	priv->idev->poll_interval_min = POLL_INTERVAL_MIN;
+	priv->idev->poll_interval_max = POLL_INTERVAL_MAX;
+
+	input_idev = priv->idev->input;
+	input_idev->name = get_mma845x_name(priv->type);
+	input_idev->id.bustype = BUS_I2C;
+	input_idev->evbit[0] = BIT_MASK(EV_ABS);
+
+	input_set_abs_params(input_idev, ABS_X, -8192, 8191,
+			     INPUT_FUZZ, INPUT_FLAT);
+	input_set_abs_params(input_idev, ABS_Y, -8192, 8191,
+			     INPUT_FUZZ, INPUT_FLAT);
+	input_set_abs_params(input_idev, ABS_Z, -8192, 8191,
+			     INPUT_FUZZ, INPUT_FLAT);
+
+	ret = input_register_polled_device(priv->idev);
+	if (ret) {
+		dev_err(&client->dev, "register poll device failed!\n");
+		goto err_register_polled_device;
+	}
+
+	i2c_set_clientdata(client, priv);
+	dev_dbg(&client->dev, "%s accelerator init success\n",
+		get_mma845x_name(priv->type));
+
+	return 0;
+err_register_polled_device:
+	input_free_polled_device(priv->idev);
+err_alloc_poll_device:
+	hwmon_device_unregister(&client->dev);
+err_alloc_priv:
+	kfree(priv);
+err_out:
+	return ret;
+}
+
+static int mma845x_stop_chip(struct i2c_client *client)
+{
+	struct mma845x_info *priv = i2c_get_clientdata(client);
+	int ret;
+	switch (priv->type) {
+	case MMA8450:
+		priv->ctl_reg = i2c_smbus_read_byte_data(client,
+							 MMA8450_CTRL_REG1);
+		ret = i2c_smbus_write_byte_data(client, MMA8450_CTRL_REG1,
+						priv->ctl_reg & 0xFC);
+		break;
+	case MMA8451:
+		priv->ctl_reg = i2c_smbus_read_byte_data(client,
+							 MMA8451_CTRL_REG1);
+		ret = i2c_smbus_write_byte_data(client, MMA8451_CTRL_REG1,
+						priv->ctl_reg & 0xFE);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int __devexit mma845x_remove(struct i2c_client *client)
+{
+	int ret;
+	struct mma845x_info *priv = i2c_get_clientdata(client);
+	ret = mma845x_stop_chip(client);
+	input_free_polled_device(priv->idev);
+	hwmon_device_unregister(priv->hwmon_dev);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mma845x_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return mma845x_stop_chip(client);
+}
+
+static int mma845x_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mma845x_info *priv = i2c_get_clientdata(client);
+
+	return init_mma845x_chip(priv);
+}
+#endif
+
+static const struct i2c_device_id mma845x_id[] = {
+	{"mma8451", 0},
+	{"mma8450", 0},
+};
+MODULE_DEVICE_TABLE(i2c, mma845x_id);
+
+static SIMPLE_DEV_PM_OPS(mma845x_pm_ops, mma845x_suspend, mma845x_resume);
+static struct i2c_driver mma845x_driver = {
+	.driver = {
+		   .name = "mma845x",
+		   .owner = THIS_MODULE,
+		   .pm = &mma845x_pm_ops,
+		   },
+	.probe = mma845x_probe,
+	.remove = __devexit_p(mma845x_remove),
+	.id_table = mma845x_id,
+};
+
+static int __init mma845x_init(void)
+{
+	return i2c_add_driver(&mma845x_driver);
+}
+
+static void __exit mma845x_exit(void)
+{
+	i2c_del_driver(&mma845x_driver);
+}
+
+module_init(mma845x_init);
+module_exit(mma845x_exit);
+
+MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
+MODULE_DESCRIPTION("Freescale MMA845x 3-axis gravity accelerator sensors");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
