From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Fri, 03 Feb 2006 13:43:11 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <11389741912417-git-send-email-Uwe_Zeisberger@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Adds support for the Epson RX8025 SA/NB RTC module.

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger at digi.com>

---

 MAINTAINERS                |    5 
 drivers/i2c/chips/Kconfig  |   10 +
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/rx8025.c |  598 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 614 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/rx8025.c

2bb51a91a12c7096c50dcb2feb9601095d67f9ba
diff --git a/MAINTAINERS b/MAINTAINERS
index 42955fe..b2cc2b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,6 +900,11 @@ P:	Christopher Hoover
 M:	ch at murgatroid.com, ch at hpl.hp.com
 S:	Maintained
 
+EPSON RX-8025 SA/NB RTC DRIVER
+P:	Uwe Zeisberger
+M:	Uwe_Zeisberger at digi.com
+S:	Maintained
+
 ETHEREXPRESS-16 NETWORK DRIVER
 P:	Philip Blundell
 M:	philb at gnu.org
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f9fae28..2c572c7 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -74,6 +74,16 @@ config SENSORS_RTC8564
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rtc8564.
 
+config RTC_RX8025
+	tristate "Epson RX-8025 SA/NB RTC chip"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the
+	  Epson RX-8025 SA/NB RTC chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called rx8025.
+
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
 	depends on I2C && ARCH_OMAP_OTG
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 46178b5..5a67db4 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
+obj-$(CONFIG_RTC_RX8025)	+= rx8025.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
diff --git a/drivers/i2c/chips/rx8025.c b/drivers/i2c/chips/rx8025.c
new file mode 100644
index 0000000..cf8383e
--- /dev/null
+++ b/drivers/i2c/chips/rx8025.c
@@ -0,0 +1,598 @@
+/*
+ * drivers/i2c/chips/rx8025.c
+ *
+ * Driver for Epson's RTC module RX-8025 SA/NB
+ *
+ * Copyright (C) 2005 by Digi International Inc.
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <asm/uaccess.h>
+
+/* registers */
+#define RX8025_REG_SEC		0x00
+#define RX8025_REG_MIN		0x01
+#define RX8025_REG_HOUR		0x02
+#define RX8025_REG_WDAY		0x03
+#define RX8025_REG_MDAY		0x04
+#define RX8025_REG_MONTH	0x05
+#define RX8025_REG_YEAR		0x06
+#define RX8025_REG_DIGOFF	0x07
+#define RX8025_REG_ALWMIN	0x08
+#define RX8025_REG_ALWHOUR	0x09
+#define RX8025_REG_ALWWDAY	0x0a
+#define RX8025_REG_ALDMIN	0x0b
+#define RX8025_REG_ALDHOUR	0x0c
+/* 0x0d is reserved */
+#define RX8025_REG_CTRL1	0x0e
+#define RX8025_REG_CTRL2	0x0f
+
+#define RX8025_BIT_CTRL1_1224	(1 << 5)
+#define RX8025_BIT_CTRL1_DALE	(1 << 6)
+#define RX8025_BIT_CTRL1_WALE	(1 << 7)
+
+#define RX8025_BIT_CTRL2_PON	(1 << 4)
+#define RX8025_BIT_CTRL2_VDET	(1 << 6)
+
+static unsigned short normal_i2c[] = { 0x32, I2C_CLIENT_END };
+I2C_CLIENT_INSMOD_1(rx8025);
+
+static int rx8025_attach_adapter(struct i2c_adapter *adapter);
+static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind);
+static int rx8025_init_client(struct i2c_client *client);
+static int rx8025_detach_client(struct i2c_client *client);
+static int rx8025_rtc_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg);
+
+static struct i2c_driver rx8025_driver = {
+	.driver = {
+		.name = "rx8025",
+	},
+	.attach_adapter = &rx8025_attach_adapter,
+	.detach_client = &rx8025_detach_client,
+};
+
+static struct i2c_client *rx8025_rtcclient = NULL;
+static struct file_operations rx8025_rtc_fops = {
+	.ioctl  = rx8025_rtc_ioctl,
+};
+
+static struct miscdevice rx8025_rtc_dev = {
+	.minor	= RTC_MINOR,
+	.name	= "rtc",
+	.fops	= &rx8025_rtc_fops,
+};
+
+struct rx8025_data {
+	struct i2c_client client;
+	struct list_head list;
+};
+
+static LIST_HEAD(rx8025_clients);
+static DECLARE_MUTEX(rx8025_lock);
+
+static const unsigned char days_in_mo[] +	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
+
+static int rx8025_get_rtctime(struct rtc_time *dt)
+{
+	u8 command = (RX8025_REG_CTRL1 << 4) | 0x08;
+	u8 result[9];
+	int i, err;
+
+	struct i2c_msg msg[] = {
+		{
+			.len	= 1,
+			.buf	= &command,
+		}, {
+			.flags	= I2C_M_RD,
+			.len	= ARRAY_SIZE(result),
+			.buf	= result,
+		}
+	};
+
+	if (down_interruptible(&rx8025_lock))
+		return -ERESTARTSYS;
+
+	if (!rx8025_rtcclient) {
+		err = -EIO;
+		goto errout_unlock;
+	}
+
+	if (!dt) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_get_rtctime: passed in dt = NULL\n");
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(msg); ++i)
+		msg[i].addr = rx8025_rtcclient->addr;
+
+	if ((err = i2c_transfer(rx8025_rtcclient->adapter, msg, 2)) < 2) {
+		err = err >= 0 ? -EIO : err;
+		goto errout_unlock;
+	}
+
+	up(&rx8025_lock);
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"rx8025_get_rtctime: read 0x%02x 0x%02x 0x%02x 0x%02x "
+			"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", result[0],
+			result[1], result[2], result[3], result[4], result[5],
+			result[6], result[7], result[8]);
+
+	dt->tm_sec = BCD2BIN(result[2 + RX8025_REG_SEC] & 0x7f);
+	dt->tm_min = BCD2BIN(result[2 + RX8025_REG_MIN] & 0x7f);
+	if (result[0] | RX8025_BIT_CTRL1_1224)
+		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x3f);
+	else
+		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x1f) % 12
+			+ (result[2 + RX8025_REG_HOUR] & 0x20 ? 12 : 0);
+
+	dt->tm_wday = BCD2BIN(result[2 + RX8025_REG_WDAY] & 0x07);
+	dt->tm_mday = BCD2BIN(result[2 + RX8025_REG_MDAY] & 0x3f);
+	dt->tm_mon = BCD2BIN(result[2 + RX8025_REG_MONTH] & 0x1f) - 1;
+	dt->tm_year = BCD2BIN(result[2 + RX8025_REG_YEAR]);
+
+	if (dt->tm_year < 70)
+		dt->tm_year += 100;
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"rx8025_get_rtctime: "
+			"result: %ds %dm %dh %dwd %dmd %dm %dy\n",
+			dt->tm_sec, dt->tm_min, dt->tm_hour, dt->tm_wday,
+			dt->tm_mday, dt->tm_mon, dt->tm_year);
+
+	return 0;
+
+errout_unlock:
+	up(&rx8025_lock);
+	return err;
+}
+
+static int rx8025_set_rtctime(struct rtc_time *dt)
+{
+	u8 command[8] = { RX8025_REG_SEC << 4, };
+	int err;
+	s32 ctrl1;
+
+	if (down_interruptible(&rx8025_lock))
+		return -ERESTARTSYS;
+
+	if (!rx8025_rtcclient) {
+		err = -EIO;
+		goto errout_unlock;
+	}
+
+	if (!dt) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: passed in dt = NULL\n");
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_sec < 0 || dt->tm_sec >= 60) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: seconds out of range: %d\n",
+			dt->tm_sec);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_min < 0 || dt->tm_min >= 60) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: minutes out of range: %d\n",
+			dt->tm_min);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_hour < 0 || dt->tm_hour >= 24) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: hours out of range: %d\n",
+			dt->tm_hour);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_wday < 0 || dt->tm_wday >= 7) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: week day out of range: %d\n",
+			dt->tm_wday);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_mon < 0 || dt->tm_mon >= 12) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: month out of range: %d\n",
+			dt->tm_mon);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if (dt->tm_year < 70 || dt->tm_year >= 170) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: year out of range: %d\n",
+			dt->tm_year);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	/*
+	 * BUG: The HW assumes every year that is a multiple of 4 to be a leap
+	 * year.  Next time this is wrong is 2100, which will not be a leap
+	 * year.
+	 */
+	if (dt->tm_mday > days_in_mo[dt->tm_mon] +
+			(!(dt->tm_year & 3) && (dt->tm_mon = 1))) {
+		dev_err(&rx8025_rtcclient->dev,
+			"%s: day out of range (with month=%d, year=%d): %d\n",
+			__FUNCTION__, dt->tm_mon, dt->tm_year, dt->tm_mday);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if ((ctrl1 = i2c_smbus_read_byte_data(rx8025_rtcclient,
+					RX8025_REG_CTRL1 << 4)) < 0) {
+		dev_err(&rx8025_rtcclient->dev,
+				"%s: failed to read out RX8025_REG_CTRL1\n",
+				__FUNCTION__);
+		err = -EIO;
+		goto errout_unlock;
+	}
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"%s: ctrl1=0x%x\n", __FUNCTION__, ctrl1);
+	/*
+	 * Here the read-only bits are written as "0".  I'm not sure if that
+	 * is sound.
+	 */
+	command[1 + RX8025_REG_SEC] = BIN2BCD(dt->tm_sec);
+	command[1 + RX8025_REG_MIN] = BIN2BCD(dt->tm_min);
+	if (ctrl1 & RX8025_BIT_CTRL1_1224)
+		command[1 + RX8025_REG_HOUR] = BIN2BCD(dt->tm_hour);
+	else
+		command[1 + RX8025_REG_HOUR] = (dt->tm_hour >= 12 ? 0x20 : 0) |
+			BIN2BCD((dt->tm_hour + 11) % 12 + 1);
+
+	command[1 + RX8025_REG_WDAY] = BIN2BCD(dt->tm_wday);
+	command[1 + RX8025_REG_MDAY] = BIN2BCD(dt->tm_mday);
+	command[1 + RX8025_REG_MONTH] = BIN2BCD(dt->tm_mon + 1);
+	command[1 + RX8025_REG_YEAR] = BIN2BCD(dt->tm_year % 100);
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"%s: send 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
+			"0x%02x 0x%02x\n", __FUNCTION__, command[0],
+			command[1], command[2], command[3], command[4],
+			command[5], command[6], command[7]);
+
+	if ((err = i2c_master_send(rx8025_rtcclient, command, 8) < 8)) {
+		err = err >= 0 ? -EIO : err;
+		goto errout_unlock;
+	}
+
+	up(&rx8025_lock);
+
+	return 0;
+
+errout_unlock:
+	up(&rx8025_lock);
+	return err;
+}
+
+static int rx8025_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, &rx8025_detect);
+}
+
+struct rx8025_limits {
+	u8 reg;
+	u8 mask;
+	u8 min;
+	u8 max;
+};
+
+static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int err = 0;
+	struct rx8025_data *data;
+	struct i2c_client *client;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+		dev_dbg(&adapter->dev, "doesn't support full I2C\n");
+		goto errout;
+	}
+
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
+		dev_dbg(&adapter->dev, "failed to alloc memory\n");
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &rx8025_driver;
+
+	INIT_LIST_HEAD(&data->list);
+
+	if (kind = 0)
+		kind = rx8025;
+
+	if (kind < 0) {
+		u8 command = 0x08;
+		u8 res[RX8025_REG_YEAR + 1];
+		int i, err;
+
+		struct i2c_msg msg[] = {
+			{
+				.addr	= address,
+				.len	= 1,
+				.buf	= &command,
+			}, {
+				.addr	= address,
+				.flags	= I2C_M_RD,
+				.len	= ARRAY_SIZE(res),
+				.buf	= res,
+			}
+		};
+
+		static const struct rx8025_limits limits[] = {
+			{
+				.reg	= RX8025_REG_SEC,
+				.mask	= 0x7f,
+				.min	= 0,
+				.max	= 59,
+			}, {
+				.reg	= RX8025_REG_MIN,
+				.mask	= 0x7f,
+				.min	= 0,
+				.max	= 59,
+			}, {
+				.reg	= RX8025_REG_HOUR,
+				.mask	= 0x3f,
+				.min	= 0,
+				.max	= 32,
+			}, {
+				.reg	= RX8025_REG_WDAY,
+				.mask	= 0x7f,
+				.min	= 0,
+				.max	= 6,
+			}, {
+				.reg	= RX8025_REG_MDAY,
+				.mask	= 0x3f,
+				.min	= 1,
+				.max	= 31,
+			}, {
+				.reg    = RX8025_REG_MONTH,
+				.mask	= 0x1f,
+				.min	= 1,
+				.max	= 12,
+			}, {
+				.reg	= RX8025_REG_YEAR,
+				.mask	= 0xff,
+				.min	= 0,
+				.max	= 99,
+			}
+		};
+
+		if ((err = i2c_transfer(adapter, msg, ARRAY_SIZE(msg)))
+				< ARRAY_SIZE(msg)) {
+			err = err >= 0 ? 0 : err;
+			goto errout_free;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(limits); ++i) {
+			u8 value;
+
+			if ((res[limits[i].reg] & ~limits[i].mask) ||
+					(limits[i].mask > 0x0f &&
+					 (res[limits[i].reg] & 0x0f) > 9) ||
+					((value = BCD2BIN(res[limits[i].reg]))
+					 < limits[i].min) ||
+					 value > limits[i].max) {
+				dev_dbg(&adapter->dev, "%s: register=0x%02x, "
+						"value=0x%02x\n", __FUNCTION__,
+						limits[i].reg,
+						res[limits[i].reg]);
+				err = -ENODEV;
+				goto errout_unlock;
+			}
+		}
+
+		kind = rx8025;
+	}
+
+	BUG_ON(kind != rx8025);
+
+	strlcpy(client->name, "rx8025", I2C_NAME_SIZE);
+
+	if (down_interruptible(&rx8025_lock)) {
+		err = -ERESTARTSYS;
+		goto errout_free;
+	}
+
+	if ((err = i2c_attach_client(client)))
+		goto errout_unlock;
+
+	list_add(&data->list, &rx8025_clients);
+
+	if ((err = rx8025_init_client(client)))
+		goto errout_detach;
+
+	if (!rx8025_rtcclient) {
+		rx8025_rtcclient = client;
+		if ((err = misc_register(&rx8025_rtc_dev))) {
+			rx8025_rtcclient = NULL;
+			dev_err(&client->dev,
+					"Failed to register rtc device\n");
+		}
+	}
+	up(&rx8025_lock);
+
+	dev_info(&client->dev, "chip found\n");
+
+	return 0;
+
+errout_detach:
+	rx8025_detach_client(client);
+
+errout_unlock:
+	up(&rx8025_lock);
+
+errout_free:
+	kfree(data);
+
+errout:
+	dev_dbg(&adapter->dev, "Failed to detect rx8025\n");
+	return err;
+}
+
+static int rx8025_init_client(struct i2c_client *client)
+{
+	u8 command[2] = { RX8025_REG_CTRL2 << 4 | 0x08, };
+	int err;
+
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.len	= 1,
+			.buf	= command,
+		}, {
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= ARRAY_SIZE(command) - 1,
+			.buf	= command + 1,
+		}
+	};
+
+	if ((err = i2c_transfer(client->adapter, msg, 2)) < 2) {
+		err = err >= 0 ? -EIO : err;
+		goto errout;
+	}
+
+	if (command[1] & RX8025_BIT_CTRL2_PON)
+		dev_warn(&client->dev, "power-on reset was detected, "
+				"you may have to readjust the clock\n");
+
+	if (command[1] & RX8025_BIT_CTRL2_VDET)
+		dev_warn(&client->dev, "a power voltage drop was detected, "
+				"you may have to readjust the clock\n");
+
+	command[1] &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET);
+
+	command[0] = RX8025_REG_CTRL2 << 4;
+
+	if ((err = i2c_master_send(client, command, 2)) < 2) {
+		err = err >= 0 ? -EIO : err;
+		goto errout;
+	}
+
+	return 0;
+
+errout:
+	return err;
+}
+
+static int rx8025_detach_client(struct i2c_client *client)
+{
+	int err;
+	struct rx8025_data *data = i2c_get_clientdata(client);
+
+	if (down_interruptible(&rx8025_lock))
+		return -ERESTARTSYS;
+
+	BUG_ON(list_empty(&rx8025_clients));
+
+	if (rx8025_rtcclient = client) {
+		struct list_head *lh = rx8025_clients.next;
+
+		if (list_entry(lh, struct rx8025_data, list) = data)
+			lh = lh->next;
+
+		if (lh = &rx8025_clients) {
+
+			if ((err = misc_deregister(&rx8025_rtc_dev))) {
+				up(&rx8025_lock);
+				return err;
+			}
+
+			rx8025_rtcclient = NULL;
+		} else
+			rx8025_rtcclient = &data->client;
+	}
+
+	if ((err = i2c_detach_client(client))) {
+		up(&rx8025_lock);
+		return err;
+	}
+
+	list_del(&data->list);
+
+	up(&rx8025_lock);
+	kfree(data);
+	return 0;
+}
+
+static int rx8025_rtc_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int err;
+	struct rtc_time rtctime;
+
+	dev_dbg(&rx8025_rtcclient->dev, "got command %d\n", cmd);
+	switch(cmd) {
+		case RTC_RD_TIME:
+			memset(&rtctime, 0, sizeof(rtctime));
+			if ((err = rx8025_get_rtctime(&rtctime)))
+				return err;
+
+			return copy_to_user((void __user *)arg, &rtctime,
+					sizeof(rtctime)) ? -EFAULT : 0;
+
+		case RTC_SET_TIME:
+			if (!capable(CAP_SYS_TIME))
+				return -EACCES;
+
+			if (copy_from_user(&rtctime, (const void __user *)arg,
+						sizeof(rtctime)))
+				return -EFAULT;
+
+			return rx8025_set_rtctime(&rtctime);
+	}
+	dev_dbg(&rx8025_rtcclient->dev, "unhandled command %d\n", cmd);
+	return -EINVAL;
+}
+
+static int __init rx8025_init(void)
+{
+	return i2c_add_driver(&rx8025_driver);
+}
+
+static void __exit rx8025_exit(void)
+{
+	i2c_del_driver(&rx8025_driver);
+}
+
+MODULE_AUTHOR("Uwe Zeisberger <Uwe_Zeisberger at digi.com>");
+MODULE_DESCRIPTION("RX-8025 SA/NB RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(rx8025_init);
+module_exit(rx8025_exit);
-- 
1.1.6.g5248



