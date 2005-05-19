From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: lm_sensors2/kernel/chips w83792d.c
Message-Id: <20050329050036.GC14733@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050329011601.GA14733@jupiter.solarsys.private>
In-Reply-To: <20050329011601.GA14733@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao:

I wrote:
> > Why is there a huge 'do {...} while(0)' loop in w83792d_fan()?  I guess
> > it's some kind of fan divisor auto-configuration.  If that's the case,
> > shouldn't it be 'do {...} while(1)'?

* Chunhao <Huang0@Winbond.com.tw> [2005-03-29 11:46:36 +0800]:
> We use that huge 'do {...} while(0)' to substitute the "goto" sentence,
> because the "goto" sentence is NOT welcome in most cases, we want to
> avoid
> it. :-)

If that was your intention, I would prefer if you just used goto.
To use 'do {...} while(0)' as a "stealth" goto is even worse.

> Although the idea of changing "while (0)" into "while (1)" is feasible,
> We can NOT do that, it's dangerous to use such endless loop. We have
> tested
> it, the "while (1)" leads to bad result, while "while (0)" works well.

Well, the purpose of this part of the code was not immediately clear
to me.  Now I've read it more closely.  It seems you are trying to
settle on an appropriate fan divisor - one which is appropriate for
the measured fan speed.  But... the loop obviously isn't a loop at
all, so you're only incrementing or decrementing fan_div[nr] by 1.
That means the user would have to read the fan multiple times before
the fan_div arrives at a useful value.  Is that what you wanted?

Also notice, the way it's written now... the value reported in 
results[0] (the limit) will be wrong if the fan_div is written
back to the chip immediately after.

> > Also, why not move the w83792d_update_client() call to the bottom of
> > the loop?
> 
> Which case do you mean ? Case 1 or Case 2?
> (snip)

I should have noticed in the first place... but actually it doesn't
matter at all.  It will only really update the values once anyway
because of the rate limiting.  As it's written now, you may just as
well get rid of the second one altogether.  Do you see why?

At any rate, I think there are multiple problems here.  Could you
please explain exactly what you are trying to do between these lines?
Then maybe I can help you better.

> 1000 else if (operation = SENSORS_PROC_REAL_READ) {
> ???
> 1042 } else if (operation = SENSORS_PROC_REAL_WRITE) {

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
