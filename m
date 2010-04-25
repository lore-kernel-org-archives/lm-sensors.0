From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 25 Apr 2010 21:20:09 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] [RFC] hwmon: f71882fg: Add watchdog
Message-Id: <y2ucfe85dfa1004251420ta003f216mb69a7ac8d2133eb7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269385936-3440-1-git-send-email-me@mortis.eu>
	 <1269385936-3440-3-git-send-email-me@mortis.eu>
	 <1269385936-3440-4-git-send-email-me@mortis.eu>
	 <4BA9CF57.4030504@redhat.com>
	 <20100324093651.GG6368@salidar.me.mortis.eu>
	 <4BA9EA5C.9060506@redhat.com>
	 <20100324153550.GK6368@salidar.me.mortis.eu>
	 <20100324155151.2482952f@lxorguk.ukuu.org.uk>
	 <4BAA3BEB.6010902@redhat.com>
	 <20100324203555.GA19046@salidar.me.mortis.eu>
In-Reply-To: <20100324203555.GA19046@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Laurens Leemans <laurens@signips.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Mar 24, 2010 at 4:35 PM, Giel van Schijndel <me@mortis.eu> wrote:
> On Wed, Mar 24, 2010 at 05:20:59PM +0100, Hans de Goede wrote:
>> On 03/24/2010 04:51 PM, Alan Cox wrote:
>>>> hold on the SIO port range. This would thus interfere with the
>>>> operation of the f71882fg driver. I.e. it would prevent the device
>>>> probing stage from working, thus preventing it from loading *after*
>>>> my in-development watchdog driver.
>>>
>>> There are two ways to deal with that really
>>>
>>> 1. Add a multi-function driver - it finds the chip and claims the
>>> port regions and then provides methods for locked access to them as
>>> well as creating other device instances that the drivers map to
>>> (probably platform devices ?) which in turn trigger the
>>> loading/binding of the relevant low level devices.
>>>
>>> 2. Fix the kernel request_resource stuff to support a sleeping non
>>> exclusive resource so request/free of regions can be used as a
>>> resource semaphore by co-operative devices.
>>>
>>> #2 is actually not hard but when I did the patch originally it then
>>> wasn't needed by the driver I had in mind for other reasons.
>>>
>>> See http://groups.google.com/group/linux.kernel/msg/1425fc2aad32e6ea
>>>
>>> Maybe its worth resurrecting ?
>>
>> Or, a bit more specific solution would be to resurrect the superio
>> lock coordinator patches, which were written (but never merged) 2
>> years ago to solve exactly this problem:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-July/023743.html
>
> When performing some searches I find messages going back to at least
> september 2006 [1] [2]. With multiple occurences of these patches being
> "dusted off". They never got applied though, and for that (*not*
> applying them) I cannot find any reason. Is there any? Or did people
> just become uninterested and let the patches "collect dust"?
>

For my part, I started seeing difficulties in the centralized probing,
esp around the unlocking sequences; stuff thats device specific, but
wanted to be hidden in the centralized probe.  When it was just byte-sequences,
it was ok, but then too many variations presented.

> Then regarding Alan's patch. The fact that it is a *lot* simpler than
> Jim Cromie's SuperIO locks coordinator is IMHO a significant advantage
> over the latter. Furthermore, "lock coordinator" seems like a bad name
> to me, since those patches seem especially concerned with centralising
> the way that SuperIO devices are probed for. Thus if the only thing
> required is to serialize resource access I think plain-ol' locking
> (with the ability to block on the lock, rather than polling for it).
>

"coordinator" was meant to imply cooperative drivers,
though thats *always* the case, in that drivers would at least
have to check a mutex.


> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016476.html
> [2] http://lkml.org/lkml/2006/9/14/20
>
> --
> Met vriendelijke groet,
> With kind regards,
> Giel van Schijndel
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAkuqd6sACgkQZBYm/87l50K6KwCdEMTmQ2Y4k0yi8GcWOSHIeel8
> g90An3Yso3XhFqwniMyIwEa/gOSQ9uPw
> =NFuC
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
