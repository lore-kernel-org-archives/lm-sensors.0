From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Aug 2010 16:21:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100817182138.63cb01ec@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Mon, 16 Aug 2010 11:17:36 +0200, Andreas Herrmann wrote:
> From: Andreas Herrmann <andreas.herrmann3@amd.com>
> 
> Commit 8bf0223ed515be24de0c671eedaff49e78bebc9c (hwmon, k8temp: Fix
> temperature reporting for ASB1 processor revisions) fixed temperature
> reporting for ASB1 CPUs. But one dual core CPU model (model 0x6b) was
> packaged both as AM2 (desktop) and ASB1 (mobile). Thus the commit
> leads to wrong temperature reporting for the AM2 CPU part.
> 
> The solution is to determine the package type for model 0x6b.
> 
> This is done using BrandId from CPUID Fn8000_0001_EBX[15:0]. See
> "Constructing the processor Name String" in "Revision Guide for AMD
> NPT Family 0Fh Processors" (Rev. 3.46).
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Cc: stable@kernel.org [.32.x .34.x, .35.x]
> Reported-by: Vladislav Guberinic <neosisani@gmail.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   27 +++++++++++++++++++++++----
>  1 files changed, 23 insertions(+), 4 deletions(-)
> 
> Sorry, but I missed that model 0x6b was also packaged as AM2.
> Please apply this fix.

Thanks for the heads up. I'm a little confused though, see below.

> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 1fdd63e..bcb1a35 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -143,6 +143,28 @@ static const struct pci_device_id k8temp_ids[] = {
>  
>  MODULE_DEVICE_TABLE(pci, k8temp_ids);
>  
> +static int is_rev_g_desktop(u8 model)
> +{
> +	u32 brandidx;
> +
> +	if (model < 0x69)
> +		return 0;
> +
> +	if (model = 0xc1 || model = 0x6c || model = 0x7c ||
> +	    model = 0x6f || model = 0x7f)
> +		return 0;
> +
> +	if (model = 0x6b) {
> +		/* differentiate between AM2 and ASB1 */
> +		brandidx = cpuid_ebx(0x80000001);
> +		brandidx = (brandidx >> 9) & 0x1f;
> +		if (brandidx > 0xa)

This will only catch the "AMD Sempron(tm) Processor 2RRU" entry, if I
read both the code and the datasheet right? Is this correct? What about
the 3 other ASB1 entries in table 8? And why are you comparing with 0xa
while this specific value doesn't match any CPU model?

> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static int __devinit k8temp_probe(struct pci_dev *pdev,
>  				  const struct pci_device_id *id)
>  {
> @@ -179,9 +201,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
>  				 "wrong - check erratum #141\n");
>  		}
>  
> -		if ((model >= 0x69) &&
> -		    !(model = 0xc1 || model = 0x6c || model = 0x7c ||
> -		      model = 0x6b || model = 0x6f || model = 0x7f)) {
> +		if (is_rev_g_desktop(model))
>  			/*
>  			 * RevG desktop CPUs (i.e. no socket S1G1 or
>  			 * ASB1 parts) need additional offset,
> @@ -189,7 +209,6 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
>  			 * ambient temperature
>  			 */
>  			data->temp_offset = 21000;
> -		}
>  
>  		break;
>  	}

I also do not like the brace change. While technically correct, it
could lead to mistakes on future changes, because the large comment
doesn't make it immediately obvious that this is currently a
single-statement branch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
