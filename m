From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Mar 2011 22:31:04 +0000
Subject: Re: [lm-sensors] New sysfs attribute for fan control: fan pulses
Message-Id: <20110303233104.041e10ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110223035414.GA18074@ericsson.com>
In-Reply-To: <20110223035414.GA18074@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 22 Feb 2011 19:54:14 -0800, Guenter Roeck wrote:
> while working on NCT6776F support, I realized that there is a fan control
> attribute which is not currently supported by the syfs ABI: The number of
> fan pulses per revolution. On the NCT6776F, this can be configured in Bank 6,
> registers 0x44 to 0x46. Possible values are 0..3 for 4, 1, 2, or 3 pulses 
> per revolution.
> 
> I encountered the same parameter when working on PMBus devices. At the time,
> I thought this was a variant of a fan divisor (ie a divisor of 1, 2, 3, or 4),
> but apparently it is different and independent of the fan divisor.
> 
> Question is if it would make sense to merge support for this attribute into fan[1-*]_div,
> or if we should define a new attribute specifically for fan pulses per revolution.

I remember discussing this years ago. It's so old that I don't remember
the details and couldn't find the discussion in the archive. I seem to
recall that I proposed to introduce a new attribute for this, and was
replied (don't remember by whom) that it was just a variant of fan
clock divisors and it didn't need special handling.

I suspect this might be true for some devices. It all depends on how
the pulse-per-revolution register works. It could be informative only
(to let the BIOS or pin wrapping set it) and the driver must take the
value into account. Or it could be handled by the device itself, in
which case the device may or may not adjust the clock frequency to
stick to a range of measurements (in other words, changing the
pulse-per-revolution value may influence the divisor or not.)

I suspect that the lack of proper support for this feature is the
result of several factors: few devices support it, few users need it
(the vast majority of consumer fans emit 2 PPR) and handling the
correction is easily done in user-space with a compute statement in the
libsensors config file. It's even documented in our FAQ.

> Merging it into fan[1-*]_div would mean we would have to permit new values for it,
> and we would need a more complex description. Changing the value could be ambiguous
> if there is ever a chip which supports both fan divisor and pulse/revolution
> configuration registers (NCT6776F and PMBus devices don't, so we would be safe there).

FWIW, some of the LM85-compatible devices (ADM1027 at least) have a
pulse-per-revolution register at 0x7b. The Linux 2.6 driver lacks
support for it, but the Linux 2.4 driver included it:
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-2.10/kernel/chips/lm85.c

Interestingly, this family of chips is one of the oldest with more than
8 bits for fan speed values, and thus doesn't have a fan clock divisor
mechanism. So apparently this setting is mutually exclusive with fan
div on all devices we know.

> A new attribute (fanX_pulses ? fanX_ppr ?) would be more straightforward,
> but ... it would be a new attribute.

There's nothing wrong with new attributes :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
