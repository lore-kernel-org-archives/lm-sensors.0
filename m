From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Mon, 10 May 2010 02:35:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (coretemp) Detect the thermal
Message-Id: <20100510023510.GA9181@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095459.GA12190@owl>
 <4BE413D1.6090606@osadl.org>
In-Reply-To: <4BE413D1.6090606@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carsten Emde <Carsten.Emde@osadl.org>
Cc: Huaxu Wan <huaxu.wan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Huaxu Wan <huaxu.wan@intel.com>

On 15:21 Fri 07 May, Carsten Emde wrote:
> Hi Huaxu,
> 
> > The thermal sensors of Intel(R) CPUs can be detected by CPUID instruction,
> > indicated by CPUID.06H.EAX[0].
> Thanks, works great, successfully tested it on an i7 machine.
> 
> I would propose to use dev_warn() instead of printk_once(), since all
> other per-cpu info is also logged this way.
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
> 

That reminds me that dev_warn is right one on multiple CPU system, especially with different CPUs. Thank you.

> ---
>  drivers/hwmon/coretemp.c |   23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> Index: head/drivers/hwmon/coretemp.c
> =================================> --- head.orig/drivers/hwmon/coretemp.c
> +++ head/drivers/hwmon/coretemp.c
> @@ -440,6 +440,7 @@ static int __init coretemp_init(void)
>  {
>  	int i, err = -ENODEV;
>  	struct pdev_entry *p, *n;
> +	u32 eax;
>  
>  	/* quick check if we run Intel */
>  	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
> @@ -450,23 +451,13 @@ static int __init coretemp_init(void)
>  		goto exit;
>  
>  	for_each_online_cpu(i) {
> -		struct cpuinfo_x86 *c = &cpu_data(i);
> +		/* check if the CPU has thermal sensor */
> +		eax = cpuid_eax(0x06);
> +		if (!(eax & 0x01)) {
> +			struct cpuinfo_x86 *c = &cpu_data(i);
>  
> -		/* check if family 6, models 0xe (Pentium M DC),
> -		  0xf (Core 2 DC 65nm), 0x16 (Core 2 SC 65nm),
> -		  0x17 (Penryn 45nm), 0x1a (Nehalem), 0x1c (Atom),
> -		  0x1e (Lynnfield) */
> -		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
> -		    !((c->x86_model = 0xe) || (c->x86_model = 0xf) ||
> -			(c->x86_model = 0x16) || (c->x86_model = 0x17) ||
> -			(c->x86_model = 0x1a) || (c->x86_model = 0x1c) ||
> -			(c->x86_model = 0x1e))) {
> -
> -			/* supported CPU not found, but report the unknown
> -			   family 6 CPU */
> -			if ((c->x86 = 0x6) && (c->x86_model > 0xf))
> -				printk(KERN_WARNING DRVNAME ": Unknown CPU "
> -					"model 0x%x\n", c->x86_model);
> +			dev_warn("CPU (model=0x%x) has no thermal sensor!\n",
> +			    c->x86_model);
>  			continue;
>  		}
>  


-- 
Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
