From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Apr 2008 12:34:53 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 1/5] lm75: cleanup/reorg
Message-Id: <20080419143453.3e363221@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161029.23656.david-b@pacbell.net>
In-Reply-To: <200804161029.23656.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Apr 2008 13:49:31 -0700, David Brownell wrote:
> Updated patch appended.  The second patch needs corresponding
> fixups; I'll post them after I get any comments on that.

Good idea. I hope to have some time for this later today, if Laurent
doesn't beat me at it.

> Minor cleanup and reorg of the lm75 code.
> 
>  - Kconfig provides a larger list of lm75-compatible chips
> 
>  - A top comment now says what the driver does (!) ... as in, just
>    what sort of sensor is this??
> 
>  - Section comments now delineate the various sections of the driver:
>    hwmon attributes, driver binding, register access, module glue.
>    One driver binding function moved out of the attribute section,
>    as did the driver struct itself.
> 
>  - Minor tweaks to legacy probe logic:  correct a comment, and
>    remove a pointless variable.
> 
>  - Whitespace, linelength, and comment fixes.
> 
> This patch should include no functional changes.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |   17 ++++++---
>  drivers/hwmon/lm75.c  |   90 ++++++++++++++++++++++++++++----------------------
>  2 files changed, 62 insertions(+), 45 deletions(-)
> 
> --- ngw.orig/drivers/hwmon/Kconfig	2008-04-18 11:16:46.000000000 -0700
> +++ ngw/drivers/hwmon/Kconfig	2008-04-18 11:24:59.000000000 -0700
> @@ -380,13 +380,18 @@ config SENSORS_LM75
>  	tristate "National Semiconductor LM75 and compatibles"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for National Semiconductor LM75
> -	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
> -	  9-bit precision mode), and TelCom (now Microchip) TCN75.
> +	  If you say yes here you get support for one common type of
> +	  temperature sensor chip, with models including:
>  
> -	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
> -	  a force module parameter. The driver will not handle the extra
> -	  precision anyhow.
> +		- Dallas Semiconductor DS75 and DS1775
> +		- Maxim MAX6625 and MAX6626
> +		- Microchip MCP980x
> +		- National Semiconductor LM75 and LM75A

The LM75A is actually a Philips (NXP) part, not a National
Semiconductor part.

> +		- ST Microelectronics STDS75
> +		- TelCom (now Microchip) TCN75
> +		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
> +
> +	  Most of these chips will require a "force" module parameter.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm75.

But anyway, all the rest is correct so

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
