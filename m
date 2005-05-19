From: j.ellerbroek@student.tudelft.nl (Joost Ellerbroek)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: problem with it87.o
Message-Id: <200308161521.26420.j.ellerbroek@student.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ah, sensors -s initialises the config as specified in /etc/sensors.conf :)
that takes care of one alarm (+3.3v)

cat /proc/sys/dev/sensors/it87-i2c-1-2d/alarms returns:
26130

it87-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5100
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.64 V  (min =  +1.42 V, max =  +1.56 V)   ALARM
VCore 2:   +1.50 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.11 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +11.44 V  (min = +11.36 V, max = +12.60 V)
-12V:     -21.15 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -6.45 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +5.11 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.21 V
fan1:     5192 RPM  (min = 2657 RPM, div = 2)
fan3:     3648 RPM  (min = 2657 RPM, div = 2)
Temp1/MB:    +36?C  (min =  +20?C, max =  +40?C)
Temp2/CPU:   +39?C  (min =  +25?C, max =  +45?C)
Temp3:       +39?C  (min =  +25?C, max =  +45?C)

When i rebooted, my BIOS provided the following values:
CPU Voltage:		1.63V
AGP				1.50V
3.3V				3.36V
+5V				5.13V
+12V				11.39V
-12V				(-)13.26V
Chipset			1.66V
5V SBVIN			5.13V
Battery			3.16V
Sys Temperature	39 C
CPU				45 C
PWM			42 C
Fan 1			5443 RPM
Fan 3			1985 RPM


On Saturday 16 August 2003 15:07, you wrote:
> > it87-i2c-1-2d
> > Adapter: SMBus nForce2 adapter at 5100
> > Algorithm: Non-I2C SMBus adapter
> > VCore 1:   +1.64 V  (min =  +1.53 V, max =  +1.87 V)
> > VCore 2:   +1.50 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> > +3.3V:     +3.36 V  (min =  +1.48 V, max =  +1.80 V)   ALARM
> > +5V:       +5.11 V  (min =  +4.50 V, max =  +5.48 V)
> > +12V:     +11.44 V  (min = +11.36 V, max = +13.80 V)   ALARM
> > -12V:     -21.15 V  (min = -15.86 V, max = -13.40 V)   ALARM
> > -5V:       -6.45 V  (min = -10.13 V, max =  -9.44 V)   ALARM
> > Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
> > VBat:      +3.21 V
> > fan1:     5192 RPM  (min = 3000 RPM, div = 2)
> > fan3:     3648 RPM  (min = 3000 RPM, div = 2)
> > Temp1/MB:    +37?C  (min =  +20?C, max =  +60?C)
> > Temp2/CPU:   +40?C  (min =  +20?C, max =  +60?C)
> > Temp3:       +38?C  (min =  +20?C, max =  +60?C)
>
> Many alarms there :(
>
> > For some reason sensors says the minimum fan speed is 3000, even
> > though i specified 1400 in /etc/sensors.conf
>
> I suspect you never ran "sensors -s", did you?
>
> I think your problem is that some values we initialize as the driver is
> loaded are wrong for you, and make your chipset goes mad and think your
> computer is on fire ;) I don't know if this is only the voltages above,
> or if there is something else. Could you give us what the alarms file
> (somewhere in /proc/sys/dev/sensors/) contains?
>
> Note that I'll be off for a week so the follow up is left to the other
> folks on this list. Good luck.
