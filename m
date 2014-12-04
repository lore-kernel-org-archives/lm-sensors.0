From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 21:24:08 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/3] hwmon: tmp401: add support for TI TMP435
Message-Id: <20141204212408.GA10390@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417711553-21311-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417711553-21311-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, Dec 04, 2014 at 05:45:51PM +0100, Bartosz Golaszewski wrote:
> From: Patrick Titiano <ptitiano@baylibre.com>
> 
> Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>
> [Bartosz Golaszewski: prepared for submission, code review fixes]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/hwmon/tmp401.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index 7fa6e7d..ccd9938 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -46,7 +46,7 @@
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
>  
> -enum chips { tmp401, tmp411, tmp431, tmp432 };
> +enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
>  
>  /*
>   * The TMP401 registers, note some registers have different addresses for
> @@ -136,6 +136,7 @@ static const u8 TMP432_STATUS_REG[] = {
>  #define TMP411C_DEVICE_ID			0x10
>  #define TMP431_DEVICE_ID			0x31
>  #define TMP432_DEVICE_ID			0x32
> +#define TMP435_DEVICE_ID			0x35
>  
>  /*
>   * Driver data (common to all clients)
> @@ -146,6 +147,7 @@ static const struct i2c_device_id tmp401_id[] = {
>  	{ "tmp411", tmp411 },
>  	{ "tmp431", tmp431 },
>  	{ "tmp432", tmp432 },
> +	{ "tmp435", tmp435 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp401_id);
> @@ -684,6 +686,11 @@ static int tmp401_detect(struct i2c_client *client,
>  			return -ENODEV;
>  		kind = tmp432;
>  		break;
> +	case TMP435_DEVICE_ID:
> +		if (client->addr != 0x4c)
> +			return -ENODEV;

On second thought, is this really correct ?

I had another look into the datasheet. It seems to me that the chip
may support up to 9 different addresses, though that is a bit vague
since the datasheet first claims that the address would be 0x4c,
only to go on and list the 9 addresses (0x48 to 0x4f as well as 0x37)
in the next paragraph.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
