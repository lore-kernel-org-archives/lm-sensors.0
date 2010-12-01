From: Gabriele Gorla <gorlik@penguintown.net>
Date: Wed, 01 Dec 2010 00:57:17 +0000
Subject: [lm-sensors] [PATCH] adm1026: fix setting fan_div (2nd try)
Message-Id: <20101201005717.GE30973@penguintown.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Prevent setting fan_div from stomping on other fans that share the same i2c register.

Signed-off-by: Gabriele Gorla <gorlik at penguintown.net>
---

diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-2.6.26/drivers/hwmon/adm1026.c
--- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c	2008-07-13 14:51:29.000000000 -0700
+++ linux-source-2.6.26/drivers/hwmon/adm1026.c	2010-11-30 16:35:27.000000000 -0800
@@ -918,34 +918,36 @@
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val, orig_div, new_div, shift;
+	int val, orig_div, new_div;
 
 	val = simple_strtol(buf, NULL, 10);
 	new_div = DIV_TO_REG(val);
 	if (new_div = 0) {
 		return -EINVAL;
 	}
 	mutex_lock(&data->update_lock);
 	orig_div = data->fan_div[nr];
-	data->fan_div[nr] = DIV_FROM_REG(new_div);
+	if (orig_div != DIV_FROM_REG(new_div)) {
+		data->fan_div[nr] = DIV_FROM_REG(new_div);
 
-	if (nr < 4) { /* 0 <= nr < 4 */
-		shift = 2 * nr;
-		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
-			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
-			(new_div << shift)));
-	} else { /* 3 < nr < 8 */
-		shift = 2 * (nr - 4);
-		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
-			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
-			(new_div << shift)));
-	}
+		if (nr < 4) { /* 0 <= nr < 4 */
+			adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
+				    (DIV_TO_REG(data->fan_div[0]) << 0) |
+				    (DIV_TO_REG(data->fan_div[1]) << 2) |
+				    (DIV_TO_REG(data->fan_div[2]) << 4) |
+				    (DIV_TO_REG(data->fan_div[3]) << 6));
+		} else { /* 3 < nr < 8 */
+			adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
+				    (DIV_TO_REG(data->fan_div[4]) << 0) |
+				    (DIV_TO_REG(data->fan_div[5]) << 2) |
+				    (DIV_TO_REG(data->fan_div[6]) << 4) |
+				    (DIV_TO_REG(data->fan_div[7]) << 6));
+		}
 
-	if (data->fan_div[nr] != orig_div) {
 		fixup_fan_min(dev, nr, orig_div);
 	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
