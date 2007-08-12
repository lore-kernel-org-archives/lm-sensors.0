From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 18:18:12 +0000
Subject: Re: [lm-sensors] [PATCH] bad temperature values from w83781d in
Message-Id: <20070812201812.34694d75@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070805183219.0d54802b.akpm@linux-foundation.org>
	<20070808010316.GB3584@jupiter.solarsys.private>
	<20070808151716.GA6053@sommrey.de>
	<20070809035642.GE3584@jupiter.solarsys.private>
	<20070809070915.GA24252@sommrey.de>
	<20070809122619.GF3584@jupiter.solarsys.private>
In-Reply-To: <20070809122619.GF3584@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Joerg Sommrey <jo@sommrey.de>, LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, 9 Aug 2007 08:26:19 -0400, Mark M. Hoffman wrote:
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Thu Aug 9 08:12:46 2007 -0400
> 
>     hwmon: fix w83781d temp sensor type setting
>     
>     Commit 348753379a7704087603dad403603e825422fd9a introduced a regression that
>     caused temp2 and temp3 sensor type settings to be written to temp1 instead.
>     The result is that temp sensor readings could be way off.
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Good catch, sorry for messing up. My test chip is a W83781D, it doesn't
have thermal sensor type selection, so I couldn't test that.

Acked-by: Jean Delvare <khali@linux-fr.org>

> diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> index f85b48f..c95909c 100644
> --- a/drivers/hwmon/w83781d.c
> +++ b/drivers/hwmon/w83781d.c
> @@ -740,9 +740,9 @@ store_sensor(struct device *dev, struct device_attribute *da,
>  static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
>  	show_sensor, store_sensor, 0);
>  static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
> -	show_sensor, store_sensor, 0);
> +	show_sensor, store_sensor, 1);
>  static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
> -	show_sensor, store_sensor, 0);
> +	show_sensor, store_sensor, 2);
>  
>  /* I2C devices get this name attribute automatically, but for ISA devices
>     we must create it by ourselves. */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
