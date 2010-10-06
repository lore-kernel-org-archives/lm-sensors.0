From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Oct 2010 15:05:53 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Introduce chip
Message-Id: <20101006170553.42adbfc9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 5 Oct 2010 08:38:26 -0700, Guenter Roeck wrote:
> Instead of using switch/case and if statements in probe, define chip specific
> functionality in a parameter structure array.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm90.c |   92 ++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 60 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 302d9eb..9df08e1 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -190,6 +190,63 @@ static const struct i2c_device_id lm90_id[] = {
>  MODULE_DEVICE_TABLE(i2c, lm90_id);
>  
>  /*
> + * chip type specific parameters
> + */
> +struct lm90_params {
> +	u32 flags;		/* Capabilities */

Any reason why you don't use u16? there aren't that many flags yet, and
u16 divides the size of lm90_params[] below by 2.

> +	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
> +				/* Upper 8 bits for max6695/96 */
> +};
> +
> +static const struct lm90_params lm90_params[] = {
> +	[adm1032] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7c,
> +	},
> +	[adt7461] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7c,
> +	},
> +	[lm86] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7b,
> +	},
> +	[lm90] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7b,
> +	},
> +	[lm99] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7b,
> +	},
> +	[max6646] = {
> +		.flags = LM90_HAVE_LOCAL_EXT,
> +		.alert_alarms = 0x7c,
> +	},
> +	[max6657] = {
> +		.flags = LM90_HAVE_LOCAL_EXT,
> +		.alert_alarms = 0x7c,
> +	},
> +	[max6659] = {
> +		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY,
> +		.alert_alarms = 0x7c,
> +	},
> +	[max6680] = {
> +		.flags = LM90_HAVE_OFFSET,
> +		.alert_alarms = 0x7c,
> +	},
> +	[max6696] = {
> +		.flags = LM90_HAVE_LOCAL_EXT | LM90_HAVE_EMERGENCY
> +		  | LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3,
> +		.alert_alarms = 0x187c,
> +	},
> +	[w83l771] = {
> +		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
> +		.alert_alarms = 0x7c,
> +	},
> +};
> +
> +/*
>   * Client data (each client gets its own)
>   */
>  
> @@ -199,7 +256,7 @@ struct lm90_data {
>  	char valid; /* zero until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
>  	int kind;
> -	int flags;
> +	u32 flags;
>  
>  	u8 config_orig;		/* Original configuration register value */
>  	u16 alert_alarms;	/* Which alarm bits trigger ALERT# */
> @@ -1201,39 +1258,10 @@ static int lm90_probe(struct i2c_client *new_client,
>  
>  	/* Different devices have different alarm bits triggering the
>  	 * ALERT# output */
> -	switch (data->kind) {
> -	case lm90:
> -	case lm99:
> -	case lm86:
> -		data->alert_alarms = 0x7b;
> -		break;
> -	case max6696:
> -		data->alert_alarms = 0x187c;
> -		break;
> -	default:
> -		data->alert_alarms = 0x7c;
> -		break;
> -	}
> +	data->alert_alarms = lm90_params[data->kind].alert_alarms;
>  
>  	/* Set chip capabilities */
> -	if (data->kind != max6657 && data->kind != max6659
> -	    && data->kind != max6646 && data->kind != max6696)
> -		data->flags |= LM90_HAVE_OFFSET;
> -
> -	if (data->kind = max6657 || data->kind = max6659
> -	    || data->kind = max6646 || data->kind = max6696)
> -		data->flags |= LM90_HAVE_LOCAL_EXT;
> -
> -	if (data->kind != max6657 && data->kind != max6659
> -	    && data->kind != max6646 && data->kind != max6680
> -	    && data->kind != max6696)
> -		data->flags |= LM90_HAVE_REM_LIMIT_EXT;
> -
> -	if (data->kind = max6659 || data->kind = max6696)
> -		data->flags |= LM90_HAVE_EMERGENCY;
> -
> -	if (data->kind = max6696)
> -		data->flags |= LM90_HAVE_EMERGENCY_ALARM | LM90_HAVE_TEMP3;
> +	data->flags = lm90_params[data->kind].flags;
>  
>  	/* Initialize the LM90 chip */
>  	lm90_init_client(new_client);

I like this change a lot, even though it makes the binary module a
little larger. This is a lot cleaner. Consider it applied.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
