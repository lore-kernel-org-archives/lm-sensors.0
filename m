From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 20 Oct 2005 00:12:35 +0000
Subject: [lm-sensors] SE95 AGAIN! Houston, we have a problem
Message-Id: <4356C4CB.6000900@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510191559.59358.tonu@jes.ee>
In-Reply-To: <200510191559.59358.tonu@jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tonu Samuel wrote:
> Well, I can't get the point. Anyway, this is my last post till I do not get 
> response. Probably I do something wrong or just people are lazy and 
> lm_sensors project needs some refreshing fork.

Well we are not lazy. Try to work 8 hours a day, or work 4 and spend rest with writing Master thesis.
We have *friends, families etc. We must go shopping, clean the flat etc. Now imagine that
you need like 4hours for all this stuff a day. It is plain impossible to handle that in small team
like lm-sensors is. Especially reviewing of code is very time consumpting so be patient please.

> If I did something wrong here and not welcome - please explain it in private. 
> I have no clue what's going on. Of course I am little bit upset too but this 
> is not so fatal. We all are overloaded with different stuff but being a 
> maintainer is responsibility. At least this is how I understand it. So 
> probably something is wrong with my patches but what?

The only problem so far is that they are not inline and these days we are very busy.


The DS75, DS1775, MAX6625, and MAX6626 are supported as well.
They are not distinguished from an LM75. While most of these chips
have three additional bits of accuracy (12 vs. 9 for the LM75),
the additional bits are not supported. Not only that, but these chips will
not be detected if not in 9-bit precision mode (use the force parameter if
needed).

I must check why we cant extends those chips to bigger precision too.

Here is preliminary pass.

> diff -ur linux-2.6.14-rc3/drivers/hwmon/asb100.c se95/drivers/hwmon/asb100.c
> --- linux-2.6.14-rc3/drivers/hwmon/asb100.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/asb100.c	2005-10-11 23:42:47.000000000 +0300
> @@ -433,7 +433,7 @@
>  
>  	switch (nr) {
>  	case 1: case 2:
> -		ret = sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(reg));
> +		ret = sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(reg, 9));
>  		break;
>  	case 0: case 3: default:
>  		ret = sprintf(buf, "%d\n", TEMP_FROM_REG(reg));
> diff -ur linux-2.6.14-rc3/drivers/hwmon/ds1621.c se95/drivers/hwmon/ds1621.c
> --- linux-2.6.14-rc3/drivers/hwmon/ds1621.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/ds1621.c	2005-10-11 23:49:06.000000000 +0300
> @@ -141,7 +141,7 @@
>  static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
>  {									\
>  	struct ds1621_data *data = ds1621_update_client(dev);		\
> -	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
> +	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value, 9));	\
>  }
>  
>  show(temp);
> diff -ur linux-2.6.14-rc3/drivers/hwmon/lm75.c se95/drivers/hwmon/lm75.c
> --- linux-2.6.14-rc3/drivers/hwmon/lm75.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/lm75.c	2005-10-11 23:38:53.000000000 +0300
> @@ -3,6 +3,14 @@
>               monitoring
>      Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
>  
> +    Added: Philips SE95 Ultra high accuracy digital temperature sensor 
> +    support. SE95 is very similar to lm75 with two major differences:
> +	1. Reading over register boundaries do not cause looping. This
> +	   behaviour makes lm75 detection broken for se95.
> +	2. Instead 9-bit reading it is possible to get 13 bits. Meanwhile
> +	   first 9 bits are exactly same, just 4 more for accuracy.
> +    Copyright (c) 2005  Tonu Samuel <tonu@spam.ee>
> +
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
>      the Free Software Foundation; either version 2 of the License, or
> @@ -43,6 +51,10 @@
>  #define LM75_REG_TEMP_HYST	0x02
>  #define LM75_REG_TEMP_OS	0x03
>  
> +/* Philips SE95 specific values */
> +#define SE95_REG_MANUF_ID	0x05
> +#define SE95_MANUF_ID_VALUE	0xA1
> +
>  /* Each client has this additional data */
>  struct lm75_data {
>  	struct i2c_client	client;
> @@ -53,6 +65,7 @@
>  	u16			temp_input;	/* Register values */
>  	u16			temp_max;
>  	u16			temp_hyst;
> +	char 			precision;	/* precision in bits. 9 for lm75, 13 for se95 */
>  };
>  
>  static int lm75_attach_adapter(struct i2c_adapter *adapter);
> @@ -78,7 +91,7 @@
>  static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
>  {									\
>  	struct lm75_data *data = lm75_update_device(dev);		\
> -	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
> +	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value,data->precision));	\

