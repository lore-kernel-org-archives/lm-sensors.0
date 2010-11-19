From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Nov 2010 18:17:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (i5k_amb) Fix compile warning
Message-Id: <20101119191759.7e283249@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1290188513-31924-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1290188513-31924-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Nov 2010 09:41:53 -0800, Guenter Roeck wrote:
> This patch fixes the following compile warning.
> 
> drivers/hwmon/i5k_amb.c:500: warning: 'i5k_amb_ids' defined but not used
> 
> The warning is seen if the driver is built into the kernel (not as module).
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/i5k_amb.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index 9379834..c4c40be 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -497,12 +497,14 @@ static unsigned long chipset_ids[] = {
>  	0
>  };
>  
> +#ifdef MODULE
>  static struct pci_device_id i5k_amb_ids[] __devinitdata = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
> +#endif
>  
>  static int __devinit i5k_amb_probe(struct platform_device *pdev)
>  {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
