From: Hartmut Knaack <knaack.h@gmx.de>
Date: Tue, 19 Feb 2013 23:07:41 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: (adt7410) Let suspend/resume depend on CONFIG_PM_SLEEP
Message-Id: <512405BD.9030505@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de> <1360947438-2550-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Lars-Peter Clausen schrieb:
> Only build the suspend/resume code if CONFIG_PM_SLEEP is selected. Currently the
> code is built if CONFIG_PM is selected, but it will also be selected if only
> runtime PM support is built into the kernel.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/hwmon/adt7410.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 4ccee4f..ae80815 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -415,7 +415,7 @@ static const struct i2c_device_id adt7410_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adt7410_ids);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int adt7410_suspend(struct device *dev)
>  {
>  	int ret;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
