From: "Felten, Lothar" <l-felten@ti.com>
Date: Fri, 04 May 2012 08:20:08 +0000
Subject: [lm-sensors] [PATCH] INA219 and INA226 support
Message-Id: <28DAD847AEFDD344B2D3802E7670BEE116AD54B7@DNCE04.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch brings support for the Texas Instruments INA219 and INA226 power monitors.
It's a diff to linux-3.3.4

Files added:
Documentation/hwmon/ina2xx
drivers/hwmon/ina2xx.c

Files changed:
drivers/hwmon/Kconfig
drivers/hwmon/Makefile

- Lothar



diff -uprN a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
--- a/Documentation/hwmon/ina2xx        1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/hwmon/ina2xx        2012-05-04 09:49:35.927178705 +0200
@@ -0,0 +1,29 @@
+Kernel driver ina2xx
+==========
+
+Supported chips:
+  * Texas Instruments INA219
+    Prefix: 'ina219'
+    Addresses: I2C 0x40 - 0x4f
+    Datasheet: Publicly available at the Texas Instruments website
+               http://www.ti.com/
+
+  * Texas Instruments INA226
+    Prefix: 'ina226'
+    Addresses: I2C 0x40 - 0x4f
+    Datasheet: Publicly available at the Texas Instruments website
+               http://www.ti.com/
+
+Author: Lothar Felten <l-felten@ti.com>
+
+Description
+-----------
+
+The INA219 is a high-side current shunt and power monitor with an I2C
+interface. The INA219 monitors both shunt drop and supply voltage, with
+programmable conversion times and filtering.
+
+The INA226 is a current shunt and power monitor with an I2C interface.
+The INA226 monitors both a shunt voltage drop and bus supply voltage.
+
+The shunt value in milliohms can be set via the kernel config.
diff -uprN a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
--- a/drivers/hwmon/ina2xx.c    1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hwmon/ina2xx.c    2012-05-03 18:42:36.076172359 +0200
@@ -0,0 +1,357 @@
+/*
+ * Driver for Texas Instruments INA219, INA226
+ *
+ * INA219:
+ * Zero Drift Bi-Directional Current/Power Monitor with I2C Interface
+ * Datasheet: http://www.ti.com/product/ina219
+ *
+ * INA226:
+ * Bi-Directional Current/Power Monitor with I2C Interface
+ * Datasheet: http://www.ti.com/product/ina226
+ *
+ * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Thanks to Jan Volkering
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+/* register definitions */
+#define INA2XX_SHUNT_VOLTAGE           0x01
+#define        INA2XX_BUS_VOLTAGE              0x02
+#define        INA2XX_POWER                    0x03
+#define        INA2XX_CURRENT                  0x04
+
+#define        INA219_CONFIG                   0x00
+#define INA219_SHUNT_VOLTAGE           0x01    /* readonly */
+#define        INA219_BUS_VOLTAGE              0x02    /* readonly */
+#define        INA219_POWER                    0x03    /* readonly */
+#define        INA219_CURRENT                  0x04    /* readonly */
+#define        INA219_CALIBRATION              0x05
+#define INA219_REGISTERS               6
+
+#define        INA226_CONFIG                   0x00
+#define INA226_SHUNT_VOLTAGE           0x01    /* readonly */
+#define        INA226_BUS_VOLTAGE              0x02    /* readonly */
+#define        INA226_POWER                    0x03    /* readonly */
+#define        INA226_CURRENT                  0x04    /* readonly */
+#define        INA226_CALIBRATION              0x05
+#define        INA226_MASK_ENABLE              0x06
+#define        INA226_ALERT_LIMIT              0x07
+#define        INA226_DIE_ID                   0xFF
+#define INA226_REGISTERS               8
+
+#define INA2XX_MAX_REGISTERS           8
+
+/* settings - depend on use case */
+#define INA219_CONFIG_DEFAULT          0x219F  /* PGA=1, all others default */
+#define INA226_CONFIG_DEFAULT          0x4527  /* averages, all others default */
+#define INA2XX_CONVERSION_RATE         15      /* worst case is 68.10 ms (~14.6Hz, ina219) */
+
+/* from kernel configuartion */
+#define INA2XX_RSHUNT                  CONFIG_SENSORS_INA2XX_RSHUNT_MOHMS
+
+enum ina2xx_ids { ina219, ina226 };
+
+struct ina2xx_data {
+       struct device *hwmon_dev;
+
+       struct mutex update_lock;
+       bool valid;
+       unsigned long last_updated;
+
+       int kind;
+       int registers;
+       u16 regs[INA2XX_MAX_REGISTERS];
+};
+
+static struct ina2xx_data *ina2xx_update_device(struct device *dev)
+{
+       struct i2c_client *client = to_i2c_client(dev);
+       struct ina2xx_data *data = i2c_get_clientdata(client);
+       struct ina2xx_data *ret = data;
+
+       mutex_lock(&data->update_lock);
+
+       if (time_after(jiffies, data->last_updated + HZ / INA2XX_CONVERSION_RATE) || !data->valid) {
+               int i;
+
+               dev_dbg(&client->dev, "Starting ina2xx update\n");
+
+               /* Read all registers */
+               for (i = 0; i < data->registers; i++) {
+                       int val;
+
+                       val = be16_to_cpu(i2c_smbus_read_word_data(client, i));
+                       if (unlikely(val < 0)) {
+                               dev_dbg(dev,
+                                       "Failed to read register value: %d\n",
+                                       val);
+                               ret = ERR_PTR(val);
+                               goto abort;
+                       }
+                       data->regs[i] = val;
+               }
+               data->last_updated = jiffies;
+               data->valid = 1;
+       }
+abort:
+       mutex_unlock(&data->update_lock);
+       return ret;
+}
+
+static int ina219_get_value(struct ina2xx_data *data, u8 reg)
+{
+       /*
+        * calculate exact value for the given register
+        * we assume default power-on reset settings:
+        * bus voltage range 32V
+        * gain = /8
+        * adc 1 & 2 -> conversion time 532uS
+        * mode is continuous shunt and bus
+        * calibration value is INA219_CALIBRATION_VALUE */
+       int val;
+
+       val = data->regs[reg];
+
+       switch (reg) {
+       case INA219_SHUNT_VOLTAGE:
+               /* LSBuV. Convert to mV. */
+               val = val / 100;
+               break;
+       case INA219_BUS_VOLTAGE:
+               /* LSB=4mV. Convert to mV. */
+               val = (val>>3) * 4;
+               break;
+       case INA219_POWER:
+               /* LSB mW. Convert to mW */
+               val = val * 20;
+               break;
+       case INA219_CURRENT:
+               /* LSB=1mA (selected). Is in mA */
+               break;
+       default:
+               /* programmer goofed */
+               WARN_ON_ONCE(1);
+               val = 0;
+               break;
+       }
+
+       return val;
+}
+
+static int ina226_get_value(struct ina2xx_data *data, u8 reg)
+{
+       /*
+        * calculate exact value for the given register
+        * we assume default power-on reset settings:
+        * bus voltage range 32V
+        * gain = /8
+        * adc 1 & 2 -> conversion time 532uS
+        * mode is continuous shunt and bus
+        * calibration value is INA226_CALIBRATION_VALUE */
+       int val;
+
+       val = data->regs[reg];
+
+       switch (reg) {
+       case INA226_SHUNT_VOLTAGE:
+               /* LSB=2.5uV. Convert to mV. */
+               val = val / 400;
+               break;
+       case INA226_BUS_VOLTAGE:
+               /* LSB=1.25mV. Convert to mV. */
+               val = val + ( val / 4 );
+               break;
+       case INA226_POWER:
+               /* LSB%mW. Convert to mW */
+               val = val * 25 ;
+               break;
+       case INA226_CURRENT:
+               /* LSB=1mA (selected). Is in mA */
+               break;
+       default:
+               /* programmer goofed */
+               WARN_ON_ONCE(1);
+               val = 0;
+               break;
+       }
+
+       return val;
+}
+
+static ssize_t ina2xx_show_value(struct device *dev,
+                                 struct device_attribute *da, char *buf)
+{
+       struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+       struct ina2xx_data *data = ina2xx_update_device(dev);
+       int value = 0;
+
+       if (IS_ERR(data))
+               return PTR_ERR(data);
+
+       switch(data->kind){
+       case ina219:
+               value = ina219_get_value(data, attr->index);
+               break;
+       case ina226:
+               value = ina226_get_value(data, attr->index);
+               break;
+       default:
+               WARN_ON_ONCE(1);
+               break;
+       }
+       return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+/* bus voltage */
+static SENSOR_DEVICE_ATTR(in_voltage, S_IRUGO, \
+       ina2xx_show_value, NULL, INA2XX_BUS_VOLTAGE);
+
+/* shunt voltage */
+static SENSOR_DEVICE_ATTR(in_shunt_voltage, S_IRUGO, \
+       ina2xx_show_value, NULL, INA2XX_SHUNT_VOLTAGE);
+
+/* calculated current */
+static SENSOR_DEVICE_ATTR(in_current, S_IRUGO, \
+       ina2xx_show_value, NULL, INA2XX_CURRENT);
+
+/* calculated power */
+static SENSOR_DEVICE_ATTR(in_power, S_IRUGO, \
+       ina2xx_show_value, NULL, INA2XX_POWER);
+
+/* pointers to created device attributes */
+static struct attribute *ina2xx_attributes[] = {
+       &sensor_dev_attr_in_voltage.dev_attr.attr,
+       &sensor_dev_attr_in_shunt_voltage.dev_attr.attr,
+       &sensor_dev_attr_in_current.dev_attr.attr,
+       &sensor_dev_attr_in_power.dev_attr.attr,
+       NULL,
+};
+
+static const struct attribute_group ina2xx_group = {
+       .attrs = ina2xx_attributes,
+};
+
+static int ina2xx_probe(struct i2c_client *client,
+                        const struct i2c_device_id *id)
+{
+       struct i2c_adapter *adapter = client->adapter;
+       struct ina2xx_data *data;
+       int ret;
+       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+               return -ENODEV;
+
+       data = kzalloc(sizeof(*data), GFP_KERNEL);
+       if (!data) {
+               ret = -ENOMEM;
+               goto out_err_kzalloc;
+       }
+
+       i2c_set_clientdata(client, data);
+       mutex_init(&data->update_lock);
+
+       ret = sysfs_create_group(&client->dev.kobj, &ina2xx_group);
+       if (ret)
+               goto out_err_sysfs;
+
+       data->hwmon_dev = hwmon_device_register(&client->dev);
+       if (IS_ERR(data->hwmon_dev)) {
+               ret = PTR_ERR(data->hwmon_dev);
+               goto out_err_hwmon;
+       }
+
+       /* set the device type */
+       data->kind = id->driver_data;
+       switch(data->kind) {
+       case ina219:
+               /* device configuration */
+               i2c_smbus_write_word_data(client,INA219_CONFIG, cpu_to_be16(INA219_CONFIG_DEFAULT));
+               /* set current LSB to 1mA, RSHUNT is in mOhms (equation 13 in datasheet) */
+               i2c_smbus_write_word_data(client,INA219_CALIBRATION, cpu_to_be16(40960 / INA2XX_RSHUNT));
+               dev_info(&client->dev, "%s: power monitor INA219 (Rshunt = %i mOhm)\n",
+                       dev_name(data->hwmon_dev), INA2XX_RSHUNT);
+               data->registers = INA219_REGISTERS;
+               break;
+       case ina226:
+               /* device configuration */
+               i2c_smbus_write_word_data(client,INA226_CONFIG, cpu_to_be16(INA226_CONFIG_DEFAULT));
+               /* set current LSB to 1mA, RSHUNT is in mOhms (equation 1 in datasheet)*/
+               i2c_smbus_write_word_data(client,INA226_CALIBRATION, cpu_to_be16(5120 / INA2XX_RSHUNT));
+               dev_info(&client->dev, "%s: power monitor INA226 (Rshunt = %i mOhm)\n",
+                       dev_name(data->hwmon_dev), INA2XX_RSHUNT);
+               dev_info(&client->dev, "%s: INA226 die id: 0x%2x\n",
+                       dev_name(data->hwmon_dev),
+                       be16_to_cpu(i2c_smbus_read_word_data(client, INA226_DIE_ID)));
+               data->registers = INA226_REGISTERS;
+               break;
+       default:
+               /* unknown device id */
+               goto out_err_hwmon;
+       }
+
+       return 0;
+
+out_err_hwmon:
+       sysfs_remove_group(&client->dev.kobj, &ina2xx_group);
+out_err_sysfs:
+       kfree(data);
+out_err_kzalloc:
+       return ret;
+}
+
+static int ina2xx_remove(struct i2c_client *client)
+{
+       struct ina2xx_data *data = i2c_get_clientdata(client);
+
+       hwmon_device_unregister(data->hwmon_dev);
+       sysfs_remove_group(&client->dev.kobj, &ina2xx_group);
+
+       kfree(data);
+
+       return 0;
+}
+
+static const struct i2c_device_id ina2xx_id[] = {
+       { "ina219", ina219 },
+       { "ina226", ina226 },
+       { }
+}
+MODULE_DEVICE_TABLE(i2c, ina2xx_id);
+
+static struct i2c_driver ina2xx_driver = {
+       .driver = {
+               .name   = "ina2xx",
+       },
+       .probe          = ina2xx_probe,
+       .remove         = ina2xx_remove,
+       .id_table       = ina2xx_id,
+};
+
+static int __init ina2xx_init(void)
+{
+       return i2c_add_driver(&ina2xx_driver);
+}
+
+static void __exit ina2xx_exit(void)
+{
+       i2c_del_driver(&ina2xx_driver);
+}
+
+MODULE_AUTHOR("Lothar Felten <l-felten@ti.com>");
+MODULE_DESCRIPTION("ina2xx driver");
+MODULE_LICENSE("GPL");
+
+module_init(ina2xx_init);
+module_exit(ina2xx_exit);
diff -uprN a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig     2012-04-02 19:32:52.000000000 +0200
+++ b/drivers/hwmon/Kconfig     2012-05-03 17:17:18.052263029 +0200
@@ -1088,6 +1088,26 @@ config SENSORS_AMC6821
          This driver can also be build as a module.  If so, the module
          will be called amc6821.

+config SENSORS_INA2XX
+       tristate "Texas Instruments INA2xx"
+       depends on I2C
+       help
+         If you say yes here you get support for INA2xx current/power monitors.
+
+         The INA2xx driver is configured for the default configuration of
+         the part as described in the datasheet.
+         Default value for Rshunt is 10 mOhms.
+         This driver can also be built as a module.  If so, the module
+         will be called ina2xx.
+
+config SENSORS_INA2XX_RSHUNT_MOHMS
+       int "Value for Rshunt in milliohms (1-65536)"
+       depends on SENSORS_INA2XX
+       default "10"
+       help
+         The resistance of the Rshunt resistor in milliohms.
+         Default is 10mOhm.
+
 config SENSORS_THMC50
        tristate "Texas Instruments THMC50 / Analog Devices ADM1022"
        depends on I2C
diff -uprN a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
--- a/drivers/hwmon/Makefile    2012-04-02 19:32:52.000000000 +0200
+++ b/drivers/hwmon/Makefile    2012-05-03 17:14:22.672266057 +0200
@@ -62,6 +62,7 @@ obj-$(CONFIG_SENSORS_ULTRA45) += ultra45
 obj-$(CONFIG_SENSORS_I5K_AMB)  += i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)   += ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)   += ibmpex.o
+obj-$(CONFIG_SENSORS_INA2xx)   += ina2xx.o
 obj-$(CONFIG_SENSORS_IT87)     += it87.o
 obj-$(CONFIG_SENSORS_JC42)     += jc42.o
 obj-$(CONFIG_SENSORS_JZ4740)   += jz4740-hwmon.o





Texas Instruments Belgium SA, Rond Point Schuman 6- Bo?te 5, 1040 Bruxelles. BCE: 0414.207.123. RPM Bruxelles. IBAN: BE83570121895615. Swift: CITIBEBX. TVA BE 0414.207.123



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
