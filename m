From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 20:53:39 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <20070722225339.7fa80db8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 22 Jul 2007 11:27:55 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > The fscscy driver was not ported to Linux 2.6 yet. There was a first
> > request one year and a half ago:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015319.html
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015489.html
> > 
> > Nobody volunteered yet to do the work. I've added your request on our
> > wiki/Devices page, but don't hold your breath. The FSC Scylla is an old
> > and rare chip, it's unlikely that anyone will volunteer to port it for
> > free.
> 
> Well actually, I would like to volunteer, as it fits within my current fscher / 
> fscpos driver activities. I've done some checking and the fscscy is very much 
> like the fscher / fscpos, and it has the tempX_limit registers right were my 
> reverse engineering found them in the fscher :) As always if anyone has a 
> datasheet for the fscscy, that would be very welcome.

I don't have it. You may try asking the author of the Linux 2.4 fscscy
driver.

> With the possibility to add fscscy support to the driver and with my wish to 
> rip out the watchdog support (for now, I might redo it with the official kernel 
> api later, esp. if there are requests for it) + the possibility for many other 
> cleanups, I'm starting to think that it would be (much) easier to add a new 
> fscxxx driver to the kernel, based on my current fscher work, with added fscscy 
> support and cleanups.

You may also want to take a look at the pending driver for the new FSC
Heimdall chip:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018629.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018787.html
I wonder if it is also similar. I just added an entry to wiki/Devices.

> Jean & Mark, were do you stand with regards to this., I see 2 options:
> 
> 1) * Many smaller patches with incremental improvements to the fscher
>     * essentially making it an fscxxx driver
>     * with the current pseudo watchdog support left in for compatibility
>     * with other uglies like raw export of status registers left in for
>       compatibility, while also exporting the exact same info with _alarm and
>       _fault files
> 
> 2) A new fscxxx driver tackling all the issues at once, based on my current
>     fscher work, with some major cleanup and added fscscy support
> 
> As I type this, and also remind myself that the current driver has to keep 
> carying the tempX_status ugliness, my vote strongly goes to the new driver 
> approach. Then we can mark the fscpos and fscher drivers as obsolete for a 
> while and remove them eventually.

I agree that having a single driver for all similar chips would be
great, as it would lower the maintenance effort. I don't really care
which road you take, but here are my random thoughts:

* I discourage the use of "x" in the driver names. It looks great only
until the day a new chip is released, those name matches the mask, but
which isn't compatible at all. For hardware monitoring drivers, we tend
to name the driver after the first supported chip, and consider the
others as "mostly foo-compatible."

* If you go for a new driver, without watchdog support, then we will
have to keep all the other drivers around for at least some time
anyway. So the watchdog problem is more or less independent from your
decision.

* If you start from one of the existing drivers, at least the users of
this driver are guaranteed to have an easy upgrade path.

But all it all, I'd say: whatever makes it easier for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
