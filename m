From: Philipp Kraus <philipp.kraus@flashpixx.de>
Date: Sat, 30 Jun 2012 17:27:49 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <jsncpc$2vi$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2012-06-30 19:03:44 +0200, Guenter Roeck said:

> On Sat, Jun 30, 2012 at 06:04:53PM +0200, Philipp Kraus wrote:
>> On 2012-06-30 17:33:38 +0200, Guenter Roeck said:
>> 
>>> On Sat, Jun 30, 2012 at 04:37:28PM +0200, Philipp Kraus wrote:
>>>> 
>>>> the grep command shows
>>>> grep: /sys/class/hwmon/hwmon1/device/driver: Is a directory
>>>> grep: /sys/class/hwmon/hwmon1/device/hwmon: Is a directory
>>>> grep: /sys/class/hwmon/hwmon1/device/power: Is a directory
>>>> grep: /sys/class/hwmon/hwmon1/device/subsystem: Is a directory
>>>> 
>>>> and within the directory are the in*, pwm* temp* files
>>>> 
>>> Not sure I understand.
>>> 
>>> I'll need the names and output for the pwm* and temp* files. They
>>> _should_ be in
>>> /sys/class/hwmon/hwmon1/device/pwm* and /sys/class/hwmon/hwmon1/device/temp*.
>> 
>> the command grep /sys.... does not work, I have run an ls -l and
> 
> Phil,
> 
> It wasn't "grep /sys/...", it was "grep . /sys/class/hwmon/hwmon1/device/*".
> The "." is important. Your output gives me the file names, but I need names and
> content, not names and permissions.

Sorry, my mistake, I haven't seen that it ist "grep . <space> /sys..."
Hope this the correct output now

