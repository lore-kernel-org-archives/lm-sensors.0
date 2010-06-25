From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Jun 2010 08:09:48 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] hwmon: Update MAINTAINERS for
Message-Id: <20100625100948.002739da@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1277416861-32494-1-git-send-email-guenter.roeck@ericsson.com>
	<1277416861-32494-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1277416861-32494-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@linux-foundation.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <kernel@jic23.retrosnub.co.uk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, 24 Jun 2010 15:01:01 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  MAINTAINERS |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d119c9..2e8334d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5205,6 +5205,13 @@ M:	Nicolas Pitre <nico@fluxnic.net>
>  S:	Odd Fixes
>  F:	drivers/net/smc91x.*
>  
> +SMM665 HARDWARE MONITOR DRIVER
> +M:	"Guenter Roeck" <linux@roeck-us.net>

Quotes aren't needed. They are present below for Mark only because of
the dot in his name, which needs quoting.

> +L:	lm-sensors@lm-sensors.org
> +S:	Maintained
> +F:	Documentation/hwmon/smm665
> +F:	drivers/hwmon/smm665.c
> +
>  SMSC47B397 HARDWARE MONITOR DRIVER
>  M:	"Mark M. Hoffman" <mhoffman@lightlink.com>
>  L:	lm-sensors@lm-sensors.org

Other than this, this patch looks good to me.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
