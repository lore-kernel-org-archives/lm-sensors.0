From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 18 May 2014 10:18:48 +0000
Subject: Re: [lm-sensors] [PATCH 5/9] hwmon: (emc1403) Make all hyst attributes except for temp1_crit_hyst re
Message-Id: <20140518121848.256482ce@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1399921311-9524-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399921311-9524-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 May 2014 12:01:47 -0700, Guenter Roeck wrote:
> All chips in this chip series only support a single hysteresis value. Having
> multiple writable hysteresis attributes is therefore confusing, since a single
> write affects all hysteresis temperatures. Make all but one (temp1_crit_hyst)
> read-only.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/emc1403 | 7 +++++--
>  drivers/hwmon/emc1403.c     | 9 +++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/emc1403 b/Documentation/hwmon/emc1403
> index b109e35..a869b0e 100644
> --- a/Documentation/hwmon/emc1403
> +++ b/Documentation/hwmon/emc1403
> @@ -51,6 +51,9 @@ This implementation detail implies the following:
>    was 80 degrees C, and the hysteresis was 75 degrees C, and you change
>    the critical limit to 90 degrees C, then the hysteresis will
>    automatically change to 85 degrees C.
> -* While hysteresis limits can be set for all critical limits, setting a single
> -  hysteresis value affects the hysteresis values for all limits on all sensors.
> +* The hysteresis values can't be set independently. We decided to make
> +  only temp1_crit_hyst writable, while all other hysteresis attributes
> +  are read-only. Setting temp1_crit_hyst writes the difference between
> +  temp1_crit_hyst and temp1_crit into the chip, and the same relative
> +  hysteresis applies automatically to all other limits.
>  * The limits should be set before the hysteresis.
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index ee63d7b..877144c 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -195,8 +195,7 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
>  	show_bit, NULL, 0x35, 0x02);
>  static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
>  	show_bit, NULL, 0x37, 0x02);
> -static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO | S_IWUSR,
> -	show_hyst, store_hyst, 0x19);
> +static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_hyst, NULL, 0x19);
>  
>  static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR,
>  	show_temp, store_temp, 0x16);
> @@ -212,8 +211,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
>  	show_bit, NULL, 0x35, 0x04);
>  static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
>  	show_bit, NULL, 0x37, 0x04);
> -static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO | S_IWUSR,
> -	show_hyst, store_hyst, 0x1A);
> +static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_hyst, NULL, 0x1A);
>  
>  static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR,
>  	show_temp, store_temp, 0x2D);
> @@ -229,8 +227,7 @@ static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
>  	show_bit, NULL, 0x35, 0x08);
>  static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO,
>  	show_bit, NULL, 0x37, 0x08);
> -static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO | S_IWUSR,
> -	show_hyst, store_hyst, 0x30);
> +static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO, show_hyst, NULL, 0x30);
>  
>  static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
>  	show_bit, store_bit, 0x03, 0x40);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
