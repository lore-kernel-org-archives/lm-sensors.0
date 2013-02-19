From: Hartmut Knaack <knaack.h@gmx.de>
Date: Tue, 19 Feb 2013 23:03:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/9] hwmon: (adt7410) Clear unwanted bits in the config register
Message-Id: <512404A4.1010200@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Make sure to clear the mode bits from the config register before setting the new
> mode. Otherwise we might end up with a different mode than we want to.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 797c2b8..4ccee4f 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -364,6 +364,7 @@ static int adt7410_probe(struct i2c_client *client,
>  	/*
>  	 * Set to 16 bit resolution, continous conversion and comparator mode.
>  	 */
> +	ret &= ~ADT7410_MODE_MASK;
>  	data->config = ret | ADT7410_FULL | ADT7410_RESOLUTION |
>  			ADT7410_EVENT_MODE;
>  	if (data->config != data->oldconfig) {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
