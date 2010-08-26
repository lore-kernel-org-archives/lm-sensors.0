From: Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 26 Aug 2010 20:51:25 +0000
Subject: Re: [lm-sensors] [Patch-next] therm_throt.c: fix missing { and }.
Message-Id: <20100826205125.GA16468@fenghua-desk.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C75D3C4.6040802@np.css.fujitsu.com> <20100826060822.GA15021@fenghua-desk.sc.intel.com> <4C7625D1.4060201@np.css.fujitsu.com>
In-Reply-To: <4C7625D1.4060201@np.css.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, mingo Redhat <mingo@redhat.com>, "Brown, Len" <len.brown@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, "H. Peter Anvin" <hpa@linux.jf.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, LKLM <linux-kernel@vger.kernel.org>

On Thu, Aug 26, 2010 at 01:29:05AM -0700, Jin Dongming wrote:
> When the feature PTS is not supported by CPU, the sysfile
> package_power_limit_count for package should not be generated.
> 
> This patch is used for fixing missing { and }. But I have not confirmed
> this patch because I don't have such machine.
> 
> Signed-off-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
> ---
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> index d9368ee..169d880 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -216,7 +216,7 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
>  		err = sysfs_add_file_to_group(&sys_dev->kobj,
>  					      &attr_core_power_limit_count.attr,
>  					      thermal_attr_group.name);
> -	if (cpu_has(c, X86_FEATURE_PTS))
> +	if (cpu_has(c, X86_FEATURE_PTS)) {
>  		err = sysfs_add_file_to_group(&sys_dev->kobj,
>  					      &attr_package_throttle_count.attr,
>  					      thermal_attr_group.name);
> @@ -224,6 +224,7 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
>  			err = sysfs_add_file_to_group(&sys_dev->kobj,
>  					&attr_package_power_limit_count.attr,
>  					thermal_attr_group.name);
> +	}
>  
>  	return err;
>  }
> -- 
> 1.7.1.1
> 

Reviewed-by: Fenghua Yu <fenghua.yu@initel.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
