From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Aug 2015 14:56:35 +0000
Subject: Re: [lm-sensors] [PATCH 08/15] hwmon, fam15h_power: add max compute unit accumulated power
Message-Id: <55DF2523.1010605@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-9-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-9-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?windows-1252?Q?Fr=E9d=E9ric_We?= =?windows-1252?Q?isbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/27/2015 01:07 AM, Huang Rui wrote:
> This patch adds a member in fam15h_power_data which specifies the
> maximum accumulated power in a compute unit.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/hwmon/fam15h_power.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index d6efcf6..fdfa18e 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -26,6 +26,7 @@
>   #include <linux/pci.h>
>   #include <linux/bitops.h>
>   #include <asm/processor.h>
> +#include <asm/msr.h>
>
>   MODULE_DESCRIPTION("AMD Family 15h CPU processor power monitor");
>   MODULE_AUTHOR("Andreas Herrmann <herrmann.der.user@googlemail.com>");
> @@ -43,12 +44,16 @@ MODULE_LICENSE("GPL");
>
>   #define FAM15H_MIN_POWER_GROUPS		2
>
> +#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
> +
>   struct fam15h_power_data {
>   	struct pci_dev *pdev;
>   	unsigned int tdp_to_watts;
>   	unsigned int base_tdp;
>   	unsigned int processor_pwr_watts;
>   	unsigned int cpu_pwr_sample_ratio;
> +	/* maximum accumulated power of a compute unit */
> +	u64 max_cu_acc_power;
>   };
>
>   static ssize_t show_power(struct device *dev,
> @@ -199,8 +204,8 @@ static int fam15h_power_resume(struct pci_dev *pdev)
>   #define fam15h_power_resume NULL
>   #endif
>
> -static void fam15h_power_init_data(struct pci_dev *f4,
> -					     struct fam15h_power_data *data)
> +static int fam15h_power_init_data(struct pci_dev *f4,
> +				  struct fam15h_power_data *data)
>   {
>   	u32 val, eax, ebx, ecx, edx;
>   	u64 tmp;
> @@ -228,7 +233,7 @@ static void fam15h_power_init_data(struct pci_dev *f4,
>
>   	/* CPUID Fn8000_0007:EDX[12] indicates to support accumulated power */
>   	if (!(edx & BIT(12)))
> -		return;
> +		return 0;
>
>   	/*
>   	 * detemine the ratio of the compute unit power accumulator
> @@ -236,6 +241,15 @@ static void fam15h_power_init_data(struct pci_dev *f4,
>   	 * Fn8000_0007:ECX
>   	 */
>   	data->cpu_pwr_sample_ratio = ecx;
> +
> +	if (rdmsrl_safe(MSR_F15H_CU_MAX_PWR_ACCUMULATOR, &tmp)) {
> +		pr_err("Failed to read max compute unit power accumulator MSR\n");
> +		return -ENODEV;
> +	}
> +
> +	data->max_cu_acc_power = tmp;
> +
> +	return 0;
>   }
>
>   static int fam15h_power_probe(struct pci_dev *pdev,
> @@ -262,7 +276,9 @@ static int fam15h_power_probe(struct pci_dev *pdev,
>   	if (fam15h_power_init_attrs(pdev))
>   		return -ENOMEM;
>
> -	fam15h_power_init_data(pdev, data);
> +	if (fam15h_power_init_data(pdev, data))
> +		return -ENODEV;
> +
This should return the error code from fam15h_power_init_data().

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
