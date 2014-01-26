From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 26 Jan 2014 13:22:14 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of TI ADC128D818
Message-Id: <20140126142214.24dfee79@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 25 Jan 2014 16:13:51 -0800, Guenter Roeck wrote:
> On 01/25/2014 02:05 PM, Jean Delvare wrote:
> > On Sat, 25 Jan 2014 09:54:51 -0800, Guenter Roeck wrote:
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   CHANGES                    |    3 +++
> >>   prog/detect/sensors-detect |   26 +++++++++++++++++++++-----
> >>   2 files changed, 24 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/CHANGES b/CHANGES
> >> index e1347a6..970dd67 100644
> >> --- a/CHANGES
> >> +++ b/CHANGES
> >> @@ -1,6 +1,9 @@
> >>   lm-sensors CHANGES file
> >>   -----------------------
> >>
> >> +SVN HEAD
> >> +  sensors-detect: Add detection of ADC128D818
> >> +
> >>   3.3.5 "Happy Birthday Beddy" (2014-01-22)
> >>     libsensors: Improve documentation of two functions
> >>                 Increase MAX_SENSORS_PER_TYPE to 33
> >> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> >> index a2093f3..2136b76 100755
> >> --- a/prog/detect/sensors-detect
> >> +++ b/prog/detect/sensors-detect
> >> @@ -547,6 +547,11 @@ use vars qw(@i2c_adapter_names);
> >>   		i2c_addrs => [0x28..0x2f],
> >>   		i2c_detect => sub { lm80_detect(@_, 1); },
> >>   	}, {
> >> +		name => "TI / National Semiconductor ADC128D818",
> >> +		driver => "adc128d818",
> >> +		i2c_addrs => [0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f, 0x35, 0x36, 0x37],
> >> +		i2c_detect => sub { lm80_detect(@_, 2); },
> >
> > How does this relate to the LM80?
> >
> > Is this chip really something people will need sensors-detect for (i.e.
> > it is found in PC-like computers) or something which will be always
> > declared in DT-like declarations anyway?
>
> No idea, really. I was asked by someone from TI to write a driver some time ago,
> and finally found the time to actually do it. I recall they had a request
> from a customer, but I did not ask for the use case.
> 
> The chip is a close relative to LM80 and LM96080. Register addresses are
> almost the same, but the sensor registers are 16 bit wide instead of 8,
> and there are no fan registers. I didn't use the lm80 driver because of
> the 16 bit registers, but decided to write a new one.

Then I suggest using a different detect function in sensors-detect.
There isn't enough in common with detect_lm80 to reuse it, and having a
1:1 mapping between sensors-detect functions and drivers has advantages.

> > I'm asking because I am worried about the address list. I'm fine with
> > 0x1d..0x1f and 0x2d..0x2f (you can declare them that way in perl BTW,
> > it's more compact) but addresses 0x35..0x37 we don't currently scan.
> > Adding a new address to the scan list is always a risk, as you may start
> > probing a whole new class of devices and the effects can be very bad.
> >
> > Actually we used to scan address 0x37 until r3233 / 2006-01-16. Commit
> > message was:
> >
> > "Lower the confidence of ITE overclocking chips. Do not scan
> > address 0x37 for these chips, as it may cause problem with some
> > eeproms."
> >
> > Addresses 0x35 and 0x36 I don't think we ever scanned, but EEPROMs can
> > reply to these as well so I'd rather not add them.
>
> Ok with me to take out those three addresses ... or drop the entire detection
> if you think it isn't worth it.

I am fine with the detection function. Please just drop the 3 addresses
in the 0x30-0x37 range.

> Question is what I should do in the driver. Any thoughts on that ?
> For my part I am fine with dropping the detect function entirely from it;
> I suspect you are right and it will mostly be used from DT type systems,
> and from what you said it sounds a bit risky to scan the 0x35..0x37
> address range.

You can keep the detect function in the driver as long as you remove
the 0x35..0x37 addresses from the scan list. Just document it properly
and that should be fine.

About the code itself:

> @@ -4436,11 +4441,13 @@ sub lm92_detect
>  # Chip to detect: 0 = LM80, 1 = LM96080
>  # Registers used:
>  #   0x00: Configuration register
> -#   0x02: Interrupt state register
> -#   0x07: Converstion rate register (LM96080 only)
> +#   0x02: Interrupt state register (LM80, LM96080 only)
> +#   0x07: Converstion rate register (LM96080, ADC128D818 only)
> +#   0x08: Oneshot register (ADC128D818 only)
> +#   0x09: Shutdown register (ADC128D818 only)

The datasheet I have states that 0x09 is the One-Shot register and 0x0a
is the Deep Shutdown register.

>  #   0x2a-0x3d: Limits registers (LM80 only)
> -#   0x3e: Manufacturer's ID register (LM96080 only)
> -#   0x3f: Stepping/die revision ID register (LM96080 only)
> +#   0x3e: Manufacturer's ID register (LM96080, ADC128D818 only)
> +#   0x3f: Stepping/die revision ID register (LM96080, ADC128D818 only)
>  # The LM80 is easily misdetected since it doesn't provide identification
>  # registers. So we have to use some tricks:
>  #   - 6-bit addressing, so limits readings modulo 0x40 should be unchanged
> @@ -4458,9 +4465,9 @@ sub lm80_detect
>  	my ($i, $reg);
>  
>  	return if (i2c_smbus_read_byte_data($file, 0x00) & 0x80) != 0;

For the ADC128D818 you can even mask with 0xf4, slightly improving the
reliability.

> -	return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
>  
>  	if ($chip = 0) {
> +		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
>  		for ($i = 0x2a; $i <= 0x3d; $i++) {
>  			$reg = i2c_smbus_read_byte_data($file, $i);
>  			return if i2c_smbus_read_byte_data($file, $i+0x40) != $reg;
> @@ -4493,11 +4500,20 @@ sub lm80_detect
>  		return unless $confidence > 0;
>  		return $confidence;
>  	} elsif ($chip = 1) {
> +		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
>  		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
>  		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
>  		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x08;
>  
>  		return 6;
> +	} elsif ($chip = 2) {
> +		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
> +		return if (i2c_smbus_read_byte_data($file, 0x08) & 0xfe) != 0;
> +		return if (i2c_smbus_read_byte_data($file, 0x09) & 0xfe) != 0;

You could also check register 0x0c, which as 6 unused bits.

> +		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
> +		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x09;
> +
> +		return 6;
>  	}
>  }
>  

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
