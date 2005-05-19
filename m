From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (almost solved)
Message-Id: <200307282349.12077.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030727233434.568d9d4c.khali@linux-fr.org>
In-Reply-To: <20030727233434.568d9d4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne po 28. cervence 2003 23:24 jste napsal(a):
> > > > btw: speed of fan can show lm_sensors with ne1619 too?
> > >
> > > Negative on that, it's a 6-voltage 2-temperature chip, period. No
> > > fan monitoring. I'm surprised too, but that's how it it.
> >
> > I'm not sure if I understand you. Intel sw can show fan speed, e.g.
> > Sensor Name         System Fan 1
> > Current Value       3 840
> > Upper Threshold     not applicable
> > Lower Threshold     500.
> >
> > Current driver cannot show that or something else?
>
> Not the driver, but the *chipset* doesn't even know about them. Don't
> hit me! I'm only the messenger ;)
>
> Intel must get their information from somewhere else. Possibilities are:
> another bus driver we don't support yet (unlikely), another chip on the
> first bus (unlikely again, the only unknown one is that thing at 0x44
> and I still believe it looks like an EEPROM; I could be wrong of course;
> does the fan speed value sometimes change with that Linux software? if
> yes the data at 0x44 would have to move the same way too, and you say it
> didn't) or non-I2C chip (could be ACPI; is your system ACPI-compliant?
> did you ever try enabling ACPI in your kernel, using the bug ACPI
> patch?)

all right, I don't know situation about sensors, chips and ...
fan speed isn't important value, temperature of CPU was my problem ;-)

fan speed isn't constantly, but data at 0x44 is.

ACPI from current Marcelo's kernel (2.4.21) don't work, I'm curious to new 
ACPI in kernel 2.4.x (maybe 22, but evidently 23) ...

> > btw:
> >
> > hippopotamus:/proc/sys/dev/sensors/adm1025-i2c-0-2d# ls
> > alarms  in0  in1  in2  in3  in4  in5  temp1  temp1  temp2  vid  vrm
> > hippopotamus:/proc/sys/dev/sensors/adm1025-i2c-0-2d# cat temp1
> > cat: temp1: nen? adres??em (= temp1 in't directory ...)
> > temp2 is normal proc file with values ... there are two files "temp1"
> > in this directory, but i didn't reboot ...
>
> I think I remember something similar some times ago (see:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket85) but it is
> supposed to be fixed. Just in case, is any part of the I2C subsystem or
> device drivers hard-compiled into your kernel?

no, just modules.

> > (later) this problem solved reboot system ... sorry for useless
> > messages :o(
>
> Not useless at all. I don't like the idea you had to reboot your system
> to get rid of the problem. Didn't you forget to unload the old module
> before reloading the new one?

You're right, this "windows reboot tactics" are bad, but I had to reboot to 
windows, because I had to find something in windows closed source program.

> I'd like you to try unloading the adm1025 module, and check in /proc if
> the entries have really gone. Then reload it and check if the entries
> are back for good, and one of each kind only. If you can reproduce the
> problem, we'll try to fix it.

It works perfectly. Maybe I made mistake, becase ran gkrellm made Oops ... I 
detected it after I mailed you. 

> > adm1025-i2c-0-2d
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > +2.5V:     +2.48 V  (min =  +2.23 V, max =  +2.74 V)
> > VCore:     +1.46 V  (min =  +1.40 V, max =  +1.55 V)
> > +3.3V:     +3.33 V  (min =  +2.95 V, max =  +3.62 V)
> > +5V:       +5.02 V  (min =  +4.47 V, max =  +5.49 V)
> > +12V:      +0.00 V  (min = +10.75 V, max = +13.18 V)
> > VCC:       +3.26 V  (min =  +2.95 V, max =  +3.62 V)
> > SYS Temp:  +43.0?C  (min =   +0?C, max =  +60?C)
> > CPU Temp:  +42.0?C  (min =   +0?C, max =  +60?C)
> > vid:       +1.50 V
>
> The limits are still a bit too low, probably a common rounding issue,
> I'll take a look at it tomorrow (and probably ask you to test then, if
> you don't mind).

with pleasure, but in Czech Republic is now 23:49 ;-))))

-- 
Ondrej Cecak

