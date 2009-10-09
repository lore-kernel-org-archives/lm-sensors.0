From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Fri, 09 Oct 2009 08:37:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83791d) Clean up detect function
Message-Id: <200910091037.36536.m.hulsman@tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006201101.220e89ef@hyperion.delvare>
In-Reply-To: <20091006201101.220e89ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tuesday 06 October 2009 20:11:01 Jean Delvare wrote:
> As kind is now hard-coded to -1, there is room for code clean-ups.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Marc Hulsman <m.hulsman@tudelft.nl>
> ---
Looks good,

Acked-by: Marc Hulsman <m.hulsman@tudelft.nl>

Thanks,
Marc


>  drivers/hwmon/w83791d.c |   60
> ++++++++++++++--------------------------------- 1 file changed, 18
> insertions(+), 42 deletions(-)
>
> --- linux-2.6.32-rc3.orig/drivers/hwmon/w83791d.c	2009-10-06
> 10:33:15.000000000 +0200 +++
> linux-2.6.32-rc3/drivers/hwmon/w83791d.c	2009-10-06 12:13:28.000000000
> +0200 @@ -1270,56 +1270,32 @@ static int w83791d_detect(struct i2c_cli
>  		return -ENODEV;
>  	}
>
> -	/* The w83791d may be stuck in some other bank than bank 0. This may
> -	   make reading other information impossible. Specify a force=...
> -	   parameter, and the Winbond will be reset to the right bank. */
> -	if (kind < 0) {
> -		if (w83791d_read(client, W83791D_REG_CONFIG) & 0x80) {
> -			return -ENODEV;
> -		}
> -		val1 = w83791d_read(client, W83791D_REG_BANK);
> -		val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
> -		/* Check for Winbond ID if in bank 0 */
> -		if (!(val1 & 0x07)) {
> -			/* yes it is Bank0 */
> -			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
> -			    ((val1 & 0x80) && (val2 != 0x5c))) {
> -				return -ENODEV;
> -			}
> -		}
> -		/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
> -		   should match */
> -		if (w83791d_read(client, W83791D_REG_I2C_ADDR) != address) {
> +	if (w83791d_read(client, W83791D_REG_CONFIG) & 0x80)
> +		return -ENODEV;
> +
> +	val1 = w83791d_read(client, W83791D_REG_BANK);
> +	val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
> +	/* Check for Winbond ID if in bank 0 */
> +	if (!(val1 & 0x07)) {
> +		if ((!(val1 & 0x80) && val2 != 0xa3) ||
> +		    ( (val1 & 0x80) && val2 != 0x5c)) {
>  			return -ENODEV;
>  		}
>  	}
> +	/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
> +	   should match */
> +	if (w83791d_read(client, W83791D_REG_I2C_ADDR) != address)
> +		return -ENODEV;
>
> -	/* We either have a force parameter or we have reason to
> -	   believe it is a Winbond chip. Either way, we want bank 0 and
> -	   Vendor ID high byte */
> +	/* We want bank 0 and Vendor ID high byte */
>  	val1 = w83791d_read(client, W83791D_REG_BANK) & 0x78;
>  	w83791d_write(client, W83791D_REG_BANK, val1 | 0x80);
>
>  	/* Verify it is a Winbond w83791d */
> -	if (kind <= 0) {
> -		/* get vendor ID */
> -		val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
> -		if (val2 != 0x5c) {	/* the vendor is NOT Winbond */
> -			return -ENODEV;
> -		}
> -		val1 = w83791d_read(client, W83791D_REG_WCHIPID);
> -		if (val1 = 0x71) {
> -			kind = w83791d;
> -		} else {
> -			if (kind = 0)
> -				dev_warn(&adapter->dev,
> -					"w83791d: Ignoring 'force' parameter "
> -					"for unknown chip at adapter %d, "
> -					"address 0x%02x\n",
> -					i2c_adapter_id(adapter), address);
> -			return -ENODEV;
> -		}
> -	}
> +	val1 = w83791d_read(client, W83791D_REG_WCHIPID);
> +	val2 = w83791d_read(client, W83791D_REG_CHIPMAN);
> +	if (val1 != 0x71 || val2 != 0x5c)
> +		return -ENODEV;
>
>  	strlcpy(info->type, "w83791d", I2C_NAME_SIZE);



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
