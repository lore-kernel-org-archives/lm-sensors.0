From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Mar 2013 13:12:24 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] sensors-detect: Add detection of TMP431 and TMP432
Message-Id: <20130317141224.0e56c134@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Mar 2013 11:30:53 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |    1 +
>  prog/detect/sensors-detect |   24 +++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 51ac3c8..ba6409f 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -12,6 +12,7 @@ SVN HEAD
>                    Add detection of IT8752F
>                    Add detection of MCP98244
>                    Add detection of LM95234
> +                  Add detection of TMP431/TMP432
>  
>  3.3.3 "Happy Birthday Sophie" (2012-11-06)
>    documentation: Update fan-divisors, fan divisors are optional
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index f238802..00e3904 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -1023,6 +1023,16 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x4c, 0x4d],
>  		i2c_detect => sub { tmp42x_detect(@_, 2); },
>  	}, {
> +		name => "Texas Instruments TMP431",
> +		driver => "to-be-written",		# tmp401
> +		i2c_addrs => [0x4c, 0x4d],
> +		i2c_detect => sub { lm90_detect(@_, 16); },
> +	}, {
> +		name => "Texas Instruments TMP432",
> +		driver => "to-be-written",		# tmp401
> +		i2c_addrs => [0x4c, 0x4d],
> +		i2c_detect => sub { lm90_detect(@_, 17); },
> +	}, {
>  		name => "Texas Instruments AMC6821",
>  		driver => "amc6821",
>  		i2c_addrs => [0x18..0x1a, 0x2c..0x2e, 0x4c..0x4e],
> @@ -4537,7 +4547,7 @@ sub max6680_95_detect
>  #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
>  #		  11 = W83L771AWG/ASG, 12 = MAX6690,
>  #		  13 = ADT7461A/NCT1008, 14 = SA56004,
> -#		  15 = G781
> +#		  15 = G781, 16 = TMP431, 17 = TMP432
>  # Registers used:
>  #   0x03: Configuration
>  #   0x04: Conversion rate
> @@ -4655,6 +4665,18 @@ sub lm90_detect
>  		return if $mid != 0x47;		# GMT
>  		return 8 if $cid = 0x01;	# G781
>  	}
> +	if ($chip = 16) {
> +		return if ($conf & 0x1B) != 0;
> +		return if $rate > 0x0F;
> +		return if $mid != 0x55;		# Texas Instruments
> +		return 6 if ($cid = 0x31);	# TMP431A/B/C/D
> +	}
> +	if ($chip = 17) {
> +		return if ($conf & 0x1B) != 0;
> +		return if $rate > 0x0F;
> +		return if $mid != 0x55;		# Texas Instruments
> +		return 6 if ($cid = 0x32);	# TMP432A/B
> +	}
>  	return;
>  }
>  

Looks good, please commit.

BTW, please use ISO8601 date format in wiki/Devices. MM/DD/YYYY as you
used is potentially ambiguous.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
