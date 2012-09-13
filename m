From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Sep 2012 07:13:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Update Kconfig to reference IT8782F and IT8783E/F
Message-Id: <20120913091311.5fe59a77@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347468661-24147-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347468661-24147-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 12 Sep 2012 09:51:01 -0700, Guenter Roeck wrote:
> Add missing reference to IT8782F and IT8783E/F to it87 driver description
> in Kconfig.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b0a2e4c..a90195b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -495,8 +495,8 @@ config SENSORS_IT87
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for ITE IT8705F, IT8712F,
> -	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F and IT8758E
> -	  sensor chips, and the SiS960 clone.
> +	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
> +	  IT8782F, and IT8783E/F sensor chips, and the SiS960 clone.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called it87.

Good catch. While you're here, maybe you can fix the name of the SiS
clone, it's the SiS950 not SiS960. Hard to believe it's been wrong
since September 2003 and I never noticed, despite this line being
repeatedly modified since then.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
