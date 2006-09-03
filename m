From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Sep 2006 13:32:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: vt1211 documentation update
Message-Id: <20060903153203.36561c05.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0609021507n5e4ba366l5bacba0b2eeee151@mail.gmail.com>
In-Reply-To: <191fb4ca0609021507n5e4ba366l5bacba0b2eeee151@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> This patch adds a description of the module load parameters to the
> documentation of the vt1211.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Eek, it appears that your mailer broke the patch by wrapping long
lines. Please send it again. If your mailer can't deal with inline
patches, just attach it instead, that's fine with me.

Thanks,

> 
> ---
> 
> --- Documentation/hwmon/vt1211.orig     2006-09-02 14:38:59.000000000 -0700
> +++ Documentation/hwmon/vt1211  2006-09-02 14:56:02.000000000 -0700
> @@ -16,6 +16,26 @@
>  technical support.
> 
> 
> +Module Parameters
> +-----------------
> +
> +* uch_config: int      Override the BIOS default universal channel (UCH)
> +                       configuration for channels 1-5.
> +                       Legal values are in the range of 0-31. Bit 0 maps to
> +                       UCH1, bit 1 maps to UCH2 and so on. Setting a bit to 1
> +                       enables the thermal input of that particular UCH and
> +                       setting a bit to 0 enables the voltage input.
> +
> +* int_mode: int                Override the BIOS default temperature
> interrupt mode.
> +                       The only possible value is 0 which forces interrupt
> +                       mode 0. In this mode, any pending interrupt is cleared
> +                       when the status register is read but is regenerated as
> +                       long as the temperature stays above the hysteresis
> +                       limit.
> +
> +Be aware that overriding BIOS defaults might cause some unwanted side effects!
> +
> +
>  Description
>  -----------
> 
> @@ -88,9 +108,7 @@
>  hysteresis value with each temperature below which the temperature has to drop
>  before the alarm is cleared (this is only true for interrupt mode 0). The
>  interrupt mode can be forced to 0 in case the BIOS doesn't do it
> -automatically. For that, the parameter int_mode=0 needs to be supplied when
> -loading the driver module. Be aware that overriding BIOS defaults might cause
> -some unwanted side effects!
> +automatically. See the 'Module Parameters' section for details.
> 
>  All temperature channels except temp2 are external. Temp2 is the VT1211
>  internal thermal diode and the driver does all the scaling for temp2 and


-- 
Jean Delvare

