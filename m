From: cilly <cilly@cilly.mine.nu>
Date: Wed, 25 Jul 2007 15:47:13 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <32DF2369-16F2-468D-919A-0AA940B74A0B@cilly.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jul 25, 2007, at 6:26 AM, Juerg Haefliger wrote:

Hi Juerg,

> Are you saying you compiled the vt1211 statically into the kernel and
> not as a module?

yes, I did compile it into the kernel.

> Hmm... What does 'ls /sys/class/hwmon*/*' return?

I am on gentoo, kernel 2.6.21.6.

/sys/class/hwmon/:
total 0
drwxr-xr-x  3 root root 0 2007-07-21 21:28 .
drwxr-xr-x 21 root root 0 2007-07-21 21:29 ..
drwxr-xr-x  2 root root 0 2007-07-25 02:15 hwmon0

/sys/class/hwmon/hwmon0:
total 0
drwxr-xr-x 2 root root    0 2007-07-25 02:15 .
drwxr-xr-x 3 root root    0 2007-07-21 21:28 ..
lrwxrwxrwx 1 root root    0 2007-07-25 02:15 device -> ../../../ 
devices/platform/vt1211.24
576
lrwxrwxrwx 1 root root    0 2007-07-25 02:15 subsystem -> ../../../ 
class/hwmon
--w------- 1 root root 4096 2007-07-25 02:15 uevent

/sys/class/hwmon/hwmon0/device/:
total 0
drwxr-xr-x 3 root root    0 2007-07-25 02:15 .
drwxr-xr-x 7 root root    0 2007-07-21 21:28 ..
-r--r--r-- 1 root root 4096 2007-07-25 02:15 alarms
-r--r--r-- 1 root root 4096 2007-07-25 02:15 cpu0_vid
lrwxrwxrwx 1 root root    0 2007-07-25 02:15 driver -> ../../../bus/ 
platform/drivers/vt1211
-r--r--r-- 1 root root 4096 2007-07-25 02:15 fan1_alarm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 fan1_div
-r--r--r-- 1 root root 4096 2007-07-25 02:15 fan1_input
-rw-r--r-- 1 root root    0 2007-07-25 02:58 fan1_min
-r--r--r-- 1 root root 4096 2007-07-25 02:15 fan2_alarm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 fan2_div
-r--r--r-- 1 root root 4096 2007-07-25 02:15 fan2_input
-rw-r--r-- 1 root root    0 2007-07-25 02:58 fan2_min
-r--r--r-- 1 root root 4096 2007-07-24 02:30 in0_alarm
-r--r--r-- 1 root root 4096 2007-07-24 02:30 in0_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in0_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in0_min
-r--r--r-- 1 root root 4096 2007-07-24 02:30 in1_alarm
-r--r--r-- 1 root root 4096 2007-07-24 02:30 in1_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in1_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in1_min
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in2_alarm
-r--r--r-- 1 root root 4096 2007-07-24 02:30 in2_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in2_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in2_min
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in3_alarm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in3_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in3_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in3_min
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in4_alarm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in4_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in4_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in4_min
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in5_alarm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 in5_input
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in5_max
-rw-r--r-- 1 root root    0 2007-07-25 04:41 in5_min
-r--r--r-- 1 root root 4096 2007-07-24 02:30 modalias
-r--r--r-- 1 root root 4096 2007-07-25 02:15 name
drwxr-xr-x 2 root root    0 2007-07-25 17:43 power
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_channels_temp
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point1_pwm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point1_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point2_pwm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point2_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point3_pwm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point3_temp
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point4_pwm
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point4_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_enable
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_freq
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_channels_temp
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point1_pwm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point1_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point2_pwm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point2_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point3_pwm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point3_temp
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point4_pwm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point4_temp
-rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_enable
-r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_freq
lrwxrwxrwx 1 root root    0 2007-07-24 02:30 subsystem -> ../../../ 
bus/platform
-r--r--r-- 1 root root 4096 2007-07-25 02:15 temp1_alarm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 temp1_input
-rw-r--r-- 1 root root    0 2007-07-25 02:58 temp1_max
-rw-r--r-- 1 root root    0 2007-07-25 02:58 temp1_max_hyst
-r--r--r-- 1 root root 4096 2007-07-25 02:15 temp2_alarm
-r--r--r-- 1 root root 4096 2007-07-25 02:15 temp2_input
-rw-r--r-- 1 root root    0 2007-07-25 02:54 temp2_max
-rw-r--r-- 1 root root    0 2007-07-25 02:54 temp2_max_hyst
--w------- 1 root root 4096 2007-07-24 02:30 uevent
-rw-r--r-- 1 root root    0 2007-07-25 04:41 vrm

/sys/class/hwmon/hwmon0/device/power:
total 0
drwxr-xr-x 2 root root    0 2007-07-25 17:43 .
drwxr-xr-x 3 root root    0 2007-07-25 02:15 ..
-rw-r--r-- 1 root root 4096 2007-07-25 17:43 wakeup



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
