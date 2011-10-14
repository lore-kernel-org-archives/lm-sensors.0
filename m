From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 14 Oct 2011 00:01:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Document why clones are not
Message-Id: <20111014000138.GB16967@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111013231511.787f76f0@endymion.delvare>
In-Reply-To: <20111013231511.787f76f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 13, 2011 at 05:15:11PM -0400, Jean Delvare wrote:
> Explain why clones of the LM75 are generally not detected by the
> driver, and why this isn't going to change. Also update the
> documentation to reflect the list of chip names currently supported by
> the driver.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to -next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/lm75 |   58 ++++++++++++++++++++++++++--------------------
>  drivers/hwmon/lm75.c     |   37 +++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 37 deletions(-)
> 
> --- linux-3.1-rc9.orig/drivers/hwmon/lm75.c	2011-10-13 22:52:01.000000000 +0200
> +++ linux-3.1-rc9/drivers/hwmon/lm75.c	2011-10-13 22:52:10.000000000 +0200
> @@ -249,19 +249,30 @@ static int lm75_detect(struct i2c_client
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
>  
> -	/* Now, we do the remaining detection. There is no identification-
> -	   dedicated register so we have to rely on several tricks:
> -	   unused bits, registers cycling over 8-address boundaries,
> -	   addresses 0x04-0x07 returning the last read value.
> -	   The cycling+unused addresses combination is not tested,
> -	   since it would significantly slow the detection down and would
> -	   hardly add any value.
> -
> -	   The National Semiconductor LM75A is different than earlier
> -	   LM75s.  It has an ID byte of 0xaX (where X is the chip
> -	   revision, with 1 being the only revision in existence) in
> -	   register 7, and unused registers return 0xff rather than the
> -	   last read value. */
> +	/*
> +	 * Now, we do the remaining detection. There is no identification-
> +	 * dedicated register so we have to rely on several tricks:
> +	 * unused bits, registers cycling over 8-address boundaries,
> +	 * addresses 0x04-0x07 returning the last read value.
> +	 * The cycling+unused addresses combination is not tested,
> +	 * since it would significantly slow the detection down and would
> +	 * hardly add any value.
> +	 *
> +	 * The National Semiconductor LM75A is different than earlier
> +	 * LM75s.  It has an ID byte of 0xaX (where X is the chip
> +	 * revision, with 1 being the only revision in existence) in
> +	 * register 7, and unused registers return 0xff rather than the
> +	 * last read value.
> +	 *
> +	 * Note that this function only detects the original National
> +	 * Semiconductor LM75 and the LM75A. Clones from other vendors
> +	 * aren't detected, on purpose, because they are typically never
> +	 * found on PC hardware. They are found on embedded designs where
> +	 * they can be instantiated explicitly so detection is not needed.
> +	 * The absence of identification registers on all these clones
> +	 * would make their exhaustive detection very difficult and weak,
> +	 * and odds are that the driver would bind to unsupported devices.
> +	 */
>  
>  	/* Unused bits */
>  	conf = i2c_smbus_read_byte_data(new_client, 1);
> --- linux-3.1-rc9.orig/Documentation/hwmon/lm75	2011-10-13 22:52:01.000000000 +0200
> +++ linux-3.1-rc9/Documentation/hwmon/lm75	2011-10-13 23:07:02.000000000 +0200
> @@ -12,31 +12,46 @@ Supported chips:
>      Addresses scanned: I2C 0x48 - 0x4f
>      Datasheet: Publicly available at the National Semiconductor website
>                 http://www.national.com/
> -  * Dallas Semiconductor DS75
> -    Prefix: 'lm75'
> -    Addresses scanned: I2C 0x48 - 0x4f
> -    Datasheet: Publicly available at the Dallas Semiconductor website
> -               http://www.maxim-ic.com/
> -  * Dallas Semiconductor DS1775
> -    Prefix: 'lm75'
> -    Addresses scanned: I2C 0x48 - 0x4f
> +  * Dallas Semiconductor DS75, DS1775
> +    Prefixes: 'ds75', 'ds1775'
> +    Addresses scanned: none
>      Datasheet: Publicly available at the Dallas Semiconductor website
>                 http://www.maxim-ic.com/
>    * Maxim MAX6625, MAX6626
> -    Prefix: 'lm75'
> -    Addresses scanned: I2C 0x48 - 0x4b
> +    Prefixes: 'max6625', 'max6626'
> +    Addresses scanned: none
>      Datasheet: Publicly available at the Maxim website
>                 http://www.maxim-ic.com/
>    * Microchip (TelCom) TCN75
>      Prefix: 'lm75'
> -    Addresses scanned: I2C 0x48 - 0x4f
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the Microchip website
> +               http://www.microchip.com/
> +  * Microchip MCP9800, MCP9801, MCP9802, MCP9803
> +    Prefix: 'mcp980x'
> +    Addresses scanned: none
>      Datasheet: Publicly available at the Microchip website
>                 http://www.microchip.com/
>    * Analog Devices ADT75
>      Prefix: 'adt75'
> -    Addresses scanned: I2C 0x48 - 0x4f
> +    Addresses scanned: none
>      Datasheet: Publicly available at the Analog Devices website
>                 http://www.analog.com/adt75
> +  * ST Microelectronics STDS75
> +    Prefix: 'stds75'
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the ST website
> +               http://www.st.com/internet/analog/product/121769.jsp
> +  * Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175, TMP275
> +    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp175', 'tmp75', 'tmp275'
> +    Addresses scanned: none
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/product/tmp100
> +               http://www.ti.com/product/tmp101
> +               http://www.ti.com/product/tmp105
> +               http://www.ti.com/product/tmp75
> +               http://www.ti.com/product/tmp175
> +               http://www.ti.com/product/tmp275
>  
>  Author: Frodo Looijaard <frodol@dds.nl>
>  
> @@ -55,21 +70,16 @@ range of -55 to +125 degrees.
>  The LM75 only updates its values each 1.5 seconds; reading it more often
>  will do no harm, but will return 'old' values.
>  
> -The LM75 is usually used in combination with LM78-like chips, to measure
> -the temperature of the processor(s).
> -
> -The DS75, DS1775, MAX6625, and MAX6626 are supported as well.
> -They are not distinguished from an LM75. While most of these chips
> -have three additional bits of accuracy (12 vs. 9 for the LM75),
> -the additional bits are not supported. Not only that, but these chips will
> -not be detected if not in 9-bit precision mode (use the force parameter if
> -needed).
> -
> -The TCN75 is supported as well, and is not distinguished from an LM75.
> +The original LM75 was typically used in combination with LM78-like chips
> +on PC motherboards, to measure the temperature of the processor(s). Clones
> +are now used in various embedded designs.
>  
>  The LM75 is essentially an industry standard; there may be other
>  LM75 clones not listed here, with or without various enhancements,
> -that are supported.
> +that are supported. The clones are not detected by the driver, unless
> +they reproduce the exact register tricks of the original LM75, and must
> +therefore be instantiated explicitly. The specific enhancements (such as
> +higher resolution) are not currently supported by the driver.
>  
>  The LM77 is not supported, contrary to what we pretended for a long time.
>  Both chips are simply not compatible, value encoding differs.
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
