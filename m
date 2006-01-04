From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Jan 2006 21:12:11 +0000
Subject: [lm-sensors] hwmon-pc87360-use-sensor-attr-arrays.patch
Message-Id: <20060104221211.5f39cfd0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> I couldnt get rc5-mm3 to boot properly (some switchroot prob)
> so I baselined this patch against rc7 + all accepted patches named in
> http://khali.linux-fr.org/devel/i2c/linux-2.6/series
> 
> (diffstat is uninteresting, but hey ..)
> jimc at harpo i2c-stuff]$ diffstat hwmon-pc87360-use-sensor-attr-arrays.patch
>  pc87360.c |  410 
> ++++++++++++++++++++++++++++++--------------------------------
>  1 files changed, 202 insertions(+), 208 deletions(-)

It's not that uninteresting. It shows that the patch doesn't only
shrink the binary size, it also kills a few lines of source code. Not
much, but at least it doesn't *add* lines of code, which is a good
thing.

> Convert individual sensors to sensor-attr arrays by each sensor type,
> and initialize them in loops instead of long blocks of individual calls.

Looks good (except for some trailing whitespace which I had to remove,
grmbl), applied, thanks.

It's probably one of the last large non-bug-fixing patches I accept for
Linux 2.6.16.

-- 
Jean Delvare

