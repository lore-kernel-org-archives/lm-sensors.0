From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 07:24:23 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/coretemp: Remove warnings of
Message-Id: <20100819092423.00f76256@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
	<1282172027-640-2-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1282172027-640-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Chen Gong <gong.chen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Fenghua,

On Wed, 18 Aug 2010 15:53:46 -0700, Fenghua Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Remove compilation warnings of unused variables p and n in coretemp_init().
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/hwmon/coretemp.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index c070c97..de81111 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -518,7 +518,6 @@ static struct notifier_block coretemp_cpu_notifier __refdata = {
>  static int __init coretemp_init(void)
>  {
>  	int i, err = -ENODEV;
> -	struct pdev_entry *p, *n;
>  
>  	/* quick check if we run Intel */
>  	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)

Thanks for the fix, but it is already in my tree:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/hwmon-coretemp-fix-warning.patch

I'll send it to Linus as part as my next batch of hwmon fixes for
2.6.36.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
