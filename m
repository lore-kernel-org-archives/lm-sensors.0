From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jun 2008 13:22:38 +0000
Subject: Re: [lm-sensors] [PATCH 06/10] hwmon: (lm85) Simplify device
Message-Id: <20080625132238.GE23797@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-04-12 20:00:18 +0200]:
> Clean up and simplify the device initialization function:
> * Degrade error messages to warnings - what they really are.
> * Stop warning about VxI mode, we don't really care.
> * Drop comment about lack of limit initialization - that's the standard
>   way, all hardware monitoring drivers do that.
> * Only read the configuration register once.
> * Only write back to the configuration register if needed.
> * Don't attempt to clear the lock bit, it locks itself to 1.
> * Move the function to before it's called, so that we no longer need to
>   forware declare it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |   61 ++++++++++++++------------------------------------
>  1 file changed, 18 insertions(+), 43 deletions(-)

Applied[1] to hwmon-2.6.git/testing, thanks.

[1] http://jdelvare.pck.nerim.net/sensors/lm85/hwmon-lm85-06-cleanup-init-function.patch

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
