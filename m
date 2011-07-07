From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 14:21:10 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add support for
Message-Id: <20110707142110.GC11007@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110707121403.6c0cf59b@endymion.delvare>
In-Reply-To: <20110707121403.6c0cf59b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 07, 2011 at 06:14:03AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Again, sorry for the late review.
> 
> On Sun, 26 Jun 2011 13:38:36 -0700, Guenter Roeck wrote:
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5980)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -1055,6 +1055,11 @@
> >  		i2c_addrs => [0x4c..0x4d],
> >  		i2c_detect => sub { lm90_detect(@_, 13); },
> >  	}, {
> > +		name => "NXP/Philips SA56004",
> > +		driver => "lm90",
> > +		i2c_addrs => [0x48..0x4f],
> > +		i2c_detect => sub { lm90_detect(@_, 14); },
> > +	}, {
> >  		name => "Analog Devices ADT7481",
> >  		driver => "to-be-written",
> >  		i2c_addrs => [0x4c, 0x4b],
> > @@ -4352,7 +4357,7 @@
> >  #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
> >  #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
> >  #		  11 = W83L771AWG/ASG, 12 = MAX6690,
> > -#		  13 = ADT7461A/NCT1008
> > +#		  13 = ADT7461A/NCT1008, 14 = SA56004
> >  # Registers used:
> >  #   0x03: Configuration
> >  #   0x04: Conversion rate
> > @@ -4457,6 +4462,12 @@
> >  		return if $mid != 0x41;		# Analog Devices
> >  		return 8 if $cid = 0x57;	# ADT7461A, NCT1008
> >  	}
> > +	if ($chip = 14) {
> > +		return if ($conf & 0x2a) != 0;
> > +		return if $rate > 0x09;
> > +		return if $mid != 0xa1;		# NXP Semiconductor/Philips
> > +		return 8 if $cid = 0x00;	# SA56004
> 
> A device ID of 0, unfortunately, is very fragile and thus certainly
> doesn't deserve a confidence value of 8. 6, tops. It would also make
> sense to check the unused bits in register 0xbf (Alert Mode / $conf2)
> for this device, to make the detection somewhat more reliable, as we do
> for many other LM90-compatible chips.
> 
Ok, I'll change that. Guess we should make the same change in the driver.

> > +	}
> >  	return;
> >  }
> >  
> > Index: CHANGES
> > =================================> > --- CHANGES	(revision 5980)
> > +++ CHANGES	(working copy)
> > @@ -15,6 +15,7 @@
> >                    Add detection of SMSC EMC2300
> >                    Add detection of MAX6642
> >                    Add detection of ITE IT8772E
> > +                  Add detection of SE56004
> 
> You mean SA.
> 
Oops, obviously ...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
