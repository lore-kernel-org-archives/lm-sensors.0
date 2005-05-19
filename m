From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH Trivial: change adm1026 vid to cpu0_vid
Message-Id: <0i9571l0k0rok5n2f489na1pomoatvf5hi@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7d8571pd95d46i4jphs7cqp9hjmbechp8a@4ax.com>
In-Reply-To: <7d8571pd95d46i4jphs7cqp9hjmbechp8a@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 30 Apr 2005 07:10:45 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>Greetings,
>
>This trivial patch changes adm1026 sysfs name "vid" to "cpu0_vid" to 
>match the other drivers.  Compile tested.

Part of sysfs naming cleanup and documentation project.

Oops, scrub that, need to change analog_out to aout_output to match 
other drivers too.

While we're here, should 'vrm' accessor be removed as that value is 
obtained internally by driver?

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1026.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/adm1026.c	2005-04-30 06:45:30.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/adm1026.c	2005-04-30 07:22:59.000000000 +1000
@@ -1259,7 +1259,7 @@
 	return count;
 }
 
-static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg, 
+static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_analog_out_reg, 
 	set_analog_out_reg);
 
 static ssize_t show_vid_reg(struct device *dev, char *buf)
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
@@ -1726,7 +1726,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp1_auto_point2_pwm);
 	device_create_file(&new_client->dev, &dev_attr_temp2_auto_point2_pwm);
 	device_create_file(&new_client->dev, &dev_attr_temp3_auto_point2_pwm);
-	device_create_file(&new_client->dev, &dev_attr_analog_out);
+	device_create_file(&new_client->dev, &dev_attr_aout_output);
 	return 0;
 
 	/* Error out and cleanup code */
