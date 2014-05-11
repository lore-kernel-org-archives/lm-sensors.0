From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 11 May 2014 22:47:17 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add support for emc1412
Message-Id: <536FFDF5.5070103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140511130023.GA501@dashie>
In-Reply-To: <20140511130023.GA501@dashie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 05/11/2014 06:00 AM, Josef Gajdusek wrote:
> Adds support for emc1412.
>
[ ... ]
> @@ -330,9 +389,9 @@ static int emc1403_detect(struct i2c_client *client,
>   	}
>
>   	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
> -	if (id != 0x01)
> +	if (id != 0x01 && id != 0x04) {
>   		return -ENODEV;
> -
> +	}

Forgot: Please see Documents/CodingStyle, Chapter 3:

	"Do not unnecessarily use braces where a single statement will do."

As it turns out, this change generates a checkpatch warning.

Also, you forgot to sign this patch.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
