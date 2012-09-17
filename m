From: Parag Warudkar <parag.lkml@gmail.com>
Date: Mon, 17 Sep 2012 18:54:25 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Bump max wait and rearrange udelay
Message-Id: <alpine.DEB.2.02.1209171446390.1963@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120915225841.GA3816@roeck-us.net> <alpine.DEB.2.02.1209151918210.2271@ubuntu> <alpine.DEB.2.02.1209152323490.2088@ubuntu> <20120916043116.GA4477@roeck-us.net> <20120916093520.GA5623@polaris.bitmath.org> <alpine.DEB.2.02.1209161712070.14838@ubuntu>
 <20120916223003.GA2160@polaris.bitmath.org> <alpine.DEB.2.02.1209161957490.2808@ubuntu> <20120917162705.GA2854@polaris.bitmath.org> <alpine.DEB.2.02.1209171356340.3412@ubuntu> <20120917184954.GA349@polaris.bitmath.org>
In-Reply-To: <20120917184954.GA349@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Parag Warudkar <parag.lkml@gmail.com>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org



On Mon, 17 Sep 2012, Henrik Rydberg wrote:

> So the question is, does this patch work equally well for you?
> 
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index 2827088..8bf9011 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -56,7 +56,7 @@
>  /* wait up to 32 ms for a status change. */
>  #define APPLESMC_MIN_WAIT      0x0010
>  #define APPLESMC_RETRY_WAIT    0x0100
> -#define APPLESMC_MAX_WAIT      0x8000
> +#define APPLESMC_MAX_WAIT      0x10000
>  
>  #define APPLESMC_READ_CMD      0x10
>  #define APPLESMC_WRITE_CMD     0x11
> 

That was something that I tried originally and it still resulted in 
failures - albeit lesser in number.

I had to bump it to 0x20000 (effective wait of 65536) with the original 
loop termination logic and  udelay() in order to get it to reduce to 
zero.

Note that with usleep_range - each sleep is potentially more than the 
minimum - that's may be why 32ms works with usleep_range but not with 
udelay which is precise.

So bottomline, I suspect we will need to bump to 0x20000 if you want to 
keep the current loop termination and udelay().

Parag

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
