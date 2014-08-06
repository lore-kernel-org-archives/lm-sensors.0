From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 06 Aug 2014 00:06:50 +0000
Subject: [lm-sensors] [PATCH] hwmon: (hih6130) Fix missing hih6130->write_length setting
Message-Id: <1407283610.4924.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hih6130->write_length setting was accidently removed by commit
ebc6b9383f3e "hwmon: (hih6130) Convert to devm_hwmon_device_register_with_groups",
fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/hih6130.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
index 0e01c4e..7b73d20 100644
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -238,6 +238,9 @@ static int hih6130_probe(struct i2c_client *client,
 	hih6130->client = client;
 	mutex_init(&hih6130->lock);
 
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_QUICK))
+		hih6130->write_length = 1;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   hih6130,
 							   hih6130_groups);
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
