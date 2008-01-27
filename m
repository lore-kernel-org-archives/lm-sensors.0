From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 27 Jan 2008 15:45:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Misc cleanups
Message-Id: <20080127154510.GH29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-30 23:52:44 +0100]:
> * Drop unused defines
> * Drop unused driver ID
> * Remove trailing whitespace
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/w83781d.c |   13 ++++---------
>  include/linux/i2c-id.h  |    1 -
>  2 files changed, 4 insertions(+), 10 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
