From: fishor@gmx.net (Alexey Fisher)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: max1619
Message-Id: <200405231411.52094.fishor@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

> Not sure I get what you mean. At any rate, the Linux kernel is written
> in C and no C++ code is allowed. Just start from an existing driver, and
> it shouldn't be too hard to adapt the code for your MAX1619 chip.

I mean, i don't know C at all, i jas wont to lern it and it will be greate if 
you have and can send me  some DOC about C. 

> +	if (kind < 0)
> +	{
> +		u8 reg_config, reg_convrate;
> +		reg_config = i2c_smbus_read_byte_data(new_client,
> +			MAX1619_REG_R_CONFIG);
> +		reg_convrate = i2c_smbus_read_byte_data(new_client,
> +			MAX1619_REG_R_CONVRATE);
> +
> +		if ((reg_config & 0x03) != 0x00 )
> +		{
> You forgot to cgecj trhe conversion rate register . It has to be <> 0x07. You could use the status register as well, for which reg & 0x61
> should be 0.

Hear i'm not sure what you mean

if ((reg_config & 0x2A) != 0x00  || reg_convrate <= 0x07 || (reg_status & 
0x61) != 0x00)

is it corect ?

> +	i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONVRATE,
> +		5); /* 2 Hz */
> +	config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
> +	if (config & 0x40)
> +		i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONFIG,
> +			config & 0x0C); /* run */
> +}
>
> This doesn't preserve configuration bits. You should write back config &
> 0xBF.
I can't yus 0xbf wile it bringing up OVERT output, it's mean HYST and CRIT 
can't do any think. For max1619   0x9f , this preserve and doesn't have OVERT 
bit.
