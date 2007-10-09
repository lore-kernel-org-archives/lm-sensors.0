From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 09 Oct 2007 02:17:39 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp driver and Celeron 430 - works
Message-Id: <20071009021739.GO3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4708C611.5040808@assembler.cz>
In-Reply-To: <4708C611.5040808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Rudolf Marek <r.marek@assembler.cz> [2007-10-07 13:42:09 +0200]:
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> This patch adds support for the Celeron 4xx based on Core 2 core.

> Index: linux-2.6.23-rc7-rc9/drivers/hwmon/coretemp.c
> =================================> --- linux-2.6.23-rc7-rc9.orig/drivers/hwmon/coretemp.c	2007-10-07 13:18:51.650651170 +0200
> +++ linux-2.6.23-rc7-rc9/drivers/hwmon/coretemp.c	2007-10-07 13:27:05.086652886 +0200
> @@ -371,9 +371,10 @@
>  	for_each_online_cpu(i) {
>  		struct cpuinfo_x86 *c = &(cpu_data)[i];
>  
> -		/* check if family 6, models e, f */
> +		/* check if family 6, models e, f, 16 */
>  		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
> -		    !((c->x86_model = 0xe) || (c->x86_model = 0xf))) {
> +		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
> +			(c->x86_model = 0x16))) {
>  
>  			/* supported CPU not found, but report the unknown
>  			   family 6 CPU */
> Index: linux-2.6.23-rc7-rc9/Documentation/hwmon/coretemp
> =================================> --- linux-2.6.23-rc7-rc9.orig/Documentation/hwmon/coretemp	2007-10-07 13:27:18.682652097 +0200
> +++ linux-2.6.23-rc7-rc9/Documentation/hwmon/coretemp	2007-10-07 13:27:39.226648400 +0200
> @@ -4,7 +4,7 @@
>  Supported chips:
>    * All Intel Core family
>      Prefix: 'coretemp'
> -    CPUID: family 0x6, models 0xe, 0xf
> +    CPUID: family 0x6, models 0xe, 0xf, 0x16
>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>  

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
