From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Sep 2010 17:55:37 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: some optimisations
Message-Id: <20100909175537.GA16681@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284052336-25864-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284052336-25864-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

General comments:

- Please select a more descriptive headline, such as
	hwmon: lm75: Add __devinit and __devexit section initializers

- It is useful to provide the patch version to reduce confusion and enable
  version tracking.
  Example:
	[PATCH v3] hwmon: lm75: Add __devinit and __devexit section initializers

- Please cc linux-kernel@vger.kernel.org and Jean Delvare <khali@linux-fr.org>.

On Thu, Sep 09, 2010 at 01:12:16PM -0400, Shubhrajyoti D wrote:
> - updating with Guenter's comments
> 
This and other patch version related comments should be below the --- line.
Otherwise, it will end up in the commit log, which isn't really useful.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Assuming you make above changes and resubmit, feel free to add
	Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

> ---
>  drivers/hwmon/lm75.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ab5b87a..028f961 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -134,7 +134,7 @@ static const struct attribute_group lm75_group = {
>  
>  /* device probe and removal */
>  
> -static int
> +static int __devinit
>  lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct lm75_data *data;
> @@ -196,7 +196,7 @@ exit_free:
>  	return status;
>  }
>  
> -static int lm75_remove(struct i2c_client *client)
> +static int __devexit lm75_remove(struct i2c_client *client)
>  {
>  	struct lm75_data *data = i2c_get_clientdata(client);
>  
> @@ -325,7 +325,7 @@ static struct i2c_driver lm75_driver = {
>  		.pm	= LM75_DEV_PM_OPS,
>  	},
>  	.probe		= lm75_probe,
> -	.remove		= lm75_remove,
> +	.remove		=  __devexit_p(lm75_remove),
>  	.id_table	= lm75_ids,
>  	.detect		= lm75_detect,
>  	.address_list	= normal_i2c,
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
