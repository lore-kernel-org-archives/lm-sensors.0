From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Apr 2008 14:10:31 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: Fix lm75a detection
Message-Id: <20080418161031.35059a01@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161334.10533.laurentp@cse-semaphore.com>
In-Reply-To: <200804161334.10533.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Laurent,

On Wed, 16 Apr 2008 13:34:09 +0200, Laurent Pinchart wrote:
> Philips LM75A temperature sensors don't pass the current detection check
> as they return 0xffff when reading unimplemented registers instead of the
> last read value. This patch modifies device detection to accept 0xffff as
> valid values when reading registers 0x04-0x07.

In fact almost no LM75 clone mimics the original behavior perfectly so
they all need to be forced with a module parameter at the moment. I
have always been reluctant to update the detection code to support them
all, as this would weaken it to a point where about any device at any
of the 8 supported I2C addresses would be picked.

May I ask on which system you have the Philips LM75A chip? If that's an
embedded system where you will end up using the new-style lm75 driver,
then I'd rather focus on getting this new-style driver ready, instead
of updating the detection code.

I'm reviewing your patch still, in case we finally decide to apply it:

> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  drivers/hwmon/lm75.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 115f409..d7a22a5 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -159,28 +159,29 @@ static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
>  	/* Now, we do the remaining detection. There is no identification-
>  	   dedicated register so we have to rely on several tricks:
>  	   unused bits, registers cycling over 8-address boundaries,
> -	   addresses 0x04-0x07 returning the last read value.
> +	   addresses 0x04-0x07 returning the last read value (LM75) or
> +	   0xffff (Philips LM75A).

Does the chip really return 0xffff or is the SMBus read returning an
error which in turn is converted to 0xffff? i2cdump w should tell.

>  	   The cycling+unused addresses combination is not tested,
>  	   since it would significantly slow the detection down and would
>  	   hardly add any value. */
>  	if (kind < 0) {
> -		int cur, conf, hyst, os;
> +		int cur, conf, hyst, os, na;
>  
>  		/* Unused addresses */
>  		cur = i2c_smbus_read_word_data(new_client, 0);
>  		conf = i2c_smbus_read_byte_data(new_client, 1);
>  		hyst = i2c_smbus_read_word_data(new_client, 2);
> -		if (i2c_smbus_read_word_data(new_client, 4) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 5) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 6) != hyst
> -		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
> -		 	goto exit_free;
> +		for (i = 4; i < 8; ++i) {
> +			na = i2c_smbus_read_word_data(new_client, i);
> +			if (na != hyst && na != 0xffff)
> +				goto exit_free;
> +		}

This will accept all combinations of hyst and 0xffff, while ideally
only "all hyst" or "all 0xffff" should be accepted, for more
robustness.

>  		os = i2c_smbus_read_word_data(new_client, 3);
> -		if (i2c_smbus_read_word_data(new_client, 4) != os
> -		 || i2c_smbus_read_word_data(new_client, 5) != os
> -		 || i2c_smbus_read_word_data(new_client, 6) != os
> -		 || i2c_smbus_read_word_data(new_client, 7) != os)
> -		 	goto exit_free;
> +		for (i = 4; i < 8; ++i) {
> +			na = i2c_smbus_read_word_data(new_client, i);
> +			if (na != os && na != 0xffff)
> +				goto exit_free;
> +		}

Note that this second loop only makes sense if the hyst value was
returned in the first loop. If 0xffff was returned then the second loop
will certainly return 0xffff again so there's no point in testing it
again.

>  
>  		/* Unused bits */
>  		if (conf & 0xe0)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
