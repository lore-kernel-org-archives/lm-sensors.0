From: Asaf Vertz <asaf.vertz@tandemg.com>
Date: Wed, 21 Jan 2015 08:03:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: abx500: fix format string warnings
Message-Id: <20150121080322.GA26811@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de
Cc: linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Fixed the following warnings (reported by cppcheck):
[drivers/hwmon/abx500.c:224]: (warning) %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
[drivers/hwmon/abx500.c:233]: (warning) %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.
[drivers/hwmon/abx500.c:242]: (warning) %ld in format string (no. 1)
requires 'long' but the argument type is 'unsigned long'.

Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>
---
 drivers/hwmon/abx500.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
index 1387596..6cb89c0 100644
--- a/drivers/hwmon/abx500.c
+++ b/drivers/hwmon/abx500.c
@@ -221,7 +221,7 @@ static ssize_t show_min(struct device *dev,
 	struct abx500_temp *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%ld\n", data->min[attr->index]);
+	return sprintf(buf, "%lu\n", data->min[attr->index]);
 }
 
 static ssize_t show_max(struct device *dev,
@@ -230,7 +230,7 @@ static ssize_t show_max(struct device *dev,
 	struct abx500_temp *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%ld\n", data->max[attr->index]);
+	return sprintf(buf, "%lu\n", data->max[attr->index]);
 }
 
 static ssize_t show_max_hyst(struct device *dev,
@@ -239,7 +239,7 @@ static ssize_t show_max_hyst(struct device *dev,
 	struct abx500_temp *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%ld\n", data->max_hyst[attr->index]);
+	return sprintf(buf, "%lu\n", data->max_hyst[attr->index]);
 }
 
 static ssize_t show_min_alarm(struct device *dev,
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
