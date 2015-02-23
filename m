From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 23 Feb 2015 16:51:22 +0000
Subject: Re: [lm-sensors] [PATCH v4 7/8] hwmon: pwm-fan: Read PWM FAN configuration from device tree
Message-Id: <20150223175122.2c0a4645@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-8-git-send-email-l.majewski@samsung.com>
 <54E7D0B3.7040800@roeck-us.net> <20150223171336.2e09ce50@amdc2363>
 <20150223162305.GB2165@roeck-us.net>
In-Reply-To: <20150223162305.GB2165@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi Guenter,

> On Mon, Feb 23, 2015 at 05:13:36PM +0100, Lukasz Majewski wrote:
> > Hi Guenter,
> > 
> [ ... ]
> 
> > > 
> > > If devicetree is not configured, of_property_count_elems_of_size
> > > returns -ENOSYS, which is returned, causing the driver to fail
> > > loading.
> > 
> > Has of_property_count_elems_of_size() returns -ENOSYS?
> > 
> > Maybe something has changed, but in my linux-vanila (3.19-rc4)
> > at ./drivers/of/base.c it returns -EINVAL, -ENODATA or number of
> > elements.
> > 
> > Have I missed something?
> > 
> Hi Lukasz,
> 
> Yes, you have. Check include/linux/of.h, line 484, in latest mainline.

Ok. Now I got it.

The above situation shouldn't happen if I put of_find_property() check
on the very beginning of this function (it returns NULL when DT support
is not compiled).

The function would look as follows:

int 
pwm_fan_of_get_cooling_data(struct device *dev, struct pwm_fan_ctx
*ctx) 
{       
        struct device_node *np = dev->of_node;
	int num, i, ret;

	if (!of_find_property(np, "cooling-levels", NULL))
		return 0;

	ret = of_property_count_u32_elems(np, "cooling-levels");
	if (ret <= 0) {
		dev_err(dev, "Wrong data!\n");
		return ret;
	}

	num = ret;
	ctx->pwm_fan_cooling_levels = devm_kzalloc(dev, num *
					sizeof(u32), GFP_KERNEL); 
	if (!ctx->pwm_fan_cooling_levels) 
		return -ENOMEM;

	ret = of_property_read_u32_array(np, "cooling-levels",
					 ctx->pwm_fan_cooling_levels,
					 num); 
	if (ret) {
		dev_err(dev, "Property 'cooling-levels' cannot be
			read!\n"); 
		return ret;
	}

	for (i = 0; i < num; i++) {
		if (ctx->pwm_fan_cooling_levels[i] > MAX_PWM) {
			dev_err(dev, "PWM fan state[%d]:%d > %d\n", i,
				ctx->pwm_fan_cooling_levels[i],
				MAX_PWM); 
			return -EINVAL;
		}
	}

	ctx->pwm_fan_max_state = num - 1;

	return 0;
}

> 
> Guenter



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
