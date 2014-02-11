From: Laszlo Papp <lpapp@kde.org>
Date: Tue, 11 Feb 2014 10:28:49 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (max6650) Dissociate the i2c device name from the hwmon device name
Message-Id: <1392114529-30672-1-git-send-email-lpapp@kde.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de
Cc: linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Laszlo Papp <lpapp@kde.org>

This is a necessary step to revamp the existing design of the driver for the
overall functionality the chip can provide. This will create a clean name-space
for each function.

Signed-off-by: Laszlo Papp <lpapp@kde.org>
---
 drivers/hwmon/max6650.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 0cafc39..1e7a131 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -518,6 +518,7 @@ static struct attribute *max6650_attrs[] = {
 	&sensor_dev_attr_gpio2_alarm.dev_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(max6650);
 
 static struct attribute_group max6650_attr_grp = {
 	.attrs = max6650_attrs,
@@ -573,8 +574,10 @@ static int max6650_probe(struct i2c_client *client,
 			goto err_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							client->name, data,
+							max6650_groups);
+	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
 		return 0;
 
 	err = PTR_ERR(data->hwmon_dev);
-- 
1.8.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
