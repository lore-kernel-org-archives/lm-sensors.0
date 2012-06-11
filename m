From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Jun 2012 15:50:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/3] hwmon: (coretemp) Add support for Atom D2000 and N2000 series CPU mo
Message-Id: <20120611175020.4b02f840@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338958116-6205-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338958116-6205-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  5 Jun 2012 21:48:35 -0700, Guenter Roeck wrote:
> Document the Atom series D2000 and N2000 (Cedar Trail) as being supported.
> List and set TjMax for those series.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Still not clear if this is needed, or if the CPUs support the
> IA32_TEMPERATURE_TARGET register. I didn;t find anything in the documentation,
> so I suspect it is necessary. Would be nice to get it confirmed, though.

Would be great, yes, but I'm afraid you're right. Durga, Fenghua, if
you have access to these parts, can you check for
IA32_TEMPERATURE_TARGET support?

> 
> v2: Tjmax is 100 degrees C for all D2000 and N2000 CPU variants.
>     Update code to reflect it.
> 
>  Documentation/hwmon/coretemp |    5 ++++-
>  drivers/hwmon/coretemp.c     |    8 +++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index f6aed440..651a7ab 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -7,7 +7,8 @@ Supported chips:
>      CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
>                                0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
>                                0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
> -                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom)
> +                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom),
> +                              0x36 (Cedar Trail Atom)
>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>                 http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
> @@ -68,6 +69,8 @@ Process		Processor					TjMax(C)
>  
>  32nm		Atom Processors
>  		Z2460						90
> +		D2500/2550/2700					100
> +		N2600/2650/2800/2850				100

I've inverted these lists to have decreasing numbers, as done
everywhere else in the document (no idea why...)

>  
>  45nm		Xeon Processors 5400 Quad-Core
>  		X5492, X5482, X5472, X5470, X5460, X5450	85
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 495add5..928a3ec 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -210,10 +210,12 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
>  
>  	/* Atom CPUs */
>  
> -	if (c->x86_model = 0x1c || c->x86_model = 0x26
> -	    || c->x86_model = 0x27) {
> +	if (c->x86_model = 0x36) {
> +		usemsr_ee = 0;
> +		tjmax = 100000;
> +	} else if (c->x86_model = 0x1c || c->x86_model = 0x26
> +		   || c->x86_model = 0x27) {
>  		usemsr_ee = 0;
> -
>  		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
>  
>  		if (host_bridge && host_bridge->vendor = PCI_VENDOR_ID_INTEL

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
