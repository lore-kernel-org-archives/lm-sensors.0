From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 16:51:50 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ltc4245) Drop debug messages
Message-Id: <20140223175150.3c9cbbcc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393173685-23067-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393173685-23067-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 23 Feb 2014 08:41:25 -0800, Guenter Roeck wrote:
> The debug messages in this driver have little if any value. Drop them.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop debug messages instead of attaching them to the hwmon device.
> 
>  drivers/hwmon/ltc4245.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 2c6da5d..aa36c23 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -95,7 +95,6 @@ static void ltc4245_update_gpios(struct device *dev)
>  	 * readings as stale by setting them to -EAGAIN
>  	 */
>  	if (time_after(jiffies, data->last_updated + 5 * HZ)) {
> -		dev_dbg(&client->dev, "Marking GPIOs invalid\n");
>  		for (i = 0; i < ARRAY_SIZE(data->gpios); i++)
>  			data->gpios[i] = -EAGAIN;
>  	}
> @@ -141,8 +140,6 @@ static struct ltc4245_data *ltc4245_update_device(struct device *dev)
>  
>  	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
>  
> -		dev_dbg(&client->dev, "Starting ltc4245 update\n");
> -
>  		/* Read control registers -- 0x00 to 0x07 */
>  		for (i = 0; i < ARRAY_SIZE(data->cregs); i++) {
>  			val = i2c_smbus_read_byte_data(client, i);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
