From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Aug 2014 20:17:30 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon, k10temp: Add support for F15h M60h
Message-Id: <20140814201730.GA501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408035262-18026-1-git-send-email-aravind.gopalakrishnan@amd.com>
In-Reply-To: <1408035262-18026-1-git-send-email-aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: clemens@ladisch.de, jdelvare@suse.de, rdunlap@infradead.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de, dan.carpenter@oracle.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 14, 2014 at 11:54:22AM -0500, Aravind Gopalakrishnan wrote:
> This patch adds temperature monitoring support for F15h M60h processor.
>  - Add new pci device id for the relevant processor
>  - The functionality of REG_REPORTED_TEMPERATURE is moved to
>    D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>    - So, use this to get CUR_TEMP value
>    - Since we need an indirect register access, protect this with
>      a mutex lock
>  - Add Kconfig, Doc entries to indicate support for this processor.
> 
> Signed-off-by: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
> ---
> Changes in V2:
>  - Prevent race with other code that may require indirect NB_SMU_REG access
>  - Fix some minor style issues
> 
>  Documentation/hwmon/k10temp   |  2 +-
>  arch/x86/include/asm/amd_nb.h |  2 ++
>  arch/x86/kernel/amd_nb.c      | 15 +++++++++++++++
>  drivers/hwmon/Kconfig         |  6 +++---
>  drivers/hwmon/k10temp.c       | 22 +++++++++++++++++++---
>  5 files changed, 40 insertions(+), 7 deletions(-)
> 
[ ... ]

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 02d3d85..0234a08 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -275,13 +275,13 @@ config SENSORS_K8TEMP
>  
>  config SENSORS_K10TEMP
>  	tristate "AMD Family 10h+ temperature sensor"
> -	depends on X86 && PCI
> +	depends on X86 && PCI && AMD_NB

Is the added dependency acceptable ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
