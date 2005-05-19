From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: RFC lmsensors sysfs interface documentation
Message-Id: <xq1CsLvF.1112084768.4601560.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
In-Reply-To: <9kug41tbmj5kp8bmadk4t7bupgvnl15q0m@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Hi All,
>
> I've started a little documentation project here:
>
>   http://scatter.mine.nu/lmsensors/sysfs-names/
>
> So far I generated list of sysfs interface names, culled the
> documented ones and produced a second list.
>
> I don't know if anyone has a cross-reference which driver uses
> what name but I'm thinking of producing one, perhaps a table,
> X = drivers, Y = sysfs names, * marks the spot?  This been done?

Sounds good, has not been done yet.

> Worth doing?

Certainly, but only if you find a way to automate this. If not, the
drivers are changed and added as such a fast pace these days that you
would certainly regret the time you spent doing it manually quite
quickly.

> Comments, suggestions welcome.

I have a lot of them.

First, you would probably make things easier to read and analyze by
collapsing names changing only by their channel number. Where the
documentation says temp[1-4]_input, it really (almost) means
temp[anynumber]_input. The "1" is valuable because some counts start
at 0 (most notably voltage channels and CPUs) and it's better to know
which, but the "4" is totally arbitrary, and is there just because
that was the max number at the time the documentation was written. This
would be better written temp[1-*]_input, or anything similiar which
really expresses the lack of upper limit. This way we could focus on the
masks rather than the exact names.

rt[1-3] is now gone thanks to your patch to w83781d.c.

fan[1-3]_ripple is NOT fan[1-3]_div. As explained in a previous post,
ripples are the number of pulses per revolution. They are a kind of fan
divider, but fundamentally different from fan[1-*]_div which are fan
*clock* dividers. A more "standard" name for fan[1-3]_ripple would
probably be "fan[1-*]_ppr". I think I remember that some 2.4 driver
exported these.

wdog_* should definitely be changed to watchdog_*, and these should be
documented. That being said, maybe it'd be even better to look at real
watchdog drivers and use the standard interface rather than our own.

revision and die_code are the same thing. Both should be removed IMHO,
revision should not be needed by user-space, and it's cheaper to just
printk it on driver load (if this is of any use at all).

Almost each item on your nondoc list would require specific treatment.
That's quite a lot of work...

I really appreciate that you tackle issues that affect all the drivers at
once, but at some point you might find more fun and interest in going on
with your adm9240 driver port. Once you have a working driver you can
play with, you will most probably have an even better understanding of
the subsystem as a whole, which will help you focus on points you think
need fixing.

Keep up the good work,
--
Jean Delvare
