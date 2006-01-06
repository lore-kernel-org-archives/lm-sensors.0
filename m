From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: remove deprecated sysfs names of
Message-Id: <11365852523278@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: remove deprecated sysfs names of adm1025 and adm1026

drivers, hwmon, adm1025 and adm1026: remove deprecated sysfs names.

these names have been listed for removal for six months, time for them to go

Signed-off-by: Grant Coady <gcoady at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 07421cabdc62519d0f747149b7c9b425b4d746cd
tree a72c4afdff890c7b61176591f155d18e4080c365
parent f9e8957937ebf60d22732a5ca9130f48a7603f60
author Grant Coady <gcoady at gmail.com> Sun, 06 Nov 2005 23:13:06 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 Documentation/feature-removal-schedule.txt |    9 ---------
 drivers/hwmon/adm1025.c                    |    4 ----
 drivers/hwmon/adm1026.c                    |    4 ----
 3 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 9b74319..cb13b96 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -82,15 +82,6 @@ Who:	Mauro Carvalho Chehab <mchehab at brtu
 
 ---------------------------
 
-What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
-When:	November 2005
-Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
-Why:	Match the other drivers' name for the same function, duplicate names
-	will be available until removal of old names.
-Who:	Grant Coady <gcoady at gmail.com>
-
----------------------------
-
 What:	remove EXPORT_SYMBOL(panic_timeout)
 When:	April 2006
 Files:	kernel/panic.c
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 3ec1242..bf67860 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -287,8 +287,6 @@ static ssize_t show_vid(struct device *d
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-/* in1_ref is deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -444,8 +442,6 @@ static int adm1025_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	/* in1_ref is deprecated, remove after 2005-11-11 */
-	device_create_file(&new_client->dev, &dev_attr_in1_ref);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index e0f5654..5036b17 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1227,8 +1227,6 @@ static ssize_t show_vid_reg(struct devic
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
-/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1673,8 +1671,6 @@ static int adm1026_detect(struct i2c_ada
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
-	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-	device_create_file(&new_client->dev, &dev_attr_vid);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);


