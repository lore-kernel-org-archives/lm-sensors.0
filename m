From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 23:18:06 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/9] hwmon: (lm90) Register to the thermal framework
Message-Id: <5124082E.604@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-7-git-send-email-wni@nvidia.com>
In-Reply-To: <1361187031-3679-7-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Register the remote sensor to the thermal framework.
> It can support to show the temperature and read/write threshold.

>  arch/arm/boot/dts/tegra30-cardhu.dtsi |    1 +
>  drivers/hwmon/lm90.c                  |  182 ++++++++++++++++++++++++++++++++-

There shouldn't be any need to edit both those files in the same patch.
This patch is making multiple separate logical changes, which should be
separate patches.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

> +			#sensor-cells = <1>;

Again, in order to allow that, you need some documentation in
Documentation/devicetree/bindings/. Related to that, you need to Cc the
devicetree maintainers on at least the patches that add that documentation.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> @@ -1576,12 +1728,38 @@ static int lm90_probe(struct i2c_client *client,
...
> +	np_args.np = dev->of_node;
> +	np_args.index = 0;

As I mentioned before, that'd be better replaced by an explicit of_xlate
function.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
