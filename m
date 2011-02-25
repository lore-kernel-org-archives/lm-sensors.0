From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 18:57:23 +0000
Subject: [lm-sensors] [PATCH v4 1/4] hwmon: (lm85) Use boolean to determine
Message-Id: <1298660246-6484-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ADT7463 and ADT7468 optionally support VID5 instead of the standard +12V
measurement input. Use a boolean to identify the chip configuration instead of
hardcoding it several times.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index d2cc286..2253676 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -306,6 +306,8 @@ struct lm85_data {
 	const int *freq_map;
 	enum chips type;
 
+	bool has_vid5;	/* true if VID5 is configured for ADT7463 or ADT7468 */
+
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
 	unsigned long last_reading;	/* In jiffies */
@@ -420,8 +422,7 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 	struct lm85_data *data = lm85_update_device(dev);
 	int vid;
 
-	if ((data->type = adt7463 || data->type = adt7468) &&
-	    (data->vid & 0x80)) {
+	if (data->has_vid5) {
 		/* 6-pin VID (VRM 10) */
 		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
 	} else {
@@ -1321,9 +1322,13 @@ static int lm85_probe(struct i2c_client *client,
 
 	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
 	   as a sixth digital VID input rather than an analog input. */
-	data->vid = lm85_read_value(client, LM85_REG_VID);
-	if (!((data->type = adt7463 || data->type = adt7468) &&
-	    (data->vid & 0x80)))
+	if (data->type = adt7463 || data->type = adt7468) {
+		u8 vid = lm85_read_value(client, LM85_REG_VID);
+		if (vid & 0x80)
+			data->has_vid5 = true;
+	}
+
+	if (!data->has_vid5)
 		if ((err = sysfs_create_group(&client->dev.kobj,
 					&lm85_group_in4)))
 			goto err_remove_files;
@@ -1457,11 +1462,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			    lm85_read_value(client, LM85_REG_FAN(i));
 		}
 
-		if (!((data->type = adt7463 || data->type = adt7468) &&
-		    (data->vid & 0x80))) {
-			data->in[4] = lm85_read_value(client,
-				      LM85_REG_IN(4));
-		}
+		if (!data->has_vid5)
+			data->in[4] = lm85_read_value(client, LM85_REG_IN(4));
 
 		if (data->type = adt7468)
 			data->cfg5 = lm85_read_value(client, ADT7468_REG_CFG5);
@@ -1528,8 +1530,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
 		}
 
-		if (!((data->type = adt7463 || data->type = adt7468) &&
-		    (data->vid & 0x80))) {
+		if (!data->has_vid5)  {
 			data->in_min[4] = lm85_read_value(client,
 					  LM85_REG_IN_MIN(4));
 			data->in_max[4] = lm85_read_value(client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
