From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 02 Sep 2007 18:07:35 +0000
Subject: Re: [lm-sensors] [patch 3/6] Convert from class_device to device
Message-Id: <20070902180735.GA3547@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tony et al:

* Tony Jones <tonyj@suse.de> [2007-08-20 13:46:20 -0700]:
> Discussed on lkml as message id 20070808053022.519538000@suse.de.
> 
> Sorry, I forgot to cc you.
> 
> Patches attached.
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Tony

> Subject: Convert from class_device to device for hwmon
> 
> Convert from class_device to device for hwmon_device_register/unregister
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

Thanks for doing that.  I combined the two patches into one (to avoid known
git-bisect breakage) and massaged them a bit to apply to my testing tree[1].
I also converted four new drivers there that you wouldn't have seen.

The resulting commit is below; notice that I left the author and signed-off-bys
intact.  Please let me know if that's not OK with you.

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

Regards,

commit 4b936941c67d29f8b5de258a75ee84af1061b784
Author: Tony Jones <tonyj@suse.de>
Date:   Mon Aug 20 13:46:20 2007 -0700

    hwmon: Convert from class_device to device
    
    Convert from class_device to device for hwmon_device_register/unregister
    
    Signed-off-by: Tony Jones <tonyj@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
    Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
    Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index d575ee9..719151a 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -176,7 +176,7 @@ MODULE_PARM_DESC(verbose, "How verbose should the driver be? (0-3):\n"
    The structure is dynamically allocated, at the same time when a new
    abituguru device is allocated. */
 struct abituguru_data {
-	struct class_device *class_dev; /* hwmon registered device */
+	struct device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned short addr;		/* uguru base address */
@@ -1287,11 +1287,11 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 				&abituguru_sysfs_attr[i].dev_attr))
 			goto abituguru_probe_error;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (!IS_ERR(data->class_dev))
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (!IS_ERR(data->hwmon_dev))
 		return 0; /* success */
 
-	res = PTR_ERR(data->class_dev);
+	res = PTR_ERR(data->hwmon_dev);
 abituguru_probe_error:
 	for (i = 0; data->sysfs_attr[i].dev_attr.attr.name; i++)
 		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
@@ -1308,7 +1308,7 @@ static int __devexit abituguru_remove(struct platform_device *pdev)
 	int i;
 	struct abituguru_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	for (i = 0; data->sysfs_attr[i].dev_attr.attr.name; i++)
 		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index cdd8b6d..cb2331b 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -124,7 +124,7 @@ struct abituguru3_motherboard_info {
    The structure is dynamically allocated, at the same time when a new
    abituguru3 device is allocated. */
 struct abituguru3_data {
-	struct class_device *class_dev; /* hwmon registered device */
+	struct device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned short addr;		/* uguru base address */
 	char valid;			/* !=0 if following fields are valid */
@@ -933,9 +933,9 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 				&abituguru3_sysfs_attr[i].dev_attr))
 			goto abituguru3_probe_error;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		res = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		res = PTR_ERR(data->hwmon_dev);
 		goto abituguru3_probe_error;
 	}
 
@@ -957,7 +957,7 @@ static int __devexit abituguru3_remove(struct platform_device *pdev)
 	struct abituguru3_data *data = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	for (i = 0; data->sysfs_attr[i].dev_attr.attr.name; i++)
 		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(abituguru3_sysfs_attr); i++)
diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index 879ea72..fcd7fe7 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -47,7 +47,7 @@ static const u8 AD7418_REG_TEMP[] = { AD7418_REG_TEMP_IN,
 
 struct ad7418_data {
 	struct i2c_client	client;
-	struct class_device	*class_dev;
+	struct device		*hwmon_dev;
 	struct attribute_group	attrs;
 	enum chips		type;
 	struct mutex		lock;
@@ -326,9 +326,9 @@ static int ad7418_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -347,7 +347,7 @@ exit:
 static int ad7418_detach_client(struct i2c_client *client)
 {
 	struct ad7418_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
 	i2c_detach_client(client);
 	kfree(data);
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 6649e06..5667630 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -91,7 +91,7 @@ clearing it.  Weird, ey?   --Phil  */
 /* Each client has this additional data */
 struct adm1021_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -319,9 +319,9 @@ static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&client->dev.kobj, &adm1021_group)))
 		goto error2;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto error3;
 	}
 
@@ -351,7 +351,7 @@ static int adm1021_detach_client(struct i2c_client *client)
 	struct adm1021_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1021_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 8c56288..a67e133 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -133,7 +133,7 @@ static struct i2c_driver adm1025_driver = {
 
 struct adm1025_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -472,9 +472,9 @@ static int adm1025_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -538,7 +538,7 @@ static int adm1025_detach_client(struct i2c_client *client)
 	struct adm1025_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1025_group_opt);
 
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index ba80cd3..b85370c 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -260,7 +260,7 @@ struct pwm_data {
 
 struct adm1026_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -1676,9 +1676,9 @@ static int adm1026_detect(struct i2c_adapter *adapter, int address,
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm1026_group)))
 		goto exitdetach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exitremove;
 	}
 
