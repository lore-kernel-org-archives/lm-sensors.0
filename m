From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: lm85 driver and a standardized pwm fancontrol interface
Message-Id: <200406241141.i5OBf2cT050809@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040623221136.GE27870@penguincomputing.com>
In-Reply-To: <20040623221136.GE27870@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Justin,

>I'm working on adding the automated fancontrol features back into the 2.6.X
>kernel lm85 driver.  So far I've been working from the 2.4.X driver and the
>respective chip spec sheets, using the 2.6.X kernel adm1030/1031 driver
>and mailing list discussion as a guideline to structure and interface.
>
>The model proposed looks something like:
>
>
>
>       Off     Min          Max     Crit
>________|_______|____________|________|_______
>
>                 Temperature -->
>
>Where Off, Min, Max, and Critical temperatures are set independently,
>except for assuming that:
>
>Off <= Min <= Max <= Crit

True, except that I think there was a Medium value between Min and Max in
thw furat place (but see right below), and Crit was labelled Full.

Please keep in mind that this was really a *proposal*. It cannot be
considered a standard yet, and as a matter of fact, this interface
isn't described in Documentation/i2c/sysfs-interface.

The interesting point is that this means that objections are still
welcome and we might consider updating the proposal if interesting
improvements are proposed. One such proposal was to simplify the
interface by discarding the "Medium" point, which it seems you took
for granted. Since we also consider that fan speed is 0 under Toff and
full speed over Tcrit/Tfull, this leaves 8 configurable values, which,
depending on the hardware, are or are not independant.

One point that hasn't been discussed so far was whether all 6 files
should be present for all drivers, even if the chips don't physically
have it. Doing so may ease the writing of scripts, but OTOH will make
some drivers bigger for virtually nothing. I have no strong opinion
about this.

Another important point that hasn't been discussed yet is whether we
want to associate temperature limits to a temperature channel or to a
fan. The ADM1031 for example physically handles one temperature points
set per temperature channel. But other chips associate them with fans
directly. In both cases, the user can chose among various fan channel
vs. temperature channel combinations. The difference matters because
it'll affect the interface. In one case, you would expect files named:
  fan1_auto_temp_off
  fan1_auto_temp_min
  fan1_auto_temp_max
  fan1_auto_temp_full
  fan2_auto_temp_off
  fan2_auto_temp_min
  fan2_auto_temp_max
  fan2_auto_temp_full
While in the other you would have:
  temp1_auto_off
  temp1_auto_min
  temp1_auto_max
  temp1_auto_full
  temp2_auto_off
  temp2_auto_min
  temp2_auto_max
  temp2_auto_full
The fact that some chips physically implement one way and other chips
implement the other means we have to pick one of three choices:
* Interface reflects the physical reality. It doesn't mean we lose
chip-independancy, but scripts will be twice as big.
* Temperatures are associated to fans. Chips that do it the other way
will have to emulate this behavior.
* Temperatures are associated to temperature channels. Chips that do it
the other way will have to emulate this behavior.
Note that this becomes very tricky when one fan depends on multiple
temperature channels. This is why we need to think a bit more about it.
Note that I'm not certain that every case can be emulated from one
model to the other without losing functionality.

>The lm85 and compatible chips use a model like:
>
>
>
>               Min                  Crit
>________________|_____________________|_______
>        |       |____________|
>        |_______|      |
>            |        Range
>        Hysteresis
>
>
>
>                 Temperature -->
>
>
>Where the Min and Crit temperatures are set indpendently, except that
>
>Min <= Crit
>
>And
>
>Hystersis is a negative offset from Min,
>
>While
>
>Range is a positive offset from Min.

That's typical. We have other chips with similar behaviors: the ADM1030
and ADM1031, and the ADM1032 (for regular temperature limits, not auto
fan). This isn't supposed to be a problem.

