From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Mar 2007 19:49:28 +0000
Subject: [lm-sensors] [PATCH] coretemp 1/3 Add rdmsr_safe_on_cpu and
Message-Id: <20070324204928.3c8d15aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600653F.8040000@assembler.cz>
In-Reply-To: <4600653F.8040000@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Mar 2007 18:07:59 +0800, Nicolas Boichat wrote:
> Use safe functions provided by arch/*/lib/msr-on-cpu.c in arch/i386/kernel/msr.c.
> 
> Signed-off-by: Nicolas Boichat <nicolas at boichat.ch>
> 
> 
> ---
> 
>  arch/i386/kernel/msr.c |  106 ++----------------------------------------------
>  1 files changed, 4 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
> index bcaa6e9..8cd0a91 100644
> --- a/arch/i386/kernel/msr.c
> +++ b/arch/i386/kernel/msr.c
> @@ -45,104 +45,6 @@
>  
>  static struct class *msr_class;
>  
> -static inline int wrmsr_eio(u32 reg, u32 eax, u32 edx)
> -{
> -	int err;
> -
> -	err = wrmsr_safe(reg, eax, edx);
> -	if (err)
> -		err = -EIO;
> -	return err;
> -}
> -
> -static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
> -{
> -	int err;
> -
> -	err = rdmsr_safe(reg, eax, edx);
> -	if (err)
> -		err = -EIO;
> -	return err;
> -}
> -
> -#ifdef CONFIG_SMP
> -
> -struct msr_command {
> -	int err;
> -	u32 reg;
> -	u32 data[2];
> -};
> -
> -static void msr_smp_wrmsr(void *cmd_block)
> -{
> -	struct msr_command *cmd = (struct msr_command *)cmd_block;
> -
> -	cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
> -}
> -
> -static void msr_smp_rdmsr(void *cmd_block)
> -{
> -	struct msr_command *cmd = (struct msr_command *)cmd_block;
> -
> -	cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
> -}
> -
> -static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
> -{
> -	struct msr_command cmd;
> -	int ret;
> -
> -	preempt_disable();
> -	if (cpu = smp_processor_id()) {
> -		ret = wrmsr_eio(reg, eax, edx);
> -	} else {
> -		cmd.reg = reg;
> -		cmd.data[0] = eax;
> -		cmd.data[1] = edx;
> -
> -		smp_call_function_single(cpu, msr_smp_wrmsr, &cmd, 1, 1);
> -		ret = cmd.err;
> -	}
> -	preempt_enable();
> -	return ret;
> -}
> -
> -static inline int do_rdmsr(int cpu, u32 reg, u32 * eax, u32 * edx)
> -{
> -	struct msr_command cmd;
> -	int ret;
> -
> -	preempt_disable();
> -	if (cpu = smp_processor_id()) {
> -		ret = rdmsr_eio(reg, eax, edx);
> -	} else {
> -		cmd.reg = reg;
> -
> -		smp_call_function_single(cpu, msr_smp_rdmsr, &cmd, 1, 1);
> -
> -		*eax = cmd.data[0];
> -		*edx = cmd.data[1];
> -
> -		ret = cmd.err;
> -	}
> -	preempt_enable();
> -	return ret;
> -}
> -
> -#else				/* ! CONFIG_SMP */
> -
> -static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
> -{
> -	return wrmsr_eio(reg, eax, edx);
> -}
> -
> -static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
> -{
> -	return rdmsr_eio(reg, eax, edx);
> -}
> -
> -#endif				/* ! CONFIG_SMP */
> -
>  static loff_t msr_seek(struct file *file, loff_t offset, int orig)
>  {
>  	loff_t ret = -EINVAL;
> @@ -174,9 +76,9 @@ static ssize_t msr_read(struct file *file, char __user * buf,
>  		return -EINVAL;	/* Invalid chunk size */
>  
>  	for (; count; count -= 8) {
> -		err = do_rdmsr(cpu, reg, &data[0], &data[1]);
> +		err = rdmsr_safe_on_cpu(cpu, reg, &data[0], &data[1]);
>  		if (err)
> -			return err;
> +			return -EIO;
>  		if (copy_to_user(tmp, &data, 8))
>  			return -EFAULT;
>  		tmp += 2;
> @@ -200,9 +102,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
>  	for (; count; count -= 8) {
>  		if (copy_from_user(&data, tmp, 8))
>  			return -EFAULT;
> -		err = do_wrmsr(cpu, reg, data[0], data[1]);
> +		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
>  		if (err)
> -			return err;
> +			return -EIO;
>  		tmp += 2;
>  	}
>  

Patch looks OK to me.

Acked-by: Jean Delvare <khali at linux-fr.org>

-- 
Jean Delvare

