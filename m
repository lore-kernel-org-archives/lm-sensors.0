From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:00 +0000
Subject: [lm-sensors] [PATCH 12/24] hwmon: (lm87) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-13-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm87.c |   29 ++++-------------------------
 1 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 314d147..c20c984 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -180,7 +180,6 @@ struct lm87_data {
 
 	u16 alarms;		/* register values, combined */
 	u8 vid;			/* register values, combined */
-	u8 vrm;
 };
 
 static inline int lm87_read_value(struct i2c_client *client, u8 reg)
@@ -597,31 +596,10 @@ static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-			char *buf)
-{
-	struct lm87_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
-{
-	struct lm87_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	data->vrm = val;
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
 static ssize_t show_aout(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -795,7 +773,6 @@ static const struct attribute_group lm87_group_in0_5 = {
 
 static struct attribute *lm87_attributes_vid[] = {
 	&dev_attr_cpu0_vid.attr,
-	&dev_attr_vrm.attr,
 	NULL
 };
 
@@ -955,8 +932,10 @@ static int lm87_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			goto exit_remove;
 	}
 
+	if (!(data->channel & CHAN_NO_VID) && vid_which_vrm() = 0)
+		data->channel |= CHAN_NO_VID;
+
 	if (!(data->channel & CHAN_NO_VID)) {
-		data->vrm = vid_which_vrm();
 		err = sysfs_create_group(&client->dev.kobj, &lm87_group_vid);
 		if (err)
 			goto exit_remove;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
