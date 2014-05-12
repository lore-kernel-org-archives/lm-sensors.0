From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 16:14:15 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc14x2
Message-Id: <20140512161415.GA16770@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140512123409.GB16252@dashie>
In-Reply-To: <20140512123409.GB16252@dashie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Josef,

On Mon, May 12, 2014 at 02:34:09PM +0200, Josef Gajdusek wrote:
> Adds support for emc1402/emc1412/emc1422 temperature monitoring chips.
> This line of sensors does only have 2 channels (internal and external) in comparison to the emc14x3 (3 channels) and emc14x4 (4 channels) lines.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>

Applied, with a couple of minor adjustments.

> ---

[ ... ]
>  
>  static const unsigned short emc1403_address_list[] = {
> -	0x18, 0x29, 0x4c, 0x4d, I2C_CLIENT_END
> +	0x18, 0x29, 0x1c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END

Changed to numerical order.

>  };
>  
> +/* Last number in name indicates the amount of channels */

I found that comment a bit confusing, so I changed it to

/* Last digit of chip name indicates number of channels */

>  static const struct i2c_device_id emc1403_idtable[] = {
> -	{ "emc1403", 0 },
> -	{ "emc1404", 1 },
> -	{ "emc1423", 0 },
> -	{ "emc1424", 1 },
> +	{ "emc1402", emc1402 },
> +	{ "emc1403", emc1403 },
> +	{ "emc1404", emc1404 },
> +	{ "emc1422", emc1402 },
> +	{ "emc1423", emc1403 },
> +	{ "emc1424", emc1404 },

Wonder if we should list the emc141x chips here. Jean, any thoughts ?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
> 

It would be nice to also have support for the alarms on EMC14x2,
but that can be a separate patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
