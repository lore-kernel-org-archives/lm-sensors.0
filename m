From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:46 +0000
Subject: [lm-sensors] [PATCH 4/7] hwmon: (max16065) Convert to use devm_kzalloc
Message-Id: <1329929809-6085-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marginally less code and eliminate the possibility of memory leaks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max16065.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 51edae9..822261b 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -554,7 +554,7 @@ static int max16065_probe(struct i2c_client *client,
 				     | I2C_FUNC_SMBUS_READ_WORD_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (unlikely(!data))
 		return -ENOMEM;
 
@@ -567,20 +567,16 @@ static int max16065_probe(struct i2c_client *client,
 
 	if (have_secondary) {
 		val = i2c_smbus_read_byte_data(client, MAX16065_SW_ENABLE);
-		if (unlikely(val < 0)) {
-			ret = val;
-			goto out_free;
-		}
+		if (unlikely(val < 0))
+			return val;
 		secondary_is_max = val & MAX16065_WARNING_OV;
 	}
 
 	/* Read scale registers, convert to range */
 	for (i = 0; i < DIV_ROUND_UP(data->num_adc, 4); i++) {
 		val = i2c_smbus_read_byte_data(client, MAX16065_SCALE(i));
-		if (unlikely(val < 0)) {
-			ret = val;
-			goto out_free;
-		}
+		if (unlikely(val < 0))
+			return val;
 		for (j = 0; j < 4 && i * 4 + j < data->num_adc; j++) {
 			data->range[i * 4 + j]  			  max16065_adc_range[(val >> (j * 2)) & 0x3];
@@ -595,10 +591,8 @@ static int max16065_probe(struct i2c_client *client,
 		for (j = 0; j < data->num_adc; j++) {
 			val = i2c_smbus_read_byte_data(client,
 						       MAX16065_LIMIT(i, j));
-			if (unlikely(val < 0)) {
-				ret = val;
-				goto out_free;
-			}
+			if (unlikely(val < 0))
+				return val;
 			data->limit[i][j] = LIMIT_TO_MV(val, data->range[j]);
 		}
 	}
@@ -661,8 +655,6 @@ static int max16065_probe(struct i2c_client *client,
 
 out:
 	max16065_cleanup(client);
-out_free:
-	kfree(data);
 	return ret;
 }
 
@@ -672,7 +664,6 @@ static int max16065_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	max16065_cleanup(client);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
