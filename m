From: Davide Rizzo <elpa.rizzo@gmail.com>
Date: Thu, 11 Nov 2010 18:18:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95241) Rewritten without using macros
Message-Id: <AANLkTinEzMPxEnrEY5K8u5qLkQutU0vdRh_vOGU=QOCF@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6971829182987204818=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
In-Reply-To: <AANLkTi=n7f_40ZdLBd4rYC-PgVABHp_gEWKm264n=yjC@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6971829182987204818==
Content-Type: multipart/alternative; boundary=00221532ce4ccbf85b0494cb0137

--00221532ce4ccbf85b0494cb0137
Content-Type: text/plain; charset=ISO-8859-1

> Hi Davide,
>
> this looks much better, and gives me a chance for a more complete
> review. Please see below.
>
> Unfortunately, I got hit with the MS Exchange server bug, meaning I can
> not apply your patch. So I might still miss something. Next time please
> copy lkml - that will give me a chance to retrieve the patch from
> patchwork.kernel.org.
>
> Thanks,
> Guenter
Hi Guenther, here is the driver again with requested modifies.
What do you mean with "copy lkml" ?
Regards
Davide

From: Davide Rizzo <elpa.rizzo@gmail.com>

Rewriting of driver/hwmon/lm95241.c to avoid using macros
Now it uses SENSOR_DEVICE_ATTR to distinguish similar attr.
Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com>
---
--- linux-2.6.37-rc1/drivers/hwmon/lm95241.c    2010-11-01
12:54:12.000000000 +0100
+++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c    2010-11-11
19:12:28.392515642 +0100
@@ -1,13 +1,9 @@
 /*
- * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware
- *             monitoring
- * Copyright (C) 2008 Davide Rizzo <elpa-rizzo@gmail.com>
+ * Copyright (C) 2008, 2010 Davide Rizzo <elpa.rizzo@gmail.com>
  *
- * Based on the max1619 driver. The LM95241 is a sensor chip made by
National
- *   Semiconductors.
- * It reports up to three temperatures (its own plus up to
- * two external ones). Complete datasheet can be
- * obtained from National's website at:
+ * The LM95241 is a sensor chip made by National Semiconductors.
+ * It reports up to three temperatures (its own plus up to two external
ones).
+ * Complete datasheet can be obtained from National's website at:
  *   http://www.national.com/ds.cgi/LM/LM95241.pdf
  *
  * This program is free software; you can redistribute it and/or modify
@@ -25,16 +21,13 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */

-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/mutex.h>
-#include <linux/sysfs.h>
+
+#define DEVNAME "lm95241"

 static const unsigned short normal_i2c[] = {
     0x19, 0x2a, 0x2b, I2C_CLIENT_END};
@@ -79,13 +72,14 @@ static const unsigned short normal_i2c[]
 #define MANUFACTURER_ID 0x01
 #define DEFAULT_REVISION 0xA4

-/* Conversions and various macros */
-#define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) - 0x100 : \
-    (val_h)) * 1000 + (val_l) * 1000 / 256)
-
-/* Functions declaration */
-static void lm95241_init_client(struct i2c_client *client);
-static struct lm95241_data *lm95241_update_device(struct device *dev);
+static const u8 lm95241_reg_address[] = {
+    LM95241_REG_R_LOCAL_TEMPH,
+    LM95241_REG_R_LOCAL_TEMPL,
+    LM95241_REG_R_REMOTE1_TEMPH,
+    LM95241_REG_R_REMOTE1_TEMPL,
+    LM95241_REG_R_REMOTE2_TEMPH,
+    LM95241_REG_R_REMOTE2_TEMPL
+};

 /* Client data (each client gets its own) */
 struct lm95241_data {
@@ -94,211 +88,230 @@ struct lm95241_data {
     unsigned long last_updated, interval; /* in jiffies */
     char valid; /* zero until following fields are valid */
     /* registers values */
-    u8 local_h, local_l; /* local */
-    u8 remote1_h, remote1_l; /* remote1 */
-    u8 remote2_h, remote2_l; /* remote2 */
+    u8 temp[ARRAY_SIZE(lm95241_reg_address)];
     u8 config, model, trutherm;
 };

+/* Conversions */
+static int TempFromReg(u8 val_h, u8 val_l)
+{
+    if (val_h & 0x80)
+        return val_h - 0x100;
+    return val_h * 1000 + val_l * 1000 / 256;
+}
+
+static struct lm95241_data *lm95241_update_device(struct device *dev)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    mutex_lock(&data->update_lock);
+
+    if (time_after(jiffies, data->last_updated + data->interval) ||
+        !data->valid) {
+        int i;
+
+        dev_dbg(&client->dev, "Updating lm95241 data.\n");
+        for (i = 0; i < ARRAY_SIZE(lm95241_reg_address); i++)
+            data->temp[i] = i2c_smbus_read_byte_data(client,
+                lm95241_reg_address[i]);
+        data->last_updated = jiffies;
+        data->valid = 1;
+    }
+
+    mutex_unlock(&data->update_lock);
+
+    return data;
+}
+
 /* Sysfs stuff */
