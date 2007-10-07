From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 07 Oct 2007 16:47:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/thmc50: Fix a debug message
Message-Id: <20071007164718.GG3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-09-18 18:48:16 +0200]:
> type_name was used before being set. See why I don't like play-it-safe
> variable initializations: they prevent the compiler from warning you
> about such mistakes. So fix that as well.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/thmc50.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
