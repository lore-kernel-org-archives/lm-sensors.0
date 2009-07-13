From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 13 Jul 2009 11:44:35 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add TMP42x chip detection
Message-Id: <20090713114435.GA4439@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090712193403.GA4444@ubuntu>
In-Reply-To: <20090712193403.GA4444@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 13, 2009 at 10:53:54AM +0200, Jean Delvare wrote:
> Hi Andre,
> 
> On Sun, 12 Jul 2009 21:34:04 +0200, Andre Prendel wrote:
> > This patch adds detection for TI's TMP421, TMP422 and TMP423 chips to
> > sensors-detect. Only the manufactory ID and the device ID is used for
> > detection. I hope this is reliable enough.
> > ---
> > 
> >  sensors-detect |   34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > Index: sensors/prog/detect/sensors-detect
> > =================================> > --- sensors.orig/prog/detect/sensors-detect	2009-07-10 22:15:41.000000000 +0200
> > +++ sensors/prog/detect/sensors-detect	2009-07-12 19:26:14.000000000 +0200
> > @@ -908,6 +908,21 @@
> >  		i2c_addrs => [0x4c..0x4e],
> >  		i2c_detect => sub { lm90_detect(@_, 10); },
> >  	}, {
> > +		name => "Texas Instruments TMP421",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x2a, 0x4c..0x4f],
> 
> Maybe you can add a comment about the other addresses supported by the
> chip but not probed?

Ok, will do that. What's actually the reason why we dont probe all addresses?
Why is it unsafe and what can happen probing an unsafe address?

> > +		i2c_detect => sub { tmp42x_detect(@_, 0); },
> > +	}, {
> > +		name => "Texas Instruments TMP422",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x2a, 0x4c..0x4f],
> > +		i2c_detect => sub { tmp42x_detect(@_, 1); },
> > +	}, {
> > +		name => "Texas Instruments TMP423",
> > +		driver => "tmp421",
> > +		i2c_addrs => [0x2a, 0x4c..0x4f],
> > +		i2c_detect => sub { tmp42x_detect(@_, 2); },
> > +	}, {
> >  		name => "National Semiconductor LM95231",
> >  		driver => "to-be-written",
> >  		i2c_addrs => [0x2b, 0x19, 0x2a],
> > @@ -3907,6 +3922,25 @@
> >  }
> >  
> >  # Registers used:
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
> Other than that it looks OK, please apply.

Thanks,
Andre

> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
