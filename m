From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 23 Oct 2007 12:02:39 +0000
Subject: Re: [lm-sensors] [patch 1/1] applesmc for Mac Pro 2 x Quad-Core
Message-Id: <20071023120239.GD30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi:

* Andrew Morton <akpm@linux-foundation.org> [2007-10-16 14:19:20 -0700]:
> From: Ren� Rebe <rene@exactcode.de>
> 
> At least the 2x Quad-Core Apple Mac Pro appears to have some over-heat
> protection which suddenly powers off the whole box under load.  This adds
> support for the fans and temerature sensors in the Mac Pro - later some
> "windwarm" a-like code should probably monitor the values.  For now
> manually tweaking the fans prevents the sudden shutdown for me.
> 
> cd /sys/devices/platform/applesmc.768
> for x in fan{1,2,3,4}; do
> 	echo 1 > ${x}_manual
> 	echo 1285 > ${x}_output
> done
> 

Ren�: there is a series of patches for the f75375s hwmon driver that allow fans
to be initialized with platform data.  Although I haven't reviewed the series
in detail yet, IMO the concept looks OK and it may be appropriate for the Macs
also.

http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021597.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021598.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021599.html

> Two sensors are 0, while four are 129 �C, those might be removed again,
> later.
> 
> Signed-off-by: Ren� Rebe <rene@exactcode.de>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> Cc: Nicolas Boichat <nicolas@boichat.ch>
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/hwmon/applesmc.c |  107 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 101 insertions(+), 6 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
