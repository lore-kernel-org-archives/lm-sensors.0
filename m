From: 2crazy4you@gmx.de (slompf)
Date: Sat, 11 Nov 2006 22:39:39 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <1163284779.5555.34.camel@armageddon>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

I'm trying to reduce the speed of a cpu fan on a k8n-vm. The chip is for
controlling the temp is a winbond w83627ehf. My kernel is 2.6.18.2.
lm-sensors seems to work correctly, because on the 'sensors' command I'm
getting the following output:

w83627ehf-isa-0290
Adapter: ISA adapter
Case Fan:  888 RPM  (min = 1205 RPM, div = 8)
CPU Fan:  2109 RPM  (min = 1704 RPM, div = 8)
fan3:        0 RPM  (min =   45 RPM, div = 128)
fan4:        0 RPM  (min = 10546 RPM, div = 128)
Sys Temp:    +28?C  (high =   +45?C, hyst =   +40?C)  
CPU Temp:  +23.0?C  (high = +45.0?C, hyst = +40.0?C)  
temp3:     +25.0?C  (high = +80.0?C, hyst = +75.0?C)  

Now the first question: I thought support for the voltage inputs was
added at one of the last kernels. Is that correct? 

Now the PROBLEM: After calling pwmconfig (which seems to be the tool for
configuring fancontrol) I'm getting this output:

/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed

After checking this script, it became clear that it needs something
called pwm.. or fan.._pwm in the /sys/bus/i2c/devices/9191-0290
directory. ls does only show that: 

bus         fan2_div    fan4_alarm    in0_max    in2_input  in4_alarm
in5_min    in7_max    in9_input    temp1_input     temp3_alarm
driver      fan2_input  fan4_div      in0_min    in2_max    in4_input
in6_alarm  in7_min    in9_max      temp1_max       temp3_input
fan1_alarm  fan2_min    fan4_input    in1_alarm  in2_min    in4_max
in6_input  in8_alarm  in9_min      temp1_max_hyst  temp3_max
fan1_div    fan3_alarm  fan4_min      in1_input  in3_alarm  in4_min
in6_max    in8_input  name         temp2_alarm     temp3_max_hyst
fan1_input  fan3_div    hwmon:hwmon0  in1_max    in3_input  in5_alarm
in6_min    in8_max    power        temp2_input     uevent
fan1_min    fan3_input  in0_alarm     in1_min    in3_max    in5_input
in7_alarm  in8_min    subsystem    temp2_max
fan2_alarm  fan3_min    in0_input     in2_alarm  in3_min    in5_max
in7_input  in9_alarm  temp1_alarm  temp2_max_hyst

Next question: where are my pwm entries? The in_... where printed first,
after I compiled the new kernel. (2.6.17->2.6.18) Is the pwm function
not supported for this chipset in the above mentioned kernel?

Maybe you guys can give some general information about the status of the
chipset. Whats supported by which kernel and what is planned and what is
not. That would be quiet helpful. Maybe there is a document more
detailed than that: http://www.lm-sensors.org/wiki/Devices?

Kind Regards
Torsten


