From: Richard.Laing@4rf.com (Richard Laing)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Fix for kernel 2.4.21 patch
Message-Id: <4ABDB84E30B89F4E9C942C186F0B9EF605BAFA@4rf-nz-mail.local.4rf.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
In-Reply-To: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I haven't created a patch - I need some time to rowk out exactly how to make it work and the changes are not just against the i2c 2.8.0 code. It appears that there is a bug in the changes done to the kernel code to.The changes however are very simple:

1) File i2c-rpx.c line 21
#include "i2c-algo-8xx.h" 

needs to be moved to below 

#include "asm/commproc.h"

2) File i2c-algo-8xx.c line 37
#include "i2c-algo-8xx.h" 

needs to be moved to below 

#include "asm/commproc.h"

3) Not in the I2C sources:
drivers/i2c/Makefile

CONFIG_I2C_ALGO_8XX needs to be CONFIG_I2C_ALGO8XX

Just remove the underscore.

And that's it...

Cheers
Richard




-----Original Message-----
From:	Jean Delvare [mailto:khali@linux-fr.org]
Sent:	Wed 30/07/2003 9:14 p.m.
To:	Richard Laing
Cc:	sensors@Stimpy.netroedge.com
Subject:	Re: Fix for kernel 2.4.21 patch

> I downloaded the Linux 2.4.21 kernel patch for the I2C 2.8.0 release
> and tried to patch my kernel for an RPXLite target board. There are a
> couple of bugs in the patch for this target which prevent it from
> compiling. I have fixed these and would like to know where to send the
> updated patch file.

You hit the right address, we are interested in your patch. Please send
it to us. Comments about what it does and why it is necessary would be
very welcome too.

However, please dont send us a modified patch. This patch is soooo big
and I guess you just fixed some lines. What we would need is a patch
against our original I2C source code. Please download i2c-2.8.0.tar.gz
(or checkout from CVS, at your option) and generate a patch from this.

(If you don't want to/don't know how to do that, send your large file to
me only and I'll try to handle it.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/



