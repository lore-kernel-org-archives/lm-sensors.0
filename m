From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 14 Sep 2005 04:41:03 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: adm9240 updates
Message-Id: <20050914024038.GB28187@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <cslei1dpij6dbpghepu0na965d9rtfig63@4ax.com>
In-Reply-To: <cslei1dpij6dbpghepu0na965d9rtfig63@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant:

* Grant Coady <grant_lkml@dodo.com.au> [2005-09-14 08:50:10 +1000]:
> 
> hwmon: adm9240 update 2/3: cleanups
> 
> make SCALE function return zero for zero input,
> remove i2c read/write wrapper interface,
> change kmalloc + memset to kzalloc 
> 
> Signed-off-by: Grant Coady <gcoady@gmail.com>
> 
> ---
>  adm9240.c |   94 ++++++++++++++++++++++++++++++--------------------------------
>  1 files changed, 46 insertions(+), 48 deletions(-)
> 
> --- linux-2.6.14-rc1b/drivers/hwmon/adm9240.c-whitespace	2005-09-14 07:10:45.000000000 +1000
> +++ linux-2.6.14-rc1b/drivers/hwmon/adm9240.c	2005-09-14 07:26:43.000000000 +1000
> @@ -81,6 +81,8 @@
>  /* generalised scaling with integer rounding */
>  static inline int SCALE(long val, int mul, int div)
>  {
> +	if (val = 0)
> +		return 0;
>  	if (val < 0)
>  		return (val * mul - div / 2) / div;
>  	else

Just for reference, here's the whole original function:

orig > static inline int SCALE(long val, int mul, int div)
orig > {
orig >         if (val < 0)
orig >                 return (val * mul - div / 2) / div;
orig >         else
orig >                 return (val * mul + div / 2) / div;
orig > }

So... exactly what value of div would require this fix?

> [cut rest of patch which looks ok]

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

