From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: a question about i2c
Message-Id: <20040706214148.5f5f998d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i've downladed i2c-2.8.7 and i was trying to compile it, but i
> receive this error message:
> 
> kernel/i2c-philips-par.c: En el nivel principal:
> kernel/i2c-philips-par.c:141: error: el elemento inicializador
> no es constante
> kernel/i2c-philips-par.c:141: error: (near initialization for
> `bit_lp_data.timeout')
> kernel/i2c-philips-par.c:150: error: el elemento inicializador
> no es constante
> kernel/i2c-philips-par.c:150: error: (near initialization for
> `bit_lp_data2.timeout')
> make: *** [kernel/i2c-philips-par.o] Error 1
> 
> at this point we can find the next:
> 
> static struct i2c_algo_bit_data bit_lp_data = {
>         .setsda         = bit_lp_setsda,
>         .setscl         = bit_lp_setscl,
>         .getsda         = bit_lp_getsda,
>         .getscl         = bit_lp_getscl,
>         .udelay         = 80,
>         .mdelay         = 80,
>         .timeout        = HZ
> };
> 
> i'm not sure but i think it should be so:
> 
> ..
>         .timeout        = HZ,
> };

It doesn't change anything, the trailing coma isn't relevant.

> but this constant is found at <linux/hz.h> and not at the
> included header files (at least here in my suse 9.0 distro)
> 
> how can i solve this problem?

This is a problem with the Suse kernel sources. These are not the
vanilla sources, they do some weird stuff that prevent our code from
compiling properly. We already had several reports of this.

We cannot support random changes from all distributors. Either use Suse
packages for lm_sensors, or switch to a vanilla kernel before compiling
from our sources.

-- 
Jean Delvare
http://khali.linux-fr.org/
