From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Sep 2010 14:05:23 +0000
Subject: Re: [lm-sensors] [RFC PATCH] lm75: some optimisations
Message-Id: <20100909140523.GA15906@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284037694-16806-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284037694-16806-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 09, 2010 at 09:08:14AM -0400, Shubhrajyoti D wrote:
> Functions that used only at probe may be optimised.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/hwmon/lm75.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ab5b87a..7857b94 100644
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
Other drivers reference the exit function using __devexit_p():

lm78.c:static int __devexit lm78_isa_remove(struct platform_device *pdev);
lm78.c: .remove         = __devexit_p(lm78_isa_remove),

You might want to do the same.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
