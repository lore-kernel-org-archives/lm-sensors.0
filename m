From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH-2.4] build fix for amd756 in sensors 2.9
Message-Id: <20050306114911.34e68bc1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306103039.GA18356@alpha.home.local>
In-Reply-To: <20050306103039.GA18356@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Willy,

> lm_sensors 2.9 does not fully compile under linux 2.4 because the
> i2c-amd756 module exports a symbol and is not referenced in the
> export-objs in the makefile :
> 
> (i2c-amd756.c)
> +
> +EXPORT_SYMBOL(amd756_smbus);
> +

The problem was already reported and fixed in lm_sensors CVS on January
10th, 2005 (but thanks for reporting anyway).

> The trivial fix below fixes the problem. Please apply.
> (...)
> --- ./drivers/i2c/Makefile.bad	Mon Feb  7 00:30:00 2005
> +++ ./drivers/i2c/Makefile	Mon Feb  7 00:56:18 2005
> @@ -7,7 +7,7 @@
>  export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
>  		   i2c-algo-ite.o i2c-algo-sibyte.o i2c-algo-sgi.o \
>  		   i2c-algo-8xx.o i2c-algo-ibm_ocp.o \
> -		   i2c-proc.o
> +		   i2c-proc.o i2c-amd756.o

Except that this wouldn't be correct. i2c-amd756 doesn't belong to the
main 2.4 kernel tree, it's added there by the sensors patch. So the
correct fix was to teach the lm_sensors patch maker how to properly add
an export declaration for i2c-amd756.

If you regenerate the sensors patch from lm_sensors CVS and apply it
instead of the patch generated from lm_sensors 2.9.0, it should just
work.

Thanks,
-- 
Jean Delvare
