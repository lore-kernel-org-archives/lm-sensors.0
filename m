From: Davide Rizzo <elpa.rizzo@gmail.com>
Date: Mon, 23 Mar 2009 16:29:09 +0000
Subject: Re: [lm-sensors] LM95241 Driver proposal
Message-Id: <8447d6730903230929m491591cfi78280715ab1270de@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2277600053434456250=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20090322170810.7350923b.akpm@linux-foundation.org>
In-Reply-To: <20090322170810.7350923b.akpm@linux-foundation.org>
To: lm-sensors@vger.kernel.org

--===============2277600053434456250==
Content-Type: multipart/alternative; boundary=0015174c34a21f6b240465cbc41b

--0015174c34a21f6b240465cbc41b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2009/3/23 Andrew Morton <akpm@linux-foundation.org>


> > +/* Conversions and various macros */
> > +#define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) - 0x100 :
> \
> > +    (val_h)) * 1000 + (val_l) * 1000 / 256)
>
> This macro is inefficient or buggy when pass an expression which has
> side-effects, because it evaulates an argument multiple times.
>
> Please just turn it into a plain old lower-case C function.
>

Ok, rewritten



> > +#define show_type(flag) \
> > +static ssize_t show_type##flag(struct device *dev, \
> > +                                struct device_attribute *attr, char
> *buf) \
> > +{ \
> > +     struct i2c_client *client = to_i2c_client(dev); \
> > +     struct lm95241_data *data = i2c_get_clientdata(client); \
> > +\
> > +     snprintf(buf, PAGE_SIZE - 1, \
> > +             data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
> > +     return strlen(buf); \
> > +}
> > +show_type(1);
> > +show_type(2);
> > +
> > +#define show_min(flag) \
> > +static ssize_t show_min##flag(struct device *dev, \
> > +    struct device_attribute *attr, char *buf) \
> > +{ \
> > +     struct i2c_client *client = to_i2c_client(dev); \
> > +     struct lm95241_data *data = i2c_get_clientdata(client); \
> > +\
> > +     snprintf(buf, PAGE_SIZE - 1, \
> > +             data->config & R##flag##DF_MASK ?       \
> > +             "-127000\n" : "0\n"); \
> > +     return strlen(buf); \
> > +}
> > +show_min(1);
> > +show_min(2);
>
> hm.  Is this still the preferred way of implementing these sysfs handlers?
>

Rewritten without using macros, much easier to read now...



> > +static struct attribute *lm95241_attributes[] = {
> > +     &dev_attr_temp1_input.attr,
> > +     &dev_attr_temp2_input.attr,
> > +     &dev_attr_temp3_input.attr,
> > +     &dev_attr_temp2_type.attr,
> > +     &dev_attr_temp3_type.attr,
> > +     &dev_attr_temp2_min.attr,
> > +     &dev_attr_temp3_min.attr,
> > +     &dev_attr_temp2_max.attr,
> > +     &dev_attr_temp3_max.attr,
> > +     &dev_attr_rate.attr,
> > +     NULL
> > +};
>
> Should this use an attribute group?
>

Yes, didn't I ?

Here follows the updated patch:
-----------------------------------------------

This patch implements the hwmon driver for the National Semiconductor
LM95241
 triple temperature sensors chip

Signed-off-by: Davide Rizzo <elpa-rizzo@gmail.com>
---
diff -urNp linux-2.6.28.5/drivers/hwmon/Kconfig
linux-2.6.28.5.elpa/drivers/hwmon/Kconfig
--- linux-2.6.28.5/drivers/hwmon/Kconfig    2008-12-25 00:26:37.000000000
+0100
+++ linux-2.6.28.5.elpa/drivers/hwmon/Kconfig    2009-01-04
08:07:39.000000000 +0100
@@ -548,6 +548,15 @@ config SENSORS_LM93
       This driver can also be built as a module.  If so, the module
       will be called lm93.

+config SENSORS_LM95241
+    tristate "National Semiconductor LM95241 sensor chip"
+    depends on I2C
+    help
+      If you say yes here you get support for LM95241 sensor chip.
+
+      This driver can also be built as a module.  If so, the module
+      will be called lm95241.
+
 config SENSORS_MAX1111
     tristate "Maxim MAX1111 Multichannel, Serial 8-bit ADC chip"
     depends on SPI_MASTER
