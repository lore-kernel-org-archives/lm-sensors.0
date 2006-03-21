From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Mar 2006 21:46:10 +0000
Subject: [lm-sensors] lm87 on kernel 2.6.9: kinda-sorta working. What
Message-Id: <20060321224610.d4d43f25.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603211249.43224.swsnyder@insightbb.com>
In-Reply-To: <200603211249.43224.swsnyder@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

> Thanks for the advice.  With the lm87.c from kernel v2.6.12 and 
> lm_sensors v2.8.8 the output is vastly improved.  Now it looks like this:
> 
> # sensors
> lm87-i2c-0-2e
> Adapter: SMBus PIIX4 adapter at 0580
> VCore:     +1.43 V  (min =  +0.98 V, max =  +2.00 V)
> +3.3V:     +3.32 V  (min =  +2.99 V, max =  +3.51 V)
> +5V:       +5.03 V  (min =  +4.50 V, max =  +5.52 V)
> +12V:     +12.12 V  (min = +10.00 V, max = +13.00 V)
> CPU Fan:  5153 RPM  (min = 2848 RPM, div = 2)
> fan2:     5114 RPM  (min = 2848 RPM, div = 2)
> M/B Temp:    +34?C  (low  =    +0?C, high =   +50?C)
> CPU Temp:    +37?C  (low  =    +0?C, high =   +85?C)
> temp3:       +37?C  (low  =    +0?C, high =   +75?C)
> vid:      +1.450 V  (VRM Version 8.5)

Yes, that's quite good. You could try "sensors -s" to set the limits
for the CPU voltage. You might tweak the configuration file to set the
other limits as well - in particular high temperature limits can
probably be lowered a bit.

> Those 3 temperatures correspond to the 2 CPUs and the motherboard temp.
> 
> Is there any way to know which temp and RPM reading corresponds to which
> actual device?  I assume that the lowest of the 2 temperatures is the M/B,
> but it would be nice to accurately identify the specific CPUs and fans.

A rule of thumb is that the BIOS will usually list the items in the same
order as lm_sensors does, so if your BIOS displays the labels for fans
and/or temperature you can use that order as a hint.

Then for temperatures, you can try to run a CPU-consumming process,
e.g. "md5sum /dev/zero", and see which temperature rises faster: this
will be the temperature of the CPU running the process.

For fans it's even easier, just unplug or block one fan and see which
reading goes to 0. It's safer to temporarily power the fan from a molex
connector using a converter instead, unless you're really quick.

Anyway, it is _very_ likely that the order is just what you would
expect:
temp1: motherboard temperature
temp2: first CPU temperature
temp3: second CPU temperature
fan1: first CPU fan
fan2: second CPU fan

I have a similar motherboard (Supermicro DLE370) with an LM87 and
that's how it is wired.

-- 
Jean Delvare

