From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Dec 2009 09:35:35 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091214103535.48ea0884@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Sun, 13 Dec 2009 19:55:58 -0500 (EST), Sean Fidler wrote:
> On Sat, 5 Dec 2009, Jean Delvare wrote:
> 
> > Hi Sean,
> >
> > On Wed, 2 Dec 2009 14:55:37 -0500 (EST), Sean Fidler wrote:
> >> Sensors output:
> >>
> >> smsc47m192-i2c-0-2d
> >> Adapter: SMBus I801 adapter at 1880
> >> +2.5V:       +0.00 V  (min =  +2.90 V, max =  +2.90 V)   ALARM
> >> VCore:       +0.00 V  (min =  +2.99 V, max =  +2.99 V)   ALARM
> >> +3.3V:       +0.00 V  (min =  +4.38 V, max =  +4.35 V)   ALARM
> >> +5V:         +0.00 V  (min =  +6.64 V, max =  +6.64 V)   ALARM
> >> +12V:        +3.12 V  (min = +15.81 V, max = +15.88 V)   ALARM
> >> VCC:         +3.35 V  (min =  +4.38 V, max =  +3.83 V)   ALARM
> >> +1.5V:       +0.05 V  (min =  +1.49 V, max =  +1.99 V)   ALARM
> >> +1.8V:       +0.00 V  (min =  +2.39 V, max =  +2.39 V)   ALARM
> >> Chip Temp:   +34.0°C  (low  = -17.0°C, high =  -1.0°C)  ALARM
> >> CPU Temp:    +28.0°C  (low  =  -1.0°C, high = -33.0°C)  ALARM
> >> Sys Temp:      FAULT  (low  = -65.0°C, high =  -1.0°C)  ALARM
> >> cpu0_vid:   +1.475 V
> >
> > Not many inputs wired, and the min voltage and high temperature limits
> > are pretty wrong, but other than that it's not too bad, except for
> > +12V. Do the temperature values appear to match anything you've seen in
> > the BIOS?
> 
> The CPU temperature in the BIOS is 35 and the CPU temperature shown by 
> "sensors" is 31. The "sensors" reading for Chip Temp is closer to what 
> the BIOS shows, 34 degrees.

The BIOS and "sensors" temperatures for the CPU aren't expected to
match exactly, because often the BIOS stands in a busy loop (waiting
for keys to be pressed) which keeps the CPU busy and thus hot.

And actually... reading the SMSC LPC47M192's datasheet again, it
happens that temp1 is internal to that chip. Which means that temp2 has
to be the CPU temperature.

> >> smsc47m1-isa-0600
> >> Adapter: ISA adapter
> >> fan1:       2925 RPM  (min = 2560 RPM, div = 2)  ALARM
> >> fan2:          0 RPM  (min = 3072 RPM, div = 4)  ALARM
> >
> > Looks reasonable. Only one fan on this system? If there are more, you
> > can try increasing fan2_div to 8 if the other fan is a slow one. I
> > guess that the first ALARM wears off when running "sensors" again? 2925
> > is above the min limit so there should be no ALARM.
> 
> There's one fan.

OK, good.

> ALARM show up most of the time.

This is odd and unexpected, but I am not too familiar with the smsc47m1
driver. A quick look at the code did not reveal anything obviously
incorrect.

> > (...)
> > Needs to be confirmed:
> > * What is wired on in4.
> 
> I don't know how to find out this information.

It might be difficult, especially if the BIOS doesn't display anything.
Is the reported value stable? With a voltage like that, it could be the
battery. Without help from Compaq, it will be difficult to come to a
conclusion.

> > * Temperature input labels.
> 
> Clarify, please.

Whether CPU temp was temp1 or temp2, but already clarified above.

> > * Whether cpu0_vid is real. What CPU is there on this machine?
> 
> CPU: Intel Celeron 2.4GHz, 400MHz (Willamette, Northwood according to HP 
> http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?objectID=bph07813)

HP is probably right, the fastest Willamette-based Celeron was running
at 1.8 GHz.

The good news is that 1.475V is a valid Vcore for your CPU, which
suggests that cpu0_vid is correct.

> > * Which fan is connected to fan1.
> 
> This is the CPU fan.
> 
> > * Is there anything connected to fan2.
> 
> Nothing connected.

OK.

I've created the following config:
http://www.lm-sensors.org/wiki/Configurations/Compaq/Presario-S4000NX

Let me know if you think it needs changes.

> > (...)
> > I've put a modified smsc47m1 driver here:
> > http://khali.linux-fr.org/devel/misc/smsc47m1/
> >
> > I would like you to download it and test it. With that driver, you
> > should no longer have to do the isaset magic at boot time. It include
> > other changes which should hopefully be transparent to you if I didn't
> > mess up.
> >
> > This is a standalone driver, you'll need a proper build environment
> > (install make, gcc and the kernel headers) then type "make" then load
> > the driver (with insmod.)
> 
> Fans are now controlled at startup. Any test I should run?

If the driver is working fine, that's great. Please test that you are
able to unload and reload it. I would also appreciate if you could
report the contents of /proc/ioports while the driver is loaded.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
