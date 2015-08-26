From: Il Han <corone.il.han@gmail.com>
Date: Wed, 26 Aug 2015 05:41:59 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: The Code Crashes
Message-Id: <1440567719-27643-2-git-send-email-corone.il.han@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The code crashes, since dev is not an i2c client device.

Signed-off-by: Il Han <corone.il.han@gmail.com>
---
 drivers/hwmon/max31790.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index d9b0003..f129668 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -206,8 +206,8 @@ static ssize_t set_fan_target(struct device *dev,
 			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max31790_data *data = i2c_get_clientdata(client);
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 bits;
 	int sr;
 	int target_count;
@@ -273,8 +273,8 @@ static ssize_t set_pwm(struct device *dev,
 		       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max31790_data *data = i2c_get_clientdata(client);
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long pwm;
 	int err;
 
@@ -325,8 +325,8 @@ static ssize_t set_pwm_enable(struct device *dev,
 			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max31790_data *data = i2c_get_clientdata(client);
+	struct max31790_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long mode;
 	int err;
 
-- 
2.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
