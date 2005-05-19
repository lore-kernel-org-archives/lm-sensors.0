From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <20040429233154.063dc91b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I re-ran pwmconfig, an this time, no correlation was detected with
> pwm3;

This is much more logical. On this chip, pwm1 controls fan1, pwm2
controls fan2 and pwm3 controls fan3 (at least that how National meant
it). Since you have no fan3, it's logical that pwm3 has no effect.

> The alarms for the temperatures seem to be working fine. From what I 
> gather in the last e-mail is that the alarm flag will be displayed
> one time after the alarm has gone away, and then get cleared. This is
> exactly what happened here. (note: doing cat on the temp3_status file 
> produced the same effect as having to run sensors before the flag was 
> cleared).

Correct. Doing cat on the file or running sensors has the same effect:
sensors actually accesses the information through libsensors, which, on
2.6 kernels, reads them from sysfs.

> As for the cpu temperature, it seems as though windows programs are
> also unable to detect it. Here is a link to screenshots of two windows
> programs I tried (both available online; the first is called speedfans
> and is freeware, the other is simply called hardware monitor and is
> shareware)

Yeah, I already heard of these. You could have tried Motherboard Monitor
as well:
http://mbm.livewiredev.com/
Alex told me he had theoretical support for the PC87366, although only
one user really had success so far.

> http://themastermind3000.tripod.com/index.html
> 
> The first shot shows that the other temperatures are definitely a 
> problem. It also shows some voltages, so hopefully that will aide in 
> that aspect.

Looks mostly broken. This obviously means that the authors of these
tools don't know more than I do about the resistor values and voltage
orders. Since it is left to the motherboard manufacturers, this means
that we are likely to see as many different configurations as there are
different motherboards, except for in7-in10. Same for the extra
temperatures. This make me feel like I'd better export raw values for
these from the driver and let the user inquire from their motherboard
maker for the correct labels and formulae.

> The second shot calls the only reportable temperature the mainboard 
> temperature, and it reports about 51 degrees...
> So it seems that this cpu temperature problem is common.

Correct.

> As for fans, this cvs is reporting 0 pwm to be the highest and 255 to
> be the lowest. For this reason, immediately after I execute pwmconfig,
> my fans turn off, and when the program tries to really turn off the
> fans, it turns them back on.

This is odd. Your chip's configuration says that the fans are inverted,
so I thought I had to invert the logic in the driver as well... And
doing so actually breaks things. Either I do not read the datasheet
correctly (possible) or your motherboard maker did something nasty.
Either way, I have disabled this "feature" and now ignore the invert
flags completely. Hopefully if should revert the driver's behavior to
what it was before.

> Other than that, the fans' pwm altering is in good working order. All 
> the pwm files have the "1" bit.
> However, the speeds will still not get updated. There is an overflow 
> flag if I echo anything above 27 (or 228 if pwm was used normally). I 
> ran sensors several times (giving the computer about a minute of idle 
> time) and cat'ed the fan#_status files several times. When pwm values 
> above 27 were echoed, the status files stated "4". After echoing 27
> or lower, the flags would wear off only after I either ran sensors or
> cat'ed the respective status file and waited at least 4 seconds.

I have a theory about this and would like you to do some additional
tests. I think that when you slow the fan down with PWM, it simply drops
below the lowest measurable speed for the given divisor. This triggers
the OVERFLOW alarm. By design, the chip stops updating the values as
long as any alarm flag is set. This is what you observe.

If I'm not mistaking, the "limit" value of PWM that causes the problem
should change if you increase the fan divisor.

Second, I made the choice not to re-read the value if the "new data
ready" bit is not set. My point was that the read value would either be
the same as the previous one, or make no sense. It was probably a bad
idea, because on error the "new data ready" bit is cleared, which is
probably why we are missing the "0" reading that goes with the
"OVERFLOW" flag. I've reverted this to the original behavior (read the
fan speed regardless of the "new data ready" flag). Let me know if it
helps.

> Something similar happens with echoing minimum values. After echoing
> a minimum value higher than the reported speed, an alarm flag comes
> on normally. Then, after echoing a value lower than the fan speed,
> only after cat'ing the respective fan#_status file (which stated "3")
> or running sensors and then waiting 4 seconds will the flags go away.

This is expected.

> For both temperatures and fans, the flags also are removed if gkrellm
> is running (I suppose since it is continuously querying the driver
> and forcing it to update); but even while gkrellm ran, the speeds
> would not get updated with pwm changes.

Yes, probably, although the flags should remain active if the error
condition is still present (it's actually clear on read and reactivated
by the chip a few cycles later).

Anyway, please test the new CVS driver and let me know if it solves (or
at least alters) your PWM and fan issues.

> By the way, what are the temp#_status files reporting?

Chip-specific bitfield. From the driver code:
#define PC87365_STATUS_TEMP_MIN		0x02
#define PC87365_STATUS_TEMP_MAX		0x04
#define PC87365_STATUS_TEMP_CRIT	0x08
#define PC87365_STATUS_TEMP_OPEN	0x40
Other bits are not alarms (but still exported, mainly for debugging
purposes at the moment). See the datasheet for details.

> I will see what I can dig up about those other special channels for
> this chip, most likely this weekend.

Great, let me know if you find something. I'll try to collect as much
data as possible from different sources on my side.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
