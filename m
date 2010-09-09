From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Sep 2010 13:25:45 +0000
Subject: [lm-sensors] [PATCH v2 2/7] hwmon: (lm90) Introduce device feature
Message-Id: <1284038750-8833-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm90.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index aafed28..a81a053 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -142,7 +142,11 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, adt7461, max6680, max6646,
 /*
  * Device flags
  */
-#define LM90_FLAG_ADT7461_EXT		0x01	/* ADT7461 extended mode */
+#define LM90_FLAG_ADT7461_EXT	0x01	/* ADT7461 extended mode	*/
+/* Device features */
+#define	LM90_HAVE_OFFSET	0x02	/* temperature offset register	*/
+#define	LM90_HAVE_LOCAL_EXT	0x04	/* extended local temperature	*/
+#define	LM90_HAVE_REM_LIMIT_EXT	0x08	/* extended remote limit	*/
 
 /*
  * Functions declaration
@@ -462,17 +466,16 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	mutex_lock(&data->update_lock);
 	if (data->kind = adt7461)
 		data->temp11[nr] = temp_to_u16_adt7461(data, val);
-	else if (data->kind = max6657 || data->kind = max6680)
-		data->temp11[nr] = temp_to_s8(val) << 8;
 	else if (data->kind = max6646)
 		data->temp11[nr] = temp_to_u8(val) << 8;
+	else if (!(data->flags & LM90_HAVE_REM_LIMIT_EXT))
+		data->temp11[nr] = temp_to_s8(val) << 8;
 	else
 		data->temp11[nr] = temp_to_s16(val);
 
 	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
 				  data->temp11[nr] >> 8);
-	if (data->kind != max6657 && data->kind != max6680
-	    && data->kind != max6646)
+	if (data->flags & LM90_HAVE_REM_LIMIT_EXT)
 		i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2 + 1],
 					  data->temp11[nr] & 0xff);
 	mutex_unlock(&data->update_lock);
@@ -847,6 +850,17 @@ static int lm90_probe(struct i2c_client *new_client,
 		break;
 	}
 
+	/* Set chip capabilities */
+	if (data->kind != max6657 && data->kind != max6646)
+		data->flags |= LM90_HAVE_OFFSET;
+
+	if (data->kind = max6657 || data->kind = max6646)
+		data->flags |= LM90_HAVE_LOCAL_EXT;
+
+	if (data->kind != max6657 && data->kind != max6646
+	    && data->kind != max6680)
+		data->flags |= LM90_HAVE_REM_LIMIT_EXT;
+
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 
@@ -859,7 +873,7 @@ static int lm90_probe(struct i2c_client *new_client,
 		if (err)
 			goto exit_remove_files;
 	}
-	if (data->kind != max6657 && data->kind != max6646) {
+	if (data->flags & LM90_HAVE_OFFSET) {
 		err = device_create_file(&new_client->dev,
 					&sensor_dev_attr_temp2_offset.dev_attr);
 		if (err)
@@ -925,7 +939,7 @@ static int lm90_remove(struct i2c_client *client)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &lm90_group);
 	device_remove_file(&client->dev, &dev_attr_pec);
-	if (data->kind != max6657 && data->kind != max6646)
+	if (data->flags & LM90_HAVE_OFFSET)
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
 
@@ -1019,7 +1033,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
 		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
 
-		if (data->kind = max6657 || data->kind = max6646) {
+		if (data->flags & LM90_HAVE_LOCAL_EXT) {
 			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
 				    MAX6657_REG_R_LOCAL_TEMPL,
 				    &data->temp11[4]);
@@ -1033,22 +1047,20 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 
 		if (lm90_read_reg(client, LM90_REG_R_REMOTE_LOWH, &h) = 0) {
 			data->temp11[1] = h << 8;
-			if (data->kind != max6657 && data->kind != max6680
-			 && data->kind != max6646
+			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_LOWL,
 					  &l) = 0)
 				data->temp11[1] |= l;
 		}
 		if (lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHH, &h) = 0) {
 			data->temp11[2] = h << 8;
-			if (data->kind != max6657 && data->kind != max6680
-			 && data->kind != max6646
+			if ((data->flags & LM90_HAVE_REM_LIMIT_EXT)
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_HIGHL,
 					  &l) = 0)
 				data->temp11[2] |= l;
 		}
 
-		if (data->kind != max6657 && data->kind != max6646) {
+		if (data->flags & LM90_HAVE_OFFSET) {
 			if (lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSH,
 					  &h) = 0
 			 && lm90_read_reg(client, LM90_REG_R_REMOTE_OFFSL,
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
