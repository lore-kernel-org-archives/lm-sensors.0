From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 03 Dec 2006 10:41:38 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <4572A9E2.8030704@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Jean Delvare wrote:
> On Sun, 03 Dec 2006 09:18:45 +0100, Udo van den Heuvel wrote:
>> Since booting into 2.6.19 on my VIA SP8000 I have a small problem with
>> the vt1211 sensors driver:
>>
>> sensors -s gives:
>>
>> vt1211-isa-6000: Can't access procfs/sysfs file for writing;
> 
> Are you root when running this command?

Sure!

>> Also the temperature sensors are not shown.
> 
> Please provide the complete output of "sensors".

# sensors
vt1211-isa-6000
Adapter: ISA adapter
VCore1:    +1.04 V  (min =  +1.13 V, max =  +1.27 V)   ALARM
+5V:       +4.93 V  (min =  +4.74 V, max =  +5.26 V)
+12V:     +12.05 V  (min = +11.38 V, max = +12.61 V)
+3.3V:     +5.28 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
System:   4070 RPM  (min = 2580 RPM, div = 2)
vid:      +1.850 V  (VRM Version 9.1)


>> sysfs is of course mounted and accessible.
>> lm_sensors 2.10.1 we have installed before rebooting.
> 
> What does "sensors -v" return?

sensors version 2.10.1 with libsensors version 2.10.1

>> The vt1211 sensors stuff has moved to
>> /sys/bus/platform/drivers/vt1211/vt1211.24576. In that directory the
>> files with sensors info for rpm, voltage etc can be found.
> 
> Yes, this is OK. You should also have a link in /sys/class/hwmon
> pointing to it.

Indeed. /sys/class/hwmon/hwmon0/device points to the directory I
mentioned earlier.

>> Of course the sensor's location on the bus was not changed so I am
>> wondering what is wrong, why can't the sensors command find the files in
>> /sys/bus/platform/drivers/vt1211/vt1211.24576?
> 
> Please provide a detailed listing (ls -l) of the files present in this
> directory.

# pwd
/sys/class/hwmon/hwmon0/device
[root at recorder device]# ls -l
total 0
-r--r--r-- 1 root root 4096 Dec  3 11:38 alarms
lrwxrwxrwx 1 root root    0 Dec  3 11:38 bus -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Dec  3 11:38 cpu0_vid
lrwxrwxrwx 1 root root    0 Dec  3 11:38 driver ->
../../../bus/platform/drivers/vt1211
-r--r--r-- 1 root root 4096 Dec  3 11:39 fan1_alarm
-rw-r--r-- 1 root root 4096 Dec  3 09:10 fan1_div
-r--r--r-- 1 root root 4096 Dec  3 11:39 fan1_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 fan1_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 fan2_alarm
-rw-r--r-- 1 root root 4096 Dec  3 09:10 fan2_div
-r--r--r-- 1 root root 4096 Dec  3 11:38 fan2_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 fan2_min
lrwxrwxrwx 1 root root    0 Dec  3 11:39 hwmon:hwmon0 ->
../../../class/hwmon/hwmon0
-r--r--r-- 1 root root 4096 Dec  3 11:39 in0_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:39 in0_input
-rw-r--r-- 1 root root 4096 Dec  3 11:39 in0_max
-rw-r--r-- 1 root root 4096 Dec  3 11:39 in0_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 in1_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:39 in1_input
-rw-r--r-- 1 root root 4096 Dec  3 11:39 in1_max
-rw-r--r-- 1 root root 4096 Dec  3 11:39 in1_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 in2_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:38 in2_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in2_max
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in2_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 in3_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:38 in3_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in3_max
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in3_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 in4_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:38 in4_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in4_max
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in4_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 in5_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:38 in5_input
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in5_max
-rw-r--r-- 1 root root 4096 Dec  3 09:10 in5_min
-r--r--r-- 1 root root 4096 Dec  3 11:39 modalias
-r--r--r-- 1 root root 4096 Dec  3 11:38 name
drwxr-xr-x 2 root root    0 Dec  3 09:02 power
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm1
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_channels_temp
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point1_pwm
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point1_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point2_pwm
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point2_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point3_pwm
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point3_temp
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point4_pwm
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_auto_point4_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_enable
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm1_freq
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_channels_temp
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point1_pwm
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point1_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point2_pwm
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point2_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point3_pwm
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point3_temp
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point4_pwm
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_auto_point4_temp
-rw-r--r-- 1 root root 4096 Dec  3 11:39 pwm2_enable
-r--r--r-- 1 root root 4096 Dec  3 11:39 pwm2_freq
lrwxrwxrwx 1 root root    0 Dec  3 11:39 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Dec  3 11:39 temp1_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:39 temp1_input
-rw-r--r-- 1 root root 4096 Dec  3 11:39 temp1_max
-rw-r--r-- 1 root root 4096 Dec  3 11:39 temp1_max_hyst
-r--r--r-- 1 root root 4096 Dec  3 11:39 temp2_alarm
-r--r--r-- 1 root root 4096 Dec  3 11:39 temp2_input
-rw-r--r-- 1 root root 4096 Dec  3 11:39 temp2_max
-rw-r--r-- 1 root root 4096 Dec  3 11:39 temp2_max_hyst
--w------- 1 root root 4096 Dec  3 11:39 uevent
-rw-r--r-- 1 root root 4096 Dec  3 09:10 vrm

Kind regards,
Udo

