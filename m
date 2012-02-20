From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Feb 2012 22:28:58 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <1329776938.23014.40.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-02-20 at 16:58 -0500, Chris wrote:
> Patch to fix PPR register initialization to set both channels
> Signed-off-by: Chris D Schimp <silverchris <at> gmail.com>
> ---
> diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/max6639.c
> b/drivers/hwmon/max6639.c
> --- a/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> +++ b/drivers/hwmon/max6639.c	2012-02-20 16:36:02.553668023 -0500
> @@ -438,7 +438,6 @@ static int max6639_init_client(struct i2
>  				  MAX6639_GCONFIG_POR);
>  	if (err)
>  		goto exit;
> -

Unnecessary whitespace change.

>  	/* Fans pulse per revolution is 2 by default */
>  	if (max6639_info && max6639_info->ppr > 0 &&
>  			max6639_info->ppr < 5)
> @@ -446,11 +445,6 @@ static int max6639_init_client(struct i2
>  	else
>  		data->ppr = 2;
>  	data->ppr -= 1;
> -	err = i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_PPR(i),
> -			data->ppr << 5);
> -	if (err)
> -		goto exit;
> 
>  	if (max6639_info)
>  		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> @@ -458,6 +452,13 @@ static int max6639_init_client(struct i2
> 
>  	for (i = 0; i < 2; i++) {
> 
> +		/* Set Fan pulse per revolution */
> +		err = i2c_smbus_write_byte_data(client,
> +				MAX6639_REG_FAN_PPR(i),
> +				data->ppr << 6);

Just asking ... is this correct ? Original code is << 5.

> +		if (err)
> +			goto exit;
> +
>  		/* Fans config PWM, RPM */
>  		err = i2c_smbus_write_byte_data(client,
>  			MAX6639_REG_FAN_CONFIG1(i),
> 
> On Mon, Feb 20, 2012 at 1:58 PM, Roland Stigge <stigge@antcom.de> wrote:
> > Hi!
> >
> > On 02/20/2012 06:39 PM, Guenter Roeck wrote:
> >>> Please resubmit a (-p1) patch fixing the issue your originally spotted
> >>> instead.
> >>>
> >> We really need input from Roland on the initialization problem.
> >> Might make sense to kwwp him copied on this exchange.
> >
> > Thanks for your notification and sorry for the delay!
> >
> > Unfortunately, when I ported the driver from the other original author,
> > I kept the initialization procedure which is obviously wrong, doing
> > initialization only for one channel. (I adjusted the driver locally
> > platform-dependent, so didn't find a chance for mainline integration and
> > this way, the obvious problems in the mainline driver slipped.)
> >
> > Therefore, a fix for doing this for both channels, possibly in a loop,
> > would be good, IMO.
> >
> > Jean's note about the broken variable initialization is correct. Should
> > have done this differently.
> >
> > The other note about initialization only with platform_data is also a
> > good idea.
> >
> > I'm using the chip on a custom ARM board without BIOS initialization,
> > but providing platform_data in this case should be the correct way, anyway.
> >
> > So Chris, if you are already at it, do it this way. Otherwise please
> > notify me and I can prepare patches.
> >
> > Thanks for your work!
> >
> > Roland



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
