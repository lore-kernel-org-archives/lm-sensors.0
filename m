From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Thu, 09 Sep 2010 13:20:14 +0000
Subject: [lm-sensors] [RFC PATCH] lm75: some optimisations
Message-Id: <1284037694-16806-1-git-send-email-shubhrajyoti@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Functions that used only at probe may be optimised.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/hwmon/lm75.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ab5b87a..7857b94 100644
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
 
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
