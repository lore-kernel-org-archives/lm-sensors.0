From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <20040216232139.25e9f881.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For now, just a wild guess, but it seemed, that gentoo sources using
> the preemptible kernel patch (Was it preemptible or preemptive ?) tend
> to freeze temporary in a non reproduceable way. Since the patch
> mangles the scheduling and certainly the most inner parts of the
> kernel I could imagine it might influence lm sensors too.

The problem other users reported is that they could not use "sensors
-s". For some reasons, the ioctls libsensors is using were rejected due
to bad permissions, although writing to the /proc files directly would
work. I doubt it is linked to the preemtive mode, although this one
could cause unstability as well. The grsec and acl patches were
suspected for a time but we could never ensure they were fully
responsible for the problem. But we have at least one person reporting
that changing from the gentoo kernel to a vanilla one soved the problem.

> Just a thought to consider that kinda popped up my mind, since I saw a
> couple of gentoo boxes with 2.4.x series that all had problems with
> kernels including this patch.
> 
> We all switched the feature off and rebuilt the kernel, but I guess
> most users use the premade gentoo scripts and there it seems to be
> turned on by default.

Yes, sounds logical. I really hate these people who think that they are
smarter than the kernel developers (and I don't say that because I'm one
of these). If all these additional patches are not part of the official
2.4 kernel, there must be a f*cking reason.

> Intristing question would be: Do others (non gentoo) folks use that
> patch, do they have problems with it, esp. with lm_sensors?

I think we had reports with Debian for a moment, but since some times
there are only Gentoo folks complaining. I don't know if these Debian
folks were using patches on their default kernel of not. Maybe that was
just the people building their own kernel by themselves, can't remember.

Thanks for sharing your experience and thoughts with us :')

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
