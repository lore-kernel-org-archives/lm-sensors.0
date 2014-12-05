From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 05 Dec 2014 11:57:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <20141205125722.6f17b2f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu,  4 Dec 2014 10:04:10 -0800, Guenter Roeck wrote:
> A chip returning 0x00 in all registers is erroneously detected
> as LM75. Check hysteresis and temperature limit registers and
> abort if both are 0 to reduce the likelyhood for this to happen.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm75.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index f58439b..6753fd9 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -415,6 +415,12 @@ static int lm75_detect(struct i2c_client *new_client,
>  		 || i2c_smbus_read_byte_data(new_client, 7) != os)
>  			return -ENODEV;
>  	}
> +	/*
> +	 * It is very unlikely that this is a LM75 if both
> +	 * hysteresis and temperature limit registers are 0.
> +	 */
> +	if (hyst = 0 && os = 0)
> +		return -ENODEV;
>  
>  	/* Addresses cycling */
>  	for (i = 8; i <= 248; i += 40) {

Looks reasonable.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Did sensors-detect misdetect that chip as an LM75 too, or was the
extended detection logic there good enough already?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
