From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Jan 2007 16:38:25 +0000
Subject: [lm-sensors] [PATCH] [2.6.21] Add adt7467 to lm85
Message-Id: <20070125173825.c7a60c7e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olof,

You hit the wrong list. Hardware monitoring driver updates should be
directed to the lm-sensors list, to which I am replying.

On Thu, 25 Jan 2007 01:10:02 -0600, Olof Johansson wrote:
> Enable ADT7467 support in lm85.

Did you make sure that the ADT7467 is 100% compatible with the ADT7463?
The change of major revision number causes me to have a doubt.

> 
> Signed-off-by: Olof Johansson <olof at lixom.net>
> 
> Index: powerpc/drivers/hwmon/lm85.c
> =================================> --- powerpc.orig/drivers/hwmon/lm85.c
> +++ powerpc/drivers/hwmon/lm85.c
> @@ -37,7 +37,7 @@
>  static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
>  
>  /* Insmod parameters */
> -I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
> +I2C_CLIENT_INSMOD_7(lm85b, lm85c, adm1027, adt7463, adt7467, emc6d100, emc6d102);
>  
>  /* The LM85 registers */
>  
> @@ -75,6 +75,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
>  #define	LM85_VERSTEP_ADM1027		0x60
>  #define	LM85_VERSTEP_ADT7463		0x62
>  #define	LM85_VERSTEP_ADT7463C		0x6A
> +#define	LM85_VERSTEP_ADT7467		0x71
>  #define	LM85_VERSTEP_EMC6D100_A0        0x60
>  #define	LM85_VERSTEP_EMC6D100_A1        0x61
>  #define	LM85_VERSTEP_EMC6D102		0x65
> @@ -1172,6 +1173,9 @@ static int lm85_detect(struct i2c_adapte
>  			 || verstep = LM85_VERSTEP_ADT7463C) ) {
>  			kind = adt7463 ;
>  		} else if( company = LM85_COMPANY_ANALOG_DEV
> +		    && (verstep = LM85_VERSTEP_ADT7467) ) {
> +			kind = adt7467 ;
> +		} else if( company = LM85_COMPANY_ANALOG_DEV
>  		    && (verstep & LM85_VERSTEP_VMASK) = LM85_VERSTEP_GENERIC ) {
>  			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
>  				" Defaulting to Generic LM85.\n", verstep );
> @@ -1223,6 +1227,8 @@ static int lm85_detect(struct i2c_adapte
>  		type_name = "adm1027";
>  	} else if ( kind = adt7463 ) {
>  		type_name = "adt7463";
> +	} else if ( kind = adt7467 ) {
> +		type_name = "adt7467";
>  	} else if ( kind = emc6d100){
>  		type_name = "emc6d100";
>  	} else if ( kind = emc6d102 ) {
> @@ -1410,7 +1416,8 @@ static struct lm85_data *lm85_update_dev
>  		/* Have to read extended bits first to "freeze" the
>  		 * more significant bits that are read later.
>  		 */
> -		if ( (data->type = adm1027) || (data->type = adt7463) ) {
> +		if ( (data->type = adm1027) || (data->type = adt7463) ||
> +		     (data->type = adt7467) ) {
>  			int ext1 = lm85_read_value(client,
>  						   ADM1027_REG_EXTEND_ADC1);
>  			int ext2 =  lm85_read_value(client,
> @@ -1459,7 +1466,7 @@ static struct lm85_data *lm85_update_dev
>  
>  		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
>  
> -		if ( data->type = adt7463 ) {
> +		if ( data->type = adt7463 || data->type = adt7467 ) {
>  			if( data->therm_total < ULONG_MAX - 256 ) {
>  			    data->therm_total +>  				lm85_read_value(client, ADT7463_REG_THERM );

Please also update Documentation/hwmon/lm85 and drivers/hwmon/Kconfig.

Thanks,
-- 
Jean Delvare

