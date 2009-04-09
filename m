From: DaNiMoTh <jjdanimoth@gmail.com>
Date: Thu, 09 Apr 2009 12:50:26 +0000
Subject: [lm-sensors] [PATCH] adt746x compatibile with lm_sensors
Message-Id: <7b71803f0904090550i37f489d0hb37cc777c844671f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello to all,

After the first attempt to make a better driver for adt746x, I follow
what Jean said to me.
So, there is a patch for the actual adt746x driver that move the sysfs
attributes from /sys/devices/temperature to /sys/class/hwmon/ and also
it renames the old attributes (ex. from sensor1_temperature to
temp1_input).

As result, now I'm able to see two temperatures and two fan speed from
lm_sensors.

I tested it on adt7467 chip, I have only a compile warning about the
deprecation of attach and detach method. I've tried to use the new
style, but I've some trouble on detecting and probing device ( more
specifically, i2c-core compares the name of only 2 things - "tas audio
codec" and "ams" - and not the "uni-n 1", and also don't scan any
address, because in the comparison of the class of driver, adt746x
have 1 ( I2c_CLASS_HWMON ), but the driver in the kernel have 0. This
could be a things related to powerpc, and I'm searching a man that
knows in what direction I need to move )

This driver has all of the old limitations ( like it is impossible to
set device parameters at runtime, except the fan speed, doesn't
control the pwm, etc. ).
Thanks

----
Moved the sysfs attribute to the standard location (/sys/class/hwmon/..)
and renamed accordingly to new sysfs standard names,
to make the temperature and fan speed visible from lm_sensors.

Signed-off-by: Natale Patriciello <jjdanimoth@gmail.com>
---
 drivers/macintosh/therm_adt746x.c |  150 ++++++++++++++++++++----------------
 1 files changed, 83 insertions(+), 67 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c
b/drivers/macintosh/therm_adt746x.c
index 82607ad..63c23ad 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -3,6 +3,10 @@
  *
  * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt
  *
+ * 2009-04-09 Natale Patriciello <jjdanimoth@gmail.com>:
+ *	- Added new hwmon sysfs attribute's schema
+ *	- Removed the old schema
+ *
  * Documentation from
  * http://www.analog.com/UploadedFiles/Data_Sheets/115254175ADT7467_pra.pdf
  * http://www.analog.com/UploadedFiles/Data_Sheets/3686221171167ADT7460_b.pdf
