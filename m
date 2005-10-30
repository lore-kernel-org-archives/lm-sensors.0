From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 30 Oct 2005 17:14:03 +0000
Subject: [lm-sensors] PEC support in i2c/lm_sensors CVS
Message-Id: <20051030171335.34da6461.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am almost done backporting many of the i2c and hwmon changes which
made it into Linux 2.6.14-git1 to i2c/lm_sensors CVS. As these are
backports, I am quite confident that these changes are all safe, but
you never know. So everyone still using a 2.4 kernel is welcome to give
a try to i2c and lm_sensors CVS, and report any problem.

One set of changes I did not backport yet is the software PEC support
rewrite and all the related changes. Usually we avoid large changes to
i2c CVS, but for this one time I would like to make an exception, and
backport the new PEC code so that i2c/lm_sensors CVS and Linux 2.6
behave the same way.

My arguments in favor of doing so are as follow:

* PEC support has a user-space interface part (i2c-dev.h). The new
interface is not incompatible with the old one, but still slightly
different. It's probably better for application writers to have a
common interface to deal with.

* The old PEC code was buggy. Hideki Iwamoto reported several problems,
some of which are already fixed in i2c CVS, but some others are still
not, and I also know of at least one more which wasn't reported. If we
don't replace the old implementation with the new one, we will at least
need to fix it - or delete it altogether.

* The fact that the old code was not working and nobody reported before
Hideki did proves that PEC is not widely used, if at all. So, there is
very little risk of upsetting anyone by changing the PEC code now.
Having a common implementation in CVS and Linux 2.6 will make it easier
for future driver authors. We have seen that people are still writing
drivers for Linux 2.4, which will be ported to 2.6 in the long run.

* The old PEC support was not even in Linux 2.4, so we don't break any
kind of compatibility at this level if changing the PEC code in
i2c/lm_sensors CVS.

* As a maintainer, I would very much prefer to have a single
implementation to support.

So, unless someone comes up with good reasons for not backporting the
new PEC code to i2c/lm_sensors CVS, I will probably do so. I would
appreciate if someone could take a look at the new Linux 2.6 code
(2.6.14-git1 and later) and confirm that I got it right. I don't think
it got any form of review so far, except for the fact that It Works For
Me (TM).

I would like to publicly thank Hideki for his work on the old PEC code.
Arigato, Hideki-san! Don't go thinking that your investigations and
reports were in vain. Even if later versions of i2c/lm_sensors CVS use
a completely different PEC code, you still much helped me understand
the old implementation and its weaknesses, so I could design something
(hopefully) better. And this is also very valuable to know the bugs
that existed in older versions of our software, as people are likely to
continue to use it for a long time.

Thanks,
-- 
Jean Delvare
