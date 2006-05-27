From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 27 May 2006 11:22:10 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <20060527132210.434a9b6f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <447815E5.5060601@sh.cvut.cz>
In-Reply-To: <447815E5.5060601@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> --- c/drivers/hwmon/hwmon-vid.c	2006-05-12 01:31:53.000000000 +0200
> +++ linux-2.6.17-rc4/drivers/hwmon/hwmon-vid.c	2006-05-27 10:55:07.954764128 +0200
> (...)
>  /* vrm is the VRM/VRD document version multiplied by 10.
> -   val is the 4-, 5- or 6-bit VID code.
> -   Returned value is in mV to avoid floating point in the kernel. */
> +   val is the 4-, 5-, 6- or 7-bit VID code.

Maybe this is time to go with "4 or more". I'm pretty certain we will
see 8-bit VID codes in the future.

> +   Returned value is in mV to avoid floating point in the kernel. 
> +   Some VID have some bits in uV scale, this is rounded to mV */

This was the case of VRD 10 already, and for this one we do truncate,
not round. We need to be consistent here, either round all, or truncate
all.

>  int vid_from_reg(int val, u8 vrm)
>  {
>  	int vid;
> @@ -80,7 +91,10 @@ int vid_from_reg(int val, u8 vrm)
>  			vid -= 125;
>  		vid /= 10;      /* only return 3 dec. places for now */
>  		return vid;
> -
> +	case 110:		/* Intel Conroe */
> +				/* compute in uV, round to mV */
> +		return((val & 0x7e) ? (1600500 - ((val & 0x7f) - 2) * 6250)
> +				      / 1000 : 0);

If we go for rounding, please separate the +500 offset from the base
voltage value, so as to make it clear it is there for rounding purposes.

>  	case 24:                /* Opteron processor */
>  		return(val = 0x1f ? 0 : 1550 - val * 25);
>  
> @@ -106,6 +120,9 @@ int vid_from_reg(int val, u8 vrm)
>  				    1750 - val * 50);
>  	case 13:
>  		return(1708 - (val & 0x3f) * 16);
> +	case 14:		/* Intel Core */
> +				/* compute in uV, round to mV */
> +		return((1500500 - (val & 0x7f) * 12500) / 1000);

Same here. Additionally, values above 0x77 should be filtered out
somehow, as they seem to be invalid (they would result in 0 or nevative
Vcore.)

-- 
Jean Delvare

