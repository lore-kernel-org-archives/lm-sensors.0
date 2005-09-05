From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:08 +0000
Subject: [lm-sensors] [PATCH] I2C hwmon: add hwmon sysfs class to drivers
Message-Id: <11259567653828@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C hwmon: add hwmon sysfs class to drivers

This patch modifies sensors chip drivers to make use of the new
sysfs class "hwmon".

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 943b0830cebe4711354945ed3cb44e84152aaca0
tree 1963da8d8867069617404a8f92739035c6faca02
parent 1236441f38b6a98caf4c7983e7efdecc2d1527b5
author Mark M. Hoffman <mhoffman@lightlink.com> Fri, 15 Jul 2005 21:39:18 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:08 -0700

 drivers/hwmon/adm1021.c    |   16 +++++++++++++++-
 drivers/hwmon/adm1025.c    |   16 +++++++++++++++-
 drivers/hwmon/adm1026.c    |   15 ++++++++++++++-
 drivers/hwmon/adm1031.c    |   16 +++++++++++++++-
 drivers/hwmon/adm9240.c    |   17 ++++++++++++++++-
 drivers/hwmon/asb100.c     |   31 +++++++++++++++++++++++++------
 drivers/hwmon/atxp1.c      |   16 +++++++++++++++-
 drivers/hwmon/ds1621.c     |   16 +++++++++++++++-
 drivers/hwmon/fscher.c     |   16 +++++++++++++++-
 drivers/hwmon/fscpos.c     |   16 +++++++++++++++-
 drivers/hwmon/gl518sm.c    |   17 +++++++++++++++--
 drivers/hwmon/gl520sm.c    |   16 +++++++++++++++-
 drivers/hwmon/it87.c       |   16 +++++++++++++++-
 drivers/hwmon/lm63.c       |   16 +++++++++++++++-
 drivers/hwmon/lm75.c       |   15 ++++++++++++++-
 drivers/hwmon/lm77.c       |   16 ++++++++++++++--
 drivers/hwmon/lm78.c       |   16 +++++++++++++++-
 drivers/hwmon/lm80.c       |   16 +++++++++++++++-
 drivers/hwmon/lm83.c       |   16 +++++++++++++++-
 drivers/hwmon/lm85.c       |   15 ++++++++++++++-
 drivers/hwmon/lm87.c       |   16 +++++++++++++++-
 drivers/hwmon/lm90.c       |   16 +++++++++++++++-
 drivers/hwmon/lm92.c       |   17 +++++++++++++++--
 drivers/hwmon/max1619.c    |   17 +++++++++++++++--
 drivers/hwmon/pc87360.c    |   13 +++++++++++++
 drivers/hwmon/sis5595.c    |   18 ++++++++++++++++--
 drivers/hwmon/smsc47b397.c |   16 +++++++++++++++-
 drivers/hwmon/smsc47m1.c   |   17 ++++++++++++++++-
 drivers/hwmon/via686a.c    |   24 +++++++++++++++++++-----
 drivers/hwmon/w83627ehf.c  |   16 +++++++++++++++-
 drivers/hwmon/w83627hf.c   |   16 +++++++++++++++-
 drivers/hwmon/w83781d.c    |   39 +++++++++++++++++++++++++++++++--------
 drivers/hwmon/w83l785ts.c  |   16 +++++++++++++++-
 33 files changed, 522 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -25,6 +25,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 
 /* Addresses to scan */
