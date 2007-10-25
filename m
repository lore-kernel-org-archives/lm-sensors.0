From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 25 Oct 2007 11:38:30 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s allow setting up fans with
Message-Id: <20071025113830.GH30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Riku Voipio <riku.voipio@iki.fi> [2007-09-26 13:14:40 +0300]:
> Allow initializing fans on systems where BIOS does not do that by
> default.
> 
>  - define f75375s_platform_data in new file f75375s.h
>  - if platform_data was provided, set fans accordingly in f75375_init()
>  - split set_pwm_enable() to a sysfs callback and directly usable
>    set_pwm_enable_direct()
> 
> Signed-off-by: Riku Voipio <riku.voipio@movial.fi>
> ---
>  drivers/hwmon/f75375s.c |   42 +++++++++++++++++++++++++++++++++++-------
>  include/linux/f75375s.h |   21 +++++++++++++++++++++
>  2 files changed, 56 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/f75375s.h

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
