From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Aug 2011 16:34:18 +0000
Subject: Re: [lm-sensors] [PATCH] [RFC] lm85: fix PWM control on SMSC
Message-Id: <1312562058.9971.109.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308325488-26386-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1308325488-26386-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-08-05 at 09:44 -0400, Steve Glendinning wrote:
> This patch works around a quirk of the hardware's implementation to
> allow raw PWM fan drive values to be set.  Without it the device
> never leaves auto control mode so the PWM output request is ignored.
> 
> I'm not sure if this is the right place for the workaround, comments?
> 
Problem is that your changes are unconditional, meaning any BIOS side
automatic fan control settings would be overwritten and might cause
unpredictable and undesired results.

It would probably make more sense to have this kind of code in
set_pwm_enable(), and only execute it if manual pwm control is selected.
Similar, if automatic pwm control is selected, it might be necessary to
reset the limit to the default to actually enable auto-pwm.

Either case, I think we will have to wait for feedback from Jean, since
he knows the driver much better than me.

Thanks,
Guenter

> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> ---
>  drivers/hwmon/lm85.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index da72dc1..f4e124b 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -1146,8 +1146,21 @@ static const struct attribute_group lm85_group_in567 = {
>  
>  static void lm85_init_client(struct i2c_client *client)
>  {
> +	struct lm85_data *data = i2c_get_clientdata(client);
>  	int value;
>  
> +	/* For emc2300 & emc6d103s when auto temp min is the default value,
> +	 * pwm can never be controlled manually, so change this */
> +	if (data->type = emc6d103s) {
> +		int nr;
> +
> +		for (nr = 0; nr < 3; nr++) {
> +			data->zone[nr].limit = TEMP_TO_REG(-127000);
> +			lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
> +				data->zone[nr].limit);
> +		}
> +	}
> +
>  	/* Start monitoring if needed */
>  	value = lm85_read_value(client, LM85_REG_CONFIG);
>  	if (!(value & 0x01)) {



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
