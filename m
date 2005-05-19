From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <253818670505172136613abb43@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e9iUj0EZ.1116327879.1515720.khali@localhost>
In-Reply-To: <e9iUj0EZ.1116327879.1515720.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> On 5/17/05, Jean Delvare <khali@linux-fr.org> wrote:
> > If you could come up with an additional demonstration patch for either
> > the lm90 driver or the it87 driver, I would happily give it a try. The
> > adm1026 has very few users AFAIK so it might not be the best choice to
> > find testers, although I agree that it was a convenient way to
> > demonstrate how drivers could benefit from the proposed change.

Here is a patch against it87, since it seems to have many more device
attributes than lm90. The size difference:

before:
Module                  Size  Used by
it87                   28832  0
after:
Module                  Size  Used by
it87                   22432  0

That isn't bad, but the code cleanup is worth it alone in my opinion.

Yani
-------------- next part --------------
 it87.c |  387 ++++++++++++++++++++++++++++++-----------------------------------
 1 files changed, 183 insertions(+), 204 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c-it87.diff
Type: text/x-patch
Size: 25290 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050518/3c74d163/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c-it87.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
