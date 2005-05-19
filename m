From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: [sensors] system slow since ~ 2.6.7
Message-Id: <20041125211941.27eac8f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
	<1101186291.20008.247.camel@d845pe>
	<Pine.LNX.4.60.0411242139090.2319@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0411242139090.2319-J+lI668vivfmY97RW1zN3Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, sensors-8Q/ZecXQGFUZMC/lefXSXFaTQe2KTcn/@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

> (added Andrew to CC as he also answered my original email. Don't know
> if sensors@stimpy.netroedge.com allows non-subscribers)

Yes it does :) Now I hope acpi-devel does too.

> This reminds me: about a year ago my CPU fan burnt down. Then too,
> shortly after booting the PC, it slowed down. Then by accident I
> noticed in BIOS CPU temperature 98 deg C. With a new fan problem
> disappeared.

Wow, 98, no less. You're lucky it didn't catch on fire, you know.

> So, can it be, that the BIOS automatically slows down (throttles) the
> CPU at high temperature.

Yes this is certainly what happens. Blinking power led usually means
that some kinf of thermal or power management is in effect.

> And after ~ 2.6.7 sensors program the sensor 
> interface with some (wrong) coefficient, and then it throttles the CPU
> wrongly?

There were some significant changes to the via686a driver in 2.6.6 and
2.6.7.

2.6.6: Limit initialization was removed from the driver. The same was
done for most other drivers. The limits have to be set by either the
BIOS or user-space, not kernel drivers. Also, chip initialization is now
less agressive (previous version would possibly arbitrarily overwrite
BIOS settings).

2.6.7: Conversion formulas were reworked for a better accuracy. Errors
were previously introduced by incorrect rounding.

I think that the changes in 2.6.6 are the ones affecting you.

> Yes, some coefficients are definitely wrong. Here are a
> couple of snapshots:
> 
> via686a-isa-e200
> Adapter: ISA adapter
> CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
> +2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
> I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
> +5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
> +12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
> CPU Fan:  5443 RPM  (min =    0 RPM, div = 2)          
> P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
> SYS Temp:  +45.4 C  (high =   +45 C, hyst =   +40 C)   ALARM
> CPU Temp:  +34.5 C  (high =   +60 C, hyst =   +55 C)   
> SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   

Blame your BIOS! It did not properly configure voltage limits, among
others. BTW, Vcore, +2.5V and +12V look awfully wrong anyway. I/O and
+5V are acceptable but even +5V is a bit too high IMHO. Never heard of
your motherboard model before, seems to be a rare one. Maybe Asus didn't
put much support on it. 

Notice the ALARM in SYS Temp, which is probably causing the system to
throttle.

> via686a-isa-e200
> Adapter: ISA adapter
> CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
> +2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
> I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
> +5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
> +12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
> CPU Fan:  5487 RPM  (min =    0 RPM, div = 2)          
> P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
> SYS Temp:  +45.2 C  (high =   +91 C, hyst =   +40 C)   ALARM
> CPU Temp:  +34.4 C  (high =   +60 C, hyst =   +55 C)   
> SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   
> 
> Notice how SYS Temp high changed...

Did it change *on its own*? Weird. Note that 91 = 45 << 1 + 1. I wonder
if it could be some kind of read error. Will the value change 

> Can my guesses be correct and how can the situation be fixed?

Pick the latest default configuration file for sensors here:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/etc/sensors.conf.eg
Save as /etc/sensors.conf, edit the via686a-* section, especially the
"set temp1_high" and set temp1_hyst" values. I'd suggest:

    set temp1_hyst 55
    set temp1_over 60

Save the changes and run "sensors -s". Your system should hopefully be
back to full speed right after that. So all you have to do is make sure
that "sensors -s" is called after you load the via686a driver at boot
time.

You should take a look at the hardware monitoring options in your BIOS
setup screen if it has any. Maybe you can configure the boot value of
temp1_high directly there, and it may provide hints about voltages as
well.

-- 
Jean Delvare
http://khali.linux-fr.org/