@@ -1698,7 +1698,7 @@ exit:
 static int adm1026_detach_client(struct i2c_client *client)
 {
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
 	i2c_detach_client(client);
 	kfree(data);
diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 73ce31b..0bc897d 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -141,7 +141,7 @@ static struct i2c_driver adm1029_driver = {
 
 struct adm1029_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
@@ -391,9 +391,9 @@ static int adm1029_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&client->dev.kobj, &adm1029_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -431,7 +431,7 @@ static int adm1029_detach_client(struct i2c_client *client)
 	struct adm1029_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1029_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 122683f..37cfc10 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -70,7 +70,7 @@ typedef u8 auto_chan_table_t[8][2];
 /* Each client has this additional data */
 struct adm1031_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
@@ -853,9 +853,9 @@ static int adm1031_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -877,7 +877,7 @@ static int adm1031_detach_client(struct i2c_client *client)
 	struct adm1031_data *data = i2c_get_clientdata(client);
 	int ret;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
 	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
 	if ((ret = i2c_detach_client(client)) != 0) {
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index aad594a..c17d0b6 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -150,7 +150,7 @@ static struct i2c_driver adm9240_driver = {
 struct adm9240_data {
 	enum chips type;
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
@@ -590,9 +590,9 @@ static int adm9240_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -620,7 +620,7 @@ static int adm9240_detach_client(struct i2c_client *client)
 	struct adm9240_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index c4dc205..9810aaa 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -124,7 +124,7 @@ I2C_CLIENT_INSMOD_1(adt7470);
 
 struct adt7470_data {
 	struct i2c_client	client;
-	struct class_device	*class_dev;
+	struct device		*hwmon_dev;
 	struct attribute_group	attrs;
 	struct mutex		lock;
 	char			sensors_valid;
@@ -1003,9 +1003,9 @@ static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -1025,7 +1025,7 @@ static int adt7470_detach_client(struct i2c_client *client)
 {
 	struct adt7470_data *data = i2c_get_clientdata(client);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
 	i2c_detach_client(client);
 	kfree(data);
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 941729a..21ff8e1 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -127,7 +127,7 @@ static s16 rest_x;
 static s16 rest_y;
 static struct timer_list applesmc_timer;
 static struct input_dev *applesmc_idev;
-static struct class_device *hwmon_class_dev;
+static struct device *hwmon_dev;
 
 /* Indicates whether this computer has an accelerometer. */
 static unsigned int applesmc_accelerometer;
@@ -1287,9 +1287,9 @@ static int __init applesmc_init(void)
 			goto out_light_wq;
 	}
 
-	hwmon_class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(hwmon_class_dev)) {
-		ret = PTR_ERR(hwmon_class_dev);
+	hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
 		goto out_light_ledclass;
 	}
 
@@ -1331,7 +1331,7 @@ out:
 
 static void __exit applesmc_exit(void)
 {
-	hwmon_device_unregister(hwmon_class_dev);
+	hwmon_device_unregister(hwmon_dev);
 	if (applesmc_light) {
 		led_classdev_unregister(&applesmc_backlight);
 		destroy_workqueue(applesmc_led_wq);
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index 55d92e1..745bf26 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -182,7 +182,7 @@ static u8 DIV_TO_REG(long val)
    dynamically allocated, at the same time the client itself is allocated. */
 struct asb100_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
@@ -844,9 +844,9 @@ static int asb100_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &asb100_group)))
 		goto ERROR3;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
 	}
 
@@ -874,7 +874,7 @@ static int asb100_detach_client(struct i2c_client *client)
 
 	/* main client */
 	if (data) {
-		hwmon_device_unregister(data->class_dev);
+		hwmon_device_unregister(data->hwmon_dev);
 		sysfs_remove_group(&client->dev.kobj, &asb100_group);
 	}
 
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 0ccdd07..cce3350 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -61,7 +61,7 @@ static struct i2c_driver atxp1_driver = {
 
 struct atxp1_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
@@ -335,9 +335,9 @@ static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -361,7 +361,7 @@ static int atxp1_detach_client(struct i2c_client * client)
 	struct atxp1_data * data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
 
 	err = i2c_detach_client(client);
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index f7b0ef4..1a0ff8d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -47,7 +47,7 @@ typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
 static struct coretemp_data *coretemp_update_device(struct device *dev);
 
 struct coretemp_data {
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	u32 id;
@@ -226,9 +226,9 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
 		goto exit_free;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		dev_err(&pdev->dev, "Class registration failed (%d)\n",
 			err);
 		goto exit_class;
@@ -248,7 +248,7 @@ static int __devexit coretemp_remove(struct platform_device *pdev)
 {
 	struct coretemp_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index e9cbc72..14ebbfb 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -155,7 +155,7 @@ static const u8 DME1737_BIT_ALARM_FAN[] = {10, 11, 12, 13, 22, 23};
 
 struct dme1737_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	int valid;			/* !=0 if following fields are valid */
@@ -1983,9 +1983,9 @@ static int dme1737_detect(struct i2c_adapter *adapter, int address,
 	}
 
 	/* Register device */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -2030,7 +2030,7 @@ static int dme1737_detach_client(struct i2c_client *client)
 	struct dme1737_data *data = i2c_get_clientdata(client);
 	int ix, err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 
 	for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
 		if (data->has_fan & (1 << ix)) {
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 5a861f9..b7bd000 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -73,7 +73,7 @@ static const u8 DS1621_REG_TEMP[3] = {
 /* Each client has this additional data */
 struct ds1621_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -266,9 +266,9 @@ static int ds1621_detect(struct i2c_adapter *adapter, int address,
 	if ((err = sysfs_create_group(&client->dev.kobj, &ds1621_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -289,7 +289,7 @@ static int ds1621_detach_client(struct i2c_client *client)
 	struct ds1621_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &ds1621_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 1cd71a5..5d9d5cc 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -162,7 +162,7 @@ struct f71805f_auto_point {
 struct f71805f_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
@@ -1381,9 +1381,9 @@ static int __devinit f71805f_probe(struct platform_device *pdev)
 		}
 	}
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
 		goto exit_remove_files;
 	}
@@ -1410,7 +1410,7 @@ static int __devexit f71805f_remove(struct platform_device *pdev)
 	struct resource *res;
 	int i;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group);
 	for (i = 0; i < 4; i++)
 		sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_optin[i]);
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index b4ff0f9..6db7443 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -87,7 +87,7 @@ static inline u16 fan_from_reg ( u16 reg );
 
 struct f71882fg_data {
 	unsigned short addr;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
@@ -781,9 +781,9 @@ static int __devinit f71882fg_probe(struct platform_device * pdev)
 		}
 	}
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_unregister_sysfs;
 	}
 
@@ -811,7 +811,7 @@ static int __devexit f71882fg_remove(struct platform_device *pdev)
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_dev_attr); i++)
 		device_remove_file(&pdev->dev, &f71882fg_dev_attr[i]);
diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 6425184..13a0413 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -87,7 +87,7 @@ I2C_CLIENT_INSMOD_2(f75373, f75375);
 struct f75375_data {
 	unsigned short addr;
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	const char *name;
 	int kind;
@@ -583,7 +583,7 @@ static int f75375_detach_client(struct i2c_client *client)
 	struct f75375_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &f75375_group);
 
 	err = i2c_detach_client(client);
@@ -655,9 +655,9 @@ static int f75375_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&client->dev.kobj, &f75375_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index b34b546..e67c369 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -134,7 +134,7 @@ static struct i2c_driver fscher_driver = {
 
 struct fscher_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -344,9 +344,9 @@ static int fscher_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &fscher_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -367,7 +367,7 @@ static int fscher_detach_client(struct i2c_client *client)
 	struct fscher_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &fscher_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
index ea506a7..92c9703 100644
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -115,7 +115,7 @@ static struct i2c_driver fscpos_driver = {
  */
 struct fscpos_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; 		/* 0 until following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -539,9 +539,9 @@ static int fscpos_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &fscpos_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -562,7 +562,7 @@ static int fscpos_detach_client(struct i2c_client *client)
 	struct fscpos_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &fscpos_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
index c103640..bb58d98 100644
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -119,7 +119,7 @@ static inline u8 FAN_TO_REG(long rpm, int div)
 /* Each client has this additional data */
 struct gl518_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -460,9 +460,9 @@ static int gl518_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &gl518_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -502,7 +502,7 @@ static int gl518_detach_client(struct i2c_client *client)
 	struct gl518_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &gl518_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index ebe7b9a..a3b56c8 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -122,7 +122,7 @@ static struct i2c_driver gl520_driver = {
 /* Client data */
 struct gl520_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
@@ -622,9 +622,9 @@ static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
 	}
 
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -685,7 +685,7 @@ static int gl520_detach_client(struct i2c_client *client)
 	struct gl520_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
 
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index affcc00..3db2845 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -28,17 +28,17 @@ static DEFINE_IDR(hwmon_idr);
 static DEFINE_SPINLOCK(idr_lock);
 
 /**
- * hwmon_device_register - register w/ hwmon sysfs class
+ * hwmon_device_register - register w/ hwmon
  * @dev: the device to register
  *
- * hwmon_device_unregister() must be called when the class device is no
+ * hwmon_device_unregister() must be called when the device is no
  * longer needed.
  *
- * Returns the pointer to the new struct class device.
+ * Returns the pointer to the new device.
  */
-struct class_device *hwmon_device_register(struct device *dev)
+struct device *hwmon_device_register(struct device *dev)
 {
-	struct class_device *cdev;
+	struct device *hwdev;
 	int id, err;
 
 again:
@@ -55,34 +55,33 @@ again:
 		return ERR_PTR(err);
 
 	id = id & MAX_ID_MASK;
-	cdev = class_device_create(hwmon_class, NULL, MKDEV(0,0), dev,
-					HWMON_ID_FORMAT, id);
+	hwdev = device_create(hwmon_class, dev, MKDEV(0,0), HWMON_ID_FORMAT, id);
 
-	if (IS_ERR(cdev)) {
+	if (IS_ERR(hwdev)) {
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
 	}
 
-	return cdev;
+	return hwdev;
 }
 
 /**
  * hwmon_device_unregister - removes the previously registered class device
  *
- * @cdev: the class device to destroy
+ * @dev: the class device to destroy
  */
-void hwmon_device_unregister(struct class_device *cdev)
+void hwmon_device_unregister(struct device *dev)
 {
 	int id;
 
-	if (likely(sscanf(cdev->class_id, HWMON_ID_FORMAT, &id) = 1)) {
-		class_device_unregister(cdev);
+	if (likely(sscanf(dev->bus_id, HWMON_ID_FORMAT, &id) = 1)) {
+		device_unregister(dev);
 		spin_lock(&idr_lock);
 		idr_remove(&hwmon_idr, id);
 		spin_unlock(&idr_lock);
 	} else
-		dev_dbg(cdev->dev,
+		dev_dbg(dev->parent,
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d75dba9..41a90e5 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -222,7 +222,7 @@ struct it87_sio_data {
 /* For each registered chip, we need to keep some data in memory.
    The structure is dynamically allocated. */
 struct it87_data {
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	unsigned short addr;
@@ -1089,9 +1089,9 @@ static int __devinit it87_probe(struct platform_device *pdev)
 			goto ERROR4;
 	}
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
 	}
 
@@ -1113,7 +1113,7 @@ static int __devexit it87_remove(struct platform_device *pdev)
 {
 	struct it87_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &it87_group);
 	sysfs_remove_group(&pdev->dev.kobj, &it87_group_opt);
 
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 5d8d0ca..bd2bde0 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -38,7 +38,7 @@
 #define SEL_CORE	0x04
 
 struct k8temp_data {
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	const char *name;
 	char valid;		/* zero until following fields are valid */
@@ -225,10 +225,10 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 	if (err)
 		goto exit_remove;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -255,7 +255,7 @@ static void __devexit k8temp_remove(struct pci_dev *pdev)
 {
 	struct k8temp_data *data = dev_get_drvdata(&pdev->dev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_remove_file(&pdev->dev,
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 2162d69..f207434 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -154,7 +154,7 @@ static struct i2c_driver lm63_driver = {
 
 struct lm63_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -502,9 +502,9 @@ static int lm63_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -561,7 +561,7 @@ static int lm63_detach_client(struct i2c_client *client)
 	struct lm63_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group);
 	sysfs_remove_group(&client->dev.kobj, &lm63_group_fan1);
 
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 30b9b2b..dd36688 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -37,7 +37,7 @@
 #define DRVNAME		"lm70"
 
 struct lm70 {
-	struct class_device *cdev;
+	struct device *hwmon_dev;
 	struct semaphore sem;
 };
 
@@ -115,10 +115,10 @@ static int __devinit lm70_probe(struct spi_device *spi)
 	init_MUTEX(&p_lm70->sem);
 
 	/* sysfs hook */
-	p_lm70->cdev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(p_lm70->cdev)) {
+	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
+	if (IS_ERR(p_lm70->hwmon_dev)) {
 		dev_dbg(&spi->dev, "hwmon_device_register failed.\n");
-		status = PTR_ERR(p_lm70->cdev);
+		status = PTR_ERR(p_lm70->hwmon_dev);
 		goto out_dev_reg_failed;
 	}
 	dev_set_drvdata(&spi->dev, p_lm70);
@@ -133,7 +133,7 @@ static int __devinit lm70_probe(struct spi_device *spi)
 
 out_dev_create_file_failed:
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
-	hwmon_device_unregister(p_lm70->cdev);
+	hwmon_device_unregister(p_lm70->hwmon_dev);
 out_dev_reg_failed:
 	dev_set_drvdata(&spi->dev, NULL);
 	kfree(p_lm70);
@@ -146,7 +146,7 @@ static int __devexit lm70_remove(struct spi_device *spi)
 
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	device_remove_file(&spi->dev, &dev_attr_name);
-	hwmon_device_unregister(p_lm70->cdev);
+	hwmon_device_unregister(p_lm70->hwmon_dev);
 	dev_set_drvdata(&spi->dev, NULL);
 	kfree(p_lm70);
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4fa3220..37a8cc0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -50,7 +50,7 @@ static const u8 LM75_REG_TEMP[3] = {
 /* Each client has this additional data */
 struct lm75_data {
 	struct i2c_client	client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
@@ -219,9 +219,9 @@ static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm75_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -240,7 +240,7 @@ exit:
 static int lm75_detach_client(struct i2c_client *client)
 {
 	struct lm75_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	i2c_detach_client(client);
 	kfree(data);
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index 46e3aba..cee5c2e 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -51,7 +51,7 @@ I2C_CLIENT_INSMOD_1(lm77);
 /* Each client has this additional data */
 struct lm77_data {
 	struct i2c_client	client;
-	struct class_device *class_dev;
+	struct device 		*hwmon_dev;
 	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
@@ -337,9 +337,9 @@ static int lm77_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm77_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -358,7 +358,7 @@ exit:
 static int lm77_detach_client(struct i2c_client *client)
 {
 	struct lm77_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm77_group);
 	i2c_detach_client(client);
 	kfree(data);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 565c4e6..db9b879 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -131,7 +131,7 @@ static inline int TEMP_FROM_REG(s8 val)
    the driver field to differentiate between I2C and ISA chips. */
 struct lm78_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
@@ -585,9 +585,9 @@ static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm78_group)))
 		goto ERROR3;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
 	}
 
@@ -608,7 +608,7 @@ static int lm78_detach_client(struct i2c_client *client)
 	struct lm78_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm78_group);
 
 	if ((err = i2c_detach_client(client)))
@@ -659,9 +659,9 @@ static int __devinit lm78_isa_probe(struct platform_device *pdev)
 	 || (err = device_create_file(&pdev->dev, &dev_attr_name)))
 		goto exit_remove_files;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -681,7 +681,7 @@ static int __devexit lm78_isa_remove(struct platform_device *pdev)
 {
 	struct lm78_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	release_region(data->client.addr, LM78_EXTENT);
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 064516d..063cdba 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -108,7 +108,7 @@ static inline long TEMP_FROM_REG(u16 temp)
 
 struct lm80_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -497,9 +497,9 @@ static int lm80_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm80_group)))
 		goto error_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto error_remove;
 	}
 
@@ -520,7 +520,7 @@ static int lm80_detach_client(struct i2c_client *client)
 	struct lm80_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm80_group);
 	if ((err = i2c_detach_client(client)))
 		return err;
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 654c0f7..0336b45 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -144,7 +144,7 @@ static struct i2c_driver lm83_driver = {
 
 struct lm83_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -400,9 +400,9 @@ static int lm83_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -424,7 +424,7 @@ static int lm83_detach_client(struct i2c_client *client)
 	struct lm83_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm83_group);
 	sysfs_remove_group(&client->dev.kobj, &lm83_group_opt);
 
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 20a8c64..954c364 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -328,7 +328,7 @@ struct lm85_autofan {
    The structure is dynamically allocated. */
 struct lm85_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -1257,9 +1257,9 @@ static int lm85_detect(struct i2c_adapter *adapter, int address,
 					&dev_attr_in4_max)))
 			goto ERROR3;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR3;
 	}
 
@@ -1280,7 +1280,7 @@ static int lm85_detect(struct i2c_adapter *adapter, int address,
 static int lm85_detach_client(struct i2c_client *client)
 {
 	struct lm85_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm85_group);
 	sysfs_remove_group(&client->dev.kobj, &lm85_group_opt);
 	i2c_detach_client(client);
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 988ae1c..e60076e 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -176,7 +176,7 @@ static struct i2c_driver lm87_driver = {
 
 struct lm87_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
@@ -755,9 +755,9 @@ static int lm87_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -816,7 +816,7 @@ static int lm87_detach_client(struct i2c_client *client)
 	struct lm87_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group);
 	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
 
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index af541d6..98b53b1 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -214,7 +214,7 @@ static struct i2c_driver lm90_driver = {
 
 struct lm90_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -653,9 +653,9 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -707,7 +707,7 @@ static int lm90_detach_client(struct i2c_client *client)
 	struct lm90_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
 	device_remove_file(&client->dev, &dev_attr_pec);
 
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 30b5363..61d1bd1 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -96,7 +96,7 @@ static struct i2c_driver lm92_driver;
 /* Client data (each client gets its own) */
 struct lm92_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -379,9 +379,9 @@ static int lm92_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm92_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -409,7 +409,7 @@ static int lm92_detach_client(struct i2c_client *client)
 	struct lm92_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm92_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 86c6c6e..b9899b9 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -201,7 +201,7 @@ struct block1_t {
  */
 struct lm93_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -2590,11 +2590,11 @@ static int lm93_detect(struct i2c_adapter *adapter, int address, int kind)
 		goto err_detach;
 
 	/* Register hwmon driver class */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if ( !IS_ERR(data->class_dev))
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if ( !IS_ERR(data->hwmon_dev))
 		return 0;
 
-	err = PTR_ERR(data->class_dev);
+	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
 err_detach:
@@ -2619,7 +2619,7 @@ static int lm93_detach_client(struct i2c_client *client)
 	struct lm93_data *data = i2c_get_clientdata(client);
 	int err = 0;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
 
 	err = i2c_detach_client(client);
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 2f58f65..38a44c3 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -105,7 +105,7 @@ static struct i2c_driver max1619_driver = {
 
 struct max1619_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -293,9 +293,9 @@ static int max1619_detect(struct i2c_adapter *adapter, int address, int kind)
 	if ((err = sysfs_create_group(&new_client->dev.kobj, &max1619_group)))
 		goto exit_detach;
 
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -331,7 +331,7 @@ static int max1619_detach_client(struct i2c_client *client)
 	struct max1619_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &max1619_group);
 
 	if ((err = i2c_detach_client(client)))
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 8415664..755570c 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -128,7 +128,7 @@ static struct i2c_driver max6650_driver = {
 struct max6650_data
 {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -523,11 +523,11 @@ static int max6650_detect(struct i2c_adapter *adapter, int address, int kind)
 	if (err)
 		goto err_detach;
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->class_dev))
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (!IS_ERR(data->hwmon_dev))
 		return 0;
 
-	err = PTR_ERR(data->class_dev);
+	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
 	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
 err_detach:
@@ -543,7 +543,7 @@ static int max6650_detach_client(struct i2c_client *client)
 	int err;
 
 	sysfs_remove_group(&client->dev.kobj, &max6650_attr_grp);
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	err = i2c_detach_client(client);
 	if (!err)
 		kfree(data);
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index f57c75d..91cf510 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -180,7 +180,7 @@ static inline u8 PWM_TO_REG(int val, int inv)
 
 struct pc87360_data {
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
@@ -1054,9 +1054,9 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	if ((err = device_create_file(dev, &dev_attr_name)))
 		goto ERROR3;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR3;
 	}
 	return 0;
@@ -1083,7 +1083,7 @@ static int __devexit pc87360_remove(struct platform_device *pdev)
 	struct pc87360_data *data = platform_get_drvdata(pdev);
 	int i;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_temp_group);
diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
index 2915bc4..d40509a 100644
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -42,7 +42,7 @@ static struct platform_device *pdev;
    device is using banked registers) and the register cache (needed to keep
    the data in the registers and the cache in sync at any time). */
 struct pc87427_data {
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	int address[2];
 	const char *name;
@@ -454,9 +454,9 @@ static int __devinit pc87427_probe(struct platform_device *pdev)
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
 		goto exit_remove_files;
 	}
@@ -484,7 +484,7 @@ static int __devexit pc87427_remove(struct platform_device *pdev)
 	struct resource *res;
 	int i;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	for (i = 0; i < 8; i++) {
 		if (!(data->fan_enabled & (1 << i)))
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 92956eb..3de9721 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -163,7 +163,7 @@ static inline u8 DIV_TO_REG(int val)
 struct sis5595_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
@@ -557,9 +557,9 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -580,7 +580,7 @@ static int __devexit sis5595_remove(struct platform_device *pdev)
 {
 	struct sis5595_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_opt);
 
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index 45266b3..0b57d2e 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -94,7 +94,7 @@ static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
 struct smsc47b397_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
@@ -222,7 +222,7 @@ static int __devexit smsc47b397_remove(struct platform_device *pdev)
 	struct smsc47b397_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &smsc47b397_group);
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	release_region(res->start, SMSC_EXTENT);
@@ -272,9 +272,9 @@ static int __devinit smsc47b397_probe(struct platform_device *pdev)
 	if ((err = sysfs_create_group(&dev->kobj, &smsc47b397_group)))
 		goto error_free;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto error_remove;
 	}
 
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 7179277..a10a380 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -116,7 +116,7 @@ struct smsc47m1_data {
 	unsigned short addr;
 	const char *name;
 	enum chips type;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -588,9 +588,9 @@ static int __devinit smsc47m1_probe(struct platform_device *pdev)
 	if ((err = device_create_file(dev, &dev_attr_name)))
 		goto error_remove_files;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto error_remove_files;
 	}
 
@@ -611,7 +611,7 @@ static int __devexit smsc47m1_remove(struct platform_device *pdev)
 	struct smsc47m1_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &smsc47m1_group);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index d3a3ba0..0efcd27 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -97,7 +97,7 @@ static inline int TEMP_FROM_REG(s8 val)
 
 struct smsc47m192_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -553,9 +553,9 @@ static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
 			goto exit_remove_files;
 	}
 
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -577,7 +577,7 @@ static int smsc47m192_detach_client(struct i2c_client *client)
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
 	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
 
diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index c920f39..981d1f1 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -61,7 +61,7 @@ const static u8 THMC50_REG_TEMP_MAX[] = { 0x39, 0x37, 0x2B };
 /* Each client has this additional data */
 struct thmc50_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	enum chips type;
@@ -351,9 +351,9 @@ static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
 			goto exit_remove_sysfs_thmc50;
 
 	/* Register a new directory entry with module sensors */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_sysfs;
 	}
 
@@ -384,7 +384,7 @@ static int thmc50_detach_client(struct i2c_client *client)
 	struct thmc50_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
 	if (data->type = adm1022)
 		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 696c8a2..8f63dad 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -294,7 +294,7 @@ static inline long TEMP_FROM_REG10(u16 val)
 struct via686a_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -627,9 +627,9 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &via686a_group)))
 		goto exit_free;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -648,7 +648,7 @@ static int __devexit via686a_remove(struct platform_device *pdev)
 {
 	struct via686a_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
 
 	release_region(data->addr, VIA686A_EXTENT);
diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 9f3e332..e694164 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -108,7 +108,7 @@ static const u8 bitalarmfan[]	= {6, 7};
 struct vt1211_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
@@ -1191,9 +1191,9 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	}
 
 	/* Register device */
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		dev_err(dev, "Class registration failed (%d)\n", err);
 		goto EXIT_DEV_REMOVE_SILENT;
 	}
