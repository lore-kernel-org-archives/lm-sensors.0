From: Uwe_Zeisberger@digi.com (Uwe Zeisberger)
Date: Wed, 01 Feb 2006 10:23:37 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060201102335.GA8223@digi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

below is a patch adding support for the Epson RX8025 SA/NB RTC module.

There are a few things I'm not sure about:

 - There exists a RTC driver interface in include/asm-arm/rtc.h by
   Russell King.  Should I use it even if it's ARM specific?
   For now I used the ioctl interface directly.

 - Is it correct to name the config symbol SENSORS_RTCRX8025?
   I question because in my eyes an RTC is not a sensor. OTOH the driver
   for the 8564 chip (and serveral others) uses SENSORS_RTC8564.

I'd be happy to get some feedback.

Best regards
Uwe


--- >8 ---

Adds support for the Epson RX8025 SA/NB RTC module.

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger at digi.com>

---

 drivers/i2c/chips/Kconfig  |   10 +
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/rx8025.c |  585 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 596 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/rx8025.c

8a23a3543a33d98c0ee7626f081e1c9538310afa
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index f9fae28..07061c9 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -74,6 +74,16 @@ config SENSORS_RTC8564
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rtc8564.
 
+config SENSORS_RTCRX8025
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
index 46178b5..16a5e51 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
+obj-$(CONFIG_SENSORS_RTCRX8025)	+= rx8025.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
diff --git a/drivers/i2c/chips/rx8025.c b/drivers/i2c/chips/rx8025.c
new file mode 100644
index 0000000..77356a1
--- /dev/null
+++ b/drivers/i2c/chips/rx8025.c
@@ -0,0 +1,585 @@
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
+/* 0x0e is reserved */
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
+static int rx8025_get_rtctime(struct rtc_time *dt)
+{
+	u8 command = RX8025_REG_CTRL1 << 4 | 0x08;
+	u8 result[9] = { 0, };
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
+	if(down_interruptible(&rx8025_lock))
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
+			"rx8025_get_rtctime: read 0x%02x 0x%02x 0x%02x 0x%02x"
+			" 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", result[0],
+			result[1], result[2], result[3], result[4], result[5],
+			result[6], result[7], result[8]);
+
+	/* according to the documention read-only-bits read as 0 */
+#define CHECK_ROBITS(reg, mask)						\
+	if (unlikely(result[2 + (reg)] & ~(mask))) {			\
+		dev_warn(&rx8025_rtcclient->dev,			\
+				"value for " #reg " out of spec: %x\n",	\
+				result[2 + (reg)]);			\
+		result[2 + RX8025_REG_SEC] &= (mask);			\
+	}
+	CHECK_ROBITS(RX8025_REG_SEC, 0x7f);
+	CHECK_ROBITS(RX8025_REG_MIN, 0x7f);
+	CHECK_ROBITS(RX8025_REG_HOUR, 0x3f);
+	CHECK_ROBITS(RX8025_REG_WDAY, 0x07);
+	CHECK_ROBITS(RX8025_REG_MDAY, 0x3f);
+	CHECK_ROBITS(RX8025_REG_MONTH, 0x1f);
+
+	/* I don't have to do more checking, don't I? */
+	dt->tm_sec = BCD2BIN(result[2 + RX8025_REG_SEC]);
+	dt->tm_min = BCD2BIN(result[2 + RX8025_REG_MIN]);
+	if (result[0] | RX8025_BIT_CTRL1_1224)
+		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR]);
+	else
+		dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x1f) % 12
+			+ (result[2 + RX8025_REG_HOUR] & 0x20 ? 12 : 0);
+
+	dt->tm_wday = BCD2BIN(result[2 + RX8025_REG_WDAY]);
+	dt->tm_mday = BCD2BIN(result[2 + RX8025_REG_MDAY]);
+	dt->tm_mon = BCD2BIN(result[2 + RX8025_REG_MONTH]) - 1;
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
+	struct i2c_msg msg = {
+		.len    = 8,
+		.buf    = command,
+	};
+
+	if(down_interruptible(&rx8025_lock))
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
+			"rx8025_set_rtctime: hours out of range: %d\n",
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
+	if (dt->tm_year < 70 || dt->tm_mon >= 170) {
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
+	if (dt->tm_mday > 31 ||
+			((dt->tm_mon = 3 || dt->tm_mon = 5 ||
+			  dt->tm_mon = 8 || dt->tm_mon = 10)
+			 && dt->tm_mday > 30) ||
+			(dt->tm_mon = 1 && dt->tm_mday > 28 +
+			 (dt->tm_year & 3 ? 0 : 1))) {
+		dev_err(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: day out of range (with month=%d, "
+			"year=%d): %d\n", dt->tm_mon, dt->tm_year, dt->tm_mon);
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	if ((ctrl1 = i2c_smbus_read_byte_data(rx8025_rtcclient,
+					RX8025_REG_CTRL1 << 4)) < 0) {
+		dev_err(&rx8025_rtcclient->dev,
+				"rx8025_set_rtctime: failed to read out "
+				"RX8025_REG_CTRL1\n");
+		err = -EINVAL;
+		goto errout_unlock;
+	}
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: ctrl1=0x%x\n", ctrl1);
+	/*
+	 * Here the read-only bits are written as "0".  I'm not sure if that
+	 * is sound.
+	 */
+	command[1 + RX8025_REG_SEC] = BIN2BCD(dt->tm_sec);
+	command[1 + RX8025_REG_MIN] = BIN2BCD(dt->tm_min);
+	if (ctrl1 & RX8025_BIT_CTRL1_1224)
+		command[1 + RX8025_REG_HOUR] = BIN2BCD(dt->tm_hour);
+	else
+		command[1 + RX8025_REG_HOUR] = (dt->tm_hour >= 12 ? 1 << 5 : 0) |
+			BIN2BCD((dt->tm_hour + 11) % 12 + 1);
+
+	command[1 + RX8025_REG_WDAY] = BIN2BCD(dt->tm_wday);
+	command[1 + RX8025_REG_MDAY] = BIN2BCD(dt->tm_mday);
+	command[1 + RX8025_REG_MONTH] = BIN2BCD(dt->tm_mon + 1);
+	command[1 + RX8025_REG_YEAR] = BIN2BCD(dt->tm_year % 100);
+
+	msg.addr = rx8025_rtcclient->addr;
+
+	dev_dbg(&rx8025_rtcclient->dev,
+			"rx8025_set_rtctime: send 0x%02x 0x%02x 0x%02x 0x%02x"
+			" 0x%02x 0x%02x 0x%02x 0x%02x\n", command[0],
+			command[1], command[2], command[3], command[4],
+			command[5], command[6], command[7]);
+
+	if ((err = i2c_transfer(rx8025_rtcclient->adapter, &msg, 1)) < 1) {
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
+static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int err = 0;
+	struct rx8025_data *data;
+	struct i2c_client *new_client;
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
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &rx8025_driver;
+	new_client->flags = 0;
+
+	INIT_LIST_HEAD(&data->list);
+
+	if (kind = 0)
+		kind = rx8025;
+
+	if (kind < 0) {
+		u8 command = RX8025_REG_SEC << 4 | 0x08;
+		u8 result[8] = { 0, };
+		int err;
+
+		struct i2c_msg msg[] = {
+			{
+				.addr	= address,
+				.len	= 1,
+				.buf	= &command,
+			}, {
+				.addr	= address,
+				.flags	= I2C_M_RD,
+				.len	= ARRAY_SIZE(result),
+				.buf	= result,
+			}
+		};
+
+		if ((err = i2c_transfer(adapter, msg, ARRAY_SIZE(msg)))
+				< ARRAY_SIZE(msg)) {
+			err = err >= 0 ? 0 : err;
+			goto errout_free;
+		}
+
+		/* bits 7 of RX8025_REG_MONTH and RX8025_REG_DIGOFF
+		 * "should be set as "0".  Their value when read will be "0""
+		 *
+		 * There are serveral more read-only bits who's "value when
+		 * read is always "0"" according to the spec, but setting them
+		 * yields a "1" sometimes.
+		 */
+		if (((result[RX8025_REG_MONTH] | result[RX8025_REG_DIGOFF])
+					& 0x80)) {
+			dev_dbg(&adapter->dev, "RX8025_REG_MONTH = %x, "
+					"RX8025_REG_DIGOFF = %x\n",
+					result[RX8025_REG_MONTH],
+					result[RX8025_REG_DIGOFF]);
+
+
+			goto errout_free;
+		}
+
+		kind = rx8025;
+	}
+
+	BUG_ON(kind != rx8025);
+
+	strlcpy(new_client->name, "rx8025", I2C_NAME_SIZE);
+
+	if(down_interruptible(&rx8025_lock)) {
+		err = -ERESTARTSYS;
+		goto errout_free;
+	}
+
+	if ((err = i2c_attach_client(new_client)))
+		goto errout_unlock;
+
+	list_add(&data->list, &rx8025_clients);
+
+	if ((err = rx8025_init_client(new_client)))
+		goto errout_detach;
+
+	if (!rx8025_rtcclient) {
+		rx8025_rtcclient = new_client;
+		if ((err = misc_register(&rx8025_rtc_dev))) {
+			rx8025_rtcclient = NULL;
+			printk(KERN_ERR "Failed to register rtc device\n");
+		}
+	}
+	up(&rx8025_lock);
+
+	printk(KERN_INFO "loaded driver for RX-8025 SA/NB on addr %d\n",
+	       address);
+
+	return 0;
+
+errout_detach:
+	rx8025_detach_client(new_client);
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
+	u8 command[3] = { RX8025_REG_CTRL1 << 4 | 0x08, };
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
+	/* Assert 24-hour mode */
+	command[1] |= RX8025_BIT_CTRL1_1224;
+
+	/* disable Alarm D and Alarm W */
+	command[1] &= ~(RX8025_BIT_CTRL1_DALE | RX8025_BIT_CTRL1_WALE);
+
+	if (command[2] & RX8025_BIT_CTRL2_PON)
+		dev_warn(&client->dev, "power-on reset was detected, "
+				"you may have to readjust the clock\n");
+
+	if (command[2] & RX8025_BIT_CTRL2_VDET)
+		dev_warn(&client->dev, "a power voltage drop was detected, "
+				"you may have to readjust the clock\n");
+
+	command[2] &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET);
+
+	command[0] = RX8025_REG_CTRL1 << 4;
+	msg[0].len = ARRAY_SIZE(command);
+
+	if ((err = i2c_transfer(client->adapter, msg, 1)) < 1) {
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
+	if(down_interruptible(&rx8025_lock))
+		return -ERESTARTSYS;
+
+	BUG_ON(list_empty(&rx8025_clients));
+
+	if (rx8025_rtcclient = client) {
+		struct list_head *lh = rx8025_clients.next;
+
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
1.1.6.g8233

-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com

