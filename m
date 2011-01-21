From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 Jan 2011 17:06:01 +0000
Subject: Re: [lm-sensors] lm-sensors: Add detection of MAX6639
Message-Id: <20110121180601.5d80b1ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110121165822.GA13021@ericsson.com>
In-Reply-To: <20110121165822.GA13021@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 21 Jan 2011 08:58:22 -0800, Guenter Roeck wrote:
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5906)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -828,6 +828,11 @@
>  		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
>  		i2c_detect => sub { max1668_detect(@_, 2); },
>  	}, {
> +		name => "Maxim MAX6639",
> +		driver => "max6639",
> +		i2c_addrs => [0x2c, 0x2e, 0x2f],
> +		i2c_detect => sub { max6639_detect(@_); },
> +	}, {
>  		name => "Maxim MAX6650/MAX6651",
>  		driver => "max6650",
>  		i2c_addrs => [0x1b, 0x1f, 0x48, 0x4b],
> @@ -5446,6 +5451,27 @@
>  	return @res;
>  }
>  
> +# Chip to detect: MAX6639
> +# Registers used:
> +#   0x3d: Device ID
> +#   0x3e: Manufacturer ID
> +#   0x3f: Chip revision
> +sub max6639_detect
> +{
> +	my ($file, $addr) = @_;
> +	my ($man_id, $dev_id, $rev);
> +
> +	$dev_id = i2c_smbus_read_byte_data($file, 0x3d);
> +	$man_id = i2c_smbus_read_byte_data($file, 0x3e);
> +	$rev = i2c_smbus_read_byte_data($file, 0x3f);
> +	
> +	return unless $man_id = 0x4d;	# Maxim
> +	return unless $dev_id = 0x58;	# MAX6639
> +	return unless $rev = 0x00;
> +
> +	return 6;
> +}
> +
>  # The max6650 has no device ID register. However, a few registers have
>  # spare bits, which are documented as being always zero on read. We read
>  # all of these registers check the spare bits. Any non-zero means this
> Index: CHANGES
> =================================> --- CHANGES	(revision 5906)
> +++ CHANGES	(working copy)
> @@ -19,6 +19,7 @@
>                    Add detection of the National Semiconductor LM94
>                    Add detection of the ITE IT8728F
>                    Implement universal detection for coretemp (#2381)
> +                  Add detection of Maxim MAX6639
>  
>  3.2.0 (2010-10-10)
>    libsensors: Increase MAX_SENSORS_PER_TYPE to 24
> 

Looks good, feel free to commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
