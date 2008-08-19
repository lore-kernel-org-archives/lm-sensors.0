From: Sebastian Witt <hasw@hasw.net>
Date: Tue, 19 Aug 2008 20:58:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (atxp1) Fix device detection logic
Message-Id: <48AB3411.30504@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080629123111.26ffc368@hyperion.delvare>
In-Reply-To: <20080629123111.26ffc368@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Subject: hwmon: (atxp1) Fix device detection logic
> 
> The atxp1 device detection code has a major logic flaw, fix it. Not
> sure how we managed to miss this when the driver was merged...
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Sebastian Witt <se.witt@gmx.net>
> Cc: Sebastian Witt <se.witt@gmx.net>
> ---
> Patch refreshed to apply on top of 2.6.27-rc3.
> 
> I didn't hear of Sebastian in 6 weeks. Can anyone please review this?
> 
>  drivers/hwmon/atxp1.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> --- linux-2.6.27-rc3.orig/drivers/hwmon/atxp1.c	2008-08-05 18:17:05.000000000 +0200
> +++ linux-2.6.27-rc3/drivers/hwmon/atxp1.c	2008-08-13 19:37:43.000000000 +0200
> @@ -31,7 +31,7 @@
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
> -MODULE_VERSION("0.6.2");
> +MODULE_VERSION("0.6.3");
>  MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
>  
>  #define ATXP1_VID	0x00
> @@ -289,16 +289,16 @@ static int atxp1_detect(struct i2c_clien
>  	if (!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
>  	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
>  	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
> -	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0) )) {
> +	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
> +		return -ENODEV;
>  
> -		/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
> -		 * showing the same as register 0x00 */
> -		temp = i2c_smbus_read_byte_data(new_client, 0x00);
> -
> -		if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
> -			 (i2c_smbus_read_byte_data(new_client, 0x11) = temp) ))
> -			return -ENODEV;
> -	}
> +	/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
> +	 * showing the same as register 0x00 */
> +	temp = i2c_smbus_read_byte_data(new_client, 0x00);
> +
> +	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
> +	      (i2c_smbus_read_byte_data(new_client, 0x11) = temp)))
> +		return -ENODEV;
>  
>  	/* Get VRM */
>  	temp = vid_which_vrm();
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