diff -urNp linux-2.6.28.5/drivers/hwmon/lm95241.c
linux-2.6.28.5.elpa/drivers/hwmon/lm95241.c
--- linux-2.6.28.5/drivers/hwmon/lm95241.c    1970-01-01 01:00:00.000000000
+0100
+++ linux-2.6.28.5.elpa/drivers/hwmon/lm95241.c    2009-03-23
17:13:21.000000000 +0100
@@ -0,0 +1,553 @@
+/*
+ * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
monitoring
+ * Copyright (C) 2008 Davide Rizzo <elpa.rizzo@gmail.com>
+ *
+ * The LM95241 is a sensor chip made by National Semiconductors.
+ * It reports up to three temperatures (its own plus up to two external
ones).
+ * Complete datasheet can be obtained from National's website at:
+ *   http://www.national.com/ds.cgi/LM/LM95241.pdf
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+static const unsigned short normal_i2c[] = {
+    0x19, 0x2a, 0x2b, I2C_CLIENT_END};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(lm95241);
+
+/* LM95241 registers */
+#define LM95241_REG_R_MAN_ID        0xFE
+#define LM95241_REG_R_CHIP_ID        0xFF
+#define LM95241_REG_R_STATUS        0x02
+#define LM95241_REG_RW_CONFIG        0x03
+#define LM95241_REG_RW_REM_FILTER    0x06
+#define LM95241_REG_RW_TRUTHERM        0x07
+#define LM95241_REG_W_ONE_SHOT      0x0F
+#define LM95241_REG_R_LOCAL_TEMPH    0x10
+#define LM95241_REG_R_REMOTE1_TEMPH    0x11
+#define LM95241_REG_R_REMOTE2_TEMPH    0x12
+#define LM95241_REG_R_LOCAL_TEMPL    0x20
+#define LM95241_REG_R_REMOTE1_TEMPL    0x21
+#define LM95241_REG_R_REMOTE2_TEMPL    0x22
+#define LM95241_REG_RW_REMOTE_MODEL    0x30
+
+/* LM95241 specific bitfields */
+#define CFG_STOP 0x40
+#define CFG_CR0076 0x00
+#define CFG_CR0182 0x10
+#define CFG_CR1000 0x20
+#define CFG_CR2700 0x30
+#define R1MS_SHIFT 0
+#define R2MS_SHIFT 2
+#define R1MS_MASK (0x01 << (R1MS_SHIFT))
+#define R2MS_MASK (0x01 << (R2MS_SHIFT))
+#define R1DF_SHIFT 1
+#define R2DF_SHIFT 2
+#define R1DF_MASK (0x01 << (R1DF_SHIFT))
+#define R2DF_MASK (0x01 << (R2DF_SHIFT))
+#define R1FE_MASK 0x01
+#define R2FE_MASK 0x05
+#define TT1_SHIFT 0
+#define TT2_SHIFT 4
+#define TT_OFF 0
+#define TT_ON 1
+#define TT_MASK 7
+#define MANUFACTURER_ID 0x01
+#define DEFAULT_REVISION 0xA4
+
+/* Functions declaration */
+static int lm95241_attach_adapter(struct i2c_adapter *adapter);
+static int lm95241_detect(struct i2c_adapter *adapter, int address,
+              int kind);
+static void lm95241_init_client(struct i2c_client *client);
+static int lm95241_detach_client(struct i2c_client *client);
+static struct lm95241_data *lm95241_update_device(struct device *dev);
+
+/* Driver data (common to all clients) */
+static struct i2c_driver lm95241_driver = {
+    .driver = {
+        .name   = "lm95241",
+    },
+    .attach_adapter = lm95241_attach_adapter,
+    .detach_client  = lm95241_detach_client,
+};
+
+/* Client data (each client gets its own) */
+struct lm95241_data {
+    struct i2c_client client;
+    struct device *hwmon_dev;
+    struct mutex update_lock;
+    unsigned long last_updated, rate; /* in jiffies */
+    char valid; /* zero until following fields are valid */
+    /* registers values */
+    u8 local_h, local_l; /* local */
+    u8 remote1_h, remote1_l; /* remote1 */
+    u8 remote2_h, remote2_l; /* remote2 */
+    u8 config, model, trutherm;
+};
+
+static ssize_t show_input(struct device *dev,
+    struct device_attribute *attr, char *buf);
+static ssize_t show_rate(struct device *dev, struct device_attribute *attr,
+    char *buf);
+static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count);
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+    char *buf);
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,
+    char *buf);
+static ssize_t show_max(struct device *dev, struct device_attribute *attr,
+    char *buf);
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count);
+static ssize_t set_min(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count);
+static ssize_t set_max(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count);
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL);
+static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
+static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type);
+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min);
+static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max);
+static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max);
+static DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate, set_rate);
+
+static struct attribute *lm95241_attributes[] = {
+    &dev_attr_temp1_input.attr,
+    &dev_attr_temp2_input.attr,
+    &dev_attr_temp3_input.attr,
+    &dev_attr_temp2_type.attr,
+    &dev_attr_temp3_type.attr,
+    &dev_attr_temp2_min.attr,
+    &dev_attr_temp3_min.attr,
+    &dev_attr_temp2_max.attr,
+    &dev_attr_temp3_max.attr,
+    &dev_attr_rate.attr,
+    NULL
+};
+
+static const struct attribute_group lm95241_group = {
+    .attrs = lm95241_attributes,
+};
+
+/* Conversions */
+static int TempFromReg(u8 val_h, u8 val_l)
+{
+    if (val_h & 0x80)
+        return val_h - 0x100;
+    return val_h * 1000 + val_l * 1000 / 256;
+}
+
+/* Sysfs stuff */
+static ssize_t show_input(struct device *dev,
+    struct device_attribute *attr, char *buf)
+{
+    struct lm95241_data *data = lm95241_update_device(dev);
+    int value;
+
+    if (attr == &dev_attr_temp1_input)
+        value = TempFromReg(data->local_h, data->local_l);
+    else if (attr == &dev_attr_temp2_input)
+        value = TempFromReg(data->remote1_h, data->remote1_l);
+    else
+        value = TempFromReg(data->remote2_h, data->remote2_l);
+    snprintf(buf, PAGE_SIZE - 1, "%d\n", value);
+    return strlen(buf);
+}
+
+static ssize_t show_rate(struct device *dev, struct device_attribute *attr,
+    char *buf)
+{
+    struct lm95241_data *data = lm95241_update_device(dev);
+
+    snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->rate / HZ);
+    return strlen(buf);
+}
+
+static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    strict_strtol(buf, 10, &data->rate);
+    data->rate = data->rate * HZ / 1000;
+    return count;
+}
+
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+    char *buf)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    if (attr == &dev_attr_temp2_type)
+        snprintf(buf, PAGE_SIZE - 1,
+            data->model & R1MS_MASK ? "1\n" : "2\n");
+    else
+        snprintf(buf, PAGE_SIZE - 1,
+            data->model & R2MS_MASK ? "1\n" : "2\n");
+    return strlen(buf);
+}
+
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,
+    char *buf)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    if (attr == &dev_attr_temp2_min)
+        snprintf(buf, PAGE_SIZE - 1,
+            data->config & R1DF_MASK ? "-127000\n" : "0\n");
+    else
+        snprintf(buf, PAGE_SIZE - 1,
+            data->config & R2DF_MASK ? "-127000\n" : "0\n");
+    return strlen(buf);
+}
+
+static ssize_t show_max(struct device *dev, struct device_attribute *attr,
+    char *buf)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    if (attr == &dev_attr_temp2_max)
+        snprintf(buf, PAGE_SIZE - 1,
+            data->config & R1DF_MASK ? "127000\n" : "255000\n");
+    else
+        snprintf(buf, PAGE_SIZE - 1,
+            data->config & R2DF_MASK ? "127000\n" : "255000\n");
+    return strlen(buf);
+}
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    long val;
+
+    strict_strtol(buf, 10, &val);
+    if ((val == 1) || (val == 2)) {
+        int shift;
+        u8 mask;
+        if (attr == &dev_attr_temp2_type) {
+            shift = TT1_SHIFT;
+            mask = R1MS_MASK;
+        } else {
+            shift = TT2_SHIFT;
+            mask = R2MS_MASK;
+        }
+
+        mutex_lock(&data->update_lock);
+
+        data->trutherm &= ~(TT_MASK << shift);
+        if (val == 1) {
+            data->model |= mask;
+            data->trutherm |= (TT_ON << shift);
+        } else {
+            data->model &= ~mask;
+            data->trutherm |= (TT_OFF << shift);
+        }
+
+        data->valid = 0;
+
+        i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
+                      data->model);
+        i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
+                      data->trutherm);
+
+        mutex_unlock(&data->update_lock);
+
+    }
+    return count;
+}
+
+static ssize_t set_min(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    long val;
+    u8 mask;
+
+    strict_strtol(buf, 10, &val);
+    if (attr == &dev_attr_temp2_min)
+        mask = R1DF_MASK;
+    else
+        mask = R2DF_MASK;
+
+    mutex_lock(&data->update_lock);
+
+    if (val < 0)
+        data->config |= mask;
+    else
+        data->config &= mask;
+    data->valid = 0;
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+    mutex_unlock(&data->update_lock);
+
+    return count;
+}
+
+static ssize_t set_max(struct device *dev, struct device_attribute *attr,
+    const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    long val;
+    u8 mask;
+
+    strict_strtol(buf, 10, &val);
+    if (attr == &dev_attr_temp2_max)
+        mask = R1DF_MASK;
+    else
+        mask = R2DF_MASK;
+
+    mutex_lock(&data->update_lock);
+
+    if (val <= 127000)
+        data->config |= R1DF_MASK;
+    else
+        data->config &= ~R2DF_MASK;
+    data->valid = 0;
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+    mutex_unlock(&data->update_lock);
+
+    return count;
+}
+
+/* Init/exit code */
+static int lm95241_attach_adapter(struct i2c_adapter *adapter)
+{
+    if (!(adapter->class & I2C_CLASS_HWMON))
+        return 0;
+    return i2c_probe(adapter, &addr_data, lm95241_detect);
+}
+
+/*
+ * The following function does more than just detection. If detection
+ * succeeds, it also registers the new chip.
+ */
+static int lm95241_detect(struct i2c_adapter *adapter, int address, int
kind)
+{
+    struct i2c_client *new_client;
+    struct lm95241_data *data;
+    int err = 0;
+    const char *name = "";
+
+    if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+        goto exit;
+
+    data = kzalloc(sizeof(struct lm95241_data), GFP_KERNEL);
+    if (!data) {
+        err = -ENOMEM;
+        goto exit;
+    }
+
+    /* The common I2C client data is placed right before the
+       LM95241-specific data. */
+    new_client = &data->client;
+    i2c_set_clientdata(new_client, data);
+    new_client->addr = address;
+    new_client->adapter = adapter;
+    new_client->driver = &lm95241_driver;
+    new_client->flags = 0;
+
+    /*
+     * Now we do the remaining detection. A negative kind means that
+     * the driver was loaded with no force parameter (default), so we
+     * must both detect and identify the chip. A zero kind means that
+     * the driver was loaded with the force parameter, the detection
+     * step shall be skipped. A positive kind means that the driver
+     * was loaded with the force parameter and a given kind of chip is
+     * requested, so both the detection and the identification steps
+     * are skipped.
+     */
+    if (kind < 0) {    /* detection */
+        if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
+             != MANUFACTURER_ID)
+        || (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
+            < DEFAULT_REVISION)) {
+            dev_dbg(&adapter->dev,
+                "LM95241 detection failed at 0x%02x.\n",
+                address);
+            goto exit_free;
+        }
+    }
+
+    if (kind <= 0) { /* identification */
+        if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
+             == MANUFACTURER_ID)
+        && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
+            >= DEFAULT_REVISION)) {
+
+            kind = lm95241;
+
+            if (kind <= 0) { /* identification failed */
+                dev_info(&adapter->dev, "Unsupported chip\n");
+                goto exit_free;
+            }
+        }
+    }
+
+    if (kind == lm95241)
+        name = "lm95241";
+
+    /* We can fill in the remaining client fields */
+    strlcpy(new_client->name, name, I2C_NAME_SIZE);
+    data->valid = 0;
+    mutex_init(&data->update_lock);
+
+    /* Tell the I2C layer a new client has arrived */
+    err = i2c_attach_client(new_client);
+    if (err)
+        goto exit_free;
+
+    /* Initialize the LM95241 chip */
+    lm95241_init_client(new_client);
+
+    /* Register sysfs hooks */
+    err = sysfs_create_group(&new_client->dev.kobj, &lm95241_group);
+    if (err)
+        goto exit_detach;
+
+    data->hwmon_dev = hwmon_device_register(&new_client->dev);
+    if (IS_ERR(data->hwmon_dev)) {
+        err = PTR_ERR(data->hwmon_dev);
+        goto exit_remove_files;
+    }
+
+    return 0;
+
+exit_remove_files:
+    sysfs_remove_group(&new_client->dev.kobj, &lm95241_group);
+exit_detach:
+    i2c_detach_client(new_client);
+exit_free:
+    kfree(data);
+exit:
+    return err;
+}
+
+static void lm95241_init_client(struct i2c_client *client)
+{
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    data->rate = HZ;    /* 1 sec default */
+    data->valid = 0;
+    data->config = CFG_CR0076;
+    data->model = 0;
+    data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
+                  data->config);
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
+                  R1FE_MASK | R2FE_MASK);
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
+                  data->trutherm);
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
+                  data->model);
+}
+
+static int lm95241_detach_client(struct i2c_client *client)
+{
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    int err;
+
+    hwmon_device_unregister(data->hwmon_dev);
+    sysfs_remove_group(&client->dev.kobj, &lm95241_group);
+
+    err = i2c_detach_client(client);
+    if (err)
+        return err;
+
+    kfree(data);
+    return 0;
+}
+
+static struct lm95241_data *lm95241_update_device(struct device *dev)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    mutex_lock(&data->update_lock);
+
+    if (time_after(jiffies, data->last_updated + data->rate) ||
+        !data->valid) {
+        dev_dbg(&client->dev, "Updating lm95241 data.\n");
+        data->local_h =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_LOCAL_TEMPH);
+        data->local_l =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_LOCAL_TEMPL);
+        data->remote1_h =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_REMOTE1_TEMPH);
+        data->remote1_l =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_REMOTE1_TEMPL);
+        data->remote2_h =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_REMOTE2_TEMPH);
+        data->remote2_l =
+            i2c_smbus_read_byte_data(client,
+                         LM95241_REG_R_REMOTE2_TEMPL);
+        data->last_updated = jiffies;
+        data->valid = 1;
+    }
+
+    mutex_unlock(&data->update_lock);
+
+    return data;
+}
+
+static int __init sensors_lm95241_init(void)
+{
+    return i2c_add_driver(&lm95241_driver);
+}
+
+static void __exit sensors_lm95241_exit(void)
+{
+    i2c_del_driver(&lm95241_driver);
+}
+
+MODULE_AUTHOR("Davide Rizzo <elpa.rizzo@gmail.com>");
+MODULE_DESCRIPTION("LM95241 sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_lm95241_init);
+module_exit(sensors_lm95241_exit);
diff -urNp linux-2.6.28.5/drivers/hwmon/Makefile
linux-2.6.28.5.elpa/drivers/hwmon/Makefile
--- linux-2.6.28.5/drivers/hwmon/Makefile    2008-12-25 00:26:37.000000000
+0100
+++ linux-2.6.28.5.elpa/drivers/hwmon/Makefile    2009-01-04
08:14:42.000000000 +0100
@@ -62,6 +62,7 @@ obj-$(CONFIG_SENSORS_LM87)    += lm87.o
 obj-$(CONFIG_SENSORS_LM90)    += lm90.o
 obj-$(CONFIG_SENSORS_LM92)    += lm92.o
 obj-$(CONFIG_SENSORS_LM93)    += lm93.o
+obj-$(CONFIG_SENSORS_LM95241)    += lm95241.o
 obj-$(CONFIG_SENSORS_MAX1111)    += max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)    += max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)    += max6650.o

