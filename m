From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 17 Feb 2008 20:07:15 +0000
Subject: Re: [lm-sensors] [patch 2/2] applesmc: sensors set for MacBook2
Message-Id: <20080217200715.GE2916@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Andrew Morton <akpm@linux-foundation.org> [2008-02-04 23:41:58 -0800]:
> From: Riki Oktarianto <rkoktarianto@gmail.com>
> 
> On my mid-2007 MacBook2, reading Ts0P sensor always failed with this message:
> applesmc: wait status failed: 5 != 50.
> 
> So I assume that there's no such Ts0p sensor in this model (please confirm,
> anyone). If there's the case, then we need a new set of sensors defined for
> MacBook2.
> 
> Signed-off-by: Riki Oktarianto <rkoktarianto@gmail.com>
> Cc: Nicolas Boichat <nicolas@boichat.ch>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/hwmon/applesmc.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