-#define show_temp(value) \
-static ssize_t show_##value(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-    struct lm95241_data *data = lm95241_update_device(dev); \
-    snprintf(buf, PAGE_SIZE - 1, "%d\n", \
-        TEMP_FROM_REG(data->value##_h, data->value##_l)); \
-    return strlen(buf); \
-}
-show_temp(local);
-show_temp(remote1);
-show_temp(remote2);
+static ssize_t show_input(struct device *dev, struct device_attribute
*attr,
+              char *buf)
+{
+    struct lm95241_data *data = lm95241_update_device(dev);

-static ssize_t show_interval(struct device *dev, struct device_attribute
*attr,
+    return snprintf(buf, PAGE_SIZE - 1, "%d\n",
+         TempFromReg(data->temp[to_sensor_dev_attr(attr)->index],
+                 data->temp[to_sensor_dev_attr(attr)->index + 1]));
+}
+
+static ssize_t show_type(struct device *dev, struct device_attribute *attr,
              char *buf)
 {
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    return snprintf(buf, PAGE_SIZE - 1,
+         data->model & to_sensor_dev_attr(attr)->index ? "1\n" : "2\n");
+}
+
+static ssize_t set_type(struct device *dev, struct device_attribute *attr,
+            const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    unsigned long val;
+    int shift;
+    u8 mask = to_sensor_dev_attr(attr)->index;
+
+    if (strict_strtoul(buf, 10, &val) < 0)
+        return -EINVAL;
+
+    if (val != 1 && val != 2)
+        return -EINVAL;
+    shift = mask == R1MS_MASK ? TT1_SHIFT : TT2_SHIFT;
+
+    mutex_lock(&data->update_lock);
+
+    data->trutherm &= ~(TT_MASK << shift);
+    if (val == 1) {
+        data->model |= mask;
+        data->trutherm |= (TT_ON << shift);
+    } else {
+        data->model &= ~mask;
+        data->trutherm |= (TT_OFF << shift);
+    }
+
+    data->valid = 0;
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
+                  data->model);
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
+                  data->trutherm);
+
+    mutex_unlock(&data->update_lock);
+
+    return count;
+}
+
+static ssize_t show_min(struct device *dev, struct device_attribute *attr,
+            char *buf)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    return snprintf(buf, PAGE_SIZE - 1,
+         data->config & to_sensor_dev_attr(attr)->index ?
+         "-127000\n" : "0\n");
+}
+
+static ssize_t set_min(struct device *dev, struct device_attribute *attr,
+               const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    long val;
+
+    if (strict_strtol(buf, 10, &val) < 0)
+        return -EINVAL;
+    if (val < -128000)
+        return -EINVAL;
+
+    mutex_lock(&data->update_lock);
+
+    if (val < 0)
+        data->config |= to_sensor_dev_attr(attr)->index;
+    else
+        data->config &= ~to_sensor_dev_attr(attr)->index;
+    data->valid = 0;
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+    mutex_unlock(&data->update_lock);
+
+    return count;
+}
+
+static ssize_t show_max(struct device *dev, struct device_attribute *attr,
+            char *buf)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    return snprintf(buf, PAGE_SIZE - 1,
+         data->config & to_sensor_dev_attr(attr)->index ?
+         "127000\n" : "255000\n");
+}
+
+static ssize_t set_max(struct device *dev, struct device_attribute *attr,
+               const char *buf, size_t count)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct lm95241_data *data = i2c_get_clientdata(client);
+    long val;
+
+    if (strict_strtol(buf, 10, &val) < 0)
+        return -EINVAL;
+    if (val >= 256000)
+        return -EINVAL;
+
+    mutex_lock(&data->update_lock);
+
+    if (val <= 127000)
+        data->config |= to_sensor_dev_attr(attr)->index;
+    else
+        data->config &= ~to_sensor_dev_attr(attr)->index;
+    data->valid = 0;
+
+    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+
+    mutex_unlock(&data->update_lock);
+
+    return count;
+}
+
+static ssize_t show_interval(struct device *dev, struct device_attribute
*attr,
+                 char *buf)
+{
     struct lm95241_data *data = lm95241_update_device(dev);

-    snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval / HZ);
-    return strlen(buf);
+    return snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->interval
+            / HZ);
 }

 static ssize_t set_interval(struct device *dev, struct device_attribute
*attr,
-            const char *buf, size_t count)
+                const char *buf, size_t count)
 {
     struct i2c_client *client = to_i2c_client(dev);
     struct lm95241_data *data = i2c_get_clientdata(client);
+    unsigned long val;
+
+    if (strict_strtoul(buf, 10, &val) < 0)
+        return -EINVAL;

-    strict_strtol(buf, 10, &data->interval);
-    data->interval = data->interval * HZ / 1000;
+    data->interval = val * HZ / 1000;

     return count;
 }

-#define show_type(flag) \
-static ssize_t show_type##flag(struct device *dev, \
-                   struct device_attribute *attr, char *buf) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    snprintf(buf, PAGE_SIZE - 1, \
-        data->model & R##flag##MS_MASK ? "1\n" : "2\n"); \
-    return strlen(buf); \
-}
-show_type(1);
-show_type(2);
-
-#define show_min(flag) \
-static ssize_t show_min##flag(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    snprintf(buf, PAGE_SIZE - 1, \
-        data->config & R##flag##DF_MASK ?    \
-        "-127000\n" : "0\n"); \
-    return strlen(buf); \
-}
-show_min(1);
-show_min(2);
-
-#define show_max(flag) \
-static ssize_t show_max##flag(struct device *dev, \
-    struct device_attribute *attr, char *buf) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    snprintf(buf, PAGE_SIZE - 1, \
-        data->config & R##flag##DF_MASK ? \
-        "127000\n" : "255000\n"); \
-    return strlen(buf); \
-}
-show_max(1);
-show_max(2);
-
-#define set_type(flag) \
-static ssize_t set_type##flag(struct device *dev, \
-                  struct device_attribute *attr, \
-                  const char *buf, size_t count) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    long val; \
-    strict_strtol(buf, 10, &val); \
-\
-    if ((val == 1) || (val == 2)) { \
-\
-        mutex_lock(&data->update_lock); \
-\
-        data->trutherm &= ~(TT_MASK << TT##flag##_SHIFT); \
-        if (val == 1) { \
-            data->model |= R##flag##MS_MASK; \
-            data->trutherm |= (TT_ON << TT##flag##_SHIFT); \
-        } \
-        else { \
-            data->model &= ~R##flag##MS_MASK; \
-            data->trutherm |= (TT_OFF << TT##flag##_SHIFT); \
-        } \
-\
-        data->valid = 0; \
-\
-        i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL, \
-                      data->model); \
-        i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM, \
-                      data->trutherm); \
-\
-        mutex_unlock(&data->update_lock); \
-\
-    } \
-    return count; \
-}
-set_type(1);
-set_type(2);
-
-#define set_min(flag) \
-static ssize_t set_min##flag(struct device *dev, \
-    struct device_attribute *devattr, const char *buf, size_t count) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    long val; \
-    strict_strtol(buf, 10, &val); \
-\
-    mutex_lock(&data->update_lock); \
-\
-    if (val < 0) \
-        data->config |= R##flag##DF_MASK; \
-    else \
-        data->config &= ~R##flag##DF_MASK; \
-\
-    data->valid = 0; \
-\
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
-        data->config); \
-\
-    mutex_unlock(&data->update_lock); \
-\
-    return count; \
-}
-set_min(1);
-set_min(2);
-
-#define set_max(flag) \
-static ssize_t set_max##flag(struct device *dev, \
-    struct device_attribute *devattr, const char *buf, size_t count) \
-{ \
-    struct i2c_client *client = to_i2c_client(dev); \
-    struct lm95241_data *data = i2c_get_clientdata(client); \
-\
-    long val; \
-    strict_strtol(buf, 10, &val); \
-\
-    mutex_lock(&data->update_lock); \
-\
-    if (val <= 127000) \
-        data->config |= R##flag##DF_MASK; \
-    else \
-        data->config &= ~R##flag##DF_MASK; \
-\
-    data->valid = 0; \
-\
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, \
-        data->config); \
-\
-    mutex_unlock(&data->update_lock); \
-\
-    return count; \
-}
-set_max(1);
-set_max(2);
-
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_local, NULL);
-static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote1, NULL);
-static DEVICE_ATTR(temp3_input, S_IRUGO, show_remote2, NULL);
-static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type1, set_type1);
-static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type2, set_type2);
-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min1, set_min1);
-static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min2, set_min2);
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max1, set_max1);
-static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max2, set_max2);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type,
set_type,
+              R1MS_MASK);
+static SENSOR_DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type,
set_type,
+              R2MS_MASK);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min,
+              R1DF_MASK);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min,
+              R2DF_MASK);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max,
+              R1DF_MASK);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max,
+              R2DF_MASK);
 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
            set_interval);

 static struct attribute *lm95241_attributes[] = {
-    &dev_attr_temp1_input.attr,
-    &dev_attr_temp2_input.attr,
-    &dev_attr_temp3_input.attr,
-    &dev_attr_temp2_type.attr,
-    &dev_attr_temp3_type.attr,
-    &dev_attr_temp2_min.attr,
-    &dev_attr_temp3_min.attr,
-    &dev_attr_temp2_max.attr,
-    &dev_attr_temp3_max.attr,
+    &sensor_dev_attr_temp1_input.dev_attr.attr,
+    &sensor_dev_attr_temp2_input.dev_attr.attr,
+    &sensor_dev_attr_temp3_input.dev_attr.attr,
+    &sensor_dev_attr_temp2_type.dev_attr.attr,
+    &sensor_dev_attr_temp3_type.dev_attr.attr,
+    &sensor_dev_attr_temp2_min.dev_attr.attr,
+    &sensor_dev_attr_temp3_min.dev_attr.attr,
+    &sensor_dev_attr_temp2_max.dev_attr.attr,
+    &sensor_dev_attr_temp3_max.dev_attr.attr,
     &dev_attr_update_interval.attr,
     NULL
 };
