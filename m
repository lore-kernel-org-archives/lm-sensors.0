From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: driver design question
Message-Id: <20030730220620.GA1522@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030728153714.7b09e0b7.khali@linux-fr.org>
In-Reply-To: <20030728153714.7b09e0b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Philip Edelbrock <phil@edgedesign.us> [2003-07-29 09:50:45 -0700]:
> 
> Jean Delvare wrote:
> 
> >And I don't quite agree. We are already caching since we limit the
> >frequency at which new data can be obtained. [...]
> >
> Quick note: The refresh frequency limit was introduced because the 
> hardware would give bad results if you polled it too fast.  So, 
> depending on what the datasheet for the chip says, we adjust the max 
> polling frequency to match.  So this was to ensure accurate results from 
> the hardware, not as a performace optimization.

Take a look at the ADM1026 driver (by Phil P.) as a counter-example.  The
update routine is apropos to this thread.  He uses two different refresh
frequencies - the slower one for config data.  I thought this was a good
idea when I first saw it.

> My idea of the ideal driver is that it is almost transparent to the 
> hardware.  The less caching, the better.

Much as I try, I can't jump off the fence here.  OOH, it seems wasteful to
keep re-reading what are almost certainly non-volatile h/w registers.  OTOH,
what are we optimizing here? - a special purpose slow bus that has nothing
better to do (I2C); or an insignificant amount of ISA port IO.

> Now, your point about reducing a significant amount of latency is a good 
> one.  That's a reasonable reason for such an optimization.  I'm not sure 
> if it is a strong enough reason, though.  I think we'd need to do a 
> little math to figure out exactly how much it 'costs' to read limits and 
> what it would save us to poll them less frequently.

It depends on the chip of course - but I think the ADM1026 driver might be
a good model to follow for others which are deemed worth optimizing.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
