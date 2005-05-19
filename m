From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: negative voltages (was Re: [BK PATCH] i2c driver fixes for
Message-Id: <20040202014639.GA21554@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(trimmed CC list - we can report back to LKML with conclusion)

> > * J.A. Magallon <jamagallon@able.es> [2004-01-29 23:56:59 +0100]:
> >
> > > Oops, not so good:
> > >           
> > > > -12V:     -12.18 V  (min = -12.57 V, max = -11.35 V)    ALARM
> > > > -5V:       -4.96 V  (min =  -5.25 V, max =  -4.74 V)    ALARM
> > > 
> > > Why ALARM ?

<trimmed>

* Jean Delvare <khali@linux-fr.org> [2004-01-30 10:36:51 +0100]:
> What Mark says is perfectly true as a generic remark, but this isn't the
> problem here. The problem is that the limits of negative voltages are
> swapped. Internally, the low limit is the one nearer from 0, i.e. the
> lesser in absolute value. Your output shows the contrary.
> 
> This is a bug in the driver, or libsensors, or both. We have to take a
> look at this really soon. This is on my to-do list for some times
> already, just gimme some more time.

There is no bug in the driver, *nor* (I think) in libsensors...

Nevermind sensors(1) or libsensors for a moment.  With my w83781d,  I
see this:

/sys/.../in_max5   => 3.616V
/sys/.../in_input5 => 3.328V
/sys/.../in_min5   => 3.264V

This scenario shows no alarm, nor should it.  This represents the voltage at
the pin of the w83781d.  Making no assumptions about what in5 is, this is the
correct and logical conclusion.

Using sensors(1), I see this:

-12V:     -11.57 V  (min = -11.35 V, max = -12.57 V)

But it can't be that min > max, so how to fix it?  Since changing the driver
has been ruled out...

If we reverse the sense of min/max in libsensors, that leads to the 
undesirable effect of in_max5 modifying /sys/.../in_min5.  But worse,
what if in5 is a positive voltage on a given board?  Oops, now we
broke it for them.

If anything, what is needed in sensors.conf is a "negative voltage" flag
which can signal the situtation to the library so it can be handled
correctly.

Or, we can just document that min/max are absolute values and be done
with it.  That would force a review of all 2.4 drivers that might have
reversed voltages (are there any?),  but that's my vote... comments?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
