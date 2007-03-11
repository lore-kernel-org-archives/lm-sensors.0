From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 11 Mar 2007 15:55:08 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070311155508.GD3251@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Jean:

* Hans de Goede <j.w.r.degoede at hhs.nl> [2007-03-11 15:54:18 +0100]:
> 
> 
> Jean Delvare wrote:
> > Hi Hans,
> 
> <stuff about me prefering small increments in 2.10 instead of doing 3.0
>   snipped>
> 
> > I don't really care, libsensors is more or less Mark's realm, I am busy
> > enough with the kernel side of things. As long as we do not duplicate
> > the effort in two different branches, I'm fine. Also keep in mind that
> > the 2.10.x branch _must_ be stable. We must be able to release a new
> > version any time if there's a need, as is the case for 2.10.3. Going
> > with a 3.0.x branch makes it possible to make things unstable if it's
> > easier that way.
> 
> The patches I'm talking about where specificly designed to:
> 1) Keep backwards compatibility
> 2) Not change any behaviour for chips already supported. Actually for
>     chips already supported the whole code path they introduce is never
>     entered.
> 
> This minimizing the chance of introducing instability. Also keep in mind 
> that a 3.0 branch will not be thoroughly tested by a wide audience until 
> released , so that won't help much either.
> 
> Anyways lets wait and see what Mark has to say, I've made my preferences 
> clear and I will follow whatever Mark decides.

First, I should be clear: I was planning to modify the libsensors ABI for
libsensors 3.0.  That's the reason behind incrementing the major rev number
from 2 to 3.

However, I was not planning to do a complete redesign.  I just don't have the
time for that.  Here is an example of the type of change I'm planning to make:

-extern int sensors_match_chip(sensors_chip_name chip1, 
-                              sensors_chip_name chip2);
+extern int sensors_match_chip(const sensors_chip_name *chip1, 
+                              const sensors_chip_name *chip2);

That breaks the ABI, but it's not a redesign.  Nor does it make it very
difficult for libsensors users to update.  The most significant change would be
to add 'include' functionality to the config scanner.  

However, I do appreciate that a true redesign may be warranted.  If you want to
tackle this, please don't let me hold you back.  The sensors project has always
been very liberal about SVN access and contributors, because we haven't had the
luxury of having many contributors with lots of time.

If people with more time and/or energy come along, I don't want to stand in the
way just because I've been around longer.  I can also tell you that Jean feels
the same way (we're both on #linux-sensors as I write this.)

So how about this: you get SVN access, and get these patches committed to a
feature branch (as I did some time ago for the scanner).  If everything's ready
before 2.10.4, *you* can merge them back to the main line.  If it turns out you
decide to go in a different direction (destabilize the API/ABI or whatever)
then you're already on a branch so it's no big deal.

Meanwhile, I'll work on the remainder of the 3.0 material on the branch I
already have open, as I have time.  If it turns out that you want to do a
complete API/ABI redesign, I can always abandon that part of the 3.0 branch.

Does that sound OK?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


