From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 05 Dec 2014 09:43:07 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add code to detect TMP435
Message-Id: <20141205104307.3b4bed1b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110406072137.GB23562@ericsson.com>
In-Reply-To: <20110406072137.GB23562@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu,  4 Dec 2014 11:14:59 -0800, Guenter Roeck wrote:
> Also update driver support status for TMP431 and TMP432.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  1 +
>  prog/detect/sensors-detect | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 638a8bf..534b810 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -24,6 +24,7 @@ SVN HEAD
>                    Document support for EMC1402, EMC1404, and EMC1424
>                    Detect new revisions of EMC14xx
>                    Add detection of EMC1422
> +                  Add detection of TMP435
>  
>  3.3.5 "Happy Birthday Beddy" (2014-01-22)
>    libsensors: Improve documentation of two functions
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index 448cf22..d169fb9 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -1029,15 +1029,20 @@ use vars qw(@i2c_adapter_names);
>  		i2c_detect => sub { tmp42x_detect(@_, 2); },
>  	}, {
>  		name => "Texas Instruments TMP431",
> -		driver => "to-be-written",		# tmp401
> +		driver => "tmp401",
>  		i2c_addrs => [0x4c, 0x4d],
>  		i2c_detect => sub { lm90_detect(@_, 16); },
>  	}, {
>  		name => "Texas Instruments TMP432",
> -		driver => "to-be-written",		# tmp401
> +		driver => "tmp401",
>  		i2c_addrs => [0x4c, 0x4d],
>  		i2c_detect => sub { lm90_detect(@_, 17); },
>  	}, {
> +		name => "Texas Instruments TMP435",
> +		driver => "tmp401",
> +		i2c_addrs => [0x4c],
> +		i2c_detect => sub { lm90_detect(@_, 19); },
> +	}, {
>  		name => "Texas Instruments TMP441",
>  		driver => "tmp421",
>  		i2c_addrs => [0x1c..0x1f, 0x2a, 0x4c..0x4f],
> @@ -4674,7 +4679,8 @@ sub max6680_95_detect
>  #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
>  #		  11 = W83L771AWG/ASG, 12 = MAX6690,
>  #		  13 = ADT7461A/NCT1008, 14 = SA56004,
> -#		  15 = G781, 16 = TMP431, 17 = TMP432, 18 = TMP451
> +#		  15 = G781, 16 = TMP431, 17 = TMP432, 18 = TMP451,
> +#		  19 = TMP435
>  # Registers used:
>  #   0x03: Configuration
>  #   0x04: Conversion rate
> @@ -4810,6 +4816,12 @@ sub lm90_detect
>  		return if $mid != 0x55;		# Texas Instruments
>  		return 4 if ($cid = 0x00);	# TMP451
>  	}
> +	if ($chip = 19) {
> +		return if ($conf & 0x1B) != 0;

Would it make sense to also check configuration register 2 at 0x1a? It
has 5 unused bits. We do check configuration register 2 (but at a
different address) for other brands already.

> +		return if $rate > 0x0F;
> +		return if $mid != 0x55;		# Texas Instruments
> +		return 6 if ($cid = 0x35);	# TMP435
> +	}
>  	return;
>  }

Other than that, and the pending programmable address question, patch
looks good.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