/sys/class/hwmon/hwmon1/device/beep_enable:0
/sys/class/hwmon/hwmon1/device/chassis:0
/sys/class/hwmon/hwmon1/device/cpu0_vid:2050
/sys/class/hwmon/hwmon1/device/fan1_alarm:1
/sys/class/hwmon/hwmon1/device/fan1_beep:0
/sys/class/hwmon/hwmon1/device/fan1_input:0
/sys/class/hwmon/hwmon1/device/fan1_min:712
/sys/class/hwmon/hwmon1/device/fan2_alarm:0
/sys/class/hwmon/hwmon1/device/fan2_beep:0
/sys/class/hwmon/hwmon1/device/fan2_input:1904
/sys/class/hwmon/hwmon1/device/fan2_min:1500
/sys/class/hwmon/hwmon1/device/fan3_alarm:0
/sys/class/hwmon/hwmon1/device/fan3_beep:0
/sys/class/hwmon/hwmon1/device/fan3_input:2023
/sys/class/hwmon/hwmon1/device/fan3_min:1500
/sys/class/hwmon/hwmon1/device/fan4_alarm:1
/sys/class/hwmon/hwmon1/device/fan4_beep:0
/sys/class/hwmon/hwmon1/device/fan4_input:0
/sys/class/hwmon/hwmon1/device/fan4_min:712
/sys/class/hwmon/hwmon1/device/fan5_alarm:0
/sys/class/hwmon/hwmon1/device/fan5_beep:0
/sys/class/hwmon/hwmon1/device/fan5_input:1277
/sys/class/hwmon/hwmon1/device/fan5_min:900
/sys/class/hwmon/hwmon1/device/fan6_alarm:1
/sys/class/hwmon/hwmon1/device/fan6_beep:0
/sys/class/hwmon/hwmon1/device/fan6_input:0
/sys/class/hwmon/hwmon1/device/fan6_min:712
/sys/class/hwmon/hwmon1/device/fan7_alarm:0
/sys/class/hwmon/hwmon1/device/fan7_beep:0
/sys/class/hwmon/hwmon1/device/fan7_input:6108
/sys/class/hwmon/hwmon1/device/fan7_min:2000
/sys/class/hwmon/hwmon1/device/fan8_alarm:0
/sys/class/hwmon/hwmon1/device/fan8_beep:0
/sys/class/hwmon/hwmon1/device/fan8_input:6428
/sys/class/hwmon/hwmon1/device/fan8_min:2000
/sys/class/hwmon/hwmon1/device/in0_alarm:0
/sys/class/hwmon/hwmon1/device/in0_beep:0
/sys/class/hwmon/hwmon1/device/in0_input:1068
/sys/class/hwmon/hwmon1/device/in0_max:1486
/sys/class/hwmon/hwmon1/device/in0_min:926
/sys/class/hwmon/hwmon1/device/in1_alarm:0
/sys/class/hwmon/hwmon1/device/in1_beep:0
/sys/class/hwmon/hwmon1/device/in1_input:1070
/sys/class/hwmon/hwmon1/device/in1_max:1486
/sys/class/hwmon/hwmon1/device/in1_min:926
/sys/class/hwmon/hwmon1/device/in2_alarm:0
/sys/class/hwmon/hwmon1/device/in2_beep:0
/sys/class/hwmon/hwmon1/device/in2_input:1014
/sys/class/hwmon/hwmon1/device/in2_max:1326
/sys/class/hwmon/hwmon1/device/in2_min:1000
/sys/class/hwmon/hwmon1/device/in3_alarm:0
/sys/class/hwmon/hwmon1/device/in3_beep:0
/sys/class/hwmon/hwmon1/device/in3_input:528
/sys/class/hwmon/hwmon1/device/in3_max:688
/sys/class/hwmon/hwmon1/device/in3_min:384
/sys/class/hwmon/hwmon1/device/in4_alarm:0
/sys/class/hwmon/hwmon1/device/in4_beep:0
/sys/class/hwmon/hwmon1/device/in4_input:560
/sys/class/hwmon/hwmon1/device/in4_max:1648
/sys/class/hwmon/hwmon1/device/in4_min:496
/sys/class/hwmon/hwmon1/device/in5_alarm:0
/sys/class/hwmon/hwmon1/device/in5_beep:0
/sys/class/hwmon/hwmon1/device/in5_input:3408
/sys/class/hwmon/hwmon1/device/in5_max:3632
/sys/class/hwmon/hwmon1/device/in5_min:2960
/sys/class/hwmon/hwmon1/device/in6_alarm:0
/sys/class/hwmon/hwmon1/device/in6_beep:0
/sys/class/hwmon/hwmon1/device/in6_input:992
/sys/class/hwmon/hwmon1/device/in6_max:1104
/sys/class/hwmon/hwmon1/device/in6_min:896
/sys/class/hwmon/hwmon1/device/in7_alarm:0
/sys/class/hwmon/hwmon1/device/in7_beep:0
/sys/class/hwmon/hwmon1/device/in7_input:5070
/sys/class/hwmon/hwmon1/device/in7_max:5502
/sys/class/hwmon/hwmon1/device/in7_min:4518
/sys/class/hwmon/hwmon1/device/in8_alarm:0
/sys/class/hwmon/hwmon1/device/in8_beep:0
/sys/class/hwmon/hwmon1/device/in8_input:5118
/sys/class/hwmon/hwmon1/device/in8_max:5502
/sys/class/hwmon/hwmon1/device/in8_min:4518
/sys/class/hwmon/hwmon1/device/in9_alarm:0
/sys/class/hwmon/hwmon1/device/in9_beep:0
/sys/class/hwmon/hwmon1/device/in9_input:3232
/sys/class/hwmon/hwmon1/device/in9_max:3296
/sys/class/hwmon/hwmon1/device/in9_min:2704
/sys/class/hwmon/hwmon1/device/intrusion0_alarm:0
/sys/class/hwmon/hwmon1/device/modalias:i2c:w83793
/sys/class/hwmon/hwmon1/device/name:w83793
/sys/class/hwmon/hwmon1/device/pwm1:252
/sys/class/hwmon/hwmon1/device/pwm1_nonstop:152
/sys/class/hwmon/hwmon1/device/pwm1_start:32
/sys/class/hwmon/hwmon1/device/pwm1_stop_time:0
/sys/class/hwmon/hwmon1/device/pwm2:252
/sys/class/hwmon/hwmon1/device/pwm2_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm2_start:32
/sys/class/hwmon/hwmon1/device/pwm2_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm3:252
/sys/class/hwmon/hwmon1/device/pwm3_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm3_start:32
/sys/class/hwmon/hwmon1/device/pwm3_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm4:252
/sys/class/hwmon/hwmon1/device/pwm4_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm4_start:32
/sys/class/hwmon/hwmon1/device/pwm4_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm5:252
/sys/class/hwmon/hwmon1/device/pwm5_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm5_start:32
/sys/class/hwmon/hwmon1/device/pwm5_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm6:252
/sys/class/hwmon/hwmon1/device/pwm6_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm6_start:32
/sys/class/hwmon/hwmon1/device/pwm6_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm7:252
/sys/class/hwmon/hwmon1/device/pwm7_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm7_start:32
/sys/class/hwmon/hwmon1/device/pwm7_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm8:252
/sys/class/hwmon/hwmon1/device/pwm8_nonstop:16
/sys/class/hwmon/hwmon1/device/pwm8_start:32
/sys/class/hwmon/hwmon1/device/pwm8_stop_time:10000
/sys/class/hwmon/hwmon1/device/pwm_default:252
/sys/class/hwmon/hwmon1/device/pwm_downtime:300
/sys/class/hwmon/hwmon1/device/pwm_uptime:200
/sys/class/hwmon/hwmon1/device/temp1_alarm:0
/sys/class/hwmon/hwmon1/device/temp1_auto_channels_pwm:1
/sys/class/hwmon/hwmon1/device/temp1_auto_point1_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point1_temp:50000
/sys/class/hwmon/hwmon1/device/temp1_auto_point2_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point2_temp:50000
/sys/class/hwmon/hwmon1/device/temp1_auto_point3_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point3_temp:50000
/sys/class/hwmon/hwmon1/device/temp1_auto_point4_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point4_temp:72000
/sys/class/hwmon/hwmon1/device/temp1_auto_point5_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point5_temp:72000
/sys/class/hwmon/hwmon1/device/temp1_auto_point6_pwm:152
/sys/class/hwmon/hwmon1/device/temp1_auto_point6_temp:77000
/sys/class/hwmon/hwmon1/device/temp1_auto_point7_pwm:192
/sys/class/hwmon/hwmon1/device/temp1_auto_point7_temp:82000
/sys/class/hwmon/hwmon1/device/temp1_beep:0
/sys/class/hwmon/hwmon1/device/temp1_input:52000
/sys/class/hwmon/hwmon1/device/temp1_max:75000
/sys/class/hwmon/hwmon1/device/temp1_max_hyst:60000
/sys/class/hwmon/hwmon1/device/temp1_pwm_enable:2
/sys/class/hwmon/hwmon1/device/temp1_type:6
/sys/class/hwmon/hwmon1/device/temp1_warn:85000
/sys/class/hwmon/hwmon1/device/temp1_warn_hyst:80000
/sys/class/hwmon/hwmon1/device/temp2_alarm:0
/sys/class/hwmon/hwmon1/device/temp2_auto_channels_pwm:1
/sys/class/hwmon/hwmon1/device/temp2_auto_point1_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point1_temp:50000
/sys/class/hwmon/hwmon1/device/temp2_auto_point2_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point2_temp:50000
/sys/class/hwmon/hwmon1/device/temp2_auto_point3_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point3_temp:50000
/sys/class/hwmon/hwmon1/device/temp2_auto_point4_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point4_temp:72000
/sys/class/hwmon/hwmon1/device/temp2_auto_point5_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point5_temp:72000
/sys/class/hwmon/hwmon1/device/temp2_auto_point6_pwm:152
/sys/class/hwmon/hwmon1/device/temp2_auto_point6_temp:77000
/sys/class/hwmon/hwmon1/device/temp2_auto_point7_pwm:192
/sys/class/hwmon/hwmon1/device/temp2_auto_point7_temp:82000
/sys/class/hwmon/hwmon1/device/temp2_beep:0
/sys/class/hwmon/hwmon1/device/temp2_input:54000
/sys/class/hwmon/hwmon1/device/temp2_max:75000
/sys/class/hwmon/hwmon1/device/temp2_max_hyst:60000
/sys/class/hwmon/hwmon1/device/temp2_pwm_enable:2
/sys/class/hwmon/hwmon1/device/temp2_type:6
/sys/class/hwmon/hwmon1/device/temp2_warn:85000
/sys/class/hwmon/hwmon1/device/temp2_warn_hyst:80000
/sys/class/hwmon/hwmon1/device/temp3_alarm:0
/sys/class/hwmon/hwmon1/device/temp3_auto_channels_pwm:1
/sys/class/hwmon/hwmon1/device/temp3_auto_point1_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point1_temp:50000
/sys/class/hwmon/hwmon1/device/temp3_auto_point2_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point2_temp:50000
/sys/class/hwmon/hwmon1/device/temp3_auto_point3_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point3_temp:50000
/sys/class/hwmon/hwmon1/device/temp3_auto_point4_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point4_temp:72000
/sys/class/hwmon/hwmon1/device/temp3_auto_point5_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point5_temp:72000
/sys/class/hwmon/hwmon1/device/temp3_auto_point6_pwm:152
/sys/class/hwmon/hwmon1/device/temp3_auto_point6_temp:77000
/sys/class/hwmon/hwmon1/device/temp3_auto_point7_pwm:192
/sys/class/hwmon/hwmon1/device/temp3_auto_point7_temp:82000
/sys/class/hwmon/hwmon1/device/temp3_beep:0
/sys/class/hwmon/hwmon1/device/temp3_input:75250
/sys/class/hwmon/hwmon1/device/temp3_max:87000
/sys/class/hwmon/hwmon1/device/temp3_max_hyst:82000
/sys/class/hwmon/hwmon1/device/temp3_pwm_enable:2
/sys/class/hwmon/hwmon1/device/temp3_type:6
/sys/class/hwmon/hwmon1/device/temp3_warn:85000
/sys/class/hwmon/hwmon1/device/temp3_warn_hyst:80000
/sys/class/hwmon/hwmon1/device/temp4_alarm:0
/sys/class/hwmon/hwmon1/device/temp4_auto_channels_pwm:1
/sys/class/hwmon/hwmon1/device/temp4_auto_point1_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point1_temp:50000
/sys/class/hwmon/hwmon1/device/temp4_auto_point2_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point2_temp:50000
/sys/class/hwmon/hwmon1/device/temp4_auto_point3_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point3_temp:50000
/sys/class/hwmon/hwmon1/device/temp4_auto_point4_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point4_temp:72000
/sys/class/hwmon/hwmon1/device/temp4_auto_point5_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point5_temp:72000
/sys/class/hwmon/hwmon1/device/temp4_auto_point6_pwm:152
/sys/class/hwmon/hwmon1/device/temp4_auto_point6_temp:77000
/sys/class/hwmon/hwmon1/device/temp4_auto_point7_pwm:192
/sys/class/hwmon/hwmon1/device/temp4_auto_point7_temp:82000
/sys/class/hwmon/hwmon1/device/temp4_beep:0
/sys/class/hwmon/hwmon1/device/temp4_input:78000
/sys/class/hwmon/hwmon1/device/temp4_max:87000
/sys/class/hwmon/hwmon1/device/temp4_max_hyst:82000
/sys/class/hwmon/hwmon1/device/temp4_pwm_enable:2
/sys/class/hwmon/hwmon1/device/temp4_type:6
/sys/class/hwmon/hwmon1/device/temp4_warn:85000
/sys/class/hwmon/hwmon1/device/temp4_warn_hyst:80000
/sys/class/hwmon/hwmon1/device/temp5_alarm:0
/sys/class/hwmon/hwmon1/device/temp5_auto_channels_pwm:0
/sys/class/hwmon/hwmon1/device/temp5_auto_point1_pwm:32
/sys/class/hwmon/hwmon1/device/temp5_auto_point1_temp:30000
/sys/class/hwmon/hwmon1/device/temp5_auto_point2_pwm:48
/sys/class/hwmon/hwmon1/device/temp5_auto_point2_temp:35000
/sys/class/hwmon/hwmon1/device/temp5_auto_point3_pwm:64
/sys/class/hwmon/hwmon1/device/temp5_auto_point3_temp:40000
/sys/class/hwmon/hwmon1/device/temp5_auto_point4_pwm:96
/sys/class/hwmon/hwmon1/device/temp5_auto_point4_temp:45000
/sys/class/hwmon/hwmon1/device/temp5_auto_point5_pwm:128
/sys/class/hwmon/hwmon1/device/temp5_auto_point5_temp:50000
/sys/class/hwmon/hwmon1/device/temp5_auto_point6_pwm:192
/sys/class/hwmon/hwmon1/device/temp5_auto_point6_temp:55000
/sys/class/hwmon/hwmon1/device/temp5_auto_point7_pwm:224
/sys/class/hwmon/hwmon1/device/temp5_auto_point7_temp:60000
/sys/class/hwmon/hwmon1/device/temp5_beep:0
/sys/class/hwmon/hwmon1/device/temp5_input:46000
/sys/class/hwmon/hwmon1/device/temp5_max:75000
/sys/class/hwmon/hwmon1/device/temp5_max_hyst:70000
/sys/class/hwmon/hwmon1/device/temp5_pwm_enable:2
/sys/class/hwmon/hwmon1/device/temp5_type:4
/sys/class/hwmon/hwmon1/device/temp5_warn:85000
/sys/class/hwmon/hwmon1/device/temp5_warn_hyst:80000
/sys/class/hwmon/hwmon1/device/temp_critical:127000
/sys/class/hwmon/hwmon1/device/thermal_cruise1:40000
/sys/class/hwmon/hwmon1/device/thermal_cruise2:40000
/sys/class/hwmon/hwmon1/device/thermal_cruise3:40000
/sys/class/hwmon/hwmon1/device/thermal_cruise4:40000
/sys/class/hwmon/hwmon1/device/thermal_cruise5:32000
/sys/class/hwmon/hwmon1/device/tolerance1:5000
/sys/class/hwmon/hwmon1/device/tolerance2:5000
/sys/class/hwmon/hwmon1/device/tolerance3:5000
/sys/class/hwmon/hwmon1/device/tolerance4:5000
/sys/class/hwmon/hwmon1/device/tolerance5:2000
/sys/class/hwmon/hwmon1/device/uevent:DRIVER=w83793
/sys/class/hwmon/hwmon1/device/uevent:MODALIAS=i2c:w83793
/sys/class/hwmon/hwmon1/device/vrm:82

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
