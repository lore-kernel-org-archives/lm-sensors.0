From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: lm_sensors2/kernel/chips w83792d.c
Message-Id: <CwuiAcl4.1112086903.5823600.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050329011601.GA14733@jupiter.solarsys.private>
In-Reply-To: <20050329011601.GA14733@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao, hi Mark,

> > > We use that huge 'do {...} while(0)' to substitute the "goto"
> > > sentence, because the "goto" sentence is NOT welcome in most cases,
> > > we want to avoid it. :-)
> >
> > If that was your intention, I would prefer if you just used goto.
> > To use 'do {...} while(0)' as a "stealth" goto is even worse.

I second Mark on this, using a loop block when you have no itention to
actually loop is error-prone.

It looks quite obvious to me that this block should be made a seperate
function, as it's quite big and accomplishes a specific task. Breaks
will become returns, so you would need neither the
loop-which-is-not-a-loop nor gotos. This is exactly how things are
supposed to be done in C.

> > > Although the idea of changing "while (0)" into "while (1)" is
> > > feasible, We can NOT do that, it's dangerous to use such endless
> > > loop. We have tested it, the "while (1)" leads to bad result, while
> > > "while (0)" works well.

Of course. It's not supposed to be a loop in the first place, so (I
guess) it lacks a proper exit condition.

> > Well, the purpose of this part of the code was not immediately clear
> > to me.  Now I've read it more closely.  It seems you are trying to
> > settle on an appropriate fan divisor - one which is appropriate for
> > the measured fan speed.  But... the loop obviously isn't a loop at
> > all, so you're only incrementing or decrementing fan_div[nr] by 1.
> > That means the user would have to read the fan multiple times before
> > the fan_div arrives at a useful value.  Is that what you wanted?

That's quite logical. I do the same in my pc87360 driver. When the fan
clock divider is too low and the register overflows, you have no idea
what the "ideal" divider would be, so you have to increase it step by
step until you get a valid reading.

A different approach would be to jump to the highest divider, and go down
from there until the register value fits in the ideal range. This would
be optimum for missing fans and better for very slow fans, but in the
common case (fan is present and not too slow), the simple algorithm of
increasing the divider step by step seems to work better, as the correct
divider will be reached after only one or two tries.

A yet different approach, which I took in the new w83627ehf driver, is to
mainly set the divider according to the fan min limit and not to the fan
reading. This works because by definition the fan reading should always
be more that the limit. That way, users who know which speed they expect
will set the limit just below that, which will in turn set the correct
divider, which will then never change (unless the fan speed actually
drops below that limit). Or course I always make sure that there is a
significant room below the limit before a divider change is required. If
you think about it, you'll see that it's exactly how voltage channels
work. Not all voltage values can be measured, only some range around the
expected value, typically a 0-133% range of nominal value. Same I do
with fans in the w83627ehf case.

These methods are still at the experimental stage, granted, but I really
believe that once we have found the best algorithm and implement it in
more drivers, the end user will enjoy the improvement. Just see how many
tickets and posts we have about fan_div problems and you'll see what I
mean.

Thanks,
--
Jean Delvare
