From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Jan 2008 09:21:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix divide-by-0
Message-Id: <20080128102116.444aba0b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
In-Reply-To: <191fb4ca0801240911m79bdc87p72b734df3427ee4b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 27 Jan 2008 16:39:46 -0800, Juerg Haefliger wrote:
> This patch fixes a possible divide-by-0 and a minor bug in the
> FAN_FROM_REG macro (in TPC mode).
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
>
> Index: linux/drivers/hwmon/dme1737.c
> =================================> --- linux.orig/drivers/hwmon/dme1737.c	2008-01-24 09:04:24.000000000 -0800
> +++ linux/drivers/hwmon/dme1737.c	2008-01-27 16:33:47.000000000 -0800
> @@ -279,14 +279,21 @@
>  /* Fan input RPM */
>  static inline int FAN_FROM_REG(int reg, int tpc)
>  {
> -	return (reg = 0 || reg = 0xffff) ? 0 :
> -		(tpc = 0) ? 90000 * 60 / reg : tpc * reg;
> +	if (tpc) {
> +		return tpc * reg;
> +	} else {
> +		return (reg = 0 || reg = 0xffff) ? 0 : 90000 * 60 / reg;
> +	}
>  }
>  
>  static inline int FAN_TO_REG(int val, int tpc)
>  {
> -	return SENSORS_LIMIT((tpc = 0) ? 90000 * 60 / val : val / tpc,
> -			     0, 0xffff);
> +	if (tpc) {
> +		return SENSORS_LIMIT(val / tpc, 0, 0xffff);
> +	} else {
> +		return (val <= 0) ? 0xffff :
> +			SENSORS_LIMIT(90000 * 60 / val, 0, 0xfffe);
> +	}
>  }
>  
>  /* Fan TPC (tach pulse count)

Looks good to me this time.

Acked-by: Jean Delvare <khali@linux-fr.org>

PS: Would you have some time to review one of my pending patches? For
example:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022143.html

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
