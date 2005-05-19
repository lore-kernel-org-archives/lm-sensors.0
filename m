From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Winbond chips - design questions
Message-Id: <20031022022051.GB8764@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-10-21 21:51:13 -0400]:
> OK, I committed a partial fix - go ahead and try it.  I already see that
> sensors doesn't report fan3 (which corresponds to "Power Fan" in P4C800
> BIOS.)  I will start another thread on the mailing list about that...

OK, new subject anyway...

What is the benefit of having all of the Winbond drivers in two files?

And related - what is the benefit of recycling feature tables etc. between
all the Winbond types in lib/chips.c and prog/sensors/chips.c?

I can tell you the downside, for sure: I'm afraid to touch any of it for
fear of breaking one of the other 5 chips that I *don't* have and *can't*
test.  Sure it's free software and I don't have any obligation... but right
now those particular bits are nigh unmaintainable.

I guess I'm asking for permission (and help!) in refactoring the Winbond
drivers.  The NatSemi (lm??) drivers are closer to where I think we
should go: two (or at most, three) related chips per file... and only
if they are trivially different or one has a subset of features of the
other, etc.

Also, what (kinds of) changes in libsensors will cause an ABI change?  Is
it absolutely limited to the contents of lib/sensors.h?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
