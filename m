From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Nov 2005 14:24:45 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <Ln2u8rC9.1130937134.0773400.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

On 2005-11-2, Roger Lucas wrote:
> The fan is handled correctly, but you have the nasty condition where if
> you set a minimum speed that is too low, it is set to zero.  The Via
> speed sensor works on period rather than frequency, so there is a 1/x
> conversion done in the driver.

Note that this is pretty standard, almost all fan tachometers work that
way. The only drivers which do not have to invert the register value are
the FSC ones if I remember correctly.

> If you select a frequency that is too low, then the conversion to a
> period creates a period that is too large for the counters and the
> resulting illegal result is rejected.

It's not rejected, it's even worse than that: it's rounded to the
greatest possible value (255), which in turn is read back as 0 RPM.

>                                        If you want very slow fan
> speeds then you must make sure the divider is set high enough so that
> the resulting period is within the limits of the device.
>
> Personally, I don't like this.  It isn't really a massive amount of work
> to get the driver to automatically either:
>
> 1) Automatically select the appropriate divider for the minimum speed
> that you have requested (i.e. pick the highest divider ratio that can
> give the speed you want range)
>
> Or
> 2) Select the lowest possible minimum speed if the one you selected is
> still too low.

I think that most drivers implement solution 2. We have a (low) number of
drivers which implement automatic fan-div switching (pc87360, adm9240),
which is a subset of solution 1.

> A minimum speed of 0 should always disable the minimum speed detection.

We can't always do that, as it depends on what the chip itself does.
Some chips have a dedicated bit to disable the alarm. Some chips disable
the alarm if the limit register is set to 0. Some chips disable the
alarm if the limit register is set to 255. What does the VT8231 do?

> Resetting the minimum speed to zero when you select a non-zero minimum
> speed is just plain wrong, however, as it is not obvious exactly what is
> happening "behind the scenes".  I spent quite a bit of time debugging the
> system to convince myself it was working "correctly".
> (...)
> Anyone else have thoughts on this?

I completely agree with you. Please fix the driver. We should port the
fix back to lm_sensors CVS too. In fact, I think the current behavior is
a bug in the original code. Consider the following code:

> /********* FAN RPM CONVERSIONS ********/
> /* But this chip saturates back at 0, not at 255 like all the other chips.
>    So, 0 means 0 RPM */
> static inline u8 FAN_TO_REG(long rpm, int div)
> {
> 	if (rpm = 0)
> 		return 0;						
> 	rpm = SENSORS_LIMIT(rpm, 1, 1000000);   
> 	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1,
>                            255);
> }
> 
> #define MIN_TO_REG(a, b) FAN_TO_REG(a, b)
> #define FAN_FROM_REG(val, div) \
>                  ((val)=0?0:(val)=255?0:1310720/((val)*(div)))

The comment clearly states that the register value will be 0 if the fan
speed is too low to be measured under the currently selected clock
divider. I guess this is true for stopped or missing fan as well (can
you confirm?) Thus there is no reason to consider the register value 255
any differently from other non-zero values, is there? The FAN_TO_REG
function does actually not, but the FAN_FROM_REG macro does, and I
believe this is where the bug is.

Try removing the (val)=255 case in FAN_TO_REG, and I think the driver
will behave like you described above (solution 2).

While you're there, please delete the MIN_TO_REG macro and use
FAN_TO_REG instead.

You could also get rid of the middle SENSORS_LIMIT call in FAN_TO_REG,
providing you use strtoul instead of strtol to read the input value (in
set_fan_min). The lower bound will be handled by strtoul and the = 0
check. The upper bound is redundant with the next SENSORS_LIMIT call.

If you are willing to implement the solution 1, fine with me. This isn't
a requirement for me to accept the driver in Linux 2.6 though.

I will try to review the code further later today. It would be great if
we could integrate this ported driver in Linux 2.6 soon, it has been
around for too long already.

Thanks a lot for your work,
--
Jean Delvare
