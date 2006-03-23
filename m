From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 19:56:17 +0000
Subject: [lm-sensors] [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060323205617.38e02afe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060323081231.D794B1EC019@garage.murgatroid.com>
In-Reply-To: <20060323081231.D794B1EC019@garage.murgatroid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christopher Hoover <ch@murgatroid.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org, Andrew Morton <akpm@osdl.org>

Hi Christopher,

> This small patch gets rid of some magic numbers in the i2c parport
> drivers, specifically wrt the control and status handling, using the
> symbols already defined in parport.h
> 
> The patch produces the same binary objects for i2c-parport.c and
> i2c-parport-simple.c as before.

> --- linux-2.6.16/drivers/i2c/busses/i2c-parport.h	2006-03-19 21:53:29.000000000 -0800
> +++ linux-2.6.16.i2c/drivers/i2c/busses/i2c-parport.h	2006-03-22 23:51:08.000000000 -0800
> (...)
> +#define LINEOP_DATA(val_, inverted_) \
> +   { .val=(val_), .port = DATA, .inverted=(inverted_) }
> +
> +#define LINEOP_STATUS(val_, inverted_) \
> +   { .val=(val_), .port = STAT, .inverted=(inverted_) }
> +
> +#define LINEOP_CONTROL(val_, inverted_) \
> +   { .val=(val_), .port = CTRL, .inverted=(inverted_) }
> +

Beeuh. These macros don't really help. They actually make the lines
longer! I'm not taking this change, sorry.

Other than that, I am fine with your patch. Not that I really see the
benefit, but it others do, why not. Can you please respin the patch
without the additional macros?

Thanks,
-- 
Jean Delvare