@@ -25,6 +29,8 @@
 #include <linux/moduleparam.h>
 #include <linux/freezer.h>
 #include <linux/of_platform.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>

 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -72,6 +78,8 @@ MODULE_PARM_DESC(verbose,"Verbose log operations "

 struct thermostat {
 	struct i2c_client	clt;
+	struct device		*hwmon_dev;
+	struct attribute_group	attrs;
 	u8			temps[3];
 	u8			cached_temp[3];
 	u8			initial_limits[3];
@@ -85,6 +93,7 @@ static int therm_bus, therm_address;
 static struct of_device * of_dev;
 static struct thermostat* thermostat;
 static struct task_struct *thread_therm = NULL;
+static struct attribute *adt746x_attr[];

 static int attach_one_thermostat(struct i2c_adapter *adapter, int addr,
 				 int busno);
@@ -165,6 +174,9 @@ detach_thermostat(struct i2c_adapter *adapter)

 	write_both_fan_speed(th, -1);

+	hwmon_device_unregister(thermostat->hwmon_dev);
+	sysfs_remove_group(&thermostat->clt.dev.kobj, &thermostat->attrs);
+	
 	i2c_detach_client(&th->clt);

 	thermostat = NULL;
@@ -374,7 +386,7 @@ static int attach_one_thermostat(struct
i2c_adapter *adapter, int addr,
 {
 	struct thermostat* th;
 	int rc;
-	int i;
+	int i, err;

 	if (thermostat)
 		return 0;
@@ -393,8 +405,8 @@ static int attach_one_thermostat(struct
i2c_adapter *adapter, int addr,
 		printk(KERN_ERR "adt746x: Thermostat failed to read config "
 				"from bus %d !\n",
 				busno);
-		kfree(th);
-		return -ENODEV;
+		err = -ENODEV;
+		goto error_kfree;
 	}

 	/* force manual control to start the fan quieter */
@@ -424,9 +436,8 @@ static int attach_one_thermostat(struct
i2c_adapter *adapter, int addr,
 	if (i2c_attach_client(&th->clt)) {
 		printk(KERN_INFO "adt746x: Thermostat failed to attach "
 				 "client !\n");
-		thermostat = NULL;
-		kfree(th);
-		return -ENODEV;
+		err = -ENODEV;
+		goto error_kfree;
 	}

 	/* be sure to really write fan speed the first time */
@@ -447,11 +458,33 @@ static int attach_one_thermostat(struct
i2c_adapter *adapter, int addr,

 	if (thread_therm = ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
-		thread_therm = NULL;
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto error_ktherm;
+	}
+
+	/* Register sysfs hooks */
+	thermostat->attrs.attrs = adt746x_attr;
+	if (sysfs_create_group(&thermostat->clt.dev.kobj, &thermostat->attrs))
+		printk(KERN_WARNING
+			"Failed to create tempertaure attribute file(s).\n");
+	
+	thermostat->hwmon_dev = hwmon_device_register(&thermostat->clt.dev);
+	if (IS_ERR(thermostat->hwmon_dev)) {
+		err = PTR_ERR(thermostat->hwmon_dev);		
+		goto error_hwmon;
 	}

 	return 0;
+	
+error_hwmon:
+	kthread_stop(thread_therm);
+error_ktherm:
+	thread_therm = NULL;
+	i2c_detach_client(&th->clt);
+error_kfree:
+	kfree(th);
+	thermostat = NULL;
+	return err;
 }

 /*
@@ -464,7 +497,7 @@ static int attach_one_thermostat(struct
i2c_adapter *adapter, int addr,
 #define BUILD_SHOW_FUNC_INT(name, data)				\
 static ssize_t show_##name(struct device *dev, struct
device_attribute *attr, char *buf)	\
 {								\
-	return sprintf(buf, "%d\n", data);			\
+	return sprintf(buf, "%d\n", 1000 * data);		\
 }

 #define BUILD_SHOW_FUNC_STR(name, data)				\
@@ -476,8 +509,7 @@ static ssize_t show_##name(struct device *dev,
struct device_attribute *attr, ch
 #define BUILD_SHOW_FUNC_FAN(name, data)				\
 static ssize_t show_##name(struct device *dev, struct
device_attribute *attr, char *buf)       \
 {								\
-	return sprintf(buf, "%d (%d rpm)\n", 			\
-		thermostat->last_speed[data],			\
+	return sprintf(buf, "%d\n",	 			\
 		read_fan_speed(thermostat, FAN_SPEED[data])	\
 		);						\
 }
@@ -507,45 +539,59 @@ static ssize_t store_##name(struct device *dev,
struct device_attribute *attr, c
 	return n;						\
 }

-BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(thermostat, TEMP_REG[1])))
-BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(thermostat, TEMP_REG[2])))
-BUILD_SHOW_FUNC_INT(sensor1_limit,		 thermostat->limits[1])
-BUILD_SHOW_FUNC_INT(sensor2_limit,		 thermostat->limits[2])
-BUILD_SHOW_FUNC_STR(sensor1_location,		 sensor_location[1])
-BUILD_SHOW_FUNC_STR(sensor2_location,		 sensor_location[2])
+BUILD_SHOW_FUNC_INT(temp1_input,	 (read_reg(thermostat, TEMP_REG[1])))
+BUILD_SHOW_FUNC_INT(temp2_input,	 (read_reg(thermostat, TEMP_REG[2])))
+BUILD_SHOW_FUNC_INT(temp1_max,		 thermostat->limits[1])
+BUILD_SHOW_FUNC_INT(temp2_max,		 thermostat->limits[2])
+BUILD_SHOW_FUNC_STR(temp1_label,	 sensor_location[1])
+BUILD_SHOW_FUNC_STR(temp2_label,	 sensor_location[2])

 BUILD_SHOW_FUNC_INT(specified_fan_speed, fan_speed)
-BUILD_SHOW_FUNC_FAN(sensor1_fan_speed,	 0)
-BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,	 1)
+BUILD_SHOW_FUNC_FAN(fan1_input,	 0)
+BUILD_SHOW_FUNC_FAN(fan2_input,	 1)

 BUILD_STORE_FUNC_INT(specified_fan_speed,fan_speed)
 BUILD_SHOW_FUNC_INT(limit_adjust,	 limit_adjust)
 BUILD_STORE_FUNC_DEG(limit_adjust,	 thermostat)
 		
-static DEVICE_ATTR(sensor1_temperature,	S_IRUGO,
-		   show_sensor1_temperature,NULL);
-static DEVICE_ATTR(sensor2_temperature,	S_IRUGO,
-		   show_sensor2_temperature,NULL);
-static DEVICE_ATTR(sensor1_limit, S_IRUGO,
-		   show_sensor1_limit,	NULL);
-static DEVICE_ATTR(sensor2_limit, S_IRUGO,
-		   show_sensor2_limit,	NULL);
-static DEVICE_ATTR(sensor1_location, S_IRUGO,
-		   show_sensor1_location, NULL);
-static DEVICE_ATTR(sensor2_location, S_IRUGO,
-		   show_sensor2_location, NULL);
+static DEVICE_ATTR(temp1_input,	S_IRUGO,
+		   show_temp1_input,NULL);
+static DEVICE_ATTR(temp2_input,	S_IRUGO,
+		   show_temp2_input,NULL);
+static DEVICE_ATTR(temp1_max, S_IRUGO,
+		   show_temp1_max,	NULL);
+static DEVICE_ATTR(temp2_max, S_IRUGO,
+		   show_temp2_max,	NULL);
+static DEVICE_ATTR(temp1_label, S_IRUGO,
+		   show_temp1_label, NULL);
+static DEVICE_ATTR(temp2_label, S_IRUGO,
+		   show_temp2_label, NULL);

 static DEVICE_ATTR(specified_fan_speed,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,
 		   show_specified_fan_speed,store_specified_fan_speed);

-static DEVICE_ATTR(sensor1_fan_speed,	S_IRUGO,
-		   show_sensor1_fan_speed,	NULL);
-static DEVICE_ATTR(sensor2_fan_speed,	S_IRUGO,
-		   show_sensor2_fan_speed,	NULL);
+static DEVICE_ATTR(fan1_input,	S_IRUGO,
+		   show_fan1_input,	NULL);
+static DEVICE_ATTR(fan2_input,	S_IRUGO,
+		   show_fan2_input,	NULL);

 static DEVICE_ATTR(limit_adjust,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,
 		   show_limit_adjust,	store_limit_adjust);

+static struct attribute *adt746x_attr[] +{
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp2_max.attr,
+	&dev_attr_temp1_label.attr,
+	&dev_attr_temp2_label.attr,
+	&dev_attr_specified_fan_speed.attr,
+	&dev_attr_fan1_input.attr,
+	&dev_attr_fan2_input.attr,
+	&dev_attr_limit_adjust.attr,
+	NULL
+};

 static int __init
 thermostat_init(void)
@@ -553,7 +599,6 @@ thermostat_init(void)
 	struct device_node* np;
 	const u32 *prop;
 	int i = 0, offset = 0;
-	int err;

 	np = of_find_node_by_name(NULL, "fan");
 	if (!np)
@@ -620,21 +665,6 @@ thermostat_init(void)
 		return -ENODEV;
 	}

-	err = device_create_file(&of_dev->dev, &dev_attr_sensor1_temperature);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_temperature);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_limit);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_limit);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_location);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_location);
-	err |= device_create_file(&of_dev->dev, &dev_attr_limit_adjust);
-	err |= device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
-	if(therm_type = ADT7460)
-		err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
-	if (err)
-		printk(KERN_WARNING
-			"Failed to create tempertaure attribute file(s).\n");
-
 #ifndef CONFIG_I2C_POWERMAC
 	request_module("i2c-powermac");
 #endif
@@ -645,23 +675,9 @@ thermostat_init(void)
 static void __exit
 thermostat_exit(void)
 {
-	if (of_dev) {
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_temperature);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_temperature);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_limit);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_limit);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_location);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_location);
-		device_remove_file(&of_dev->dev, &dev_attr_limit_adjust);
-		device_remove_file(&of_dev->dev, &dev_attr_specified_fan_speed);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
-
-		if(therm_type = ADT7460)
-			device_remove_file(&of_dev->dev,
-					   &dev_attr_sensor2_fan_speed);
-
+	if (of_dev)
 		of_device_unregister(of_dev);
-	}
+	
 	i2c_del_driver(&thermostat_driver);
 }

-- 
1.6.1.3

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
