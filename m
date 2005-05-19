From: j.ellerbroek@student.tudelft.nl (Joost Ellerbroek)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: problem with it87.o
Message-Id: <200308161455.03758.j.ellerbroek@student.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi

The module is loaded at boottime (from /etc/modules), so i don't think sensors 
-s causes the spinup. Also, after the module is loaded, the fan speed doesn't 
go down anymore, even when i unload it87.o!
There are three temperature sensors on board, all of the thermistor type,
so i use temp_type=0x38. I've tried the default too, and i've tried reloading 
the module with all the other possible flags. None made the speed go down.

the output of 'sensors' is as follows: (with temp_type=0x38)

it87-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5100
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.64 V  (min =  +1.53 V, max =  +1.87 V)
VCore 2:   +1.50 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
+3.3V:     +3.36 V  (min =  +1.48 V, max =  +1.80 V)   ALARM
+5V:       +5.11 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.44 V  (min = +11.36 V, max = +13.80 V)   ALARM
-12V:     -21.15 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -6.45 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +3.21 V
fan1:     5192 RPM  (min = 3000 RPM, div = 2)
fan3:     3648 RPM  (min = 3000 RPM, div = 2)
Temp1/MB:    +37?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:   +40?C  (min =  +20?C, max =  +60?C)
Temp3:       +38?C  (min =  +20?C, max =  +60?C)

For some reason sensors says the minimum fan speed is 3000, even though i 
specified 1400 in /etc/sensors.conf

i hope this info helps,

Joost

On Saturday 16 August 2003 14:20, you wrote:
> > I've got a small bugreport for the it87 driver.
> > The driver loads fine, and i get normal readings afterwards, but as
> > soon as the driver loads, my cpu fan gears up to it's maximum rpm,
> > even though the temperature is still low enough.
> >
> > I have a shuttle sn41g2 pc, with the nforce2 chipset. The board
> > supports variable fan speeds, it monitors cpu temperature, and sets
> > fan speed accordingly. Up to the point where i load the it87 module
> > that is :)
> >
> > I'm running kernel 2.4.20, i2c and lm-sensors version 2.8.0
> > bios version fn41s019. Should you need more info just ask.
>
> Does the fan keep a high speed for always, or does is goes down after
> some times?
>
> Does the "sensors" program report any alarm? (a "cat" on the alarms file
> could help too)
>
> Can you confirm the fan speedup is caused by loading the driver, and not
> by running "sensors -s"? (Many scripts will do both in a row.)
>
> Does using the temp_type parameter with various values (read
> doc/chips/it87) have any influence (except giving very bad temperatures)
> on the fan speed?
