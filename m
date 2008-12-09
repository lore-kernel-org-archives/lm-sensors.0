From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 09 Dec 2008 22:12:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (k8temp) adapt cpuid handling,
Message-Id: <493EED57.1090005@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081205174612.GB5581@alberich.amd.com>
In-Reply-To: <20081205174612.GB5581@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Sorry for the delay.

> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>

Maybe also some desc. Well the reason why the code below looks like is that

1) avoid very old systems - the idea that revs of CPU will be similar/same
2) get the cpuid from PCI. This is good, because some CPU may have the problem, 
some other may not.

Your patch reduces this to boot CPU checks. The idea was to have the driver know 
exact CPUID for each PCI driver instance. It was prepared to situation when some 
CPU steppings will have the fix, some not.

Please tell me why it is not necessary or why you changed that ;)

Thanks,
Rudolf




> ---
>  drivers/hwmon/k8temp.c |   27 ++++++++++++---------------
>  1 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 3b90384..712c208 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -31,6 +31,7 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> +#include <asm/processor.h>
>  
>  #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
>  #define REG_TEMP	0xe4
> @@ -48,7 +49,6 @@ struct k8temp_data {
>  	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
> -	u8 fam;
>  };
>  
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -143,30 +143,27 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
>  	int err;
>  	u8 scfg;
>  	u32 temp;
> +	u8 model, stepping;
>  	struct k8temp_data *data;
> -	u32 cpuid = cpuid_eax(1);
> -
> -	/* this feature should be available since SH-C0 core */
> -	if ((cpuid = 0xf40) || (cpuid = 0xf50) || (cpuid = 0xf51)) {
> -		err = -ENODEV;
> -		goto exit;
> -	}
>  
>  	if (!(data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL))) {
>  		err = -ENOMEM;
>  		goto exit;
>  	}
>  
> -	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */
> -	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
> -
> -	data->fam = (cpuid & 0x00000f00) >> 8;
> -	data->fam += (cpuid & 0x0ff00000) >> 20;
> +	model = boot_cpu_data.x86_model;
> +	stepping = boot_cpu_data.x86_mask;
>  
> -	switch (data->fam) {
> +	switch (boot_cpu_data.x86) {
>  	case 0xf:
> +		/* feature available since SH-C0, exclude older revisions */
> +		if (((model = 4) && (stepping = 0)) ||
> +		    ((model = 5) && ((stepping = 0) || (stepping = 1)))) {
> +			err = -ENODEV;
> +			goto exit;
> +		}
>  		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> -					" - check errata #141\n");
> +			 " - check erratum #141\n");
>  		break;
>  	}
>  
> -- 1.6.0.4 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
