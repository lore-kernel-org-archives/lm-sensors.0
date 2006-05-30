From: kim.Mostrup@sagemdenmark.com (kim.Mostrup@sagemdenmark.com)
Date: Tue, 30 May 2006 14:31:36 +0000
Subject: [lm-sensors] [PATCH] Linux 2.6.16 driver for I2C based Philips
Message-Id: <OF4C991ACF.DE368C38-ONC125717E.004ED613-C125717E.004FCC3D@sagemdenmark.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the I2C based Philips pcf8563 RTC. It 
basically attaches to the I2C bus and registers a RTC device which can be 
accessed from userspace with hwclock.

It is tested on an AT91RM9200 target but the patch can be applied cleanly 
to a 2.6.16 vanilla kernel. 

I hope I submitted to the right place:)

Comments welcome.

BR
kim

diff -uprN -X linux-2.6.16.org/Documentation/dontdiff 
linux-2.6.16.org/drivers/i2c/chips/Kconfig 
linux-2.6.16/drivers/i2c/chips/Kconfig
--- linux-2.6.16.org/drivers/i2c/chips/Kconfig  2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16/drivers/i2c/chips/Kconfig      2006-05-30 
16:04:12.000000000 +0200
@@ -74,6 +74,15 @@ config SENSORS_RTC8564
          This driver can also be built as a module.  If so, the module
          will be called i2c-rtc8564.
 
+config SENSORS_PCF8563
+       tristate "Philips 8563 RTC chip"
+       depends on I2C && EXPERIMENTAL
+       help
+         If you say yes here you get support for the Philips 8563 RTC 
chip.
+
+         This driver can also be built as a module.  If so, the module
+         will be called i2c-pcf8563.
+
 config ISP1301_OMAP
        tristate "Philips ISP1301 with OMAP OTG"
        depends on I2C && ARCH_OMAP_OTG
diff -uprN -X linux-2.6.16.org/Documentation/dontdiff 
linux-2.6.16.org/drivers/i2c/chips/Makefile 
linux-2.6.16/drivers/i2c/chips/Makefile
--- linux-2.6.16.org/drivers/i2c/chips/Makefile 2006-03-20 
06:53:29.000000000 +0100
+++ linux-2.6.16/drivers/i2c/chips/Makefile     2006-05-30 
16:04:12.000000000 +0200
@@ -14,6 +14,8 @@ obj-$(CONFIG_SENSORS_RTC8564) += rtc8564
 obj-$(CONFIG_ISP1301_OMAP)     += isp1301_omap.o
 obj-$(CONFIG_TPS65010)         += tps65010.o
 obj-$(CONFIG_RTC_X1205_I2C)    += x1205.o
