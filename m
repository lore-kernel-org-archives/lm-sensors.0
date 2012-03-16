From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 16 Mar 2012 07:43:28 +0000
Subject: Re: [lm-sensors] Watchdog timer core enhancements
Message-Id: <4F62EF20.8060607@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com> <20120315211323.GE10698@spo001.leaseweb.com>
In-Reply-To: <20120315211323.GE10698@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

Hi,

On 03/15/2012 10:13 PM, Wim Van Sebroeck wrote:
> Hi Hans,
>
>> Short selfintro for the watchdog people: I'm a FOSS developer / enthusiast
>> for close to 15 years now. I've written Linux kernel drivers for a ton
>> of webcams and various hwmon IC's.
>
> Let me also give a short intro about myself: As a hobby I maintain the
> linux-watchdog drivers since years now. I'm not paid by anyone to do that and
> I'm doing this in my spare time. Apart from that I have a wive and 2 children
> that also need attention. In real life I'm a freelancer (doing mostly network
> and telecoms stuff) and that's how I try to survive.

I completely understand, my intend of the resend was not to complain, merely to
hopefully get some attention for it. FWIW despite my email address my kernel
contributions are mostly a hobby too.

> If you then add the fact that on the 12th of February an upgrade of my home
> system made sure that I lost a big part of my e-mail :-( and made sure that
> I didn't had outgoing and local mail anymore :-( then you understand probably
> why I have been struggling the last month... FYI: the last week I have been
> busy working on my backlog of patches for the watchdog trees, before doing
> anything else (like responding to e-mails).

Sorry to hear that, and I'm glad to see that you're back in business wrt you
email.

>> This is a resend of a series of watchdog_dev patches which I initially send
>> on Sep 12 2011:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-September/033707.html
>> And which unfortunately has seen 0 reviews / feedback since then.
>
> I have been looking at these 5 patches last week. This is what I think of them:
> patch 1: Use wddev function parameter instead of wdd global ->
> 	was allready sent out by someone else also and thus has been incorporated
> patch 2: watchdog_dev: Add support for having more then 1 watchdog ->
> 	I am sure that we all agree that we need support for multiple watchdogs.
> 	But I am not convinced we have the right approach for it yet.
> 	I saw that you started looking at Alan's Code also.
> 	Please continue the discussion about this.

I've reviewed Alan's patch and I agree that his approach is better, as soon as
he resends his patch with some (small) remarks from the review addressed. I'll
add my Reviewed-by.

> 	The support for multiple watchdogs is not for this merge window, but for
> 	the one after that.

Ok.

> patch 3: watchdog_dev: Add support for dynamically allocated watchdog_device structs ->
> 	Have to look in more detail on that patch, but I think this is a good thing to add.
> 	I'm trying to get that one still in before the merge window opens (together
> 	with the ep93xx_wdt conversion and the sp805 and mpcore patches from Viresh
> 	(but no promisses here))

As I already said in my previous mail, please note that Viresh's patches for
mpcore run into the same issue I'm running into. To clarify the problem a bit,
it could be reproduced on a (hypothetical) mpcore arm system by:

Have an app open /dev/watchdog and keep that app running.

Then do the following as root:
cd /sys/bus/platform/drivers/mpcore_wdt
ls

You should see the name of the watchdog platform dev here
(as a symlink), something among the lines of: mpcore_wdt.XXXX

Now you can unbind the platform driver from the platform dev
doing the following:
cd /sys/bus/platform/drivers/mpcore_wdt
echo mpcore_wdt.XXXX > unbind
ls

With the ls the symlink should be gone. And /dev/watchdog
too, as the mpcore_wdt_remove function has now run! This
also means that the mpcore_wdt struct, which contains the
watchdog_device struct has been free-ed.

But the app which opened /dev/watchdog still has an open
fd to it, and when calls are made on that, watchdog_dev.c
will try to use file->private_data which now points
to free-ed memory!

I admit that triggering this is not easy and not something which
will happen accidentally, but still I believe this is something which
we ought to fix.

> patch 4: watchdog_dev: Let the driver update the timeout field on set_timeout success ->
> 	This patch is in linux-watchdog-next since yesterday (and it was in my testing tree for a week).
> 	It's in linux-next since this morning together with fixes for the drivers that allready use the watchdog-api.

Great, thanks.


> patch 5: hwmon/sch5636: Add support for the integrated watchdog ->
> 	Depends off-course on patch 2.

It depends more on patch 3 then on 2. it will still work without patch 2,
but to test (and use it on some systems) I would need to blacklist the iTCO
module.

Also I've recently received information on how the watchdog in the sch5627
works, And it turns out to be exactly the same (*). So please drop this one
from your queue I'm working on a new version where most of the code is
shared between the sch5627 and sch5636 drivers (there already is a
sch56xx-common file used by both).

*) But it needs the BIOS to setup / poke some motherboard specific things,
so it only works on boards with BIOS support for the wd


Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
