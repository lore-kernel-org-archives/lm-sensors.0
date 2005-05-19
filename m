From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid, take 2
Message-Id: <d115815c9ub26dphr852u7k4j54sp5a146@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2005 19:54:29 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>> This small patch changes two drivers, adm1025 and adm1026, to 
>> report vid as cpu0_vid sysfs name as used by the other drivers.
>> 
>> Added duplicated names and six month warning for old names to 
>> be removed as requested.  Compile tested.
>
>The patch is fine but doesn't apply to my tree. Could you possibly
>regenerate it against 2.6.12-rc4?

Yes, but no point including Documentation/feature-removal-schedule.txt 
patch as that file way behind in 2.6.12-rc4 compared to rc3-mm3

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1025.c |    4 ++++
 adm1026.c |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/adm1025.c linux-2.6.12-rc4a/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc4/drivers/i2c/chips/adm1025.c	2004-12-25 08:33:47.000000000 +1100
+++ linux-2.6.12-rc4a/drivers/i2c/chips/adm1025.c	2005-05-12 07:28:17.000000000 +1000
@@ -280,7 +280,9 @@
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
+/* in1_ref is deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 static ssize_t show_vrm(struct device *dev, char *buf)
 {
@@ -431,7 +433,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_max);
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
+	/* in1_ref is deprecated, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_in1_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 
 	/* Pin 11 is either in4 (+12V) or VID4 */
diff -X dontdiff -Nru linux-2.6.12-rc4/drivers/i2c/chips/adm1026.c linux-2.6.12-rc4a/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc4/drivers/i2c/chips/adm1026.c	2005-03-30 08:33:41.000000000 +1000
+++ linux-2.6.12-rc4a/drivers/i2c/chips/adm1026.c	2005-05-12 07:28:17.000000000 +1000
@@ -1288,8 +1288,9 @@
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", vid_from_reg(data->vid & 0x3f, data->vrm));
 }
-
+/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -1740,7 +1741,9 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp2_crit_enable);
 	device_create_file(&new_client->dev, &dev_attr_temp3_crit_enable);
+	/* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */
 	device_create_file(&new_client->dev, &dev_attr_vid);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	device_create_file(&new_client->dev, &dev_attr_alarm_mask);
