From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 22:36:17 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (asus_atk0110) Consolidate sysfs
Message-Id: <1306276577-6854-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Call sysfs_attr_init() from atk_init_attribute() to handle sysfs attribute
initialization in a single function.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/hwmon/asus_atk0110.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index b5e8920..dcb78a7 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -268,6 +268,7 @@ static struct device_attribute atk_name_attr  static void atk_init_attribute(struct device_attribute *attr, char *name,
 		sysfs_show_func show)
 {
+	sysfs_attr_init(&attr->attr);
 	attr->attr.name = name;
 	attr->attr.mode = 0444;
 	attr->show = show;
@@ -1188,19 +1189,15 @@ static int atk_create_files(struct atk_data *data)
 	int err;
 
 	list_for_each_entry(s, &data->sensor_list, list) {
-		sysfs_attr_init(&s->input_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->input_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->label_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->label_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->limit1_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->limit1_attr);
 		if (err)
 			return err;
-		sysfs_attr_init(&s->limit2_attr.attr);
 		err = device_create_file(data->hwmon_dev, &s->limit2_attr);
 		if (err)
 			return err;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