@@ -322,7 +335,7 @@ static int lm95241_detect(struct i2c_cli
          == MANUFACTURER_ID)
      && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
          >= DEFAULT_REVISION)) {
-        name = "lm95241";
+        name = DEVNAME;
     } else {
         dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
             address);
@@ -334,6 +347,26 @@ static int lm95241_detect(struct i2c_cli
     return 0;
 }

+static void lm95241_init_client(struct i2c_client *client)
+{
+    struct lm95241_data *data = i2c_get_clientdata(client);
+
+    data->interval = HZ;    /* 1 sec default */
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
 static int lm95241_probe(struct i2c_client *new_client,
              const struct i2c_device_id *id)
 {
@@ -373,26 +406,6 @@ exit:
     return err;
 }

-static void lm95241_init_client(struct i2c_client *client)
-{
-    struct lm95241_data *data = i2c_get_clientdata(client);
-
-    data->interval = HZ;    /* 1 sec default */
-    data->valid = 0;
-    data->config = CFG_CR0076;
-    data->model = 0;
-    data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
-
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,
-                  data->config);
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,
-                  R1FE_MASK | R2FE_MASK);
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,
-                  data->trutherm);
-    i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,
-                  data->model);
-}
-
 static int lm95241_remove(struct i2c_client *client)
 {
     struct lm95241_data *data = i2c_get_clientdata(client);
@@ -404,46 +417,9 @@ static int lm95241_remove(struct i2c_cli
     return 0;
 }

-static struct lm95241_data *lm95241_update_device(struct device *dev)
-{
-    struct i2c_client *client = to_i2c_client(dev);
-    struct lm95241_data *data = i2c_get_clientdata(client);
-
-    mutex_lock(&data->update_lock);
-
-    if (time_after(jiffies, data->last_updated + data->interval) ||
-        !data->valid) {
-        dev_dbg(&client->dev, "Updating lm95241 data.\n");
-        data->local_h =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_LOCAL_TEMPH);
-        data->local_l =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_LOCAL_TEMPL);
-        data->remote1_h =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_REMOTE1_TEMPH);
-        data->remote1_l =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_REMOTE1_TEMPL);
-        data->remote2_h =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_REMOTE2_TEMPH);
-        data->remote2_l =
-            i2c_smbus_read_byte_data(client,
-                         LM95241_REG_R_REMOTE2_TEMPL);
-        data->last_updated = jiffies;
-        data->valid = 1;
-    }
-
-    mutex_unlock(&data->update_lock);
-
-    return data;
-}
-
 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95241_id[] = {
-    { "lm95241", 0 },
+    { DEVNAME, 0 },
     { }
 };
 MODULE_DEVICE_TABLE(i2c, lm95241_id);
@@ -451,7 +427,7 @@ MODULE_DEVICE_TABLE(i2c, lm95241_id);
 static struct i2c_driver lm95241_driver = {
     .class        = I2C_CLASS_HWMON,
     .driver = {
-        .name   = "lm95241",
+        .name   = DEVNAME,
     },
     .probe        = lm95241_probe,
     .remove        = lm95241_remove,
@@ -470,9 +446,10 @@ static void __exit sensors_lm95241_exit(
     i2c_del_driver(&lm95241_driver);
 }

-MODULE_AUTHOR("Davide Rizzo <elpa-rizzo@gmail.com>");
+MODULE_AUTHOR("Davide Rizzo <elpa.rizzo@gmail.com>");
 MODULE_DESCRIPTION("LM95241 sensor driver");
 MODULE_LICENSE("GPL");

 module_init(sensors_lm95241_init);
 module_exit(sensors_lm95241_exit);
+

--00221532ce4ccbf85b0494cb0137
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"im">
</div>&gt; Hi Davide,<br>
&gt; <br>&gt; this looks much better, and gives me a chance for a more comp=
lete<br>&gt; review. Please see below.<br>&gt; <br>&gt; Unfortunately, I go=
t hit with the MS Exchange server bug, meaning I can<br>&gt; not apply your=
 patch. So I might still miss something. Next time please<br>
&gt; copy lkml - that will give me a chance to retrieve the patch from<br>&=
gt; <a href=3D"http://patchwork.kernel.org/" target=3D"_blank">patchwork.ke=
rnel.org</a>.<br>&gt; <br>&gt; Thanks,<br>&gt; Guenter<br>
Hi Guenther, here is the driver again with requested modifies.<br>What do y=
ou mean with &quot;copy lkml&quot; ?<br>Regards<br>Davide<br><br>From: Davi=
de Rizzo &lt;<a href=3D"mailto:elpa.rizzo@gmail.com">elpa.rizzo@gmail.com</=
a>&gt;<br>
<br>Rewriting of driver/hwmon/lm95241.c to avoid using macros<br>Now it use=
s SENSOR_DEVICE_ATTR to distinguish similar attr.<br>Signed-off-by: Davide =
Rizzo &lt;<a href=3D"mailto:elpa.rizzo@gmail.com">elpa.rizzo@gmail.com</a>&=
gt;<br>
---<br>--- linux-2.6.37-rc1/drivers/hwmon/lm95241.c=A0=A0=A0 2010-11-01 12:=
54:12.000000000 +0100<br>+++ linux-2.6.37-rc1.elpa/drivers/hwmon/lm95241.c=
=A0=A0=A0 2010-11-11 19:12:28.392515642 +0100<br>@@ -1,13 +1,9 @@<br>=A0/*<=
br>- * lm95241.c - Part of lm_sensors, Linux kernel modules for hardware<br=
>
- *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 monitoring<br>- * Copyright (C) 200=
8 Davide Rizzo &lt;<a href=3D"mailto:elpa-rizzo@gmail.com">elpa-rizzo@gmail=
.com</a>&gt;<br>+ * Copyright (C) 2008, 2010 Davide Rizzo &lt;<a href=3D"ma=
ilto:elpa.rizzo@gmail.com">elpa.rizzo@gmail.com</a>&gt;<br>
=A0 *<br>- * Based on the max1619 driver. The LM95241 is a sensor chip made=
 by National<br>- *=A0=A0 Semiconductors.<br>- * It reports up to three tem=
peratures (its own plus up to<br>- * two external ones). Complete datasheet=
 can be<br>
- * obtained from National&#39;s website at:<br>+ * The LM95241 is a sensor=
 chip made by National Semiconductors.<br>+ * It reports up to three temper=
atures (its own plus up to two external ones).<br>+ * Complete datasheet ca=
n be obtained from National&#39;s website at:<br>
=A0 *=A0=A0 <a href=3D"http://www.national.com/ds.cgi/LM/LM95241.pdf">http:=
//www.national.com/ds.cgi/LM/LM95241.pdf</a><br>=A0 *<br>=A0 * This program=
 is free software; you can redistribute it and/or modify<br>@@ -25,16 +21,1=
3 @@<br>
=A0 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.<br>=A0 */<b=
r>=A0<br>-#include &lt;linux/module.h&gt;<br>-#include &lt;linux/init.h&gt;=
<br>=A0#include &lt;linux/slab.h&gt;<br>-#include &lt;linux/jiffies.h&gt;<b=
r>=A0#include &lt;linux/i2c.h&gt;<br>
=A0#include &lt;linux/hwmon.h&gt;<br>=A0#include &lt;linux/hwmon-sysfs.h&gt=
;<br>=A0#include &lt;linux/err.h&gt;<br>-#include &lt;linux/mutex.h&gt;<br>=
-#include &lt;linux/sysfs.h&gt;<br>+<br>+#define DEVNAME &quot;lm95241&quot=
;<br>
=A0<br>=A0static const unsigned short normal_i2c[] =3D {<br>=A0=A0=A0=A0 0x=
19, 0x2a, 0x2b, I2C_CLIENT_END};<br>@@ -79,13 +72,14 @@ static const unsign=
ed short normal_i2c[]<br>=A0#define MANUFACTURER_ID 0x01<br>=A0#define DEFA=
ULT_REVISION 0xA4<br>
=A0<br>-/* Conversions and various macros */<br>-#define TEMP_FROM_REG(val_=
h, val_l) (((val_h) &amp; 0x80 ? (val_h) - 0x100 : \<br>-=A0=A0=A0 (val_h))=
 * 1000 + (val_l) * 1000 / 256)<br>-<br>-/* Functions declaration */<br>-st=
