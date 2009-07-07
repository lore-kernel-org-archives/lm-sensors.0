From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Jul 2009 11:26:31 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Penryn mobile CPUs
Message-Id: <20090707132631.5a84cd62@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A5228B8.7010604@assembler.cz>
In-Reply-To: <4A5228B8.7010604@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

On Mon, 06 Jul 2009 18:39:20 +0200, Rudolf Marek wrote:
> Following patch adds support for mobile Penryn CPUs. Intel documents this
> poorly. I asked the Coretemp author for some help. This is totally untested and
> may not work. Please test!
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

> Index: linux-2.6.30.1/drivers/hwmon/coretemp.c
> =================================> --- linux-2.6.30.1.orig/drivers/hwmon/coretemp.c	2009-07-06 18:25:46.934758067 +0200
> +++ linux-2.6.30.1/drivers/hwmon/coretemp.c	2009-07-06 18:35:38.602757417 +0200
> @@ -157,6 +157,7 @@
>  	/* The 100C is default for both mobile and non mobile CPUs */
>  
>  	int tjmax = 100000;
> +	int tjmax_ee = 85000;
>  	int usemsr_ee = 1;
>  	int err;
>  	u32 eax, edx;
> @@ -175,20 +176,31 @@
>  	}
>  
>  	if ((c->x86_model > 0xe) && (usemsr_ee)) {
> -
> +		u8 platform_id;
>  		/* Now we can detect the mobile CPU using Intel provided table
>  		   http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
>  		   For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
>  		*/
>  
>  		err = rdmsr_safe_on_cpu(id, 0x17, &eax, &edx);
> +		/* Platform ID bits 52:50 (EDX starts at bit 32) */
> +		platform_id = (edx >> 18) & 0x7;
>  		if (err) {

Logic is invalid: if there's an error then the value of edx is
undefined.

>  			dev_warn(dev,
>  				 "Unable to access MSR 0x17, assuming desktop"
>  				 " CPU\n");
>  			usemsr_ee = 0;
> -		} else if (!(eax & 0x10000000)) {
> +		/* trust bit 28 up to Penryn, I could not find any documentation on that
> +		   if you happen to know someone at Intel please ask */
> +

Indentation is pretty messy, and first comment line is too long.

> +		} else if ((!(eax & 0x10000000)) && (c->x86_model < 0x17)) {

It would make more sense to check model first and eax second IMHO.

>  			usemsr_ee = 0;
> +		/* Mobile Penryn CPU seems to be platform ID 7 or 5 (guesswork) */

Line too long.

> +		} else if ((c->x86_model = 0x17) &&
> +				((platform_id = 5) || (platform_id = 7))) {
> +			/* If MSR EE bit is set, set it to 90C otherwise 105C */
> +			tjmax_ee = 90000;
> +			tjmax = 105000;
>  		}
>  	}
>  
> @@ -200,7 +212,7 @@
>  				 "Unable to access MSR 0xEE, for Tjmax, left"
>  				 " at default");
>  		} else if (eax & 0x40000000) {
> -			tjmax = 85000;
> +			tjmax = tjmax_ee;
>  		}
>  	} else {
>  		dev_warn(dev, "Using relative temperature scale!\n");
> @@ -420,7 +432,9 @@
>  	for_each_online_cpu(i) {
>  		struct cpuinfo_x86 *c = &cpu_data(i);
>  
> -		/* check if family 6, models 0xe, 0xf, 0x16, 0x17, 0x1A, 0x1c */
> +		/* check if family 6, models 0xe (Pentium M DC),
> +		  0xf (Core 2 DC 65nm), 0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm)

Line too long.

> +		  0x1a (Nehalem), 0x1c (Atom) */
>  		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
>  		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
>  			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
> Index: linux-2.6.30.1/Documentation/hwmon/coretemp
> =================================> --- linux-2.6.30.1.orig/Documentation/hwmon/coretemp	2009-07-06 18:35:53.765759446 +0200
> +++ linux-2.6.30.1/Documentation/hwmon/coretemp	2009-07-06 18:36:39.817757139 +0200
> @@ -4,7 +4,9 @@
>  Supported chips:
>    * All Intel Core family
>      Prefix: 'coretemp'
> -    CPUID: family 0x6, models 0xe, 0xf, 0x16, 0x17, 0x1c (Atom)
> +    CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
> +                              0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
> +                              0x1a (Nehalem), 0x1c (Atom).
>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>                 http://softwarecommunity.intel.com/Wiki/Mobility/720.htm


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
