From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 28 Feb 2006 17:13:40 +0000
Subject: [lm-sensors] No sensors detected on the ASUS K8V-MX motherboard
Message-Id: <440484C4.9010307@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3c456d310602280419w5f5aa2d0qeea498e936814892@mail.gmail.com>
In-Reply-To: <3c456d310602280419w5f5aa2d0qeea498e936814892@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> We have a pending update from Yuan Mu from Winbond, it needs review and
> probably some adjustment. I think I remember Rudolf Marek had been
> working on it, maybe he will be able to provide me with a patch ready
> for inclusion now that he's done with his final exams. If not, you'll
> have to wait for me to have some spare time to handle it, which is not
> right now for sure.

There are some issues and I have already some ideas how to fix that and what to change. I think
I may have some time for this on thursday evening or weekend. Problem is that I must have
physical access to that computer so I can look what a fan is doing ;)

If you want to test it please apply this patches:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-January/015115.html

Please check my  "preliminary - proprietary - confidental - NDA required" comments about the
patches ;) Some things are not working as expected some has problems and I remember I had the problem with the
fan reglation because the automatic one acted somehow strange...

I hope it helps. Please be patient. I'm converting the website to wiki too and I had to review some drivers
and this is quite time eater.

Regards
Rudolf

/sys files
----------

pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in range:
        0 (stop) to 255 (full)
pwm[1-4]_enable - this file controls mode of fan/temperature control:

our iterface specify 0=disable
            * 0 Manual mode
            * 1 Thermal Cruise
            * 2 Fan Speed Cruise
            * 3 Smart FAN III
pwm[1-4]_mode - Select PWM of DC mode
            * 0 DC
            * 1 PWM

For Thermal Cruise mode
------------------------
thermal_cruise[1-4] - Selects the desired temperature for cruise (degC) 0-255? -> wrong limit
tolerance[1-4] - Value in degrees of Celsius (degC) for +- T   limit is 0-15


For Fan speed Cruise mode
------------------------
thermal_cruise[1-4] - Selects desired target speed (limit is 0-255) -> WRONG UNITS USED

what unit is it rotations? or ticks???

tolerance[1-4] - tolerance of desired target speed (limit is 0-15) -> WRONG UNITS USED


SF3
---
Target SF3 temperature should be written to thermal_cruise,
but thermal_cruise2 and thermal_cruise4 is used (regs 0x6 and 0x63)
Tolerance of SF3 (0x7 bit-4-7, +cr62)
but tolerance2 and tolerance4 is used

So this would mean to rename 1->2 and 2->4 to have it sane.

/sys/bus/i2c/devices/9191-0290/sf3_fan_max1  255
/sys/bus/i2c/devices/9191-0290/sf3_fan_max2  255
/sys/bus/i2c/devices/9191-0290/sf3_fan_min1  177
/sys/bus/i2c/devices/9191-0290/sf3_fan_min2  1
/sys/bus/i2c/devices/9191-0290/sf3_fan_step1  1
/sys/bus/i2c/devices/9191-0290/sf3_fan_step2  1
/sys/bus/i2c/devices/9191-0290/sf3_step_time_down  1
/sys/bus/i2c/devices/9191-0290/sf3_step_time_up  1
/sys/bus/i2c/devices/9191-0290/sf3_stop_time1  60
/sys/bus/i2c/devices/9191-0290/sf3_stop_time2  60

sf3_fan_max[1-2]
------------------

When at SMART FANTM III mode, CPUFANOUT0 value will increase to this value. This register should
be written a non-zero value that cannot lower than Stop value.

0-255 is there right now -> 0 is allowed!!!

sf3_fan_min[1-2]
----------------

THIS IS USED ALSO IN THERMAL CRUISE AS BORDER (only for 2 and 4????)


0 is allowed!!!

When at Thermal Cruise mode or SMART FAN TM III mode, CPUFANOUT0-1 value will decrease to this
value. This register should be written a non-zero minimum stop value.

(1)When at PWM output:
The unit of this register is 0.1 second. The default time is 6 seconds.
(2)When at DC Voltage output:
The unit of this register is 0.4 second. The default time is 24 seconds.

sf3_step_time_down
-------------------

This register determines the speed of FANOUT decreasing its value in Smart Fan Control mode.
(1)When at PWM output:
The unit of this register is 0.1 second. The default time is 1 seconds.
(2)When at DC Voltage output:
The unit of this register is 0.4 second. The default time is 4 seconds.


sf3_step_time_up
----------------
This register determines the speed of FANOUT increasing the its value in Smart Fan Control mode.
(1)When at PWM output:
The unit of this register is 0.1 second. The default time is 1 seconds.
(2)When at DC Voltage output:
The unit of this register is 0.4 second. The default time is 4 seconds.



TODO:
Also for the thermal cruise and smartfan STOP VALUE reg (0x15 and others should be implemented)
and start value??? (0xA)

