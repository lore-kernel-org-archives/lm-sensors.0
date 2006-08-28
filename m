From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 28 Aug 2006 02:07:24 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520608271907k7b388c1cqcd4fc4a8d915aa89@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> I see very little benefit if making two separate patches for error
> checking and grouping. Both will touch the very same code. Let's get it
> right at once.

Agreed.

> Also, when sending patches to the list, please set the attachement type
> to text/plain rather than application/octet-stream. It will make it way
> easier for people to read it.

I'm looking into it. One possibility is to change the extension of the
files (e.g. add ".txt" to every file) -- however, then anyone who
reads emails from me will think, "what is this guy doing adding .txt
to everything?" Gmail allows POP access, which I don't currently use,
and I'm looking for SMTP access--if that is possible, then I'll fix it
that way. I also considered sending a patch in the body of the
message, but gmail will wrap the text and break the patch. What I'm
doing for now is attaching it twice, first with .txt and then without.
It's just an extra 7k in the email.

> You can also simulate an error at the last file creation, to make sure
> the error path is tested at least once. I did that when updating
> i2c-core, i2c-dev and i2c-isa, and found a bug thanks to this. Ideally
> you should even test every possible error case, if you have more time.

Okay, tested the return paths. They are working on my machine.

> You don't actually need to get rid of these functions if you are happy
> with them.
>
> You can group the tests with || so you have a single "goto exit_remove"
> for the whole block

Yes. I'll do that.

> Your patch does remove the files if creation failed, however it fails
> to remove them if the device is removed later.

Updated patch follows.

As a side note, I implemented the sysfs_create_group() and
sysfs_remove_group() method. Here are a few comparisons:

Using device_create_file() / device_remove_file() in for loops:
-rw-r--r-- 1 root root  6227 Aug 27 20:01
w83627ehf_unchecked_device_create_file1.patch
-rw-r--r-- 1 root root 39125 Aug 27 20:02 module1.ko

Using sysfs_create_group() and sysfs_remove_group():
-rw-r--r-- 1 root root 13109 Aug 27 19:40
w83627ehf_unchecked_device_create_file2.patch
-rw-r--r-- 1 root root 40617 Aug 27 19:42 module2.ko

I can send the sysfs_create_group patch if anyone is interested. But
since the device_create_file() is a smaller patch, I'll stay with that
one.

Thanks for the input,
David
-------------- next part --------------
Fix: check return value from device_create_file()
Signed-off-by: David Hubbard <david.c.hubbard at gmail.com>

diff -ur linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c
--- linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-08-16 15:56:34.000000000 -0700
+++ linux-2.6.18-rc4/drivers/hwmon/w83627ehf1.c	2006-08-27 19:59:48.000000000 -0700
@@ -4,6 +4,7 @@
     Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
     Copyright (C) 2006  Yuan Mu <Ymu at Winbond.com.tw>,
                         Rudolf Marek <r.marek at sh.cvut.cz>
+                        David Hubbard <david.c.hubbard at gmail.com>
 
     Shamelessly ripped from the w83627hf driver
     Copyright (C) 2003  Mark Studebaker
@@ -621,14 +622,6 @@
        SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9),
 };
 
-static void device_create_file_in(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_in_input[i].dev_attr);
-	device_create_file(dev, &sda_in_alarm[i].dev_attr);
-	device_create_file(dev, &sda_in_min[i].dev_attr);
-	device_create_file(dev, &sda_in_max[i].dev_attr);
-}
-
 #define show_fan_reg(reg) \
 static ssize_t \
 show_##reg(struct device *dev, struct device_attribute *attr, \
@@ -756,14 +749,6 @@
 	SENSOR_ATTR(fan5_div, S_IRUGO, show_fan_div, NULL, 4),
 };
 
-static void device_create_file_fan(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_fan_input[i].dev_attr);
-	device_create_file(dev, &sda_fan_alarm[i].dev_attr);
-	device_create_file(dev, &sda_fan_div[i].dev_attr);
-	device_create_file(dev, &sda_fan_min[i].dev_attr);
-}
-
 #define show_temp1_reg(reg) \
 static ssize_t \
 show_##reg(struct device *dev, struct device_attribute *attr, \
