From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Jul 2011 06:30:19 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add support for
Message-Id: <20110708083019.4948bea7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 7 Jul 2011 14:46:22 -0700, Guenter Roeck wrote:
> v2: Stronger detection code. Confidence reduced from 8 to 6.
> 
> --
> 
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5982)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -1055,6 +1055,11 @@
>  		i2c_addrs => [0x4c..0x4d],
>  		i2c_detect => sub { lm90_detect(@_, 13); },
>  	}, {
> +		name => "NXP/Philips SA56004",
> +		driver => "lm90",
> +		i2c_addrs => [0x48..0x4f],
> +		i2c_detect => sub { lm90_detect(@_, 14); },
> +	}, {
>  		name => "Analog Devices ADT7481",
>  		driver => "to-be-written",
>  		i2c_addrs => [0x4c, 0x4b],
> @@ -4352,11 +4357,11 @@
>  #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
>  #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
>  #		  11 = W83L771AWG/ASG, 12 = MAX6690,
> -#		  13 = ADT7461A/NCT1008
> +#		  13 = ADT7461A/NCT1008, 14 = SA56004
>  # Registers used:
>  #   0x03: Configuration
>  #   0x04: Conversion rate
> -#   0xbf: Configuration 2 (National Semiconductor and Winbond only)
> +#   0xbf: Configuration 2 (National Semiconductor, Winbond, and Philips only)
>  #   0xfe: Manufacturer ID
>  #   0xff: Chip ID / die revision
>  sub lm90_detect
> @@ -4457,6 +4462,13 @@
>  		return if $mid != 0x41;		# Analog Devices
>  		return 8 if $cid = 0x57;	# ADT7461A, NCT1008
>  	}
> +	if ($chip = 14) {
> +		return if ($conf & 0x2a) != 0;
> +		return if ($conf2 & 0xfe) != 0;
> +		return if $rate > 0x09;
> +		return if $mid != 0xa1;		# NXP Semiconductor/Philips
> +		return 6 if $cid = 0x00;	# SA56004
> +	}
>  	return;
>  }
>  
> Index: CHANGES
> =================================> --- CHANGES	(revision 5982)
> +++ CHANGES	(working copy)
> @@ -16,6 +16,7 @@
>                    Add detection of MAX6642
>                    Add detection of ITE IT8772E
>                    Don't advertise the ipmisensors driver
> +                  Add detection of SA56004
>  
>  3.3.0 (2011-03-28)
>    Makefile: Check for bison and flex

Looks good, please commit and update wiki/Devices accordingly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
