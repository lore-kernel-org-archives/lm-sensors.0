From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Wed, 30 May 2012 15:55:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Improve support of recent Atom CPU models
Message-Id: <2031343.XcArEAHFmo@ws-stein>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120530132956.6161d552@endymion.delvare>
In-Reply-To: <20120530132956.6161d552@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Mittwoch, 30. Mai 2012, 13:29:56 schrieb Jean Delvare:
> Document the new Atom series (Tunnel Creek and Medfield) as being
> supported, and list TjMax for the Atom E600 series.
> 
> Also enable the Atom tjmax heuristic for these Atom CPU models.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> ---
> This patch has been sitting in my tree for months now for no good
> reason, it's about time to push it upstream. Testers are welcome.
> 
>  Documentation/hwmon/coretemp |    5 ++++-
>  drivers/hwmon/coretemp.c     |    3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> --- linux-3.1-rc4.orig/Documentation/hwmon/coretemp	2011-09-28 12:45:58.000000000 +0200
> +++ linux-3.1-rc4/Documentation/hwmon/coretemp	2011-09-28 16:18:18.000000000 +0200
> @@ -6,7 +6,8 @@ Supported chips:
>      Prefix: 'coretemp'
>      CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
>                                0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
> -                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield)
> +                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
> +                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom)
>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>                 http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
> @@ -85,6 +86,8 @@ Process		Processor					TjMax(C)
>  		N475/470/455/450				100
>  		N280/270					90
>  		330/230						125
> +		E680/660/640/620				90
> +		E680T/660T/640T/620T				110
>  
>  45nm		Core2 Processors
>  		Solo ULV SU3500/3300				100

Maybe it makes sense to state here explicitly that the 110 degree TjMax for the E6XXT series cannot be autodetected and the user should use tjmax module parameter.

> --- linux-3.1-rc4.orig/drivers/hwmon/coretemp.c	2011-09-28 14:22:44.000000000 +0200
> +++ linux-3.1-rc4/drivers/hwmon/coretemp.c	2011-09-28 16:23:29.000000000 +0200
> @@ -210,7 +210,8 @@ static int adjust_tjmax(struct cpuinfo_x
>  
>  	/* Atom CPUs */
>  
> -	if (c->x86_model = 0x1c) {
> +	if (c->x86_model = 0x1c || c->x86_model = 0x26
> +	    || c->x86_model = 0x27) {
>  		usemsr_ee = 0;
>  
>  		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> 
> 
> 
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
