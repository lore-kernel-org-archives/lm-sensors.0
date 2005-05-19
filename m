From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088695659.2862.61.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2004-07-01 at 16:48, Jean Delvare wrote:

> >referencing to #1710 and #1714, I figured out that the LM77
> >sensor is not compatible with the LM75, though it's similar.

> Interesting. Our docs say that both chips are compatible (although the
> LM77 has additional features).

> I don't have the datasheets handy. Can you describe what makes them
> incompatible?

Datasheets are at http://www.national.com/ds/LM/LM75.pdf and 
http://www.national.com/ds/LM/LM77.pdf. The main difference (what makes
the lm75 driver incompatible) is the way the temperature is stored in
the temperature register. The register is a word on both chips, but
whereas lm75 stores the temperature from d14 to d8, lm77 does this from
d10 to d3:

      d15 d14 d13 d12 d11 d10 d9 d8   d7  d6 d5 d4 d3 d2 d1 d0
lm75  msb b7  b6  b5  b4  b3  b2 b1   lsb x  x  x  x  x  x  x
lm77  sgn sgn sgn sgn msb b7  b6 b5   b4  b3 b2 b1 b0 x  x  x

where b1 is bit1, x is unused/used for other purposes. Say, for
example, that the register contains 0x0005, which has to be
swapped, that is 0x0500 (that is the default value for T_crit).
The lm75 driver converts it to temperature with the following
pattern: (reg / 128) * 500. That would be 5000, 5 degrees. Quite
cool for a maximum. :-) The correct method would be to divide it
only by 8, since we have to drop the last 3 bits, not the last 7.
That makes 80000, 80 degrees, which makes sense at last.

> We usually do not include detection for other chipsets in a driver for
> exclusion purposes, but if its needed, we may consider it.

> Another approach (which I like better) would be to add support for the
> LM77 to the lm75 driver. We know that both chips share a number of
> attributes, although they do not seem to be compatible.

That's right, they're quite identical apart from what is mentioned
above (and that differentation can be easily implemented). The LM77
has support for a T_high and T_low, but I'm not sure if anyone would
need that. I separated the source because I thought that it might be
unappropriate to handle two different (though similar, but incompatible)
chips in the same driver.

> In both cases, we would need a way to differenciate between an LM75 and
> an LM77. I am not sure we know how to do that (which is why our
> sensors-detect script doesn't know about the LM77). Do you have a
> proposal? Even a heuristic would be acceptable, since there aren't that
> much LM77 out there, so just defaulting to LM75 unless specific
> conditions are met sounds acceptable.

Maybe we could check for the existence T_high and T_low registers?

> >I have this LM77 sensor on the secondary I2C bus of a National
> >SC1100 system. The bus is driven by the scx200_acb (stock kernel
> >2.6.7) module, which I had to patch in order to get it work:
[...]
> I will send a patch to Greg KH for the class issue. I don't know
> anything about the base address though, so I won't do anything about
> that.

That base address seems to differ on boards from different vendors. The
possible base addresses I have seen are 0x810, 0x820 and 0x840. It is
also possible to try all three addresses by default, but that would mean
that there will always be an error message, as one address would always
fail.

> Well, linux 2.6 drivers don't belong to lm_sensors anyway. But we can
> get it into the kernel tree (either as a new driver or as a modification
> of the lm75 driver). What belong to lm_sensors are 2,4 drivers and
> user-space tools support. Not sure you are interested in userspace since
> you're on an embedded system?

That's right, I'm not interested in user-space tools and can live
without having it in the stock kernel if it turns out that noone needs
it. However these embedded boards seem to be pretty popular nowadays
(see eg. http://www.pcengines.ch for a vendor) and they have quite
complete support in the kernel apart from this one little thing...

Thanks,
Andras

[ Please CC me all followups. ]

