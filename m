From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jan 2010 18:10:43 +0000
Subject: Re: [lm-sensors] [PATCH] w83793 watchdog support.
Message-Id: <20100123191043.05d56d1d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B18F35A.5060808@anduras.de>
In-Reply-To: <4B18F35A.5060808@anduras.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 23 Jan 2010 17:22:45 +0100, Hans de Goede wrote:
> On 01/21/2010 10:47 AM, Sven Anders wrote:
> > There is one small problem left:
> >
> > If the watchdog_open() functions failes with EBUSY, we must not
> > increase the counter.
> 
> Oh, good catch that bug is present in the fschmd.c code too. Note that the
> way you've fixed this with an unlock in the error path is sort of
> frowned up on. It is correct, but we usually try to keep locks and unlocks
> in balanced pairs, so that it is easy to check for missing unlocks. See the
> patch I've done to fix this same issue for fschmd (attached).

I'll go apply that patch right now.

> > Please notify me, if I need to make some more changes or if you sent the patch
> > upstream.
> 
> Well, I don't have any path for sending patches directly upstream, Jean Delvare
> usually does that for hwmon tree patches. I can ack this though, telling Jean
> it has been reviewed by me and I don't see any more issues.

Yes, if the patch is acked by Hans, I'll pick it.

> (...)
> And I think Jean might fall over the balanced lock unlock thingie, Jean ?

I don't care either way. As long as the code is correct, I'm fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