+obj-$(CONFIG_SENSORS_PCF8563)  += pcf8563.o
+
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff -uprN -X linux-2.6.16.org/Documentation/dontdiff 
linux-2.6.16.org/drivers/i2c/chips/pcf8563.c 
linux-2.6.16/drivers/i2c/chips/pcf8563.c
--- linux-2.6.16.org/drivers/i2c/chips/pcf8563.c        1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.16/drivers/i2c/chips/pcf8563.c    2006-05-30 
16:04:12.000000000 +0200
@@ -0,0 +1,370 @@
+/*
+ *  linux/drivers/i2c/chips/pcf8563.c
+ *  Driver for Philips pcf8564 RTC chip
+ *
+ *  2006 Kim Mostrup, Sagem Denmark
+ *
+ *  based on linux/drivers/i2c/chips/rtc8564.c
+ *  Copyright (C) 2002-2004 Stefan Eletzhofer
+ *
+ *  based on linux/drivers/char/at91_rtc.c
+ *  Copyright (C) 2002 Rick Bronson
+ *
+ *  based on linux/arch/cris/arch-v32/drivers/pcf8563.c
+ *  Copyright (c) 2002-2003, Axis Communications AB
+ *  Author: Tobias Anderberg <tobiasa at axis.com>.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/time.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/string.h>
+#include <linux/ioctl.h>
+#include <asm/rtc.h>
+
+
+/************************************************************
+ RTC Interface
+*************************************************************/
+#define PCF8563_REG_CTRL1 0x00
+#define PCF8563_REG_CTRL2 0x01
+#define PCF8563_REG_SEC   0x02
+#define PCF8563_REG_MIN   0x03
+#define PCF8563_REG_HOUR  0x04
+#define PCF8563_REG_MDAY  0x05
+#define PCF8563_REG_WDAY  0x06
+#define PCF8563_REG_MON   0x07
+#define PCF8563_REG_YEAR  0x08
+
+static int pcf8563_rtc_ioctl(unsigned int cmd, unsigned long arg);
+static int pcf8563_rtc_readtime(struct rtc_time *tm);
+static int pcf8563_rtc_settime(struct rtc_time *tm);
+static int pcf8563_rtc_read_proc(char *buf);
+
+static struct rtc_ops rtc_ops = {
+       .owner          = THIS_MODULE,
+        .ioctl         = pcf8563_rtc_ioctl,
+       .read_time      = pcf8563_rtc_readtime,
+       .set_time        = pcf8563_rtc_settime,
+  //   .read_alarm     = pcf8563_rtc_readalarm, // Not implemented
+  //   .set_alarm      = pcf8563_rtc_setalarm,  // Not implemented
+       .proc           = pcf8563_rtc_read_proc,
+};
+
+struct pcf8563_data {
+       struct i2c_client client;
+       u16 ctrl;
+};
+static struct pcf8563_data *pcf8563_data;
+static struct i2c_client   *client;
+
+static const unsigned char days_in_month[] +       { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
+
+/*
+ * Handle commands from user-space
+ */
+static int pcf8563_rtc_ioctl(unsigned int cmd, unsigned long arg)
+{
+       pr_debug(KERN_DEBUG "%s(): cmd=%08x, arg=%08lx not 
implemented.\n", __FUNCTION__, cmd, arg);
+        return 0;
+}
+
+/*
+ * Read current time and date in RTC
+ */
+static int pcf8563_rtc_readtime(struct rtc_time *tm)
+{
+       int ret = -EIO;
+        unsigned char buf[15];
+        unsigned char waddr = 0;
+        int century;
+       struct i2c_msg msgs[2] = {
+          {client->addr, 0       , 1,  &waddr},
+          {client->addr, I2C_M_RD, 15, buf}
+       };
+
+        pr_debug(KERN_DEBUG "%s(): \n", __FUNCTION__);
+ 
+       ret = i2c_transfer(client->adapter, msgs, 2);
+       if (ret != 2) {
+          goto done;
+       }
+        ret = 0;
+ 
+        century =   (buf[PCF8563_REG_MON]  & 0x80); 
+        /* Always zero bits are read as ones, so we need to AND */
+        buf[PCF8563_REG_SEC]  &= 0x7F; 
+        buf[PCF8563_REG_MIN]  &= 0x7F; 
+        buf[PCF8563_REG_HOUR] &= 0x3F; 
+        buf[PCF8563_REG_MDAY] &= 0x3F; 
+        buf[PCF8563_REG_WDAY] &= 0x07;
+        buf[PCF8563_REG_MON]  &= 0x1F; 
+        pr_debug("%s(): %02x-%02x %02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
+                 __FUNCTION__,
+                 buf[PCF8563_REG_CTRL1],
+                 buf[PCF8563_REG_CTRL2],
+                 buf[PCF8563_REG_SEC],
+                 buf[PCF8563_REG_MIN],
+                 buf[PCF8563_REG_HOUR],
+                 buf[PCF8563_REG_MDAY],
+                 buf[PCF8563_REG_WDAY],
+                 buf[PCF8563_REG_MON],
+                 buf[PCF8563_REG_YEAR]);
+ 
+       tm->tm_sec   = BCD_TO_BIN(buf[PCF8563_REG_SEC]);
+        tm->tm_min   = BCD_TO_BIN(buf[PCF8563_REG_MIN]);
+       tm->tm_hour  = BCD_TO_BIN(buf[PCF8563_REG_HOUR]);
+       tm->tm_mday  = BCD_TO_BIN(buf[PCF8563_REG_MDAY]);
+       tm->tm_wday  = buf[PCF8563_REG_WDAY]; /* Not coded in BCD. */
+       tm->tm_mon   = BCD_TO_BIN(buf[PCF8563_REG_MON]);
+       tm->tm_year  = BCD_TO_BIN(buf[PCF8563_REG_YEAR]) + (century ? 0 : 
100);
+       tm->tm_mon--;  /* Month is 1..12 in RTC but 0..11 in linux */
+
+       pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __FUNCTION__,
+                 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday, 
tm->tm_hour, 
+                 tm->tm_min, tm->tm_sec);
+
+ done:
+        return ret;
+}
+
+
+/*
+ * Set current time and date in RTC
+ */
+static int pcf8563_rtc_settime(struct rtc_time *tm)
+{
+        int ret;
+       int leap;
+        int year;
+        int mon;
+        int century;
+        unsigned char buffer[11];
+        unsigned char *buf = buffer+1;
+       struct i2c_msg  wr = 
+          { .addr  = client->addr,
+            .flags = 0,
+            .len   = 10,
+            .buf   = buffer,
+          };
+
+        buffer[0] = 0;                /* RTC word addr */
+
+       pr_debug("%s(): %4d-%02d-%02d %02d:%02d:%02d %d\n",
+                 __FUNCTION__,
+                 1900 + tm->tm_year, tm->tm_mon, tm->tm_mday, 
tm->tm_hour, tm->tm_min, tm->tm_sec, tm->tm_wday);
+
+        /* Convert from struct tm to struct rtc_time. */
+        year = tm->tm_year + 1900;
+        mon  = tm->tm_mon + 1;
+
+        /*
+         * Check if tm.tm_year is a leap year. A year is a leap
+         * year if it is divisible by 4 but not 100, except
+         * that years divisible by 400 _are_ leap years.
+         */
+        leap = (mon = 2) && ((year % 4 = 0 && year % 100 != 0) || year 
% 400 = 0);
+
+        /* Perform some sanity checks. */
+        if ((year < 1970) ||
+            (mon > 12) ||
+            (tm->tm_mday = 0) ||
+            (tm->tm_mday > days_in_month[mon] + leap) ||
+            (tm->tm_wday >= 7) ||
+            (tm->tm_hour >= 24) ||
+            (tm->tm_min >= 60) ||
+            (tm->tm_sec >= 60))
+          return -EINVAL;
+
+       century = (year <= 2000) ? 0x80 : 0;
+        buf[PCF8563_REG_CTRL1] = 0;
+        buf[PCF8563_REG_CTRL2] = 0;
+       buf[PCF8563_REG_SEC]   = BIN2BCD(tm->tm_sec);
+       buf[PCF8563_REG_MIN]   = BIN2BCD(tm->tm_min);
+       buf[PCF8563_REG_HOUR]  = BIN2BCD(tm->tm_hour);
+        buf[PCF8563_REG_MDAY]  = BIN2BCD(tm->tm_mday);
+        buf[PCF8563_REG_WDAY]  = (tm->tm_wday);
+        buf[PCF8563_REG_MON]   = BIN2BCD(mon) |century;
+        buf[PCF8563_REG_YEAR]  = BIN2BCD(year%100);
+       pr_debug("%s(): %02x-%02x %02x:%02x:%02x:%02x:%02x:%02x:%02x\n", 
__FUNCTION__,
+           buf[PCF8563_REG_CTRL1],
+                 buf[PCF8563_REG_CTRL2],
+                 buf[PCF8563_REG_SEC],
+                 buf[PCF8563_REG_MIN],
+                 buf[PCF8563_REG_HOUR],
+                 buf[PCF8563_REG_MDAY],
+                 buf[PCF8563_REG_WDAY],
+                 buf[PCF8563_REG_MON],
+                 buf[PCF8563_REG_YEAR]);
+ 
+        /* Write to RTC */
+        /* write sequence: addr+r/w, word addr, ctrl1, ... year. */
+       ret = i2c_transfer(client->adapter, &wr, 1);
+       if (ret = 1) {
+          ret = 0;
+       }
+
+        return ret;
+}
+
+
+/*
+ * Provide additional RTC information in /proc/driver/rtc
+ */
+static int pcf8563_rtc_read_proc(char *buf)
+{
+       char *p = buf;
+
+  //   p += sprintf(p, "Testing\n");
+       return p - buf;
+}
+
+
+/************************************************************
+ I2C interface
+ *************************************************************/
+#define I2C_ID_PCF8563 0xFF01
+
+static int pcf8563_probe(struct i2c_adapter *adap);
+static int pcf8563_attach(struct i2c_adapter *adap, int addr, int kind);
+static int pcf8563_detach(struct i2c_client *client);
+
+static unsigned short ignore[] =      { I2C_CLIENT_END };
+static unsigned short normal_addr[] = { 0x51, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+       .normal_i2c             = normal_addr,
+       .probe                  = ignore,
+       .ignore                 = ignore,
+};
+
+static struct i2c_driver pcf8563_driver = {
+       .driver = {
+          .name        = "pcf8563",
+       },
+       .id             = I2C_ID_PCF8563, 
+       .attach_adapter = pcf8563_probe,
+       .detach_client  = pcf8563_detach,
+};
+
+
+
+static int pcf8563_probe(struct i2c_adapter *adap)
+{
+       return i2c_probe(adap, &addr_data, pcf8563_attach);
+}
+
+static int pcf8563_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+       int ret;
+       unsigned char data[10];
+       unsigned char ad[1] = { 0 };
+       struct i2c_msg ctrl_wr[1] = {
+               {addr, 0, 2, data}
+       };
+       struct i2c_msg ctrl_rd[2] = {
+               {addr, 0, 1, ad},
+               {addr, I2C_M_RD, 2, data}
+       };
+
+       pcf8563_data = kzalloc(sizeof(struct pcf8563_data), GFP_KERNEL);
+       if (!pcf8563_data) {
+               ret = -ENOMEM;
+               goto done;
+       }
+
+        /* Save client data */
+       client = &pcf8563_data->client;
+        strlcpy(client->name, "pcf8563", I2C_NAME_SIZE);
+       i2c_set_clientdata(client, pcf8563_data);
+       client->addr = addr;
+       client->adapter = adap;
+       client->driver = &pcf8563_driver;
+
+       /* init ctrl1 reg */
+       data[0] = 0;
+       data[1] = 0;
+       ret = i2c_transfer(client->adapter, ctrl_wr, 1);
+       if (ret != 1) {
+               printk(KERN_INFO "pcf8563: cant init ctrl1\n");
+               ret = -ENODEV;
+               goto error;
+       }
+
+       /* read back ctrl1 and ctrl2 */
+       ret = i2c_transfer(client->adapter, ctrl_rd, 2);
+       if (ret != 2) {
+               printk(KERN_INFO "pcf8563: cant read ctrl\n");
+               ret = -ENODEV;
+               goto error;
+       }
+       pcf8563_data->ctrl = data[0] | (data[1] << 8);
+       pr_debug("%s  pcf8563_REG_CTRL1=%02x, RTC8564_REG_CTRL2=%02x", 
__FUNCTION__,
+           data[0], data[1]);
+
+       ret = i2c_attach_client(client);
+
+       ret |= register_rtc(&rtc_ops);
+       if (ret) {
+               printk(KERN_INFO "pcf8563: could not register RTC.\n");
+                goto error;
+       }
+
+       printk(KERN_INFO "pcf8563 Real Time Clock driver registered.\n");
+
+ done:
+        return ret;
+
+ error:
+       if (pcf8563_data) {
+          kfree(pcf8563_data);
+       }
+        return ret;
+}
+
+
+static int pcf8563_detach(struct i2c_client *client)
+{
+       unregister_rtc(&rtc_ops);
+       i2c_detach_client(client);
+       kfree(i2c_get_clientdata(client));
+       return 0;
+}
+
+
+static __init int pcf8563_init(void)
+{
+       return i2c_add_driver(&pcf8563_driver);
+}
+
+
+static __exit void pcf8563_exit(void)
+{
+       i2c_del_driver(&pcf8563_driver);
+}
+
+MODULE_AUTHOR("Kim Mostrup, Sagem Denmark A/S");
+MODULE_DESCRIPTION("Philips pcf8563 RTC Driver");
+MODULE_LICENSE("GPL");
+
+module_init(pcf8563_init);
+module_exit(pcf8563_exit);
+
+
+/************************************************************
+ Module 
+ *************************************************************/
+
+
+
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060530/2bc20ccf/attachment-0001.html
