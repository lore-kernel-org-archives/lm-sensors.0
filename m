From: sr@denx.de (Stefan Roese)
Date: Wed, 23 Nov 2005 16:12:20 +0000
Subject: [lm-sensors] [PATCH] I2C: Add MAX6900 I2C RTC support
Message-Id: <200511231611.05685.sr@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511231317.41695.sr@denx.de>
In-Reply-To: <200511231317.41695.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 23 November 2005 15:54, Stefan Roese wrote:
> Hi Jean,
>
> On Wednesday 23 November 2005 14:45, Jean Delvare wrote:
> > On 2005-11-23, Stefan Roese wrote:
> > > This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.
> >
> > -ENOPATCH
> > Try again with the proper attachement type.
>
> Hmmm. All other mailinglists seem to have no problem with ".patch" as file
> extension. Here another try with ".diff".

Now (hopefully) the last try. This time inline. Hopefully without linewrapping 
in the patch...

Best regards,
Stefan

[PATCH] I2C: Add MAX6900 I2C RTC support

This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 0d044398ada37f988e6cc66e4ba6098496e95e83
tree 208e9a654a95916056a319f45fa0d297580360a9
parent 35a9f654b2fce7fd545afbf497962c3b299838fc
author Stefan Roese <sr@denx.de> Tue, 22 Nov 2005 15:09:54 +0100
committer Stefan Roese <sr@denx.de> Tue, 22 Nov 2005 15:09:54 +0100

 drivers/i2c/chips/Kconfig   |   14 +
 drivers/i2c/chips/Makefile  |    1 
 drivers/i2c/chips/max6900.c |  447 
+++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/max6900.h |   79 ++++++++
 4 files changed, 539 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 09226e4..7ec4f05 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -36,11 +36,21 @@ config SENSORS_EEPROM
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
+config SENSORS_MAX6900
+	tristate "Maxim MAX6900 Real Time Clock"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for Maxim MAX6900
+	  real-time clock chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6900.
+
 config SENSORS_PCF8574
 	tristate "Philips PCF8574 and PCF8574A"
 	depends on I2C && EXPERIMENTAL
 	help
-	  If you say yes here you get support for Philips PCF8574 and 
+	  If you say yes here you get support for Philips PCF8574 and
 	  PCF8574A chips.
 
 	  This driver can also be built as a module.  If so, the module
@@ -91,7 +101,7 @@ config ISP1301_OMAP
 	  USB-On-The-Go transceiver working with the OMAP OTG controller.
 	  The ISP1301 is used in products including H2 and H3 development
 	  boards for Texas Instruments OMAP processors.
-	  
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called isp1301_omap.
 
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index e37835a..b77786d 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
+obj-$(CONFIG_SENSORS_MAX6900)	+= max6900.o
 obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
