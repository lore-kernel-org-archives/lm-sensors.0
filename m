From: Peter Hung <hpeter@gmail.com>
Date: Thu, 25 Jun 2015 07:30:17 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon:f71882fg fix f81866a temp/beep setting
Message-Id: <1435217418-26249-3-git-send-email-hpeter+linux_kernel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

The temperature value of Fintek F81866 is the same with
f71882fg. It located with 0x6c + 2*(nr), others located
with 0x6c + 2*(nr+1). We change the rule in f71882fg_probe(),
If type = f71858fg/f8000/f81866a. the temp_start will set to 0,
others are 1.

The F81866 over-temperature beep setting is not the same with
f71882fg too. They are using the same address 63H, but F81866 is
using bit 0/1/2 & 4/5/6, others are using bit 1/2/3 & 5/6/7,
So we copy from fxxxx_temp_beep_attr[] to f81866_temp_beep_attr
and change bit setting.

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/hwmon/f71882fg.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 10bc8b3..e1ba586 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -506,6 +506,23 @@ static struct sensor_device_attribute_2 fxxxx_temp_beep_attr[3][2] = { {
 		store_temp_beep, 0, 7),
 } };
 
+static struct sensor_device_attribute_2 f81866_temp_beep_attr[3][2] = { {
+	SENSOR_ATTR_2(temp1_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 0),
+	SENSOR_ATTR_2(temp1_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 4),
+}, {
+	SENSOR_ATTR_2(temp2_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 1),
+	SENSOR_ATTR_2(temp2_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 5),
+}, {
+	SENSOR_ATTR_2(temp3_max_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 2),
+	SENSOR_ATTR_2(temp3_crit_beep, S_IRUGO|S_IWUSR, show_temp_beep,
+		store_temp_beep, 0, 6),
+} };
+
 /*
  * Temp attr for the f8000
  * Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
@@ -2286,6 +2303,7 @@ static int f71882fg_probe(struct platform_device *pdev)
 	int nr_fans = f71882fg_nr_fans[sio_data->type];
 	int nr_temps = f71882fg_nr_temps[sio_data->type];
 	int err, i;
+	int size;
 	u8 start_reg, reg;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct f71882fg_data),
@@ -2296,7 +2314,8 @@ static int f71882fg_probe(struct platform_device *pdev)
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
 	data->type = sio_data->type;
 	data->temp_start -	    (data->type = f71858fg || data->type = f8000) ? 0 : 1;
+	    (data->type = f71858fg || data->type = f8000 ||
+		data->type = f81866a) ? 0 : 1;
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
@@ -2338,6 +2357,11 @@ static int f71882fg_probe(struct platform_device *pdev)
 					f8000_temp_attr,
 					ARRAY_SIZE(f8000_temp_attr));
 			break;
+		case f81866a:
+			err = f71882fg_create_sysfs_files(pdev,
+					f71858fg_temp_attr,
+					ARRAY_SIZE(f71858fg_temp_attr));
+			break;
 		default:
 			err = f71882fg_create_sysfs_files(pdev,
 				&fxxxx_temp_attr[0][0],
@@ -2347,10 +2371,18 @@ static int f71882fg_probe(struct platform_device *pdev)
 			goto exit_unregister_sysfs;
 
 		if (f71882fg_temp_has_beep[data->type]) {
-			err = f71882fg_create_sysfs_files(pdev,
-					&fxxxx_temp_beep_attr[0][0],
-					ARRAY_SIZE(fxxxx_temp_beep_attr[0])
-						* nr_temps);
+			if (data->type = f81866a) {
+				size = ARRAY_SIZE(f81866_temp_beep_attr[0]);
+				err = f71882fg_create_sysfs_files(pdev,
+						&f81866_temp_beep_attr[0][0],
+						size * nr_temps);
+
+			} else {
+				size = ARRAY_SIZE(fxxxx_temp_beep_attr[0];
+				err = f71882fg_create_sysfs_files(pdev,
+						&fxxxx_temp_beep_attr[0][0],
+						size * nr_temps);
+			}
 			if (err)
 				goto exit_unregister_sysfs;
 		}
@@ -2467,15 +2499,27 @@ static int f71882fg_remove(struct platform_device *pdev)
 					f8000_temp_attr,
 					ARRAY_SIZE(f8000_temp_attr));
 			break;
+		case f81866a:
+			f71882fg_remove_sysfs_files(pdev,
+					f71858fg_temp_attr,
+					ARRAY_SIZE(f71858fg_temp_attr));
+			break;
 		default:
 			f71882fg_remove_sysfs_files(pdev,
 				&fxxxx_temp_attr[0][0],
 				ARRAY_SIZE(fxxxx_temp_attr[0]) * nr_temps);
 		}
 		if (f71882fg_temp_has_beep[data->type]) {
-			f71882fg_remove_sysfs_files(pdev,
-			       &fxxxx_temp_beep_attr[0][0],
-			       ARRAY_SIZE(fxxxx_temp_beep_attr[0]) * nr_temps);
+			if (data->type = f81866a)
+				f71882fg_remove_sysfs_files(pdev,
+					&f81866_temp_beep_attr[0][0],
+					ARRAY_SIZE(f81866_temp_beep_attr[0])
+						* nr_temps);
+			else
+				f71882fg_remove_sysfs_files(pdev,
+					&fxxxx_temp_beep_attr[0][0],
+					ARRAY_SIZE(fxxxx_temp_beep_attr[0])
+						* nr_temps);
 		}
 
 		for (i = 0; i < F71882FG_MAX_INS; i++) {
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
