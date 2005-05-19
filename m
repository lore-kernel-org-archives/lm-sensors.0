From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Fix for kernel 2.4.21 patch
Message-Id: <20030801093759.0c4f7c59.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
In-Reply-To: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The changes however are very simple:
> 
> 1) File i2c-rpx.c line 21
> #include "i2c-algo-8xx.h" 
> 
> needs to be moved to below 
> 
> #include "asm/commproc.h"
> 
> 2) File i2c-algo-8xx.c line 37
> #include "i2c-algo-8xx.h" 
> 
> needs to be moved to below 
> 
> #include "asm/commproc.h"

I'm more in favor of including "asm/commproc.h" at the beginning of
i2c-algo-8xx.h. I don't like the idea of a header only working if
another header was included before.

> 3) Not in the I2C sources:
>
> drivers/i2c/Makefile
> 
> CONFIG_I2C_ALGO_8XX needs to be CONFIG_I2C_ALGO8XX
> 
> Just remove the underscore.

OK, that's done.
Thanks for reporting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
