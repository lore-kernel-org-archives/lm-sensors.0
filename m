From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 11 Oct 2007 04:08:27 +0000
Subject: [lm-sensors] hwmon driver authors: please read (was Re: [PATCH
Message-Id: <20071011040827.GA3994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

> On Sun, 7 Oct 2007 21:27:35 -0700, Juerg Haefliger wrote:
> > 3rd iteration of the patch:
> > - fixed header comment
> > - replaced dme1737_update_device with dev_get_drvdata in show_name
> > - replaced class_dev with hwmon_dev
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

No, you didn't do that in this patch.  You prepared this patch against a tree
in which this had been done... even though the first two patches in your series
were not prepared that way.  Git makes this fairly easy for me to deal with,
actually, but I shouldn't have to.  More on that later.

NOTE TO ALL HWMON DRIVER AUTHORS:

If you have multiple patches in a series, make sure that they are all prepared
against the same base version and that they can be applied in order.  Also,
please give me some indication of what that base version is, roughly.  If you
use git ('format-patch') that info is automatically included.  If you use quilt,
you'll have to tell me what it is.  If you use bare diff, just give your trees
meaningful names (e.g. v2.6.23-rc4 vs. v2.6.23-rc4.orig).

And, I *don't* particularly care what the base version is.  I just don't want
to have to *guess*.

So back to Juerg's series... it would be better for all three patches to apply
against e.g. v2.6.23-rc6.  Then I would have just branched with that as a base,
committed the whole series, and then merged the whole branch.  That way, the
patches would have gone into the repo exactly as Juerg sent them to me, in that
exact order.  Pre-merge, the code is exactly as he tested it.  Post-merge, if
I screwed it up, it's obviously my fault.


             ------------------o--o--o <- Juerg's 3 patches
            /                         \
           /             o-(etc)-o--o--o <- merge results
          /             /              ^
  -o--o--o--o-(etc)-o--o          hwmon.testing
         ^             ^
     v2.6.23-rc6    v2.6.23

Contrast with what actually happened here:

The first two patches applied cleanly to v2.6.23 (a guess on my part - not
specified in the patch itself).  The third one didn't, because it presumed the
class_dev -> hwmon_dev change.  Really, I don't know the base of this patch,
except that it seemed to include enough of the Tony Jones patch to require it
as an ancestor.


             ------------------o--o <- Juerg's 1,2 of 3
            /                      \
           /             o-(etc)-o--o----------o <- Juerg's 3 of 3
          /             /           ^          ^
  -o--o--o--o-(etc)-o--o           merge  hwmon.testing
         ^             ^
     v2.6.23-rc6    v2.6.23

(If you clone my repo with git, you can run gitk to see the same diagram with
actual graphics instead of ASCII art.  [And it would be vertical, instead of
horizontal, but I digress.])

That's unsound for a couple of reasons:

1) Whatever Juerg did to create a base for the 3rd patch, I had to recreate.
I.e. he must have done a merge by hand to even generate the 3rd patch.

2) I might have done (1) differently than he did.

So now I would like to know if the resulting drivers/hwmon/dme1737.c in my
testing branch is the same as what you (Juerg) actually intended and tested.

Juerg: I don't mean to pick on you.  Others have done this too (Hi Hans!),
even with merge conflicts from patches that aren't in any tree I know about
(Hi Darrick!)  ;)

Basically, whatever tree you guys use to start a patch series, keep using that
one until the series is done.  If I have to resolve conflicts to merge the
whole series, that's fine - it's my "job" now. ;) But I shouldn't need to merge
midway through a series and guess at the ancestry of each patch in it.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
