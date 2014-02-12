From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Feb 2014 07:49:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (smm665): Return error from i2c_smbus_read_word_swapped
Message-Id: <20140212084942.1ad2697f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392184009-5683-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392184009-5683-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Feb 2014 21:46:49 -0800, Guenter Roeck wrote:
> There is no reason to replace one error code with another,
> and returning -1 as error code is wrong anyway.
> 
> Smatch log:
> drivers/hwmon/smm665.c:225 smm665_read_adc() info: why not propagate 'rv'
> from i2c_smbus_read_word_swapped() instead of (-1)?
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smm665.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
> index d9e1b7d..4ef5802 100644
> --- a/drivers/hwmon/smm665.c
> +++ b/drivers/hwmon/smm665.c
> @@ -222,7 +222,7 @@ static int smm665_read_adc(struct smm665_data *data, int adc)
>  	rv = i2c_smbus_read_word_swapped(client, 0);
>  	if (rv < 0) {
>  		dev_dbg(&client->dev, "Failed to read ADC value: error %d", rv);
> -		return -1;
> +		return rv;
>  	}
>  	/*
>  	 * Validate/verify readback adc channel (in bit 11..14).

Good catch.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