--0015174c34a21f6b240465cbc41b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/3/23 Andrew Morton <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt=
;<br><br></span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im"><br>&gt; +/* Conversions and various macros */<br>
&gt; +#define TEMP_FROM_REG(val_h, val_l) (((val_h) &amp; 0x80 ? (val_h) - =
0x100 : \<br>
&gt; + =C2=A0 =C2=A0(val_h)) * 1000 + (val_l) * 1000 / 256)<br>
<br>
</div>This macro is inefficient or buggy when pass an expression which has<=
br>
side-effects, because it evaulates an argument multiple times.<br>
<br>
Please just turn it into a plain old lower-case C function.<br>
</blockquote><div><br>Ok, rewritten<br><br>=C2=A0<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im">
&gt; +#define show_type(flag) \<br>
&gt; +static ssize_t show_type##flag(struct device *dev, \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *attr,=
 char *buf) \<br>
&gt; +{ \<br>
&gt; + =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev); \<br=
>
&gt; + =C2=A0 =C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(clien=
t); \<br>
&gt; +\<br>
&gt; + =C2=A0 =C2=A0 snprintf(buf, PAGE_SIZE - 1, \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;model &amp; R##fl=
ag##MS_MASK ? &quot;1\n&quot; : &quot;2\n&quot;); \<br>
&gt; + =C2=A0 =C2=A0 return strlen(buf); \<br>
&gt; +}<br>
&gt; +show_type(1);<br>
&gt; +show_type(2);<br>
&gt; +<br>
&gt; +#define show_min(flag) \<br>
&gt; +static ssize_t show_min##flag(struct device *dev, \<br>
&gt; + =C2=A0 =C2=A0struct device_attribute *attr, char *buf) \<br>
&gt; +{ \<br>
&gt; + =C2=A0 =C2=A0 struct i2c_client *client =3D to_i2c_client(dev); \<br=
>
&gt; + =C2=A0 =C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(clien=
t); \<br>
&gt; +\<br>
&gt; + =C2=A0 =C2=A0 snprintf(buf, PAGE_SIZE - 1, \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data-&gt;config &amp; R##f=
lag##DF_MASK ? =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-127000\n&quot; : &q=
uot;0\n&quot;); \<br>
&gt; + =C2=A0 =C2=A0 return strlen(buf); \<br>
&gt; +}<br>
&gt; +show_min(1);<br>
&gt; +show_min(2);<br>
<br>
</div>hm. =C2=A0Is this still the preferred way of implementing these sysfs=
 handlers?<br>
