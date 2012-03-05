From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Mar 2012 17:00:32 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of ST Mircoelectronics STTS2002 and STTS3000
Message-Id: <20120305180032.1264c654@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 5 Mar 2012 08:32:28 -0800, Guenter Roeck wrote:
> On Mon, 2012-03-05 at 08:29 -0500, Jean Delvare wrote:
> > Add detection of ST Mircoelectronics STTS2002 and STTS3000.
> > 
> > ---
> >  prog/detect/sensors-detect |   24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > --- lm-sensors.orig/prog/detect/sensors-detect	2012-03-02 08:53:12.000000000 +0100
> > +++ lm-sensors/prog/detect/sensors-detect	2012-03-05 13:58:35.549784178 +0100
> > @@ -1350,6 +1350,16 @@ use vars qw(@i2c_adapter_names);
> >  		i2c_addrs => [0x18..0x1f],
> >  		i2c_detect => sub { jedec_JC42_4_detect(@_, 10); },
> >  	}, {
> > +		name => "ST STTS2002",
> > +		driver => "jc42",
> > +		i2c_addrs => [0x18..0x1f],
> > +		i2c_detect => sub { jedec_JC42_4_detect(@_, 11); },
> > +	}, {
> > +		name => "ST STTS3000",
> > +		driver => "jc42",
> > +		i2c_addrs => [0x18..0x1f],
> > +		i2c_detect => sub { jedec_JC42_4_detect(@_, 12); },
> > +	}, {
> >  		name => "NXP SE97/SE97B",
> >  		driver => "jc42",
> >  		i2c_addrs => [0x18..0x1f],
> > @@ -5965,7 +5975,7 @@ sub max6655_detect
> >  # Chip to detect: 0 = STTS424, 1 = SE97/SE97B, 2 = SE98, 3 = ADT7408,
> >  #                 4 = TS3000/TSE2002, 5 = MAX6604, 6 = MCP98242,
> >  #                 7 = MCP98243, 8 = MCP9843, 9 = CAT6095 / CAT34TS02,
> > -#                 10 = STTS424E
> > +#                 10 = STTS424E, 11 = STTS2002, 12 = STTS3000
> >  # Registers used:
> >  #   0x00: Capabilities
> >  #   0x01: Configuration
> > @@ -6022,6 +6032,12 @@ sub jedec_JC42_4_detect
> >  	} elsif ($chip = 10) {
> >  		return unless $manid = 0x10;		# STMicrolectronics
> >  		return unless $devid = 0x00;		# STTS424E02
> > +	} elsif ($chip = 11) {
> > +		return unless $manid = 0x10;		# STMicrolectronics
> > +		return unless $devid = 0x03;		# STTS2002
> > +	} elsif ($chip = 12) {
> > +		return unless $manid = 0x10;		# STMicrolectronics
> > +		return unless $devid = 0x02;		# STTS3000
> >  	}
> >  
> >  	# Now, do it all again with words. Note that we get
> > @@ -6067,6 +6083,12 @@ sub jedec_JC42_4_detect
> >  	} elsif ($chip = 10) {
> >  		return unless $manid = 0x4a10;		# STMicrolectronics
> >  		return unless ($devid & 0xfeff) = 0x0000; # STTS424E02
> > +	} elsif ($chip = 11) {
> > +		return unless $manid = 0x4a10;		# STMicrolectronics
> > +		return unless ($devid & 0xfeff) = 0x0003; # STTS2002
> > +	} elsif ($chip = 12) {
> > +		return unless $manid = 0x4a10;		# STMicrolectronics
> > +		return unless ($devid & 0xfeff) = 0x0002; # STTS3000
> >  	}
> 
> Hi Jean,
> 
> you are masking the chip IDs against 0xfeff. That made sense for
> STTS424E02, which has two variants. Any special reason for doing it for
> STTS2002 and STTS3000 as well ? If so, shouldn't we do the same for the
> jc42 driver (or, alternatively, not mask it here either for
> consistency) ?

We do mask for the STTS424 in sensors-detect too, while we don't in the
jc42 driver. I'm simply doing the same here for the STTS2002 and
STTS3000. It surprised me too at first, but then I though it made sense
to be slightly more permissive in sensors-detect, so that we can spot
and add new IDs as/if they show up.

But I am fine aligning sensors-detect and jc42 to match exactly if you
think it's preferable. Your call.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
