From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Sep 2012 20:15:49 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (w83791d) Drop unnecessary compare statements
Message-Id: <1348085749-1498-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following build warnings are seen with -Wextra.

w83791d.c: In function store_temp_target:
w83791d.c:858:2: warning: comparison of unsigned expression < 0 is always false
w83791d.c: In function store_temp_tolerance:
w83791d.c:920:2: warning: comparison of unsigned expression < 0 is always false

For store_temp_target, accept negative numbers and clamp to >= 0.
For store_temp_tolerance, drop the unnecessary comparison.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Accept negative values in store_temp_target and clamp to >= 0.

 drivers/hwmon/w83791d.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 9ade4d4..93ea81a 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -259,8 +259,7 @@ static u8 fan_to_reg(long rpm, int div)
 					((val) + 500) / 1000)
 
 /* for thermal cruise temp tolerance, 4-bits, LSB = 1 degree Celsius */
-#define TOL_TEMP_TO_REG(val)		((val) < 0 ? 0 : \
-					(val) >= 15000 ? 15 : \
+#define TOL_TEMP_TO_REG(val)		((val) >= 15000 ? 15 : \
 					((val) + 500) / 1000)
 
 #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
@@ -848,10 +847,10 @@ static ssize_t store_temp_target(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83791d_data *data = i2c_get_clientdata(client);
 	int nr = sensor_attr->index;
-	unsigned long val;
+	long val;
 	u8 target_mask;
 
-	if (kstrtoul(buf, 10, &val))
+	if (kstrtol(buf, 10, &val))
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