</blockquote><div><br>Rewritten without using macros, much easier to read n=
ow...<br><br>=C2=A0<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=
=3D"im">&gt; +static struct attribute *lm95241_attributes[] =3D {<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp1_input.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp2_input.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp3_input.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp2_type.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp3_type.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp2_min.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp3_min.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp2_max.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_temp3_max.attr,<br>
&gt; + =C2=A0 =C2=A0 &amp;dev_attr_rate.attr,<br>
&gt; + =C2=A0 =C2=A0 NULL<br>
&gt; +};<br>
<br>
</div>Should this use an attribute group?<br>
</blockquote><div><br>Yes, didn&#39;t I ?<br><br>Here follows the updated p=
atch:<br>----------------------------------------------- <br><br>This patch=
 implements the hwmon driver for the National Semiconductor LM95241<br>
=C2=A0triple temperature sensors chip<br><br>Signed-off-by: Davide Rizzo &l=
t;<a href=3D"mailto:elpa-rizzo@gmail.com">elpa-rizzo@gmail.com</a>&gt;<br>-=
--<br>diff -urNp linux-2.6.28.5/drivers/hwmon/Kconfig linux-2.6.28.5.elpa/d=
rivers/hwmon/Kconfig<br>
--- linux-2.6.28.5/drivers/hwmon/Kconfig=C2=A0=C2=A0=C2=A0 2008-12-25 00:26=
:37.000000000 +0100<br>+++ linux-2.6.28.5.elpa/drivers/hwmon/Kconfig=C2=A0=
=C2=A0=C2=A0 2009-01-04 08:07:39.000000000 +0100<br>@@ -548,6 +548,15 @@ co=
nfig SENSORS_LM93<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 This driver can also b=
e built as a module.=C2=A0 If so, the module<br>
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 will be called lm93.<br>=C2=A0<br>+config S=
ENSORS_LM95241<br>+=C2=A0=C2=A0=C2=A0 tristate &quot;National Semiconductor=
 LM95241 sensor chip&quot;<br>+=C2=A0=C2=A0=C2=A0 depends on I2C<br>+=C2=A0=
=C2=A0=C2=A0 help<br>+=C2=A0=C2=A0=C2=A0 =C2=A0 If you say yes here you get=
 support for LM95241 sensor chip.<br>
+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0 This driver can also be built as a module.=
=C2=A0 If so, the module<br>+=C2=A0=C2=A0=C2=A0 =C2=A0 will be called lm952=
41.<br>+<br>=C2=A0config SENSORS_MAX1111<br>=C2=A0=C2=A0=C2=A0=C2=A0 trista=
te &quot;Maxim MAX1111 Multichannel, Serial 8-bit ADC chip&quot;<br>
=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI_MASTER<br>diff -urNp linux-2.6.28.5=
/drivers/hwmon/lm95241.c linux-2.6.28.5.elpa/drivers/hwmon/lm95241.c<br>---=
 linux-2.6.28.5/drivers/hwmon/lm95241.c=C2=A0=C2=A0=C2=A0 1970-01-01 01:00:=
00.000000000 +0100<br>+++ linux-2.6.28.5.elpa/drivers/hwmon/lm95241.c=C2=A0=
=C2=A0=C2=A0 2009-03-23 17:13:21.000000000 +0100<br>
@@ -0,0 +1,553 @@<br>+/*<br>+ * lm95241.c - Part of lm_sensors, Linux kerne=
l modules for hardware monitoring<br>+ * Copyright (C) 2008 Davide Rizzo &l=
t;<a href=3D"mailto:elpa.rizzo@gmail.com">elpa.rizzo@gmail.com</a>&gt;<br>
+ *<br>+ * The LM95241 is a sensor chip made by National Semiconductors.<br=
>+ * It reports up to three temperatures (its own plus up to two external o=
nes).<br>+ * Complete datasheet can be obtained from National&#39;s website=
 at:<br>
+ *=C2=A0=C2=A0 <a href=3D"http://www.national.com/ds.cgi/LM/LM95241.pdf">h=
ttp://www.national.com/ds.cgi/LM/LM95241.pdf</a><br>+ *<br>+ * This program=
 is free software; you can redistribute it and/or modify<br>+ * it under th=
e terms of the GNU General Public License as published by<br>
+ * the Free Software Foundation; either version 2 of the License, or<br>+ =
* (at your option) any later version.<br>+ *<br>+ * This program is distrib=
uted in the hope that it will be useful,<br>+ * but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>+=
 * GNU General Public License for more details.<br>+ *<br>+ * You should ha=
ve received a copy of the GNU General Public License<br>+ * along with this=
 program; if not, write to the Free Software<br>
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.<br>+ */<br>+<=
br>+#include &lt;linux/module.h&gt;<br>+#include &lt;linux/init.h&gt;<br>+#=
include &lt;linux/slab.h&gt;<br>+#include &lt;linux/jiffies.h&gt;<br>+#incl=
ude &lt;linux/i2c.h&gt;<br>
+#include &lt;linux/hwmon.h&gt;<br>+#include &lt;linux/hwmon-sysfs.h&gt;<br=
>+#include &lt;linux/err.h&gt;<br>+#include &lt;linux/mutex.h&gt;<br>+#incl=
ude &lt;linux/sysfs.h&gt;<br>+<br>+static const unsigned short normal_i2c[]=
 =3D {<br>
+=C2=A0=C2=A0=C2=A0 0x19, 0x2a, 0x2b, I2C_CLIENT_END};<br>+<br>+/* Insmod p=
arameters */<br>+I2C_CLIENT_INSMOD_1(lm95241);<br>+<br>+/* LM95241 register=
s */<br>+#define LM95241_REG_R_MAN_ID=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
0xFE<br>+#define LM95241_REG_R_CHIP_ID=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 0xFF<br>
+#define LM95241_REG_R_STATUS=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x02<br>=
+#define LM95241_REG_RW_CONFIG=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x03<br=
>+#define LM95241_REG_RW_REM_FILTER=C2=A0=C2=A0=C2=A0 0x06<br>+#define LM95=
241_REG_RW_TRUTHERM=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x07<br>+#define L=
M95241_REG_W_ONE_SHOT=C2=A0 =C2=A0=C2=A0=C2=A0 0x0F<br>
+#define LM95241_REG_R_LOCAL_TEMPH=C2=A0=C2=A0=C2=A0 0x10<br>+#define LM952=
41_REG_R_REMOTE1_TEMPH=C2=A0=C2=A0=C2=A0 0x11<br>+#define LM95241_REG_R_REM=
OTE2_TEMPH=C2=A0=C2=A0=C2=A0 0x12<br>+#define LM95241_REG_R_LOCAL_TEMPL=C2=
=A0=C2=A0=C2=A0 0x20<br>+#define LM95241_REG_R_REMOTE1_TEMPL=C2=A0=C2=A0=C2=
=A0 0x21<br>
+#define LM95241_REG_R_REMOTE2_TEMPL=C2=A0=C2=A0=C2=A0 0x22<br>+#define LM9=
5241_REG_RW_REMOTE_MODEL=C2=A0=C2=A0=C2=A0 0x30<br>+<br>+/* LM95241 specifi=
c bitfields */<br>+#define CFG_STOP 0x40<br>+#define CFG_CR0076 0x00<br>+#d=
efine CFG_CR0182 0x10<br>+#define CFG_CR1000 0x20<br>
+#define CFG_CR2700 0x30<br>+#define R1MS_SHIFT 0<br>+#define R2MS_SHIFT 2<=
br>+#define R1MS_MASK (0x01 &lt;&lt; (R1MS_SHIFT))<br>+#define R2MS_MASK (0=
x01 &lt;&lt; (R2MS_SHIFT))<br>+#define R1DF_SHIFT 1<br>+#define R2DF_SHIFT =
2<br>
+#define R1DF_MASK (0x01 &lt;&lt; (R1DF_SHIFT))<br>+#define R2DF_MASK (0x01=
 &lt;&lt; (R2DF_SHIFT))<br>+#define R1FE_MASK 0x01<br>+#define R2FE_MASK 0x=
