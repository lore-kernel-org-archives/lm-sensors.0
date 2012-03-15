From: Wim Van Sebroeck <wim@iguana.be>
Date: Thu, 15 Mar 2012 21:13:23 +0000
Subject: Re: [lm-sensors] Watchdog timer core enhancements
Message-Id: <20120315211323.GE10698@spo001.leaseweb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

Hi Hans,

> Short selfintro for the watchdog people: I'm a FOSS developer / enthusiast
> for close to 15 years now. I've written Linux kernel drivers for a ton
> of webcams and various hwmon IC's.

Let me also give a short intro about myself: As a hobby I maintain the
linux-watchdog drivers since years now. I'm not paid by anyone to do that and
I'm doing this in my spare time. Apart from that I have a wive and 2 children
that also need attention. In real life I'm a freelancer (doing mostly network
and telecoms stuff) and that's how I try to survive.
If you then add the fact that on the 12th of February an upgrade of my home
system made sure that I lost a big part of my e-mail :-( and made sure that
I didn't had outgoing and local mail anymore :-( then you understand probably
why I have been struggling the last month... FYI: the last week I have been
busy working on my backlog of patches for the watchdog trees, before doing
anything else (like responding to e-mails).

> This is a resend of a series of watchdog_dev patches which I initially send
> on Sep 12 2011:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-September/033707.html
> And which unfortunately has seen 0 reviews / feedback since then.

I have been looking at these 5 patches last week. This is what I think of them:
patch 1: Use wddev function parameter instead of wdd global ->
	was allready sent out by someone else also and thus has been incorporated
patch 2: watchdog_dev: Add support for having more then 1 watchdog -> 
	I am sure that we all agree that we need support for multiple watchdogs.
	But I am not convinced we have the right approach for it yet.
	I saw that you started looking at Alan's Code also.
	Please continue the discussion about this.
	The support for multiple watchdogs is not for this merge window, but for
	the one after that.
patch 3: watchdog_dev: Add support for dynamically allocated watchdog_device structs ->
	Have to look in more detail on that patch, but I think this is a good thing to add.
	I'm trying to get that one still in before the merge window opens (together
	with the ep93xx_wdt conversion and the sp805 and mpcore patches from Viresh
	(but no promisses here))
patch 4: watchdog_dev: Let the driver update the timeout field on set_timeout success ->
	This patch is in linux-watchdog-next since yesterday (and it was in my testing tree for a week).
	It's in linux-next since this morning together with fixes for the drivers that allready use the watchdog-api.
patch 5: hwmon/sch5636: Add support for the integrated watchdog ->
	Depends off-course on patch 2.

> This resend is re-based on top of v3.3-rc7
> 
> Currently the hwmon drivers I maintain are implementing the watchdog API
> all by themselves, I would very much like to switch them over to
> watchdog_dev to remove a lot of code duplication, but there currently
> are 2 things stopping me from moving them over:
> 
> 1) The driver core only works for 1 watchdog, but both my fschmd and my sch5636
> test systems also have an iTCO watchdog and that tends to load first. Thus when
> writing the fschmd watchdog code I made it support loading either on the
> default watchdog minor, or on one of the additional reserved watchdog minors
> (212-215). The first patch in this series adds support for this to the
> watchdog timer driver core (which was quite straightforward to add).
> 
> 2) Most Linux drivers use dynamically allocated memory for the driver data,
> which gets allocated on calling the probe function and released on driver
> unbind. This means that merely locking the module containing the driver as long
> as /dev/watchdog is open is not sufficient, since the driver can still be
> unbound. The second patch in this series fixes this.
> 
> Note that the 2nd issue is also hit by the recently posted:
> "[PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates & fixes"
> patch series which convert the mpcore_wdt driver to watchdog_dev, doing
> an unbind between the platform driver and the platform dev there from sysfs
> while an app holds the /dev/watchdog file open will make file->private_data
> for that file handle point to freed memory!
> 
> Once this series is upstream I'll also write a patches to convert all my
> hwmon IC with watchdog watchdog driver parts to watchdog_dev.

You points are valid, but as said, I'm not convinced yet we have a good solution
for multiple watchdogs. But I'm sure we are getting there.

I do appreciate your patches and comments and hope to not frustrate you to much
because I am not able to respond quicker. My sincere apologies for that, although
I cannot change this easily.

Also a quick note about the linux-watchdog mailing list: there is an archive at:
http://www.spinics.net/lists/linux-watchdog/

Kind regards,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
