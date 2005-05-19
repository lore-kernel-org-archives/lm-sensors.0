From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: sensord 2.8.2 on 2.6.0/ASUS chip - subclient problem
Message-Id: <200401111319.18817.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sensord startup fails due to the fact that it tries to read alarms for ASUS 
as99127f subclient that are not available; sensors itself works OK:

Jan 11 13:06:40 localhost sensord: sensord started
Jan 11 13:06:40 localhost sensord: Error getting sensor data: as99127f/#81: 
Can't access /proc file
Jan 11 13:06:40 localhost sensord: sensord failed

strace sensord ...
..
open("/sys/bus/i2c/devices/0-0048/alarms", O_RDONLY) = -1 ENOENT (No such file 
or directory)

{pts/1}% LC_ALL=C lr /sys/bus/i2c/devices/*/
/sys/bus/i2c/devices/0-002d/:
alarms     beep_enable  beep_mask    detach_state  fan_div1     fan_div2
fan_div3   fan_input1   fan_input2   fan_input3    fan_min1     fan_min2
fan_min3   in_input0    in_input1    in_input2     in_input3    in_input4
in_input5  in_input6    in_max0      in_max1       in_max2      in_max3
in_max4    in_max5      in_max6      in_min0       in_min1      in_min2
in_min3    in_min4      in_min5      in_min6       name         power/
pwm1       pwm2         pwm_enable2  temp_input1   temp_input2  temp_input3
temp_max1  temp_max2    temp_max3    temp_min1     temp_min2    temp_min3
vid        vrm

/sys/bus/i2c/devices/0-002d/power:
state

/sys/bus/i2c/devices/0-0048/:
detach_state  name  power/

/sys/bus/i2c/devices/0-0048/power:
state

/sys/bus/i2c/devices/0-0049/:
detach_state  name  power/

/sys/bus/i2c/devices/0-0049/power:
state

{pts/1}% sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Unavailable from sysfs
VCore 1:   +1.70 V  (min =  +1.57 V, max =  +1.73 V)
+3.3V:     +3.47 V  (min =  +3.14 V, max =  +3.49 V)
+5V:       +5.00 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.37 V  (min = +10.82 V, max = +13.19 V)
-12V:     -11.57 V  (min = -13.22 V, max = -10.74 V)       ALARM
-5V:       -5.03 V  (min =  -5.25 V, max =  -4.74 V)       ALARM
CPU:      4787 RPM  (min = 3000 RPM, div = 2)
Front:    2909 RPM  (min = 2657 RPM, div = 2)
MB:          +29?C  (high =   +50?C, hyst =   +45?C)
CPU:       +36.5?C  (high =   +65?C, hyst =   +70?C)
HDD:       +39.0?C  (high =   +45?C, hyst =   +50?C)
vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm enabled

I do not know if it is a sensord (should not attempt to read subclient) or 
kernel (does not provide sufficient information) problem. Subclient can be 
determined by its name:

{pts/1}% for i in /sys/bus/i2c/devices/*
do
echo ${i:t}:$(<$i/name)
done
0-002d:as99127f
0-0048:as99127f subclient
0-0049:as99127f subclient

Greg, this is supposed to be established convention now?

regards

-andrey