05<br>+#define TT1_SHIFT 0<br>+#define TT2_SHIFT 4<br>+#define TT_OFF 0<br>
+#define TT_ON 1<br>+#define TT_MASK 7<br>+#define MANUFACTURER_ID 0x01<br>=
+#define DEFAULT_REVISION 0xA4<br>+<br>+/* Functions declaration */<br>+sta=
tic int lm95241_attach_adapter(struct i2c_adapter *adapter);<br>+static int=
 lm95241_detect(struct i2c_adapter *adapter, int address,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 int kind);=
<br>+static void lm95241_init_client(struct i2c_client *client);<br>+static=
 int lm95241_detach_client(struct i2c_client *client);<br>+static struct lm=
95241_data *lm95241_update_device(struct device *dev);<br>
+<br>+/* Driver data (common to all clients) */<br>+static struct i2c_drive=
r lm95241_driver =3D {<br>+=C2=A0=C2=A0=C2=A0 .driver =3D {<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0 =3D &quot;lm95241&quot;,<br>=
+=C2=A0=C2=A0=C2=A0 },<br>+=C2=A0=C2=A0=C2=A0 .attach_adapter =3D lm95241_a=
ttach_adapter,<br>
+=C2=A0=C2=A0=C2=A0 .detach_client=C2=A0 =3D lm95241_detach_client,<br>+};<=
br>+<br>+/* Client data (each client gets its own) */<br>+struct lm95241_da=
ta {<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client client;<br>+=C2=A0=C2=A0=C2=
=A0 struct device *hwmon_dev;<br>+=C2=A0=C2=A0=C2=A0 struct mutex update_lo=
ck;<br>
+=C2=A0=C2=A0=C2=A0 unsigned long last_updated, rate; /* in jiffies */<br>+=
=C2=A0=C2=A0=C2=A0 char valid; /* zero until following fields are valid */<=
br>+=C2=A0=C2=A0=C2=A0 /* registers values */<br>+=C2=A0=C2=A0=C2=A0 u8 loc=
al_h, local_l; /* local */<br>+=C2=A0=C2=A0=C2=A0 u8 remote1_h, remote1_l; =
/* remote1 */<br>
+=C2=A0=C2=A0=C2=A0 u8 remote2_h, remote2_l; /* remote2 */<br>+=C2=A0=C2=A0=
=C2=A0 u8 config, model, trutherm;<br>+};<br>+<br>+static ssize_t show_inpu=
t(struct device *dev,<br>+=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,=
 char *buf);<br>+static ssize_t show_rate(struct device *dev, struct device=
_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 char *buf);<br>+static ssize_t set_rate(struct device *=
dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=A0 const char *buf,=
 size_t count);<br>+static ssize_t show_type(struct device *dev, struct dev=
ice_attribute *attr,<br>+=C2=A0=C2=A0=C2=A0 char *buf);<br>
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,=
<br>+=C2=A0=C2=A0=C2=A0 char *buf);<br>+static ssize_t show_max(struct devi=
ce *dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=A0 char *buf);<=
br>+static ssize_t set_type(struct device *dev, struct device_attribute *at=
tr,<br>
+=C2=A0=C2=A0=C2=A0 const char *buf, size_t count);<br>+static ssize_t set_=
min(struct device *dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=
=A0 const char *buf, size_t count);<br>+static ssize_t set_max(struct devic=
e *dev, struct device_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 const char *buf, size_t count);<br>+<br>+static DEVICE_=
ATTR(temp1_input, S_IRUGO, show_input, NULL);<br>+static DEVICE_ATTR(temp2_=
input, S_IRUGO, show_input, NULL);<br>+static DEVICE_ATTR(temp3_input, S_IR=
UGO, show_input, NULL);<br>
+static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);<br=
>+static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type);<b=
r>+static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min);<br>
+static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min);<br>+s=
tatic DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max);<br>+sta=
tic DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max);<br>+stati=
c DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate, set_rate);<br>
+<br>+static struct attribute *lm95241_attributes[] =3D {<br>+=C2=A0=C2=A0=
=C2=A0 &amp;dev_attr_temp1_input.attr,<br>+=C2=A0=C2=A0=C2=A0 &amp;dev_attr=
_temp2_input.attr,<br>+=C2=A0=C2=A0=C2=A0 &amp;dev_attr_temp3_input.attr,<b=
r>+=C2=A0=C2=A0=C2=A0 &amp;dev_attr_temp2_type.attr,<br>+=C2=A0=C2=A0=C2=A0=
 &amp;dev_attr_temp3_type.attr,<br>
+=C2=A0=C2=A0=C2=A0 &amp;dev_attr_temp2_min.attr,<br>+=C2=A0=C2=A0=C2=A0 &a=
mp;dev_attr_temp3_min.attr,<br>+=C2=A0=C2=A0=C2=A0 &amp;dev_attr_temp2_max.=
attr,<br>+=C2=A0=C2=A0=C2=A0 &amp;dev_attr_temp3_max.attr,<br>+=C2=A0=C2=A0=
=C2=A0 &amp;dev_attr_rate.attr,<br>+=C2=A0=C2=A0=C2=A0 NULL<br>+};<br>+<br>=
+static const struct attribute_group lm95241_group =3D {<br>
+=C2=A0=C2=A0=C2=A0 .attrs =3D lm95241_attributes,<br>+};<br>+<br>+/* Conve=
rsions */<br>+static int TempFromReg(u8 val_h, u8 val_l)<br>+{<br>+=C2=A0=
=C2=A0=C2=A0 if (val_h &amp; 0x80)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 return val_h - 0x100;<br>+=C2=A0=C2=A0=C2=A0 return val_h * 1000 + val_=
l * 1000 / 256;<br>
+}<br>+<br>+/* Sysfs stuff */<br>+static ssize_t show_input(struct device *=
dev,<br>+=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)<br>+{=
<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D lm95241_update_device=
(dev);<br>+=C2=A0=C2=A0=C2=A0 int value;<br>
+<br>+=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &amp;dev_attr_temp1_input)<br>+=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 value =3D TempFromReg(data-&gt;local_h, =
data-&gt;local_l);<br>+=C2=A0=C2=A0=C2=A0 else if (attr =3D=3D &amp;dev_att=
r_temp2_input)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 value =3D TempFrom=
Reg(data-&gt;remote1_h, data-&gt;remote1_l);<br>
+=C2=A0=C2=A0=C2=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 value =
=3D TempFromReg(data-&gt;remote2_h, data-&gt;remote2_l);<br>+=C2=A0=C2=A0=
=C2=A0 snprintf(buf, PAGE_SIZE - 1, &quot;%d\n&quot;, value);<br>+=C2=A0=C2=
=A0=C2=A0 return strlen(buf);<br>+}<br>+<br>+static ssize_t show_rate(struc=
t device *dev, struct device_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 char *buf)<br>+{<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_=
data *data =3D lm95241_update_device(dev);<br>+<br>+=C2=A0=C2=A0=C2=A0 snpr=
intf(buf, PAGE_SIZE - 1, &quot;%lu\n&quot;, 1000 * data-&gt;rate / HZ);<br>=
+=C2=A0=C2=A0=C2=A0 return strlen(buf);<br>+}<br>+<br>+static ssize_t set_r=
ate(struct device *dev, struct device_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)<br>+{<br>+=C2=A0=C2=A0=
=C2=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=C2=A0=C2=A0=
=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+<br>+=
=C2=A0=C2=A0=C2=A0 strict_strtol(buf, 10, &amp;data-&gt;rate);<br>
+=C2=A0=C2=A0=C2=A0 data-&gt;rate =3D data-&gt;rate * HZ / 1000;<br>+=C2=A0=
=C2=A0=C2=A0 return count;<br>+}<br>+<br>+static ssize_t show_type(struct d=
evice *dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=A0 char *buf=
)<br>+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D to_i2c_client(=
dev);<br>
+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(client=
);<br>+<br>+=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &amp;dev_attr_temp2_type)<br=
>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snprintf(buf, PAGE_SIZE - 1,<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;model &am=
p; R1MS_MASK ? &quot;1\n&quot; : &quot;2\n&quot;);<br>
+=C2=A0=C2=A0=C2=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snprintf=
(buf, PAGE_SIZE - 1,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 data-&gt;model &amp; R2MS_MASK ? &quot;1\n&quot; : &quot;2\n&quot;);=
<br>+=C2=A0=C2=A0=C2=A0 return strlen(buf);<br>+}<br>+<br>+static ssize_t s=
how_min(struct device *dev, struct device_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 char *buf)<br>+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_clie=
nt *client =3D to_i2c_client(dev);<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_da=
ta *data =3D i2c_get_clientdata(client);<br>+<br>+=C2=A0=C2=A0=C2=A0 if (at=
tr =3D=3D &amp;dev_attr_temp2_min)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 snprintf(buf, PAGE_SIZE - 1,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;config &=
amp; R1DF_MASK ? &quot;-127000\n&quot; : &quot;0\n&quot;);<br>+=C2=A0=C2=A0=
=C2=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snprintf(buf, PAGE_SI=
ZE - 1,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&=
gt;config &amp; R2DF_MASK ? &quot;-127000\n&quot; : &quot;0\n&quot;);<br>
+=C2=A0=C2=A0=C2=A0 return strlen(buf);<br>+}<br>+<br>+static ssize_t show_=
max(struct device *dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=
=A0 char *buf)<br>+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D t=
o_i2c_client(dev);<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c=
_get_clientdata(client);<br>
+<br>+=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &amp;dev_attr_temp2_max)<br>+=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snprintf(buf, PAGE_SIZE - 1,<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;config &amp; R1=
DF_MASK ? &quot;127000\n&quot; : &quot;255000\n&quot;);<br>+=C2=A0=C2=A0=C2=
=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snprintf(buf, PAGE_SIZE =
- 1,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;config &=
amp; R2DF_MASK ? &quot;127000\n&quot; : &quot;255000\n&quot;);<br>+=C2=A0=
=C2=A0=C2=A0 return strlen(buf);<br>+}<br>+<br>+static ssize_t set_type(str=
uct device *dev, struct device_attribute *attr,<br>+=C2=A0=C2=A0=C2=A0 cons=
t char *buf, size_t count)<br>
+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D to_i2c_client(dev);=
<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(cl=
ient);<br>+=C2=A0=C2=A0=C2=A0 long val;<br>+<br>+=C2=A0=C2=A0=C2=A0 strict_=
strtol(buf, 10, &amp;val);<br>+=C2=A0=C2=A0=C2=A0 if ((val =3D=3D 1) || (va=
l =3D=3D 2)) {<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int shift;<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 u8 mask;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (a=
ttr =3D=3D &amp;dev_attr_temp2_type) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 shift =3D TT1_SHIFT;<br>+=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R1MS_MASK;<br>+=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 } else {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 shift =3D TT2_SHIFT;<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R2MS_MAS=
K;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;trutherm &amp;=3D ~(TT_MASK &lt;&l=
t; shift);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (val =3D=3D 1) {<br=
>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;model |=
=3D mask;<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;trutherm=
 |=3D (TT_ON &lt;&lt; shift);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 } e=
lse {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt=
;model &amp;=3D ~mask;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 data-&gt;trutherm |=3D (TT_OFF &lt;&lt; shift);<br>+=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
data-&gt;valid =3D 0;<br>
+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_data(clien=
t, LM95241_REG_RW_REMOTE_MODEL,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 data-&gt;mo=
del);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_data(c=
lient, LM95241_REG_RW_TRUTHERM,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 data-&gt;tr=
utherm);<br>
+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;data-&gt;upda=
te_lock);<br>+<br>+=C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 return count=
;<br>+}<br>+<br>+static ssize_t set_min(struct device *dev, struct device_a=
ttribute *attr,<br>+=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)<br>
+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D to_i2c_client(dev);=
<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(cl=
ient);<br>+=C2=A0=C2=A0=C2=A0 long val;<br>+=C2=A0=C2=A0=C2=A0 u8 mask;<br>=
+<br>+=C2=A0=C2=A0=C2=A0 strict_strtol(buf, 10, &amp;val);<br>+=C2=A0=C2=A0=
=C2=A0 if (attr =3D=3D &amp;dev_attr_temp2_min)<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R1DF_MASK;<br>+=C2=A0=C2=A0=
=C2=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R2DF_MASK;<b=
r>+<br>+=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<br>+=
=C2=A0=C2=A0=C2=A0 if (val &lt; 0)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 data-&gt;config |=3D mask;<br>+=C2=A0=C2=A0=C2=A0 else<br>+=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;config &amp;=3D mask;<br>
+=C2=A0=C2=A0=C2=A0 data-&gt;valid =3D 0;<br>+<br>+=C2=A0=C2=A0=C2=A0 i2c_s=
mbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data-&gt;config);<br>+<=
br>+=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;data-&gt;update_lock);<br>+<br>+=
=C2=A0=C2=A0=C2=A0 return count;<br>+}<br>+<br>+static ssize_t set_max(stru=
ct device *dev, struct device_attribute *attr,<br>
+=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)<br>+{<br>+=C2=A0=C2=A0=
=C2=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=C2=A0=C2=A0=
=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+=C2=A0=
=C2=A0=C2=A0 long val;<br>+=C2=A0=C2=A0=C2=A0 u8 mask;<br>+<br>+=C2=A0=C2=
=A0=C2=A0 strict_strtol(buf, 10, &amp;val);<br>
+=C2=A0=C2=A0=C2=A0 if (attr =3D=3D &amp;dev_attr_temp2_max)<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R1DF_MASK;<br>+=C2=A0=C2=A0=C2=A0 els=
e<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mask =3D R2DF_MASK;<br>+<br>+=
=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<br>+=C2=A0=
=C2=A0=C2=A0 if (val &lt;=3D 127000)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 data-&gt;config |=3D R1DF_MASK;<br>
+=C2=A0=C2=A0=C2=A0 else<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt=
;config &amp;=3D ~R2DF_MASK;<br>+=C2=A0=C2=A0=C2=A0 data-&gt;valid =3D 0;<b=
r>+<br>+=C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW=
_CONFIG, data-&gt;config);<br>+<br>+=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;da=
ta-&gt;update_lock);<br>
+<br>+=C2=A0=C2=A0=C2=A0 return count;<br>+}<br>+<br>+/* Init/exit code */<=
br>+static int lm95241_attach_adapter(struct i2c_adapter *adapter)<br>+{<br=
>+=C2=A0=C2=A0=C2=A0 if (!(adapter-&gt;class &amp; I2C_CLASS_HWMON))<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0;<br>+=C2=A0=C2=A0=C2=A0 retu=
rn i2c_probe(adapter, &amp;addr_data, lm95241_detect);<br>
+}<br>+<br>+/*<br>+ * The following function does more than just detection.=
 If detection<br>+ * succeeds, it also registers the new chip.<br>+ */<br>+=