atic void lm95241_init_client(struct i2c_client *client);<br>
-static struct lm95241_data *lm95241_update_device(struct device *dev);<br>=
+static const u8 lm95241_reg_address[] =3D {<br>+=A0=A0=A0 LM95241_REG_R_LO=
CAL_TEMPH,<br>+=A0=A0=A0 LM95241_REG_R_LOCAL_TEMPL,<br>+=A0=A0=A0 LM95241_R=
EG_R_REMOTE1_TEMPH,<br>
+=A0=A0=A0 LM95241_REG_R_REMOTE1_TEMPL,<br>+=A0=A0=A0 LM95241_REG_R_REMOTE2=
_TEMPH,<br>+=A0=A0=A0 LM95241_REG_R_REMOTE2_TEMPL<br>+};<br>=A0<br>=A0/* Cl=
ient data (each client gets its own) */<br>=A0struct lm95241_data {<br>@@ -=
94,211 +88,230 @@ struct lm95241_data {<br>
=A0=A0=A0=A0 unsigned long last_updated, interval; /* in jiffies */<br>=A0=
=A0=A0=A0 char valid; /* zero until following fields are valid */<br>=A0=A0=
=A0=A0 /* registers values */<br>-=A0=A0=A0 u8 local_h, local_l; /* local *=
/<br>-=A0=A0=A0 u8 remote1_h, remote1_l; /* remote1 */<br>
-=A0=A0=A0 u8 remote2_h, remote2_l; /* remote2 */<br>+=A0=A0=A0 u8 temp[ARR=
AY_SIZE(lm95241_reg_address)];<br>=A0=A0=A0=A0 u8 config, model, trutherm;<=
br>=A0};<br>=A0<br>+/* Conversions */<br>+static int TempFromReg(u8 val_h, =
u8 val_l)<br>+{<br>+=A0=A0=A0 if (val_h &amp; 0x80)<br>
+=A0=A0=A0 =A0=A0=A0 return val_h - 0x100;<br>+=A0=A0=A0 return val_h * 100=
0 + val_l * 1000 / 256;<br>+}<br>+<br>+static struct lm95241_data *lm95241_=
update_device(struct device *dev)<br>+{<br>+=A0=A0=A0 struct i2c_client *cl=
ient =3D to_i2c_client(dev);<br>
+=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+<b=
r>+=A0=A0=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<br>+=A0=A0=A0 if (=
time_after(jiffies, data-&gt;last_updated + data-&gt;interval) ||<br>+=A0=
=A0=A0 =A0=A0=A0 !data-&gt;valid) {<br>
+=A0=A0=A0 =A0=A0=A0 int i;<br>+<br>+=A0=A0=A0 =A0=A0=A0 dev_dbg(&amp;clien=
t-&gt;dev, &quot;Updating lm95241 data.\n&quot;);<br>+=A0=A0=A0 =A0=A0=A0 f=
or (i =3D 0; i &lt; ARRAY_SIZE(lm95241_reg_address); i++)<br>+=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 data-&gt;temp[i] =3D i2c_smbus_read_byte_data(client,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 lm95241_reg_address[i]);<br>+=A0=
=A0=A0 =A0=A0=A0 data-&gt;last_updated =3D jiffies;<br>+=A0=A0=A0 =A0=A0=A0=
 data-&gt;valid =3D 1;<br>+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 mutex_unlock(&amp=
;data-&gt;update_lock);<br>+<br>+=A0=A0=A0 return data;<br>+}<br>+<br>
=A0/* Sysfs stuff */<br>-#define show_temp(value) \<br>-static ssize_t show=
_##value(struct device *dev, \<br>-=A0=A0=A0 struct device_attribute *attr,=
 char *buf) \<br>-{ \<br>-=A0=A0=A0 struct lm95241_data *data =3D lm95241_u=
pdate_device(dev); \<br>
-=A0=A0=A0 snprintf(buf, PAGE_SIZE - 1, &quot;%d\n&quot;, \<br>-=A0=A0=A0 =
=A0=A0=A0 TEMP_FROM_REG(data-&gt;value##_h, data-&gt;value##_l)); \<br>-=A0=
=A0=A0 return strlen(buf); \<br>-}<br>-show_temp(local);<br>-show_temp(remo=
te1);<br>-show_temp(remote2);<br>
+static ssize_t show_input(struct device *dev, struct device_attribute *att=
r,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 char *buf)<br>+{<br>+=A0=A0=A0 str=
uct lm95241_data *data =3D lm95241_update_device(dev);<br>=A0<br>-static ss=
ize_t show_interval(struct device *dev, struct device_attribute *attr,<br>
+=A0=A0=A0 return snprintf(buf, PAGE_SIZE - 1, &quot;%d\n&quot;,<br>+=A0=A0=
=A0 =A0=A0=A0 =A0TempFromReg(data-&gt;temp[to_sensor_dev_attr(attr)-&gt;ind=
ex],<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 data-&gt;temp[to_sensor=
_dev_attr(attr)-&gt;index + 1]));<br>+}<br>
+<br>+static ssize_t show_type(struct device *dev, struct device_attribute =
*attr,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0char *buf)<br>=A0{<br>+=A0=A0=
=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=A0=A0=A0 struct =
lm95241_data *data =3D i2c_get_clientdata(client);<br>
+<br>+=A0=A0=A0 return snprintf(buf, PAGE_SIZE - 1,<br>+=A0=A0=A0 =A0=A0=A0=
 =A0data-&gt;model &amp; to_sensor_dev_attr(attr)-&gt;index ? &quot;1\n&quo=
t; : &quot;2\n&quot;);<br>+}<br>+<br>+static ssize_t set_type(struct device=
 *dev, struct device_attribute *attr,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 const char *buf, size_t count)<br>+{<br>+=A0=
=A0=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=A0=A0=A0 stru=
ct lm95241_data *data =3D i2c_get_clientdata(client);<br>+=A0=A0=A0 unsigne=
d long val;<br>+=A0=A0=A0 int shift;<br>+=A0=A0=A0 u8 mask =3D to_sensor_de=
v_attr(attr)-&gt;index;<br>
+<br>+=A0=A0=A0 if (strict_strtoul(buf, 10, &amp;val) &lt; 0)<br>+=A0=A0=A0=
 =A0=A0=A0 return -EINVAL;<br>+<br>+=A0=A0=A0 if (val !=3D 1 &amp;&amp; val=
 !=3D 2)<br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 shift =3D ma=
sk =3D=3D R1MS_MASK ? TT1_SHIFT : TT2_SHIFT;<br>
+<br>+=A0=A0=A0 mutex_lock(&amp;data-&gt;update_lock);<br>+<br>+=A0=A0=A0 d=
ata-&gt;trutherm &amp;=3D ~(TT_MASK &lt;&lt; shift);<br>+=A0=A0=A0 if (val =
=3D=3D 1) {<br>+=A0=A0=A0 =A0=A0=A0 data-&gt;model |=3D mask;<br>+=A0=A0=A0=
 =A0=A0=A0 data-&gt;trutherm |=3D (TT_ON &lt;&lt; shift);<br>
+=A0=A0=A0 } else {<br>+=A0=A0=A0 =A0=A0=A0 data-&gt;model &amp;=3D ~mask;<=
br>+=A0=A0=A0 =A0=A0=A0 data-&gt;trutherm |=3D (TT_OFF &lt;&lt; shift);<br>=
+=A0=A0=A0 }<br>+<br>+=A0=A0=A0 data-&gt;valid =3D 0;<br>+<br>+=A0=A0=A0 i2=
c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;model);<br>+=A0=A0=A0=
 i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;trutherm);<br>+<br>+=A0=A0=A0 mu=
tex_unlock(&amp;data-&gt;update_lock);<br>+<br>+=A0=A0=A0 return count;<br>
+}<br>+<br>+static ssize_t show_min(struct device *dev, struct device_attri=
bute *attr,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 char *buf)<br>+{<br>+=A0=A0=
=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=A0=A0=A0 struct =
lm95241_data *data =3D i2c_get_clientdata(client);<br>
+<br>+=A0=A0=A0 return snprintf(buf, PAGE_SIZE - 1,<br>+=A0=A0=A0 =A0=A0=A0=
 =A0data-&gt;config &amp; to_sensor_dev_attr(attr)-&gt;index ?<br>+=A0=A0=
=A0 =A0=A0=A0 =A0&quot;-127000\n&quot; : &quot;0\n&quot;);<br>+}<br>+<br>+s=
tatic ssize_t set_min(struct device *dev, struct device_attribute *attr,<br=
>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 const char *buf, size_t count)<br>+=
{<br>+=A0=A0=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=A0=
=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+=A0=A0=
=A0 long val;<br>+<br>+=A0=A0=A0 if (strict_strtol(buf, 10, &amp;val) &lt; =
0)<br>
+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 if (val &lt; -128000)<br=
>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+<br>+=A0=A0=A0 mutex_lock(&amp;da=
ta-&gt;update_lock);<br>+<br>+=A0=A0=A0 if (val &lt; 0)<br>+=A0=A0=A0 =A0=
=A0=A0 data-&gt;config |=3D to_sensor_dev_attr(attr)-&gt;index;<br>
+=A0=A0=A0 else<br>+=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp;=3D ~to_sensor=
_dev_attr(attr)-&gt;index;<br>+=A0=A0=A0 data-&gt;valid =3D 0;<br>+<br>+=A0=
=A0=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data-&gt;co=
nfig);<br>+<br>+=A0=A0=A0 mutex_unlock(&amp;data-&gt;update_lock);<br>
+<br>+=A0=A0=A0 return count;<br>+}<br>+<br>+static ssize_t show_max(struct=
 device *dev, struct device_attribute *attr,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 char *buf)<br>+{<br>+=A0=A0=A0 struct i2c_client *client =3D to_i2c_cli=
ent(dev);<br>+=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(cl=
ient);<br>
+<br>+=A0=A0=A0 return snprintf(buf, PAGE_SIZE - 1,<br>+=A0=A0=A0 =A0=A0=A0=
 =A0data-&gt;config &amp; to_sensor_dev_attr(attr)-&gt;index ?<br>+=A0=A0=
=A0 =A0=A0=A0 =A0&quot;127000\n&quot; : &quot;255000\n&quot;);<br>+}<br>+<b=
r>+static ssize_t set_max(struct device *dev, struct device_attribute *attr=
,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 const char *buf, size_t count)<br>+=
{<br>+=A0=A0=A0 struct i2c_client *client =3D to_i2c_client(dev);<br>+=A0=
=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+=A0=A0=
=A0 long val;<br>+<br>+=A0=A0=A0 if (strict_strtol(buf, 10, &amp;val) &lt; =
0)<br>
+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+=A0=A0=A0 if (val &gt;=3D 256000)<=
br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>+<br>+=A0=A0=A0 mutex_lock(&amp;=
data-&gt;update_lock);<br>+<br>+=A0=A0=A0 if (val &lt;=3D 127000)<br>+=A0=
=A0=A0 =A0=A0=A0 data-&gt;config |=3D to_sensor_dev_attr(attr)-&gt;index;<b=
r>
+=A0=A0=A0 else<br>+=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp;=3D ~to_sensor=
_dev_attr(attr)-&gt;index;<br>+=A0=A0=A0 data-&gt;valid =3D 0;<br>+<br>+=A0=
=A0=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data-&gt;co=
nfig);<br>+<br>+=A0=A0=A0 mutex_unlock(&amp;data-&gt;update_lock);<br>
+<br>+=A0=A0=A0 return count;<br>+}<br>+<br>+static ssize_t show_interval(s=
truct device *dev, struct device_attribute *attr,<br>+=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0=A0 char *buf)<br>+{<br>=A0=A0=A0=A0 struct lm95241_data=
 *data =3D lm95241_update_device(dev);<br>
=A0<br>-=A0=A0=A0 snprintf(buf, PAGE_SIZE - 1, &quot;%lu\n&quot;, 1000 * da=
ta-&gt;interval / HZ);<br>-=A0=A0=A0 return strlen(buf);<br>+=A0=A0=A0 retu=
rn snprintf(buf, PAGE_SIZE - 1, &quot;%lu\n&quot;, 1000 * data-&gt;interval=
<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 / HZ);<br>
=A0}<br>=A0<br>=A0static ssize_t set_interval(struct device *dev, struct de=
vice_attribute *attr,<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 const char *buf, si=
ze_t count)<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 const char *buf, si=
ze_t count)<br>=A0{<br>=A0=A0=A0=A0 struct i2c_client *client =3D to_i2c_cl=
ient(dev);<br>
=A0=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+=
=A0=A0=A0 unsigned long val;<br>+<br>+=A0=A0=A0 if (strict_strtoul(buf, 10,=
 &amp;val) &lt; 0)<br>+=A0=A0=A0 =A0=A0=A0 return -EINVAL;<br>=A0<br>-=A0=
=A0=A0 strict_strtol(buf, 10, &amp;data-&gt;interval);<br>
-=A0=A0=A0 data-&gt;interval =3D data-&gt;interval * HZ / 1000;<br>+=A0=A0=
=A0 data-&gt;interval =3D val * HZ / 1000;<br>=A0<br>=A0=A0=A0=A0 return co=
unt;<br>=A0}<br>=A0<br>-#define show_type(flag) \<br>-static ssize_t show_t=
ype##flag(struct device *dev, \<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 struct device_attribute *at=
tr, char *buf) \<br>-{ \<br>-=A0=A0=A0 struct i2c_client *client =3D to_i2c=
_client(dev); \<br>-=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientd=
ata(client); \<br>-\<br>-=A0=A0=A0 snprintf(buf, PAGE_SIZE - 1, \<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;model &amp; R##flag##MS_MASK ? &quot;1\n&quot=
; : &quot;2\n&quot;); \<br>-=A0=A0=A0 return strlen(buf); \<br>-}<br>-show_=
type(1);<br>-show_type(2);<br>-<br>-#define show_min(flag) \<br>-static ssi=
ze_t show_min##flag(struct device *dev, \<br>
-=A0=A0=A0 struct device_attribute *attr, char *buf) \<br>-{ \<br>-=A0=A0=
=A0 struct i2c_client *client =3D to_i2c_client(dev); \<br>-=A0=A0=A0 struc=
t lm95241_data *data =3D i2c_get_clientdata(client); \<br>-\<br>-=A0=A0=A0 =
snprintf(buf, PAGE_SIZE - 1, \<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp; R##flag##DF_MASK ?=A0=A0=A0 \<br=
>-=A0=A0=A0 =A0=A0=A0 &quot;-127000\n&quot; : &quot;0\n&quot;); \<br>-=A0=
=A0=A0 return strlen(buf); \<br>-}<br>-show_min(1);<br>-show_min(2);<br>-<b=
r>-#define show_max(flag) \<br>-static ssize_t show_max##flag(struct device=
 *dev, \<br>
