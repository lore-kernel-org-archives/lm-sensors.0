From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 28 Oct 2007 18:10:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm78 and w83781d: Probe fewer I2C
Message-Id: <20071028181030.GP30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007122546.3f8b4d18@hyperion.delvare>
In-Reply-To: <20071007122546.3f8b4d18@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-07 12:25:46 +0200]:
> We've never seen any device supported by the lm78 or w83781d driver
> at addresses 0x20-0x27, so let's stop probing these addresses. Extra
> probes cost time, and have potential for confusing or misdetecting
> other I2C devices.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/lm78    |    4 ++--
>  Documentation/hwmon/w83781d |    6 +++---
>  drivers/hwmon/lm78.c        |    6 ++----
>  drivers/hwmon/w83781d.c     |    7 +++----
>  4 files changed, 10 insertions(+), 13 deletions(-)

This patch has high "regression potential".  I'll take it, but not for 2.6.24.
Also: please modify sensors-detect so that it includes the (now necessary)
options to get the driver loaded, in case the above hardware is found at one of
these addresses.

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
