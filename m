From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 Oct 2009 15:14:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: (dme1737) No vid attributes for SCH311x
Message-Id: <20091019171446.62669593@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The SCH311x chips do not have VID inputs, so the cpu0_vid and vrm
attributes shouldn't be created for them.

This fixes lm-sensors ticket #2353:
http://www.lm-sensors.org/ticket/2353

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Udo van den Heuvel <udovdh@xs4all.n>
Cc: Juerg Haefliger <juergh@gmail.com>
---
 drivers/hwmon/dme1737.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- linux-2.6.30.orig/drivers/hwmon/dme1737.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.30/drivers/hwmon/dme1737.c	2009-10-19 16:25:06.000000000 +0200
@@ -572,7 +572,7 @@ static struct dme1737_data *dme1737_upda
 
 	/* Sample register contents every 1 sec */
 	if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
-		if (data->type != sch5027) {
+		if (data->type = dme1737) {
 			data->vid = dme1737_read(data, DME1737_REG_VID) &
 				0x3f;
 		}
@@ -1621,9 +1621,6 @@ static struct attribute *dme1737_misc_at
 	&sensor_dev_attr_zone1_auto_point1_temp_hyst.dev_attr.attr,
 	&sensor_dev_attr_zone2_auto_point1_temp_hyst.dev_attr.attr,
 	&sensor_dev_attr_zone3_auto_point1_temp_hyst.dev_attr.attr,
-	/* Misc */
-	&dev_attr_vrm.attr,
-	&dev_attr_cpu0_vid.attr,
 	NULL
 };
 
@@ -1631,6 +1628,18 @@ static const struct attribute_group dme1
 	.attrs = dme1737_misc_attr,
 };
 
+/* The following struct holds VID-related attributes. Their creation
+   depends on the chip type which is determined during module load. */
+static struct attribute *dme1737_vid_attr[] = {
+	&dev_attr_vrm.attr,
+	&dev_attr_cpu0_vid.attr,
+	NULL
+};
+
+static const struct attribute_group dme1737_vid_group = {
+	.attrs = dme1737_vid_attr,
+};
+
 /* The following structs hold the PWM attributes, some of which are optional.
  * Their creation depends on the chip configuration which is determined during
  * module load. */
@@ -1902,6 +1911,9 @@ static void dme1737_remove_files(struct
 	if (data->type != sch5027) {
 		sysfs_remove_group(&dev->kobj, &dme1737_misc_group);
 	}
+	if (data->type = dme1737) {
+		sysfs_remove_group(&dev->kobj, &dme1737_vid_group);
+	}
 
 	sysfs_remove_group(&dev->kobj, &dme1737_group);
 
@@ -1933,6 +1945,13 @@ static int dme1737_create_files(struct d
 		goto exit_remove;
 	}
 
+	/* Create VID-related sysfs attributes */
+	if ((data->type = dme1737) &&
+	    (err = sysfs_create_group(&dev->kobj,
+				      &dme1737_vid_group))) {
+		goto exit_remove;
+	}
+
 	/* Create fan sysfs attributes */
 	for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
 		if (data->has_fan & (1 << ix)) {
@@ -2127,7 +2146,7 @@ static int dme1737_init_device(struct de
 	data->pwm_acz[2] = 4;	/* pwm3 -> zone3 */
 
 	/* Set VRM */
-	if (data->type != sch5027) {
+	if (data->type = dme1737) {
 		data->vrm = vid_which_vrm();
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
