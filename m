From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 23:59:33 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (coretemp) Use sysfs_create_group to create sysfs attributes
Message-Id: <1392595175-7589-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Instead of creating each attribute individually, use sysfs_create_group
to create all attributes for one core with a single call.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index bbb0b0d..3f87db2 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -94,6 +94,8 @@ struct temp_data {
 	bool valid;
 	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
 	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
+	struct attribute *attrs[TOTAL_ATTRS + 1];
+	struct attribute_group attr_group;
 	struct mutex update_lock;
 };
 
@@ -406,7 +408,7 @@ static int create_name_attr(struct platform_data *pdata,
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 			     int attr_no)
 {
-	int err, i;
+	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
 			struct device_attribute *devattr, char *buf) = {
 			show_label, show_crit_alarm, show_temp, show_tjmax,
@@ -424,16 +426,10 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
 		tdata->sd_attrs[i].index = attr_no;
-		err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
-		if (err)
-			goto exit_free;
+		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
-	return 0;
-
-exit_free:
-	while (--i >= 0)
-		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
-	return err;
+	tdata->attr_group.attrs = tdata->attrs;
+	return sysfs_create_group(&dev->kobj, &tdata->attr_group);
 }
 
 
@@ -575,12 +571,10 @@ static void coretemp_add_core(unsigned int cpu, int pkg_flag)
 static void coretemp_remove_core(struct platform_data *pdata,
 				struct device *dev, int indx)
 {
-	int i;
 	struct temp_data *tdata = pdata->core_data[indx];
 
 	/* Remove the sysfs attributes */
-	for (i = 0; i < tdata->attr_size; i++)
-		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
+	sysfs_remove_group(&dev->kobj, &tdata->attr_group);
 
 	kfree(pdata->core_data[indx]);
 	pdata->core_data[indx] = NULL;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
