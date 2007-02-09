From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Feb 2007 09:39:22 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070209103922.33967126.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Wed, 07 Feb 2007 10:14:36 +0000, Alan Clucas wrote:
> Attached is the kernel patch and a patch for libsensors as well. The 
> libsensors patch does not include your sensors-detect patch.

Could you please also include the required changes to the sensors
program and possibly sensord as well? These should be trivial.

> I have changed the detected name to ds75, hence the libsensors patch. I 
> haven't managed to find any lm75 devices here, so I haven't tested this 
> on one of those, which would be good before it goes too far. The patch 
> is simple enough, but you never can tell.

I have an LM75, I just tested and it works OK.

Comments on your kernel patch:

> diff -ur linux-2.6.19.2/drivers/hwmon/lm75.c linux/drivers/hwmon/lm75.c
> --- linux-2.6.19.2/drivers/hwmon/lm75.c	2007-02-06 15:53:57.000000000 +0000
> +++ linux/drivers/hwmon/lm75.c	2007-02-06 17:45:19.000000000 +0000
> @@ -34,7 +34,7 @@
>  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
>  
>  /* Insmod parameters */
> -I2C_CLIENT_INSMOD_1(lm75);
> +I2C_CLIENT_INSMOD_2(lm75, ds75);
>  
>  /* Many LM75 constants specified below */
>  
> @@ -153,50 +153,63 @@
>  	new_client->flags = 0;
>  
>  	/* Now, we do the remaining detection. There is no identification-
> -	   dedicated register so we have to rely on several tricks:
> -	   unused bits, registers cycling over 8-address boundaries,
> -	   addresses 0x04-0x07 returning the last read value.
> +	   dedicated register so we have to rely on several tricks.
> +	   The LM75 and DS75 share unused bits. The LM75 has registers
> +	   cycling over 8-address boundaries, and addresses 0x04-0x07 
> +	   returning the last read value.
> +	   The DS75 has addresses 0x04-0x0f returning the last read value,
> +	   but does not register cycle.
>  	   The cycling+unused addresses combination is not tested,
>  	   since it would significantly slow the detection down and would
>  	   hardly add any value. */
>  	if (kind < 0) {
> -		int cur, conf, hyst, os;
> +		int cur, conf, hyst, os, addr;
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
> +
> +		for (addr = 0x04; addr <= 0x0f; addr++)
> +			if (i2c_smbus_read_word_data(new_client, addr) != hyst)
> +				break;
> +
> +		if (addr < 0x08)
> +			goto exit_free;
> +		if (addr = 0x10)
> +			kind = ds75;
> +		else
> +			kind = lm75;
> +
>  		os = i2c_smbus_read_word_data(new_client, 3);
> -		if (i2c_smbus_read_word_data(new_client, 4) != os
> -		 || i2c_smbus_read_word_data(new_client, 5) != os
> -		 || i2c_smbus_read_word_data(new_client, 6) != os
> -		 || i2c_smbus_read_word_data(new_client, 7) != os)
> -		 	goto exit_free;
> +		for (addr = 0x04; addr <= 0x0f; addr++)
> +			if (i2c_smbus_read_word_data(new_client, addr) != os)
> +				break;
> +
> +		if (addr < (kind = ds75 ? 0x10 : 0x08))
> +			goto exit_free;

It's smart :) I admit I had no clear idea how to implement the
detection efficiently. I like your approach.

>  
>  		/* Unused bits */
>  		if (conf & 0xe0)
>  		 	goto exit_free;

Note that this requires the DS75 to be in 9-bit resolution mode. The
dump you provided suggests your DS75 is in 10-bit resolution mode, so I
expect it not to be detected properly. Maybe this is OK as a first
approximation, but you may want to submit a second patch to properly
support the high resolution modes of the DS75.

>  
> -		/* Addresses cycling */
> -		for (i = 8; i < 0xff; i += 8)
> -			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
> -			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
> -			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
> -				goto exit_free;
> -	}
> +		/* Addresses cycling - LM75 only*/

Missing space before end of comment.

> +		if (kind = lm75)
> +			for (i = 8; i < 0xff; i += 8)
> +				if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
> +				    || i2c_smbus_read_word_data(new_client, i + 2) != hyst
> +				    || i2c_smbus_read_word_data(new_client, i + 3) != os)
> +					goto exit_free;

I strongly suggest adding a pair of curly braces for the outer-most if
statement. Three nested statements without any curly braces is asking
for trouble on any further change.

>  
> -	/* Determine the chip type - only one kind supported! */
> -	if (kind <= 0)
> -		kind = lm75;
> +	}

This change breaks the case kind = 0, you'll end up with an empty
name. You need to force the type to one of the supported ones if the
user uses force without a kind.

>  
> +	/* Determine the chip type */
>  	if (kind = lm75) {
>  		name = "lm75";
>  	}
> +	else if (kind = ds75) {
> +		name = "ds75";
> +	}
>  
>  	/* Fill in the remaining client fields and put it into the global list */
>  	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> 

Can you also please update Documentation/hwmon/lm75 to mention the
separate prefix?

Thanks,
-- 
Jean Delvare

