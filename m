From: Laszlo Papp <lpapp@kde.org>
Date: Tue, 11 Feb 2014 10:24:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6650) Dissociate the i2c device name from the hwmon device name
Message-Id: <1392114247-23921-1-git-send-email-lpapp@kde.org>
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
 drivers/hwmon/max6650.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 0cafc39..d4b1450 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -518,6 +518,7 @@ static struct attribute *max6650_attrs[] = {
 	&sensor_dev_attr_gpio2_alarm.dev_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(max6650);
 
 static struct attribute_group max6650_attr_grp = {
 	.attrs = max6650_attrs,
@@ -543,6 +544,7 @@ static int max6650_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct max6650_data *data;
+	struct device *hwmon_dev;
 	int err;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct max6650_data),
@@ -574,8 +576,12 @@ static int max6650_probe(struct i2c_client *client,
 	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
+	if (!IS_ERR(data->hwmon_dev)) {
+		hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							client->name, data,
+							max6650_groups);
+		return PTR_ERR_OR_ZERO(hwmon_dev);
+	}
 
 	err = PTR_ERR(data->hwmon_dev);
 	dev_err(&client->dev, "error registering hwmon device.\n");
-- 
1.8.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
