From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 02:36:15 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (w83627hf) Refactor beep	enable
Message-Id: <20080201023615.GP8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:04:55 +0100]:
> We can handle the beep enable bit as any other beep mask bit for
> slightly smaller code.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Carlos, Jim, could any of you please test and/or review this patch?
> 
>  drivers/hwmon/w83627hf.c |   78 +++++++++++++++-------------------------------
>  1 file changed, 26 insertions(+), 52 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