no space after comma
>  }
>  show(temp_max);
>  show(temp_hyst);
> @@ -119,7 +132,6 @@
>  	struct lm75_data *data;
>  	int err = 0;
>  	const char *name = "";
> -

Do not fix this

>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
>  		goto exit;
> @@ -140,6 +152,12 @@
>  	new_client->driver = &lm75_driver;
>  	new_client->flags = 0;
>  
> +	/* Trying to detect Philips SE95 by manufacturer ID */
> +	if (i2c_smbus_read_byte_data(new_client, SE95_REG_MANUF_ID) = SE95_MANUF_ID_VALUE) {
> +		pr_info("lm75: Philips SE95 detected\n");
> +		name = "se95";
> +		data->precision;
> +	} else
>  	/* Now, we do the remaining detection. There is no identification-
>  	   dedicated register so we have to rely on several tricks:
>  	   unused bits, registers cycling over 8-address boundaries,
> @@ -176,8 +194,8 @@
>  			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
>  			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
>  				goto exit_free;
> +		data->precision=9;
>  	}
> -
>  	/* Determine the chip type - only one kind supported! */
>  	if (kind <= 0)
>  		kind = lm75;
> diff -ur linux-2.6.14-rc3/drivers/hwmon/lm75.h se95/drivers/hwmon/lm75.h
> --- linux-2.6.14-rc3/drivers/hwmon/lm75.h	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/lm75.h	2005-10-11 23:38:20.000000000 +0300
> @@ -40,10 +40,22 @@
>  	return (u16)((ntemp / 500) << 7);
>  }
>  
> -static inline int LM75_TEMP_FROM_REG(u16 reg)
> +static inline int LM75_TEMP_FROM_REG(u16 reg,int bits)

Missing space after ,

>  {
>  	/* use integer division instead of equivalent right shift to
>  	   guarantee arithmetic shift and preserve the sign */
> -	return ((s16)reg / 128) * 500;
> +	switch(bits) {
> +	case 8:

why is 8 here?

> 1+	default:
> +		return ((s16)reg / 128) * 500;
> +		break; /* just paranoid */
> +	case 13:
> +		/* for lm75 we had to drop 7 bits....2^78. For se95 we drop 
> +		   3 unused bits..2^3=8. But each increment is not 0.5 degrees 
> +		   anymore 1/(2^1)=0.5 but 1/(2^5)=0.03125 degrees. */
> +		return ((s16)reg / 8) * 3125 / 100;
> +		break; /* just paranoid */
> +	}
>  }
>  
> +
> diff -ur linux-2.6.14-rc3/drivers/hwmon/w83627ehf.c se95/drivers/hwmon/w83627ehf.c
> --- linux-2.6.14-rc3/drivers/hwmon/w83627ehf.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/w83627ehf.c	2005-10-11 23:50:28.000000000 +0300
> @@ -581,7 +581,7 @@
>  { \
>  	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
>  	return sprintf(buf, "%d\n", \
> -		       LM75_TEMP_FROM_REG(data->reg[nr])); \
> +		       LM75_TEMP_FROM_REG(data->reg[nr], 9)); \
>  }
>  show_temp_reg(temp);
>  show_temp_reg(temp_max);
> diff -ur linux-2.6.14-rc3/drivers/hwmon/w83627hf.c se95/drivers/hwmon/w83627hf.c
> --- linux-2.6.14-rc3/drivers/hwmon/w83627hf.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/w83627hf.c	2005-10-11 23:42:34.000000000 +0300
> @@ -571,7 +571,7 @@
>  	struct w83627hf_data *data = w83627hf_update_device(dev); \
>  	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
>  		return sprintf(buf,"%ld\n", \
> -			(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
> +			(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2], 9)); \
>  	} else {	/* TEMP1 */ \
>  		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
>  	} \
> diff -ur linux-2.6.14-rc3/drivers/hwmon/w83781d.c se95/drivers/hwmon/w83781d.c
> --- linux-2.6.14-rc3/drivers/hwmon/w83781d.c	2005-10-01 00:17:35.000000000 +0300
> +++ se95/drivers/hwmon/w83781d.c	2005-10-11 23:44:37.000000000 +0300
> @@ -422,7 +422,7 @@
>  	struct w83781d_data *data = w83781d_update_device(dev); \
>  	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
>  		return sprintf(buf,"%d\n", \
> -			LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
> +			LM75_TEMP_FROM_REG(data->reg##_add[nr-2], 9)); \
>  	} else {	/* TEMP1 */ \
>  		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
>  	} \
> 
Regards
Rudolf
