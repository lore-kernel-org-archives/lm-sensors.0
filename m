From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 04 Jul 2007 17:16:18 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <20070704191618.da1d757a.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
In-Reply-To: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Jul 2007 11:36:07 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Krzysztof,
> 
> On Mon, 2 Jul 2007 19:54:48 +0200, Krzysztof Helt wrote:
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > +
> > +The ADM1022 works the same as THMC50 but it is faster (5 Hz instead of
> > +1 Hz for THMC50). It can be also put in a new mode to handle additional
> > +remote temperature sensor. Some pins change their meaning in this mode.
> > +If the sensor is wired to work in this mode but is not set with adm1022_temp3
> > +parameter a fan is forced to full output.
> 
> This last sentence makes no sense to me. Can you try to reformulate it?
> 

I can remove it completely. It was thought as a hint for someone with the fan settings
after loading the driver.
Is it better: "
+If the sensor is supposed to work in this mode but is not set with adm1022_temp3
+parameter a fan can be forced to full speed.

> BTW, I would expect the mode to be set properly by the BIOS. Wasn't it
> the case for you?
> 

I will read the configuration register in the probe function, so it will be preserved.
Good hint.

> > +#define THMC50_REG_INTER			0x41
> > +#define THMC50_REG_INTER_MIRROR			0x4C
> > +#define THMC50_REG_INTER_MASK			0x43
> 
> You don't make any use of these THMC50_REG_INTER* defines, so why
> define them? (What is this "inter" thing, BTW?)
> 

They are interrupt registers (mask, status and status mirror).
I'll remove them as THMC50's datasheet is still available.

> > +		.name		= "thmc50 sensor chip driver",
> 
> Should be just "thmc50", as Mark told you already?

I misunderstood him and changed only letters from capital ones.
 
> > +set(temp_max, THMC50_REG_TEMP_OS);
> > +set(temp_hyst, THMC50_REG_TEMP_HYST);
> > +set(remote_temp_max, THMC50_REG_REMOTE_TEMP_OS);
> > +set(remote_temp_hyst, THMC50_REG_REMOTE_TEMP_HYST);
> > +set(remote_temp2_max, ADM1022_REG_REMOTE_TEMP2_OS);
> > +set(remote_temp2_hyst, ADM1022_REG_REMOTE_TEMP2_HYST);
> 
> Side note: all these macro-generated functions should replaced by nice
> dynamic sysfs callbacks.
> 

Should I rewrite it before posting a driver?

> > +	client->driver = &thmc50_driver;
> > +	client->flags = 0;
> 
> Note that this initialization to 0 isn't actually needed: the kzalloc
> above did it for you.
> 

I wonder if it is worth to go for kmalloc instead because most of fields (if not all)
are set anyway.

> > +	if (company = 0x49) {
> > +		kind = thmc50;
> > +	} else if (company = 0x41) {
> > +		kind = adm1022;
> > +	} else {
> > +		pr_debug("thmc50.o: Detection of THMC50/ADM1022 failed\n");
> > +		goto exit_free;
> > +	}
> 
> [...]
> 
> The detection code for these chips in sensors-detect additionally
> checks that the MSB of the configuration register isn't set. You may
> want to do the same in your driver.
> 

I thought about it but I have to know what this kind (data->type) value means. The
driver works with two chips (thmc50 & adm1022) and the adm1022 chips has two modes.
The adm1022 is identical to thmc50 in the first mode and different (additional remote
temp) in the second mode.

If I use the MSB bit to detect adm1022 it means that it is the adm1022 chip in the
second mode. The adm1022 in the first mode would be detected as the thmc50.

If I use the manufacturer code for recognition of the chip, the adm1022 is always
adm1022 regardless the MSB in the configuration register (so that bit can be completely
ignored).

Should the data->type store the chip type or its working mode?


> What about user-space support? Looking at the libsensors/sensors code,
> I see that at least the 3rd temperature sensor of the ADM1022 is not
> supported in libsensors. And support is entirely missing from sensors?
> Do you have a patch to add support? At least the code in the
> lm-sensors-3.0.0 branch should support it right away.
> 

It works with sensors3 and after addition to the sensors.conf it works with the AP550
MB (motherboard). 

I have problem how to name temperature values. There are 5 temperature values:

1 & 2 - inside CPUs (I have to find which one is CPU0)
3 - in the chip which is mounted on the MB next to CPUs (corner of the MB - the air from
CPUs is ducted there)
4 - in the chip which is mounted on the MB next to memory slot (which is in the half
length of the MB)
5 - remote temperature from the second chip. I don't know where the sensor is located
but it is 5 degrees higher then the temperature 4 (maybe inside RIMM memory or next
to graphics card?).

Any help appreciated.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
