From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <20040417230824.45f51061.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Arthur,

> From scripts/checkincludes.pl:
> 
>   ./drivers/i2c/busses/i2c-piix4.c: linux/config.h is included more
>   than once.
> 
> Against 2.6.5. Thanks.
> 
> 
> --- a/drivers/i2c/busses/i2c-piix4.c	2004-04-11 14:05:35.000000000 +0200
> +++ b/drivers/i2c/busses/i2c-piix4.c	2004-04-16 17:52:16.000000000 +0200
> @@ -31,7 +31,6 @@
>  #include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/config.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/stddef.h>

Actually there are more problems than just this one:

1* scx200_acb.c, scx200_i2c.c and i2c-keywest.c also include version.h
   twice.

2* Most i2c bus drivers do not need to include it at all. Greg, I guess
   this is a leftover from the old debugging scheme?

3* Same goes for most (all?) i2c chip drivers, and core i2c drivers too:
   they include config.h but don't seem to need it.

If would probably be better to solve all these problems at once. I think
we should get rid of all useless includes. Greg, can you confirm?

Rusty, I think you can leave this one to Greg and I, we'll handle it.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
