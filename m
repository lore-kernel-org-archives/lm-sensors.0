From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 14:20:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: tmp401: bail-out from tmp401_probe() in case of write errors
Message-Id: <54806DC9.9040704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417687048-21455-1-git-send-email-bgolaszewski@baylibre.com> <1417687048-21455-3-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417687048-21455-3-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On 12/04/2014 01:57 AM, Bartosz Golaszewski wrote:
> The return value of i2c_smbus_read_byte_data() is checked in
> tmp401_init_client(), but only a warning is printed and the device is
> registered anyway. This leads to devices being registered even if they
> cannot be physically detected.
>
> Bail-out from probe in case of write errors and notify the user.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/hwmon/tmp401.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index 5a72d7f..75b3210 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -618,8 +618,8 @@ static const struct attribute_group tmp432_group = {
>    * Begin non sysfs callback code (aka Real code)
>    */
>
> -static void tmp401_init_client(struct tmp401_data *data,
> -			       struct i2c_client *client)
> +static int tmp401_init_client(struct tmp401_data *data,
> +			      struct i2c_client *client)
>   {
>   	int config, config_orig;
>
> @@ -630,8 +630,8 @@ static void tmp401_init_client(struct tmp401_data *data,
>   	/* Start conversions (disable shutdown if necessary) */
>   	config = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
>   	if (config < 0) {
> -		dev_warn(&client->dev, "Initialization failed!\n");
> -		return;
> +		dev_err(&client->dev, "Initialization failed!");
> +		return config;
>   	}
>
>   	config_orig = config;
> @@ -639,6 +639,8 @@ static void tmp401_init_client(struct tmp401_data *data,
>
>   	if (config != config_orig)
>   		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);

No error check and return here ?

Guenter

> +
> +	return 0;
>   }
>
>   static int tmp401_detect(struct i2c_client *client,
> @@ -721,7 +723,7 @@ static int tmp401_probe(struct i2c_client *client,
>   	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct tmp401_data *data;
> -	int groups = 0;
> +	int groups = 0, status;
>
>   	data = devm_kzalloc(dev, sizeof(struct tmp401_data), GFP_KERNEL);
>   	if (!data)
> @@ -732,7 +734,9 @@ static int tmp401_probe(struct i2c_client *client,
>   	data->kind = id->driver_data;
>
>   	/* Initialize the TMP401 chip */
> -	tmp401_init_client(data, client);
> +	status = tmp401_init_client(data, client);
> +	if (status < 0)
> +		return status;
>
>   	/* Register sysfs hooks */
>   	data->groups[groups++] = &tmp401_group;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
