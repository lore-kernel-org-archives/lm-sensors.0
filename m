From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Sep 2013 11:34:43 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522DB253.6000707@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-2-git-send-email-wni@nvidia.com> <20130909111242.GW29403@sirena.org.uk>
In-Reply-To: <20130909111242.GW29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 09/09/2013 04:12 AM, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 06:29:11PM +0800, Wei Ni wrote:
>
>> +	reg = devm_regulator_get_optional(dev, "vcc");
>> +	if (!IS_ERR(reg)) {
>> +		err = regulator_enable(reg);
>> +		if (err < 0) {
>> +			dev_err(&client->dev,
>> +				"Failed to enable regulator: %d\n", err);
>> +			return err;
>> +		}
>> +		msleep(25);
>> +	} else {
>> +		if (PTR_ERR(reg) = -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +	}
>
> This doesn't look good, it is going to ignore actual errors - I *really*
> doubt that vcc is optional, it looks like it's the main power supply for
> the device.  You should use normal regulator_get(), _optional() is for
> supplies which could physically not be provided in a system (eg, if the
> device can generate them internally if required).
>
Then he'll have to make sure that all devicetree files in the system contain references
to this regulator.

> Also do you really need 25ms after power on?
>
I had not noticed, but I recommend to reject the patch because of it. If we add 25ms delay to each driver,
booting the system will take as long as booting windows. If enabling the regulator needs time,
the regulator subsystem should do it.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
