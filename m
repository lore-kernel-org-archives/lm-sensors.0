From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:28 +0000
Subject: [lm-sensors] [PATCH 34/82] hwmon: (lm75) Fix multi-line comments
Message-Id: <1327017376-20466-35-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm75.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index b3311b1..8510e0c 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -73,10 +73,12 @@ struct lm75_data {
 	u8			orig_conf;
 	char			valid;		/* !=0 if registers are valid */
 	unsigned long		last_updated;	/* In jiffies */
-	u16			temp[3];	/* Register values,
-						   0 = input
-						   1 = max
-						   2 = hyst */
+	u16			temp[3];	/*
+						 * Register values,
+						 * 0 = input
+						 * 1 = max
+						 * 2 = hyst
+						 */
 };
 
 static int lm75_read_value(struct i2c_client *client, u8 reg);
@@ -163,7 +165,8 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
+	/*
+	 * Set to LM75 resolution (9 bits, 1/2 degree C) and range.
 	 * Then tweak to be more precise when appropriate.
 	 */
 	set_mask = 0;
@@ -285,8 +288,10 @@ static int lm75_detect(struct i2c_client *new_client,
 
 	/* First check for LM75A */
 	if (i2c_smbus_read_byte_data(new_client, 7) = LM75A_ID) {
-		/* LM75A returns 0xff on unused registers so
-		   just to be sure we check for that too. */
+		/*
+		 * LM75A returns 0xff on unused registers so
+		 * just to be sure we check for that too.
+		 */
 		if (i2c_smbus_read_byte_data(new_client, 4) != 0xff
 		 || i2c_smbus_read_byte_data(new_client, 5) != 0xff
 		 || i2c_smbus_read_byte_data(new_client, 6) != 0xff)
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
