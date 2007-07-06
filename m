From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Jul 2007 10:01:02 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <20070706120102.3c2d2af6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
In-Reply-To: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Wed, 4 Jul 2007 19:16:18 +0200, Krzysztof Helt wrote:
> On Wed, 4 Jul 2007 11:36:07 +0200 Jean Delvare wrote:
> > > +set(temp_max, THMC50_REG_TEMP_OS);
> > > +set(temp_hyst, THMC50_REG_TEMP_HYST);
> > > +set(remote_temp_max, THMC50_REG_REMOTE_TEMP_OS);
> > > +set(remote_temp_hyst, THMC50_REG_REMOTE_TEMP_HYST);
> > > +set(remote_temp2_max, ADM1022_REG_REMOTE_TEMP2_OS);
> > > +set(remote_temp2_hyst, ADM1022_REG_REMOTE_TEMP2_HYST);
> > 
> > Side note: all these macro-generated functions should replaced by nice
> > dynamic sysfs callbacks.
> 
> Should I rewrite it before posting a driver?

No, your code works as is and I don't want to delay the inclusion of
your work into the kernel. But once your driver is accepted upstream,
you could work on a patch to make this part better.

> > The detection code for these chips in sensors-detect additionally
> > checks that the MSB of the configuration register isn't set. You may
> > want to do the same in your driver.
> 
> I thought about it but I have to know what this kind (data->type) value means. The
> driver works with two chips (thmc50 & adm1022) and the adm1022 chips has two modes.
> The adm1022 is identical to thmc50 in the first mode and different (additional remote
> temp) in the second mode.
> 
> If I use the MSB bit to detect adm1022 it means that it is the adm1022 chip in the
> second mode. The adm1022 in the first mode would be detected as the thmc50.

Oops, sorry. I'm now realizing that the sensors-detect code is wrong,
and that confused me. The bit I was thinking of was not bit 7 but bit 4
of the configuration register (Soft Reset). This bit is essentially
write-only so it should always read 0. This can be used to improve the
detection for both chips.

I just fixed sensors-detect so that it checks bit 4 instead of bit 7.
Bit 7 can also be checked for the THMC50 (and the ADM1028) but not the
ADM1022, as you found out. I guess that sensors-detect was only
detecting one of your 2 ADM1022 chips? Can you please try the
sensors-detect version from SVN and confirm that it detects your two
ADM1022 chips properly now?

> If I use the manufacturer code for recognition of the chip, the adm1022 is always
> adm1022 regardless the MSB in the configuration register (so that bit can be completely
> ignored).
> 
> Should the data->type store the chip type or its working mode?

Other drivers store the chip type in data->type (if needed), and add
dedicated fields to the data structure if they need to remember working
modes. This sounds sensible. If you prefer to store the working mode,
than I suggest that you drop the "type" field and have for example a
"has_temp3" field instead.

> > What about user-space support? Looking at the libsensors/sensors code,
> > I see that at least the 3rd temperature sensor of the ADM1022 is not
> > supported in libsensors. And support is entirely missing from sensors?
> > Do you have a patch to add support? At least the code in the
> > lm-sensors-3.0.0 branch should support it right away.
> 
> It works with sensors3 and after addition to the sensors.conf it works with the AP550
> MB (motherboard).

Don't you want to submit support for lm-sensor 2.10.x too? We have no
clear idea when lm-sensors 3.0.0 will be released.

For sensors.conf, I suggest that you write a dedicated configuration
file for your motherboard rather than adding to sensors.conf.eg.

> I have problem how to name temperature values. There are 5 temperature values:
> 
> 1 & 2 - inside CPUs (I have to find which one is CPU0)
> 3 - in the chip which is mounted on the MB next to CPUs (corner of the MB - the air from
> CPUs is ducted there)
> 4 - in the chip which is mounted on the MB next to memory slot (which is in the half
> length of the MB)
> 5 - remote temperature from the second chip. I don't know where the sensor is located
> but it is 5 degrees higher then the temperature 4 (maybe inside RIMM memory or next
> to graphics card?).

Sensor locations are sometimes mentioned on the motherboard manuals, so
you may take a look. Otherwise you can "scan" you motherboard with a
hair-dryer ;) The last remote temperature could be the north bridge or
south bridge temperature.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
