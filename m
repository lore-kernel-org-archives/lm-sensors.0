From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This small patch changes two drivers, adm1025 and adm1026, to 
report vid as cpu0_vid sysfs name as used by the other drivers.

--Grant


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1025.c |    4 ++--
 adm1026.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -X dontdiff -Nru linux-2.6.12-rc3-mm3/drivers/i2c/chips/adm1025.c linux-2.6.12-rc3-mm3b/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc3-mm3/drivers/i2c/chips/adm1025.c	2005-05-06 04:43:26.000000000 +1000
+++ linux-2.6.12-rc3-mm3b/drivers/i2c/chips/adm1025.c	2005-05-07 02:26:15.000000000 +1000
@@ -286,7 +286,7 @@
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, char *buf)
 {
@@ -436,7 +436,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_in1_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
diff -X dontdiff -Nru linux-2.6.12-rc3-mm3/drivers/i2c/chips/adm1026.c linux-2.6.12-rc3-mm3b/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc3-mm3/drivers/i2c/chips/adm1026.c	2005-05-06 04:43:26.000000000 +1000
+++ linux-2.6.12-rc3-mm3b/drivers/i2c/chips/adm1026.c	2005-05-07 02:27:51.000000000 +1000
@@ -1267,7 +1267,7 @@
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
 
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -1707,7 +1707,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
-	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
