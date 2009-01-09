From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Jan 2009 13:43:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (k8temp) adapt cpuid handling,
Message-Id: <20090109144326.4ec47ccd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 00:07:51 +0100, Andreas Herrmann wrote:
> We don't need to use northbridge based CPUID checking as the allowed
> combinations of processors ensure that all processors in a multisocket
> system have similar characteristics, e.g.
> 
> (1) provide temperature sensor interface (>=RevC && <RevF)
> (2) are affected by erratum #141 (>=RevF)
> 
> Thus it is sufficient to check the revision of the boot CPU.
> 
> For "mixed silicon support" refer to
> "Revision Guide for AMD Athlon 64 and AMD Opteron Processors" (RevA-E) and
> "Revision Guide for AMD NPT Family 0Fh Processors" (RefF-G).
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   26 +++++++++++---------------
>  1 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 3b90384..be93387 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -31,10 +31,10 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> +#include <asm/processor.h>
>  
>  #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
>  #define REG_TEMP	0xe4
> -#define REG_CPUID	0xfc
>  #define SEL_PLACE	0x40
>  #define SEL_CORE	0x04
>  
> @@ -48,7 +48,6 @@ struct k8temp_data {
>  	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
> -	u8 fam;
>  };
>  
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -143,28 +142,25 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
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
>  					" - check errata #141\n");
>  		break;

Applied, thanks. This is essentially an alternative implementation of
Rudolf's patch, so I think I'll merge both patches together to get a
clearer history.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
