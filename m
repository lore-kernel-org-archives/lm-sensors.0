From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 16:24:37 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707260924s12b0bd9fq1f5ff4b2bad9494@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi cilly,

> Hi Juerg,
>
> > Are you saying you compiled the vt1211 statically into the kernel and
> > not as a module?
>
> yes, I did compile it into the kernel.
>
> > Hmm... What does 'ls /sys/class/hwmon*/*' return?
>
> I am on gentoo, kernel 2.6.21.6.
>
> /sys/class/hwmon/:
> total 0
> drwxr-xr-x  3 root root 0 2007-07-21 21:28 .
> drwxr-xr-x 21 root root 0 2007-07-21 21:29 ..
> drwxr-xr-x  2 root root 0 2007-07-25 02:15 hwmon0
>
> /sys/class/hwmon/hwmon0:
> total 0
> drwxr-xr-x 2 root root    0 2007-07-25 02:15 .
> drwxr-xr-x 3 root root    0 2007-07-21 21:28 ..
> lrwxrwxrwx 1 root root    0 2007-07-25 02:15 device -> ../../../
> devices/platform/vt1211.24
> 576
> lrwxrwxrwx 1 root root    0 2007-07-25 02:15 subsystem -> ../../../
> class/hwmon
> --w------- 1 root root 4096 2007-07-25 02:15 uevent
>
> /sys/class/hwmon/hwmon0/device/:
> total 0
> drwxr-xr-x 3 root root    0 2007-07-25 02:15 .
> drwxr-xr-x 7 root root    0 2007-07-21 21:28 ..
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 alarms
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 cpu0_vid
> lrwxrwxrwx 1 root root    0 2007-07-25 02:15 driver -> ../../../bus/
> platform/drivers/vt1211
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 fan1_alarm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 fan1_div
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 fan1_input
> -rw-r--r-- 1 root root    0 2007-07-25 02:58 fan1_min
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 fan2_alarm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 fan2_div
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 fan2_input
> -rw-r--r-- 1 root root    0 2007-07-25 02:58 fan2_min
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 in0_alarm
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 in0_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in0_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in0_min
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 in1_alarm
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 in1_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in1_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in1_min
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in2_alarm
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 in2_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in2_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in2_min
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in3_alarm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in3_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in3_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in3_min
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in4_alarm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in4_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in4_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in4_min
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in5_alarm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 in5_input
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in5_max
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 in5_min
> -r--r--r-- 1 root root 4096 2007-07-24 02:30 modalias
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 name
> drwxr-xr-x 2 root root    0 2007-07-25 17:43 power
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_channels_temp
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point1_pwm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point1_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point2_pwm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point2_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point3_pwm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point3_temp
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point4_pwm
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_auto_point4_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_enable
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm1_freq
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_channels_temp
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point1_pwm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point1_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point2_pwm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point2_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point3_pwm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point3_temp
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point4_pwm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_auto_point4_temp
> -rw-r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_enable
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 pwm2_freq
> lrwxrwxrwx 1 root root    0 2007-07-24 02:30 subsystem -> ../../../
> bus/platform
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 temp1_alarm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 temp1_input
> -rw-r--r-- 1 root root    0 2007-07-25 02:58 temp1_max
> -rw-r--r-- 1 root root    0 2007-07-25 02:58 temp1_max_hyst
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 temp2_alarm
> -r--r--r-- 1 root root 4096 2007-07-25 02:15 temp2_input
> -rw-r--r-- 1 root root    0 2007-07-25 02:54 temp2_max
> -rw-r--r-- 1 root root    0 2007-07-25 02:54 temp2_max_hyst
> --w------- 1 root root 4096 2007-07-24 02:30 uevent
> -rw-r--r-- 1 root root    0 2007-07-25 04:41 vrm
>
> /sys/class/hwmon/hwmon0/device/power:
> total 0
> drwxr-xr-x 2 root root    0 2007-07-25 17:43 .
> drwxr-xr-x 3 root root    0 2007-07-25 02:15 ..
> -rw-r--r-- 1 root root 4096 2007-07-25 17:43 wakeup

Looks all good. I guess your running on older version of sensors. What
does 'sensors -v' show? You might want to consider upgrading to the
latest version.

Anyhow, pwmconfig will not work with the vt1211 driver since the
driver doesn't support manual mode which pwmconfig relies on. I
couldn't get manual mode to work. The driver does support automatic
mode though and you can abuse the automatic mode to behave like manual
mode (but it still will not work with pwmconfig).
The idea is to set the automatic mode parameters to extreme values so
that the pwm controller stays always in the same pwm zone. Then you
can change the pwm value for that zone to manually control your fan.

Try the follwowing (assuming your fan is controlled by pwm2 and the
vt1211 is registered under hwmon0):

cd /sys/class/hwmon/hwmon0/device
# pwm2 is controlled by temp2
echo 2 > pwm2_auto_channels_temp
# enable auto mode
echo 2 > pwm2_enable
# set the temp boundaries to extreme values
echo -99999 > pwm1_auto_point1_temp
echo -99999 > pwm1_auto_point2_temp
echo 999999 > pwm1_auto_point3_temp
echo 999999 > pwm1_auto_point4_temp

You only need to issue the above command once to setup the vt1211. Now
to change the pwm value to xyz, you have to do the following

echo xyz > pwm2_auto_point3_pwm
echo -99999 > pwm1_auto_point3_temp
echo 999999 > pwm1_auto_point3_temp

And you can check the current pwm value:
grep "" pwm2

If your fan is controlled by pwm1, change pwm2 to pwm1 in the above commands.

After you issued the above commands, can you post the output of 'grep "" *'?
Let me know how it goes.

...juerg


>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