@@ -89,6 +91,7 @@ clearing it.  Weird, ey?   --Phil  */
 /* Each client has this additional data */
 struct adm1021_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -295,6 +298,12 @@ static int adm1021_detect(struct i2c_ada
 		adm1021_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto error2;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
@@ -305,6 +314,8 @@ static int adm1021_detect(struct i2c_ada
 
 	return 0;
 
+error2:
+	i2c_detach_client(new_client);
 error1:
 	kfree(data);
 error0:
@@ -322,14 +333,17 @@ static void adm1021_init_client(struct i
 
 static int adm1021_detach_client(struct i2c_client *client)
 {
+	struct adm1021_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -52,6 +52,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -132,6 +134,7 @@ static struct i2c_driver adm1025_driver 
 
 struct adm1025_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -416,6 +419,12 @@ static int adm1025_detect(struct i2c_ada
 	adm1025_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -452,6 +461,8 @@ static int adm1025_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -502,15 +513,18 @@ static void adm1025_init_client(struct i
 
 static int adm1025_detach_client(struct i2c_client *client)
 {
+	struct adm1025_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -31,6 +31,8 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -259,6 +261,7 @@ struct pwm_data {
 
 struct adm1026_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -324,8 +327,10 @@ int adm1026_attach_adapter(struct i2c_ad
 
 int adm1026_detach_client(struct i2c_client *client)
 {
+	struct adm1026_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
 	i2c_detach_client(client);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
@@ -1555,6 +1560,12 @@ int adm1026_detect(struct i2c_adapter *a
 	adm1026_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exitdetach;
+	}
+
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
@@ -1690,6 +1701,8 @@ int adm1026_detect(struct i2c_adapter *a
 	return 0;
 
 	/* Error out and cleanup code */
+exitdetach:
+	i2c_detach_client(new_client);
 exitfree:
 	kfree(data);
 exit:
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Following macros takes channel parameter starting from 0 to 2 */
 #define ADM1031_REG_FAN_SPEED(nr)	(0x08 + (nr))
@@ -69,6 +71,7 @@ typedef u8 auto_chan_table_t[8][2];
 /* Each client has this additional data */
 struct adm1031_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
@@ -788,6 +791,12 @@ static int adm1031_detect(struct i2c_ada
 	adm1031_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan1_div);
 	device_create_file(&new_client->dev, &dev_attr_fan1_min);
@@ -833,6 +842,8 @@ static int adm1031_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -841,11 +852,14 @@ exit:
 
 static int adm1031_detach_client(struct i2c_client *client)
 {
+	struct adm1031_data *data = i2c_get_clientdata(client);
 	int ret;
+
+	hwmon_device_unregister(data->class_dev);
 	if ((ret = i2c_detach_client(client)) != 0) {
 		return ret;
 	}
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -47,6 +47,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
@@ -150,6 +152,7 @@ static struct i2c_driver adm9240_driver 
 struct adm9240_data {
 	enum chips type;
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid;
 	unsigned long last_updated_measure;
@@ -582,6 +585,12 @@ static int adm9240_detect(struct i2c_ada
 	adm9240_init_client(new_client);
 
 	/* populate sysfs filesystem */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -615,6 +624,9 @@ static int adm9240_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 
 	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -630,15 +642,18 @@ static int adm9240_attach_adapter(struct
 
 static int adm9240_detach_client(struct i2c_client *client)
 {
+	struct adm9240_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 				"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -41,6 +41,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include "lm75.h"
@@ -183,6 +185,7 @@ static u8 DIV_TO_REG(long val)
    dynamically allocated, at the same time the client itself is allocated. */
 struct asb100_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -821,6 +824,12 @@ static int asb100_detect(struct i2c_adap
 	data->fan_min[2] = asb100_read_value(new_client, ASB100_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file_in(new_client, 0);
 	device_create_file_in(new_client, 1);
 	device_create_file_in(new_client, 2);
@@ -847,6 +856,11 @@ static int asb100_detect(struct i2c_adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(data->lm75[1]);
+	i2c_detach_client(data->lm75[0]);
+	kfree(data->lm75[1]);
+	kfree(data->lm75[0]);
 ERROR2:
 	i2c_detach_client(new_client);
 ERROR1:
@@ -857,21 +871,26 @@ ERROR0:
 
 static int asb100_detach_client(struct i2c_client *client)
 {
+	struct asb100_data *data = i2c_get_clientdata(client);
 	int err;
 
+	/* main client */
+	if (data)
+		hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "client deregistration failed; "
 			"client not detached.\n");
 		return err;
 	}
 
-	if (i2c_get_clientdata(client)=NULL) {
-		/* subclients */
+	/* main client */
+	if (data)
+		kfree(data);
+
+	/* subclient */
+	else
 		kfree(client);
-	} else {
-		/* main client */
-		kfree(i2c_get_clientdata(client));
-	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -25,6 +25,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
@@ -59,6 +61,7 @@ static struct i2c_driver atxp1_driver = 
 
 struct atxp1_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	unsigned long last_updated;
 	u8 valid;
@@ -317,6 +320,12 @@ static int atxp1_detect(struct i2c_adapt
 		goto exit_free;
 	}
 
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_gpio1);
 	device_create_file(&new_client->dev, &dev_attr_gpio2);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
@@ -326,6 +335,8 @@ static int atxp1_detect(struct i2c_adapt
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -334,14 +345,17 @@ exit:
 
 static int atxp1_detach_client(struct i2c_client * client)
 {
+	struct atxp1_data * data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	err = i2c_detach_client(client);
 
 	if (err)
 		dev_err(&client->dev, "Failed to detach client.\n");
 	else
-		kfree(i2c_get_clientdata(client));
+		kfree(data);
 
 	return err;
 };
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include "lm75.h"
 
 /* Addresses to scan */
@@ -71,6 +73,7 @@ MODULE_PARM_DESC(polarity, "Output's pol
 /* Each client has this additional data */
 struct ds1621_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -250,6 +253,12 @@ int ds1621_detect(struct i2c_adapter *ad
 	ds1621_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -259,6 +268,8 @@ int ds1621_detect(struct i2c_adapter *ad
 
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
+      exit_detach:
+	i2c_detach_client(new_client);
       exit_free:
 	kfree(data);
       exit:
@@ -267,15 +278,18 @@ int ds1621_detect(struct i2c_adapter *ad
 
 static int ds1621_detach_client(struct i2c_client *client)
 {
+	struct ds1621_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -32,6 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -132,6 +134,7 @@ static struct i2c_driver fscher_driver  
 struct fscher_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -341,6 +344,12 @@ static int fscher_detect(struct i2c_adap
 	fscher_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file_revision(new_client);
 	device_create_file_alarms(new_client);
 	device_create_file_control(new_client);
@@ -360,6 +369,8 @@ static int fscher_detect(struct i2c_adap
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -368,15 +379,18 @@ exit:
 
 static int fscher_detach_client(struct i2c_client *client)
 {
+	struct fscher_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -36,6 +36,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -113,6 +115,7 @@ static struct i2c_driver fscpos_driver   */
 struct fscpos_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; 		/* 0 until following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -496,6 +499,12 @@ int fscpos_detect(struct i2c_adapter *ad
 	dev_info(&new_client->dev, "Found fscpos chip, rev %u\n", data->revision);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_event);
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -526,6 +535,8 @@ int fscpos_detect(struct i2c_adapter *ad
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -534,14 +545,17 @@ exit:
 
 static int fscpos_detach_client(struct i2c_client *client)
 {
+	struct fscpos_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, client"
 							" not detached.\n");
 		return err;
 	}
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -42,6 +42,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
@@ -117,6 +119,7 @@ static inline u8 FAN_TO_REG(long rpm, in
 /* Each client has this additional data */
 struct gl518_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -419,6 +422,12 @@ static int gl518_detect(struct i2c_adapt
 	gl518_init_client((struct i2c_client *) new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -450,6 +459,8 @@ static int gl518_detect(struct i2c_adapt
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -477,16 +488,18 @@ static void gl518_init_client(struct i2c
 
 static int gl518_detach_client(struct i2c_client *client)
 {
+	struct gl518_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
-
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -28,6 +28,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Type of the extra sensor */
 static unsigned short extra_sensor_type;
@@ -120,6 +122,7 @@ static struct i2c_driver gl520_driver = 
 /* Client data */
 struct gl520_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
@@ -571,6 +574,12 @@ static int gl520_detect(struct i2c_adapt
 	gl520_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file_vid(new_client, 0);
 
 	device_create_file_in(new_client, 0);
@@ -592,6 +601,8 @@ static int gl520_detect(struct i2c_adapt
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -639,15 +650,18 @@ static void gl520_init_client(struct i2c
 
 static int gl520_detach_client(struct i2c_client *client)
 {
+	struct gl520_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -39,6 +39,8 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 
@@ -192,6 +194,7 @@ static int DIV_TO_REG(int val)
    allocated. */
 struct it87_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -840,6 +843,12 @@ int it87_detect(struct i2c_adapter *adap
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
 	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
@@ -904,6 +913,8 @@ int it87_detect(struct i2c_adapter *adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	kfree(data);
 ERROR1:
@@ -915,8 +926,11 @@ ERROR0:
 
 static int it87_detach_client(struct i2c_client *client)
 {
+	struct it87_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 			"Client deregistration failed, client not detached.\n");
@@ -925,7 +939,7 @@ static int it87_detach_client(struct i2c
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, IT87_EXTENT);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -44,6 +44,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -152,6 +154,7 @@ static struct i2c_driver lm63_driver = {
 
 struct lm63_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -437,6 +440,12 @@ static int lm63_detect(struct i2c_adapte
 	lm63_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	if (data->config & 0x04) { /* tachometer enabled */
 		device_create_file(&new_client->dev,
 				   &sensor_dev_attr_fan1_input.dev_attr);
@@ -462,6 +471,8 @@ static int lm63_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -505,15 +516,18 @@ static void lm63_init_client(struct i2c_
 
 static int lm63_detach_client(struct i2c_client *client)
 {
+	struct lm63_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -24,6 +24,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include "lm75.h"
 
 
@@ -46,6 +48,7 @@ SENSORS_INSMOD_1(lm75);
 /* Each client has this additional data */
 struct lm75_data {
 	struct i2c_client	client;
+	struct class_device *class_dev;
 	struct semaphore	update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
@@ -208,12 +211,20 @@ static int lm75_detect(struct i2c_adapte
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
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
@@ -222,8 +233,10 @@ exit:
 
 static int lm75_detach_client(struct i2c_client *client)
 {
+	struct lm75_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
 	i2c_detach_client(client);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -31,7 +31,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
@@ -51,6 +52,7 @@ SENSORS_INSMOD_1(lm77);
 /* Each client has this additional data */
 struct lm77_data {
 	struct i2c_client	client;
+	struct class_device *class_dev;
 	struct semaphore	update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
@@ -317,6 +319,12 @@ static int lm77_detect(struct i2c_adapte
 	lm77_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp1_min);
@@ -327,6 +335,8 @@ static int lm77_detect(struct i2c_adapte
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -335,8 +345,10 @@ exit:
 
 static int lm77_detach_client(struct i2c_client *client)
 {
+	struct lm77_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
 	i2c_detach_client(client);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -24,6 +24,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 /* Addresses to scan */
@@ -134,6 +136,7 @@ static inline int VID_FROM_REG(u8 val)
    allocated. */
 struct lm78_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -602,6 +605,12 @@ int lm78_detect(struct i2c_adapter *adap
 	}
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -640,6 +649,8 @@ int lm78_detect(struct i2c_adapter *adap
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	kfree(data);
 ERROR1:
@@ -651,8 +662,11 @@ ERROR0:
 
 static int lm78_detach_client(struct i2c_client *client)
 {
+	struct lm78_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
@@ -662,7 +676,7 @@ static int lm78_detach_client(struct i2c
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, LM78_EXTENT);
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -27,6 +27,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
@@ -107,6 +109,7 @@ static inline long TEMP_FROM_REG(u16 tem
 
 struct lm80_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -451,6 +454,12 @@ int lm80_detect(struct i2c_adapter *adap
 	data->fan_min[1] = lm80_read_value(new_client, LM80_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto error_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
 	device_create_file(&new_client->dev, &dev_attr_in2_min);
@@ -487,6 +496,8 @@ int lm80_detect(struct i2c_adapter *adap
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(data);
 exit:
@@ -495,15 +506,18 @@ exit:
 
 static int lm80_detach_client(struct i2c_client *client)
 {
+	struct lm80_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -34,6 +34,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -138,6 +140,7 @@ static struct i2c_driver lm83_driver = {
 
 struct lm83_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -312,6 +315,12 @@ static int lm83_detect(struct i2c_adapte
 	 */
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_create_file(&new_client->dev,
@@ -340,6 +349,8 @@ static int lm83_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -348,15 +359,18 @@ exit:
 
 static int lm83_detach_client(struct i2c_client *client)
 {
+	struct lm83_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -30,6 +30,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -339,6 +341,7 @@ struct lm85_autofan {
 
 struct lm85_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -1166,6 +1169,12 @@ int lm85_detect(struct i2c_adapter *adap
 	lm85_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR2;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_fan1_input);
 	device_create_file(&new_client->dev, &dev_attr_fan2_input);
 	device_create_file(&new_client->dev, &dev_attr_fan3_input);
@@ -1235,6 +1244,8 @@ int lm85_detect(struct i2c_adapter *adap
 	return 0;
 
 	/* Error out and cleanup code */
+    ERROR2:
+	i2c_detach_client(new_client);
     ERROR1:
 	kfree(data);
     ERROR0:
@@ -1243,8 +1254,10 @@ int lm85_detect(struct i2c_adapter *adap
 
 int lm85_detach_client(struct i2c_client *client)
 {
+	struct lm85_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->class_dev);
 	i2c_detach_client(client);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -59,6 +59,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -175,6 +177,7 @@ static struct i2c_driver lm87_driver = {
 
 struct lm87_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
@@ -608,6 +611,12 @@ static int lm87_detect(struct i2c_adapte
 	data->in_scale[7] = 1875;
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_max);
@@ -673,6 +682,8 @@ static int lm87_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -719,15 +730,18 @@ static void lm87_init_client(struct i2c_
 
 static int lm87_detach_client(struct i2c_client *client)
 {
+	struct lm87_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -77,6 +77,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /*
  * Addresses to scan
@@ -200,6 +202,7 @@ static struct i2c_driver lm90_driver = {
 
 struct lm90_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -500,6 +503,12 @@ static int lm90_detect(struct i2c_adapte
 	lm90_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_create_file(&new_client->dev,
@@ -524,6 +533,8 @@ static int lm90_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -547,15 +558,18 @@ static void lm90_init_client(struct i2c_
 
 static int lm90_detach_client(struct i2c_client *client)
 {
+	struct lm90_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -45,7 +45,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* The LM92 and MAX6635 have 2 two-state pins for address selection,
    resulting in 4 possible addresses. */
@@ -96,6 +97,7 @@ static struct i2c_driver lm92_driver;
 /* Client data (each client gets its own) */
 struct lm92_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -359,6 +361,12 @@ static int lm92_detect(struct i2c_adapte
 	lm92_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_hyst);
@@ -370,6 +378,8 @@ static int lm92_detect(struct i2c_adapte
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -385,15 +395,18 @@ static int lm92_attach_adapter(struct i2
 
 static int lm92_detach_client(struct i2c_client *client)
 {
+	struct lm92_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -32,7 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 static unsigned short normal_i2c[] = { 0x18, 0x19, 0x1a,
 					0x29, 0x2a, 0x2b,
@@ -104,6 +105,7 @@ static struct i2c_driver max1619_driver 
 
 struct max1619_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -275,6 +277,12 @@ static int max1619_detect(struct i2c_ada
 	max1619_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_min);
@@ -285,6 +293,8 @@ static int max1619_detect(struct i2c_ada
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
 exit:
@@ -308,15 +318,18 @@ static void max1619_init_client(struct i
 
 static int max1619_detach_client(struct i2c_client *client)
 {
+	struct max1619_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -40,6 +40,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
@@ -186,6 +188,7 @@ static inline u8 PWM_TO_REG(int val, int
 
 struct pc87360_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
@@ -838,6 +841,12 @@ int pc87360_detect(struct i2c_adapter *a
 	}
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
+
 	if (data->innr) {
 		device_create_file(&new_client->dev, &dev_attr_in0_input);
 		device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -974,6 +983,8 @@ int pc87360_detect(struct i2c_adapter *a
 
 	return 0;
 
+ERROR3:
+	i2c_detach_client(new_client);
 ERROR2:
 	for (i = 0; i < 3; i++) {
 		if (data->address[i]) {
@@ -990,6 +1001,8 @@ static int pc87360_detach_client(struct 
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	int i;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((i = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -56,6 +56,8 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <asm/io.h>
@@ -168,6 +170,7 @@ static inline u8 DIV_TO_REG(int val)
    allocated. */
 struct sis5595_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 
 	struct semaphore update_lock;
@@ -578,6 +581,12 @@ int sis5595_detect(struct i2c_adapter *a
 	}
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
@@ -608,7 +617,9 @@ int sis5595_detect(struct i2c_adapter *a
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
@@ -619,8 +630,11 @@ exit:
 
 static int sis5595_detach_client(struct i2c_client *client)
 {
+	struct sis5595_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		    "Client deregistration failed, client not detached.\n");
@@ -630,7 +644,7 @@ static int sis5595_detach_client(struct 
 	if (i2c_is_isa_client(client))
 		release_region(client->addr, SIS5595_EXTENT);
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -32,6 +32,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -100,6 +102,7 @@ static u8 smsc47b397_reg_temp[] = {0x25,
 
 struct smsc47b397_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 
 	struct semaphore update_lock;
@@ -226,8 +229,11 @@ static int smsc47b397_attach_adapter(str
 
 static int smsc47b397_detach_client(struct i2c_client *client)
 {
+	struct smsc47b397_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
@@ -235,7 +241,7 @@ static int smsc47b397_detach_client(stru
 	}
 
 	release_region(client->addr, SMSC_EXTENT);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
@@ -285,6 +291,12 @@ static int smsc47b397_detect(struct i2c_
 	if ((err = i2c_attach_client(new_client)))
 		goto error_free;
 
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto error_detach;
+	}
+
 	device_create_file_temp(new_client, 1);
 	device_create_file_temp(new_client, 2);
 	device_create_file_temp(new_client, 3);
@@ -297,6 +309,8 @@ static int smsc47b397_detect(struct i2c_
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(data);
 error_release:
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -31,6 +31,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -108,6 +110,7 @@ superio_exit(void)
 
 struct smsc47m1_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 
 	struct semaphore update_lock;
@@ -461,6 +464,13 @@ static int smsc47m1_detect(struct i2c_ad
 	   function. */
 	smsc47m1_update_device(&new_client->dev, 1);
 
+	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto error_detach;
+	}
+
 	if (fan1) {
 		device_create_file(&new_client->dev, &dev_attr_fan1_input);
 		device_create_file(&new_client->dev, &dev_attr_fan1_min);
@@ -494,6 +504,8 @@ static int smsc47m1_detect(struct i2c_ad
 
 	return 0;
 
+error_detach:
+	i2c_detach_client(new_client);
 error_free:
 	kfree(data);
 error_release:
@@ -503,8 +515,11 @@ error_release:
 
 static int smsc47m1_detach_client(struct i2c_client *client)
 {
+	struct smsc47m1_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
@@ -512,7 +527,7 @@ static int smsc47m1_detach_client(struct
 	}
 
 	release_region(client->addr, SMSC_EXTENT);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -36,6 +36,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
@@ -297,6 +299,7 @@ static inline long TEMP_FROM_REG10(u16 v
    via686a client is allocated. */
 struct via686a_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -637,7 +640,7 @@ static int via686a_detect(struct i2c_ada
 
 	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto exit_release;
 	}
 	memset(data, 0, sizeof(struct via686a_data));
 
@@ -655,12 +658,18 @@ static int via686a_detect(struct i2c_ada
 	init_MUTEX(&data->update_lock);
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR3;
+		goto exit_free;
 
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
@@ -695,17 +704,22 @@ static int via686a_detect(struct i2c_ada
 
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
 
 static int via686a_detach_client(struct i2c_client *client)
 {
+	struct via686a_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		"Client deregistration failed, client not detached.\n");
@@ -713,7 +727,7 @@ static int via686a_detach_client(struct 
 	}
 
 	release_region(client->addr, VIA686A_EXTENT);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -41,6 +41,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -177,6 +179,7 @@ temp1_to_reg(int temp)
 
 struct w83627ehf_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 
 	struct semaphore update_lock;
@@ -723,6 +726,12 @@ static int w83627ehf_detect(struct i2c_a
 		data->has_fan |= (1 << 4);
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
 	device_create_file(&client->dev, &dev_attr_fan1_input);
 	device_create_file(&client->dev, &dev_attr_fan1_min);
 	device_create_file(&client->dev, &dev_attr_fan1_div);
@@ -756,6 +765,8 @@ static int w83627ehf_detect(struct i2c_a
 
 	return 0;
 
+exit_detach:
+	i2c_detach_client(client);
 exit_free:
 	kfree(data);
 exit_release:
@@ -773,15 +784,18 @@ static int w83627ehf_attach_adapter(stru
 
 static int w83627ehf_detach_client(struct i2c_client *client)
 {
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 	release_region(client->addr, REGION_LENGTH);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -44,6 +44,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -277,6 +279,7 @@ static inline u8 DIV_TO_REG(long val)
    dynamically allocated, at the same time when a new client is allocated. */
 struct w83627hf_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -1102,6 +1105,12 @@ int w83627hf_detect(struct i2c_adapter *
 	data->fan_min[2] = w83627hf_read_value(new_client, W83781D_REG_FAN_MIN(3));
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
+	}
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83697hf)
 		device_create_file_in(new_client, 1);
@@ -1152,6 +1161,8 @@ int w83627hf_detect(struct i2c_adapter *
 
 	return 0;
 
+      ERROR3:
+	i2c_detach_client(new_client);
       ERROR2:
 	kfree(data);
       ERROR1:
@@ -1162,8 +1173,11 @@ int w83627hf_detect(struct i2c_adapter *
 
 static int w83627hf_detach_client(struct i2c_client *client)
 {
+	struct w83627hf_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev,
 		       "Client deregistration failed, client not detached.\n");
@@ -1171,7 +1185,7 @@ static int w83627hf_detach_client(struct
 	}
 
 	release_region(client->addr, WINB_EXTENT);
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 
 	return 0;
 }
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -40,6 +40,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -218,6 +220,7 @@ DIV_TO_REG(long val, enum chips type)
    allocated. */
 struct w83781d_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore lock;
 	enum chips type;
 
@@ -961,10 +964,10 @@ w83781d_detect_subclients(struct i2c_ada
 ERROR_SC_3:
 	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
-	if (NULL != data->lm75[1])
+	if (data->lm75[1])
 		kfree(data->lm75[1]);
 ERROR_SC_1:
-	if (NULL != data->lm75[0])
+	if (data->lm75[0])
 		kfree(data->lm75[0]);
 ERROR_SC_0:
 	return err;
@@ -1189,6 +1192,12 @@ w83781d_detect(struct i2c_adapter *adapt
 			data->pwmenable[i] = 1;
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR4;
+	}
+
 	device_create_file_in(new_client, 0);
 	if (kind != w83783s)
 		device_create_file_in(new_client, 1);
@@ -1241,6 +1250,15 @@ w83781d_detect(struct i2c_adapter *adapt
 
 	return 0;
 
+ERROR4:
+	if (data->lm75[1]) {
+		i2c_detach_client(data->lm75[1]);
+		kfree(data->lm75[1]);
+	}
+	if (data->lm75[0]) {
+		i2c_detach_client(data->lm75[0]);
+		kfree(data->lm75[0]);
+	}
 ERROR3:
 	i2c_detach_client(new_client);
 ERROR2:
@@ -1255,8 +1273,13 @@ ERROR0:
 static int
 w83781d_detach_client(struct i2c_client *client)
 {
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
+	/* main client */
+	if (data)
+		hwmon_device_unregister(data->class_dev);
+
 	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
 
@@ -1266,13 +1289,13 @@ w83781d_detach_client(struct i2c_client 
 		return err;
 	}
 
-	if (i2c_get_clientdata(client)=NULL) {
-		/* subclients */
+	/* main client */
+	if (data)
+		kfree(data);
+
+	/* subclient */
+	else
 		kfree(client);
-	} else {
-		/* main client */
-		kfree(i2c_get_clientdata(client));
-	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -37,6 +37,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
 
 /* How many retries on register read error */
 #define MAX_RETRIES	5
@@ -105,6 +107,7 @@ static struct i2c_driver w83l785ts_drive
 
 struct w83l785ts_data {
 	struct i2c_client client;
+	struct class_device *class_dev;
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -239,11 +242,19 @@ static int w83l785ts_detect(struct i2c_a
 	 */
 
 	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
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
@@ -252,15 +263,18 @@ exit:
 
 static int w83l785ts_detach_client(struct i2c_client *client)
 {
+	struct w83l785ts_data *data = i2c_get_clientdata(client);
 	int err;
 
+	hwmon_device_unregister(data->class_dev);
+
 	if ((err = i2c_detach_client(client))) {
 		dev_err(&client->dev, "Client deregistration failed, "
 			"client not detached.\n");
 		return err;
 	}
 
-	kfree(i2c_get_clientdata(client));
+	kfree(data);
 	return 0;
 }
 

