From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 16:25:21 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/3] hwmon: tmp401: bail-out from tmp401_probe() in case of write errors
Message-Id: <20141204162521.GD7385@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417706574-1023-1-git-send-email-bgolaszewski@baylibre.com>
 <1417706574-1023-4-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417706574-1023-4-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, Dec 04, 2014 at 04:22:54PM +0100, Bartosz Golaszewski wrote:
> The return value of i2c_smbus_read_byte_data() is checked in
> tmp401_init_client(), but only a warning is printed and the device is
> registered anyway. This leads to devices being registered even if they
> cannot be physically detected.
> 
> Bail-out from probe in case of write errors and notify the user.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/hwmon/tmp401.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index a5f0973..ce7e579 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -618,10 +618,10 @@ static const struct attribute_group tmp432_group = {
>   * Begin non sysfs callback code (aka Real code)
>   */
>  
> -static void tmp401_init_client(struct tmp401_data *data,
> -			       struct i2c_client *client)
> +static int tmp401_init_client(struct tmp401_data *data,
> +			      struct i2c_client *client)
>  {
> -	int config, config_orig;
> +	int config, config_orig, status;
>  
>  	/* Set the conversion rate to 2 Hz */
>  	i2c_smbus_write_byte_data(client, TMP401_CONVERSION_RATE_WRITE, 5);
> @@ -629,16 +629,21 @@ static void tmp401_init_client(struct tmp401_data *data,
>  
>  	/* Start conversions (disable shutdown if necessary) */
>  	config = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
> -	if (config < 0) {
> -		dev_warn(&client->dev, "Initialization failed!\n");
> -		return;
> -	}
> +	if (config < 0)
> +		return config;
>  
>  	config_orig = config;
>  	config &= ~TMP401_CONFIG_SHUTDOWN;
>  
> -	if (config != config_orig)
> -		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);
> +	if (config != config_orig) {
> +		status = i2c_smbus_write_byte_data(client,
> +						   TMP401_CONFIG_WRITE,
> +						   config);
> +		if (status < 0)
> +			return status;

Just pre-initialize status to 0 and return status unconditionally.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
