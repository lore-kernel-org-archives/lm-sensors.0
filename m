From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 15:16:19 +0000
Subject: Re: [lm-sensors] [PATCH 83/95] hwmon: (w83781d) Convert to use devm_ functions
Message-Id: <20120617171619.3aaa7c15@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-84-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-84-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:24:04 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83781d.c |   46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index a82f508..55422a0 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> (...)
> @@ -1237,25 +1235,22 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	/* Register sysfs hooks */
>  	err = w83781d_create_files(dev, data->type, 0);
>  	if (err)
> -		goto ERROR4;
> +		goto remove_files;
>  
>  	data->hwmon_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		err = PTR_ERR(data->hwmon_dev);
> -		goto ERROR4;
> +		goto remove_files;
>  	}
>  
>  	return 0;
>  
> -ERROR4:
> +remove_files:

For consistency with the isa code, you could name this label
"exit_remove_files", and add a leading space.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
