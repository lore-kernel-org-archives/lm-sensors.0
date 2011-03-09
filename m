From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:11 +0000
Subject: [lm-sensors] [PATCH 05/10] hwmon/f71882fg: Make number of temps
Message-Id: <1299700636-9699-6-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the temp sysattr array for the standard models a 2d array, which allows
to use it for models with less temperatures too. This is a preparation
patch for adding support for more different models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 17c752c..a1ca0cf 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -324,7 +324,7 @@ static struct sensor_device_attribute_2 f71858fg_temp_attr[] = {
 };
 
 /* Temp attr for the standard models */
-static struct sensor_device_attribute_2 fxxxx_temp_attr[] = {
+static struct sensor_device_attribute_2 fxxxx_temp_attr[3][11] = { {
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 1),
@@ -345,6 +345,7 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[] = {
 		store_temp_beep, 0, 5),
 	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 1),
 	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
+}, {
 	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 2),
@@ -363,6 +364,7 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[] = {
 		store_temp_beep, 0, 6),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 2),
 	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 2),
+}, {
 	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
 		store_temp_max, 0, 3),
@@ -381,7 +383,7 @@ static struct sensor_device_attribute_2 fxxxx_temp_attr[] = {
 		store_temp_beep, 0, 7),
 	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 3),
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
-};
+} };
 
 /* Temp attr for the f8000
    Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
@@ -1917,6 +1919,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
 	int err, i, nr_fans = (sio_data->type = f71882fg) ? 4 : 3;
+	int nr_temps = 3;
 	u8 start_reg, reg;
 
 	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
@@ -1970,8 +1973,8 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			break;
 		default:
 			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_temp_attr,
-					ARRAY_SIZE(fxxxx_temp_attr));
+				&fxxxx_temp_attr[0][0],
+				ARRAY_SIZE(fxxxx_temp_attr[0]) * nr_temps);
 		}
 		if (err)
 			goto exit_unregister_sysfs;
@@ -2114,6 +2117,7 @@ static int f71882fg_remove(struct platform_device *pdev)
 {
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 	int i, nr_fans = (data->type = f71882fg) ? 4 : 3;
+	int nr_temps = 3;
 	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
 
 	platform_set_drvdata(pdev, NULL);
@@ -2141,8 +2145,8 @@ static int f71882fg_remove(struct platform_device *pdev)
 			break;
 		default:
 			f71882fg_remove_sysfs_files(pdev,
-					fxxxx_temp_attr,
-					ARRAY_SIZE(fxxxx_temp_attr));
+				&fxxxx_temp_attr[0][0],
+				ARRAY_SIZE(fxxxx_temp_attr[0]) * nr_temps);
 		}
 		for (i = 0; i < F71882FG_MAX_INS; i++) {
 			if (f71882fg_has_in[data->type][i]) {
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