@@ -1217,7 +1217,7 @@ static int __devexit vt1211_remove(struct platform_device *pdev)
 	struct vt1211_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	vt1211_remove_sysfs(pdev);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 3e63eaf..8806302 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -148,7 +148,7 @@ struct vt8231_data {
 	const char *name;
 
 	struct mutex update_lock;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
@@ -726,9 +726,9 @@ int vt8231_probe(struct platform_device *pdev)
 		}
 	}
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 	return 0;
@@ -756,7 +756,7 @@ static int __devexit vt8231_remove(struct platform_device *pdev)
 	struct vt8231_data *data = platform_get_drvdata(pdev);
 	int i;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 
 	for (i = 0; i < ARRAY_SIZE(vt8231_group_volts); i++)
 		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_volts[i]);
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index e3dfc52..b15c6a9 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -256,7 +256,7 @@ struct w83627ehf_data {
 	int addr;	/* IO base of hw monitor block */
 	const char *name;
 
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 
 	struct mutex update_lock;
@@ -1384,9 +1384,9 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			goto exit_remove;
 	}
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -1406,7 +1406,7 @@ static int __devexit w83627ehf_remove(struct platform_device *pdev)
 {
 	struct w83627ehf_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	w83627ehf_device_remove_files(&pdev->dev);
 	release_region(data->addr, IOREGION_LENGTH);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index f0e0e20..b1943ec 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -346,7 +346,7 @@ static inline u8 DIV_TO_REG(long val)
 struct w83627hf_data {
 	unsigned short addr;
 	const char *name;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
@@ -1295,9 +1295,9 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 		 || (err = device_create_file(dev, &dev_attr_pwm3_freq)))
 			goto ERROR4;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
 	}
 
