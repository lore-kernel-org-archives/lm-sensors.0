From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Nov 2014 14:21:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Add support for the NXP LM75B
Message-Id: <545B83EC.7000304@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1415282376-3055-1-git-send-email-michael.thalmeier@hale.at>
In-Reply-To: <1415282376-3055-1-git-send-email-michael.thalmeier@hale.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Thalmeier <michael.thalmeier@hale.at>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11/06/2014 05:59 AM, Michael Thalmeier wrote:
> It is basically a faster lm75 with improved (11 bit) resolution.
>
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>   Documentation/hwmon/lm75 | 6 ++++++
>   drivers/hwmon/lm75.c     | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
> index c6a5ff1..62e216a 100644
> --- a/Documentation/hwmon/lm75
> +++ b/Documentation/hwmon/lm75
> @@ -53,6 +53,12 @@ Supported chips:
>                  http://www.ti.com/product/tmp75
>                  http://www.ti.com/product/tmp175
>                  http://www.ti.com/product/tmp275
> +  * NXP LM75B
> +    Prefix: 'lm75b'
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the NXP website
> +               http://www.nxp.com/documents/data_sheet/LM75B.pdf
> +
>
No additional newline, please.

>   Author: Frodo Looijaard <frodol@dds.nl>
>
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index d16dbb33a..7ec5ccd 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -44,6 +44,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>   	g751,
>   	lm75,
>   	lm75a,
> +	lm75b,
>   	max6625,
>   	max6626,
>   	mcp980x,
> @@ -271,6 +272,10 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   		data->resolution = 12;
>   		data->sample_time = HZ / 2;
>   		break;
> +	case lm75b:
> +		data->resolution = 11;
> +		data->sample_time = HZ / 4;
> +		break;

Alphabetic order, please.

>   	}
>
>   	/* configure as specified */
> @@ -334,6 +339,7 @@ static const struct i2c_device_id lm75_ids[] = {
>   	{ "tmp175", tmp175, },
>   	{ "tmp275", tmp275, },
>   	{ "tmp75", tmp75, },
> +	{ "lm75b", lm75b, },

Alphabetic order, please.

Thanks,
Guenter

>   	{ /* LIST END */ }
>   };
>   MODULE_DEVICE_TABLE(i2c, lm75_ids);
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
