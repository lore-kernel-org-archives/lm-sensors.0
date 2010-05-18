From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 May 2010 09:03:44 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (tmp102) Don't always stop chip at
Message-Id: <20100518110344.765d91c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only stop the chip at driver exit if it was stopped when driver was
loaded. Leave it running otherwise.

Also restore the device configuration if probe failed, to not leave
the system in a dangling state.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Steven King <sfking@fdwdc.com>
---
 drivers/hwmon/tmp102.c |   38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

--- linux-2.6.34-rc7.orig/drivers/hwmon/tmp102.c	2010-05-16 09:57:37.000000000 +0200
+++ linux-2.6.34-rc7/drivers/hwmon/tmp102.c	2010-05-17 11:47:50.000000000 +0200
@@ -50,6 +50,7 @@
 struct tmp102 {
 	struct device *hwmon_dev;
 	struct mutex lock;
+	u16 config_orig;
 	unsigned long last_update;
 	int temp[3];
 };
@@ -177,21 +178,27 @@ static int __devinit tmp102_probe(struct
 	}
 	i2c_set_clientdata(client, tmp102);
 
+	status = tmp102_read_reg(client, TMP102_CONF_REG);
+	if (status < 0) {
+		dev_err(&client->dev, "error reading config register\n");
+		goto fail_free;
+	}
+	tmp102->config_orig = status;
 	status = tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONFIG);
 	if (status < 0) {
 		dev_err(&client->dev, "error writing config register\n");
-		goto fail0;
+		goto fail_restore_config;
 	}
 	status = tmp102_read_reg(client, TMP102_CONF_REG);
 	if (status < 0) {
 		dev_err(&client->dev, "error reading config register\n");
-		goto fail0;
+		goto fail_restore_config;
 	}
 	status &= ~TMP102_CONFIG_RD_ONLY;
 	if (status != TMP102_CONFIG) {
 		dev_err(&client->dev, "config settings did not stick\n");
 		status = -ENODEV;
-		goto fail0;
+		goto fail_restore_config;
 	}
 	tmp102->last_update = jiffies - HZ;
 	mutex_init(&tmp102->lock);
@@ -199,21 +206,24 @@ static int __devinit tmp102_probe(struct
 	status = sysfs_create_group(&client->dev.kobj, &tmp102_attr_group);
 	if (status) {
 		dev_dbg(&client->dev, "could not create sysfs files\n");
-		goto fail0;
+		goto fail_restore_config;
 	}
 	tmp102->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(tmp102->hwmon_dev)) {
 		dev_dbg(&client->dev, "unable to register hwmon device\n");
 		status = PTR_ERR(tmp102->hwmon_dev);
-		goto fail1;
+		goto fail_remove_sysfs;
 	}
 
 	dev_info(&client->dev, "initialized\n");
 
 	return 0;
-fail1:
+
+fail_remove_sysfs:
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
-fail0:
+fail_restore_config:
+	tmp102_write_reg(client, TMP102_CONF_REG, tmp102->config_orig);
+fail_free:
 	i2c_set_clientdata(client, NULL);
 	kfree(tmp102);
 
@@ -224,11 +234,19 @@ static int __devexit tmp102_remove(struc
 {
 	struct tmp102 *tmp102 = i2c_get_clientdata(client);
 
-	/* shutdown the chip */
-	tmp102_write_reg(client, TMP102_CONF_REG, TMP102_CONF_SD);
-
 	hwmon_device_unregister(tmp102->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &tmp102_attr_group);
+
+	/* Stop monitoring if device was stopped originally */
+	if (tmp102->config_orig & TMP102_CONF_SD) {
+		int config;
+
+		config = tmp102_read_reg(client, TMP102_CONF_REG);
+		if (config >= 0)
+			tmp102_write_reg(client, TMP102_CONF_REG,
+					 config | TMP102_CONF_SD);
+	}
+
 	i2c_set_clientdata(client, NULL);
 	kfree(tmp102);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