>Now the obvious translation between the 2 models is:
>
>Off = Min - Hysteresis
>Max = Min + Range
>Min = Min
>Crit = Crit
>
>but there are a couple of snags.
>
>(1) Hystersis and Range only have 4 bits of resolution.
>    - the 4 bits of range cover an enumerated set of possible degree ranges:
>
>    2, 2.5, 3.3, 4, 5, 6.6, 8, 10, 13.3, 16, 20, 26.6, 32, 40, 53.3, 80
>
>    - the 4 bits of hysteresis covers the range of 0-15 degrees.
>
>Both of these are ok in actual use, AFAIK.  But they set limits on the
>relationships of Off, Min, and Max temperatures defining the behavior of
>the automated fan control.  The nature of these limits are not entirely
>transparent in the new model, and may lead to different behavior of the
>driver than a casual user expects.
>
>Unless the user knows the actual set of allowed values for the range, it
>is likely he will see a different value for Max than he sets in the
>sensors.conf file or via the sysfs interface.  This will undoubtedly cause
>a fair amount of confusion for new users.  Moreover, the code now MUST
>keep track of the last value requested for Max, in addition to the value
>actually set, because every time the value of Min is changed, Max and range
>must be recalculated.  If the actual requested value is not preserved and
>used for these calculations, it is possible for the value of Max to "drift".
>As an example, consider:
>
>------------------------
>Min:               :  40
>desired Max        :  51
>
>Resultant Range    :  13.3
>Resultant Max      :  53.3
>
>Now let
>
>Min => 42
>
>If we now use 53.3 as the desired Max, then we have
>
>Max - Min = 11.3
>
>The 2 closest elements in the allowable Range values table are 10 and 13.3.
>
>10 < 11.3 < 13.3  --> Range => 13.3.

You would pick 10 here because (11.3 - 10 = 1.3) < (13.3 - 11.3 = 2.0).
However, I agree that there is a risk of cumulated errors.

>And so Max => 55.3.
>
>But if we had kept track of desired Max and used that value:
>
>desired Max - Min = 9
>
>Again using the 2 closest elements from the allowable Range values table.
>
>8 < 9 < 10  --> range => 10
>
>and so Max => 52
>
>an entirely different number.
>
>-----------------------------
>
>A similar situation exists with Off, should
>
>Min - desired Off
>
>vary from < 15 to > 15,
>
>the value for Off will by necessity rise, since
>
>0 <= Range <= 15,
>
>and therefore
>
>Min - Off <
>
>Which again means that the driver needs to keep track of the desired value
>for Off as well as the actual value.
>
>This makes me somewhat unhappy about forcing the lm85 fancontrol interface
>to fit the Off->Min->Max->Critical model.  I have made the 2 models fit as
>best I see able, but it still feels like a kludge.
>
>I would appreciate any suggestions people have for resolving these issues.

Well, you shouldn't worry too much about this one problem. People won't
change the limits every now and then, and most likely they will set both
min and max, in order, when they do, not just max. So there probably
won't be that many cumulated errors. The problem of accuracy being
limited by the hardware aren't new to auto fan speed problems. The
policy so far as been to do our best, and not to lie to the user (e.g.
the user wants limit = 12.6, we can only do 12.5, we do that and tell
the user we did 12.5). And it has been working OK so far. Now I have to
agree that the case is a bit more tricky when it comes to values that
are relative to another with a variable accuracy (this is the case for
the ADM1031's auto fan max temp, and same for the LM85). I would expect
it to still work correctly, because I guess that manufacturers wouldn't
have use limited and variable accuracy if it was considered critical to
be able to set the value with a high accuracy.

Remember that clever software can hardly "fix" broken hardware. We do
our best but hardware limitations exist and we (and the users) have to
live with them.

At any rate, we pretty well know that interface standardization is at the
cost of sometimes losing a bit of functionallity (or accuracy). It's up
to us to limit the loss to the lowest possible.

If you really think that the drifts when changing limits are a problem,
you can still do what you suggested: remember what exact value was
requested and use that instead of the "physical" value. However,
beware that it might cause other problems, for example if the value is
changed in the chip by someone else (say the BIOS). You might overwrite
such a change, and, more importantly, the user may not be aware that
such a condition happened, which in turn might trigger actions (fan
speed changing etc...). This is one of the reasons why we decided to
always show the real values to the user, so that it can notice and act
if anything goes bad.

So I would (but that's a personal choice, you're free) stick to the old
method (do your best and tell the truth) and see how it actually works,
in real cases. I'd expect it to be quite good.

I strongly believe that standardization is more than worth the price
we'll pay.

Thanks,
Jean Delvare.
