From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Aug 2008 10:11:22 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (adm1026) Prevent log spamming
Message-Id: <20080814121122.0c52ab09@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When debugging is enabled, the adm1026 driver currently logs the
message "Setting VID from GPIO11-15" 108 times each time you run
"sensors". Once should be enough.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Philip Pokorny <ppokorny@penguincomputing.com>
---
 drivers/hwmon/adm1026.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adm1026.c	2008-07-08 14:48:51.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adm1026.c	2008-07-08 15:05:07.000000000 +0200
@@ -279,7 +279,6 @@ struct adm1026_data {
 	u8 fan_min[8];		/* Register value */
 	u8 fan_div[8];		/* Decoded value */
 	struct pwm_data pwm1;	/* Pwm control values */
-	int vid;		/* Decoded value */
 	u8 vrm;			/* VRM version */
 	u8 analog_out;		/* Register value (DAC) */
 	long alarms;		/* Register encoding, combined */
@@ -697,8 +696,6 @@ static struct adm1026_data *adm1026_upda
 		data->last_config = jiffies;
 	}; /* last_config */
 
-	dev_dbg(&client->dev, "Setting VID from GPIO11-15.\n");
-	data->vid = (data->gpio >> 11) & 0x1f;
 	data->valid = 1;
 	mutex_unlock(&data->update_lock);
 	return data;
@@ -1215,7 +1212,10 @@ static DEVICE_ATTR(analog_out, S_IRUGO |
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
+	int vid = (data->gpio >> 11) & 0x1f;
+
+	dev_dbg(dev, "Setting VID from GPIO11-15.\n");
+	return sprintf(buf, "%d\n", vid_from_reg(vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
