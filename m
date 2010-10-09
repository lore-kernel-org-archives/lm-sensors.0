From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 09 Oct 2010 18:44:30 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode
Message-Id: <20101009184430.GA29892@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 08, 2010 at 04:59:38AM -0400, Jan Beulich wrote:
> According to the documentation, simply reading the respective MSR
> isn't sufficient: It should be written with zeros, cpuid(1) be
> executed, and then read (see arch/x86/kernel/cpu/intel.c for an
> example).
> 
> v2: Fail probe when microcode revision cannot be determined, but is
> needed to check for proper operation.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Chen Gong <gong.chen@linux.intel.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> 
> ---
>  drivers/hwmon/coretemp.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
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
> @@ -327,8 +336,15 @@ static int __devinit coretemp_probe(stru
>  
>  	if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
>  		/* check for microcode update */
> -		rdmsr_on_cpu(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
> -		if (edx < 0x39) {
> +		err = smp_call_function_single(data->id, get_ucode_rev_on_cpu,
> +					       &edx, 1);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"Cannot determine microcode revision of "
> +				"CPU#%u (%d)!\n", data->id, err);
> +			err = -ENODEV;
> +			goto exit_free;
> +		} else if (edx < 0x39) {
>  			err = -ENODEV;
>  			dev_err(&pdev->dev,
>  				"Errata AE18 not fixed, update BIOS or "
> 
Do we have a conclusion on this ? Looks like no one Acked it, and there was
a suggestion to provice a generic piece of code to retrieve the ucode version.
Turns out the ucode revision is already available via ucode_cpu_info[cpu].cpu_sig.rev
unless I am missing something.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
