From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 07 Oct 2010 18:46:15 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode revision
Message-Id: <20101007184615.GA17295@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 07, 2010 at 02:36:01AM -0700, Jan Beulich wrote:
> According to the documentation, simply reading the respective MSR
> isn't sufficient: It should be written with zeros, cpuid(1) be
> executed, and then read (see arch/x86/kernel/cpu/intel.c for an
> example).
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Chen Gong <gong.chen@linux.intel.com>
> 
> ---
>  drivers/hwmon/coretemp.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.36-rc7/drivers/hwmon/coretemp.c
> +++ 2.6.36-rc7-coretemp-ucode/drivers/hwmon/coretemp.c
> @@ -292,6 +292,15 @@ static int __devinit get_tjmax(struct cp
>  	}
>  }
>  
> +static void __devinit get_ucode_rev_on_cpu(void *edx)
> +{
> +	u32 eax;
> +
> +	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
> +	sync_core();
> +	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
> +}
> +
>  static int __devinit coretemp_probe(struct platform_device *pdev)
>  {
>  	struct coretemp_data *data;
> @@ -327,8 +336,13 @@ static int __devinit coretemp_probe(stru
>  
>  	if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
>  		/* check for microcode update */
> -		rdmsr_on_cpu(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
> -		if (edx < 0x39) {
> +		err = smp_call_function_single(data->id, get_ucode_rev_on_cpu,
> +					       &edx, 1);
> +		if (err)
> +			dev_warn(&pdev->dev,
> +				 "Cannot determine microcode revision "
> +				 "of the CPU!\n");

When err, need to call dev_err and go to exit_free. This error handling should
be same as edx < 0x39 case.

> +		else if (edx < 0x39) {
>  			err = -ENODEV;
>  			dev_err(&pdev->dev,
>  				"Errata AE18 not fixed, update BIOS or "
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
