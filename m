From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 Mar 2008 10:23:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon (dme1737): probe all addresses
Message-Id: <20080326112334.0600a198@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47E9D5C7.8050507@gmail.com>
In-Reply-To: <47E9D5C7.8050507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 25 Mar 2008 21:49:11 -0700, Juerg Haefliger wrote:
> This patch adds a module load parameter to enable probing of non-standard LPC
> addresses 0x162e and 0x164e when scanning for supported ISA chips.
> 
> Signed-Off-By: Juerg Haefliger <juergh at gmail.com>
> 
> Index: linux/Documentation/hwmon/dme1737
> =================================> --- linux.orig/Documentation/hwmon/dme1737	2008-01-24 14:58:37.000000000 -0800
> +++ linux/Documentation/hwmon/dme1737	2008-03-15 22:19:11.000000000 -0700
> @@ -22,6 +22,8 @@
>  			and PWM output control functions. Using this parameter
>  			shouldn't be required since the BIOS usually takes care
>  			of this.
> +* probe_all_addr: bool	Include non-standard LPC addresses 0x162e and 0x164e
> +			when probing for ISA devices.
>  
>  Note that there is no need to use this parameter if the driver loads without
>  complaining. The driver will say so if it is necessary.

Maybe you could document on which board this parameter is known to be
needed? (EPIA SN18000 if I recall properly.)

> Index: linux/drivers/hwmon/dme1737.c
> =================================> --- linux.orig/drivers/hwmon/dme1737.c	2008-03-15 22:12:39.000000000 -0700
> +++ linux/drivers/hwmon/dme1737.c	2008-03-15 22:17:04.000000000 -0700
> @@ -48,6 +48,11 @@
>  module_param(force_id, ushort, 0);
>  MODULE_PARM_DESC(force_id, "Override the detected device ID");
>  
> +static int probe_all_addr;
> +module_param(probe_all_addr, bool, 0);
> +MODULE_PARM_DESC(probe_all_addr, "Include probing of non-standard LPC "
> +		 "addresses");
> +
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
>  
> @@ -2430,7 +2435,10 @@
>  	}
>  
>  	if (dme1737_isa_detect(0x2e, &addr) &&
> -	    dme1737_isa_detect(0x4e, &addr)) {
> +	    dme1737_isa_detect(0x4e, &addr) &&
> +	    (!probe_all_addr || (probe_all_addr &&

It works, but note that the "probe_all_addr" check is redundant.

> +	     dme1737_isa_detect(0x162e, &addr) &&
> +	     dme1737_isa_detect(0x164e, &addr)))) {
>  		/* Return 0 if we didn't find an ISA device */
>  		return 0;
>  	}

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
