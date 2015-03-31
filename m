From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 31 Mar 2015 15:44:25 +0000
Subject: Re: [lm-sensors] [PATCH 04/15] hwmon: (it87) Introduce feature flag to reflect internal in7 sensor
Message-Id: <20150331174425.6ef98e19@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 29 Mar 2015 23:33:44 -0700, Guenter Roeck wrote:
> @@ -379,6 +381,7 @@ static const struct it87_devices it87_devices[] = {
>  #define has_fan16_config(data)	((data)->features & FEAT_FAN16_CONFIG)
>  #define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
>  #define has_vid(data)		((data)->features & FEAT_VID)
> +#define has_in7_internal(data)	((data)->features & FEAT_IN7_INTERNAL)

I just noticed that you never actually call this macro. Where you could
do so, you open-coded it instead:

> @@ -1862,6 +1865,11 @@ static int __init it87_find(unsigned short *address,
>  
>  	/* in8 (Vbat) is always internal */
>  	sio_data->internal = (1 << 2);
> +
> +	/* in7 (VSB or VCCH5V) is always internal on some chips */
> +	if (it87_devices[sio_data->type].features & FEAT_IN7_INTERNAL)
> +		sio_data->internal |= (1 << 1);
> +

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
