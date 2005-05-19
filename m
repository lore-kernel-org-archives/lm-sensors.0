From: james.leddy@binghamton.edu (James M Leddy)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: Cant access procfs: lm-sensors-2.8.6 linux-2.6.7-gentoo-r11
Message-Id: <20040728052617.GC19653@ool-44c29dc9.dyn.optonline.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried to create a ticket, but I couldn't locate it after I created it.

I used to use old userspace tools with my 2.6.* kernel.  When updating to 
2.6.5, I noticed that I would need the newer lm_sensors 2.8.6.  I tried to
change as little as possible in the transition, and I compiled the i2c modules
for the new kernel as expected.

Here are the modules that I have loaded (based on advice from sensors-detect):

root / # lsmod
Module                  Size  Used by
via686a                21256  0 
w83781d                36224  0 
i2c_isa                 3072  0 
i2c_viapro              8204  0 
i2c_sensor              4096  2 via686a,w83781d
i2c_core               24836  5 via686a,w83781d,i2c_isa,i2c_viapro,i2c_sensor

root / # sensors
as99127f-i2c-4-48
Adapter: SMBus Via Pro adapter at e800
ERROR: Can't get alarm data!
ERROR: Can't get beep data!
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get IN6 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get VID data!
alarms:   
ERROR: Can't get BEEP data!

as99127f-i2c-4-49
Adapter: SMBus Via Pro adapter at e800
ERROR: Can't get alarm data!
ERROR: Can't get beep data!
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get IN6 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get VID data!
alarms:   
ERROR: Can't get BEEP data!

as99127f-i2c-4-2d
Adapter: SMBus Via Pro adapter at e800
ERROR: Can't get IN0 data!
ERROR: Can't get IN1 data!
ERROR: Can't get IN2 data!
ERROR: Can't get IN3 data!
ERROR: Can't get IN4 data!
ERROR: Can't get IN5 data!
ERROR: Can't get IN6 data!
ERROR: Can't get FAN1 data!
ERROR: Can't get FAN2 data!
ERROR: Can't get FAN3 data!
ERROR: Can't get TEMP1 data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!
ERROR: Can't get VID data!

As you can probably see from this ticket, I am having trouble with sensors -s.

root / # strace sensors -s 
..Some output left out...
open("/sys/bus/i2c/devices/4-0048/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0048/in_min0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0048/in_max0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0048/in_min1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0048/in_max1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_min2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_max2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_min3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_max3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_min4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_max4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_max5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_min5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_max6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0048/in_min6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
write(2, "as99127f-i2c-4-48: Can\'t access "..., 63as99127f-i2c-4-48: Can't access procfs/sysfs file for writing;
) = 63
write(2, "Run as root?\n", 13Run as root?
)          = 13
open("/sys/bus/i2c/devices/4-0049/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0049/in_min0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0049/in_max0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0049/in_min1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-0049/in_max1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_min2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_max2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_min3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_max3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_min4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_max4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_max5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_min5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_max6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-0049/in_min6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
write(2, "as99127f-i2c-4-49: Can\'t access "..., 63as99127f-i2c-4-49: Can't access procfs/sysfs file for writing;
) = 63
write(2, "Run as root?\n", 13Run as root?
)          = 13
open("/sys/bus/i2c/devices/4-002d/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-002d/in_min0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-002d/in_max0", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-002d/in_min1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/vid", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/4-002d/in_max1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_min2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_max2", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_min3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_max3", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_min4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_max4", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_max5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_min5", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_max6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/4-002d/in_min6", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
write(2, "as99127f-i2c-4-2d: Can\'t access "..., 63as99127f-i2c-4-2d: Can't access procfs/sysfs file for writing;
) = 63
write(2, "Run as root?\n", 13Run as root?
)          = 13
_exit(1)                                = ?

I have noticed myself that I can't even create these files, for I, even as root, am denied access.  There are a few files in these directories, some even had similar names

root devices # ls 4-0049/ 4-0048/ 4-002d/
4-002d/:
alarms        fan2_min         in1_input  in4_max    temp1_input
beep_enable   fan2_pwm         in1_max    in4_min    temp1_max
beep_mask     fan2_pwm_enable  in1_min    in5_input  temp1_max_hyst
detach_state  fan3_div         in2_input  in5_max    temp2_input
fan1_div      fan3_input       in2_max    in5_min    temp2_max
fan1_input    fan3_min         in2_min    in6_input  temp2_max_hyst
fan1_min      in0_input        in3_input  in6_max    temp3_input
fan1_pwm      in0_max          in3_max    in6_min    temp3_max
fan2_div      in0_min          in3_min    name       temp3_max_hyst
fan2_input    in0_ref          in4_input  power      vrm

4-0048/:
detach_state  name  power

4-0049/:
detach_state  name  power

I hope someone can point me to the source of the problem.  Thanks in advance for your help

-- 
James M Leddy
