From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 04 Sep 2005 11:27:22 +0000
Subject: [lm-sensors] Re: RFC PATCH patch-13-mm1-hwmon-adm9240-whitespace-1
Message-Id: <7ldlh15m431toing3d8vju26alq517a5gp@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
In-Reply-To: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 4 Sep 2005 09:55:26 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> Patches are planned to make chassis_clear write data >> <dont_care>,
>
>With what benefit?
linux-kernel will be one source line smaller :-p  Not sure, don't have 
to do that.  The recent sysfs breakage made me wonder if we should use 
the write to chassis_clear, ignoring the data.
>
>> and rework sysfs interface to reduce driver size.
>
>Are you referring to Yani Ioannou's dynamic sysfs callbacks? That would
>be very welcome, thanks for looking into that.

Yes, it finally seems to have settled some?
>
>> This patch removes mixed tab/space indenting,
>
>There is nothing wrong with mixed tab/space indenting. Additionally,
>this part of the code will be completely modified again if you convert
>the driver to use dynamic callbacks. So I would like you not to include
>these changes in this cleanup patch.
Okay, here's take two.

---
This patch breaks long lines, removed a trailing space and is code 
neutral.  Further patches are planned which will apply after this 
cleanup.  Run tested.

Thanks,
Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

--- linux-2.6.13-mm1/drivers/hwmon/adm9240.c	2005-09-02 07:50:33.000000000 +1000
+++ linux-2.6.13-mm1b/drivers/hwmon/adm9240.c	2005-09-04 19:15:44.000000000 +1000
@@ -350,7 +350,7 @@ static void adm9240_write_fan_div(struct
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* 
+/*
  * set fan speed low limit:
  *
  * - value is zero: disable fan speed low limit alarm
@@ -449,7 +449,8 @@ show_fan_offset(1);
 show_fan_offset(2);
 
 /* alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -457,7 +458,8 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /* vid */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -465,13 +467,15 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* analog output */
-static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_aout(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
 
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm9240_data *data = i2c_get_clientdata(client);
@@ -486,7 +490,8 @@ static ssize_t set_aout(struct device *d
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
 
 /* chassis_clear */
-static ssize_t chassis_clear(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t chassis_clear(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned long val = simple_strtol(buf, NULL, 10);
