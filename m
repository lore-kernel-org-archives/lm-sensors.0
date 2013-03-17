From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Mar 2013 13:03:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] sensors-detect: Add detection of LM95234
Message-Id: <20130317140326.7dd90fcd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359434448-21181-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359434448-21181-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Mar 2013 11:30:52 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |    1 +
>  prog/detect/sensors-detect |   17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 72b7bfd..51ac3c8 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -11,6 +11,7 @@ SVN HEAD
>                    Stay alive when /dev/port is missing
>                    Add detection of IT8752F
>                    Add detection of MCP98244
> +                  Add detection of LM95234
>  
>  3.3.3 "Happy Birthday Sophie" (2012-11-06)
>    documentation: Update fan-divisors, fan divisors are optional
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index 2e6c4ef..f238802 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -1033,6 +1033,11 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x2b, 0x19, 0x2a],
>  		i2c_detect => sub { lm95231_detect(@_, 0); },
>  	}, {
> +		name => "National Semiconductor LM95234",
> +		driver => "to-be-written",		# lm95234
> +		i2c_addrs => [0x18, 0x4d, 0x4e],
> +		i2c_detect => sub { lm95231_detect(@_, 3); },
> +	}, {
>  		name => "National Semiconductor LM95241",
>  		driver => "lm95241",
>  		i2c_addrs => [0x2b, 0x19, 0x2a],
> @@ -4721,14 +4726,17 @@ sub max6657_detect
>  	return 5;
>  }
>  
> -# Chip to detect: 0 = LM95231, 1 = LM95241, 2 = LM95245
> +# Chip to detect: 0 = LM95231, 1 = LM95241, 2 = LM95245, 3 = LM95234
>  # Registers used:
>  #   0x02: Status (3 unused bits)
>  #   0x03: Configuration (3 unused bits)
> +#   0x04: Conversion rate (6 unused bits, LM95234)
>  #   0x06: Remote diode filter control (6 unused bits, LM95231 and LM95241)
>  #   0x30: Remote diode model type select (6 unused bits, LM95231 and LM95241)
>  #   0x30: Local Temperature LSB (5 unused bits, LM95245)
> +#   0x30: Diode model (4 unused bits, LM95234)
>  #   0x33: Status register 2 (6 unused bits, LM95245)
> +#   0x38: Diode model status (4 unused bits, LM95234)
>  #   0xfe: Manufacturer ID
>  #   0xff: Revision ID
>  sub lm95231_detect
> @@ -4752,6 +4760,13 @@ sub lm95231_detect
>  		return if i2c_smbus_read_byte_data($file, 0x03) & 0xa1;
>  		return if i2c_smbus_read_byte_data($file, 0x30) & 0x1f;
>  		return if i2c_smbus_read_byte_data($file, 0x33) & 0x3f;
> +	} elsif ($chip = 3) {
> +		return if $cid != 0x79;			# LM95234
> +		return if i2c_smbus_read_byte_data($file, 0x02) & 0x30;
> +		return if i2c_smbus_read_byte_data($file, 0x03) & 0xbc;
> +		return if i2c_smbus_read_byte_data($file, 0x04) & 0xfc;
> +		return if i2c_smbus_read_byte_data($file, 0x30) & 0xe1;
> +		return if i2c_smbus_read_byte_data($file, 0x38) & 0xe1;
>  	}
>  
>  	return 6;

Looks good, please commit and update wiki/Devices accordingly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
