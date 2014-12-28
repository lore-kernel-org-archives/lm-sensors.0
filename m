From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Dec 2014 08:24:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
Message-Id: <20141228082447.GA31346@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
 <20141227195825.GF10007@amd>
 <20141227223516.GA18455@amd>
In-Reply-To: <20141227223516.GA18455@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, Jean Delvare <jdelvare@suse.de>, Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Sat, Dec 27, 2014 at 11:35:16PM +0100, Pavel Machek wrote:
> On Sat 2014-12-27 20:58:25, Pavel Machek wrote:
> > On Fri 2014-12-26 13:34:53, Sebastian Reichel wrote:
> > > OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> > > which can be used to determine the SoCs temperature. This patch provides
> > > a DT based driver for the temperature sensor based on an older driver
> > > written by Peter De Schrijver for the Nokia N900 and N9.
> > > 
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > > ---
> > >  drivers/hwmon/Kconfig      |   8 ++
> > >  drivers/hwmon/Makefile     |   1 +
> > >  drivers/hwmon/omap3-temp.c | 307 +++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 316 insertions(+)
> > >  create mode 100644 drivers/hwmon/omap3-temp.c
> > 
> > When it hangs, it loops here:
> > 
> > do {
> > regmap_read(data->syscon, SYSCON_TEMP_REG,&temp_sensor_reg);
> > if ((temp_sensor_reg & eocz_mask) = level)
> >    return true;
> > printk("=");
> > }
> > while (ktime_us_delta(expire, ktime_get()) > 0);
> 
> And this fixes the hang, and makes level handling more readable.
> 
> Fix the timeout code, now it actually works. Driver still fails after
> a while.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/hwmon/omap3-temp.c b/drivers/hwmon/omap3-temp.c
> index 8a69604..1b8c768 100644
> --- a/drivers/hwmon/omap3-temp.c
> +++ b/drivers/hwmon/omap3-temp.c
> @@ -130,9 +130,7 @@ static inline bool wait_for_eocz(struct omap3_temp_data *data,
>  	ktime_t timeout, expire;
>  	u32 temp_sensor_reg, eocz_mask;
>  
>  	eocz_mask = BIT(data->hwdata->eocz_bit);
> -	level &= 1;
> -	level *= eocz_mask;
>  
>  	expire = ktime_add_ns(ktime_get(), max_delay);
>  	timeout = ktime_set(0, min_delay);
> @@ -140,9 +141,9 @@ static inline bool wait_for_eocz(struct omap3_temp_data *data,
>  	schedule_hrtimeout(&timeout, HRTIMER_MODE_REL);
>  	do {
>  		regmap_read(data->syscon, SYSCON_TEMP_REG, &temp_sensor_reg);
> -		if ((temp_sensor_reg & eocz_mask) = level)
> +		if (!!(temp_sensor_reg & eocz_mask) = level)
>  			return true;
> -	} while (ktime_us_delta(expire, ktime_get()) > 0);
> +	} while (ktime_after(expire, ktime_get()));
>  
Does this have to be a hard loop, without sleep ? I am a bit concerned that it
may loop for more than a ms.

Other than that, I assume we'll see an updated version with the coding style
issues and hang-up problems fixed.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
