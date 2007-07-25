From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jul 2007 02:01:39 +0000
Subject: Re: [lm-sensors] [PATCH][07/37] Clean up duplicate includes in
Message-Id: <20070725020139.GB3767@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200707211702.01755.jesper.juhl@gmail.com>
In-Reply-To: <200707211702.01755.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, lm-sensors@lm-sensors.org

Hi Jesper:

* Jesper Juhl <jesper.juhl@gmail.com> [2007-07-21 17:02:01 +0200]:
> Hi,
> 
> This patch cleans up duplicate includes in
> 	drivers/hwmon/
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
> diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
> index 6db9737..a112a03 100644
> --- a/drivers/hwmon/ams/ams-core.c
> +++ b/drivers/hwmon/ams/ams-core.c
> @@ -23,7 +23,6 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <asm/pmac_pfunc.h>
>  #include <asm/of_platform.h>
>  

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
