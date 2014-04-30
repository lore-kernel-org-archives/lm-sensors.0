From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 30 Apr 2014 15:33:58 +0000
Subject: Re: [lm-sensors] [PATCH 10/10] hwmon: vexpress: Use devm helper for hwmon device registration
Message-Id: <1398872038.24255.41.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
	 <1398707877-22596-11-git-send-email-pawel.moll@arm.com>
	 <535EDD49.8050107@roeck-us.net> <1398870979.24255.37.camel@hornet>
	 <20140430152754.GA30924@roeck-us.net>
In-Reply-To: <20140430152754.GA30924@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arm@kernel.org" <arm@kernel.org>, Jean Delvare <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, 2014-04-30 at 16:27 +0100, Guenter Roeck wrote:
> > I'm not sure I understand the question. The other patch from the series
> 
> The code above seems to change from
> 
>    	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
> 	if (!data->reg)
> 		return -ENODEV;
> 
> to
> 
>    	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
> 	if (IS_ERR(data->reg))
> 		return PTR_ERR(data->reg);
> 
> as part of this patch. This suggests that the return value from
> devm_regmap_init_vexpress_config may have changed from NULL to 
> ERR_PTR. Is my understanding wrong ?

No, you've got it right, but it's me making a mistake in patch splitting
- it is supposed to be a part of the first patch. Thanks for spotting
this!

Pawel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