@@ -1320,7 +1320,7 @@ static int __devexit w83627hf_remove(struct platform_device *pdev)
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group_opt);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index fe2a791..fef32d8 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -220,7 +220,7 @@ DIV_TO_REG(long val, enum chips type)
    the driver field to differentiate between I2C and ISA chips. */
 struct w83781d_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
@@ -1158,9 +1158,9 @@ w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
 	if (err)
 		goto ERROR4;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto ERROR4;
 	}
 
@@ -1194,7 +1194,7 @@ w83781d_detach_client(struct i2c_client *client)
 
 	/* main client */
 	if (data) {
-		hwmon_device_unregister(data->class_dev);
+		hwmon_device_unregister(data->hwmon_dev);
 		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
 		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
 	}
@@ -1261,9 +1261,9 @@ w83781d_isa_probe(struct platform_device *pdev)
 	if (err)
 		goto exit_remove_files;
 
-	data->class_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -1285,7 +1285,7 @@ w83781d_isa_remove(struct platform_device *pdev)
 {
 	struct w83781d_data *data = platform_get_drvdata(pdev);
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
 	device_remove_file(&pdev->dev, &dev_attr_name);
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 9e5f885..a3cb894 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -247,7 +247,7 @@ static u8 div_to_reg(int nr, long val)
 
 struct w83791d_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 
 	char valid;			/* !=0 if following fields are valid */
@@ -1017,9 +1017,9 @@ static int w83791d_detect(struct i2c_adapter *adapter, int address, int kind)
 		goto error3;
 
 	/* Everything is ready, now register the working device */
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto error4;
 	}
 
