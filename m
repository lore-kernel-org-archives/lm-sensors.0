From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Sat, 05 Nov 2011 18:16:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix for non-SMP builds
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109F102E44E@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111105185411.0fb888e3@endymion.delvare>
In-Reply-To: <20111105185411.0fb888e3@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nice Catch.
Thanks Jean for the fix.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Saturday, November 05, 2011 11:24 PM
> To: LM Sensors
> Cc: R, Durgadoss; Guenter Roeck; Phil Sutter
> Subject: [PATCH] hwmon: (coretemp) Fix for non-SMP builds
> 
> The definition of TO_ATTR_NO in the non-SMP case is wrong. As the SMP
> definition resolves to the correct value, just use this for both
> cases.
> 
> Without this fix the temperature attributes are named temp0_* instead
> of temp2_*, so libsensors won't pick them. Broken since kernel 3.0.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Tested-by: Phil Sutter <phil@nwl.cc>

Acked-By: Durgadoss R <Durgadoss.r@intel.com>

Thanks,
Durga

> ---
>  drivers/hwmon/coretemp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-3.0.orig/drivers/hwmon/coretemp.c	2011-11-05 18:39:36.000000000
> +0100
> +++ linux-3.0/drivers/hwmon/coretemp.c	2011-11-05 18:48:19.000000000 +0100
> @@ -50,14 +50,13 @@
>  #ifdef CONFIG_SMP
>  #define TO_PHYS_ID(cpu)		cpu_data(cpu).phys_proc_id
>  #define TO_CORE_ID(cpu)		cpu_data(cpu).cpu_core_id
> -#define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
>  #define for_each_sibling(i, cpu)	for_each_cpu(i, cpu_sibling_mask(cpu))
>  #else
>  #define TO_PHYS_ID(cpu)		(cpu)
>  #define TO_CORE_ID(cpu)		(cpu)
> -#define TO_ATTR_NO(cpu)		(cpu)
>  #define for_each_sibling(i, cpu)	for (i = 0; false; )
>  #endif
> +#define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
> 
>  /*
>   * Per-Core Temperature Data
> 
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
