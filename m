From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Thu, 26 Aug 2010 12:59:10 +0000
Subject: [lm-sensors] [RFC PATCH] Make the writing to sysfs more robust.
Message-Id: <1282827342-29579-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Currently we get the checkpatch warning
consider using strict_strtol in preference to simple_strtol
Also we should not allow any partially numeric values

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a86f2e0..9f23dfc 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -103,7 +103,11 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm75_data *data = i2c_get_clientdata(client);
 	int nr = attr->index;
-	long temp = simple_strtol(buf, NULL, 10);
+	long temp;
+	int error;
+	error = strict_strtol(buf, 10, &temp);
+	if (error)
+		return error;
 
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = LM75_TEMP_TO_REG(temp);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
