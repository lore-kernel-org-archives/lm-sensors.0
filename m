From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Feb 2012 21:18:02 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <20120216221802.253c8b45@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

On Mon, 13 Feb 2012 00:53:42 -0500, Chris wrote:
> Fixed RPM calculations to not use ppr, and to be closer to what the
> data sheet specifies.
> Signed-off-by: Chris D Schimp <silverchris@gmail.com>
> ---
> You would be very correct about the second bug. I have fixed that bug,
> and removed the use of ppr in this patch attached. I have also changed
> the behavior of the driver as to not change or initialize any
> settings, so that it will leave all the bios or default settings in
> place and clean up the things left over.
> 
> 
> diff -uprN -X linux-3.2.5/Documentation/dontdiff
> old/linux-3.2.5/drivers/hwmon/max6639.c
> new/linux-3.2.5/drivers/hwmon/max6639.c
> --- old/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -0500
> +++ new/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-12 23:16:21.770059276 -0500

This isn't a -p1 patch. Please send only -p1 patches.

> @@ -72,8 +72,8 @@ static unsigned short normal_i2c[] = { 0
> 
>  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> 
> -#define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
> -	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
> +#define FAN_FROM_REG(val, rpm_range)	((val) = 0 ? -1 : \
> +	(val) = 255 ? 0 : (rpm_ranges[rpm_range] * 30) / val)
>  #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)
> 
>  /*
> @@ -333,7 +334,7 @@ static ssize_t show_fan_input(struct dev
>  		return PTR_ERR(data);
> 
>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> -		       data->ppr, data->rpm_range));
> +		       data->rpm_range[attr->index]));

This change looks wrong and produces the following error at build
time:

drivers/hwmon/max6639.c: In function 'show_fan_input':
drivers/hwmon/max6639.c:335:30: error: subscripted value is neither array nor pointer nor vector

Care to build-test your patches before you send them?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
