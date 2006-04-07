From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 07 Apr 2006 19:32:11 +0000
Subject: [lm-sensors] hwmon/pc87360 as a platform driver
Message-Id: <4436BE3B.7090306@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi folks,

Ive just made a rough pass thru pc87360, and have converted it
to a non-working, but non-crashing platform_driver that does
at least a little of what it should:

soekris:~# modprobe pc87360
[  964.952000] pc87360: Device 0x09 not activated
[  966.576000] pc87360 pc87360.26144: VLM conversion set to 1s period, 
160us delay
soekris:~#


soekris:~# ls /sys/bus/platform/devices/pc87360.26144/
alarms_in      in1_input   in4_min     in8_input     temp2_input   
temp5_crit
alarms_temp    in1_max     in4_status  in8_max       temp2_max     
temp5_input
bus@           in1_min     in5_input   in8_min       temp2_min     temp5_max
cpu0_vid       in1_status  in5_max     in8_status    temp2_status  temp5_min
driver@        in2_input   in5_min     in9_input     temp3_crit    
temp5_status
hwmon:hwmon0@  in2_max     in5_status  in9_max       temp3_input   
temp6_crit
in0_input      in2_min     in6_input   in9_min       temp3_max     
temp6_input
in0_max        in2_status  in6_max     in9_status    temp3_min     temp6_max
in0_min        in3_input   in6_min     temp1_crit    temp3_status  temp6_min
in0_status     in3_max     in6_status  temp1_input   temp4_crit    
temp6_status
in10_input     in3_min     in7_input   temp1_max     temp4_input   uevent
in10_max       in3_status  in7_max     temp1_min     temp4_max     vrm
in10_min       in4_input   in7_min     temp1_status  temp4_min
in10_status    in4_max     in7_status  temp2_crit    temp4_status


soekris:~# ll /sys/bus/platform/drivers/pc87360/
total 0
--w------- 1 root root 4096 Apr  7 12:08 bind
lrwxrwxrwx 1 root root    0 Apr  7 12:08 module -> 
../../../../module/pc87360/
lrwxrwxrwx 1 root root    0 Apr  7 12:08 pc87360.26144 -> 
../../../../devices/platform/pc87360.26144/
--w------- 1 root root 4096 Apr  7 12:08 unbind



so far so good, but:

soekris:~# sensors -s
No sensors found!
soekris:~#
soekris:~# sensors
No sensors found!


my libsensors is unstable debian package:  libsensors 1:2.10.0-3
That version number looks to contain 2.10.0

Frankly, Im hoping that with 2.10, the user-side just works, but this is 
not the case here.

Any guesses / suggestions as to whats wrong ?
Im continuiing to look at the kernel-side (Im sure Ive got multiple errs 
in there)
Im hoping for some user-side-fu for free ;-)


for anyone reading along, this is a perfect ref:
    
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015180.html

given the wider staging issues, this is arguably a later/lower priority.


tia
jimc

