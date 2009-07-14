From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 14 Jul 2009 20:19:22 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add TMP42x chip detection
Message-Id: <20090714201922.GC4482@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090712193403.GA4444@ubuntu>
In-Reply-To: <20090712193403.GA4444@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 14, 2009 at 07:47:00PM +0200, Jean Delvare wrote:
> On Tue, 14 Jul 2009 19:11:32 +0200, Andre Prendel wrote:
> > Below you can find an updated patch with the comment for addresses not
> > probed. Further I've adjusted the address range for TMP422 and
> > TMP423. TMP422 only supports 0x4c-0x4f and TMP423 0x4c, 0x4d.
> > ---
> 
> Ah, yeah, good catch. BTW this could be used to improve detection
> reliability in the tmp421 driver.
> 
> > 
> > Index: sensors/prog/detect/sensors-detect
> > =================================> > --- sensors.orig/prog/detect/sensors-detect	2009-07-10 22:15:41.000000000 +0200
> > +++ sensors/prog/detect/sensors-detect	2009-07-14 18:34:05.000000000 +0200
> > @@ -908,6 +908,21 @@
> >  		i2c_addrs => [0x4c..0x4e],
> >  		i2c_detect => sub { lm90_detect(@_, 10); },
> >  	}, {
> > +		name => "Texas Instruments TMP421",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x2a, 0x4c..0x4f], # 0x1c-0x1f not probed.
> > +		i2c_detect => sub { tmp42x_detect(@_, 0); },
> > +	}, {
> > +		name => "Texas Instruments TMP422",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x4c..0x4f],
> > +		i2c_detect => sub { tmp42x_detect(@_, 1); },
> > +	}, {
> > +		name => "Texas Instruments TMP423",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x4c, 0x4d],
> > +		i2c_detect => sub { tmp42x_detect(@_, 2); },
> > +	}, {
> >  		name => "National Semiconductor LM95231",
> >  		driver => "to-be-written",
> >  		i2c_addrs => [0x2b, 0x19, 0x2a],
> > @@ -3907,6 +3922,25 @@
> >  }
> >  
> >  # Registers used:
> 
> Please add a reminder about the values of $chip, as other detect
> functions do.
> 
> > +#   0xfe: Manufactorer ID
> > +#   0xff: Device ID
> > +sub tmp42x_detect()
> > +{
> > +	my ($file, $addr, $chip) = @_;
> > +
> > +	my $mid = i2c_smbus_read_byte_data($file, 0xfe);
> > +	my $cid = i2c_smbus_read_byte_data($file, 0xff);
> > +
> > +	return if ($mid != 0x55);
> > +
> > +	return 6 if ($chip = 0 && $cid = 0x21); # TMP421
> > +	return 6 if ($chip = 1 && $cid = 0x22); # TMP422
> > +	return 6 if ($chip = 2 && $cid = 0x23); # TMP423
> > +
> > +	return;
> > +}
> > +
> > +# Registers used:
> >  #   0x03: Configuration (no low nibble, returns the previous low nibble)
> >  #   0x04: Conversion rate
> >  #   0xfe: Manufacturer ID
> 
> Other than that, looks good, please apply.

Done.

Thanks,
Andre

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
