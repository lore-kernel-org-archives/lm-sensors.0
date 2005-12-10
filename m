From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 10 Dec 2005 02:22:05 +0000
Subject: [lm-sensors] [PLUG] lm_sensors and fan speed
Message-Id: <20051210022205.GB975@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051209165101.GA23690@jupiter.solarsys.private>
In-Reply-To: <20051209165101.GA23690@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Art:

Please don't strip the lm-sensors list from the CC's.

> Mark M. Hoffman wrote:
> >Be more specific please.  Output from 'uname -a' will suffice.
> >
> >[I ask this because there has been a lot of w83627hf driver work recently -
> >for 2.6 kernels this happens in mainline (as opposed to lm_sensors CVS).]

* Art Alexion <art.alexion at verizon.net> [2005-12-09 13:36:48 -0500]:
> 2.6.10-6-386

OK, that's quite old as far as the relevant driver is concerned.  There are at
least two patches since 2.6.12 that I think might solve it.  But you won't need
to rebuild a kernel to find out.  Just add this line to /etc/modules.conf:

	options w83627hf init=0

Unfortunately, it will take a reboot for this to take effect.  (The driver
already overwrote whatever BIOS inits were performed, the only way to get
them back is to "run" the BIOS.)

I suggest the init=0 module option because it will make your (older) version
of the driver behave more like the default of the latest version - especially
with respect to the two patches that I think might solve it.

Or, you could just upgrade your kernel to something like 2.6.14 or later.

> Mark M. Hoffman wrote:
> >OK, could you please send the output of 'sensors'.

* Art Alexion <art.alexion at verizon.net> [2005-12-09 13:36:48 -0500]:
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.65 V  (min =  +1.62 V, max =  +1.79 V)
> VCore 2:   +1.50 V  (min =  +1.62 V, max =  +1.79 V)
> +3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.95 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)
> -12V:     -12.03 V  (min = -13.18 V, max = -10.80 V)
> -5V:       +3.54 V  (min =  -5.25 V, max =  -4.75 V)
> V5SB:      +5.48 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.23 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     5532 RPM  (min = 18243 RPM, div = 2)              ALARM
> fan2:        0 RPM  (min = 8766 RPM, div = 2)
> fan3:        0 RPM  (min = 4299 RPM, div = 2)
> temp1:       +31?C  (high =    +4?C, hyst =  +119?C)   sensor > thermistor   ALARM
> temp2:     +26.0?C  (high =   +80?C, hyst =   +75?C)   sensor > diode         
> temp3:     +61.5?C  (high =   +80?C, hyst =   +75?C)   sensor > thermistor    
> vid:      +1.700 V  (VRM Version 8.2)
> alarms:
> beep_enable:
>           Sound alarm disabled
> 
> eeprom-i2c-0-51
> Adapter: SMBus I801 adapter at 0540
> Memory type:            SDR SDRAM DIMM
> Memory size (MB):       64
> 
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at 0540
> Memory type:            SDR SDRAM DIMM
> Memory size (MB):       256

> Mark M. Hoffman wrote:
> >One more question... does your BIOS have any kind of automatic fan controls?

* Art Alexion <art.alexion at verizon.net> [2005-12-09 13:36:48 -0500]:
> Nothing that seems configurable from the CMOS setup screens.

> Mark M. Hoffman wrote:
> >They are usually on the same BIOS screen that shows temperatures.

* Art Alexion <art.alexion at verizon.net> [2005-12-09 13:36:48 -0500]:
> I think my BIOS is older and without such screens.

Other questions: does 'sensors -s' appear anywhere in your init scripts?

Are you happy with the output of 'sensors', or do you want to dive into
its config a bit to get better info?  If you're only interested in CPU
temperature via some KDE program, then what you have is good enough.

PS: I'll be AFK Sat 10th, able to reply again 11th

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


