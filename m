From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Oct 2010 09:28:03 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm90) Add support for
Message-Id: <20101007112803.0891de90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286400191-30824-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286400191-30824-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 6 Oct 2010 14:23:11 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v3 changes:
> - Removed unnecessary constant.
> - Improved update interval calculation to avoid rounding error.
> 
>  drivers/hwmon/lm90.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 1913f8a..afb7a1e 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> (...)
> @@ -385,15 +404,42 @@ static inline void lm90_select_remote_channel(struct i2c_client *client,
>  	}
>  }
>  
> +/*
> + * Set conversion rate.
> + * client->update_lock must be held when calling this function (unless we are
> + * in detection or initialization steps).
> + */
> +static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
> +			      unsigned int interval)
> +{
> +	int i;
> +	unsigned int update_interval;
> +
> +	/* Shift calculations to avoid rounding errors */
> +	interval <<= 2;
> +
> +	/* find the nearest update rate */
> +	for (i = 0, update_interval = LM90_MAX_CONVRATE_MS << 2;
> +	     i < data->max_convrate; i++, update_interval >>= 1)
> +		if (interval >= update_interval * 3 / 4)
> +			break;
> +
> +	i2c_smbus_write_byte_data(client, LM90_REG_W_CONVRATE, i);
> +	/* round the reported interval */
> +	data->update_interval = (update_interval + 2) >> 2;
> +}

This is smart :) I like it a lot. Just not sure why you limited the
shift to 2 bits, shifting by say 6 bits would guarantee that future
devices supporting greater values for the conversion rate register
(up tp 13) would be supported out of the box.

Also note that you may want to use DIV_ROUND_CLOSEST() to make the code
slightly easier to read.

But anyway, your code works just fine for the devices currently
supported, so I can apply the patch as is. I tested the resulting
driver on my ADM1032 evaluation board and everything went fine. Thanks
for your contribution!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
