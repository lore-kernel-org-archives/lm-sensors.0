From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 01:26:33 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (lm90) Create optional attributes with sysfs_create_group
Message-Id: <1392513995-30712-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392513973-25148-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392513973-25148-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With the new hwmon API, all attributes have to be created as groups.
Use sysfs_create_group and sysfs_remove_group instead of device_create_file
and device_remove_file to prepare for the new API.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 701e952..c3bb771 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1057,6 +1057,15 @@ static const struct attribute_group lm90_group = {
 	.attrs = lm90_attributes,
 };
 
+static struct attribute *lm90_temp2_offset_attrs[] = {
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm90_temp2_offset_group = {
+	.attrs = lm90_temp2_offset_attrs,
+};
+
 /*
  * Additional attributes for devices with emergency sensors
  */
@@ -1174,6 +1183,15 @@ static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
 
 static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
 
+static struct attribute *lm90_pec_attrs[] = {
+	&dev_attr_pec.attr,
+	NULL
+};
+
+static const struct attribute_group lm90_pec_group = {
+	.attrs = lm90_pec_attrs,
+};
+
 /*
  * Real code
  */
@@ -1404,8 +1422,8 @@ static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 	if (data->flags & LM90_HAVE_EMERGENCY)
 		sysfs_remove_group(&dev->kobj, &lm90_emergency_group);
 	if (data->flags & LM90_HAVE_OFFSET)
-		device_remove_file(dev, &sensor_dev_attr_temp2_offset.dev_attr);
-	device_remove_file(dev, &dev_attr_pec);
+		sysfs_remove_group(&dev->kobj, &lm90_temp2_offset_group);
+	sysfs_remove_group(&dev->kobj, &lm90_pec_group);
 	sysfs_remove_group(&dev->kobj, &lm90_group);
 }
 
@@ -1569,13 +1587,12 @@ static int lm90_probe(struct i2c_client *client,
 	if (err)
 		goto exit_restore;
 	if (client->flags & I2C_CLIENT_PEC) {
-		err = device_create_file(dev, &dev_attr_pec);
+		err = sysfs_create_group(&dev->kobj, &lm90_pec_group);
 		if (err)
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