@@ -1051,7 +1051,7 @@ static int w83791d_detach_client(struct i2c_client *client)
 
 	/* main client */
 	if (data) {
-		hwmon_device_unregister(data->class_dev);
+		hwmon_device_unregister(data->hwmon_dev);
 		sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 	}
 
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index f6dee38..f836198 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -267,7 +267,7 @@ DIV_TO_REG(long val)
 
 struct w83792d_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -1443,9 +1443,9 @@ w83792d_detect(struct i2c_adapter *adapter, int address, int kind)
 					      &w83792d_group_fan[3])))
 			goto exit_remove_files;
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove_files;
 	}
 
@@ -1480,7 +1480,7 @@ w83792d_detach_client(struct i2c_client *client)
 
 	/* main client */
 	if (data) {
-		hwmon_device_unregister(data->class_dev);
+		hwmon_device_unregister(data->hwmon_dev);
 		sysfs_remove_group(&client->dev.kobj, &w83792d_group);
 		for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
 			sysfs_remove_group(&client->dev.kobj,
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 253ffaf..48599e1 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -179,7 +179,7 @@ static inline s8 TEMP_TO_REG(long val, s8 min, s8 max)
 struct w83793_data {
 	struct i2c_client client;
 	struct i2c_client *lm75[2];
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -1075,7 +1075,7 @@ static int w83793_detach_client(struct i2c_client *client)
 
 	/* main client */
 	if (data) {
-		hwmon_device_unregister(data->class_dev);
+		hwmon_device_unregister(data->hwmon_dev);
 
 		for (i = 0; i < ARRAY_SIZE(w83793_sensor_attr_2); i++)
 			device_remove_file(dev,
@@ -1434,9 +1434,9 @@ static int w83793_detect(struct i2c_adapter *adapter, int address, int kind)
 		}
 	}
 
-	data->class_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index a3fcace..b5db354 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -107,7 +107,7 @@ static struct i2c_driver w83l785ts_driver = {
 
 struct w83l785ts_data {
 	struct i2c_client client;
-	struct class_device *class_dev;
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -247,9 +247,9 @@ static int w83l785ts_detect(struct i2c_adapter *adapter, int address, int kind)
 		goto exit_remove;
 
 	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
 		goto exit_remove;
 	}
 
@@ -272,7 +272,7 @@ static int w83l785ts_detach_client(struct i2c_client *client)
 	struct w83l785ts_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(&client->dev,
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_remove_file(&client->dev,
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 96581d0..51ae4fb 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -83,7 +83,7 @@ struct ads7846 {
 
 #if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
 	struct attribute_group	*attr_group;
-	struct class_device	*hwmon;
+	struct device		*hwmon;
 #endif
 
 	u16			model;
@@ -369,7 +369,7 @@ static struct attribute_group ads7845_attr_group = {
 
 static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
 {
-	struct class_device *hwmon;
+	struct device *hwmon;
 	int err;
 
 	/* hwmon sensors need a reference voltage */
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index bb8956d..6790fd0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -517,7 +517,7 @@ static char *next_cmd(char **cmds)
  ****************************************************************************/
 
 static struct platform_device *tpacpi_pdev;
-static struct class_device *tpacpi_hwmon;
+static struct device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
 
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index eee8809..3771e6e 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -171,7 +171,7 @@ static int parse_strtoul(const char *buf, unsigned long max,
 
 /* Device model */
 static struct platform_device *tpacpi_pdev;
-static struct class_device *tpacpi_hwmon;
+static struct device *tpacpi_hwmon;
 static struct platform_driver tpacpi_pdriver;
 static struct input_dev *tpacpi_inputdev;
 static int tpacpi_create_driver_attributes(struct device_driver *drv);
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 0efd994..6b6ee70 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -16,9 +16,9 @@
 
 #include <linux/device.h>
 
-struct class_device *hwmon_device_register(struct device *dev);
+struct device *hwmon_device_register(struct device *dev);
 
-void hwmon_device_unregister(struct class_device *cdev);
+void hwmon_device_unregister(struct device *dev);
 
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)
-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
