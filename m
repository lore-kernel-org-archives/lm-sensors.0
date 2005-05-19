From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: problem with it87.o
Message-Id: <20030816150711.7674389c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> it87-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5100
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.64 V  (min =  +1.53 V, max =  +1.87 V)
> VCore 2:   +1.50 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
> +3.3V:     +3.36 V  (min =  +1.48 V, max =  +1.80 V)   ALARM
> +5V:       +5.11 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +11.44 V  (min = +11.36 V, max = +13.80 V)   ALARM
> -12V:     -21.15 V  (min = -15.86 V, max = -13.40 V)   ALARM
> -5V:       -6.45 V  (min = -10.13 V, max =  -9.44 V)   ALARM
> Stdby:     +5.11 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.21 V
> fan1:     5192 RPM  (min = 3000 RPM, div = 2)
> fan3:     3648 RPM  (min = 3000 RPM, div = 2)
> Temp1/MB:    +37?C  (min =  +20?C, max =  +60?C)
> Temp2/CPU:   +40?C  (min =  +20?C, max =  +60?C)
> Temp3:       +38?C  (min =  +20?C, max =  +60?C)

Many alarms there :(

> For some reason sensors says the minimum fan speed is 3000, even
> though i specified 1400 in /etc/sensors.conf

I suspect you never ran "sensors -s", did you?

I think your problem is that some values we initialize as the driver is
loaded are wrong for you, and make your chipset goes mad and think your
computer is on fire ;) I don't know if this is only the voltages above,
or if there is something else. Could you give us what the alarms file
(somewhere in /proc/sys/dev/sensors/) contains?

Note that I'll be off for a week so the follow up is left to the other
folks on this list. Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
