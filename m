From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 11 Jul 2006 18:57:23 +0000
Subject: [lm-sensors] [ patch 18-rc1-mm1 01/01 ] hwmon/pc87360: check
Message-Id: <44B3F493.9080405@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


patch corrects the unchecked-return-code warnings issued when
compiling pc87360.c in 18-rc1-mm1.  It just counts the errors,
warns how many occurred, and continues merrily (as before).

Signed-off-by   Jim Cromie  <jim.cromie at gmail.com>

$ diffstat hwmon-stuff/diff.sys-ret-not-void-1
 pc87360.c |   62 +++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 25 deletions(-)

---

diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc1-mm1-sk/drivers/hwmon/pc87360.c sys-ret-not-void/drivers/hwmon/pc87360.c
--- ../linux-2.6.18-rc1-mm1-sk/drivers/hwmon/pc87360.c	2006-06-17 19:49:35.000000000 -0600
+++ sys-ret-not-void/drivers/hwmon/pc87360.c	2006-07-11 11:51:30.000000000 -0600
@@ -829,6 +829,15 @@ static int __init pc87360_find(int sioad
 	return 0;
 }
 
+static int devattr_file_create_errs;
+static void create_devattr_file(struct device *dev,
+				struct device_attribute *attr)
+{
+	int rc = device_create_file(dev, attr);
+	if (rc)
+		devattr_file_create_errs++;
+}
+
 static int pc87360_detect(struct i2c_adapter *adapter)
 {
 	int i;
@@ -944,48 +953,51 @@ static int pc87360_detect(struct i2c_ada
 
 	if (data->innr) {
 		for (i = 0; i < 11; i++) {
-			device_create_file(dev, &in_input[i].dev_attr);
-			device_create_file(dev, &in_min[i].dev_attr);
-			device_create_file(dev, &in_max[i].dev_attr);
-			device_create_file(dev, &in_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_cpu0_vid);
-		device_create_file(dev, &dev_attr_vrm);
-		device_create_file(dev, &dev_attr_alarms_in);
+			create_devattr_file(dev, &in_input[i].dev_attr);
+			create_devattr_file(dev, &in_min[i].dev_attr);
+			create_devattr_file(dev, &in_max[i].dev_attr);
+			create_devattr_file(dev, &in_status[i].dev_attr);
+		}
+		create_devattr_file(dev, &dev_attr_cpu0_vid);
+		create_devattr_file(dev, &dev_attr_vrm);
+		create_devattr_file(dev, &dev_attr_alarms_in);
 	}
 
 	if (data->tempnr) {
 		for (i = 0; i < data->tempnr; i++) {
-			device_create_file(dev, &temp_input[i].dev_attr);
-			device_create_file(dev, &temp_min[i].dev_attr);
-			device_create_file(dev, &temp_max[i].dev_attr);
-			device_create_file(dev, &temp_crit[i].dev_attr);
-			device_create_file(dev, &temp_status[i].dev_attr);
+			create_devattr_file(dev, &temp_input[i].dev_attr);
+			create_devattr_file(dev, &temp_min[i].dev_attr);
+			create_devattr_file(dev, &temp_max[i].dev_attr);
+			create_devattr_file(dev, &temp_crit[i].dev_attr);
+			create_devattr_file(dev, &temp_status[i].dev_attr);
 		}
-		device_create_file(dev, &dev_attr_alarms_temp);
+		create_devattr_file(dev, &dev_attr_alarms_temp);
 	}
 
 	if (data->innr = 14) {
 		for (i = 0; i < 3; i++) {
-			device_create_file(dev, &therm_input[i].dev_attr);
-			device_create_file(dev, &therm_min[i].dev_attr);
-			device_create_file(dev, &therm_max[i].dev_attr);
-			device_create_file(dev, &therm_crit[i].dev_attr);
-			device_create_file(dev, &therm_status[i].dev_attr);
+			create_devattr_file(dev, &therm_input[i].dev_attr);
+			create_devattr_file(dev, &therm_min[i].dev_attr);
+			create_devattr_file(dev, &therm_max[i].dev_attr);
+			create_devattr_file(dev, &therm_crit[i].dev_attr);
+			create_devattr_file(dev, &therm_status[i].dev_attr);
 		}
 	}
 
 	for (i = 0; i < data->fannr; i++) {
 		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
-			device_create_file(dev, &fan_input[i].dev_attr);
-			device_create_file(dev, &fan_min[i].dev_attr);
-			device_create_file(dev, &fan_div[i].dev_attr);
-			device_create_file(dev, &fan_status[i].dev_attr);
+			create_devattr_file(dev, &fan_input[i].dev_attr);
+			create_devattr_file(dev, &fan_min[i].dev_attr);
+			create_devattr_file(dev, &fan_div[i].dev_attr);
+			create_devattr_file(dev, &fan_status[i].dev_attr);
 		}
 		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
-			device_create_file(dev, &pwm[i].dev_attr);
+			create_devattr_file(dev, &pwm[i].dev_attr);
 	}
-
+	if (devattr_file_create_errs)
+		dev_warn(&client->dev, "got %d device_create_file errs\n",
+			 devattr_file_create_errs);
+		
 	return 0;
 
 ERROR3:



