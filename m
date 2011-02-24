From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Feb 2011 09:45:52 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110224104552.7775d7af@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Feb 2011 17:15:41 -0500, Lennart Sorensen wrote:
> On Tue, Feb 22, 2011 at 01:27:13PM -0500, Lennart Sorensen wrote:
> > I will do that.  I hope to have an updated patch in a couple of hours.
> 
> OK, here is an updated one:
> 
> Add support for detection of LM75A using the ID register value.
> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index f36eb80..5900926 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -232,6 +232,8 @@ static const struct i2c_device_id lm75_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, lm75_ids);
>  
> +#define LM75A_ID 0xA1
> +
>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int lm75_detect(struct i2c_client *new_client,
>  		       struct i2c_board_info *info)
> @@ -239,6 +241,7 @@ static int lm75_detect(struct i2c_client *new_client,
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	int i;
>  	int cur, conf, hyst, os;
> +	bool is_lm75a = 0;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
> @@ -250,23 +253,43 @@ static int lm75_detect(struct i2c_client *new_client,
>  	   addresses 0x04-0x07 returning the last read value.
>  	   The cycling+unused addresses combination is not tested,
>  	   since it would significantly slow the detection down and would
> -	   hardly add any value. */
> +	   hardly add any value.
> +
> +	   The National Semiconductor LM75A is different than earlier
> +	   LM75s.  It has an ID byte of 0xaX (where X is the chip
> +	   revision, with 1 being the only revision in existance) in
> +	   register 7, and unused registers return 0xff rather than the
> +	   last read value. */
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
> +	if (i2c_smbus_read_byte_data(new_client, 7) = LM75A_ID) {
> +		/* LM 75A returns 0xff on unused registers so
> +		   just to be sure we check for that too. */
> +		if (i2c_smbus_read_byte_data(new_client, 4) != 0xff
> +		 || i2c_smbus_read_byte_data(new_client, 5) != 0xff
> +		 || i2c_smbus_read_byte_data(new_client, 6) != 0xff)
> +			return -ENODEV;
> +		is_lm75a = 1;
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
> @@ -278,9 +301,14 @@ static int lm75_detect(struct i2c_client *new_client,
>  		 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
>  		 || i2c_smbus_read_word_data(new_client, i + 3) != os)
>  			return -ENODEV;
> +		if (is_lm75a && i2c_smbus_read_byte_data(new_client, i + 7) != LM75A_ID)
> +			return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, "lm75", I2C_NAME_SIZE);
> +	if (is_lm75a)
> +		strlcpy(info->type, "lm75a", I2C_NAME_SIZE);
> +	else
> +		strlcpy(info->type, "lm75", I2C_NAME_SIZE);
>  
>  	return 0;
>  }
> 

Applied with minor style fixes, thank you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
