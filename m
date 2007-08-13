From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Aug 2007 09:35:31 +0000
Subject: Re: [lm-sensors] [PATCH] [29/2many] MAINTAINERS - ADM1025 HARDWARE
Message-Id: <20070813113531.0632f551@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46bff89a.xYL7oyBOdTr8eyH/%joe@perches.com>
In-Reply-To: <46bff89a.xYL7oyBOdTr8eyH/%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Hi Joe,

What a storm :( This should have been one single patch IMHO, or grouped
by maintainer or subsystem or something.

On Sun, 12 Aug 2007 23:22:18 -0700, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry

Can you please point me to where this new pattern was discussed?

> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4faf1ce..91bc5cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -307,6 +307,7 @@ P:	Jean Delvare
>  M:	khali@linux-fr.org
>  L:	lm-sensors@lm-sensors.org
>  S:	Maintained

+F: Documentation/hwmon/adm1025

> +F:	drivers/hwmon/adm1025.c
>  
>  ADM1029 HARDWARE MONITOR DRIVER
>  P:	Corentin Labbe

Other patches I don't comment on, means I'm fine with them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
