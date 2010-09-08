From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Sep 2010 19:39:35 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add support for max6695/96
Message-Id: <1283974775.7046.14.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100706222437.GA31051@ericsson.com>
In-Reply-To: <20100706222437.GA31051@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, 2010-09-08 at 15:06 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 8 Sep 2010 08:35:00 -0700, Guenter Roeck wrote:
> > This patch adds support for max6695/96 to sensors-detect.
> > 
> > ---
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5857)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -921,8 +921,13 @@
> >  		name => "Maxim MAX6680/MAX6681",
> >  		driver => "lm90",
> >  		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> > -		i2c_detect => sub { lm90_detect(@_, 7); },
> > +		i2c_detect => sub { max6680_95_detect(@_, 0); },
> >  	}, {
> > +		name => "Maxim MAX6695/MAX6696",
> > +		driver => "lm90",
> > +		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
> > +		i2c_detect => sub { max6680_95_detect(@_, 1); },
> > +	}, {
> >  		name => "Winbond W83L771W/G",
> >  		driver => "to-be-written",
> >  		i2c_addrs => [0x4c],
> > @@ -4051,10 +4056,46 @@
> >  	return $confidence;
> >  }
> >  
> > +# Chip to detect: 0 = MAX6680/81, 1 = MAX6695/96
> > +# Registers used:
> > +#   0x03: Configuration
> > +#   0x04: Conversion rate
> > +#   0x12: Status2
> > +#   0x16: Overtemperature 2
> > +#   0xfe: Manufacturer ID
> > +#   0xff: Chip ID / die revision
> > +sub max6680_95_detect
> > +{
> > +	my ($file, $addr, $chip) = @_;
> > +	my $mid = i2c_smbus_read_byte_data($file, 0xfe);
> > +	my $cid = i2c_smbus_read_byte_data($file, 0xff);
> > +	my $conf = i2c_smbus_read_byte_data($file, 0x03);
> > +	my $rate = i2c_smbus_read_byte_data($file, 0x04);
> > +	my $emerg = i2c_smbus_read_byte_data($file, 0x16);
> > +	my $status2 = i2c_smbus_read_byte_data($file, 0x12);
> > +
> > +	if ($chip = 0) {
> > +		return if ($conf & 0x03) != 0;
> > +		return if $rate > 0x07;
> > +		return if $emerg != $rate;
> 
> Please take a look at max6657_detect(). Obviously you assume that the
> SMBus read commands above were executed in a specific order, which
> isn't actually guaranteed, because sensors-detect has a register cache
> to speed up detection. You really want to pass NO_CACHE as a third
> parameter if you want to by-pass the cache and thus ensure that the
> read order is as desired.
> 
Yes, I completely missed that.

> Also, as discussed before, comparing $emerg and $rate is likely to work
> in most cases, but isn't 100% reliable. You might want to consider the
> following sequence instead:
> 
> 	my $mid = i2c_smbus_read_byte_data($file, 0xfe, NO_CACHE);
> 	my $emerg1 = i2c_smbus_read_byte_data($file, 0x16, NO_CACHE);
> 	my $rate = i2c_smbus_read_byte_data($file, 0x04, NO_CACHE);
> 	my $emerg2 = i2c_smbus_read_byte_data($file, 0x16, NO_CACHE);
> 
> 	if ($emerg1 != $emerg2)
> 		# MAX6680/MAX6681
> 	else
> 		# MAX6695/MAX6696
> 
> This is guaranteed to work because $mid and $rate can't have the same
> value.

Excellent idea. I'll try that.

> 
> 
> > +		return if $mid != 0x4d;		# Maxim
> > +		return 8 if $cid = 0x01;	# MAX6680/MAX6681
> > +	}
> > +	if ($chip = 1) {
> > +		return if ($conf & 0x10) != 0;
> > +		return if ($status2 & 0x01) != 0;
> > +		return if $rate > 0x07;
> > +		return if $emerg = $rate;
> > +		return if $mid != 0x4d;		# Maxim
> > +		return 8 if $cid = 0x01;	# MAX6695/MAX6696
> > +	}
> > +	return;
> > +}
> > +
> >  # Chip to detect: 0 = LM90, 1 = LM89/LM99, 2 = LM86, 3 = ADM1032,
> >  #		  4 = MAX6654, 5 = ADT7461,
> >  #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
> > -#		  7 = MAX6680/MAX6681, 8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
> > +#		  7 = unused, 8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
> >  #		  11 = W83L771AWG/ASG, 12 = MAX6690
> >  # Registers used:
> >  #   0x03: Configuration
> > @@ -4116,10 +4157,7 @@
> >  		return 8 if $cid = 0x59;	# MAX6648/MAX6692
> >  	}
> >  	if ($chip = 7) {
> > -		return if ($conf & 0x03) != 0;
> > -		return if $rate > 0x07;
> > -		return if $mid != 0x4d;		# Maxim
> > -		return 8 if $cid = 0x01;	# MAX6680/MAX6681
> > +		return;
> >  	}
> 
> Why not skip it altogether? And same for the comment above? These are
> arbitrary numbers, it's totally OK if they don't follow each other.
> 
Ok.

Guenter

> >  	if ($chip = 8) {
> >  		return if ($conf & 0x2a) != 0;
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
