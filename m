From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Apr 2012 07:46:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7314) Removed unused defines, and rename OFFSET to SHIFT
Message-Id: <20120422094630.3b44af93@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1335068520-15559-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1335068520-15559-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Apr 2012 21:22:00 -0700, Guenter Roeck wrote:
> Remove unused defines AD7314_PD, AD7314_TEMP_SIGN, and ADT7301_TEMP_SIGN.
> Rename AD7314_TEMP_OFFSET to the more appropriate AD7314_TEMP_SHIFT.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/ad7314.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
> index f85ce70..cfec802 100644
> --- a/drivers/hwmon/ad7314.c
> +++ b/drivers/hwmon/ad7314.c
> @@ -18,21 +18,14 @@
>  #include <linux/hwmon-sysfs.h>
>  
>  /*
> - * AD7314 power mode
> - */
> -#define AD7314_PD		0x2000
> -
> -/*
>   * AD7314 temperature masks
>   */
> -#define AD7314_TEMP_SIGN		0x200
>  #define AD7314_TEMP_MASK		0x7FE0
> -#define AD7314_TEMP_OFFSET		5
> +#define AD7314_TEMP_SHIFT		5
>  
>  /*
>   * ADT7301 and ADT7302 temperature masks
>   */
> -#define ADT7301_TEMP_SIGN		0x2000
>  #define ADT7301_TEMP_MASK		0x3FFF
>  
>  enum ad7314_variant {
> @@ -73,7 +66,7 @@ static ssize_t ad7314_show_temperature(struct device *dev,
>  		return ret;
>  	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
>  	case ad7314:
> -		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
> +		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
>  		data = (data << 6) >> 6;
>  
>  		return sprintf(buf, "%d\n", 250 * data);

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
