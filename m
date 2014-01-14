From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Jan 2014 21:24:52 +0000
Subject: Re: [lm-sensors] k10temp Kaveri support (was: Re: Test patch)
Message-Id: <20140114212452.GA27681@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 14, 2014 at 10:46:46AM -0800, Phil Pokorny wrote:
> Add new PCI ID to k10temp in support of new model "Kaveri" family.
> 
> Signed-off-by: Philip Pokorny <ppokorny@penguincomputing.com>
> 
Odd headline ;-). I fixed that as well as the patch format (spaces instead of
tabs below) and applied it to hwmon-next.

Thanks,
Guenter

> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index d65f3fd..758774f 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -210,6 +210,7 @@ static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_F3) },
> +       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F3) },
>         { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
>         {}
>  };
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
