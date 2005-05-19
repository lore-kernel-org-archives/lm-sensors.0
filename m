From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <20031014223706.0c1aa3e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Apparently Mandrake has I2C packages for the Alpha, so I'm in
> business.
> 
> I have worked out my build issues with my distribution(Gentoo) by way
> of an additional patch. Apparently 'i2c-velleman.c' needs a bit like
> this...
> 
> +#include <asm/param.h>
> 
> Can this be included in 2.9?

Reported and fixed back in July, so it's OK in 2.8.1 already.

> There is some variation within Gentoo regarding where the kernel
> modules go when done. Canonically, should they be in misc/ or
> drivers/i2c/ ?

Misc/ was for 2.2 kernels, on recent kernels you want to put them in
drivers/i2c/.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
