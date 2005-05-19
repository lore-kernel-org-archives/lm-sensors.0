From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: Linux on GA-8LD533(-P)
Message-Id: <20031112231741.2b0cd3bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <03080518254600.09450@diva.localdomain>
In-Reply-To: <03080518254600.09450@diva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> If I assume the default sensor types, i.e.:
> modprobe it87 temp_type=0x2a
> then I get:
> (...)

I'd read the raw register value (using i2cdump) before loading the it87
module. The BIOS is likely to have set it up to the correct value, and I
believe the it87 module should not change that value unless explicitely
asked to do so. Reading the original value could help you determine
which kind of sensors you have.

> Now of course I don't know which of temp1, temp2 or temp3 is the CPU 
> temperature and in the BIOS screen I only have that single
> temperature.  Problem however is that the CPU temp as reported in the
> BIOS - 19 centigrade - is not very near to any of the 12 temperatures
> above ;-(  Worse still, when I pulled the fan wire off the CPU fan and
> cooked it a bit (in fact up to about 40 centigrade), none of the 3
> temperatures as reported by the it87 varied by anything significant
> which might at least have enabled me to decide which of the 3 was the
> cpu temp.

You can use cpuburn (or simply compile a kernel or something similar)
for such tests. It's supposedly less risky than removing the fan
completely.

Does the BIOS reading increased as you remove the fan?

> Regarding the 2 -ve voltage sensors, the results are wacky!
> (...)
> But I should mention that the BIOS does not show values for
> the -ve rails, so maybe these have simply not been wired up to the
> chip and this is why the readings are floating around.

That's something common. Recent systems don't use these voltages, so
there's no need monitoring them, and we can reasonably thing they did
not wire them to your it87. Simply ignore them through the config file.

> So it seems that there are some significant differences between the
> IT8702 and IT8712 despite being pin compatible.
> 
> Any help in sorting this out will be greatly appreciated.

If you can get any temperature reading to change under high load, that
it might simply be that the formula is different (maybe they use
different resisor values). If not, you might look for a secondary
chipset that would monitor teperature only. Download sensors-detect CVS
and give it a try, it might return something. If it detects chips but
can't identify them, send us an i2cdump for them, we might have an idea
about what it could be.

One last thing that comes to my mind is that the temperature displayed
in your BIOS setup screen might be some average value of two or three
sensors of the it87, and not a raw value. Just an idea though, and
probably not true if you can't get any reading to raise under load
anyway.

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
