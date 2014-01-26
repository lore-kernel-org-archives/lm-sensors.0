From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 26 Jan 2014 18:55:10 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of TI ADC128D818
Message-Id: <20140126195510.433c1307@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 26 Jan 2014 10:33:31 -0800, Guenter Roeck wrote:
> On 01/26/2014 05:22 AM, Jean Delvare wrote:
> > About the code itself:
> >
> >> @@ -4436,11 +4441,13 @@ sub lm92_detect
> >>   # Chip to detect: 0 = LM80, 1 = LM96080
> >>   # Registers used:
> >>   #   0x00: Configuration register
> >> -#   0x02: Interrupt state register
> >> -#   0x07: Converstion rate register (LM96080 only)
> >> +#   0x02: Interrupt state register (LM80, LM96080 only)
> >> +#   0x07: Converstion rate register (LM96080, ADC128D818 only)
> >> +#   0x08: Oneshot register (ADC128D818 only)
> >> +#   0x09: Shutdown register (ADC128D818 only)
> >
> > The datasheet I have states that 0x09 is the One-Shot register and 0x0a
> > is the Deep Shutdown register.
> >
> Funny, in the driver I got that right :-)
> 
> >>   #   0x2a-0x3d: Limits registers (LM80 only)
> >> -#   0x3e: Manufacturer's ID register (LM96080 only)
> >> -#   0x3f: Stepping/die revision ID register (LM96080 only)
> >> +#   0x3e: Manufacturer's ID register (LM96080, ADC128D818 only)
> >> +#   0x3f: Stepping/die revision ID register (LM96080, ADC128D818 only)
> >>   # The LM80 is easily misdetected since it doesn't provide identification
> >>   # registers. So we have to use some tricks:
> >>   #   - 6-bit addressing, so limits readings modulo 0x40 should be unchanged
> >> @@ -4458,9 +4465,9 @@ sub lm80_detect
> >>   	my ($i, $reg);
> >>
> >>   	return if (i2c_smbus_read_byte_data($file, 0x00) & 0x80) != 0;
> >
> > For the ADC128D818 you can even mask with 0xf4, slightly improving the
> > reliability.
> >
> Ok.
> 
> >> -	return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
> >>
> >>   	if ($chip = 0) {
> >> +		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
> >>   		for ($i = 0x2a; $i <= 0x3d; $i++) {
> >>   			$reg = i2c_smbus_read_byte_data($file, $i);
> >>   			return if i2c_smbus_read_byte_data($file, $i+0x40) != $reg;
> >> @@ -4493,11 +4500,20 @@ sub lm80_detect
> >>   		return unless $confidence > 0;
> >>   		return $confidence;
> >>   	} elsif ($chip = 1) {
> >> +		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
> >>   		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
> >>   		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
> >>   		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x08;
> >>
> >>   		return 6;
> >> +	} elsif ($chip = 2) {
> >> +		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
> >> +		return if (i2c_smbus_read_byte_data($file, 0x08) & 0xfe) != 0;
> >> +		return if (i2c_smbus_read_byte_data($file, 0x09) & 0xfe) != 0;
> >
> > You could also check register 0x0c, which as 6 unused bits.
> >
> As well as 0x0b.
> 
> >> +		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
> >> +		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x09;
> >> +
> >> +		return 6;
> 
> If I do all that, is that worth a higher rating ?

It could be a 7, yes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
