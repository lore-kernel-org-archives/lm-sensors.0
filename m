From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 27 Jan 2008 15:44:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Drop W83627HF support
Message-Id: <20080127154439.GG29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-30 23:51:24 +0100]:
> The W83627HF hardware monitoring features are supported by the
> w83627hf driver for several years now. Support by the w83781d has
> been advertised as deprecated 6 months ago, it's about time to see
> it go.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/w83781d |   18 ++++++------------
>  drivers/hwmon/Kconfig       |    6 +++---
>  drivers/hwmon/w83781d.c     |   29 +++++------------------------
>  3 files changed, 14 insertions(+), 39 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
