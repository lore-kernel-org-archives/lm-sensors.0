From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Aug 2015 14:46:18 +0000
Subject: Re: [lm-sensors] [PATCH 03/15] hwmon, fam15h_power: refactor attributes for dynamically added
Message-Id: <55DF22BA.7080306@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-4-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-4-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?windows-1252?Q?Fr=E9d=E9ric_We?= =?windows-1252?Q?isbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/27/2015 01:07 AM, Huang Rui wrote:
> Attributes depend on the CPU model the driver gets loaded on.
> Therefore, add those attributes dynamically at init time. This is more
> flexible to control the different attributes on different platforms.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/hwmon/fam15h_power.c | 49 +++++++++++++++++++++++++++-----------------
>   1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 820adf1..65ffb06 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -41,6 +41,8 @@ MODULE_LICENSE("GPL");
>   #define REG_TDP_RUNNING_AVERAGE		0xe0
>   #define REG_TDP_LIMIT3			0xe8
>
> +#define FAM15H_MIN_POWER_GROUPS		2

This should be something like FAM15H_MIN_NUM_ATTRS.
There is only one group with a variable number of attributes.

> +
>   struct fam15h_power_data {
>   	struct pci_dev *pdev;
>   	unsigned int tdp_to_watts;
> @@ -93,29 +95,35 @@ static ssize_t show_power_crit(struct device *dev,
>   }
>   static DEVICE_ATTR(power1_crit, S_IRUGO, show_power_crit, NULL);
>
> -static umode_t fam15h_power_is_visible(struct kobject *kobj,
> -				       struct attribute *attr,
> -				       int index)
> +static struct attribute_group fam15h_power_group;
> +__ATTRIBUTE_GROUPS(fam15h_power);
> +
> +static int fam15h_power_init_attrs(struct pci_dev *pdev)
>   {
> -	/* power1_input is only reported for Fam15h, Models 00h-0fh */
> -	if (attr = &dev_attr_power1_input.attr &&
> -	   (boot_cpu_data.x86 != 0x15 || boot_cpu_data.x86_model > 0xf))
> -		return 0;
> +	int n = FAM15H_MIN_POWER_GROUPS;
> +	struct attribute **fam15h_power_attrs;
>
> -	return attr->mode;
> -}
> +	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model <= 0xf)
> +		n += 1;
>
> -static struct attribute *fam15h_power_attrs[] = {
> -	&dev_attr_power1_input.attr,
> -	&dev_attr_power1_crit.attr,
> -	NULL
> -};
> +	fam15h_power_attrs = devm_kcalloc(&pdev->dev, n,
> +					  sizeof(*fam15h_power_attrs),
> +					  GFP_KERNEL);
>
> -static const struct attribute_group fam15h_power_group = {
> -	.attrs = fam15h_power_attrs,
> -	.is_visible = fam15h_power_is_visible,
> -};
> -__ATTRIBUTE_GROUPS(fam15h_power);
> +	if (!fam15h_power_attrs) {
> +		dev_err(&pdev->dev, "failed to alloc fam15h_power_attrs\n");

The infrastructure already dumps a message for memory allocation errors.
No need for another one.

> +		return -ENOMEM;
> +	}
> +
> +	n = 0;
> +	fam15h_power_attrs[n++] = &dev_attr_power1_crit.attr;
> +	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model <= 0xf)
> +		fam15h_power_attrs[n++] = &dev_attr_power1_input.attr;
> +
> +	fam15h_power_group.attrs = fam15h_power_attrs;
> +
Assuming this will be called for each CPU in a multi-CPU system,
this will be overwritten each time a new CPU comes online.
fam15h_power_group and fam15h_power_groups probably need to be moved
into fam15h_power_data to avoid that. In essence, there should only
be read-only static variables. Everything else should be allocated.

> +	return 0;
> +}
>
>   static bool should_load_on_this_node(struct pci_dev *f4)
>   {
> @@ -221,6 +229,9 @@ static int fam15h_power_probe(struct pci_dev *pdev,
>   	if (!data)
>   		return -ENOMEM;
>
> +	if (fam15h_power_init_attrs(pdev))
> +		return -ENOMEM;

This should return the error code from fam15h_power_init_attrs().

> +
>   	fam15h_power_init_data(pdev, data);
>   	data->pdev = pdev;
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
