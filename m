From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 12:05:19 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-volt-test.patch
Message-Id: <20070618140519.5a3e2cf6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46759456.9080905@hhs.nl>
In-Reply-To: <46759456.9080905@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 17 Jun 2007 22:06:46 +0200, Hans de Goede wrote:
> This patch fixes the detection of volt inputs with a reading of more then 240
> units.

> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> diff -urN linux-2.6.22-rc4.orig/drivers/hwmon/abituguru.c linux-2.6.22-rc4/drivers/hwmon/abituguru.c
> --- linux-2.6.22-rc4.orig/drivers/hwmon/abituguru.c	2007-06-17 09:10:17.000000000 +0200
> +++ linux-2.6.22-rc4/drivers/hwmon/abituguru.c	2007-06-17 09:09:48.000000000 +0200
> (...)
> @@ -449,10 +449,23 @@
>  
>  	ABIT_UGURU_DEBUG(2, "testing bank1 sensor %d\n", (int)sensor_addr);
>  	/* Volt sensor test, enable volt low alarm, set min value ridicously
> -	   high. If its a volt sensor this should always give us an alarm. */
> -	buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
> -	buf[1] = 245;
> -	buf[2] = 250;
> +	   high, or vica versa if the reading is very high. If its a volt
> +	   sensor this should always give us an alarm. */
> +	if (val <= 240u)
> +	{
> +		buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
> +		buf[1] = 245;
> +		buf[2] = 250;
> +		test_flag = ABIT_UGURU_VOLT_LOW_ALARM_FLAG;
> +	}
> +	else
> +	{
> +		buf[0] = ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE;
> +		buf[1] = 5;
> +		buf[2] = 10;
> +		test_flag = ABIT_UGURU_VOLT_HIGH_ALARM_FLAG;
> +	}
> +	
>  	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
>  			buf, 3) != 3)
>  		goto abituguru_detect_bank1_sensor_type_exit;

Curly braces placement infringes Documentation/CodingSyle.

Other than that, patch looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
