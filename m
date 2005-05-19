From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (almost solved)
Message-Id: <200307282251.32627.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030727233434.568d9d4c.khali@linux-fr.org>
In-Reply-To: <20030727233434.568d9d4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne po 28. ?ervence 2003 22:38 jste napsal(a):
> > after reinstall ne1619 driver are values of min/max voltage 0.
> >
> > e.g.
> >
> > +2.5V:     +2.48 V  (min =  +0.00 V, max =  +0.00 V)
>
> My bad, fixed in the attached version. Can you please try again? (No
> need rebooting this time, just unload the old module and load the new
> one instead.)

problem solved ...

> > btw: speed of fan can show lm_sensors with ne1619 too?
>
> Negative on that, it's a 6-voltage 2-temperature chip, period. No fan
> monitoring. I'm surprised too, but that's how it it.

I'm not sure if I understand you. Intel sw can show fan speed, e.g. 
Sensor Name         System Fan 1
Current Value       3 840
Upper Threshold     not applicable
Lower Threshold     500.

Current driver cannot show that or something else? 

> > OK, current values are:
> >
> > alarms 0
> > in0 0.00 0.00 2.48
> > in1 1.40 1.55 1.46
> > in2  0.00 0.00 3.33
> > in3  0.00 0.00 5.02
> > in4  0.00 0.00 0.00
> > in5  0.00 0.00 3.26
> > temp1 0.0 0.0 43.0
> > temp2 0.0 0.0 43.0
> > vid 1.500
> > vrm 9.0

btw:

hippopotamus:/proc/sys/dev/sensors/adm1025-i2c-0-2d# ls
alarms  in0  in1  in2  in3  in4  in5  temp1  temp1  temp2  vid  vrm
hippopotamus:/proc/sys/dev/sensors/adm1025-i2c-0-2d# cat temp1
cat: temp1: nen? adres??em (= temp1 in't directory ...)
temp2 is normal proc file with values ... there are two files "temp1" in this 
directory, but i didn't reboot ...


> Bad of course because of the bug... Oh, please provide the output of
> "sensors" too (almost similar, but much more pleasant to read, isn't
> it).
>
> Thanks!

you're welcome ...

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
+2.5V:     +2.48 V  (min =  +2.23 V, max =  +2.74 V)
VCore:     +1.46 V  (min =  +1.40 V, max =  +1.55 V)
+3.3V:     +3.33 V  (min =  +2.95 V, max =  +3.62 V)
+5V:       +5.02 V  (min =  +4.47 V, max =  +5.49 V)
+12V:      +0.00 V  (min = +10.75 V, max = +13.18 V)
VCC:       +3.26 V  (min =  +2.95 V, max =  +3.62 V)
SYS Temp:  +43.0?C  (min =   +0?C, max =  +60?C)
CPU Temp:  +42.0?C  (min =   +0?C, max =  +60?C)
vid:       +1.50 V

-- 
Ondrej Cecak

