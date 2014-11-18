From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Date: Tue, 18 Nov 2014 00:11:21 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <546A8EA9.5070001@kapsi.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416263769-6578-2-git-send-email-edubezval@gmail.com> <1416264255-10083-1-git-send-email-edubezval@gmail.com>
In-Reply-To: <1416264255-10083-1-git-send-email-edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On 11/18/2014 12:44 AM, Eduardo Valentin wrote:
> Different drivers request API extensions in of-thermal. For this reason,
> additional callbacks are required to fit the new drivers needs.
>
> The current API implementation expects the registering sensor driver
> to provide a get_temp and get_trend callbacks as function parameters.
> As the amount of callbacks is growing, this patch changes the existing
> implementation to use a .ops field to hold all the of thermal callbacks
> to sensor drivers.
>
> This patch also changes the existing of-thermal users to fit the new
> API design. No functional change is introduced in this patch.
>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: lm-sensors@lm-sensors.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>
> Difference from V1:
>   - Fix error handling when .get_trend is not provided.
>
> ---
>   drivers/hwmon/lm75.c                               |  9 +++--
>   drivers/hwmon/ntc_thermistor.c                     |  6 +++-
>   drivers/hwmon/tmp102.c                             |  6 +++-
>   drivers/thermal/of-thermal.c                       | 41 +++++++++-------------
>   drivers/thermal/tegra_soctherm.c                   |  7 ++--
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  8 +++--
>   include/linux/thermal.h                            | 24 +++++++++----
>   7 files changed, 62 insertions(+), 39 deletions(-)
>
> ...
> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
> index 70f7e9e..893c39c 100644
> --- a/drivers/thermal/tegra_soctherm.c
> +++ b/drivers/thermal/tegra_soctherm.c
> @@ -317,6 +317,10 @@ static int tegra_thermctl_get_temp(void *data, long *out_temp)
>   	return 0;
>   }
>
> +static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
> +	.get_trend = tegra_thermctl_get_temp,
> +};

This should probably read ".get_temp = tegra_thermctl_get_temp" instead 
of .get_trend :)

> ...

Cheers,
Mikko


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
