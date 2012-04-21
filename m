From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 21 Apr 2012 07:18:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7314) Fix build warning
Message-Id: <20120421091835.73fe4e05@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 20 Apr 2012 08:39:17 -0700, Guenter Roeck wrote:
> The following build warning is seen in some configurations.
> 
> drivers/hwmon/ad7314.c: In function 'ad7314_show_temperature':
> drivers/hwmon/ad7314.c:70: warning: 'data' may be used uninitialized in this function
> 
> Fix by overloading the return value from ad7314_spi_read with both data and
> error code (the returned data is really u16 and needs to be converted into a
> signed value anyway).
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/ad7314.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
> index ce43642..f85ce70 100644
> --- a/drivers/hwmon/ad7314.c
> +++ b/drivers/hwmon/ad7314.c
> @@ -47,7 +47,7 @@ struct ad7314_data {
>  	u16 rx ____cacheline_aligned;
>  };
>  
> -static int ad7314_spi_read(struct ad7314_data *chip, s16 *data)
> +static int ad7314_spi_read(struct ad7314_data *chip)
>  {
>  	int ret;
>  
> @@ -57,9 +57,7 @@ static int ad7314_spi_read(struct ad7314_data *chip, s16 *data)
>  		return ret;
>  	}
>  
> -	*data = be16_to_cpu(chip->rx);
> -
> -	return ret;
> +	return be16_to_cpu(chip->rx);
>  }
>  
>  static ssize_t ad7314_show_temperature(struct device *dev,
> @@ -70,12 +68,12 @@ static ssize_t ad7314_show_temperature(struct device *dev,
>  	s16 data;
>  	int ret;
>  
> -	ret = ad7314_spi_read(chip, &data);
> +	ret = ad7314_spi_read(chip);
>  	if (ret < 0)
>  		return ret;
>  	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
>  	case ad7314:
> -		data = (data & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
> +		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
>  		data = (data << 6) >> 6;
>  
>  		return sprintf(buf, "%d\n", 250 * data);
> @@ -86,7 +84,7 @@ static ssize_t ad7314_show_temperature(struct device *dev,
>  		 * with a sign bit - which is a 14 bit 2's complement
>  		 * register.  1lsb - 31.25 milli degrees centigrade
>  		 */
> -		data &= ADT7301_TEMP_MASK;
> +		data = ret & ADT7301_TEMP_MASK;
>  		data = (data << 2) >> 2;
>  
>  		return sprintf(buf, "%d\n",

This change looks good:

Acked-by: Jean Delvare <khali@linux-fr.org>

The original code looks a little weird though. Some of the defined
constants aren't used, "offset" is used where "shift" should be.
Introducing function sign_extend16 would also make the code more
readable. I'll send a patch...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
