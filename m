From: sergio <mailbox@sergio.spb.ru>
Date: Fri, 27 Mar 2009 16:30:49 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <49CCFF39.9040705@sergio.spb.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040008040907070408090803"
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040008040907070408090803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean.


> Do you actually know of one NAS or router running busybox and needing
> software-based fan speed control? Or is this just a theory?
Theory.

>> force_load is function for initramfs-tools hook script...
> That's kind of a misnomer, as it isn't forcing anything.
May be, you can suggest the better name?
 > It just load the driver early.
Yes.

> OK, I understand your setup now. But I fail to see how the it87 driver
> alone helps. Loading the it87 driver shouldn't change any fan speed. So
> I suppose that you also included the fancontrol script in your
> initramfs, or maybe some custom script just slowing down one fan?
simple echo

> Please don't compress patches, it only makes them harder to review.
ok

> Please fold long lines.
Excuse me, i don't pay attention.

 > As not all hwmon class devices have a device backing them up, this
 > could be a problem for some users.
But it is possible to specify absolute path for them.

> Also, to be truly useful for users, the possibility to use absolute
> paths should be used by the pwmconfig script, by following and
> resolving the device link of hwmon class devices before writing the
> configuration file. Care to give it a try?
I know. This fix is very simple and quick.
Path mixing and pwmconfig is not so easy to fix.
But not only paths should be reworked. Pid file is hardcoded. Egrep is 
deprecated. Configuration file is not very simple. Maybe it is the right 
time to rework whole fancontrol and pwmconfig. Or it will be better to 
save time for write new daemon. I can't find any suitable one of some 
which can be extended.

>>> Not to say that it can't be done properly for hwmon devices. But do
>>> you have some concrete proposal? "Let's just use udev" doesn't tell me
>>> much.
>> I don't clearly understand how udev works.
> OK, so it was just hand-waiving. Wonderful.
I was interested in you opinion about udev, no more.

-- 
sergio

--------------040008040907070408090803
Content-Type: text/x-diff;
 name="fancontrol.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fancontrol.patch"

diff -Naur lm_sensors-3.1.0.orig/doc/fancontrol.txt lm_sensors-3.1.0/doc/fancontrol.txt
--- lm_sensors-3.1.0.orig/doc/fancontrol.txt	2009-01-29 11:58:36.000000000 +0300
+++ lm_sensors-3.1.0/doc/fancontrol.txt	2009-03-27 18:04:23.000000000 +0300
@@ -99,14 +99,14 @@
 VARIABLE2=[...]
 
 Each variable has its own line. The variable name is followed by an equal sign
-and the device=value pairs. These consist of the relative path to the pwm
-output (from /sys/bus/i2c/devices or /sys/class/hwmon depending on the kernel
-version) for which the value is valid, equal sign followed by the value and
-are separated by a blank.
+and the device=value pairs. These consist of the path to the pwm output for
+which the value is valid, equal sign followed by the value and are separated
+by a blank. Path can be absolute or relative (from /sys/bus/i2c/devices or
+/sys/class/hwmon depending on the kernel version).
 
 Example:
 
-MINTEMP=w83627hf-isa-0290/pwm2=40 w83627hf-isa-0290/pwm1=54
+MINTEMP=hwmon0/device/pwm1=40 hwmon0/device/pwm2=54
 
 You have to play with the temperature values a bit to get happy. For initial
 setup I recommend using the pwmconfig script. Small changes can be made by
diff -Naur lm_sensors-3.1.0.orig/prog/pwm/fancontrol lm_sensors-3.1.0/prog/pwm/fancontrol
--- lm_sensors-3.1.0.orig/prog/pwm/fancontrol	2009-02-28 22:42:51.000000000 +0300
+++ lm_sensors-3.1.0/prog/pwm/fancontrol	2009-03-27 17:55:40.000000000 +0300
@@ -159,8 +159,11 @@
 	LoadConfig /etc/fancontrol
 fi
 
-# Detect if config file uses the hwmon class or not yet
-if echo "${AFCPWM[0]}" | egrep -q '^hwmon[0-9]'
+# Detect path to sensors
+if echo "${AFCPWM[0]}" | egrep -q '^/'
+then
+	DIR=/
+elif echo "${AFCPWM[0]}" | egrep -q '^hwmon[0-9]'
 then
 	DIR=/sys/class/hwmon
 else
diff -Naur lm_sensors-3.1.0.orig/prog/pwm/fancontrol.8 lm_sensors-3.1.0/prog/pwm/fancontrol.8
--- lm_sensors-3.1.0.orig/prog/pwm/fancontrol.8	2009-01-29 11:58:36.000000000 +0300
+++ lm_sensors-3.1.0/prog/pwm/fancontrol.8	2009-03-27 18:05:36.000000000 +0300
@@ -81,12 +81,12 @@
 .fi
 .PP
 Each variable has its own line. The variable name is followed by an equal sign
-and the device=value pairs. These consist of the relative path to the pwm
-output (from /sys/bus/i2c/devices or /sys/class/hwmon
-depending on the kernel version) for which the value is valid, equal sign
-followed by the value and are separated by a blank. Example:
+and the device=value pairs. These consist of the path to the pwm output for
+which the value is valid, equal sign followed by the value and are separated
+by a blank. Path can be absolute or relative (from /sys/bus/i2c/devices or
+/sys/class/hwmon depending on the kernel version). Example:
 .IP
-MINTEMP=w83627hf-isa-0290/pwm2=40 w83627hf-isa-0290/pwm1=54
+MINTEMP=hwmon0/device/pwm1=40 hwmon0/device/pwm2=54
 .PP
 You have to play with the temperature values a bit to get happy. For initial
 setup I recommend using the \fBpwmconfig\fP script. Small changes can be made by

--------------040008040907070408090803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040008040907070408090803--
