From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Aug 2010 13:20:07 +0000
Subject: Re: [lm-sensors] [Patch-next] therm_throt.c: fix missing { and }.
Message-Id: <20100827152007.27636fa5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C75D3C4.6040802@np.css.fujitsu.com>
	<20100826060822.GA15021@fenghua-desk.sc.intel.com>
	<4C7625D1.4060201@np.css.fujitsu.com>
In-Reply-To: <4C7625D1.4060201@np.css.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, "Brown, Len" <len.brown@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@linux.jf.intel.com>, LKLM <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, mingo Redhat <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, 26 Aug 2010 17:29:05 +0900, Jin Dongming wrote:
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

This is incomplete. Error handling in this function is totally broken.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
