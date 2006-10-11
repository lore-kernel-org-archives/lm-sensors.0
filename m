From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 11 Oct 2006 04:38:40 +0000
Subject: [lm-sensors] [patch] hwmon-sysfs.h: add _RO and _RW versions of
Message-Id: <452C7550.10707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45292789.5000003@gmail.com>
In-Reply-To: <45292789.5000003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>> 1st attachment adds _RO and _RW versions to the following macros:
>> SENSOR_ATTR, SENSOR_DEVICE_ATTR,
>> SENSOR_ATTR_2, SENSOR_DEVICE_ATTR_2,
>>
>> with these defined, the script (2nd attachment) will convert ~800 uses
>> (in 17 files) to the correct _RO/_RW version, and remove the linewraps.
>> The results compile cleanly (all modules in hwmon).
>>     
>
> What are you trying to achieve?
>
>   
cosmetics and abstraction.
- the 800 uses effectively have 2 modes; 0644 and 0444, but have 
multiple ways of saying it
- these permissions approach 'canonical' use, so if we hide them, 
exceptions become more distinct.
- lines are shorter, much less line-wrap fussing.

> May you please post a sample patch as obtained by using the script
> above on one arbitrary driver? So that we can see what it looks like.
>
>   
ok.  Ive in-lined the patch to hwmon-sysfs.h, and the script's 
conversion of f71805f.c

>> Is this something you'd consider applying ? If so, when ?
>>     
>
> It merely depends on what our purpose is. As for "when", remember that
> we have two high priority tasks for hwmon drivers now: individual alarm
> files, and i2c-isa removal. I would like the first one to be done for
> 2.6.20, and the second in 2.6.21 but individual drivers can (should) be
> converted to platform drivers before that. These will be large and
> intrusive patches and I am unlikely to take other large and intrudive
> patches until it's done.
>
>   
>> Theres obvious timing issues - since this patch touches many drivers, 
>> which may have work in-queue (yours or other hackers').  Its also why
>> I sent the script - the patch it yields is 94KB, so the script is far
>> more inspectable, and with the script, you can chose the optimal
>> time(s) w/o synchronization hassles.
>>     
>
> Yes, sounds like a good idea, even though in this case your script is
> rather frightening. I can't get why you didn't write a real perl
> script? It would perform better and would certainly be somewhat more
> readable too.
>
>   
its an assembly of 1-liners.
regexs always look like line-noise, its their nature.
runtime on hwmon/*.c was <5 sec, hardly prohibitive for a 1-time script.

That said, Ive rewritten it as a pure perl script, attached.
use it like so:
perl chg-ro drivers/hwmon/*.c

diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/include/linux/hwmon-sysfs.h ro-rw/include/linux/hwmon-sysfs.h
--- 19rc1-0/include/linux/hwmon-sysfs.h	2006-06-17 19:49:35.000000000 -0600
+++ ro-rw/include/linux/hwmon-sysfs.h	2006-10-08 09:33:48.000000000 -0600
@@ -31,10 +31,24 @@ struct sensor_device_attribute{
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .index = _index }
 
+#define SENSOR_ATTR_RO(_name, _show, _index)	\
+	SENSOR_ATTR(_name, S_IRUGO, _show, NULL, _index)
+
+#define SENSOR_ATTR_RW(_name, _show, _store, _index)	\
+	SENSOR_ATTR(_name, S_IRUGO | S_IWUSR, _show, _store, _index)
+
 #define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
 struct sensor_device_attribute sensor_dev_attr_##_name		\
 	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
 
+#define SENSOR_DEVICE_ATTR_RO(_name, _show, _index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name	\
+	= SENSOR_ATTR_RO(_name, _show, _index)
+
+#define SENSOR_DEVICE_ATTR_RW(_name, _show, _store, _index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name		\
+	= SENSOR_ATTR_RW(_name, _show, _store, _index)
+
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
 	u8 index;
@@ -48,8 +62,22 @@ struct sensor_device_attribute_2 {
 	  .index = _index,					\
 	  .nr = _nr }
 
+#define SENSOR_ATTR_2RO(_name, _show, _nr, _index)		\
+	SENSOR_ATTR_2(_name, S_IRUGO, _show, NULL, _nr, _index)
+
+#define SENSOR_ATTR_2RW(_name, _show, _store, _nr, _index)	\
+	SENSOR_ATTR_2(_name, S_IRUGO | S_IWUSR, _show, _store, _nr, _index)
+
 #define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
 struct sensor_device_attribute_2 sensor_dev_attr_##_name		\
 	= SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)
 
+#define SENSOR_DEVICE_ATTR_2RO(_name,_show,_nr,_index)		\
+struct sensor_device_attribute_2 sensor_dev_attr_##_name	\
+	= SENSOR_ATTR_2RO(_name, _show, _nr, _index)
+
+#define SENSOR_DEVICE_ATTR_2RW(_name,_show,_store,_nr,_index)	\
+struct sensor_device_attribute_2 sensor_dev_attr_##_name	\
+	= SENSOR_ATTR_2RW(_name, _show, _store, _nr, _index)
+
 #endif /* _LINUX_HWMON_SYSFS_H */


diff -ruNp -X dontdiff -X exclude-diffs 19rc1-3/drivers/hwmon/f71805f.c 19rc1-4/drivers/hwmon/f71805f.c
--- 19rc1-3/drivers/hwmon/f71805f.c	2006-10-05 20:17:49.000000000 -0600
+++ 19rc1-4/drivers/hwmon/f71805f.c	2006-10-08 22:01:58.000000000 -0600
@@ -597,91 +597,66 @@ static ssize_t show_name(struct device *
 static DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL);
 static DEVICE_ATTR(in0_max, S_IRUGO| S_IWUSR, show_in0_max, set_in0_max);
 static DEVICE_ATTR(in0_min, S_IRUGO| S_IWUSR, show_in0_min, set_in0_min);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 1);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 2);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 3);
