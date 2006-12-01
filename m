From: fengjh@rising.com.cn (Paul)
Date: Fri, 01 Dec 2006 04:42:04 +0000
Subject: [lm-sensors] New Rx8025 RTC driver
Message-Id: <000701c71503$0ef32750$4450a8c0@003355>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a driver patch for Epson RX8025 SA/NB RTC module.
It based on Uwe's patch http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015172.html,and used new rtc class,It has tested on kernel 2.6.17.11.


Index: linux/drivers/rtc/rtc-rx8025.c
=================================--- linux/drivers/rtc/rtc-rx8025.c 
+++ linux/drivers/rtc/rtc-rx8025.c 
@@ -0,0 +1,560 @@
+/*
+ * drivers/rtc/rtc-rx8025.c
+ *
+ * Driver for Epson's RTC module RX-8025 SA/NB
+ *
+ * Copyright (C) 2005 by Digi International Inc.
+ * All rights reserved.
+ *
+ * Modify by fengjh at rising.com.cn
+ * 2006.11
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
+#define RX8025_REG_SEC  0x00
+#define RX8025_REG_MIN  0x01
+#define RX8025_REG_HOUR  0x02
+#define RX8025_REG_WDAY  0x03
+#define RX8025_REG_MDAY  0x04
+#define RX8025_REG_MONTH 0x05
+#define RX8025_REG_YEAR  0x06
+#define RX8025_REG_DIGOFF 0x07
+#define RX8025_REG_ALWMIN 0x08
+#define RX8025_REG_ALWHOUR 0x09
+#define RX8025_REG_ALWWDAY 0x0a
+#define RX8025_REG_ALDMIN 0x0b
+#define RX8025_REG_ALDHOUR 0x0c
+/* 0x0d is reserved */
+#define RX8025_REG_CTRL1 0x0e
+#define RX8025_REG_CTRL2 0x0f
+
+#define RX8025_BIT_CTRL1_1224 (1 << 5)
+#define RX8025_BIT_CTRL1_DALE (1 << 6)
+#define RX8025_BIT_CTRL1_WALE (1 << 7)
+
+#define RX8025_BIT_CTRL2_PON (1 << 4)
+#define RX8025_BIT_CTRL2_VDET (1 << 6)
+
+static unsigned short normal_i2c[] = { 0x32, I2C_CLIENT_END };
+I2C_CLIENT_INSMOD_1(rx8025);
+
+static int rx8025_attach_adapter(struct i2c_adapter *adapter);
+static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind);
+static int rx8025_init_client(struct i2c_client *client);
+static int rx8025_detach_client(struct i2c_client *client);
+static struct i2c_driver rx8025_driver = {
+ .driver = {
+  .name = "rx8025",
+  .owner = THIS_MODULE,
+ },
+ .attach_adapter = &rx8025_attach_adapter,
+ .detach_client = &rx8025_detach_client,
+};
+
+static struct i2c_client *rx8025_rtcclient = NULL;
+static int rx8025_get_rtctime(struct device *dev,struct rtc_time *dt);
+static int rx8025_set_rtctime(struct device *dev,struct rtc_time *dt);
+static struct rtc_class_ops rx8025_rtc_ops = {
+ .read_time   = rx8025_get_rtctime,
+ .set_time   = rx8025_set_rtctime,
+};
+struct rx8025_data {
+ struct i2c_client client;
+ struct list_head list;
+ struct rtc_device *rtc;
+};
+
+static LIST_HEAD(rx8025_clients);
+static DECLARE_MUTEX(rx8025_lock);
+
+static const unsigned char days_in_mo[] + { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
+static int rx8025_get_rtctime(struct device *dev,struct rtc_time *dt)
+{
+ u8 command = (RX8025_REG_CTRL1 << 4) | 0x08;
+ u8 result[9];
+ int i, err;
+
+ struct i2c_msg msg[] = {
+  {
+   .len = 1,
+   .buf = &command,
+  }, {
+   .flags = I2C_M_RD,
+   .len = ARRAY_SIZE(result),
+   .buf = result,
+  }
+ };
+
+ if (down_interruptible(&rx8025_lock))
+  return -ERESTARTSYS;
+
+ if (!rx8025_rtcclient) {
+  err = -EIO;
+  goto errout_unlock;
+ }
+
+ if (!dt) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_get_rtctime: passed in dt = NULL\n");
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ for (i = 0; i < ARRAY_SIZE(msg); ++i)
+  msg[i].addr = rx8025_rtcclient->addr;
+
+ if ((err = i2c_transfer(rx8025_rtcclient->adapter, msg, 2)) < 2) {
+  err = err >= 0 ? -EIO : err;
+  goto errout_unlock;
+ }
+
+ up(&rx8025_lock);
+
+ dev_dbg(&rx8025_rtcclient->dev,
+   "rx8025_get_rtctime: read 0x%02x 0x%02x 0x%02x 0x%02x "
+   "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", result[0],
+   result[1], result[2], result[3], result[4], result[5],
+   result[6], result[7], result[8]);
+
+ dt->tm_sec = BCD2BIN(result[2 + RX8025_REG_SEC] & 0x7f);
+ dt->tm_min = BCD2BIN(result[2 + RX8025_REG_MIN] & 0x7f);
+ if (result[0] | RX8025_BIT_CTRL1_1224)
+  dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x3f);
+ else
+  dt->tm_hour = BCD2BIN(result[2 + RX8025_REG_HOUR] & 0x1f) % 12
+   + (result[2 + RX8025_REG_HOUR] & 0x20 ? 12 : 0);
+
+ dt->tm_wday = BCD2BIN(result[2 + RX8025_REG_WDAY] & 0x07);
+ dt->tm_mday = BCD2BIN(result[2 + RX8025_REG_MDAY] & 0x3f);
+ dt->tm_mon = BCD2BIN(result[2 + RX8025_REG_MONTH] & 0x1f) - 1;
+ dt->tm_year = BCD2BIN(result[2 + RX8025_REG_YEAR]);
+
+ if (dt->tm_year < 70)
+  dt->tm_year += 100;
+
+ dev_dbg(&rx8025_rtcclient->dev,
+   "rx8025_get_rtctime: "
+   "result: %ds %dm %dh %dwd %dmd %dm %dy\n",
+   dt->tm_sec, dt->tm_min, dt->tm_hour, dt->tm_wday,
+   dt->tm_mday, dt->tm_mon, dt->tm_year);
+
+ return 0;
+
+errout_unlock:
+ up(&rx8025_lock);
+ return err;
+}
+static int rx8025_set_rtctime(struct device *dev,struct rtc_time *dt)
+{
+ u8 command[8] = { RX8025_REG_SEC << 4, };
+ int err;
+ s32 ctrl1;
+
+ if (down_interruptible(&rx8025_lock))
+  return -ERESTARTSYS;
+
+ if (!rx8025_rtcclient) {
+  err = -EIO;
+  goto errout_unlock;
+ }
+
+ if (!dt) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: passed in dt = NULL\n");
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_sec < 0 || dt->tm_sec >= 60) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: seconds out of range: %d\n",
+   dt->tm_sec);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_min < 0 || dt->tm_min >= 60) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: minutes out of range: %d\n",
+   dt->tm_min);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_hour < 0 || dt->tm_hour >= 24) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: hours out of range: %d\n",
+   dt->tm_hour);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_wday < 0 || dt->tm_wday >= 7) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: week day out of range: %d\n",
+   dt->tm_wday);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_mon < 0 || dt->tm_mon >= 12) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: month out of range: %d\n",
+   dt->tm_mon);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if (dt->tm_year < 70 || dt->tm_year >= 170) {
+  dev_err(&rx8025_rtcclient->dev,
+   "rx8025_set_rtctime: year out of range: %d\n",
+   dt->tm_year);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ /*
+  * BUG: The HW assumes every year that is a multiple of 4 to be a leap
+  * year.  Next time this is wrong is 2100, which will not be a leap
+  * year.
+  */
+ if (dt->tm_mday > days_in_mo[dt->tm_mon] +
+   (!(dt->tm_year & 3) && (dt->tm_mon = 1))) {
+  dev_err(&rx8025_rtcclient->dev,
+   "%s: day out of range (with month=%d, year=%d): %d\n",
+   __FUNCTION__, dt->tm_mon, dt->tm_year, dt->tm_mday);
+  err = -EINVAL;
+  goto errout_unlock;
+ }
+
+ if ((ctrl1 = i2c_smbus_read_byte_data(rx8025_rtcclient,
+     RX8025_REG_CTRL1 << 4)) < 0) {
+  dev_err(&rx8025_rtcclient->dev,
+    "%s: failed to read out RX8025_REG_CTRL1\n",
+    __FUNCTION__);
+  err = -EIO;
+  goto errout_unlock;
+ }
+
+ dev_dbg(&rx8025_rtcclient->dev,
+   "%s: ctrl1=0x%x\n", __FUNCTION__, ctrl1);
+ /*
+  * Here the read-only bits are written as "0".  I'm not sure if that
+  * is sound.
+  */
+ command[1 + RX8025_REG_SEC] = BIN2BCD(dt->tm_sec);
+ command[1 + RX8025_REG_MIN] = BIN2BCD(dt->tm_min);
+ if (ctrl1 & RX8025_BIT_CTRL1_1224)
+  command[1 + RX8025_REG_HOUR] = BIN2BCD(dt->tm_hour);
+ else
+  command[1 + RX8025_REG_HOUR] = (dt->tm_hour >= 12 ? 0x20 : 0) |
+   BIN2BCD((dt->tm_hour + 11) % 12 + 1);
+
+ command[1 + RX8025_REG_WDAY] = BIN2BCD(dt->tm_wday);
+ command[1 + RX8025_REG_MDAY] = BIN2BCD(dt->tm_mday);
+ command[1 + RX8025_REG_MONTH] = BIN2BCD(dt->tm_mon + 1);
+ command[1 + RX8025_REG_YEAR] = BIN2BCD(dt->tm_year % 100);
+
+ dev_dbg(&rx8025_rtcclient->dev,
+   "%s: send 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
+   "0x%02x 0x%02x\n", __FUNCTION__, command[0],
+   command[1], command[2], command[3], command[4],
+   command[5], command[6], command[7]);
+
+ if ((err = i2c_master_send(rx8025_rtcclient, command, 8) < 8)) {
+  err = err >= 0 ? -EIO : err;
+  goto errout_unlock;
+ }
+
+ up(&rx8025_lock);
+
+ return 0;
+
+errout_unlock:
+ up(&rx8025_lock);
+ return err;
+}
+
+static int rx8025_attach_adapter(struct i2c_adapter *adapter)
+{
+ return i2c_probe(adapter, &addr_data, &rx8025_detect);
+}
+
+struct rx8025_limits {
+ u8 reg;
+ u8 mask;
+ u8 min;
+ u8 max;
+};
+
+static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+ int err = 0;
+ struct rx8025_data *data;
+ struct i2c_client *client;
+
+ if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+  dev_err(&adapter->dev, "doesn't support full I2C\n");
+  goto errout;
+ }
+
+ if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
+  dev_err(&adapter->dev, "failed to alloc memory\n");
+  err = -ENOMEM;
+  goto errout;
+ }
+
+ client = &data->client;
+ i2c_set_clientdata(client, data);
+ client->addr = address;
+ client->adapter = adapter;
+ client->driver = &rx8025_driver;
+
+ INIT_LIST_HEAD(&data->list);
+
+ if (kind = 0)
+  kind = rx8025;
+
+ if (kind < 0) {
+  u8 command = 0x08;
+  u8 res[RX8025_REG_YEAR + 1];
+  int i, err;
+
+  struct i2c_msg msg[] = {
+   {
+    .addr = address,
+    .len = 1,
+    .buf = &command,
+   }, {
+    .addr = address,
+    .flags = I2C_M_RD,
+    .len = ARRAY_SIZE(res),
+    .buf = res,
+   }
+  };
+
+  static const struct rx8025_limits limits[] = {
+   {
+    .reg = RX8025_REG_SEC,
+    .mask = 0x7f,
+    .min = 0,
+    .max = 59,
+   }, {
+    .reg = RX8025_REG_MIN,
+    .mask = 0x7f,
+    .min = 0,
+    .max = 59,
+   }, {
+    .reg = RX8025_REG_HOUR,
+    .mask = 0x3f,
+    .min = 0,
+    .max = 32,
+   }, {
+    .reg = RX8025_REG_WDAY,
+    .mask = 0x7f,
+    .min = 0,
+    .max = 6,
+   }, {
+    .reg = RX8025_REG_MDAY,
+    .mask = 0x3f,
+    .min = 1,
+    .max = 31,
+   }, {
+    .reg    = RX8025_REG_MONTH,
+    .mask = 0x1f,
+    .min = 1,
+    .max = 12,
+   }, {
+    .reg = RX8025_REG_YEAR,
+    .mask = 0xff,
+    .min = 0,
+    .max = 99,
+   }
+  };
+
+  if ((err = i2c_transfer(adapter, msg, ARRAY_SIZE(msg)))
+    < ARRAY_SIZE(msg)) {
+   err = err >= 0 ? 0 : err;
+   goto errout_free;
+  }
+
+  for (i = 0; i < ARRAY_SIZE(limits); ++i) {
+   u8 value;
+
+   if ((res[limits[i].reg] & ~limits[i].mask) ||
+     (limits[i].mask > 0x0f &&
+      (res[limits[i].reg] & 0x0f) > 9) ||
+     ((value = BCD2BIN(res[limits[i].reg]))
+      < limits[i].min) ||
+      value > limits[i].max) {
+    dev_dbg(&adapter->dev, "%s: register=0x%02x, "
+      "value=0x%02x\n", __FUNCTION__,
+      limits[i].reg,
+      res[limits[i].reg]);
+    err = -ENODEV;
+    goto errout_unlock;
+   }
+  }
+
+  kind = rx8025;
+ }
+
+ BUG_ON(kind != rx8025);
+
+ strlcpy(client->name, "rx8025", I2C_NAME_SIZE);
+
+ if (down_interruptible(&rx8025_lock)) {
+  err = -ERESTARTSYS;
+  goto errout_free;
+ }
+
+ if ((err = i2c_attach_client(client)))
+  goto errout_unlock;
+
+ list_add(&data->list, &rx8025_clients);
+
+ if ((err = rx8025_init_client(client)))
+  goto errout_detach;
+
+ if (!rx8025_rtcclient) {
+  rx8025_rtcclient = client;
+  data->rtc = rtc_device_register(client->name, &client->dev,
+    &rx8025_rtc_ops, THIS_MODULE);
+  if (IS_ERR(data->rtc)) {
+   rx8025_rtcclient = NULL;
+   dev_err(&client->dev,
+     "Failed to register rtc device\n");
+  }
+ }
+ up(&rx8025_lock);
+
+ dev_info(&client->dev, "chip found\n");
+
+ return 0;
+
+errout_detach:
+ rx8025_detach_client(client);
+
+errout_unlock:
+ up(&rx8025_lock);
+
+errout_free:
+ kfree(data);
+
+errout:
+ dev_err(&adapter->dev, "Failed to detect rx8025\n");
+ return err;
+}
+
+static int rx8025_init_client(struct i2c_client *client)
+{
+ u8 command[2] = { RX8025_REG_CTRL2 << 4 | 0x08, };
+ int err;
+
+ struct i2c_msg msg[] = {
+  {
+   .addr = client->addr,
+   .len = 1,
+   .buf = command,
+  }, {
+   .addr = client->addr,
+   .flags = I2C_M_RD,
+   .len = ARRAY_SIZE(command) - 1,
+   .buf = command + 1,
+  }
+ };
+
+ if ((err = i2c_transfer(client->adapter, msg, 2)) < 2) {
+  err = err >= 0 ? -EIO : err;
+  goto errout;
+ }
+
+ if (command[1] & RX8025_BIT_CTRL2_PON)
+  dev_warn(&client->dev, "power-on reset was detected, "
+    "you may have to readjust the clock\n");
+
+ if (command[1] & RX8025_BIT_CTRL2_VDET)
+  dev_warn(&client->dev, "a power voltage drop was detected, "
+    "you may have to readjust the clock\n");
+
+ command[1] &= ~(RX8025_BIT_CTRL2_PON | RX8025_BIT_CTRL2_VDET);
+
+ command[0] = RX8025_REG_CTRL2 << 4;
+
+ if ((err = i2c_master_send(client, command, 2)) < 2) {
+  err = err >= 0 ? -EIO : err;
+  goto errout;
+ }
+
+ return 0;
+
+errout:
+ return err;
+}
+
+static int rx8025_detach_client(struct i2c_client *client)
+{
+ int err;
+ struct rx8025_data *data = i2c_get_clientdata(client);
+
+ if (down_interruptible(&rx8025_lock))
+  return -ERESTARTSYS;
+
+ BUG_ON(list_empty(&rx8025_clients));
+
+ if (rx8025_rtcclient = client) {
+  struct list_head *lh = rx8025_clients.next;
+
+  if (list_entry(lh, struct rx8025_data, list) = data)
+   lh = lh->next;
+
+  if (lh = &rx8025_clients) {
+   rtc_device_unregister(data->rtc);
+   rx8025_rtcclient = NULL;
+  } else
+   rx8025_rtcclient = &data->client;
+ }
+
+ if ((err = i2c_detach_client(client))) {
+  up(&rx8025_lock);
+  return err;
+ }
+
+ list_del(&data->list);
+
+ up(&rx8025_lock);
+ kfree(data);
+ return 0;
+}
+static int __init rx8025_init(void)
+{
+ return i2c_add_driver(&rx8025_driver);
+}
+
+static void __exit rx8025_exit(void)
+{
+ i2c_del_driver(&rx8025_driver);
+}
+
+MODULE_AUTHOR("Uwe Zeisberger <Uwe_Zeisberger <at> digi.com> and modify by fengjh at rising.com.cn");
+MODULE_DESCRIPTION("RX-8025 SA/NB RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(rx8025_init);
+module_exit(rx8025_exit);

Best regards

Paul Von
2006.12.1
