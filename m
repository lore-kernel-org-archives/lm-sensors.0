From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <3F401E93.4030403@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Why don't we just make it policy that now and in the future we don't 
initialize the limits on the sensors?

We don't know in what crazy way a motherboard manufacturer may have wired or 
scaled the inputs and with the newer sensors, it's leading to shutdowns and 
fan spinup behavior that is "less than optimal".

If the BIOS knows what reasonable limits are, it will set them and we are 
better off reading and displaying those values than resetting them.  If the 
BIOS hasn't set any limits, the hardware almost always (does anyone have a 
counter example?) initializes with the limits at the extreme values.  No harm 
there.  We've got (or had...) a user space library that could initialize 
limits with much more configurability than the drivers ever will have.

I'd really like to see this whole initialization mess go away...

And it would make the drivers blah-blah lines smaller ... :)

:v)

Greg KH wrote:

> ChangeSet 1.1123.18.6, 2003/08/14 14:31:21-07:00, rusty@linux.co.intel.com
> 
> [PATCH] I2C: bugfix for initialization bug in adm1021 driver
> 
> While initializing the adm1021 device, the driver is performing a conversion
> from fixed point to Celcius on values that were declaired as Celcius.  On
> my Dell Precision 220 this results in a shutdown after a couple of minutes
> running.
> 
> This is a very simple patch against the 2.6.0-test3 tree that just removes the
> conversion.
> 
> 
>  drivers/i2c/chips/adm1021.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
> --- a/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
> +++ b/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
> @@ -356,13 +356,13 @@
>  {
>  	/* Initialize the adm1021 chip */
>  	adm1021_write_value(client, ADM1021_REG_TOS_W,
> -			    TEMP_TO_REG(adm1021_INIT_TOS));
> +			    adm1021_INIT_TOS);
>  	adm1021_write_value(client, ADM1021_REG_THYST_W,
> -			    TEMP_TO_REG(adm1021_INIT_THYST));
> +			    adm1021_INIT_THYST);
>  	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
> -			    TEMP_TO_REG(adm1021_INIT_REMOTE_TOS));
> +			    adm1021_INIT_REMOTE_TOS);
>  	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
> -			    TEMP_TO_REG(adm1021_INIT_REMOTE_THYST));
> +			    adm1021_INIT_REMOTE_THYST);
>  	/* Enable ADC and disable suspend mode */
>  	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
>  	/* Set Conversion rate to 1/sec (this can be tinkered with) */
> 
> 
> 

