From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Thu, 09 Sep 2010 17:24:16 +0000
Subject: [lm-sensors] [PATCH] lm75: some optimisations
Message-Id: <1284052336-25864-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- updating with Guenter's comments

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ab5b87a..028f961 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -134,7 +134,7 @@ static const struct attribute_group lm75_group = {
 
 /* device probe and removal */
 
-static int
+static int __devinit
 lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct lm75_data *data;
@@ -196,7 +196,7 @@ exit_free:
 	return status;
 }
 
-static int lm75_remove(struct i2c_client *client)
+static int __devexit lm75_remove(struct i2c_client *client)
 {
 	struct lm75_data *data = i2c_get_clientdata(client);
 
@@ -325,7 +325,7 @@ static struct i2c_driver lm75_driver = {
 		.pm	= LM75_DEV_PM_OPS,
 	},
 	.probe		= lm75_probe,
-	.remove		= lm75_remove,
+	.remove		=  __devexit_p(lm75_remove),
 	.id_table	= lm75_ids,
 	.detect		= lm75_detect,
 	.address_list	= normal_i2c,
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