-static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in4_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 4);
-static SENSOR_DEVICE_ATTR(in4_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 5);
-static SENSOR_DEVICE_ATTR(in5_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 5);
-static SENSOR_DEVICE_ATTR(in5_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 6);
-static SENSOR_DEVICE_ATTR(in6_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 6);
-static SENSOR_DEVICE_ATTR(in6_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 7);
-static SENSOR_DEVICE_ATTR(in7_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 7);
-static SENSOR_DEVICE_ATTR(in7_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 8);
-static SENSOR_DEVICE_ATTR(in8_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 8);
-static SENSOR_DEVICE_ATTR(in8_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 8);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 2);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 2);
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2);
-
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR_RO(in1_input, show_in, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_max, show_in_max, set_in_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_min, show_in_min, set_in_min, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, show_in, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_max, show_in_max, set_in_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_min, show_in_min, set_in_min, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, show_in, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_max, show_in_max, set_in_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_min, show_in_min, set_in_min, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, show_in, 4);
+static SENSOR_DEVICE_ATTR_RW(in4_max, show_in_max, set_in_max, 4);
+static SENSOR_DEVICE_ATTR_RW(in4_min, show_in_min, set_in_min, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, show_in, 5);
+static SENSOR_DEVICE_ATTR_RW(in5_max, show_in_max, set_in_max, 5);
+static SENSOR_DEVICE_ATTR_RW(in5_min, show_in_min, set_in_min, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, show_in, 6);
+static SENSOR_DEVICE_ATTR_RW(in6_max, show_in_max, set_in_max, 6);
+static SENSOR_DEVICE_ATTR_RW(in6_min, show_in_min, set_in_min, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, show_in, 7);
+static SENSOR_DEVICE_ATTR_RW(in7_max, show_in_max, set_in_max, 7);
+static SENSOR_DEVICE_ATTR_RW(in7_min, show_in_min, set_in_min, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, show_in, 8);
+static SENSOR_DEVICE_ATTR_RW(in8_max, show_in_max, set_in_max, 8);
+static SENSOR_DEVICE_ATTR_RW(in8_min, show_in_min, set_in_min, 8);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, show_fan, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, show_fan_min, set_fan_min, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, show_fan, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, show_fan_min, set_fan_min, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, show_fan, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, show_fan_min, set_fan_min, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, show_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, show_temp_max, set_temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, show_temp_hyst, set_temp_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_type, show_temp_type, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, show_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, show_temp_max, set_temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max_hyst, show_temp_hyst, set_temp_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_type, show_temp_type, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, show_temp, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, show_temp_max, set_temp_max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max_hyst, show_temp_hyst, set_temp_hyst, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_type, show_temp_type, 2);
+
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, show_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, show_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, show_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, show_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, show_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, show_alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, show_alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, show_alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, show_alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, show_alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, show_alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, show_alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, show_alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, show_alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, show_alarm, 18);
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_alarms_in, NULL);
 static DEVICE_ATTR(alarms_fan, S_IRUGO, show_alarms_fan, NULL);
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_alarms_temp, NULL);



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: chg-ro
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061010/3d42e697/attachment-0001.pl 
