From: Wei Ni <wni@nvidia.com>
Date: Wed, 20 Feb 2013 12:29:50 +0000
Subject: Re: [lm-sensors] [RFC PATCH 7/9] thermal: tegra30: add tegra30 thermal driver
Message-Id: <5124C1BE.8030401@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-8-git-send-email-wni@nvidia.com> <20130219235629.GU17833@n2100.arm.linux.org.uk>
In-Reply-To: <20130219235629.GU17833-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

On 02/20/2013 07:56 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 18, 2013 at 07:30:29PM +0800, Wei Ni wrote:
>> +static struct tegra_thermal_data * __devinit thermal_tegra_dt_parse_pdata(
> 
> __dev* no longer exists.

Ok, I will change it.

> 
>> +	tdata = devm_kzalloc(&pdev->dev, sizeof(*tdata), GFP_KERNEL);
>> +	if (!tdata) {
>> +		dev_err(&pdev->dev, "Can't allocate platform data\n");
>> +		return NULL;
>> +	}
>> +	memset(tdata, 0, sizeof(*tdata));
> 
> Useless memset.  k*z*alloc already zeros the memory before returning.

Yes, I forgot to remove this line.

> 
>> +static int tegra30_thermal_probe(struct platform_device *pdev)
>> +{
>> +	struct tegra_thermal_data *pdata = pdev->dev.platform_data;
> 
> You read pdata here....
> 
>> +	struct thermal_zone *tz;
>> +	struct thermal_sensor *ts;
>> +	static struct thermal_cooling_device *cdev;
>> +	int ret;
>> +
>> +	pdata = thermal_tegra_dt_parse_pdata(pdev);
> 
> and immediately overwrite it here.
> 
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "Get platform data failed.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Create a thermal zone */
>> +	tz = create_thermal_zone("tz_tegra", NULL);
>> +	if (!tz) {
>> +		dev_err(&pdev->dev, "Create thermal_zone failed.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	pdata->tz = tz;
> 
> This isn't how you deal with driver data.  Set driver data against a
> platform device using platform_set_drvdata(pdev, tz).

Yes, I didn't consider it carefully.
As Stephen said, our tegra will only support DT, so I will remove the
platform date.

Thanks.
Wei.

> 
>> +static int tegra30_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct tegra_thermal_data *pdata = pdev->dev.platform_data;
> 
> and use platform_get_drvdata() here - and don't use pdata->tz.
> 	struct struct thermal_zone *tz = platform_get_drvdata(pdev);
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
