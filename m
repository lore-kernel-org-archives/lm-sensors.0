From: bezaur@gmail.com (Charles Spirakis)
Date: Tue, 15 Aug 2006 03:36:31 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <5bfe43f80608142036g71e1af2ataed36ea4e53eb1d7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
In-Reply-To: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I wrote an ugly little python script to cause each alarm to trigger
one at a time (I can provide it if anyone is interested). Based on the
script, what I found was that the documentation was completely correct
for the values I tested (in0-9, temp1-3, fan1-5). My board doesn't
have the pwm stuff and the driver doesn't have that support, so I
didn't validate the tart1-3 alarms/enables, but since everything else
was correct, it seems likely those are as well.

Sven - Can you confirm this result?

Based on this result and the comment earlier that the driver should do
a pass through of the values, I will create a documentation only
change for the 2.6 driver and clean up the lm_sensors patch that
started this thread.

Does this sound reasonable?

-- charles

in0 (VCORE)  :  alarms: 0x000001 beep_enable: 0x000001
in1 (VINR0)  :  alarms: 0x000002 beep_enable: 0x002000 <= mismatch
in2 (+3.3VIN):  alarms: 0x000004 beep_enable: 0x000004
in3 (5VDD)   :  alarms: 0x000008 beep_enable: 0x000008
in4 (+12VIN) :  alarms: 0x000100 beep_enable: 0x000100
in5 (-12VIN) :  alarms: 0x000200 beep_enable: 0x000200
in6 (-5VIN)  :  alarms: 0x000400 beep_enable: 0x000400
in7 (VSB)    :  alarms: 0x080000 beep_enable: 0x010000 <= mismatch
in8 (VBAT)   :  alarms: 0x100000 beep_enable: 0x020000 <= mismatch
in9 (VINR1)  :  alarms: 0x004000 beep_enable: 0x004000
temp1        :  alarms: 0x000010 beep_enable: 0x000010
temp2        :  alarms: 0x000020 beep_enable: 0x000020
temp3        :  alarms: 0x002000 beep_enable: 0x000002 <= mismatch
fan1         :  alarms: 0x000040 beep_enable: 0x000040
fan2         :  alarms: 0x000080 beep_enable: 0x000080
fan3         :  alarms: 0x000800 beep_enable: 0x000800
fan4         :  alarms: 0x200000 beep_enable: 0x200000
fan5         :  alarms: 0x400000 beep_enable: 0x400000
tart1        :  alarms: 0x010000 beep_enable: 0x040000 <= mismatch
tart2        :  alarms: 0x020000 beep_enable: 0x080000 <= mismatch
tart3        :  alarms: 0x040000 beep_enable: 0x100000 <= mismatch
case open    :  alarms: 0x001000 beep_enable: 0x001000
user enable  :  alarms: -------- beep_enable: 0x800000
alarm_rsvd   :  alarms: 0x800000 beep_enable: --------
reserved     :  alarms: 0x008000 beep_enable: 0x008000


On 8/14/06, Jean Delvare <khali at linux-fr.org> wrote:
> Charles,
>
> > I will try to get an update to you in the next few days. However,
> > there is some ambiguity in the documentation which is causing some of
> > the confusion...
> >
> > If you look at the 791d beep enable register (0xa3) and compare those
> > bits to the alarm status register (0xab) you will see a discrepancy in
> > the bit ordering.
> >
> > Sven and I tried to figure out if the documentation was correct or if
> > one of the bit orderings provided were correct and it was hard to
> > tell. It seemed like the bits for the enable did correspond to the
> > bits for the alarm and we had reason to believe the enable bits were
> > correct (which puts in7 and in8 at 0x10000 and 0x20000 respectively -
> > the same as the w83782d). In a side note, if you look at the interrupt
> > mask bits (0x9d) they seem to follow the alarm status bit pattern and
> > not the enable bit pattern but since the driver isn't using that
> > register it's not overly significant other than interesting
> > information.
> >
> > I will go back and test this again just to verify what we think we saw
> > is what we actually saw (or heard as the case may be).
>
> Yeah I agree that there's some confusion in the datasheet. I don't have
> a chip to test myself. All I want is that the bits we define in the 2.4
> driver and use in sensors/chips.c match the hardware reality. Else they
> are quite useless.
>
> > If anyone from winbond is reading this, would it be possible to get a
> > definitive answer as to whether the documentation is right and (if
> > not), to let us know what the correct bit patterns are for the alarm
> > vs. the enable?
>
> We have people from Winbond reading the list and helping where they
> can, but they certainly don't have the time to read everything. Please
> prepare precise questions, then we can ask them. Keep in mind though
> that the W83791D is a relatively old chip, and not very successful from
> a commercial perspective as far as can see, so Winbond must have it at
> low priority on their lists.
>
> > Along these same lines, the bit position for bit 1 and bit 13 are also
> > swapped between what is shown for the enable vs. alarm. In that case,
> > the documentation seems to be correct and the patch for the 2.6 driver
> > is updated to reflect this.
> >
> > Which leads to a different question. The assumption that was made for
> > the driver patch was that we wanted the alarm and enable bits to match
> > in user-space (and the driver would hide the problem if the chip
> > didn't do this). Is this the correct assumption? Or should userspace
> > get the values directly from the chip (so it matches the chip
> > documentation) and let the user-space code deal with the bit
> > twiddling?
>
> That's probably the first time we encounter this problem so we have to
> decide now. The rule for alarms and beeps in 2.4 was indeed to export
> them in the most simple way for the driver (only masking out irrelevant
> bits.) And so far it happened that beep registers always matched alarm
> registers so it just happened that a single set of bit definitions
> would fit them both. If this ain't true anymore, we have to break one
> of the rules, i.e. either introduce new bit definitions for beeps, or
> cook the beep register values in the driver.
>
> The most important thing to keep in mind here is that in the future, we
> want individual alarm and beep files anyway, so the decision we make
> here only matters for the 2.4 kernel drivers in the long run. In other
> words, it doesn't really matter. I'd go for the most simple solution,
> i.e. keep exporting the raw register values for both alarms and beeps,
> and introduce new defines for beeps where needed.
>
> > Oh, and I just noticed the inconsistency in the 2.6 w83791d driver
> > patch in the Documentation file - needs to be:
> >
> > 14 - in9 (VINR1)
>
> You're right.
>
> > Depending on your answer to the previous question (how do we handle
> > the situation where the enable bit ordering is different from the
> > alarm bit ordering), I will update or remove the patch... And yes, I
> > understand this is yet another argument for updating this code to the
> > standardized sysfs beep/alarm model. :)
>
> Definitely. The w83791d currently only creates the old style alarm
> files, I would welcome a patch adding individual alarm and beep files.
>
> --
> Jean Delvare
>

