From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Aug 2015 17:27:46 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] x86, amd: add accessor for number of cores per compute unit
Message-Id: <20150827172746.GA27452@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com>
 <1440662866-28716-10-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-10-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>
Cc: Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On Thu, Aug 27, 2015 at 04:07:40PM +0800, Huang Rui wrote:
> Add an accessor function amd_get_cores_per_cu() which returns the
> number of cores per compute unit.
> 
> In a subsequent patch, we will use this function in fam15h_power
> driver.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  arch/x86/include/asm/processor.h |  1 +
>  arch/x86/kernel/cpu/amd.c        | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 19577dd..831ad682 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -810,6 +810,7 @@ static inline int mpx_disable_management(void)
>  
>  extern u16 amd_get_nb_id(int cpu);
>  extern u32 amd_get_nodes_per_socket(void);
> +extern u32 amd_get_cores_per_cu(void);
>  
>  static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
>  {
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 51ad2af..8ab939a 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -26,6 +26,9 @@
>   */
>  static u32 nodes_per_socket = 1;
>  
> +/* cores_per_cu: stores the number of cores per compute unit */
> +static u32 cores_per_cu = 1;
> +
Is this value going to be constant even if there are multiple CPUs
in the system ? In other words, if there are multiple CPUs, do
they always have to have the same number of cores per CU ?

Thanks,
Guenter

>  static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
>  {
>  	u32 gprs[8] = { 0 };
> @@ -298,7 +301,6 @@ static int nearby_node(int apicid)
>  #ifdef CONFIG_SMP
>  static void amd_get_topology(struct cpuinfo_x86 *c)
>  {
> -	u32 cores_per_cu = 1;
>  	u8 node_id;
>  	int cpu = smp_processor_id();
>  
> @@ -313,7 +315,6 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
>  		/* get compute unit information */
>  		smp_num_siblings = ((ebx >> 8) & 3) + 1;
>  		c->compute_unit_id = ebx & 0xff;
> -		cores_per_cu += ((ebx >> 8) & 3);
>  	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
>  		u64 value;
>  
> @@ -379,6 +380,13 @@ u32 amd_get_nodes_per_socket(void)
>  }
>  EXPORT_SYMBOL_GPL(amd_get_nodes_per_socket);
>  
> +/* this function returns the number of cores per compute unit */
> +u32 amd_get_cores_per_cu(void)
> +{
> +	return cores_per_cu;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_cores_per_cu);
> +
>  static void srat_detect_node(struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_NUMA
> @@ -506,6 +514,13 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  		/* A random value per boot for bit slice [12:upper_bit) */
>  		va_align.bits = get_random_int() & va_align.mask;
>  	}
> +
> +	if (cpu_has_topoext) {
> +		u32 cpuid;
> +
> +		cpuid = cpuid_ebx(0x8000001e);
> +		cores_per_cu += ((cpuid >> 8) & 3);
> +	}
>  }
>  
>  static void early_init_amd(struct cpuinfo_x86 *c)
> -- 
> 1.9.1
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
