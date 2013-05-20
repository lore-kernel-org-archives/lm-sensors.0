From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 May 2013 13:26:41 +0000
Subject: Re: [lm-sensors] sensors-detect:: Drop detection of DS1621-like chips
Message-Id: <20130520132641.GA32402@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130520141525.59931252@endymion.delvare>
In-Reply-To: <20130520141525.59931252@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 20, 2013 at 02:15:25PM +0200, Jean Delvare wrote:
> Detection of the Dallas/Maxim DS1621, DS1625 and DS1631 chips is weak
> and likely to result in false positives. There's no rationale for
> keeping it in sensors-detect as these chips are not found in desktop
> computer systems. So drop detection of these chips altogether.
> ---

Good idea.

Guenter

>  prog/detect/sensors-detect |   46 ---------------------------------------------
>  1 file changed, 46 deletions(-)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2013-05-20 13:25:33.992641174 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2013-05-20 14:11:21.668063379 +0200
> @@ -803,11 +803,6 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x2c..0x2f],
>  		i2c_detect => sub { adm9240_detect(@_, 0); },
>  	}, {
> -		name => "Dallas Semiconductor DS1621/DS1631",
> -		driver => "ds1621",
> -		i2c_addrs => [0x48..0x4f],
> -		i2c_detect => sub { ds1621_detect(@_); },
> -	}, {
>  		name => "Dallas Semiconductor DS1780",
>  		driver => "adm9240",
>  		i2c_addrs => [0x2c..0x2f],
> @@ -4357,47 +4352,6 @@ sub lm92_detect
>  	return ($chip = 0) ? 4 : 2;
>  }
>  
> -# Registers used:
> -#   0xAA: Temperature
> -#   0xA1: High limit
> -#   0xA2: Low limit
> -#   0xA8: Counter
> -#   0xA9: Slope
> -#   0xAC: Configuration
> -# Detection is weak. We check if bit 4 (NVB) is clear, because it is
> -# unlikely to be set (would mean that EEPROM is currently being accessed).
> -# We also check the value of the counter and slope registers, the datasheet
> -# doesn't mention the possible values but the conversion formula together
> -# with experimental evidence suggest possible sanity checks.
> -# Not all devices enjoy SMBus read word transactions, so we do as much as
> -# possible with read byte transactions first, and only use read word
> -# transactions second.
> -sub ds1621_detect
> -{
> -	my ($file, $addr) = @_;
> -
> -	my $conf = i2c_smbus_read_byte_data($file, 0xAC);
> -	return if ($conf & 0x10);
> -
> -	my $temp = i2c_smbus_read_word_data($file, 0xAA);
> -	return if $temp < 0 || ($temp & 0x0f00);
> -	# On the DS1631, the following two checks are too strict in theory,
> -	# but in practice I very much doubt that anyone will set temperature
> -	# limits not a multiple of 0.5 degrees C.
> -	my $high = i2c_smbus_read_word_data($file, 0xA1);
> -	return if $high < 0 || ($high & 0x7f00);
> -	my $low = i2c_smbus_read_word_data($file, 0xA2);
> -	return if $low < 0 || ($low & 0x7f00);
> -
> -	return if ($temp = 0 && $high = 0 && $low = 0 && $conf = 0);
> -
> -	# Old versions of the DS1621 apparently don't have the counter and
> -	# slope registers (or they return crap)
> -	my $counter = i2c_smbus_read_byte_data($file, 0xA8);
> -	my $slope = i2c_smbus_read_byte_data($file, 0xA9);
> -	return ($slope = 0x10 && $counter <= $slope) ? 3 : 2;
> -}
> -
>  # Chip to detect: 0 = LM80, 1 = LM96080
>  # Registers used:
>  #   0x00: Configuration register
> 
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
