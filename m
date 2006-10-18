From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:32 +0000
Subject: [lm-sensors] [PATCH 1/8] w83791d: Fix unchecked return status
Message-Id: <11612021792545-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>

Replace all unchecked calls to device_create_file with a single group
declaration, and one call to sysfs_create_group, and check that one
return status. Also remove the files on device detach.

Signed-off-by: Jim Cromie <jim.cromie at gmail.com>
Signed-off by: Charles Spirakis <bezaur at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/w83791d.c |   85 +++++++++++++++++++++++++++++++----------------
 1 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 371ed4f..9e5f885 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -746,6 +746,52 @@ static ssize_t store_vrm_reg(struct devi
 
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 
+#define IN_UNIT_ATTRS(X) \
+	&sda_in_input[X].dev_attr.attr, \
+	&sda_in_min[X].dev_attr.attr,   \
+	&sda_in_max[X].dev_attr.attr
+
+#define FAN_UNIT_ATTRS(X) \
+	&sda_fan_input[X].dev_attr.attr,        \
+	&sda_fan_min[X].dev_attr.attr,          \
+	&sda_fan_div[X].dev_attr.attr
+
+#define TEMP_UNIT_ATTRS(X) \
+	&sda_temp_input[X].dev_attr.attr,       \
+	&sda_temp_max[X].dev_attr.attr,         \
+	&sda_temp_max_hyst[X].dev_attr.attr
+
+static struct attribute *w83791d_attributes[] = {
+	IN_UNIT_ATTRS(0),
+	IN_UNIT_ATTRS(1),
+	IN_UNIT_ATTRS(2),
+	IN_UNIT_ATTRS(3),
+	IN_UNIT_ATTRS(4),
+	IN_UNIT_ATTRS(5),
+	IN_UNIT_ATTRS(6),
+	IN_UNIT_ATTRS(7),
+	IN_UNIT_ATTRS(8),
+	IN_UNIT_ATTRS(9),
+	FAN_UNIT_ATTRS(0),
+	FAN_UNIT_ATTRS(1),
+	FAN_UNIT_ATTRS(2),
+	FAN_UNIT_ATTRS(3),
+	FAN_UNIT_ATTRS(4),
+	TEMP_UNIT_ATTRS(0),
+	TEMP_UNIT_ATTRS(1),
+	TEMP_UNIT_ATTRS(2),
+	&dev_attr_alarms.attr,
+	&sda_beep_ctrl[0].dev_attr.attr,
+	&sda_beep_ctrl[1].dev_attr.attr,
+	&dev_attr_cpu0_vid.attr,
+	&dev_attr_vrm.attr,
+	NULL
+};
+
+static const struct attribute_group w83791d_group = {
+	.attrs = w83791d_attributes,
+};
+
 /* This function is called when:
      * w83791d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -967,41 +1013,20 @@ #endif
 	}
 
 	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&client->dev.kobj, &w83791d_group)))
+		goto error3;
+
+	/* Everything is ready, now register the working device */
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto error3;
+		goto error4;
 	}
 
-	for (i = 0; i < NUMBER_OF_VIN; i++) {
-		device_create_file(dev, &sda_in_input[i].dev_attr);
-		device_create_file(dev, &sda_in_min[i].dev_attr);
-		device_create_file(dev, &sda_in_max[i].dev_attr);
-	}
-
-	for (i = 0; i < NUMBER_OF_FANIN; i++) {
-		device_create_file(dev, &sda_fan_input[i].dev_attr);
-		device_create_file(dev, &sda_fan_div[i].dev_attr);
-		device_create_file(dev, &sda_fan_min[i].dev_attr);
-	}
-
-	for (i = 0; i < NUMBER_OF_TEMPIN; i++) {
-		device_create_file(dev, &sda_temp_input[i].dev_attr);
-		device_create_file(dev, &sda_temp_max[i].dev_attr);
-		device_create_file(dev, &sda_temp_max_hyst[i].dev_attr);
-	}
-
-	device_create_file(dev, &dev_attr_alarms);
-
-	for (i = 0; i < ARRAY_SIZE(sda_beep_ctrl); i++) {
-		device_create_file(dev, &sda_beep_ctrl[i].dev_attr);
-	}
-
-	device_create_file(dev, &dev_attr_cpu0_vid);
-	device_create_file(dev, &dev_attr_vrm);
-
 	return 0;
 
+error4:
+	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 error3:
 	if (data->lm75[0] != NULL) {
 		i2c_detach_client(data->lm75[0]);
@@ -1025,8 +1050,10 @@ static int w83791d_detach_client(struct 
 	int err;
 
 	/* main client */
-	if (data)
+	if (data) {
 		hwmon_device_unregister(data->class_dev);
+		sysfs_remove_group(&client->dev.kobj, &w83791d_group);
+	}
 
 	if ((err = i2c_detach_client(client)))
 		return err;
-- 
1.4.2.4


