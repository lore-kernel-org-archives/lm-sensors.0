From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: robustified adm1021
Message-Id: <3E1A412D.D43A4F7A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E173681.3050806@paradyne.com>
In-Reply-To: <3E173681.3050806@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the good comments.

As I recall a user was complaining about a bad reading, which caused
an out-of-limits value, and some userspace sw decided to shut the
system down based on one reading.

You are correct that my change handles transient failures but
also hides permanent failures.

Since there is no way to get a consistent failure indication
through libsensors now (0xff could become anything),
perhaps a new standard /proc entry (fail?), which is cleared-on-read,
could be used. Fail could be either 0/1 or a bitmask like alarms?

Or, in the driver, only return 0xff for a reading after repeated read
failures.

Another alternative is to let the i2c adapter do the fail indication...
no, probably not good.

adm1021 and lm75 now in linus' tree...



Ky?sti M?lkki wrote:
> 
> On Sat, 4 Jan 2003, Mark Studebaker wrote:
> 
> > Couldn't find the thread, but there was some discussion about how
> > i2c-core returns failures as -1 and the chip drivers just take that,
> > cast it to a u8, and that gets converted by libsensors and reported as
> > the value.
> 
> I think I complained about returning -1 for any errors from i2c-core,
> even when adapter returned something worth repeating to user, like
> timeout or hw failure etc. I have not looked if something tests for -1
> explicitly, and put some choices in i2c-algo-biths.
> 
> While the adm change is trivial, it leaves userland with less chance of
> detecting bus/chip game over situation. The pitfall is that monitoring
> daemon will choose to draw a straight line and not notify sysadmin nor
> do any fan(cy) pwm.
> 
> With /proc there is little to do but give clearly incorrect reading or
> invent new alarm set if some access failed. Without PEC, bad values come
> through anyway and need sanity checking for RRD/MRTG/logging.
> For this type of sysadmin utility, I feel reliability must come first.
> 
> Whether sensor access over /proc is convenient or (ever) acceptable in
> Linus's tree is worth considering. Today the choice might be devfs.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
