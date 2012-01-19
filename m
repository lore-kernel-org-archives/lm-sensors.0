From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:27 +0000
Subject: [lm-sensors] [PATCH 33/82] hwmon: (lm73) Fix multi-line comments
Message-Id: <1327017376-20466-34-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Guillaume Ligneul <guillaume.ligneul@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm73.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 9c8093c..343740f 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -66,8 +66,10 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
-	/* use integer division instead of equivalent right shift to
-	   guarantee arithmetic shift and preserve the sign */
+	/*
+	 * use integer division instead of equivalent right shift to
+	 * guarantee arithmetic shift and preserve the sign
+	 */
 	int temp = ((s16) (i2c_smbus_read_word_swapped(client,
 		    attr->index))*250) / 32;
 	return sprintf(buf, "%d\n", temp);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
