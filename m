From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Mar 2016 03:33:55 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/6] hwmon: (fam15h_power) Add compute unit accumulated power
Message-Id: <56E38E23.1060708@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1457662670-3354-1-git-send-email-ray.huang@amd.com>
 <1457662670-3354-3-git-send-email-ray.huang@amd.com>
In-Reply-To: <1457662670-3354-3-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Huang Rui <ray.huang@amd.com>, Jean Delvare <jdelvare@suse.de>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, spg_linux_kernel@amd.com, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>

On 03/10/2016 06:17 PM, Huang Rui wrote:
> This patch adds a member in fam15h_power_data which specifies the
> compute unit accumulated power. It adds do_read_registers_on_cu to do
> all the read to all MSRs and run it on one of the online cores on each
> compute unit with smp_call_function_many(). This behavior can decrease
> IPI numbers.
>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/hwmon/fam15h_power.c | 61 +++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 4f695d8..c5e2297 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -25,6 +25,8 @@
>   #include <linux/module.h>
>   #include <linux/pci.h>
>   #include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
>   #include <asm/processor.h>
>   #include <asm/msr.h>
>
> @@ -44,7 +46,9 @@ MODULE_LICENSE("GPL");
>
>   #define FAM15H_MIN_NUM_ATTRS		2
>   #define FAM15H_NUM_GROUPS		2
> +#define MAX_CUS				8
>
> +#define MSR_F15H_CU_PWR_ACCUMULATOR	0xc001007a
>   #define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
>
>   #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
> @@ -59,6 +63,8 @@ struct fam15h_power_data {
>   	struct attribute_group group;
>   	/* maximum accumulated power of a compute unit */
>   	u64 max_cu_acc_power;
> +	/* accumulated power of the compute units */
> +	u64 cu_acc_power[MAX_CUS];
>   };
>
>   static ssize_t show_power(struct device *dev,
> @@ -125,6 +131,59 @@ static ssize_t show_power_crit(struct device *dev,
>   }
>   static DEVICE_ATTR(power1_crit, S_IRUGO, show_power_crit, NULL);
>
> +static void do_read_registers_on_cu(void *_data)
> +{
> +	struct fam15h_power_data *data =3D _data;
> +	int cpu, cu;
> +
> +	cpu =3D smp_processor_id();
> +
> +	cu =3D cpu / smp_num_siblings;
> +

If smp is not configured:

drivers/hwmon/fam15h_power.c: In function =91do_read_registers_on_cu=92:
drivers/hwmon/fam15h_power.c:144:13: error: =91smp_num_siblings=92 undeclar=
ed (first use in this function)

Guenter

> +	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
> +}
> +
> +/*
> + * This function is only able to be called when CPUID
> + * Fn8000_0007:EDX[12] is set.
> + */
> +static int read_registers(struct fam15h_power_data *data)
> +{
> +	int this_cpu, ret, cpu;
> +	int target;
> +	cpumask_var_t mask;
> +
> +	ret =3D zalloc_cpumask_var(&mask, GFP_KERNEL);
> +	if (!ret)
> +		return -ENOMEM;
> +
> +	get_online_cpus();
> +	this_cpu =3D get_cpu();
> +
> +	/*
> +	 * Choose the first online core of each compute unit, and then
> +	 * read their MSR value of power and ptsc in a single IPI,
> +	 * because the MSR value of CPU core represent the compute
> +	 * unit's.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		target =3D cpumask_first(topology_sibling_cpumask(cpu));
> +		if (!cpumask_test_cpu(target, mask))
> +			cpumask_set_cpu(target, mask);
> +	}
> +
> +	if (cpumask_test_cpu(this_cpu, mask))
> +		do_read_registers_on_cu(data);
> +
> +	smp_call_function_many(mask, do_read_registers_on_cu, data, true);
> +	put_cpu();
> +	put_online_cpus();
> +
> +	free_cpumask_var(mask);
> +
> +	return 0;
> +}
> +
>   static int fam15h_power_init_attrs(struct pci_dev *pdev,
>   				   struct fam15h_power_data *data)
>   {
> @@ -263,7 +322,7 @@ static int fam15h_power_init_data(struct pci_dev *f4,
>
>   	data->max_cu_acc_power =3D tmp;
>
> -	return 0;
> +	return read_registers(data);
>   }
>
>   static int fam15h_power_probe(struct pci_dev *pdev,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
