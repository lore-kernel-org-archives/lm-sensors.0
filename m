From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 15:55:42 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (lm75) Fix tcn75 prefix
Message-Id: <20130312155542.GC30269@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312154349.78696ff0@endymion.delvare>
In-Reply-To: <20130312154349.78696ff0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 12, 2013 at 03:43:49PM +0100, Jean Delvare wrote:
> The TCN75 has its own prefix for a long time now.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/hwmon/lm75 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.9-rc2.orig/Documentation/hwmon/lm75	2013-03-12 11:00:05.349115743 +0100
> +++ linux-3.9-rc2/Documentation/hwmon/lm75	2013-03-12 11:32:19.118988959 +0100
> @@ -23,7 +23,7 @@ Supported chips:
>      Datasheet: Publicly available at the Maxim website
>                 http://www.maxim-ic.com/
>    * Microchip (TelCom) TCN75
> -    Prefix: 'lm75'
> +    Prefix: 'tcn75'
>      Addresses scanned: none
>      Datasheet: Publicly available at the Microchip website
>                 http://www.microchip.com/
> 
> 
> 
> -- 
> Jean Delvare
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
