From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Feb 2014 20:21:32 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm63) Create all sysfs groups in one call
Message-Id: <20140202212132.18635e75@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390243126-19519-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390243126-19519-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 20 Jan 2014 10:38:45 -0800, Guenter Roeck wrote:
> We can create all sysfs groups in one call by using sysfs_create_groups
> instead of using sysfs_create_group individually for each group.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch is purely to prepare for the next patch in the series.
> Both could be merged, though I think it makes sense to keep it separate
> to show the sequence of changes.

I'm fine with the changes and either way is fine with me. Just one note:

> 
>  drivers/hwmon/lm63.c |   38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 438e612..b56cb9f 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> (...)
> @@ -1105,10 +1106,12 @@ static void lm63_init_client(struct i2c_client *client)
>  static int lm63_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;

I prefer when this kind of change is done separately, so it doesn't
distract me from the actual changes when reviewing a patch.

>  	struct lm63_data *data;
> +	int groups = 0;
>  	int err;
>  
> -	data = devm_kzalloc(&client->dev, sizeof(struct lm63_data), GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(struct lm63_data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
