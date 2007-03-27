From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2007 15:22:04 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] lm-sensors: add dme1737 support
Message-Id: <20070327172204.0a960e09.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
In-Reply-To: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 26 Mar 2007 17:46:49 -0700, Juerg Haefliger wrote:
> This patch fixes a bug in sensors-detect that prevents the SMSC
> DME1737 from being discovered. It also adds full support for the chip
> to libsensors and sensors.

> @@ -1791,9 +1793,17 @@ $chip_kern26_w83791d = {
>        {
>  	name => "SMSC DME1737 Super IO",
>  	# Hardware monitoring features are accessed on the SMBus
> -	driver => "not-a-sensor",
> +	driver => "via-smbus-only",
>  	devid => 0x78,
>        },
> +      {
> +	name => "SMSC DME1737 Super IO",
> +	# The DME1737 shows up twice in this list because it can return both

I think you mean "either", not "both". I doubt a given chip would
return two different values?

> +	# 0x78 or 0x77 as its device ID.
> +	# Hardware monitoring features are accessed on the SMBus
> +	driver => "via-smbus-only",
> +	devid => 0x77,
> +      },
>      ],
>    },
>    {

>  # Registers used:
>  #   0x3E: Manufacturer ID
>  #   0x3F: Version/Stepping
> -#   0x40: Configuration (2 reserved bits)
> -#   0x42: Interrupt Status 2 (1 reserved bit)
> -#   0x43: VID (2 reserved bits)
> +#   0x73: Read-only test register (4 test bits)
> +#   0x8A: Read-only test register (7 test bits)
>  sub dme1737_detect
>  {
>    my ($file, $addr) = @_;
> -  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x55
> +  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x5c
>             and (i2c_smbus_read_byte_data($file, 0x3F) & 0xF8) = 0x88
> -           and (i2c_smbus_read_byte_data($file, 0x40) & 0xC4) = 0x04
> -           and (i2c_smbus_read_byte_data($file, 0x42) & 0x02) = 0x00
> -           and (i2c_smbus_read_byte_data($file, 0x43) & 0xC0) = 0x00;
> +           and (i2c_smbus_read_byte_data($file, 0x73) & 0x0F) = 0x09
> +           and (i2c_smbus_read_byte_data($file, 0x8A) & 0x7F) = 0x4D;
>    return ($addr = 0x2e ? 6 : 5);
>  }

I'm fine with using register 0x8A, even though I don't think we ever
used a test register for identification purposes. But I am skeptical
about 0x73, it's essentially not documented in the datasheet I have,
but the only think they say is that it's read/write, that doesn't sound
right for identification purposes. Assuming that your datasheet is more
complete than mine, you'll know better, but please confirm it's really
that register you want to use. If not, I still think that register 0x40
is good for identification purposes.

Other than that, your patch looks good and I am willing to apply it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
