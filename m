From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 30 Mar 2012 13:46:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: k10temp: Add support for AMD Trinity CPUs
Message-Id: <20120330134647.GA18299@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333108649-22338-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333108649-22338-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 30, 2012 at 07:57:29AM -0400, Andre Przywara wrote:
> The on-chip northbridge's temperature sensor of the upcoming
> AMD Trinity CPUs works the same as for the previous CPUs.
> Since it has a different PCI-ID, we just add the new one to the list
> supported by k10temp.
> This allows us to use the k10temp driver on those CPUs.
> 
> On that way move the PCI-ID definition for the Llano and Brazos
> northbridges from pci_ids.h into this driver, since it's the only
> user and the header of pci_ids.h tell us to do so.
> 
Actually, it says that you should only _add_ an entry if that entry is shared,
not that you should remove entries. So, as Clemens pointed out, this is
an unnecessary change.

Please re-submit w/o that removal. I don't want to have to touch pci_ids.h
that late in the commit window, much less after the commit window closes.

Thanks,
Guenter

> Signed-off-by: Andre Przywara <andre.przywara@amd.com>
> ---
>  Documentation/hwmon/k10temp |    2 +-
>  drivers/hwmon/Kconfig       |    3 ++-
>  drivers/hwmon/k10temp.c     |    7 ++++++-
>  include/linux/pci_ids.h     |    1 -
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp
> index a10f736..90956b6 100644
> --- a/Documentation/hwmon/k10temp
> +++ b/Documentation/hwmon/k10temp
> @@ -11,7 +11,7 @@ Supported chips:
>    Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
>  * AMD Family 12h processors: "Llano" (E2/A4/A6/A8-Series)
>  * AMD Family 14h processors: "Brazos" (C/E/G/Z-Series)
> -* AMD Family 15h processors: "Bulldozer"
> +* AMD Family 15h processors: "Bulldozer" (FX-Series), "Trinity"
>  
>    Prefix: 'k10temp'
>    Addresses scanned: PCI space
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b32d56..7d7b63d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -253,7 +253,8 @@ config SENSORS_K10TEMP
>  	  If you say yes here you get support for the temperature
>  	  sensor(s) inside your CPU. Supported are later revisions of
>  	  the AMD Family 10h and all revisions of the AMD Family 11h,
> -	  12h (Llano), 14h (Brazos) and 15h (Bulldozer) microarchitectures.
> +	  12h (Llano), 14h (Brazos) and 15h (Bulldozer/Trinity)
> +	  microarchitectures.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called k10temp.
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index aba29d6..0af326d 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -33,6 +33,10 @@ static bool force;
>  module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
>  
> +/* PCI-IDs for Northbridge devices not used anywhere else */
> +#define PCI_DEVICE_ID_AMD_12H_14H_NB_F3		0x1703
> +#define PCI_DEVICE_ID_AMD_15H_M10H_NB_F3	0x1403
> +
>  /* CPUID function 0x80000001, ebx */
>  #define CPUID_PKGTYPE_MASK	0xf0000000
>  #define CPUID_PKGTYPE_F		0x00000000
> @@ -208,8 +212,9 @@ static void __devexit k10temp_remove(struct pci_dev *pdev)
>  static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
> -	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_12H_14H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M10H_NB_F3) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, k10temp_id_table);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 3329965..e6d3db1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -523,7 +523,6 @@
>  #define PCI_DEVICE_ID_AMD_15H_NB_F3	0x1603
>  #define PCI_DEVICE_ID_AMD_15H_NB_F4	0x1604
>  #define PCI_DEVICE_ID_AMD_15H_NB_F5	0x1605
> -#define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
>  #define PCI_DEVICE_ID_AMD_SCSI		0x2020
> -- 
> 1.7.4.4
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
