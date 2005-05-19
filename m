From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid, take 3
Message-Id: <vs85815vqsd8o40h9atobv7sosidrdrtol@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Jean,

This small patch changes two drivers, adm1025 and adm1026, to 
report vid as cpu0_vid sysfs name as used by the other drivers.

Added duplicated names and six month warning for old names to 
be removed as requested.  Compile tested.

Rediff'd to 2.6.12-rc4 as requested, take 2 completely bogus, sorry.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 Documentation/feature-removal-schedule.txt |   10 ++++++++++
 drivers/i2c/chips/adm1025.c                |    4 ++++
 drivers/i2c/chips/adm1026.c                |    5 ++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff -X dontdiff -Nru linux-2.6.12-rc4/Documentation/feature-removal-schedule.txt linux-2.6.12-rc4a/Documentation/feature-removal-schedule.txt
--- linux-2.6.12-rc4/Documentation/feature-removal-schedule.txt	2005-05-12 09:47:29.000000000 +1000
+++ linux-2.6.12-rc4a/Documentation/feature-removal-schedule.txt	2005-05-12 10:26:23.000000000 +1000
@@ -63,3 +63,13 @@
 	people, who might be using implementations that I am not aware
 	of, to adjust to this upcoming change.
 Who:	Paul E. McKenney <paulmck@us.ibm.com>
+
+---------------------------
+
+What:	i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
+When:	November 2005
+Files:	drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
+Why:	Match the other drivers' name for the same function, duplicate names
+	will be available until removal of old names.
+Who:	Grant Coady <gcoady@gmail.com>
+
diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/adm1025.c linux-2.6.12-rc4a/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc4/drivers/i2c/chips/adm1025.c	2005-05-12 09:47:33.000000000 +1000
+++ linux-2.6.12-rc4a/drivers/i2c/chips/adm1025.c	2005-05-12 10:23:49.000000000 +1000
@@ -287,7 +287,9 @@
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
+/* in1_ref is deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, char *buf)
 {
@@ -437,7 +439,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	/* in1_ref is deprecated, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_in1_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/adm1026.c linux-2.6.12-rc4a/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc4/drivers/i2c/chips/adm1026.c	2005-05-12 09:47:33.000000000 +1000
+++ linux-2.6.12-rc4a/drivers/i2c/chips/adm1026.c	2005-05-12 10:23:49.000000000 +1000
@@ -1267,8 +1267,9 @@
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
-
+/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -1708,7 +1709,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
+	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
