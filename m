From: bezaur@gmail.com (Charles Spirakis)
Date: Fri, 18 Aug 2006 21:14:32 +0000
Subject: [lm-sensors] [PATCH] documentation-only update for w83791d to
Message-Id: <5bfe43f80608181414j2accf664l5dbe3c3cfee5e53b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608171511h546b5ceai3cbf0b2987becbec@mail.gmail.com>
In-Reply-To: <5bfe43f80608171511h546b5ceai3cbf0b2987becbec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No disagreements.

Updated patch enclosed.

-- charles


On 8/18/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Charles,
>
> > From: Charles Spirakis <bezaur at gmail.com>
> >
> > The alarm bits and the beep enable bits are in different positions in the
> > hardware. This patch documents the problem and leaves it to the user-space code
> > to handle the situation. When this driver is updated to the standardized sysfs
> > alarm/beep methodology, this won't be a problem.
> >
> > This is a documentation only change.
>
> Mostly fine with me, see my comments inline.
>
> > +alarm_rsvd   :  alarms: 0x800000 beep_enable: --------
> > +reserved     :  alarms: 0x008000 beep_enable: 0x008000
>
> I don't think it's worth documenting these, as they won't ever be used
> by definition.
>
> > +
> > +*** NOTE: It is the responsibility of user-space code to handle the fact
> > +that the enable and alarm bits are in different positions when using that
> > +feature of the chip.
>
> Please write "beep enable" rather than only "enable", it's clearer.
>
> >
> >  When an alarm goes off, you can be warned by a beeping signal through your
> >  computer speaker. It is possible to enable all beeping globally, or only
> > @@ -109,5 +117,7 @@ often will do no harm, but will return '
> >
> >  W83791D TODO:
> >  ---------------
> > -Provide a patch for per-file alarms as discussed on the mailing list
> > +Provide a patch for per-file alarms and beep enables as defined in the hwmon
> > +     documentation (.../Documentation/hwmon/sysfs-interface)
>
> No need to add ".../" before documentation.
>
> >  Provide a patch for smart-fan control (still need appropriate motherboard/fans)
> > +
>
> No need to add this blank line.
>
> > diff -urpN linux-2.6.18-rc2-git2/drivers/hwmon/w83791d.c linux-2.6.18-rc2-git2_update/drivers/hwmon/w83791d.c
> > --- linux-2.6.18-rc2-git2/drivers/hwmon/w83791d.c     2006-07-24 19:00:43.000000000 -0700
> > +++ linux-2.6.18-rc2-git2_update/drivers/hwmon/w83791d.c      2006-08-17 11:30:12.000000000 -0700
> > @@ -28,8 +28,9 @@
> >      The w83791d chip appears to be part way between the 83781d and the
> >      83792d. Thus, this file is derived from both the w83792d.c and
> >      w83781d.c files, but its output is more along the lines of the
> > -    83781d (which means there are no changes to the user-mode sensors
> > -    program which treats the 83791d as an 83781d).
> > +    83781d.
> > +
> > +    The w83791g chip is the same as the w83791d but lead-free.
> >  */
>
> While you're at it, what about removing the "its output is more along
> the lines of the 83781d" part? I don't see how relevant it is, the
> output is standardized anyway.
>
> Thanks,
> --
> Jean Delvare
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_update.patch
Type: text/x-patch
Size: 5710 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060818/7b7dcbee/attachment.bin 
