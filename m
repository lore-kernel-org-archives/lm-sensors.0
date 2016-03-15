From: Keerthy <a0393675@ti.com>
Date: Tue, 15 Mar 2016 12:38:54 +0000
Subject: Re: [lm-sensors] [PATCH 13/13] thermal: convert ti-thermal to use devm_thermal_zone_of_sensor_regist
Message-Id: <56E7FF8E.8030209@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-15-git-send-email-edubezval@gmail.com>
In-Reply-To: <1457559336-17652-15-git-send-email-edubezval@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org

Hi Eduardo,

On Thursday 10 March 2016 03:05 AM, Eduardo Valentin wrote:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>

Boot tested on dra7xx-evm, dra72x-evm, pandaboard-es.
Also checked the thermal sysfs entries on am57xx-beagle-x15.

Tested-by: Keerthy <j-keerthy@ti.com>


> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index b213a12..15c0a9a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -337,7 +337,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   		return -EINVAL;
>
>   	/* in case this is specified by DT */
> -	data->ti_thermal = thermal_zone_of_sensor_register(bgp->dev, id,
> +	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
>   					data, &ti_of_thermal_ops);
>   	if (IS_ERR(data->ti_thermal)) {
>   		/* Create thermal zone */
> @@ -368,9 +368,6 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
>   	if (data && data->ti_thermal) {
>   		if (data->our_zone)
>   			thermal_zone_device_unregister(data->ti_thermal);
> -		else
> -			thermal_zone_of_sensor_unregister(bgp->dev,
> -							  data->ti_thermal);
>   	}
>
>   	return 0;
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
