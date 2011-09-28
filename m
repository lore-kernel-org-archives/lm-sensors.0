From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 28 Sep 2011 15:11:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Document Atom E660
Message-Id: <1317222689.3888.98.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110928143042.7ddd0c0a@endymion.delvare>
In-Reply-To: <20110928143042.7ddd0c0a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, 2011-09-28 at 08:30 -0400, Jean Delvare wrote:
> Document the new Atom series (Tunnel Creek) as being supported, and
> list TjMax for the Atom E660 and E660T.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> As reported by Alexander weeks ago.
> 
>  Documentation/hwmon/coretemp |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-3.1-rc4.orig/Documentation/hwmon/coretemp	2011-09-28 12:45:58.000000000 +0200
> +++ linux-3.1-rc4/Documentation/hwmon/coretemp	2011-09-28 14:28:24.000000000 +0200
> @@ -6,7 +6,8 @@ Supported chips:
>      Prefix: 'coretemp'
>      CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
>                                0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
> -                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield)
> +                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
> +                              0x26 (Tunnel Creek Atom)
>      Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
>                 Volume 3A: System Programming Guide
>                 http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
> @@ -85,6 +86,8 @@ Process		Processor					TjMax(C)
>  		N475/470/455/450				100
>  		N280/270					90
>  		330/230						125
> +		E660						90
> +		E660T						110
>  
>  45nm		Core2 Processors
>  		Solo ULV SU3500/3300				100
> 

I got lost somewhere in the exchange. Should I apply this one, or are
you going to send out a new version ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
