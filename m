From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Mar 2011 03:38:16 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (f71882fg) Document all
Message-Id: <20110324033816.GC15395@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110323215004.5b9ab7b0@endymion.delvare>
In-Reply-To: <20110323215004.5b9ab7b0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 23, 2011 at 04:50:04PM -0400, Jean Delvare wrote:
> The list of supported devices was not always well documented in all
> places. Clarify and list all devices in documentation, Kconfig and
> the driver itself.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/hwmon/f71882fg |   11 +++++++++++
>  drivers/hwmon/Kconfig        |   14 +++++++++++---
>  drivers/hwmon/f71882fg.c     |    2 +-
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
[ ... ]
>  
>  config SENSORS_F71882FG
> -	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
> +	tristate "Fintek F71882FG and compatibles"
>  	help
>  	  If you say yes here you get support for hardware monitoring
> -	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG,
> -	  F71889FG and F8000 Super-I/O chips.
> +	  features of many Fintek Super-I/O (LPC) chips. The currently
> +	  supported chips are:
> +	    F71808E
> +	    F71858FG
> +	    F71862FG and F71863FG
> +	    F71869F and F71869E
> +	    F71882FG and F71883FG
> +	    F71889FG and F81801U
> +	    F71889ED
> +	    F8000
>  
Why not just a simple list ? The grouping seems to be a bit arbitrary unless one knows
that the "and" chip IDs are the same - but users won't usually know that.

Nitpick, so

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
