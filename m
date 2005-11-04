From: gcoady@gmail.com (Grant Coady)
Date: Fri, 04 Nov 2005 00:31:51 +0000
Subject: [lm-sensors] Re: your scheduled removals for this month
Message-Id: <436A9DC0.4000909@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Adrian Bunk wrote:
> Hi Grant,
> 
> Documentation/feature-removal-schedule.txt lists that you want to remove 
> the following from the 2.6 kernel this month:
> 
> What:   i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
> 
> If you send a patch now it could be included in kernel 2.6.15.

Thank you Adrian, the patch was sent the other day to lm-sensors list,
no response yet.  Was planning to resend in few more days.

Here 'tis again:

From: Grant Coady <gcoady@gmail.com>

drivers, hwmon, adm1025 and adm1026: remove deprecated sysfs names.

these names have been listed for removal for six months, time for them to go

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 Documentation/feature-removal-schedule.txt |    9 ---------
 drivers/hwmon/adm1025.c                    |    4 ----
 drivers/hwmon/adm1026.c                    |    4 ----
 3 files changed, 17 deletions(-)

diff -X dontdiff -Naur linux-2.6.14a/Documentation/feature-removal-schedule.txt linux-2.6.14b/Documentation/feature-removal-schedule.txt
--- linux-2.6.14a/Documentation/feature-removal-schedule.txt	2005-10-29 07:38:25.000000000 +1000
+++ linux-2.6.14b/Documentation/feature-removal-schedule.txt	2005-11-02 08:50:59.000000000 +1100
@@ -60,15 +60,6 @@

 ---------------------------

-What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
-When:	November 2005
-Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
-Why:	Match the other drivers' name for the same function, duplicate names
-	will be available until removal of old names.
-Who:	Grant Coady <gcoady@gmail.com>
-
----------------------------
-
 What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
 When:	November 2005
 Files:	drivers/pcmcia/: pcmcia_ioctl.c
diff -X dontdiff -Naur linux-2.6.14a/drivers/hwmon/adm1025.c linux-2.6.14b/drivers/hwmon/adm1025.c
--- linux-2.6.14a/drivers/hwmon/adm1025.c	2005-10-29 07:38:28.000000000 +1000
+++ linux-2.6.14b/drivers/hwmon/adm1025.c	2005-11-02 08:59:44.000000000 +1100
@@ -287,8 +287,6 @@
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-/* in1_ref is deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);

 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -445,8 +443,6 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	/* in1_ref is deprecated, remove after 2005-11-11 */
-	device_create_file(&new_client->dev, &dev_attr_in1_ref);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);

diff -X dontdiff -Naur linux-2.6.14a/drivers/hwmon/adm1026.c linux-2.6.14b/drivers/hwmon/adm1026.c
--- linux-2.6.14a/drivers/hwmon/adm1026.c	2005-10-29 07:38:28.000000000 +1000
+++ linux-2.6.14b/drivers/hwmon/adm1026.c	2005-11-02 09:00:06.000000000 +1100
@@ -1227,8 +1227,6 @@
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
-/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);

 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1675,8 +1673,6 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
-	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
-	device_create_file(&new_client->dev, &dev_attr_vid);
 	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);


Cheers,
Grant.