-=A0=A0=A0 struct device_attribute *attr, char *buf) \<br>-{ \<br>-=A0=A0=
=A0 struct i2c_client *client =3D to_i2c_client(dev); \<br>-=A0=A0=A0 struc=
t lm95241_data *data =3D i2c_get_clientdata(client); \<br>-\<br>-=A0=A0=A0 =
snprintf(buf, PAGE_SIZE - 1, \<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp; R##flag##DF_MASK ? \<br>-=A0=A0=
=A0 =A0=A0=A0 &quot;127000\n&quot; : &quot;255000\n&quot;); \<br>-=A0=A0=A0=
 return strlen(buf); \<br>-}<br>-show_max(1);<br>-show_max(2);<br>-<br>-#de=
fine set_type(flag) \<br>-static ssize_t set_type##flag(struct device *dev,=
 \<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 struct device_attribute *attr,=
 \<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 const char *buf, size_t =
count) \<br>-{ \<br>-=A0=A0=A0 struct i2c_client *client =3D to_i2c_client(=
dev); \<br>-=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(clie=
nt); \<br>
-\<br>-=A0=A0=A0 long val; \<br>-=A0=A0=A0 strict_strtol(buf, 10, &amp;val)=
; \<br>-\<br>-=A0=A0=A0 if ((val =3D=3D 1) || (val =3D=3D 2)) { \<br>-\<br>=
-=A0=A0=A0 =A0=A0=A0 mutex_lock(&amp;data-&gt;update_lock); \<br>-\<br>-=A0=
=A0=A0 =A0=A0=A0 data-&gt;trutherm &amp;=3D ~(TT_MASK &lt;&lt; TT##flag##_S=
HIFT); \<br>
-=A0=A0=A0 =A0=A0=A0 if (val =3D=3D 1) { \<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 data-&gt;model |=3D R##flag##MS_MASK; \<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 data-&gt;trutherm |=3D (TT_ON &lt;&lt; TT##flag##_SHIFT); \<br>-=A0=A0=
=A0 =A0=A0=A0 } \<br>-=A0=A0=A0 =A0=A0=A0 else { \<br>-=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 data-&gt;model &amp;=3D ~R##flag##MS_MASK; \<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 data-&gt;trutherm |=3D (TT_OFF &lt;&lt; TT##=
flag##_SHIFT); \<br>-=A0=A0=A0 =A0=A0=A0 } \<br>-\<br>-=A0=A0=A0 =A0=A0=A0 =
data-&gt;valid =3D 0; \<br>-\<br>-=A0=A0=A0 =A0=A0=A0 i2c_smbus_write_byte_=
data(client, LM95241_REG_RW_REMOTE_MODEL, \<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;model); \<br>
-=A0=A0=A0 =A0=A0=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTH=
ERM, \<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;t=
rutherm); \<br>-\<br>-=A0=A0=A0 =A0=A0=A0 mutex_unlock(&amp;data-&gt;update=
_lock); \<br>-\<br>-=A0=A0=A0 } \<br>-=A0=A0=A0 return count; \<br>
-}<br>-set_type(1);<br>-set_type(2);<br>-<br>-#define set_min(flag) \<br>-s=
tatic ssize_t set_min##flag(struct device *dev, \<br>-=A0=A0=A0 struct devi=
ce_attribute *devattr, const char *buf, size_t count) \<br>-{ \<br>-=A0=A0=
=A0 struct i2c_client *client =3D to_i2c_client(dev); \<br>
-=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client); \<br>-=
\<br>-=A0=A0=A0 long val; \<br>-=A0=A0=A0 strict_strtol(buf, 10, &amp;val);=
 \<br>-\<br>-=A0=A0=A0 mutex_lock(&amp;data-&gt;update_lock); \<br>-\<br>-=
