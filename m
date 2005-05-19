From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC scaling/constraining user-space input
Message-Id: <hQImQ6Bu.1111159925.1708460.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <lllk31p1cgiaao96a5vn16edoda4tkmt19@4ax.com>
In-Reply-To: <lllk31p1cgiaao96a5vn16edoda4tkmt19@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Result of my survey of chip drivers, cherrypicking for 'best
> practice'.  To clarify this stuff I read in code.  Perhaps
> others been here too?  A newcomer's view of the lm_sensors
> stuff.  Perhaps this has all been done before too.  I'm
> simply looking for sane looking interface components.

I'll attempt to clarify the points whenever I can. As you noticed,
different drivers behave differently. Reasons are historical, some
drivers are new, some have been around for quite some times, and all
were written by different people. We clean things up sometimes but there
is still a long way to go.

> Rounding and Scaling
> --------------------
> unipolar:
> return (val + scale/2) / scale;
>
> bipolar (also is general case):
> return val < 0 ? (val - scale/2) / scale : (val + scale/2) / scale;

Both are OK, first for positive-only values, second for possibly-negative
values.

> Constraining user_space input
> -----------------------------
> static inline u8 IN_TO_REG(long val, int scale)
> {
> 	/* assume scale > 0 */
> 	if (val <= 0)
> 		return 0;
> 	return SENSORS_LIMIT((val + scale/2) / scale, 0, 255);
> }
>
> static inline s8 TEMP_TO_REG(int val, scale)
> {
> 	/* assume scale > 0 */
> 	return SENSORS_LIMIT(val < 0 ?
> 			(val - scale/2) / scale :
> 			(val + scale/2) / scale, -128, 127);
> }

These ones look all OK to me, again for positive-only and
possibly-negative values, respectively.

> static inline u8 FAN_TO_REG(long rpm, int div)
> {
> 	/* assume gated 22.5kHz counter with div in 1, 2, 4, 8... */
>
> 	if (rpm <= 0)
> 		return 255;
> 	return SENSORS_LIMIT(
> 		(1350000 + rpm * div / 2) / (rpm * div), 1, 254);
> }

Looks fine to me as well. It is questionable whether 0 RPM should be
written to as 0 or 255. In fact I think it depends on the chip. Some
chips consider 0 as a "disable" setting (disable alarm, or monitoring,
or both), some consider 255 for this instead. We have no official policy
for this.

> Two main ideas for constraining fan divisor, the easy way silently
> defaults to something:
>
> static inline u8 DIV_TO_REG(int val)
> {
> 	return val = 8 ? 3 : val = 4 ? 2 : val = 1 ? 0 : 1;
> }

Old way, deprecated, don't do it anymore.

> from adm1026:
> #define DIV_TO_REG(val) ((val) >= 8 ? 3 : (val) >= 4 ? 2 : (val) >= 2 ? 1
>     : 0)
>
> or round to nearest (mine?):
> #define DIV_TO_REG(val) ((val) <= 1 ? 0 : (val) = 2 ? 1 : (val) >= 6 ? 3
>     : 2)

Slightly better, but still not recommended.

> Yet another method seeks to special case fan setting and return
> an error:
>
>	/* supported values: 2, 4, 8 */
>	unsigned long v = simple_strtoul(buf, NULL, 10);
>	switch (v) {
>	case 2: v = 1; break;
>	case 4: v = 2; break;
>	case 8: v = 3; break;
>	default:
>		dev_err(&client->dev, "fan_ripple value %ld not supported. "
>					"Must be one of 2, 4 or 8!\n", v);
>		return -EINVAL;
>	}
>
> Overkill?

That's the correct way to do it for all discrete values. Rounding +
range constraints is fine for continuous (voltages) or pseudo-continuous
(fans) values. Returning an error for these would make no sense. But for
discrete values, it is better to let the user-space know that the value
it tried to write was not valid.

The reason why many drivers don't do it is that it was not previously
possible to do that (with 2.4 kernels and procfs interface). Now with
2.6 kernels and sysfs it is possible, so new drivers do it that way, but
some older drivers still need to be updated.

> Apart from the use of a confusing term 'ripple' for
> divisor, why special case fan divisor to return errors?  This
> method also disables the neat feature of discovering limits by
> trying something way out of range and seeing result.

Ripple is not fan clock dividers, it means more like "pulse per
revolution". I think that another driver has "ppr" for this. That
being said, pulse per revolutions are discrete too so the same applies
for fan_div and ripple/ppr: return an error if written value is not
possible.

There is no "limits" for fan clock dividers, in that you can have holes
in the range. For example, it87's fan3_div can only take values 2 and
8. With your approach, one would easily find out that min value is 2 and
max value is 8, but would also assume that 4 is a possible value - while
it's not. Also, trying arbitrarily small or large values just to find
out what the limits are is definitely not a good idea. You could trigger
hardware alarms by doing this.

> Coupled with setting fan divisor, why take special action to
> adjust fan speed limit when divisor change?  Why not simply
> tell user-space to set divisor prior to changing fan speed
> limit?

Because people do not read the docs. So they'll do it the wrong way
around, then complain that our drivers are broken. We have to protect
ourselves against users that don't read the docs.

And also because there is no reason to do otherwise. When you change one
parameter, you do not expect another to change. The fact that the chips
are implemented that way doesn't make it any more acceptable from the
user's point of view.

Imagine a sound card for which setting the master volume would reset all
other sound settings like left/right and front/back balance. Would you
just tell the users to adjust the master volume first, and not touch it
after balances have been set? Certainly not. You would remember the
settings before changing the master volume, and automatically restore
them afterwards. Same we do here.

> Then we get to the odd VID reporting, too late, I suppose, to
> simply present VID sense value to user-space and let them do
> whatever interpretation suits?  But we seem stuck with it.

Why do you say it's odd? I like the ways things are done now. Raw VID
bits are read from the chips, VRM version is guessed from the CPU and
possibly overwritten by the user, nominal VCore voltage is exposed
through sysfs. How could it be better than that?

I hope I answered your questions.
--
Jean Delvare
