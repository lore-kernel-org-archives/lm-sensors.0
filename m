From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 13 Oct 2007 16:45:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) De-macro sysfs callback
Message-Id: <20071013164543.GG3994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071012210800.505b1892@hyperion.delvare>
In-Reply-To: <20071012210800.505b1892@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-10-12 21:08:00 +0200]:
> From: Jim Cromie <jim.cromie@gmail.com>
> 
> This patch to drivers/hwmon/w83627hf converts many sysfs items from DEVICE_ATTRs
> to SENSOR_DEVICE_ATTRs, and replaces macros which expand to define redundant
> callbacks, with callbacks which use the SENSOR_DEV.nr to know what to do.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/w83627hf.c |  703 ++++++++++++++++++++++------------------------
>  1 file changed, 343 insertions(+), 360 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