=A0=A0=A0 if (val &lt; 0) \<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;config |=3D R##flag##DF_MASK; \<br>-=A0=A0=A0=
 else \<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp;=3D ~R##flag##DF_MASK;=
 \<br>-\<br>-=A0=A0=A0 data-&gt;valid =3D 0; \<br>-\<br>-=A0=A0=A0 i2c_smbu=
s_write_byte_data(client, LM95241_REG_RW_CONFIG, \<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;config); \<br>-\<br>-=A0=A0=A0 mutex_unlock(&=
amp;data-&gt;update_lock); \<br>-\<br>-=A0=A0=A0 return count; \<br>-}<br>-=
set_min(1);<br>-set_min(2);<br>-<br>-#define set_max(flag) \<br>-static ssi=
ze_t set_max##flag(struct device *dev, \<br>
-=A0=A0=A0 struct device_attribute *devattr, const char *buf, size_t count)=
 \<br>-{ \<br>-=A0=A0=A0 struct i2c_client *client =3D to_i2c_client(dev); =
\<br>-=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client); \=
<br>-\<br>-=A0=A0=A0 long val; \<br>
-=A0=A0=A0 strict_strtol(buf, 10, &amp;val); \<br>-\<br>-=A0=A0=A0 mutex_lo=
ck(&amp;data-&gt;update_lock); \<br>-\<br>-=A0=A0=A0 if (val &lt;=3D 127000=
) \<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;config |=3D R##flag##DF_MASK; \<br>-=
=A0=A0=A0 else \<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;config &amp;=3D ~R##flag#=
#DF_MASK; \<br>
-\<br>-=A0=A0=A0 data-&gt;valid =3D 0; \<br>-\<br>-=A0=A0=A0 i2c_smbus_writ=
e_byte_data(client, LM95241_REG_RW_CONFIG, \<br>-=A0=A0=A0 =A0=A0=A0 data-&=
gt;config); \<br>-\<br>-=A0=A0=A0 mutex_unlock(&amp;data-&gt;update_lock); =
\<br>-\<br>-=A0=A0=A0 return count; \<br>
-}<br>-set_max(1);<br>-set_max(2);<br>-<br>-static DEVICE_ATTR(temp1_input,=
 S_IRUGO, show_local, NULL);<br>-static DEVICE_ATTR(temp2_input, S_IRUGO, s=
how_remote1, NULL);<br>-static DEVICE_ATTR(temp3_input, S_IRUGO, show_remot=
e2, NULL);<br>
-static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type1, set_type1);<=
br>-static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type2, set_type2=
);<br>-static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min1, set_min1=
);<br>
-static DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min2, set_min2);<br>=
-static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max1, set_max1);<br>=
-static DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max2, set_max2);<br>
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);<br>+=
static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 2);<br>+s=
tatic SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 4);<br>
+static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_ty=
pe,<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 R1MS_MASK);<br>+static SENSOR_DEV=
ICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type,<br>+=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0 R2MS_MASK);<br>
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min,=
<br>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 R1DF_MASK);<br>+static SENSOR_DEVICE=
_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min,<br>+=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0 R2DF_MASK);<br>+static SENSOR_DEVICE_ATTR(temp2_max, S_IW=
USR | S_IRUGO, show_max, set_max,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 R1DF_MASK);<br>+static SENSOR_DEVICE_ATT=
R(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max,<br>+=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0 R2DF_MASK);<br>=A0static DEVICE_ATTR(update_interval, S_IWUSR=
 | S_IRUGO, show_interval,<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0 set_interval);<=
