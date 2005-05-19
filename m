From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH Trivial: change adm1026 vid to cpu0_vid
Message-Id: <7d8571pd95d46i4jphs7cqp9hjmbechp8a@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This trivial patch changes adm1026 sysfs name "vid" to "cpu0_vid" to 
match the other drivers.  Compile tested.

--Grant.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1026.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/adm1026.c	2005-04-30 06:45:30.000000000 +1000
+++ linux-2.6.12-rc3a/drivers/i2c/chips/adm1026.c	2005-04-30 06:58:36.000000000 +1000
@@ -1268,7 +1268,7 @@
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
 
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -1708,7 +1708,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
-	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
