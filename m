From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: two questions about w83792d.c for linux-2.4
Message-Id: <TYWAog2P.1109067782.5308360.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> Question 1:
> Need I modify my current calculation method again into your above
> method?

Yes please.

> Is that all the other chip drivers in lm_sensors as what you said:
> "the values in /proc should really be Volts"? If do, I will try to
> modify my current method.:-(

Don't be afraid, it's not that difficult. The difficulty is to get what
has to be done and understand why. After that, the changes to the code
should be rather simple.

> Question 2:
> I agree that the LSB of in2-5 is 4mV, so as to in2-5, the method you
> provided is correct. But about in6-in8, you said that their LSB is
> also 4mV, then how to calculate their measured value? Because in
> datasheet
> 5VCC(in6) Voltage = (CR[26]*4 + CR[3F]&0x30) * 0.006;
> 5VSB(in7) Voltage = CR[B0] * 0.024;
> VBAT(in8) Voltage = CR[B1] * 0.016;
> The voltage factor for in6 is 0.006 instead of 0.004, the voltage factor
> for in7/8 is 0.024/0.016.
> So I think that I should use the same method as in2-5, and use the
> multiplier 1.5 in sensors.conf for in6, use the multiplier 6 for
> in7, and use the multiplier 4 for in8.
> Am I right? Can you confirm that for me?

It's a bit more complex than that. First of all, the 0.024 and 0.016
factors are really (4 * 0.006) and (4 * 0.004), because in7 and in8 do
not have the additional 2 bits of resolution (exactly the same as the
limits for all voltages). So in8 is mostly similar to in2-in5 except
that you have no second register to read:
in8 = CR[B1] * 4 * 0.004
    = CR[B1] * 0.016

For in6-in7, the datasheet explains that they are affected by *internal*
resistors. This means that you'll really have 5V at the pins, but then
you have internal resistors right before the ADC (this is needed because
the max value for the ADC is 4.080V which is less than 5V).

The reason why these inputs use internal resistors and not external ones
is that the W83792D itself *needs* the 5V lines as power suppliers. If
they were attenuated externally it would obviously not work.

So for in6-in7 the resistors have to be handled inside the driver
(remember, everything that happens inside the chip belong to the driver,
everything that happens outside of the chip belong to libsensors). This
leads to the following in the driver:
in6 = (CR[26]*4 + ((CR[3F]&0x30)>>4)) * 0.006
in7 = CR[B0] * 4 * 0.006
    = CR[B0] * 0.024

Note that you cannot use floating point in the kernel so you will not
really multiply by 0.006, 0.016 and 0.024. Instead you multiply by 6, 16
and 24, and set the "in" file magnitude to 3 (which means divide by
1000). This leads to:
in6 = (CR[26]*4 + ((CR[3F]&0x30)>>4)) * 6;
in7 = CR[B0] * 24;
in8 = CR[B1] * 16;

> Question 3:
> We discussed the voltage measured value, but how about the voltage
> limits?
> I try to get the new calculation method, would you please confirm it?
> Or please give me the detailed calculation about the voltage limits.
> VcoreA(in0) Limit = (CR[2B/2C] * 4) * 0.002;
> VcoreB(in1) Limit = (CR[2D/2E] * 4) * 0.002;
> VIN0~VIN3(in2-in5) Limit = (CR[2F~36] * 4) * 0.004;

Looks all OK to me (except that the multipliers are really 2 and 4, with
magnitude is 3, as explained above).

> Note: in0-in5 do NOT use any multiplier in sensors.conf

in0-in1 never will, but in2-in5 may. It all depends on what is wired to
them, and this choice is left to the motherboard maker. This is the
exact reason why the multipliers (if any) need to be in sensors.conf and
not in the driver.

> 5VCC(in6) Limit = (CR[37/38] * 4) * 0.004;
> Note: in6 use multiplier 1.5 in sensors.conf, same as the one for
> in6 measured value.
>
> 5VSB(in7) Limit = CR[B4/B5] * 0.004;
> Note: in7 use multiplier 6 in sensors.conf, same as the one for
> in7 measured value.

As explained above, in6 and in7 have internal resistors, so the
multiplier should be in the driver for these ones.

> VBAT(in8) Limit = (CR[B6/B7] * 0.004);
> Note: in8 use multiplier 4 in sensors.conf, same as the one for
> in8 measured value.

Not correct, the multiplier 4 must be in the driver, exactly like
in2-in5. This multiplier is not due to external resistors, but to the
lack of additional resolution bits.

I hope I've been clear. I admit it is a bit complicated to get it right
especially since it is your first driver, and it's a complex one, and
you're not used to the lm_sensors architecture. The basic rules are:
1* The driver must export the voltage _measured at its pins_ to /proc, in
Volts.
2* External resistors are handled by libsensors.
Rule 1* implies that internal resistors are handled by the driver.
The second difficulty is that you are not allowed to work with floating
point values in the kernel, which is why you always multiply by integer
values and use the magnitude to divide by 10, 100 or 1000 in the end. In
fact, for the W83792D voltages, you work in millivolts in the driver,
and the magnitude of 3 divides by 1000 in /proc, resulting in Volts.

(In Linux 2.6 it has been simplified, /sys handles millivolts too, so
there is no more magnitude to deal with.)

Thanks,
--
Jean Delvare
