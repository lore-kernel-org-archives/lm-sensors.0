From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 15:01:54 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (lm90) Convert to use hwmon_device_register_with_groups
Message-Id: <20140218160154.7ae46fa1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392513995-30712-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392513995-30712-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 17:26:35 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach hwmon attributes to hwmon device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm90.c |   51 ++++++++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 5ddfab0..9abc915 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> (...)
> @@ -1421,10 +1425,9 @@ static void lm90_restore_conf(struct i2c_client *client, struct lm90_data *data)
>  				  data->config_orig);
>  }
>  
> -static void lm90_init_client(struct i2c_client *client)
> +static void lm90_init_client(struct lm90_data *data, struct i2c_client *client)

I can't remember what you did for other drivers, but for a function
named foo_init_client, I'd very much expect the "client" parameter to
come first. In general you try to add new function parameters at the
end anyway.

The rest looks fine.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
