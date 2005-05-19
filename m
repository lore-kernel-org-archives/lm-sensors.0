From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [patch] sensors/w83781d.c creates useless sysfs entries
Message-Id: <20031014202415.GA17026@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 14, 2003 at 05:27:45PM +0200, Kronos wrote:
> Il Mon, Oct 13, 2003 at 12:31:14PM -0700, Greg KH ha scritto: 
> > On Sat, Oct 11, 2003 at 06:32:44PM +0200, Kronos wrote:
> > > Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> > > > Hello,
> > > > 
> > > > here is a trivial fix for Winbond sensor driver, which currently creates 
> > > > useless entries in sys/bus/i2c due to missing braces after if statements 
> > > > - author probably forgot about the macro expansion.
> > > 
> > > IMHO it's better to fix the macro:
> > 
> > Thanks, I've applied this version.
> 
> I've reviewed the patch, there was a trailing ";" that wasn't supposed
> to be there:

Good catch.  Actually there were some other issues with those macros.
I've applied the patch below to the tree.

thanks,

greg k-h


# I2C: fix more define problems in w83781d driver

diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Tue Oct 14 13:22:22 2003
+++ b/drivers/i2c/chips/w83781d.c	Tue Oct 14 13:22:22 2003
@@ -426,7 +426,7 @@
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
 device_create_file(&client->dev, &dev_attr_in_max##offset); \
-} while (0);
+} while (0)
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -484,8 +484,10 @@
 sysfs_fan_min_offset(3);
 
 #define device_create_file_fan(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_fan_input##offset); \
 device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+} while (0)
 
 #define show_temp_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
@@ -568,9 +570,11 @@
 sysfs_temp_offsets(3);
 
 #define device_create_file_temp(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_temp_input##offset); \
 device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_min##offset);
+device_create_file(&client->dev, &dev_attr_temp_min##offset); \
+} while (0)
 
 static ssize_t
 show_vid_reg(struct device *dev, char *buf)
@@ -693,8 +697,10 @@
 sysfs_beep(MASK, mask);
 
 #define device_create_file_beep(client) \
+do { \
 device_create_file(&client->dev, &dev_attr_beep_enable); \
-device_create_file(&client->dev, &dev_attr_beep_mask);
+device_create_file(&client->dev, &dev_attr_beep_mask); \
+} while (0)
 
 /* w83697hf only has two fans */
 static ssize_t
@@ -771,7 +777,9 @@
 sysfs_fan_div(3);
 
 #define device_create_file_fan_div(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+} while (0)
 
 /* w83697hf only has two fans */
 static ssize_t
@@ -883,10 +891,14 @@
 sysfs_pwm(4);
 
 #define device_create_file_pwm(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_pwm##offset); \
+} while (0)
 
 #define device_create_file_pwmenable(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_pwm_enable##offset); \
+} while (0)
 
 static ssize_t
 show_sensor_reg(struct device *dev, char *buf, int nr)
@@ -959,7 +971,9 @@
 sysfs_sensor(3);
 
 #define device_create_file_sensor(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_sensor##offset); \
+} while (0)
 
 #ifdef W83781D_RT
 static ssize_t
@@ -1018,7 +1032,9 @@
 sysfs_rt(3);
 
 #define device_create_file_rt(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_rt##offset); \
+} while (0)
 
 #endif				/* ifdef W83781D_RT */
 
