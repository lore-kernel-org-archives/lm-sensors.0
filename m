From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Aug 2008 09:21:21 +0000
Subject: Re: [lm-sensors] Modify proposal to manage LM75A chips
Message-Id: <20080827112121.2cd301c9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Davide,

On Wed, 27 Aug 2008 09:46:56 +0200, Davide Rizzo wrote:
> I suggest this modify to make LM75 driver support also LM75A chips, that
> otherwise fail a bug-based identification test.

Moving to the lm-sensors list, where this discussion belongs. Also,
please avoid application/octet-stream attachments.

> This check is not working on LM75A.
> If you remove it, the driver will work also with LM75A chips.

If you remove it, the driver will also attach to basically any I2C chip
in address range 0x48-0x4f. This is of course not acceptable, which is
why the change you propose, and which was already proposed many times
in the past [1] [2], has always been rejected.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022879.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-June/023445.html

The fact is that the LM75A can't be detected.

> 
> Signed-off-by: Davide Rizzo <davide@elpa.it>
> ========================================
> diff -urNp linux-2.6.26/drivers/hwmon/lm75.c linux-2.6.26.elpa/drivers/hwmon/lm75.c
> --- linux-2.6.26/drivers/hwmon/lm75.c	2008-07-13 23:51:29.000000000 +0200
> +++ linux-2.6.26.elpa/drivers/hwmon/lm75.c	2008-08-25 16:58:04.000000000 +0200
> @@ -170,17 +170,19 @@ static int lm75_detect(struct i2c_adapte
>  		cur = i2c_smbus_read_word_data(new_client, 0);
>  		conf = i2c_smbus_read_byte_data(new_client, 1);
>  		hyst = i2c_smbus_read_word_data(new_client, 2);
> +/*	This was eliminated because LM75A is not recognized
>  		if (i2c_smbus_read_word_data(new_client, 4) != hyst
>  		 || i2c_smbus_read_word_data(new_client, 5) != hyst
>  		 || i2c_smbus_read_word_data(new_client, 6) != hyst
>  		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -		 	goto exit_free;
> +			goto exit_free;*/
>  		os = i2c_smbus_read_word_data(new_client, 3);
> +/*	This was eliminated because LM75A is not recognized
>  		if (i2c_smbus_read_word_data(new_client, 4) != os
>  		 || i2c_smbus_read_word_data(new_client, 5) != os
>  		 || i2c_smbus_read_word_data(new_client, 6) != os
>  		 || i2c_smbus_read_word_data(new_client, 7) != os)
> -		 	goto exit_free;
> +			goto exit_free;*/
>  
>  		/* Unused bits */
>  		if (conf & 0xe0)

Which system do you have this LM75A on? If this is an embedded system
with platform code, simply declare the device with
i2c_register_board_info(). The lm75 driver supports the "lm75a" type
since kernel 2.6.27-rc2. Otherwise, simply pass a "force" parameter to
the lm75 driver when you load it, to bypass the detection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
