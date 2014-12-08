From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 08 Dec 2014 10:40:16 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add code to detect TMP435
Message-Id: <20141208114016.1b50eee7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110122171437.GA21444@ericsson.com>
In-Reply-To: <20110122171437.GA21444@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat,  6 Dec 2014 16:25:19 -0800, Guenter Roeck wrote:
> Also strengthen chip detection for other TMP4xx chips,
> and update driver support status for TMP431 and TMP432.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Detect TMP435 on its entire address range
>     Strengthen detect function for other TMP4xx chips
>
>  CHANGES                    |  1 +
>  prog/detect/sensors-detect | 42 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 34 insertions(+), 9 deletions(-)
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
> index 448cf22..55b3537 100755
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
> +		i2c_addrs => [0x37, 0x48..0x4f],
> +		i2c_detect => sub { lm90_detect(@_, 19); },
> +	}, {
>  		name => "Texas Instruments TMP441",
>  		driver => "tmp421",
>  		i2c_addrs => [0x1c..0x1f, 0x2a, 0x4c..0x4f],
> @@ -4674,11 +4679,13 @@ sub max6680_95_detect
>  #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
>  #		  11 = W83L771AWG/ASG, 12 = MAX6690,
>  #		  13 = ADT7461A/NCT1008, 14 = SA56004,
> -#		  15 = G781, 16 = TMP431, 17 = TMP432, 18 = TMP451
> +#		  15 = G781, 16 = TMP431, 17 = TMP432, 18 = TMP451,
> +#		  19 = TMP435
>  # Registers used:
>  #   0x03: Configuration
>  #   0x04: Conversion rate
>  #   0xbf: Configuration 2 (National Semiconductor, Winbond, and Philips only)
> +#   0x1a: Configuration 2 (TI only)
>  #   0xfe: Manufacturer ID
>  #   0xff: Chip ID / die revision
>  sub lm90_detect
> @@ -4688,7 +4695,13 @@ sub lm90_detect
>  	my $cid = i2c_smbus_read_byte_data($file, 0xff);
>  	my $conf = i2c_smbus_read_byte_data($file, 0x03);
>  	my $rate = i2c_smbus_read_byte_data($file, 0x04);
> -	my $conf2 = i2c_smbus_read_byte_data($file, 0xbf);
> +	my $conf2;
> +
> +	if ($chip = 9 || $chip = 10 || ($chip >= 16 && $chip <= 19)) {
> +		$conf2 = i2c_smbus_read_byte_data($file, 0x1a);
> +	} else {
> +		$conf2 = i2c_smbus_read_byte_data($file, 0xbf);
> +	}

The TMP431/TMP432 datasheet I have claims that Configuration Register 2
is at 0x3f for the TMP432 (surprisingly, I have to say.)

At this point I am wondering if it wouldn't make more sense to split
support for the TI chips to a separate function.

>  
>  	if ($chip = 0) {
>  		return if ($conf & 0x2a) != 0;
> @@ -4748,17 +4761,19 @@ sub lm90_detect
>  	}
>  	if ($chip = 9) {
>  		return if ($conf & 0x1B) != 0;
> +		return if ($conf2 & 0xfc) != 0x1c;
>  		return if $rate > 0x0F;
>  		return if $mid != 0x55;		# Texas Instruments
>  		return 8 if $cid = 0x11;	# TMP401
>  	}
>  	if ($chip = 10) {
>  		return if ($conf & 0x1B) != 0;
> +		return if ($conf2 & 0xfc) != 0x1c;
>  		return if $rate > 0x0F;
>  		return if $mid != 0x55;		# Texas Instruments
> -		return 6 if ($addr = 0x4c && $cid = 0x12); # TMP411A
> -		return 6 if ($addr = 0x4d && $cid = 0x13); # TMP411B
> -		return 6 if ($addr = 0x4e && $cid = 0x10); # TMP411C
> +		return 8 if ($addr = 0x4c && $cid = 0x12); # TMP411A
> +		return 8 if ($addr = 0x4d && $cid = 0x13); # TMP411B
> +		return 8 if ($addr = 0x4e && $cid = 0x10); # TMP411C
>  	}
>  	if ($chip = 11) {
>  		return if ($conf & 0x2a) != 0;
> @@ -4794,15 +4809,17 @@ sub lm90_detect
>  	}
>  	if ($chip = 16) {
>  		return if ($conf & 0x1B) != 0;
> +		return if ($conf2 & 0xe3) != 0;
>  		return if $rate > 0x0F;
>  		return if $mid != 0x55;		# Texas Instruments
> -		return 6 if ($cid = 0x31);	# TMP431A/B/C/D
> +		return 8 if ($cid = 0x31);	# TMP431A/B/C/D
>  	}
>  	if ($chip = 17) {
>  		return if ($conf & 0x1B) != 0;
> +		return if ($conf2 & 0xe3) != 0;

With the datasheet I have, the mask should be 0xC3 here.

>  		return if $rate > 0x0F;
>  		return if $mid != 0x55;		# Texas Instruments
> -		return 6 if ($cid = 0x32);	# TMP432A/B
> +		return 8 if ($cid = 0x32);	# TMP432A/B
>  	}
>  	if ($chip = 18) {
>  		return if ($conf & 0x1B) != 0;
> @@ -4810,6 +4827,13 @@ sub lm90_detect
>  		return if $mid != 0x55;		# Texas Instruments
>  		return 4 if ($cid = 0x00);	# TMP451
>  	}
> +	if ($chip = 19) {
> +		return if ($conf & 0x1B) != 0;
> +		return if ($conf2 & 0xe3) != 0;
> +		return if $rate > 0x0F;
> +		return if $mid != 0x55;		# Texas Instruments
> +		return 8 if ($cid = 0x35);	# TMP435
> +	}
>  	return;
>  }
>  


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
