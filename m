From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: Support the VRM 10 mode of the ADT7463
Message-Id: <113658525373@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Support the VRM 10 mode of the ADT7463

Support the VRM 10 mode of the ADT7463.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 9c516ef496c857aa4b1b41dc313010f11d39c496
tree 94fd2cc493def4ec290705b4d943335558eb304e
parent 07421cabdc62519d0f747149b7c9b425b4d746cd
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 20:07:54 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 drivers/hwmon/lm85.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index d1070ed..3f5544a 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -443,7 +443,17 @@ show_fan_offset(4);
 static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	int vid;
+
+	if (data->type = adt7463 && (data->vid & 0x80)) {
+		/* 6-pin VID (VRM 10) */
+		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
+	} else {
+		/* 5-pin VID (VRM 9) */
+		vid = vid_from_reg(data->vid & 0x1f, data->vrm);
+	}
+
+	return sprintf(buf, "%d\n", vid);
 }
 
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
@@ -1176,17 +1186,14 @@ static int lm85_detect(struct i2c_adapte
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
 	device_create_file(&new_client->dev, &dev_attr_in2_input);
 	device_create_file(&new_client->dev, &dev_attr_in3_input);
-	device_create_file(&new_client->dev, &dev_attr_in4_input);
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
 	device_create_file(&new_client->dev, &dev_attr_in2_min);
 	device_create_file(&new_client->dev, &dev_attr_in3_min);
-	device_create_file(&new_client->dev, &dev_attr_in4_min);
 	device_create_file(&new_client->dev, &dev_attr_in0_max);
 	device_create_file(&new_client->dev, &dev_attr_in1_max);
 	device_create_file(&new_client->dev, &dev_attr_in2_max);
 	device_create_file(&new_client->dev, &dev_attr_in3_max);
-	device_create_file(&new_client->dev, &dev_attr_in4_max);
 	device_create_file(&new_client->dev, &dev_attr_temp1_input);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_temp3_input);
@@ -1224,6 +1231,15 @@ static int lm85_detect(struct i2c_adapte
 	device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_crit);
 	device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_crit);
 
+	/* The ADT7463 has an optional VRM 10 mode where pin 21 is used
+	   as a sixth digital VID input rather than an analog input. */
+	data->vid = lm85_read_value(new_client, LM85_REG_VID);
+	if (!(kind = adt7463 && (data->vid & 0x80))) {
+		device_create_file(&new_client->dev, &dev_attr_in4_input);
+		device_create_file(&new_client->dev, &dev_attr_in4_min);
+		device_create_file(&new_client->dev, &dev_attr_in4_max);
+	}
+
 	return 0;
 
 	/* Error out and cleanup code */
@@ -1382,11 +1398,18 @@ static struct lm85_data *lm85_update_dev
 		   irrelevant. So it is left in 4*/
 		data->adc_scale = (data->type = emc6d102 ) ? 16 : 4;
 
-		for (i = 0; i <= 4; ++i) {
+		data->vid = lm85_read_value(client, LM85_REG_VID);
+
+		for (i = 0; i <= 3; ++i) {
 			data->in[i]  			    lm85_read_value(client, LM85_REG_IN(i));
 		}
 
+		if (!(data->type = adt7463 && (data->vid & 0x80))) {
+			data->in[4] = lm85_read_value(client,
+				      LM85_REG_IN(4));
+		}
+
 		for (i = 0; i <= 3; ++i) {
 			data->fan[i]  			    lm85_read_value(client, LM85_REG_FAN(i));
@@ -1450,13 +1473,20 @@ static struct lm85_data *lm85_update_dev
 		/* Things that don't change often */
 		dev_dbg(&client->dev, "Reading config values\n");
 
-		for (i = 0; i <= 4; ++i) {
+		for (i = 0; i <= 3; ++i) {
 			data->in_min[i]  			    lm85_read_value(client, LM85_REG_IN_MIN(i));
 			data->in_max[i]  			    lm85_read_value(client, LM85_REG_IN_MAX(i));
 		}
 
+		if (!(data->type = adt7463 && (data->vid & 0x80))) {
+			data->in_min[4] = lm85_read_value(client,
+					  LM85_REG_IN_MIN(4));
+			data->in_max[4] = lm85_read_value(client,
+					  LM85_REG_IN_MAX(4));
+		}
+
 		if ( data->type = emc6d100 ) {
 			for (i = 5; i <= 7; ++i) {
 				data->in_min[i] @@ -1478,8 +1508,6 @@ static struct lm85_data *lm85_update_dev
 			    lm85_read_value(client, LM85_REG_TEMP_MAX(i));
 		}
 
-		data->vid = lm85_read_value(client, LM85_REG_VID);
-
 		for (i = 0; i <= 2; ++i) {
 			int val ;
 			data->autofan[i].config 

