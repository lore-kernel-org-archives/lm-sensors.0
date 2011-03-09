From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:13 +0000
Subject: [lm-sensors] [PATCH 07/10] hwmon/f71882fg: Break out test for auto
Message-Id: <1299700636-9699-8-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Putting this check in its own switch case rather then in the switch case
for adding pwm auto point sysfs attr is cleaner. This is a preparation patch
for adding support for more different models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 7f71a5a..6d88aeb 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2075,6 +2075,27 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		}
 
 		switch (data->type) {
+		case f71889fg:
+			for (i = 0; i < nr_fans; i++) {
+				data->pwm_auto_point_mapping[i] +					f71882fg_read8(data,
+						F71882FG_REG_POINT_MAPPING(i));
+				if (data->pwm_auto_point_mapping[i] & 0x80)
+					break;
+			}
+			if (i != nr_fans) {
+				dev_warn(&pdev->dev,
+					 "Auto pwm controlled by raw digital "
+					 "data, disabling pwm auto_point "
+					 "sysfs attributes\n");
+				goto no_pwm_auto_point;
+			}
+			break;
+		default:
+			break;
+		}
+
+		switch (data->type) {
 		case f71862fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71862fg_auto_pwm_attr,
@@ -2090,23 +2111,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 					f8000_auto_pwm_attr,
 					ARRAY_SIZE(f8000_auto_pwm_attr));
 			break;
-		case f71889fg:
-			for (i = 0; i < nr_fans; i++) {
-				data->pwm_auto_point_mapping[i] -					f71882fg_read8(data,
-						F71882FG_REG_POINT_MAPPING(i));
-				if (data->pwm_auto_point_mapping[i] & 0x80)
-					break;
-			}
-			if (i != nr_fans) {
-				dev_warn(&pdev->dev,
-					 "Auto pwm controlled by raw digital "
-					 "data, disabling pwm auto_point "
-					 "sysfs attributes\n");
-				break;
-			}
-			/* fall through */
-		default: /* f71858fg / f71882fg */
+		default:
 			err = f71882fg_create_sysfs_files(pdev,
 				&fxxxx_auto_pwm_attr[0][0],
 				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
@@ -2114,6 +2119,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		if (err)
 			goto exit_unregister_sysfs;
 
+no_pwm_auto_point:
 		for (i = 0; i < nr_fans; i++)
 			dev_info(&pdev->dev, "Fan: %d is in %s mode\n", i + 1,
 				 (data->pwm_enable & (1 << 2 * i)) ?
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
