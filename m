From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Jun 2005 05:38:23 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050602033727.GD4906@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch modifies sensors chip drivers to make use of the new
sysfs class "hwmon".

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1021.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/adm1021.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1021.c
@@ -25,6 +25,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 
 /* Addresses to scan */
@@ -37,6 +39,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
 
+static int id;	/* increment once for every chip found */
+
 /* adm1021 constants specified below */
 
 /* The adm1021 registers */
@@ -295,6 +299,13 @@ static int adm1021_detect(struct i2c_ada
 		adm1021_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto error2;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
@@ -305,6 +316,8 @@ static int adm1021_detect(struct i2c_ada
 
 	return 0;
 
+error2:
+	i2c_detach_client(new_client);
 error1:
 	kfree(data);
 error0:
@@ -324,6 +337,8 @@ static int adm1021_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
 		return err;
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1025.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/adm1025.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1025.c
@@ -52,6 +52,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -68,6 +70,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_2(adm1025, ne1619);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The ADM1025 registers
  */
@@ -416,6 +420,13 @@ static int adm1025_detect(struct i2c_ada
 	adm1025_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -452,6 +463,8 @@ static int adm1025_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -504,6 +517,8 @@ static int adm1025_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1026.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/adm1026.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1026.c
@@ -31,6 +31,8 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -62,6 +64,8 @@ MODULE_PARM_DESC(gpio_normal,"List of GP
 module_param_array(gpio_fan,int,NULL,0);
 MODULE_PARM_DESC(gpio_fan,"List of GPIO pins (0-7) to program as fan tachs");
 
+static int id;	/* increment once for every chip found */
+
 /* Many ADM1026 constants specified below */
 
 /* The ADM1026 registers */
@@ -324,6 +328,7 @@ int adm1026_attach_adapter(struct i2c_ad
 
 int adm1026_detach_client(struct i2c_client *client)
 {
+	hwmon_device_unregister(client->class_dev);
 	i2c_detach_client(client);
 	kfree(client);
 	return 0;
@@ -1555,6 +1560,13 @@ int adm1026_detect(struct i2c_adapter *a
 	adm1026_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exitdetach;
+	}
+
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
@@ -1690,6 +1702,8 @@ int adm1026_detect(struct i2c_adapter *a
 	return 0;
 
 	/* Error out and cleanup code */
+exitdetach:
+	i2c_detach_client(new_client);
 exitfree:
 	kfree(new_client);
 exit:
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1031.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/adm1031.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm1031.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Following macros takes channel parameter starting from 0 to 2 */
 #define ADM1031_REG_FAN_SPEED(nr)	(0x08 + (nr))
@@ -64,6 +66,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_2(adm1030, adm1031);
 
+static int id;	/* increment once for every chip found */
+
 typedef u8 auto_chan_table_t[8][2];
 
 /* Each client has this additional data */
@@ -788,6 +792,13 @@ static int adm1031_detect(struct i2c_ada
 	adm1031_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
@@ -833,6 +844,8 @@ static int adm1031_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(new_client);
 exit:
@@ -842,6 +855,8 @@ exit:
 static int adm1031_detach_client(struct i2c_client *client)
 {
 	int ret;
+
+	hwmon_device_unregister(client->class_dev);
 	if ((ret = i2c_detach_client(client)) != 0) {
 		return ret;
 	}
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm9240.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/adm9240.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/adm9240.c
@@ -47,6 +47,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -57,6 +59,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_3(adm9240, ds1780, lm81);
 
+static int id;	/* increment once for every chip found */
+
 /* ADM9240 registers */
 #define ADM9240_REG_MAN_ID		0x3e
 #define ADM9240_REG_DIE_REV		0x3f
@@ -582,6 +586,13 @@ static int adm9240_detect(struct i2c_ada
 	adm9240_init_client(new_client);
 
 	/* populate sysfs filesystem */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -615,6 +626,9 @@ static int adm9240_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 
 	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(new_client);
 exit:
@@ -632,6 +646,8 @@ static int adm9240_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 				"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/asb100.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/asb100.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/asb100.c
@@ -41,6 +41,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include "lm75.h"
@@ -62,6 +64,8 @@ SENSORS_INSMOD_1(asb100);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
 	"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
+static int id;	/* increment once for every chip found */
+
 /* Voltage IN registers 0-6 */
 #define ASB100_REG_IN(nr)	(0x20 + (nr))
 #define ASB100_REG_IN_MAX(nr)	(0x2b + (nr * 2))
@@ -821,6 +825,13 @@ static int asb100_detect(struct i2c_adap
 	data->fan_min[2] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
+        new_client->class_dev = hwmon_device_register(&new_client->dev,
+                "%s-%d", new_client->name, id++);
+        if (IS_ERR(new_client->class_dev)) {
+                err = PTR_ERR(new_client->class_dev);
+                goto ERROR3;
+        }
+
 	device_create_file_in(new_client, 0);
 	device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
@@ -847,6 +858,10 @@ static int asb100_detect(struct i2c_adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(data->lm75[0]);
+	kfree(data->lm75[1]);
+	kfree(data->lm75[0]);
 ERROR2:
 	i2c_detach_client(new_client);
 ERROR1:
@@ -859,6 +874,8 @@ static int asb100_detach_client(struct i
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "client deregistration failed; "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/ds1621.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/ds1621.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/ds1621.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include "lm75.h"
 
 /* Addresses to scan */
@@ -40,6 +42,8 @@ static int polarity = -1;
 module_param(polarity, int, 0);
 MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low");
 
+static int id;	/* increment once for every chip found */
+
 /* Many DS1621 constants specified below */
 /* Config register used for detection         */
 /*  7    6    5    4    3    2    1    0      */
@@ -250,6 +254,13 @@ int ds1621_detect(struct i2c_adapter *ad
 	ds1621_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -259,6 +270,8 @@ int ds1621_detect(struct i2c_adapter *ad
 
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
+      exit_detach:
+	i2c_detach_client(new_client);
       exit_free:
 	kfree(data);
       exit:
@@ -269,6 +282,8 @@ static int ds1621_detach_client(struct i
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/fscher.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/fscher.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/fscher.c
@@ -32,6 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -46,6 +48,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(fscher);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The FSCHER registers
  */
@@ -341,6 +345,13 @@ static int fscher_detect(struct i2c_adap
 	fscher_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file_revision(new_client);
 	device_create_file_alarms(new_client);
 	device_create_file_control(new_client);
@@ -360,6 +371,8 @@ static int fscher_detect(struct i2c_adap
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -370,6 +383,8 @@ static int fscher_detach_client(struct i
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/fscpos.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/fscpos.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/fscpos.c
@@ -35,6 +35,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -47,6 +49,8 @@ static unsigned int normal_isa[] = { I2C
  */
 SENSORS_INSMOD_1(fscpos);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The FSCPOS registers
  */
@@ -495,6 +499,13 @@ int fscpos_detect(struct i2c_adapter *ad
 	dev_info(&new_client->dev, "Found fscpos chip, rev %u\n", data->revision);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_event);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -525,6 +536,8 @@ int fscpos_detect(struct i2c_adapter *ad
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -535,6 +548,8 @@ static int fscpos_detach_client(struct i
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, client"
 							" not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/gl518sm.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/gl518sm.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/gl518sm.c
@@ -42,6 +42,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
@@ -50,6 +52,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_2(gl518sm_r00, gl518sm_r80);
 
+static int id;	/* increment once for every chip found */
+
 /* Many GL518 constants specified below */
 
 /* The GL518 registers */
@@ -419,6 +423,13 @@ static int gl518_detect(struct i2c_adapt
 	gl518_init_client((struct i2c_client *) new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -450,6 +461,8 @@ static int gl518_detect(struct i2c_adapt
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -479,6 +492,8 @@ static int gl518_detach_client(struct i2
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/gl520sm.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/gl520sm.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/gl520sm.c
@@ -27,6 +27,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Type of the extra sensor */
 static unsigned short extra_sensor_type;
@@ -40,6 +42,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_1(gl520sm);
 
+static int id;	/* increment once for each chip found */
+
 /* Many GL520 constants specified below 
 One of the inputs can be configured as either temp or voltage.
 That's why _TEMP2 and _IN4 access the same register 
@@ -570,6 +574,13 @@ static int gl520_detect(struct i2c_adapt
 	gl520_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file_vid(new_client, 0);
 
 	device_create_file_in(new_client, 0);
@@ -591,6 +602,8 @@ static int gl520_detect(struct i2c_adapt
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -640,6 +653,8 @@ static int gl520_detach_client(struct i2
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/it87.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/it87.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/it87.c
@@ -38,9 +38,10 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 					0x2e, 0x2f, I2C_CLIENT_END };
@@ -49,6 +50,8 @@ static unsigned int normal_isa[] = { 0x0
 /* Insmod parameters */
 SENSORS_INSMOD_2(it87, it8712);
 
+static int id;	/* increment once for every chip found */
+
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
 #define	VAL	0x2f	/* The value to read/write */
@@ -861,6 +864,13 @@ int it87_detect(struct i2c_adapter *adap
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -925,6 +935,8 @@ int it87_detect(struct i2c_adapter *adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	kfree(data);
 ERROR1:
@@ -938,6 +950,8 @@ static int it87_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 			"Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm63.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm63.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm63.c
@@ -43,6 +43,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -58,6 +60,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(lm63);
 
+static int id;	/* increment once for each chip found */
+
 /*
  * The LM63 registers
  */
@@ -428,6 +432,13 @@ static int lm63_detect(struct i2c_adapte
 	lm63_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	if (data->config & 0x04) { /* tachometer enabled */
 		device_create_file(&new_client->dev, &dev_attr_fan1_input);
 		device_create_file(&new_client->dev, &dev_attr_fan1_min);
@@ -445,6 +456,8 @@ static int lm63_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -490,6 +503,8 @@ static int lm63_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm75.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm75.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm75.c
@@ -24,6 +24,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include "lm75.h"
 
 
@@ -35,6 +37,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm75);
 
+static int id;	/* increment once for every chip found */
+
 /* Many LM75 constants specified below */
 
 /* The LM75 registers */
@@ -208,12 +212,21 @@ static int lm75_detect(struct i2c_adapte
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -222,6 +235,7 @@ exit:
 
 static int lm75_detach_client(struct i2c_client *client)
 {
+	hwmon_device_unregister(client->class_dev);
 	i2c_detach_client(client);
 	kfree(i2c_get_clientdata(client));
 	return 0;
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm77.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm77.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm77.c
@@ -31,7 +31,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
@@ -40,6 +41,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm77);
 
+static int id;	/* increment once for every chip found */
+
 /* The LM77 registers */
 #define LM77_REG_TEMP		0x00
 #define LM77_REG_CONF		0x01
@@ -317,6 +320,13 @@ static int lm77_detect(struct i2c_adapte
 	lm77_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -327,6 +337,8 @@ static int lm77_detect(struct i2c_adapte
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -335,6 +347,7 @@ exit:
 
 static int lm77_detach_client(struct i2c_client *client)
 {
+	hwmon_device_unregister(client->class_dev);
 	i2c_detach_client(client);
 	kfree(i2c_get_clientdata(client));
 	return 0;
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm78.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm78.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm78.c
@@ -24,6 +24,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 /* Addresses to scan */
@@ -36,6 +38,8 @@ static unsigned int normal_isa[] = { 0x0
 /* Insmod parameters */
 SENSORS_INSMOD_3(lm78, lm78j, lm79);
 
+static int id;	/* increment once for every chip found */
+
 /* Many LM78 constants specified below */
 
 /* Length of ISA address segment */
@@ -605,6 +609,13 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -643,6 +654,8 @@ int lm78_detect(struct i2c_adapter *adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	kfree(data);
 ERROR1:
@@ -656,6 +669,8 @@ static int lm78_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm80.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm80.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm80.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
@@ -36,6 +38,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm80);
 
+static int id;	/* increment once for every chip found */
+
 /* Many LM80 constants specified below */
 
 /* The LM80 registers */
@@ -451,6 +455,13 @@ int lm80_detect(struct i2c_adapter *adap
 	data->fan_min[1] = lm80_read_value(new_client, LM80_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto error_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
 	device_create_file(&new_client->dev, &dev_attr_in2_min);
@@ -487,6 +498,8 @@ int lm80_detect(struct i2c_adapter *adap
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(data);
 exit:
@@ -497,6 +510,8 @@ static int lm80_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm83.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm83.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm83.c
@@ -33,6 +33,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -52,6 +54,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(lm83);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The LM83 registers
  * Manufacturer ID is 0x01 for National Semiconductor.
@@ -322,6 +326,13 @@ static int lm83_detect(struct i2c_adapte
 	 */
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_temp3_input);
@@ -338,6 +349,8 @@ static int lm83_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -348,6 +361,8 @@ static int lm83_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm85.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm85.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm85.c
@@ -30,6 +30,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -38,6 +40,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
 
+static int id;	/* increment once for every chip found */
+
 /* The LM85 registers */
 
 #define	LM85_REG_IN(nr)			(0x20 + (nr))
@@ -1166,6 +1170,13 @@ int lm85_detect(struct i2c_adapter *adap
 	lm85_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR2;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan2_input);
 	device_create_file(&new_client->dev, &dev_attr_fan3_input);
@@ -1235,6 +1246,8 @@ int lm85_detect(struct i2c_adapter *adap
 	return 0;
 
 	/* Error out and cleanup code */
+    ERROR2:
+	i2c_detach_client(new_client);
     ERROR1:
 	kfree(data);
     ERROR0:
@@ -1243,6 +1256,7 @@ int lm85_detect(struct i2c_adapter *adap
 
 int lm85_detach_client(struct i2c_client *client)
 {
+	hwmon_device_unregister(client->class_dev);
 	i2c_detach_client(client);
 	kfree(i2c_get_clientdata(client));
 	return 0;
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm87.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm87.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm87.c
@@ -59,6 +59,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -74,6 +76,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(lm87);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The LM87 registers
  */
@@ -608,6 +612,13 @@ static int lm87_detect(struct i2c_adapte
 	data->in_scale[7] = 1875;
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_max);
@@ -673,6 +684,8 @@ static int lm87_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -721,6 +734,8 @@ static int lm87_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm90.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm90.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm90.c
@@ -76,6 +76,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -96,6 +98,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The LM90 registers
  */
@@ -480,6 +484,13 @@ static int lm90_detect(struct i2c_adapte
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -494,6 +505,8 @@ static int lm90_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -519,6 +532,8 @@ static int lm90_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm92.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/lm92.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/lm92.c
@@ -45,7 +45,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* The LM92 and MAX6635 have 2 two-state pins for address selection,
    resulting in 4 possible addresses. */
@@ -56,6 +57,8 @@ static unsigned int normal_isa[] = { I2C
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm92);
 
+static int id;	/* increment once for every chip found */
+
 /* The LM92 registers */
 #define LM92_REG_CONFIG			0x01 /* 8-bit, RW */
 #define LM92_REG_TEMP			0x00 /* 16-bit, RO */
@@ -359,6 +362,13 @@ static int lm92_detect(struct i2c_adapte
 	lm92_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_hyst);
@@ -370,6 +380,8 @@ static int lm92_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -387,6 +399,8 @@ static int lm92_detach_client(struct i2c
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/max1619.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/max1619.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/max1619.c
@@ -32,7 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,
@@ -46,6 +47,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(max1619);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The MAX1619 registers
  */
@@ -275,6 +278,13 @@ static int max1619_detect(struct i2c_ada
 	max1619_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_min);
@@ -285,6 +295,8 @@ static int max1619_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -310,6 +322,8 @@ static int max1619_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/pc87360.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/pc87360.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/pc87360.c
@@ -40,6 +40,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
@@ -65,6 +67,8 @@ MODULE_PARM_DESC(init,
  " 2: Forcibly enable all voltage and temperature channels, except in9\n"
  " 3: Forcibly enable all voltage and temperature channels, including in9");
 
+static int id;	/* increment once for every chip found */
+
 /*
  * Super-I/O registers and operations
  */
@@ -838,6 +842,13 @@ int pc87360_detect(struct i2c_adapter *a
 	}
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	if (data->innr) {
 		device_create_file(&new_client->dev, &dev_attr_in0_input);
 		device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -974,6 +985,8 @@ int pc87360_detect(struct i2c_adapter *a
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	for (i = 0; i < 3; i++) {
 		if (data->address[i]) {
@@ -990,6 +1003,8 @@ static int pc87360_detach_client(struct 
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	int i;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((i = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/sis5595.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/sis5595.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/sis5595.c
@@ -56,6 +56,8 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
@@ -77,6 +79,8 @@ static unsigned int normal_isa[] = { 0x0
 /* Insmod parameters */
 SENSORS_INSMOD_1(sis5595);
 
+static int id;	/* increment once for every chip found */
+
 /* Many SIS5595 constants specified below */
 
 /* Length of ISA address segment */
@@ -578,6 +582,13 @@ int sis5595_detect(struct i2c_adapter *a
 	}
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -608,7 +619,9 @@ int sis5595_detect(struct i2c_adapter *a
 		device_create_file(&new_client->dev, &dev_attr_temp1_max_hyst);
 	}
 	return 0;
-	
+
+exit_detach:
+	i2c_detach_client(new_client);	
 exit_free:
 	kfree(data);
 exit_release:
@@ -621,6 +634,8 @@ static int sis5595_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/smsc47b397.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/smsc47b397.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/smsc47b397.c
@@ -32,6 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -49,6 +51,8 @@ static struct i2c_address_data addr_data
 	.forces			= forces,
 };
 
+static int id;	/* increment once for every chip found */
+
 /* Super-I/0 registers and commands */
 
 #define	REG	0x2e	/* The register to read/write */
@@ -228,6 +232,8 @@ static int smsc47b397_detach_client(stru
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
@@ -285,6 +291,13 @@ static int smsc47b397_detect(struct i2c_
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
 
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto error_detach;
+	}
+
 	device_create_file_temp(new_client, 1);
 	device_create_file_temp(new_client, 2);
 	device_create_file_temp(new_client, 3);
@@ -297,6 +310,8 @@ static int smsc47b397_detect(struct i2c_
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(new_client);
 error_release:
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/smsc47m1.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/smsc47m1.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/smsc47m1.c
@@ -31,6 +31,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -46,6 +48,8 @@ static struct i2c_address_data addr_data
 	.forces			= forces,
 };
 
+static int id;	/* increment once for every chip found */
+
 /* Super-I/0 registers and commands */
 
 #define	REG	0x2e	/* The register to read/write */
@@ -461,6 +465,14 @@ static int smsc47m1_detect(struct i2c_ad
 	   function. */
 	smsc47m1_update_device(&new_client->dev, 1);
 
+	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto error_detach;
+	}
+
 	if (fan1) {
 		device_create_file(&new_client->dev, &dev_attr_fan1_input);
 		device_create_file(&new_client->dev, &dev_attr_fan1_min);
@@ -494,6 +506,8 @@ static int smsc47m1_detect(struct i2c_ad
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(new_client);
 error_release:
@@ -505,6 +519,8 @@ static int smsc47m1_detach_client(struct
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/via686a.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/via686a.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/via686a.c
@@ -36,6 +36,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -56,6 +58,8 @@ static unsigned int normal_isa[] = { 0x0
 /* Insmod parameters */
 SENSORS_INSMOD_1(via686a);
 
+static int id;	/* increment once for every chip found */
+
 /*
    The Via 686a southbridge has a LM78-like chip integrated on the same IC.
    This driver is a customized copy of lm78.c
@@ -637,7 +641,7 @@ static int via686a_detect(struct i2c_ada
 
 	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto exit_release;
 	}
 	memset(data, 0, sizeof(struct via686a_data));
 
@@ -655,12 +659,19 @@ static int via686a_detect(struct i2c_ada
 	init_MUTEX(&data->update_lock);
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR3;
+		goto exit_free;
 
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -695,9 +706,11 @@ static int via686a_detect(struct i2c_ada
 
 	return 0;
 
-ERROR3:
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
 	kfree(data);
-ERROR0:
+exit_release:
 	release_region(address, VIA686A_EXTENT);
 	return err;
 }
@@ -706,6 +719,8 @@ static int via686a_detach_client(struct 
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		"Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83627ehf.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/w83627ehf.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83627ehf.c
@@ -38,6 +38,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -49,6 +51,8 @@ static unsigned int normal_isa[] = { 0, 
 /* Insmod parameters */
 SENSORS_INSMOD_1(w83627ehf);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * Super-I/O constants and functions
  */
@@ -720,6 +724,13 @@ static int w83627ehf_detect(struct i2c_a
 		data->has_fan |= (1 << 4);
 
 	/* Register sysfs hooks */
+	client->class_dev = hwmon_device_register(&client->dev,
+		"%s-%d", client->name, id++);
+	if (IS_ERR(client->class_dev)) {
+		err = PTR_ERR(client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&client->dev, &dev_attr_fan1_input);
 	device_create_file(&client->dev, &dev_attr_fan1_min);
 	device_create_file(&client->dev, &dev_attr_fan1_div);
@@ -753,6 +764,8 @@ static int w83627ehf_detect(struct i2c_a
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit_release:
@@ -772,6 +785,8 @@ static int w83627ehf_detach_client(struc
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83627hf.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/w83627hf.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83627hf.c
@@ -44,6 +44,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -67,6 +69,8 @@ static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
+static int id;	/* increment once for every chip found */
+
 /* modified from kernel/include/traps.c */
 static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -1102,6 +1106,13 @@ int w83627hf_detect(struct i2c_adapter *
 	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83697hf)
 		device_create_file_in(new_client, 1);
@@ -1152,6 +1163,8 @@ int w83627hf_detect(struct i2c_adapter *
 
 	return 0;
 
+      ERROR3:
+	i2c_detach_client(new_client);
       ERROR2:
 	kfree(data);
       ERROR1:
@@ -1164,6 +1177,8 @@ static int w83627hf_detach_client(struct
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83781d.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/w83781d.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83781d.c
@@ -42,6 +42,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -60,6 +62,8 @@ static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
+static int id;	/* increment once for every chip found */
+
 /* Constants specified below */
 
 /* Length of ISA address segment */
@@ -1205,6 +1209,13 @@ w83781d_detect(struct i2c_adapter *adapt
 			data->pwmenable[i] = 1;
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto ERROR4;
+	}
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83783s && kind != w83697hf)
 		device_create_file_in(new_client, 1);
@@ -1262,6 +1273,15 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	return 0;
 
+ERROR4:
+	if (NULL != data->lm75[1]) {
+		i2c_detach_client(data->lm75[1]);
+		kfree(data->lm75[1]);
+	}
+	if (NULL != data->lm75[0]) {
+		i2c_detach_client(data->lm75[0]);
+		kfree(data->lm75[0]);
+	}
 ERROR3:
 	i2c_detach_client(new_client);
 ERROR2:
@@ -1278,6 +1298,9 @@ w83781d_detach_client(struct i2c_client 
 {
 	int err;
 
+	if (client->class_dev)
+		hwmon_device_unregister(client->class_dev);
+
 	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
 
Index: linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83l785ts.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/i2c/chips/w83l785ts.c
+++ linux-2.6.12-rc5-mm1/drivers/i2c/chips/w83l785ts.c
@@ -37,6 +37,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* How many retries on register read error */
 #define MAX_RETRIES	5
@@ -55,6 +57,8 @@ static unsigned int normal_isa[] = { I2C
 
 SENSORS_INSMOD_1(w83l785ts);
 
+static int id;	/* increment once for every chip found */
+
 /*
  * The W83L785TS-S registers
  * Manufacturer ID is 0x5CA3 for Winbond.
@@ -239,11 +243,20 @@ static int w83l785ts_detect(struct i2c_a
 	 */
 
 	/* Register sysfs hooks */
+	new_client->class_dev = hwmon_device_register(&new_client->dev,
+		"%s-%d", new_client->name, id++);
+	if (IS_ERR(new_client->class_dev)) {
+		err = PTR_ERR(new_client->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -254,6 +267,8 @@ static int w83l785ts_detach_client(struc
 {
 	int err;
 
+	hwmon_device_unregister(client->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
Index: linux-2.6.12-rc5-mm1/include/linux/i2c.h
=================================--- linux-2.6.12-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.12-rc5-mm1/include/linux/i2c.h
@@ -154,6 +154,7 @@ struct i2c_client {
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
+	struct class_device *class_dev;
 	struct list_head list;
 	char name[I2C_NAME_SIZE];
 	struct completion released;

-- 
Mark M. Hoffman
mhoffman@lightlink.com

