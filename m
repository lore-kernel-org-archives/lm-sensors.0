From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <200407011448.i61EmNt3004942@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>referencing to #1710 and #1714, I figured out that the LM77
>sensor is not compatible with the LM75, though it's similar.

Interesting. Our docs say that both chips are compatible (although the
LM77 has additional features).

I don't have the datasheets handy. Can you describe what makes them
incompatible?

>Attached is a driver for the LM77 that works for me. It gives
>read access to the temperature register (temp1_input) and
>read+write access to t_hyst, t_crit, t_high, t_low. The config
>register is not made available, nor are the status bits, but
>it should be really easy to add these if required. The code is
>a shameless copy of the lm75 module -- all credits go to Frodo
>Looijaard.
>
>The detection is a bit problematic: the lm77 module should not
>install itself for anything else but an lm77, but the lm75
>driver will recognize an lm77 as an lm75. It could be patched to
>check if the chip in question is an lm77 (and skip it if yes),
>but I'm not sure if it's appropriate. Ideas are welcome.

We usually do not include detection for other chipsets in a driver for
exclusion purposes, but if its needed, we may consider it.

Another approach (which I like better) would be to add support for the
LM77 to the lm75 driver. We know that both chips share a number of
attributes, although they do not seem to be compatible.

In both cases, we would need a way to differenciate between an LM75 and
an LM77. I am not sure we know how to do that (which is why our
sensors-detect script doesn't know about the LM77). Do you have a
proposal? Even a heuristic would be acceptable, since there aren't that
much LM77 out there, so just defaulting to LM75 unless specific
conditions are met sounds acceptable.

>I have this LM77 sensor on the secondary I2C bus of a National
>SC1100 system. The bus is driven by the scx200_acb (stock kernel
>2.6.7) module, which I had to patch in order to get it work: on
>line 461, the following should be added:
>
>	adapter->class = I2C_CLASS_HWMON;
>
>-- otherwise the sensors will not try to detect devices on this
>bus (thanks Khali). I also had to change the ACCESS.bus base
>addresses from 0x820, 0x840 to 0x810, 0x820 (line 46), but YMMV.

I will send a patch to Greg KH for the class issue. I don't know
anything about the base address though, so I won't do anything about
that.

>I would be really glad to see this module included in the
>lm_sensors package.

Well, linux 2.6 drivers don't belong to lm_sensors anyway. But we can
get it into the kernel tree (either as a new driver or as a modification
of the lm75 driver). What belong to lm_sensors are 2,4 drivers and
user-space tools support. Not sure you are interested in userspace since
you're on an embedded system?

Thanks,
Jean "Khali" Delvare
