From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 29 Jul 2006 02:09:42 +0000
Subject: [lm-sensors] [RFC PATCH] lib/access.c optimization
Message-Id: <20060729020942.GF25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060725041358.GB12109@jupiter.solarsys.private>
In-Reply-To: <20060725041358.GB12109@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

I wrote:
> > Before anyone spends too much time on that patch... why are there so many
> > 'strcasecmp' calls in libsensors?  Did you know that you can specify 'in0'
> > or 'IN0' in the config file and both have the same effect?  I never even
> > realized it until yesterday night.  This case insensitivity is *nowhere*
> > mentioned in the man pages.

* Jean Delvare <khali at linux-fr.org> [2006-07-28 15:29:09 +0200]:
> I didn't know either.
> 
> > Can we get rid of that?  If so, I'm gonna shave a lot more than 8% by
> > using a hash for all the string/name to chip/feature/ignore lookups.
> 
> Yeah, let's get rid of it, I really don't see the point.

Good.

> How are you going to implement your hash? I'm curious?

man 3 hsearch_r

> > BTW: valgrind 3.2.0 (w/ callgrind) plus kcachegrind rocks.
> 
> Don't know about callgrind and kcachegrind, but yeah, valgrind
> definitely rocks.

Screenshots:
http://kcachegrind.sourceforge.net/cgi-bin/show.cgi/KcacheGrindShot

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