br>
=A0<br>=A0static struct attribute *lm95241_attributes[] =3D {<br>-=A0=A0=A0=
 &amp;dev_attr_temp1_input.attr,<br>-=A0=A0=A0 &amp;dev_attr_temp2_input.at=
tr,<br>-=A0=A0=A0 &amp;dev_attr_temp3_input.attr,<br>-=A0=A0=A0 &amp;dev_at=
tr_temp2_type.attr,<br>-=A0=A0=A0 &amp;dev_attr_temp3_type.attr,<br>
-=A0=A0=A0 &amp;dev_attr_temp2_min.attr,<br>-=A0=A0=A0 &amp;dev_attr_temp3_=
min.attr,<br>-=A0=A0=A0 &amp;dev_attr_temp2_max.attr,<br>-=A0=A0=A0 &amp;de=
v_attr_temp3_max.attr,<br>+=A0=A0=A0 &amp;sensor_dev_attr_temp1_input.dev_a=
ttr.attr,<br>+=A0=A0=A0 &amp;sensor_dev_attr_temp2_input.dev_attr.attr,<br>
+=A0=A0=A0 &amp;sensor_dev_attr_temp3_input.dev_attr.attr,<br>+=A0=A0=A0 &a=
mp;sensor_dev_attr_temp2_type.dev_attr.attr,<br>+=A0=A0=A0 &amp;sensor_dev_=
attr_temp3_type.dev_attr.attr,<br>+=A0=A0=A0 &amp;sensor_dev_attr_temp2_min=
.dev_attr.attr,<br>+=A0=A0=A0 &amp;sensor_dev_attr_temp3_min.dev_attr.attr,=
<br>
+=A0=A0=A0 &amp;sensor_dev_attr_temp2_max.dev_attr.attr,<br>+=A0=A0=A0 &amp=
;sensor_dev_attr_temp3_max.dev_attr.attr,<br>=A0=A0=A0=A0 &amp;dev_attr_upd=
ate_interval.attr,<br>=A0=A0=A0=A0 NULL<br>=A0};<br>@@ -322,7 +335,7 @@ sta=
tic int lm95241_detect(struct i2c_cli<br>
=A0=A0=A0=A0 =A0=A0=A0=A0 =3D=3D MANUFACTURER_ID)<br>=A0=A0=A0=A0 =A0&amp;&=
amp; (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)<br>=A0=A0=
=A0=A0 =A0=A0=A0=A0 &gt;=3D DEFAULT_REVISION)) {<br>-=A0=A0=A0 =A0=A0=A0 na=
me =3D &quot;lm95241&quot;;<br>+=A0=A0=A0 =A0=A0=A0 name =3D DEVNAME;<br>
=A0=A0=A0=A0 } else {<br>=A0=A0=A0=A0 =A0=A0=A0 dev_dbg(&amp;adapter-&gt;de=
v, &quot;LM95241 detection failed at 0x%02x\n&quot;,<br>=A0=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 address);<br>@@ -334,6 +347,26 @@ static int lm95241_detect(s=
truct i2c_cli<br>=A0=A0=A0=A0 return 0;<br>=A0}<br>
=A0<br>+static void lm95241_init_client(struct i2c_client *client)<br>+{<br=
>+=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>+<=
br>+=A0=A0=A0 data-&gt;interval =3D HZ;=A0=A0=A0 /* 1 sec default */<br>+=
=A0=A0=A0 data-&gt;valid =3D 0;<br>
+=A0=A0=A0 data-&gt;config =3D CFG_CR0076;<br>+=A0=A0=A0 data-&gt;model =3D=
 0;<br>+=A0=A0=A0 data-&gt;trutherm =3D (TT_OFF &lt;&lt; TT1_SHIFT) | (TT_O=
FF &lt;&lt; TT2_SHIFT);<br>+<br>+=A0=A0=A0 i2c_smbus_write_byte_data(client=
, LM95241_REG_RW_CONFIG,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;config);<br>+=A0=A0=
=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,<br>+=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 R1FE_MASK | R2FE_MASK);<br>+=A0=A0=A0=
 i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,<br>
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;trutherm);<br>+=A0=A0=
=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,<br>+=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;model);<br>+}<br>+<br>=A0=
static int lm95241_probe(struct i2c_client *new_client,<br>
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0const struct i2c_device_id *id)<br>=A0{=
<br>@@ -373,26 +406,6 @@ exit:<br>=A0=A0=A0=A0 return err;<br>=A0}<br>=A0<b=
r>-static void lm95241_init_client(struct i2c_client *client)<br>-{<br>-=A0=
=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>
-<br>-=A0=A0=A0 data-&gt;interval =3D HZ;=A0=A0=A0 /* 1 sec default */<br>-=
=A0=A0=A0 data-&gt;valid =3D 0;<br>-=A0=A0=A0 data-&gt;config =3D CFG_CR007=
6;<br>-=A0=A0=A0 data-&gt;model =3D 0;<br>-=A0=A0=A0 data-&gt;trutherm =3D =
(TT_OFF &lt;&lt; TT1_SHIFT) | (TT_OFF &lt;&lt; TT2_SHIFT);<br>
-<br>-=A0=A0=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG,<br=
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;config);<br>-=A0=A0=
=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_REM_FILTER,<br>-=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 R1FE_MASK | R2FE_MASK);<br>
-=A0=A0=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_TRUTHERM,<br>-=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;trutherm);<br>-=A0=A0=
=A0 i2c_smbus_write_byte_data(client, LM95241_REG_RW_REMOTE_MODEL,<br>-=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 data-&gt;model);<br>-}<br>
-<br>=A0static int lm95241_remove(struct i2c_client *client)<br>=A0{<br>=A0=
=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>@@ -=
404,46 +417,9 @@ static int lm95241_remove(struct i2c_cli<br>=A0=A0=A0=A0 r=
eturn 0;<br>=A0}<br>
=A0<br>-static struct lm95241_data *lm95241_update_device(struct device *de=
v)<br>-{<br>-=A0=A0=A0 struct i2c_client *client =3D to_i2c_client(dev);<br=
>-=A0=A0=A0 struct lm95241_data *data =3D i2c_get_clientdata(client);<br>-<=
br>-=A0=A0=A0 mutex_lock(&amp;data-&gt;update_lock);<br>
-<br>-=A0=A0=A0 if (time_after(jiffies, data-&gt;last_updated + data-&gt;in=
terval) ||<br>-=A0=A0=A0 =A0=A0=A0 !data-&gt;valid) {<br>-=A0=A0=A0 =A0=A0=
=A0 dev_dbg(&amp;client-&gt;dev, &quot;Updating lm95241 data.\n&quot;);<br>=
-=A0=A0=A0 =A0=A0=A0 data-&gt;local_h =3D<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i2c_smbus_read_byte_data(client,<br>-=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG_R_LOCA=
L_TEMPH);<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;local_l =3D<br>-=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 i2c_smbus_read_byte_data(client,<br>-=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG_R_LOCAL_TEMPL);<br>
-=A0=A0=A0 =A0=A0=A0 data-&gt;remote1_h =3D<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 i2c_smbus_read_byte_data(client,<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG_R_REMOTE1_TEMPH);<br>-=A0=A0=A0 =
=A0=A0=A0 data-&gt;remote1_l =3D<br>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i2c_smbu=
s_read_byte_data(client,<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG=
_R_REMOTE1_TEMPL);<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;remote2_h =3D<br>-=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 i2c_smbus_read_byte_data(client,<br>-=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG_R_REMOTE2_=
TEMPH);<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;remote2_l =3D<br>
-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i2c_smbus_read_byte_data(client,<br>-=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0LM95241_REG_R_REMO=
TE2_TEMPL);<br>-=A0=A0=A0 =A0=A0=A0 data-&gt;last_updated =3D jiffies;<br>-=
=A0=A0=A0 =A0=A0=A0 data-&gt;valid =3D 1;<br>-=A0=A0=A0 }<br>-<br>-=A0=A0=
=A0 mutex_unlock(&amp;data-&gt;update_lock);<br>
-<br>-=A0=A0=A0 return data;<br>-}<br>-<br>=A0/* Driver data (common to all=
 clients) */<br>=A0static const struct i2c_device_id lm95241_id[] =3D {<br>=
-=A0=A0=A0 { &quot;lm95241&quot;, 0 },<br>+=A0=A0=A0 { DEVNAME, 0 },<br>=A0=
=A0=A0=A0 { }<br>=A0};<br>=A0MODULE_DEVICE_TABLE(i2c, lm95241_id);<br>
@@ -451,7 +427,7 @@ MODULE_DEVICE_TABLE(i2c, lm95241_id);<br>=A0static stru=
ct i2c_driver lm95241_driver =3D {<br>=A0=A0=A0=A0 .class=A0=A0=A0 =A0=A0=
=A0 =3D I2C_CLASS_HWMON,<br>=A0=A0=A0=A0 .driver =3D {<br>-=A0=A0=A0 =A0=A0=
=A0 .name=A0=A0 =3D &quot;lm95241&quot;,<br>+=A0=A0=A0 =A0=A0=A0 .name=A0=
=A0 =3D DEVNAME,<br>
=A0=A0=A0=A0 },<br>=A0=A0=A0=A0 .probe=A0=A0=A0 =A0=A0=A0 =3D lm95241_probe=
,<br>=A0=A0=A0=A0 .remove=A0=A0=A0 =A0=A0=A0 =3D lm95241_remove,<br>@@ -470=
,9 +446,10 @@ static void __exit sensors_lm95241_exit(<br>=A0=A0=A0=A0 i2c_=
del_driver(&amp;lm95241_driver);<br>=A0}<br>=A0<br>-MODULE_AUTHOR(&quot;Dav=
ide Rizzo &lt;<a href=3D"mailto:elpa-rizzo@gmail.com">elpa-rizzo@gmail.com<=
/a>&gt;&quot;);<br>
+MODULE_AUTHOR(&quot;Davide Rizzo &lt;<a href=3D"mailto:elpa.rizzo@gmail.co=
m">elpa.rizzo@gmail.com</a>&gt;&quot;);<br>=A0MODULE_DESCRIPTION(&quot;LM95=
241 sensor driver&quot;);<br>=A0MODULE_LICENSE(&quot;GPL&quot;);<br>=A0<br>=
=A0module_init(sensors_lm95241_init);<br>
=A0module_exit(sensors_lm95241_exit);<br>+<br><br>

--00221532ce4ccbf85b0494cb0137--


--===============6971829182987204818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6971829182987204818==--