static int lm95241_detect(struct i2c_adapter *adapter, int address, int kin=
d)<br>
+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *new_client;<br>+=C2=A0=C2=A0=
=C2=A0 struct lm95241_data *data;<br>+=C2=A0=C2=A0=C2=A0 int err =3D 0;<br>=
+=C2=A0=C2=A0=C2=A0 const char *name =3D &quot;&quot;;<br>+<br>+=C2=A0=C2=
=A0=C2=A0 if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))<=
br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto exit;<br>
+<br>+=C2=A0=C2=A0=C2=A0 data =3D kzalloc(sizeof(struct lm95241_data), GFP_=
KERNEL);<br>+=C2=A0=C2=A0=C2=A0 if (!data) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 err =3D -ENOMEM;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 got=
o exit;<br>+=C2=A0=C2=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 /* The common =
I2C client data is placed right before the<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 LM95241-specific data. */<br>+=C2=A0=C2=A0=
=C2=A0 new_client =3D &amp;data-&gt;client;<br>+=C2=A0=C2=A0=C2=A0 i2c_set_=
clientdata(new_client, data);<br>+=C2=A0=C2=A0=C2=A0 new_client-&gt;addr =
=3D address;<br>+=C2=A0=C2=A0=C2=A0 new_client-&gt;adapter =3D adapter;<br>=
+=C2=A0=C2=A0=C2=A0 new_client-&gt;driver =3D &amp;lm95241_driver;<br>
+=C2=A0=C2=A0=C2=A0 new_client-&gt;flags =3D 0;<br>+<br>+=C2=A0=C2=A0=C2=A0=
 /*<br>+=C2=A0=C2=A0=C2=A0 =C2=A0* Now we do the remaining detection. A neg=
ative kind means that<br>+=C2=A0=C2=A0=C2=A0 =C2=A0* the driver was loaded =
with no force parameter (default), so we<br>+=C2=A0=C2=A0=C2=A0 =C2=A0* mus=
t both detect and identify the chip. A zero kind means that<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0* the driver was loaded with the force parameter,=
 the detection<br>+=C2=A0=C2=A0=C2=A0 =C2=A0* step shall be skipped. A posi=
tive kind means that the driver<br>+=C2=A0=C2=A0=C2=A0 =C2=A0* was loaded w=
ith the force parameter and a given kind of chip is<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0* requested, so both the detection and the identification steps<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0* are skipped.<br>+=C2=A0=C2=A0=C2=A0 =C2=A0*/<br=
>+=C2=A0=C2=A0=C2=A0 if (kind &lt; 0) {=C2=A0=C2=A0=C2=A0 /* detection */<b=
r>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((i2c_smbus_read_byte_data(new_=
client, LM95241_REG_R_MAN_ID)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0 !=3D MANUFACTURER_ID)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 || (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID=
)<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 &lt; DEFAULT_REVI=
SION)) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_d=
bg(&amp;adapter-&gt;dev,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 &quot;LM95241 detection failed at 0x%02x.\n=
&quot;,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 address);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 goto exit_free;<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 }<br>+<br>+=
=C2=A0=C2=A0=C2=A0 if (kind &lt;=3D 0) { /* identification */<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((i2c_smbus_read_byte_data(new_client, LM95=
241_REG_R_MAN_ID)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0 =3D=3D MANUFACTURER_ID)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 &amp;&amp; (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)<br=
>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 &gt;=3D DEFAULT_R=
EVISION)) {<br>+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 kind =3D lm95241;<br>+<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 if (kind &lt;=3D 0) { /* identification failed */<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_i=
nfo(&amp;adapter-&gt;dev, &quot;Unsupported chip\n&quot;);<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 goto exit_free;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0=
 }<br>+<br>+=C2=A0=C2=A0=C2=A0 if (kind =3D=3D lm95241)<br>+=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 name =3D &quot;lm95241&quot;;<br>+<br>+=C2=A0=C2=A0=
=C2=A0 /* We can fill in the remaining client fields */<br>+=C2=A0=C2=A0=C2=
=A0 strlcpy(new_client-&gt;name, name, I2C_NAME_SIZE);<br>
+=C2=A0=C2=A0=C2=A0 data-&gt;valid =3D 0;<br>+=C2=A0=C2=A0=C2=A0 mutex_init=
(&amp;data-&gt;update_lock);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Tell the I2C la=
yer a new client has arrived */<br>+=C2=A0=C2=A0=C2=A0 err =3D i2c_attach_c=
lient(new_client);<br>+=C2=A0=C2=A0=C2=A0 if (err)<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 goto exit_free;<br>
+<br>+=C2=A0=C2=A0=C2=A0 /* Initialize the LM95241 chip */<br>+=C2=A0=C2=A0=
=C2=A0 lm95241_init_client(new_client);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Regi=
ster sysfs hooks */<br>+=C2=A0=C2=A0=C2=A0 err =3D sysfs_create_group(&amp;=
new_client-&gt;dev.kobj, &amp;lm95241_group);<br>+=C2=A0=C2=A0=C2=A0 if (er=
r)<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto exit_detach;<br>+<br>+=C2=A0=C2=
=A0=C2=A0 data-&gt;hwmon_dev =3D hwmon_device_register(&amp;new_client-&gt;=
dev);<br>+=C2=A0=C2=A0=C2=A0 if (IS_ERR(data-&gt;hwmon_dev)) {<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(data-&gt;hwmon_dev);<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto exit_remove_files;<br>
+=C2=A0=C2=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 return 0;<br>+<br>+exit_r=
emove_files:<br>+=C2=A0=C2=A0=C2=A0 sysfs_remove_group(&amp;new_client-&gt;=
dev.kobj, &amp;lm95241_group);<br>+exit_detach:<br>+=C2=A0=C2=A0=C2=A0 i2c_=
detach_client(new_client);<br>+exit_free:<br>+=C2=A0=C2=A0=C2=A0 kfree(data=
);<br>
+exit:<br>+=C2=A0=C2=A0=C2=A0 return err;<br>+}<br>+<br>+static void lm9524=
1_init_client(struct i2c_client *client)<br>+{<br>+=C2=A0=C2=A0=C2=A0 struc=
t lm95241_data *data =3D i2c_get_clientdata(client);<br>+<br>+=C2=A0=C2=A0=
=C2=A0 data-&gt;rate =3D HZ;=C2=A0=C2=A0=C2=A0 /* 1 sec default */<br>
+=C2=A0=C2=A0=C2=A0 data-&gt;valid =3D 0;<br>+=C2=A0=C2=A0=C2=A0 data-&gt;c=
onfig =3D CFG_CR0076;<br>+=C2=A0=C2=A0=C2=A0 data-&gt;model =3D 0;<br>+=C2=
=A0=C2=A0=C2=A0 data-&gt;trutherm =3D (TT_OFF &lt;&lt; TT1_SHIFT) | (TT_OFF=
 &lt;&lt; TT2_SHIFT);<br>+<br>+=C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_data=
(client, LM95241_REG_RW_CONFIG,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 data-&gt;config);<br>+=C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_da=
ta(client, LM95241_REG_RW_REM_FILTER,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 R1FE_MASK | R2FE_MASK);=
<br>+=C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_TR=
UTHERM,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 data-&gt;trutherm);<br>+=C2=A0=C2=A0=C2=A0 i2c_smbus_write_byte_=
data(client, LM95241_REG_RW_REMOTE_MODEL,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 data-&gt;model);<br>=
+}<br>+<br>+static int lm95241_detach_client(struct i2c_client *client)<br>
+{<br>+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(=
client);<br>+=C2=A0=C2=A0=C2=A0 int err;<br>+<br>+=C2=A0=C2=A0=C2=A0 hwmon_=
device_unregister(data-&gt;hwmon_dev);<br>+=C2=A0=C2=A0=C2=A0 sysfs_remove_=
group(&amp;client-&gt;dev.kobj, &amp;lm95241_group);<br>+<br>
+=C2=A0=C2=A0=C2=A0 err =3D i2c_detach_client(client);<br>+=C2=A0=C2=A0=C2=
=A0 if (err)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>+<br>=
+=C2=A0=C2=A0=C2=A0 kfree(data);<br>+=C2=A0=C2=A0=C2=A0 return 0;<br>+}<br>=
+<br>+static struct lm95241_data *lm95241_update_device(struct device *dev)=
<br>+{<br>+=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D to_i2c_client(d=
ev);<br>
+=C2=A0=C2=A0=C2=A0 struct lm95241_data *data =3D i2c_get_clientdata(client=
);<br>+<br>+=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<=
br>+=C2=A0=C2=A0=C2=A0 if (time_after(jiffies, data-&gt;last_updated + data=
-&gt;rate) ||<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 !data-&gt;valid) {<=
br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_dbg(&amp;client-&gt;dev, &quot;U=
pdating lm95241 data.\n&quot;);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 d=
ata-&gt;local_h =3D<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 i2c_smbus_read_byte_data(client,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0LM95241_REG_R_LOCAL_TEMPH);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 data-&gt;local_l =3D<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_read_by=
te_data(client,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0LM95241_=
REG_R_LOCAL_TEMPL);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;remo=
te1_h =3D<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_=
smbus_read_byte_data(client,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0LM95241_REG_R_REMOTE1_TEMPH);<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;remote1_l =3D<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_read_byte_data(cl=
ient,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0LM95241_REG_R_REMO=
TE1_TEMPL);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;remote2_h =
=3D<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_=
read_byte_data(client,<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0LM95241_REG_R_REMOTE2_TEMPH=
);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;remote2_l =3D<br>+=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c_smbus_read_byte_d=
ata(client,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0LM95241_REG_=
R_REMOTE2_TEMPL);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;last_u=
pdated =3D jiffies;<br>
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;valid =3D 1;<br>+=C2=A0=C2=
=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;data-&gt;update_l=
ock);<br>+<br>+=C2=A0=C2=A0=C2=A0 return data;<br>+}<br>+<br>+static int __=
init sensors_lm95241_init(void)<br>+{<br>+=C2=A0=C2=A0=C2=A0 return i2c_add=
_driver(&amp;lm95241_driver);<br>
+}<br>+<br>+static void __exit sensors_lm95241_exit(void)<br>+{<br>+=C2=A0=
=C2=A0=C2=A0 i2c_del_driver(&amp;lm95241_driver);<br>+}<br>+<br>+MODULE_AUT=
HOR(&quot;Davide Rizzo &lt;<a href=3D"mailto:elpa.rizzo@gmail.com">elpa.riz=
zo@gmail.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;LM95241 sensor driver&quot;);<br>+MODULE_LICENSE(=
&quot;GPL&quot;);<br>+<br>+module_init(sensors_lm95241_init);<br>+module_ex=
it(sensors_lm95241_exit);<br>diff -urNp linux-2.6.28.5/drivers/hwmon/Makefi=
le linux-2.6.28.5.elpa/drivers/hwmon/Makefile<br>
--- linux-2.6.28.5/drivers/hwmon/Makefile=C2=A0=C2=A0=C2=A0 2008-12-25 00:2=
6:37.000000000 +0100<br>+++ linux-2.6.28.5.elpa/drivers/hwmon/Makefile=C2=
=A0=C2=A0=C2=A0 2009-01-04 08:14:42.000000000 +0100<br>@@ -62,6 +62,7 @@ ob=
j-$(CONFIG_SENSORS_LM87)=C2=A0=C2=A0=C2=A0 +=3D lm87.o<br>
=C2=A0obj-$(CONFIG_SENSORS_LM90)=C2=A0=C2=A0=C2=A0 +=3D lm90.o<br>=C2=A0obj=
-$(CONFIG_SENSORS_LM92)=C2=A0=C2=A0=C2=A0 +=3D lm92.o<br>=C2=A0obj-$(CONFIG=
_SENSORS_LM93)=C2=A0=C2=A0=C2=A0 +=3D lm93.o<br>+obj-$(CONFIG_SENSORS_LM952=
41)=C2=A0=C2=A0=C2=A0 +=3D lm95241.o<br>=C2=A0obj-$(CONFIG_SENSORS_MAX1111)=
=C2=A0=C2=A0=C2=A0 +=3D max1111.o<br>
=C2=A0obj-$(CONFIG_SENSORS_MAX1619)=C2=A0=C2=A0=C2=A0 +=3D max1619.o<br>=C2=
=A0obj-$(CONFIG_SENSORS_MAX6650)=C2=A0=C2=A0=C2=A0 +=3D max6650.o<br><br></=
div></div>

--0015174c34a21f6b240465cbc41b--


--===============2277600053434456250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2277600053434456250==--
