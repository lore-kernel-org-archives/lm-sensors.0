From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: PATCH 2.6 Trivial: change adm1026 sysfs name vid to cpu0_vid
Message-Id: <p3u651tb512lniikr67g0ad98rao1k2f4n@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

This trivial patch changes adm1026 sysfs name "vid" to "cpu0_vid" to 
match nine other drivers.  Compile tested.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc2-mm1/drivers/i2c/chips/adm1026.c	2005-04-05 10:13:02.000000000 +1000
+++ linux-2.6.12-rc2-mm1b/drivers/i2c/chips/adm1026.c	2005-04-06 16:06:15.000000000 +1000
@@ -1268,7 +1268,7 @@ static ssize_t show_vid_reg(struct devic
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
 
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -1708,7 +1708,7 @@ int adm1026_detect(struct i2c_adapter *a
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
-	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
