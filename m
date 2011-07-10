From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jul 2011 19:20:06 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add code to detect
Message-Id: <20110710192006.GA13276@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110122171437.GA21444@ericsson.com>
In-Reply-To: <20110122171437.GA21444@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 10, 2011 at 02:26:10PM -0400, Jean Delvare wrote:
> On Sun, 10 Jul 2011 09:28:24 -0700, Guenter Roeck wrote:
> > v2: Fixed per review feedback. Tested code with LM95231 and LM95245.
> > 
> > ---
> > 
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5983)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -1008,6 +1008,11 @@
> >  		i2c_addrs => [0x2b, 0x19, 0x2a],
> >  		i2c_detect => sub { lm95231_detect(@_, 1); },
> >  	}, {
> > +		name => "National Semiconductor LM95245",
> > +		driver => "lm95245",
> > +		i2c_addrs => [0x18, 0x19, 0x29, 0x4c, 0x4d],
> > +		i2c_detect => sub { lm95231_detect(@_, 2); },
> > +	}, {
> >  		name => "National Semiconductor LM63",
> >  		driver => "lm63",
> >  		i2c_addrs => [0x4c],
> > @@ -4540,12 +4545,14 @@
> >  	return 5;
> >  }
> >  
> > -# Chip to detect: 0 = LM95231, 1 = LM95241
> > +# Chip to detect: 0 = LM95231, 1 = LM95241, 2 = LM95245
> >  # Registers used:
> >  #   0x02: Status (3 unused bits)
> >  #   0x03: Configuration (3 unused bits)
> > -#   0x06: Remote diode filter control (6 unused bits)
> > -#   0x30: Remote diode model type select (6 unused bits)
> > +#   0x06: Remote diode filter control (6 unused bits, LM95231 and LM95241)
> > +#   0x30: Remote diode model type select (6 unused bits, LM95231 and LM95241)
> > +#   0x30: Local Temperature LSB (5 unused bits, LM95245)
> > +#   0x33: Status register 2 (6 unused bits, LM95245)
> >  #   0xfe: Manufacturer ID
> >  #   0xff: Revision ID
> >  sub lm95231_detect
> > @@ -4555,13 +4562,21 @@
> >  	my $cid = i2c_smbus_read_byte_data($file, 0xff);
> >  
> >  	return if $mid != 0x01;				# National Semiconductor
> > -	return if $chip = 0 && $cid != 0xa1;		# LM95231
> > -	return if $chip = 1 && $cid != 0xa4;		# LM95241
> >  
> > -	return if i2c_smbus_read_byte_data($file, 0x02) & 0x70;
> > -	return if i2c_smbus_read_byte_data($file, 0x03) & 0x89;
> > -	return if i2c_smbus_read_byte_data($file, 0x06) & 0xfa;
> > -	return if i2c_smbus_read_byte_data($file, 0x30) & 0xfa;
> > +	if ($chip = 0 || $chip = 1) {
> > +		return if $chip = 0 && $cid != 0xa1;	# LM95231
> > +		return if $chip = 1 && $cid != 0xa4;	# LM95241
> > +		return if i2c_smbus_read_byte_data($file, 0x02) & 0x70;
> > +		return if i2c_smbus_read_byte_data($file, 0x03) & 0x89;
> > +		return if i2c_smbus_read_byte_data($file, 0x06) & 0xfa;
> > +		return if i2c_smbus_read_byte_data($file, 0x30) & 0xfa;
> > +	} elsif ($chip = 2) {
> > +		return if $cid != 0xb3;			# LM95245
> > +		return if i2c_smbus_read_byte_data($file, 0x02) & 0x68;
> > +		return if i2c_smbus_read_byte_data($file, 0x03) & 0xa1;
> > +		return if i2c_smbus_read_byte_data($file, 0x30) & 0x1a;
> 
> Rather "& 0x1f", no?
> 
Yes ...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
