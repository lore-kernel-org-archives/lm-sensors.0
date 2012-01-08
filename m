From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 17:53:29 +0000
Subject: [lm-sensors] [PATCH 17/17 v2] drivers/hwmon/i5k_amb.c: fix
Message-Id: <1326045209-19160-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index d22f241..c516bdc 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -159,7 +159,11 @@ static ssize_t store_amb_min(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i5k_amb_data *data = dev_get_drvdata(dev);
-	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
+	unsigned long temp;
+	int ret = kstrtoul(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
 
+	temp = temp / 500;
 	if (temp > 255)
 		temp = 255;
@@ -175,7 +178,11 @@ static ssize_t store_amb_mid(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i5k_amb_data *data = dev_get_drvdata(dev);
-	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
+	unsigned long temp;
+	int ret = kstrtoul(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
 
+	temp = temp / 500;
 	if (temp > 255)
 		temp = 255;
@@ -191,7 +197,11 @@ static ssize_t store_amb_max(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i5k_amb_data *data = dev_get_drvdata(dev);
-	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
+	unsigned long temp;
+	int ret = kstrtoul(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
 
+	temp = temp / 500;
 	if (temp > 255)
 		temp = 255;
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
