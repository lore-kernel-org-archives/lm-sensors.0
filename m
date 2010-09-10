From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Sep 2010 08:23:21 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add support for
Message-Id: <20100910102321.6781c7d5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 8 Sep 2010 13:03:57 -0700, Guenter Roeck wrote:
> This patch adds support for max6695/96 to sensors-detect.
> ---
> v2:
> Fix and improve max6680/81 vs. max6695/96 detection code
> Remove chip=7 code from lm90_detect
> 
> ---
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5857)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -921,8 +921,13 @@
>  		name => "Maxim MAX6680/MAX6681",
>  		driver => "lm90",
>  		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> -		i2c_detect => sub { lm90_detect(@_, 7); },
> +		i2c_detect => sub { max6680_95_detect(@_, 0); },
>  	}, {
> +		name => "Maxim MAX6695/MAX6696",
> +		driver => "lm90",
> +		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> +		i2c_detect => sub { max6680_95_detect(@_, 1); },
> +	}, {
>  		name => "Winbond W83L771W/G",
>  		driver => "to-be-written",
>  		i2c_addrs => [0x4c],
> @@ -4051,10 +4056,47 @@
>  	return $confidence;
>  }
>  
> +# Chip to detect: 0 = MAX6680/81, 1 = MAX6695/96
> +# Registers used:
> +#   0x03: Configuration
> +#   0x04: Conversion rate
> +#   0x12: Status2
> +#   0x16: Overtemperature 2
> +#   0xfe: Manufacturer ID
> +#   0xff: Chip ID / die revision
> +sub max6680_95_detect
> +{
> +	my ($file, $addr, $chip) = @_;
> +	my $cid = i2c_smbus_read_byte_data($file, 0xff);
> +	my $conf = i2c_smbus_read_byte_data($file, 0x03);
> +	my $mid = i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
> +	my $emerg = i2c_smbus_read_byte_data($file, 0x16, NO_CACHE);
> +	my $rate = i2c_smbus_read_byte_data($file, 0x04, NO_CACHE);
> +	my $emerg2 = i2c_smbus_read_byte_data($file, 0x16, NO_CACHE);
> +
> +	# Check common conditions
> +	return if $rate > 0x07;
> +	return if $mid != 0x4d;		# Not Maxim
> +	return if $cid != 0x01;		# None of the chips we are looking for
> +
> +	if ($chip = 0) {
> +		return if ($conf & 0x03) != 0;
> +		return 8 if $emerg != $emerg2;	# MAX6680/MAX6681
> +	}
> +	if ($chip = 1) {
> +		my $status2 = i2c_smbus_read_byte_data($file, 0x12);
> +
> +		return if ($conf & 0x10) != 0;
> +		return if ($status2 & 0x01) != 0;
> +		return 8 if $emerg = $emerg2;	# MAX6695/MAX6696
> +	}
> +	return;
> +}
> +
>  # Chip to detect: 0 = LM90, 1 = LM89/LM99, 2 = LM86, 3 = ADM1032,
>  #		  4 = MAX6654, 5 = ADT7461,
>  #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
> -#		  7 = MAX6680/MAX6681, 8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
> +#		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
>  #		  11 = W83L771AWG/ASG, 12 = MAX6690
>  # Registers used:
>  #   0x03: Configuration
> @@ -4115,12 +4157,6 @@
>  		return if $mid != 0x4d;		# Maxim
>  		return 8 if $cid = 0x59;	# MAX6648/MAX6692
>  	}
> -	if ($chip = 7) {
> -		return if ($conf & 0x03) != 0;
> -		return if $rate > 0x07;
> -		return if $mid != 0x4d;		# Maxim
> -		return 8 if $cid = 0x01;	# MAX6680/MAX6681
> -	}
>  	if ($chip = 8) {
>  		return if ($conf & 0x2a) != 0;
>  		return if $rate > 0x09;

Looks good, please commit!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
