From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 24 Aug 2006 21:15:57 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-suspend-resume.patch
Message-Id: <20060824231557.70a24654.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB2470.3050507@hhs.nl>
In-Reply-To: <44DB2470.3050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

> >> This patch contains rudimentary suspend / resume support for the uguru,
> >> this protects the uguru and the driver against suspend / resume cycles,
> >> so there is no reason to unload the driver in your suspend / resume scripts.
> >>
> >> I'm not sure if this is needed, does the sysfs code itself guarantee
> >> that no sysfs attr read/write calls are in progress before starting a
> >> resume, if it does then this patch most likely isn't needed.
> > 
> > Good question, I really don't know. If sysfs doesn't guarantee it, then
> > we should do something similar for all hardware monitoring drivers,
> > it's simple enough.
> > 
> > Maybe you can raise the question on LKML, or maybe linux-pm-devel
> > (doesn't seem too active though) or otherwise ask anyone with more
> > power management knowledge than I do?
> > 
> 
> I'm not subscribed to LKML (too much mail from other lists already), 
> maybe someone who is can forward this for me?

I'm not subscribed either, for the same reason. But you don't need to
be subscribed to post.

> My guess is that this protection is actually needed as in the end the 
> sysfs reads / writes are just ordinary reads / writes and I don't think 
> that the kernel guarantees all reads/writes to have completed when 
> suspending, because that would be a real pain to guarantee for things 
> like NFS, disks, etc.

Well, something has to take care of it anyway. If not sysfs, each
individual driver will have to do it, so it would make as much sense if
sysfs actually did it.

Anyway, I'll apply your patch, we'll see if someone complains ;)

-- 
Jean Delvare

