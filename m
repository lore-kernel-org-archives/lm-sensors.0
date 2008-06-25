From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jun 2008 13:20:37 +0000
Subject: Re: [lm-sensors] [PATCH 04/10] hwmon: (lm85) Don't write back
Message-Id: <20080625132037.GC23797@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-04-12 19:56:35 +0200]:
> In set_pwm_auto_pwm_minctl, we write cached register bits back to the
> chip. This is a bad idea as we have no guarantee that the cache is
> up-to-date. Better read a fresh register value from the chip, it's
> safer and in fact it is also more simple.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
