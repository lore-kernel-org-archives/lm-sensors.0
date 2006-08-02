From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Aug 2006 17:08:16 +0000
Subject: [lm-sensors] 18-rc1-mm1  and unchecked return-codes
Message-Id: <20060802190816.1351c79c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B3EEFD.5050209@gmail.com>
In-Reply-To: <44B3EEFD.5050209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim, Mark,

Sorry for the late answer, I have a hard time catching up with e-mail
since I returned from vacation.

> > - changing strategy  from completely-unchecked to 
> > undo-everything-and-bailout
> >    is a rather long step, and makes driver possibly unusable in some 
> > corner cases
> >    (none of which we know and can repeat)
> 
> True enough, but I imagine that any other solution will be frowned upon
> as "wallpapering over bugs".  Jean: any opinion on this?

Yup, I don't much like Jim's approach, because it's meant to be
temporary. Mark's approach seems better, especially since it is less
difficult than I first thought. Now let's see how it scales to more
complex drivers. Jim, would you like to try implementing something
similar for the pc87360 driver (or any other complex driver of your
choice, as long as you can test it) and see how it goes?

> > - my approach of just counting and warning is 'more legacy'
> >    (but warnings may be ignored, whereas a 'broken-driver' will elicit 
> > more feedback)

My fear with this approach is that, once the warnings are hidden,
nobody ever takes care of converting the drivers to the "proper
way" (whatever this ends up being.) The change will affect all hardware
monitoring drivers, and will be pretty large, so let's get it right
directly.

Give me a few more days to think about it all again, anyway... It's
large enough that we should be wise in choosing a strategy.

> > >	asb100, lm75, lm78, smsc47b397, w83627hf
> > >
> > > Any volunteers for the other 38?

I will take care of the drivers I maintain (adm1025, lm83, lm90,
f71805f) and the ones I was involved in (lm63, w83l785ts).

Thanks,
-- 
Jean Delvare

