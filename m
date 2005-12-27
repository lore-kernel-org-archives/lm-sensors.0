From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Dec 2005 11:13:56 +0000
Subject: [lm-sensors] [PATCH] X1205 cleanup
Message-Id: <20051227121356.0179ad79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051213214058.2781e657@inspiron>
In-Reply-To: <20051213214058.2781e657@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alessandro,

Sorry for the late reply. I've been busy, and then had a holiday break.

> Removes unused functions and data structures.

Applying this patch adds the following warnings:

  CC [M]  drivers/i2c/chips/x1205.o
drivers/i2c/chips/x1205.c:204: warning: `x1205_set_datetime' defined but not used
drivers/i2c/chips/x1205.c:284: warning: `x1205_get_dtrim' defined but not used
drivers/i2c/chips/x1205.c:316: warning: `x1205_get_atrim' defined but not used

What is the point of your cleanup? As I understand it, the driver is no
more exporting any functionality to the rest of the kernel. As it has no
user-space interface either, this means that the only thing the driver
is useful for is running x1205_hctosys at runtime - and even this only
happens if the module parameter hctosys has been set, which isn't the
default.

So you're making your own driver useless? There must be something I am
missing, please explain.

Comments about the code itself:

> +		/* year, since the rtc epoch*/

Missing space before end of comment.

> +		buf[CCR_YEAR] = BIN2BCD(tm->tm_year % 100);
>  		buf[CCR_WDAY] = tm->tm_wday & 0x07;
> -		buf[CCR_Y2K] = BIN2BCD(data->epoch / 100);
> +		buf[CCR_Y2K] = BIN2BCD(tm->tm_year / 100);
>  	}

Isn't this actually changing what the code does? If so, this isn't
suitable for a cleanup patch and should be moved to a separate patch
with proper explanations.

> @@ -387,8 +353,8 @@ static int x1205_hctosys(struct i2c_clie
>  	struct rtc_time tm;
>  	struct timespec tv;
>  
> -	err = x1205_command(client, X1205_CMD_GETDATETIME, &tm);
>  
> +	err = x1205_get_datetime(client, &tm, X1205_CCR_BASE);
>  	if (err) {
>  		dev_err(&client->dev,
>  			"Unable to set the system clock\n");

This change will lead to two consecutive blank lines, which should be
avoided.

> --- linux-nslu2.orig/drivers/i2c/chips/Kconfig	2005-12-13 21:36:26.000000000 +0100
> +++ linux-nslu2/drivers/i2c/chips/Kconfig	2005-12-13 21:38:34.000000000 +0100
> @@ -127,10 +127,11 @@ config SENSORS_MAX6875
>  	  will be called max6875.
>  
>  config RTC_X1205_I2C
> -	tristate "Xicor X1205 RTC chip"
> +	tristate "Xicor/Intersil X1205 RTC chip"
>  	depends on I2C && EXPERIMENTAL
>  	help
> -	  If you say yes here you get support for the Xicor X1205 RTC chip.
> +	  If you say yes here you get support for the
> +	  Xicor/Intersil X1205 RTC chip.

"Xicor/Intelsil X1205" would easily fit at the end of the previous line.

Thanks,
-- 
Jean Delvare