@@ -1036,15 +1021,6 @@
 		    store_tolerance, 3),
 };
 
-static void device_create_file_pwm(struct device *dev, int i)
-{
-	device_create_file(dev, &sda_pwm[i].dev_attr);
-	device_create_file(dev, &sda_pwm_mode[i].dev_attr);
-	device_create_file(dev, &sda_pwm_enable[i].dev_attr);
-	device_create_file(dev, &sda_target_temp[i].dev_attr);
-	device_create_file(dev, &sda_tolerance[i].dev_attr);
-}
-
 /* Smart Fan registers */
 
 #define fan_functions(reg, REG) \
@@ -1131,6 +1107,39 @@
  * Driver and client management
  */
 
+static void remove_unregister(struct w83627ehf_data *data, struct device *dev)
+{
+	/* some entries in the following arrays may not have been used in
+	 * device_create_file(), but device_remove_file() will ignore them */
+	int i;
+	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
+		device_remove_file(dev, &sda_temp[i].dev_attr);
+	for (i = 0; i < 5; i++) {
+		if (i < 4) { /* w83627ehf only has 4 pwm */
+			device_remove_file(dev, &sda_tolerance[i].dev_attr);
+			device_remove_file(dev, &sda_target_temp[i].dev_attr);
+			device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
+			device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
+			device_remove_file(dev, &sda_pwm[i].dev_attr);
+		}
+		device_remove_file(dev, &sda_fan_min[i].dev_attr);
+		device_remove_file(dev, &sda_fan_div[i].dev_attr);
+		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_fan_input[i].dev_attr);
+	}
+	for (i = 0; i < 10; i++) {
+		device_remove_file(dev, &sda_in_max[i].dev_attr);
+		device_remove_file(dev, &sda_in_min[i].dev_attr);
+		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_in_input[i].dev_attr);
+	}
+	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
+		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
+	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
+		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
+	hwmon_device_unregister(data->class_dev);
+}
+
 static struct i2c_driver w83627ehf_driver;
 
 static void w83627ehf_init_client(struct i2c_client *client)
@@ -1224,29 +1233,62 @@
 	}
 
   	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
-  		device_create_file(dev, &sda_sf3_arrays[i].dev_attr);
+		if ((err = device_create_file(dev,
+			&sda_sf3_arrays[i].dev_attr)))
+			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
 	if (data->has_fan & (1 << 3))
-		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
-			device_create_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
+		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
+			if ((err = device_create_file(dev,
+				&sda_sf3_arrays_fan4[i].dev_attr)))
+				goto exit_remove;
+		}
 
 	for (i = 0; i < 10; i++)
-		device_create_file_in(dev, i);
+		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_alarm[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_min[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_in_max[i].dev_attr)))
+			goto exit_remove;
 
 	for (i = 0; i < 5; i++) {
 		if (data->has_fan & (1 << i)) {
-			device_create_file_fan(dev, i);
-			if (i != 4) /* we have only 4 pwm */
-				device_create_file_pwm(dev, i);
+			if ((err = device_create_file(dev,
+					&sda_fan_input[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_alarm[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_div[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_fan_min[i].dev_attr)))
+				goto exit_remove;
+			if (i < 4 && /* w83627ehf only has 4 pwm */
+				((err = device_create_file(dev,
+					&sda_pwm[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_pwm_mode[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_pwm_enable[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_target_temp[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_tolerance[i].dev_attr))))
+				goto exit_remove;
 		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
-		device_create_file(dev, &sda_temp[i].dev_attr);
+		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
+			goto exit_remove;
 
 	return 0;
 
+exit_remove:
+	remove_unregister(data, dev);
 exit_detach:
 	i2c_detach_client(client);
 exit_free:
@@ -1262,7 +1304,7 @@
 	struct w83627ehf_data *data = i2c_get_clientdata(client);
 	int err;
 
-	hwmon_device_unregister(data->class_dev);
+	remove_unregister(data, &client->dev);
 
 	if ((err = i2c_detach_client(client)))
 		return err;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_unchecked_device_create_file1.patch
Type: application/octet-stream
Size: 6226 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060827/2b0d2f12/attachment-0001.obj 
