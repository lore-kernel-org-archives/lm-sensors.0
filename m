From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 11 May 2008 21:24:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm85) Fix function RANGE_TO_REG()
Message-Id: <20080511212412.GA3868@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-04-03 10:40:39 +0200]:
> Function RANGE_TO_REG() is broken. For a requested range of 2000 (2
> degrees C), it will return an index value of 15, i.e. 80.0 degrees C,
> instead of the expected index value of 0. All other values are handled
> properly, just 2000 isn't.
> 
> The bug was introduced back in November 2004 by this patch:
> http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commit;h28d80f1992240373099d863e4996cdd5d646d0
> 
> While this can be fixed easily with the current code, I'd rather
> rewrite the whole function in a way which is more obviously correct.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Justin Thiessen <jthiessen@penguincomputing.com>
> ---
>  drivers/hwmon/lm85.c |   25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
