From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Jun 2014 16:52:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm85) Drop generic detection
Message-Id: <20140611165204.GA9213@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140611183556.58890a5c@endymion.delvare>
In-Reply-To: <20140611183556.58890a5c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 11, 2014 at 06:35:56PM +0200, Jean Delvare wrote:
> Generic detection leads to too many false positives, so drop it. FWIW
> sensors-detect does not have such generic detection. If the user wants
> to force the driver to bind to a not yet supported chip, he/she can
> still do so using sysfs attribute new_device.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Good idea. That was way too generic.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Do you want to take it, or should I ? I have another fix pending, so it would
not make a difference for me.

Thanks,
Guenter

> ---
> Mike, I can credit you for reporting the issue if you want. That will
> put your name and e-mail address in the kernel development logs though,
> so up to you.
> 
>  drivers/hwmon/lm85.c |   33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 
> --- linux-3.15-rc7.orig/drivers/hwmon/lm85.c	2014-03-31 05:40:15.000000000 +0200
> +++ linux-3.15-rc7/drivers/hwmon/lm85.c	2014-06-11 15:45:35.967963827 +0200
> @@ -5,7 +5,7 @@
>   * Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
>   * Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
>   * Copyright (c) 2004        Justin Thiessen <jthiessen@penguincomputing.com>
> - * Copyright (C) 2007--2009  Jean Delvare <jdelvare@suse.de>
> + * Copyright (C) 2007--2014  Jean Delvare <jdelvare@suse.de>
>   *
>   * Chip details at	      <http://www.national.com/ds/LM/LM85.pdf>
>   *
> @@ -39,7 +39,7 @@
>  static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
>  
>  enum chips {
> -	any_chip, lm85b, lm85c,
> +	lm85,
>  	adm1027, adt7463, adt7468,
>  	emc6d100, emc6d102, emc6d103, emc6d103s
>  };
> @@ -75,9 +75,6 @@ enum chips {
>  #define LM85_COMPANY_NATIONAL		0x01
>  #define LM85_COMPANY_ANALOG_DEV		0x41
>  #define LM85_COMPANY_SMSC		0x5c
> -#define LM85_VERSTEP_VMASK              0xf0
> -#define LM85_VERSTEP_GENERIC		0x60
> -#define LM85_VERSTEP_GENERIC2		0x70
>  #define LM85_VERSTEP_LM85C		0x60
>  #define LM85_VERSTEP_LM85B		0x62
>  #define LM85_VERSTEP_LM96000_1		0x68
> @@ -351,9 +348,9 @@ static const struct i2c_device_id lm85_i
>  	{ "adm1027", adm1027 },
>  	{ "adt7463", adt7463 },
>  	{ "adt7468", adt7468 },
> -	{ "lm85", any_chip },
> -	{ "lm85b", lm85b },
> -	{ "lm85c", lm85c },
> +	{ "lm85", lm85 },
> +	{ "lm85b", lm85 },
> +	{ "lm85c", lm85 },
>  	{ "emc6d100", emc6d100 },
>  	{ "emc6d101", emc6d100 },
>  	{ "emc6d102", emc6d102 },
> @@ -1281,7 +1278,7 @@ static int lm85_detect(struct i2c_client
>  {
>  	struct i2c_adapter *adapter = client->adapter;
>  	int address = client->addr;
> -	const char *type_name;
> +	const char *type_name = NULL;
>  	int company, verstep;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -1297,16 +1294,6 @@ static int lm85_detect(struct i2c_client
>  		"Detecting device at 0x%02x with COMPANY: 0x%02x and VERSTEP: 0x%02x\n",
>  		address, company, verstep);
>  
> -	/* All supported chips have the version in common */
> -	if ((verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC &&
> -	    (verstep & LM85_VERSTEP_VMASK) != LM85_VERSTEP_GENERIC2) {
> -		dev_dbg(&adapter->dev,
> -			"Autodetection failed: unsupported version\n");
> -		return -ENODEV;
> -	}
> -	type_name = "lm85";
> -
> -	/* Now, refine the detection */
>  	if (company = LM85_COMPANY_NATIONAL) {
>  		switch (verstep) {
>  		case LM85_VERSTEP_LM85C:
> @@ -1323,6 +1310,7 @@ static int lm85_detect(struct i2c_client
>  					"Found Winbond WPCD377I, ignoring\n");
>  				return -ENODEV;
>  			}
> +			type_name = "lm85";
>  			break;
>  		}
>  	} else if (company = LM85_COMPANY_ANALOG_DEV) {
> @@ -1357,12 +1345,11 @@ static int lm85_detect(struct i2c_client
>  			type_name = "emc6d103s";
>  			break;
>  		}
> -	} else {
> -		dev_dbg(&adapter->dev,
> -			"Autodetection failed: unknown vendor\n");
> -		return -ENODEV;
>  	}
>  
> +	if (!type_name)
> +		return -ENODEV;
> +
>  	strlcpy(info->type, type_name, I2C_NAME_SIZE);
>  
>  	return 0;
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
