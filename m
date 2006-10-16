From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 16 Oct 2006 06:27:47 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061016082747.bb40d643.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Sun, 15 Oct 2006 22:56:40 +0200, Michael Kress wrote:
> Jean Delvare wrote:
> > Well the problem occurs in vfs_read(), so even before reaching the
> > pc87427 code. I don't quite see how my driver could be responsible.
> >
> > You could try repeatedly reading other random sysfs files instead, to
> > see if you can reproduce the problem.
> >
> > Which 2.6.16 kernel are you using exactly? The 2.6.16.y series was
> > quite long, please make sure you are using one of the latest updates.
> >
> > If this is an SMP and/or PREEMPT kernel, you may want to try UP and/or
> > non-PREEMPT to see if it makes a difference.
> >   
> It's the one that's being downloaded with xen-3.0.2, i.e.
> linux-2.6.16.tar.bz2
> I tried it with the stock kernel from CentOS (kernel-2.6.9-42.0.3.EL)
> but pc87427 doesn't compile with that, although there's lots of stuff
> back-patched.

The previous version of the pc87427 driver (i2c-isa-based) should work
on 2.6.9 with minor adjustments, but I admit I'm not really interested
in you testing this, as the version of the driver which will be merged
is the platform-based one anyway.

> I can't get another kernel than 2.6.16, because all the xen patches rely
> on this version and I need xen.
> I will try the newest from the 2.6.16.y series, give me another day to
> try it, I think xen provided the oldest 2.6.16 one it could find. I'll
> tell you if I got further with that.

OK, thanks.

> Maybe it's also related with the "nobody cared" phenomena from
> http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0101.html - I
> suspect the irq issue to be Supermicro related.

I see no relation between the two problems.

Anyway my plan is now to get my pc87427 driver in -mm. If others report
the same problem you had, we'll have more data points to investigate.

Thanks,
-- 
Jean Delvare

