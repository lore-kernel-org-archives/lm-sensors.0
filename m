From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: mkpatch and diff
Message-Id: <20031115112127.257c5407.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

In the mkpatch.pl scripts, we use "diff -u2" to generate the diffs.
Since this option is deprecated and it should be "diff -U 2", I was
about to update this line, and wondered why this option was in use.

I tested without this option and the patch is actually *smaller* than
when using only two lines of context (242846 bytes with the option,
210144 without it). The only reason I can see is that it might help
using the patch on a different version of the Linux kernel than the one
that was used as a base. But since one can always regenerate the patch
for its own tree, I don't really see the interest. And I'm not even sure
it really helps. Less contexts also means more risks to patch in the
wrong place.

So I plan to simply remove that option. Any objection anyone?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
