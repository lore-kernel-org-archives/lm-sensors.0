From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Oct 2009 11:16:03 +0000
Subject: Re: [lm-sensors] Via Epia SP13000 Mobo, virtual device?
Message-Id: <20091016131603.3fdc4c1b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1097a6730910140706q7dcba2a6j73cdbb0784b99c08@mail.gmail.com>
In-Reply-To: <1097a6730910140706q7dcba2a6j73cdbb0784b99c08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Wed, 14 Oct 2009 10:06:20 -0400, Sean Covel wrote:
> Running Ubuntu 9.10 Beta.
> Linux mythbuntu 2.6.31-13-generic #44-Ubuntu SMP Sat Oct 10 15:27:55 UTC
> 2009 i686 GNU/Linux
> sensors version 3.0.2 with libsensors version 3.0.2
> 
> ~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:      -273.2°C  (crit = +60.0°C)
> 
> vt1211-isa-6000
> Adapter: ISA adapter
> +3.3V:       +3.31 V  (min =  +0.00 V, max =  +4.42 V)
> +2.5V:       +2.42 V  (min =  +0.00 V, max =  +3.16 V)
> VCore:       +1.38 V  (min =  +0.00 V, max =  +2.63 V)
> +5V:         +4.46 V  (min =  +0.00 V, max =  +6.31 V)
> +12V:       +11.90 V  (min =  +0.00 V, max = +14.99 V)
> +3.3V:       +3.12 V  (min =  +3.13 V, max =  +3.46 V)   ALARM
> Case Fan:      0 RPM  (min =    0 RPM, div = 2)
> CPU Fan:    3640 RPM  (min =    0 RPM, div = 2)
> CPU Temp:    +36.9°C  (high = +190.1°C, hyst = -77.5°C)
> Int Temp:    +50.0°C  (high = +204.0°C, hyst =  +0.0°C)
> cpu0_vid:   +1.750 V
> 
> The value from acpitz-virtual-0 is abviously bad.

Indeed. It comes from ACPI, so either your BIOS is broken, or there's a
bug somewhere in Linux's ACPI code. You might look for a BIOS upgrade
for your machine.

> Is there a way to get
> sensors to ignore the value?  It's really messing up my Munin monitoring of
> the machine.  I looked around and didn't find any syntax to ignore virtual
> devices in sensors3.conf.

You can't ignore devices, but you can ignore individual inputs. It
works the same for all chips, virtual or not. In you case, this would
read:

chip "acpitz-virtual-0"

   ignore temp1

This should work, please let me know if it doesn't.

This however isn't very aesthetic, as the virtual chip in question will
still be displayed. Maybe we could change this behavior, either in
sensors or directly in libsensors. I'm not totally sure what can be
decided in libsensors and what should be left for applications to decide.

An alternative is to simply specify on the command line which chip you
want to see:

$ sensors "vt1211-*"

But probably it won't help your "Munin monitoring", if it doesn't
provide any option to select which hardware monitoring chip should be
used.

So probably the easiest way to get what you need is to prevent the
ACPI "thermal" driver from loading. Either by blacklisting it or by
removing it from some init script / system configuration file,
depending on your distribution. Beware though that the thermal driver
might be needed for, well, thermal management of your system, so try
this at your own risk and keep an eye on the temperature!

Hope this helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
