From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Feb 2011 10:51:59 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110219115159.2da19dfe@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lennart,

Please send hwmon patches to the lm-sensors list, as specified in
MAINTAINERS.

On Fri, 18 Feb 2011 14:30:00 -0500, Lennart Sorensen wrote:
> The LM75A can not be detected with the same logic as previous LM75
> designs.  Previous designs would return the last value read when an
> unused register was read.  The LM75 returns 0xff when an usesed register
> is read and it also has a new identity register.
> 
> This patch adds the new detection logic for the LM75A, allowing the lm75
> driver to correctly detect the presence of an LM75A as well as older
> LM75 designs.

Do you actually need to _detect_ an LM75A device? The only reason why
the lm75 driver originally detected the LM75 was because it was very
popular as a hardware monitoring chip on PC mainboards. This was in
years 1998-2001, the LM75 is no longer used for this purpose on modern
PC mainboards. So I would be very surprised if an LM75A was used on PC
mainboards.

For embedded systems, or graphics cards, the preferred way is to
explicitly instantiate the I2C device. Can't just you do this?

> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index f36eb80..6d04cf6 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -250,23 +250,40 @@ static int lm75_detect(struct i2c_client *new_client,
>  	   addresses 0x04-0x07 returning the last read value.
>  	   The cycling+unused addresses combination is not tested,
>  	   since it would significantly slow the detection down and would
> -	   hardly add any value. */
> +	   hardly add any value.
> +
> +	   The LM75A is different.  It has an id byte of 0xaX (where
> +	   X is the chip revision) in register 7, and unused registers
> +	   return 0xff rather than the last read value. */

Maybe this holds for the National Semiconductor LM75A, but not for the
Philips/NXP variant, at least according to the datasheet (no device ID
register.)

>  
> -	/* Unused addresses */
>  	cur = i2c_smbus_read_word_data(new_client, 0);
>  	conf = i2c_smbus_read_byte_data(new_client, 1);
> -	hyst = i2c_smbus_read_word_data(new_client, 2);
> -	if (i2c_smbus_read_word_data(new_client, 4) != hyst
> -	 || i2c_smbus_read_word_data(new_client, 5) != hyst
> -	 || i2c_smbus_read_word_data(new_client, 6) != hyst
> -	 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -		return -ENODEV;
> -	os = i2c_smbus_read_word_data(new_client, 3);
> -	if (i2c_smbus_read_word_data(new_client, 4) != os
> -	 || i2c_smbus_read_word_data(new_client, 5) != os
> -	 || i2c_smbus_read_word_data(new_client, 6) != os
> -	 || i2c_smbus_read_word_data(new_client, 7) != os)
> -		return -ENODEV;
> +
> +	/* First check for LM75A */
> +	if ((i2c_smbus_read_byte_data(new_client, 7) & 0xf0) = 0xa0) {
> +		/* LM 75A returns 0xff on unused registers so
> +		   just to be sure we check for that too. */

This is definitely a good idea. 4 bits for the device ID is weak, other
devices could match. In fact I think we should check all 8 bits for
value 0xa1, as this is what is documented in the datasheet.

> +		if (i2c_smbus_read_byte_data(new_client, 4) != 0xff
> +		 || i2c_smbus_read_byte_data(new_client, 5) != 0xff
> +		 || i2c_smbus_read_byte_data(new_client, 6) != 0xff)
> +			return -ENODEV;
> +		hyst = i2c_smbus_read_word_data(new_client, 2);
> +		os = i2c_smbus_read_word_data(new_client, 3);
> +	} else { /* Traditional style LM75 detection */
> +		/* Unused addresses */
> +		hyst = i2c_smbus_read_word_data(new_client, 2);
> +		if (i2c_smbus_read_word_data(new_client, 4) != hyst
> +		 || i2c_smbus_read_word_data(new_client, 5) != hyst
> +		 || i2c_smbus_read_word_data(new_client, 6) != hyst
> +		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> +			return -ENODEV;
> +		os = i2c_smbus_read_word_data(new_client, 3);
> +		if (i2c_smbus_read_word_data(new_client, 4) != os
> +		 || i2c_smbus_read_word_data(new_client, 5) != os
> +		 || i2c_smbus_read_word_data(new_client, 6) != os
> +		 || i2c_smbus_read_word_data(new_client, 7) != os)
> +			return -ENODEV;
> +	}
>  
>  	/* Unused bits */
>  	if (conf & 0xe0)
> 

Your patch is incomplete, it should set the name to "lm75a" for the
LM75A. Also, later in the detection routine, address cycling is tested
of offsets 1, 2 and 3, it would make sense to do the same for offset 7
(device ID) for the LM75A.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
