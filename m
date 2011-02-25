From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 17:21:24 +0000
Subject: [lm-sensors] [PATCH v3 1/4] hwmon: (lm85) Use macro to determine if
Message-Id: <1298654487-30232-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ADT7463 and ADT7468 optionally support VID5 instead of the standard +12V
measurement input. Use a macro to detect configuration instead of hardcoding it
several times.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index d2cc286..12edd5f 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -124,6 +124,9 @@ enum chips {
 #define	EMC6D102_REG_EXTEND_ADC3	0x87
 #define	EMC6D102_REG_EXTEND_ADC4	0x88
 
+#define	vid5_configured(data)		(((data)->type = adt7463 || \
+					  (data)->type = adt7468) && \
+					  ((data)->vid & 0x80))
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. Note that you should be a bit careful with which arguments
@@ -420,8 +423,7 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 	struct lm85_data *data = lm85_update_device(dev);
 	int vid;
 
-	if ((data->type = adt7463 || data->type = adt7468) &&
-	    (data->vid & 0x80)) {
+	if (vid5_configured(data)) {
 		/* 6-pin VID (VRM 10) */
 		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
 	} else {
@@ -1322,8 +1324,7 @@ static int lm85_probe(struct i2c_client *client,
 	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
 	   as a sixth digital VID input rather than an analog input. */
 	data->vid = lm85_read_value(client, LM85_REG_VID);
-	if (!((data->type = adt7463 || data->type = adt7468) &&
-	    (data->vid & 0x80)))
+	if (!vid5_configured(data))
 		if ((err = sysfs_create_group(&client->dev.kobj,
 					&lm85_group_in4)))
 			goto err_remove_files;
@@ -1457,11 +1458,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			    lm85_read_value(client, LM85_REG_FAN(i));
 		}
 
-		if (!((data->type = adt7463 || data->type = adt7468) &&
-		    (data->vid & 0x80))) {
-			data->in[4] = lm85_read_value(client,
-				      LM85_REG_IN(4));
-		}
+		if (!vid5_configured(data))
+			data->in[4] = lm85_read_value(client, LM85_REG_IN(4));
 
 		if (data->type = adt7468)
 			data->cfg5 = lm85_read_value(client, ADT7468_REG_CFG5);
@@ -1528,8 +1526,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			    lm85_read_value(client, LM85_REG_FAN_MIN(i));
 		}
 
-		if (!((data->type = adt7463 || data->type = adt7468) &&
-		    (data->vid & 0x80))) {
+		if (!vid5_configured(data))  {
 			data->in_min[4] = lm85_read_value(client,
 					  LM85_REG_IN_MIN(4));
 			data->in_max[4] = lm85_read_value(client,
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