diff --git a/drivers/i2c/chips/max6900.c b/drivers/i2c/chips/max6900.c
new file mode 100644
index 0000000..f31502e
--- /dev/null
+++ b/drivers/i2c/chips/max6900.c
@@ -0,0 +1,447 @@
+/*
+ * drivers/i2c/chips/max6900.c
+ *
+ * Driver for Maxim MAX6900 RTC
+ *
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ *	Copyright (C) 2002-2004 Stefan Eletzhofer
+ *	Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/rtc.h>		/* get the user-level API */
+#include <linux/init.h>
+#include <linux/list.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+
+#include "max6900.h"
+
+#define DRV_VERSION "1.0"
+
+/*
+ * Internal variables
+ */
+static LIST_HEAD(max6900_clients);
+
+static struct i2c_client *myclient = NULL;
+
+static int debug = 0;
+module_param(debug, int, S_IRUGO | S_IWUSR);
+
+static struct i2c_driver max6900_driver;
+
+/* save/restore old machdep pointers */
+int (*save_set_rtc_time)(unsigned long);
+unsigned long (*save_get_rtc_time)(void);
+
+extern spinlock_t rtc_lock;
+
+static int max6900_read(struct i2c_client *client, unsigned char adr,
+			unsigned char *buf, unsigned char len)
+{
+	int ret = -EIO;
+	unsigned char addr[1] = { adr };
+	struct i2c_msg msgs[2] = {
+		{client->addr, 0, 1, addr},
+		{client->addr, I2C_M_RD, len, buf}
+	};
+
+	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, buf, len);
+
+	if (!buf) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret = 2) {
+		ret = 0;
+	}
+
+done:
+	return ret;
+}
+
+static int max6900_write(struct i2c_client *client, unsigned char adr,
+			 unsigned char *data, unsigned char len)
+{
+	int ret = 0;
+	unsigned char _data[16];
+	struct i2c_msg wr;
+	int i;
+
+	if (!data || len > 15) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	_DBG(1, "client=%p, adr=%d, buf=%p, len=%d", client, adr, data, len);
+
+	_data[0] = adr;
+	for (i = 0; i < len; i++) {
+		_data[i + 1] = data[i];
+		_DBG(5, "data[%d] = 0x%02x (%d)", i, data[i], data[i]);
+	}
+
+	wr.addr = client->addr;
+	wr.flags = 0;
+	wr.len = len + 1;
+	wr.buf = _data;
+
+	ret = i2c_transfer(client->adapter, &wr, 1);
+	if (ret = 1) {
+		ret = 0;
+	}
+
+done:
+	return ret;
+}
+
+static int max6900_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	int ret;
+	struct i2c_client *new_client;
+	struct max6900_data *d;
+	unsigned char val = 0;
+
+	d = kmalloc(sizeof(struct max6900_data), GFP_KERNEL);
+	if (!d) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	memset(d, 0, sizeof(struct max6900_data));
+	INIT_LIST_HEAD(&d->list);
+
+	new_client = &d->client;
+
+	strlcpy(new_client->name, "MAX6900", I2C_NAME_SIZE);
+	i2c_set_clientdata(new_client, d);
+	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
+	new_client->addr = addr;
+	new_client->adapter = adap;
+	new_client->driver = &max6900_driver;
+
+	_DBG(1, "client=%p", new_client);
+
+	/* Verify the chip is really an MAX6900 */
+	max6900_read(new_client, 0x96, &val, 1);
+	if (val != 0x07) {
+		ret = -ENODEV;
+		goto done;
+	}
+
+	ret = i2c_attach_client(new_client);
+
+	/* Add client to local list */
+	list_add(&d->list, &max6900_clients);
+
+	dev_info(&new_client->dev, "chip found, driver version " DRV_VERSION "\n");
+
+done:
+	if (ret) {
+		kfree(d);
+	} else {
+		myclient = new_client;
+	}
+
+	return ret;
+}
+
+static int max6900_probe(struct i2c_adapter *adap)
+{
+	max6900_attach(adap, 0x50, 0);
+	return 0;
+}
+
+static int max6900_detach(struct i2c_client *client)
+{
+	struct max6900_data *data = i2c_get_clientdata(client);
+
+	i2c_detach_client(client);
+	kfree(i2c_get_clientdata(client));
+	list_del(&data->list);
+	return 0;
+}
+
+static int max6900_get_datetime(struct i2c_client *client, struct rtc_time 
*dt)
+{
+	int ret = -EIO;
+	unsigned char sec, sec2, min, hour, mday, wday, mon, cent, year;
+
+	_DBG(1, "client=%p, dt=%p", client, dt);
+
+	if (!dt)
+		return -EINVAL;
+
+	do {
+		ret = max6900_read(client, MAX6900_REG_SEC, &sec, 1);
+		ret |= max6900_read(client, MAX6900_REG_MIN, &min, 1);
+		ret |= max6900_read(client, MAX6900_REG_HOUR, &hour, 1);
+		ret |= max6900_read(client, MAX6900_REG_MDAY, &mday, 1);
+		ret |= max6900_read(client, MAX6900_REG_MON, &mon, 1);
+		ret |= max6900_read(client, MAX6900_REG_WDAY, &wday, 1);
+		ret |= max6900_read(client, MAX6900_REG_YEAR, &year, 1);
+		ret |= max6900_read(client, MAX6900_REG_CENT, &cent, 1);
+		if (ret)
+			return ret;
+
+		/*
+		 * Check for seconds rollover
+		 */
+		ret = max6900_read(client, MAX6900_REG_SEC, &sec2, 1);
+		if ((sec != 59) || (sec2 = sec)){
+			break;
+		}
+	} while (1);
+
+	dt->tm_year = BCD_TO_BIN(year) + BCD_TO_BIN(cent) * 100;
+	dt->tm_mday = BCD_TO_BIN(mday & 0x3f);
+	dt->tm_wday = BCD_TO_BIN(wday & 7);
+	dt->tm_mon = BCD_TO_BIN(mon & 0x1f);
+
+	dt->tm_sec = BCD_TO_BIN(sec & 0x7f);
+	dt->tm_min = BCD_TO_BIN(min & 0x7f);
+	dt->tm_hour = BCD_TO_BIN(hour & 0x3f);
+
+	_DBGRTCTM(2, *dt);
+	return 0;
+}
+
+static int
+max6900_set_datetime(struct i2c_client *client, struct rtc_time *dt, int 
datetoo)
+{
+	int ret;
+	unsigned char val;
+	unsigned char sec, min, hour, mday, wday, mon, cent, year;
+
+	_DBG(1, "client=%p, dt=%p", client, dt);
+
+	if (!dt)
+		return -EINVAL;
+
+	val = 0x00;
+	ret = max6900_write(client, 0x9e, &val, 1);
+
+	/* Clear seconds to ensure no rollover */
+	ret |= max6900_write(client, MAX6900_REG_SEC, &val, 1);
+
+	min = BIN_TO_BCD(dt->tm_min);
+	ret |= max6900_write(client, MAX6900_REG_MIN, &min, 1);
+	hour = BIN_TO_BCD(dt->tm_hour);
+	ret |= max6900_write(client, MAX6900_REG_HOUR, &hour, 1);
+
+	if (datetoo) {
+		mday = BIN_TO_BCD(dt->tm_mday);
+		ret |= max6900_write(client, MAX6900_REG_MDAY, &mday, 1);
+		wday = BIN_TO_BCD(dt->tm_wday);
+		ret |= max6900_write(client, MAX6900_REG_WDAY, &wday, 1);
+		mon = BIN_TO_BCD(dt->tm_mon);
+		ret |= max6900_write(client, MAX6900_REG_MON, &mon, 1);
+		year = BIN_TO_BCD(dt->tm_year % 100);
+		ret |= max6900_write(client, MAX6900_REG_YEAR, &year, 1);
+		cent = BIN_TO_BCD(dt->tm_year / 100);
+		ret |= max6900_write(client, MAX6900_REG_CENT, &cent, 1);
+	}
+
+	sec = BIN_TO_BCD(dt->tm_sec);
+	ret |= max6900_write(client, MAX6900_REG_SEC, &sec, 1);
+
+	if (ret) {
+		_DBG(1, "error writing data! %d", ret);
+	}
+
+	return ret;
+}
+
+static int max6900_get_ctrl(struct i2c_client *client, unsigned int *ctrl)
+{
+	struct max6900_data *data = i2c_get_clientdata(client);
+
+	if (!ctrl)
+		return -1;
+
+	*ctrl = data->ctrl;
+	return 0;
+}
+
+static int max6900_set_ctrl(struct i2c_client *client, unsigned int *ctrl)
+{
+	struct max6900_data *data = i2c_get_clientdata(client);
+	unsigned char buf[2];
+
+	if (!ctrl)
+		return -1;
+
+	buf[0] = *ctrl & 0xff;
+	buf[1] = (*ctrl & 0xff00) >> 8;
+	data->ctrl = *ctrl;
+
+	return max6900_write(client, 0, buf, 2);
+}
+
+static int max6900_read_mem(struct i2c_client *client, struct mem *mem)
+{
+
+	if (!mem)
+		return -EINVAL;
+
+	return max6900_read(client, mem->loc, mem->data, mem->nr);
+}
+
+static int max6900_write_mem(struct i2c_client *client, struct mem *mem)
+{
+
+	if (!mem)
+		return -EINVAL;
+
+	return max6900_write(client, mem->loc, mem->data, mem->nr);
+}
+
+static int
+max6900_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+
+	_DBG(1, "cmd=%d", cmd);
+
+	switch (cmd) {
+	case RTC_GETDATETIME:
+		return max6900_get_datetime(client, arg);
+
+	case RTC_SETTIME:
+		return max6900_set_datetime(client, arg, 0);
+
+	case RTC_SETDATETIME:
+		return max6900_set_datetime(client, arg, 1);
+
+	case RTC_GETCTRL:
+		return max6900_get_ctrl(client, arg);
+
+	case RTC_SETCTRL:
+		return max6900_set_ctrl(client, arg);
+
+	case MEM_READ:
+		return max6900_read_mem(client, arg);
+
+	case MEM_WRITE:
+		return max6900_write_mem(client, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Public API for access to specific device. Useful for low-level
+ * RTC access from kernel code.
+ */
+int max6900_do_command(int bus, int cmd, void *arg)
+{
+	struct list_head *walk;
+	struct list_head *tmp;
+	struct max6900_data *data;
+
+	list_for_each_safe(walk, tmp, &max6900_clients) {
+		data = list_entry(walk, struct max6900_data, list);
+		if (data->client.adapter->nr = bus) {
+			return max6900_command(&data->client, cmd, arg);
+		}
+	}
+
+	return -ENODEV;
+}
+
+/***************************************************************************
+ *
+ * get RTC time:
+ */
+unsigned long max6900_get_rtc_time(void)
+{
+	struct rtc_time tm;
+	int result;
+
+	spin_lock(&rtc_lock);
+	result = max6900_do_command(0, RTC_GETDATETIME, &tm);
+	spin_unlock(&rtc_lock);
+
+	if (result = 0)
+		result = mktime(tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, 
tm.tm_sec);
+
+	return result;
+}
+
+/***************************************************************************
+ *
+ * set RTC time:
+ */
+int max6900_set_rtc_time(unsigned long now)
+{
+        struct rtc_time tm;
+        unsigned char century, year, mon, wday, mday, hour, min, sec;
+
+        to_tm (now, &tm);
+
+        _DBG (2, "Set RTC [dec] year=%d mon=%d day=%d hour=%d min=%d 
sec=%d\n",
+                tm.tm_year, tm.tm_mon, tm.tm_mday,
+                tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+        century = (tm.tm_year >= 2000) ? 0x80 : 0;
+        year = BIN_TO_BCD (tm.tm_year % 100);
+        mon  = BIN_TO_BCD (tm.tm_mon) | century;
+        wday = BIN_TO_BCD (tm.tm_wday);
+        mday = BIN_TO_BCD (tm.tm_mday);
+        hour = BIN_TO_BCD (tm.tm_hour);
+        min  = BIN_TO_BCD (tm.tm_min);
+        sec  = BIN_TO_BCD (tm.tm_sec);
+
+        _DBG (2, "Set RTC [bcd] year=%X mon=%X day=%X "
+                "hour=%X min=%X sec=%X wday=%X\n",
+                year, mon, mday, hour, min, sec, wday);
+
+	max6900_set_datetime(myclient, &tm, 1);
+
+        return (0);
+}
+
+static struct i2c_driver max6900_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "MAX6900",
+	.id		= I2C_DRIVERID_MAX6900,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = max6900_probe,
+	.detach_client	= max6900_detach,
+	.command	= max6900_command
+};
+
+static __init int max6900_init(void)
+{
+	return i2c_add_driver(&max6900_driver);
+}
+
+static __exit void max6900_exit(void)
+{
+        ppc_md.set_rtc_time = save_set_rtc_time;
+        ppc_md.get_rtc_time = save_get_rtc_time;
+
+	i2c_del_driver(&max6900_driver);
+}
+
+MODULE_AUTHOR("Stefan Roese <sr@denx.de>");
+MODULE_DESCRIPTION("Maxim/Dallas MAX6900 RTC I2C Client Driver");
+MODULE_LICENSE("GPL");
+
+module_init(max6900_init);
+module_exit(max6900_exit);
diff --git a/drivers/i2c/chips/max6900.h b/drivers/i2c/chips/max6900.h
new file mode 100644
index 0000000..0b852c8
--- /dev/null
+++ b/drivers/i2c/chips/max6900.h
@@ -0,0 +1,79 @@
+/*
+ * drivers/i2c/chips/max6900.h
+ *
+ * Driver for Maxim MAX6900 RTC
+ *
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ *	Copyright (C) 2002-2004 Stefan Eletzhofer
+ *	Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+struct rtc_tm {
+	unsigned char	secs;
+	unsigned char	mins;
+	unsigned char	hours;
+	unsigned char	mday;
+	unsigned char	mon;
+	unsigned short	year; /* xxxx 4 digits :) */
+	unsigned char	wday;
+	unsigned char	vl;
+};
+
+struct mem {
+	unsigned int	loc;
+	unsigned int	nr;
+	unsigned char	*data;
+};
+
+#define RTC_GETDATETIME	0
+#define RTC_SETTIME	1
+#define RTC_SETDATETIME	2
+#define RTC_GETCTRL	3
+#define RTC_SETCTRL	4
+#define MEM_READ	5
+#define MEM_WRITE	6
+
+/* Device registers */
+#define MAX6900_REG_SEC		0x80
+#define MAX6900_REG_MIN		0x82
+#define MAX6900_REG_HOUR	0x84
+#define MAX6900_REG_MDAY	0x86
+#define MAX6900_REG_MON		0x88
+#define MAX6900_REG_WDAY	0x8a
+#define MAX6900_REG_YEAR	0x8c
+#define MAX6900_REG_CENT	0x92
+
+#define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock */
+
+#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
+#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
+
+#ifdef DEBUG
+# define _DBG(x, fmt, args...) do{ if (debug>=x) printk(KERN_DEBUG"%s: " fmt 
"\n", __FUNCTION__, ##args); } while(0);
+#else
+# define _DBG(x, fmt, args...) do { } while(0);
+#endif
+
+#define _DBGRTCTM(x, rtctm) if (debug>x) printk("%s: secs=%d, mins=%d, 
hours=%d, mday=%d, " \
+			"mon=%d, year=%d, wday=%d\n", __FUNCTION__, \
+			(rtctm).tm_sec, (rtctm).tm_min, (rtctm).tm_hour, (rtctm).tm_mday, \
+			(rtctm).tm_mon, (rtctm).tm_year, (rtctm).tm_wday);
+
+struct max6900_data {
+	struct i2c_client client;
+	struct list_head list;
+	u16 ctrl;
+};
+
+static int max6900_read_mem(struct i2c_client *client, struct mem *mem);
+static int max6900_write_mem(struct i2c_client *client, struct mem *mem);
+unsigned long max6900_get_rtc_time(void);
+int max6900_set_rtc_time(unsigned long now);


 
!-------------------------------------------------------------flip-


