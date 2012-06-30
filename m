From: Philipp Kraus <philipp.kraus@flashpixx.de>
Date: Sat, 30 Jun 2012 16:04:53 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <jsn7tr$2vr$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2012-06-30 17:33:38 +0200, Guenter Roeck said:

> On Sat, Jun 30, 2012 at 04:37:28PM +0200, Philipp Kraus wrote:
>> 
>> the grep command shows
>> grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
>> grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
>> grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
>> grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory
>> 
>> and within the directory are the in*, pwm* temp* files
>> 
> Not sure I understand.
> 
> I'll need the names and output for the pwm* and temp* files. They 
> _should_ be in
> /sys/class/hwmon/hwmon1/device/pwm* and /sys/class/hwmon/hwmon1/device/temp*.

the command grep /sys.... does not work, I have run an ls -l and grep 
the pwm files,
I think this is the correct output

-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm1
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm1_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm1_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm1_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm2
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm2_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm2_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm2_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm3
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm3_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm3_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm3_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm4
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm4_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm4_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm4_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm5
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm5_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm5_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm5_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm6
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm6_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm6_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm6_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm7
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm7_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm7_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm7_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:31 /sys/class/hwmon/hwmon1/device/pwm8
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm8_nonstop
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm8_start
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm8_stop_time
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm_default
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm_downtime
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/pwm_uptime

and my temp files

-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_alarm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point1_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point2_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point3_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point4_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point5_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point5_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point6_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point6_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point7_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_auto_point7_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_beep
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_input
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_max
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_max_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_pwm_enable
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp1_type
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_warn
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp1_warn_hyst
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_alarm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point1_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point2_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point3_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point4_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point5_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point5_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point6_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point6_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point7_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_auto_point7_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_beep
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_input
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_max
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_max_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_pwm_enable
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp2_type
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_warn
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp2_warn_hyst
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_alarm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_channels_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point1_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point2_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point3_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point4_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point5_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point5_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point6_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point6_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point7_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_auto_point7_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_beep
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_input
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_max
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_max_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_pwm_enable
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp3_type
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_warn
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp3_warn_hyst
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_alarm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_channels_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point1_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point2_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point3_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point4_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point5_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point5_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point6_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point6_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point7_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_auto_point7_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_beep
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_input
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_max
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_max_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_pwm_enable
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp4_type
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_warn
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp4_warn_hyst
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_alarm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_channels_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point1_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point2_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point3_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point4_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point5_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point5_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point6_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point6_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point7_pwm
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_auto_point7_temp
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_beep
-r--r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_input
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_max
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_max_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_pwm_enable
-rw-r--r-- 1 root root 4096 Jun 30 16:02 
/sys/class/hwmon/hwmon1/device/temp5_type
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_warn
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp5_warn_hyst
-rw-r--r-- 1 root root 4096 Jun 30 16:29 
/sys/class/hwmon/hwmon1/device/temp_critical

Thanks

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
