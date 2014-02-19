From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 01:01:16 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (lm90) Create most optional attributes with sysfs_create_group
Message-Id: <1392771679-14666-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With the new hwmon API, all attributes have to be created as groups.
Use sysfs_create_group and sysfs_remove_group instead of device_create_file
and device_remove_file to prepare for the new API.

Exception is the 'pec' attribute which will stay with the i2c device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Do not touch 'pec' attribute
    Name new attribute list 'lm90_temp2_offset_attributes' to match
    other attribute list variable names.

 drivers/hwmon/lm90.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 701e952..733b42e 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1057,6 +1057,15 @@ static const struct attribute_group lm90_group = {
 	.attrs = lm90_attributes,
 };
 
+static struct attribute *lm90_temp2_offset_attributes[] = {
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm90_temp2_offset_group = {
+	.attrs = lm90_temp2_offset_attributes,
+};
+
 /*
  * Additional attributes for devices with emergency sensors
  */
@@ -1404,7 +1413,7 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 	if (data->flags & LM90_HAVE_EMERGENCY)
 		sysfs_remove_group(&dev->kobj, &lm90_emergency_group);
 	if (data->flags & LM90_HAVE_OFFSET)
-		device_remove_file(dev, &sensor_dev_attr_temp2_offset.dev_attr);
+		sysfs_remove_group(&dev->kobj, &lm90_temp2_offset_group);
 	device_remove_file(dev, &dev_attr_pec);
 	sysfs_remove_group(&dev->kobj, &lm90_group);
 }
@@ -1574,8 +1583,7 @@ static int lm90_probe(struct i2c_client *client,
 			goto exit_remove_files;
 	}
 	if (data->flags & LM90_HAVE_OFFSET) {
-		err = device_create_file(dev,
-					&sensor_dev_attr_temp2_offset.dev_attr);
+		err = sysfs_create_group(&dev->kobj, &lm90_temp2_offset_group);
 		if (err)
 			goto exit_remove_files;
 	}
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
