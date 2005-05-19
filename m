From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <20050417105349.3508c0cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > Some comments on your coding style now, although the patch is quite
> > hard to read (not sure there's anything you can do about this
> > though).
> 
> I tried with and without 'p' diff option, would changing the number 
> of context lines stop diff from 'merging' a replacement function?
> No, it didn't -- would appreciate a cluebat on getting a better
> diff?

No idea, unfortunately. I've dreamt of a "--do-not-try-to-be-clever"
option to GNU diff, but there isn't. Nevermind, in this case you can
look at the new code directly rather than the diff.

> > I understand that new_min++ is for rounding purposes, but it doesn't
> > sound good to me, because of cumulated errors.
> >
> > Consider the case where the user asked for a low limit of 2630.
> > new_min will be computed as 513, new_div as 0. First iteration of the
> > loop, new_div becomes 1, new_min becomes 257. Second iteration of the
> > loop, new_div becomes 2, new_min becomes 129. We're happy and leave
> > the loop. The effective min limit is now (1350000 + (2 * 129)) / (4 *
> > 129) = 2616 RPM.
> >
> > Without the rounding now. First iteration of the loop, new_div
> > becomes 1, new_min becomes 256. Second iteration of the loop, new_div
> > becomes 2, new_min becomes 128. We're happy and leave the loop. The
> > effective min limit is now (1350000 + (2 * 128)) / (4 * 128) = 2637
> > RPM, which is nearer from 2630 than 2616 was.
>
> And the other side of the same decision point: 255? 

What do you mean exactly?

If that was the sense of your question, I agree that in some cases your
rounding will happen to do the right thing (e.g. for 2640, your method
leads to 2636, mine leads to 2657). My point was that your method would
introduce cumulated rounding errors in some cases. I don't think you can
argue with that. This is a mathematical fact.

So, either do proper rounding, or don't do any rounding at all. Rounding
that will work properly for half of the cases and make things worse for
the other half isn't worth the additional effort. As the proper rouding
looked significantly more expensive, I opted for no rounding at all. If you
come with an elegant, proper rounding solution, I'll consider it.

Also beware that whatever rounding you do should be taken into
consideration in the earlier test which discards the corner cases.
Failing to do so might result in overflows.

> > And as explained earlier, I don't think you should do that (decrease
> > the divider). Increasing is needed, but decreasing isn't.
> 
> Disagree: when using a wide speed range fan user may prefer most 
> accurate fan speed measurement reading.
> 
> It is the idea that user explicitly selects either fan low speed 
> limit mode, or wants to monitor fan speed.

And this is a bad idea. Asking the user to choose between having a low
speed alarm and "better" fan speed measurements is stupid. The whole
point of hardware monitoring is to detect hardware problems, and you are
almost inviting the user to disable the alarms in exchange of better
measurements!

Please remember that we are *not* introducing automatic fan clock
divider selection to provide stlightly more accurate fan speed readings.
We are doing it so that people stop wondering and complaining that their
fan speed reads 0 while the fan is spinning. My implementation does just
this, while yours fails to address the problem. This is the reason why I
can't accept it.

Thanks,
-- 
Jean Delvare
