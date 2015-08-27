From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 27 Aug 2015 14:50:28 +0000
Subject: Re: [lm-sensors] [PATCH 05/15] hwmon, fam15h_power: enable power1_input on AMD Carrizo
Message-Id: <55DF23B4.40609@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440662866-28716-1-git-send-email-ray.huang@amd.com> <1440662866-28716-6-git-send-email-ray.huang@amd.com>
In-Reply-To: <1440662866-28716-6-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Rui <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, Jean Delvare <jdelvare@suse.de>, Andy Lutomirski <luto@amacapital.net>, Andreas Herrmann <herrmann.der.user@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, John Stultz <john.stultz@linaro.org>, =?windows-1252?Q?Fr=E9d=E9ric_We?= =?windows-1252?Q?isbecker?= <fweisbec@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, x86@kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Fengguang Wu <fengguang.wu@intel.com>, Aaron Lu <aaron.lu@intel.com>, Tony Li <tony.li@amd.com>

On 08/27/2015 01:07 AM, Huang Rui wrote:
> This patch enables power1_input attribute for Carrizo platform.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Needs rebase to updated #3, otherwise looks good.

Thanks,
Guenter

> ---
>   drivers/hwmon/fam15h_power.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 3e9b3b9..55b25ef 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -113,8 +113,11 @@ static int fam15h_power_init_attrs(struct pci_dev *pdev)
>   {
>   	int n = FAM15H_MIN_POWER_GROUPS;
>   	struct attribute **fam15h_power_attrs;
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
>
> -	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model <= 0xf)
> +	if (c->x86 = 0x15 &&
> +	    ((c->x86_model <= 0xf) ||
> +	     (c->x86_model >= 0x60 && c->x86_model <= 0x6f)))
>   		n += 1;
>
>   	fam15h_power_attrs = devm_kcalloc(&pdev->dev, n,
> @@ -128,7 +131,9 @@ static int fam15h_power_init_attrs(struct pci_dev *pdev)
>
>   	n = 0;
>   	fam15h_power_attrs[n++] = &dev_attr_power1_crit.attr;
> -	if (boot_cpu_data.x86 = 0x15 && boot_cpu_data.x86_model <= 0xf)
> +	if (c->x86 = 0x15 &&
> +	    ((c->x86_model <= 0xf) ||
> +	     (c->x86_model >= 0x60 && c->x86_model <= 0x6f)))
>   		fam15h_power_attrs[n++] = &dev_attr_power1_input.attr;
>
>   	fam15h_power_group.attrs = fam15h_power_attrs;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
