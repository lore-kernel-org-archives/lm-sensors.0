From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Feb 2011 15:01:04 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add capability to
Message-Id: <20110209150104.GA18692@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208204952.GA15232@ericsson.com>
In-Reply-To: <20110208204952.GA15232@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Feb 09, 2011 at 08:02:55AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 8 Feb 2011 12:49:52 -0800, Guenter Roeck wrote:
> > This patch adds detection of EMC1002, EMC1033, EMC1046, EMC1047,
> > EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424 to sensors-detect.
> > 
> > --
> > v2:
> > - Updated CHANGES
> > - More detailed description
> > 
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5913)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -1195,16 +1195,36 @@
> >  		i2c_addrs => [0x2f],
> >  		i2c_detect => sub { fintek_detect(@_, 7); },
> >  	}, {
> > +		name => "SMSC EMC1002",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x3c, 0x3d, 0x4c, 0x4d],
> > +		i2c_detect => sub { emc1403_detect(@_, 4); },
> > +	}, {
> >  		name => "SMSC EMC1023",
> >  		driver => "to-be-written",	# emc1023
> >  		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
> >  		i2c_detect => sub { emc1023_detect(@_, 0); },
> >  	}, {
> > +		name => "SMSC EMC1033",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x3c, 0x3d, 0x4c, 0x4d],
> > +		i2c_detect => sub { emc1403_detect(@_, 5); },
> > +	}, {
> >  		name => "SMSC EMC1043",
> >  		driver => "to-be-written",	# emc1023
> >  		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
> >  		i2c_detect => sub { emc1023_detect(@_, 1); },
> >  	}, {
> > +		name => "SMSC EMC1046",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x4c, 0x4d],
> > +		i2c_detect => sub { emc1403_detect(@_, 6); },
> > +	}, {
> > +		name => "SMSC EMC1047",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x10, 0x18],
> > +		i2c_detect => sub { emc1403_detect(@_, 7); },
> > +	}, {
> >  		name => "SMSC EMC1053",
> >  		driver => "to-be-written",	# emc1023
> >  		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
> > @@ -1215,6 +1235,26 @@
> >  		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
> >  		i2c_detect => sub { emc1023_detect(@_, 3); },
> >  	}, {
> > +		name => "SMSC EMC1072",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x1c, 0x3c, 0x4c, 0x5c, 0x6c, 0x7c],
> > +		i2c_detect => sub { emc1403_detect(@_, 8); },
> > +	}, {
> > +		name => "SMSC EMC1073",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x1c, 0x3c, 0x4c, 0x5c, 0x6c, 0x7c],
> > +		i2c_detect => sub { emc1403_detect(@_, 9); },
> > +	}, {
> > +		name => "SMSC EMC1074",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x1c, 0x3c, 0x4c, 0x5c, 0x6c, 0x7c],
> > +		i2c_detect => sub { emc1403_detect(@_, 10); },
> > +	}, {
> > +		name => "SMSC EMC1402",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x18, 0x19, 0x4c, 0x4d],
> > +		i2c_detect => sub { emc1403_detect(@_, 11); },
> > +	}, {
> >  		name => "SMSC EMC1403",
> >  		driver => "emc1403",
> >  		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> > @@ -1230,6 +1270,11 @@
> >  		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> >  		i2c_detect => sub { emc1403_detect(@_, 3); },
> >  	}, {
> > +		name => "SMSC EMC1424",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x4c],
> > +		i2c_detect => sub { emc1403_detect(@_, 12); },
> > +	}, {
> >  		name => "ST STTS424",
> >  		driver => "jc42",
> >  		i2c_addrs => [0x18..0x1f],
> 
> These changes add I2C addresses 0x10, 0x3c, 0x3d, 0x6c and 0x7c to the
> list of addresses being probed (check with sensors-detect --stat).
> Adding new probed addresses is potentially dangerous, as we have had
> (regular and sometimes dramatic) reports of issues related to probing
> specific I2C addresses in the past. In general, I strongly suggest to
> _not_ add new addresses without a good reason.
> 
Good point.

> So we have to think about the usage of the EMC devices in question. Do
> you know if any of these are being, or will be, used on PC boards?
> Remember that the purpose of sensors-detect is not to be a universal
> hardware monitoring device detector. It's primarily aimed at PC users.
> Users of embedded devices or exotic hardware should know what hardware
> monitoring devices they have, and these device should be instantiated by
> the kernel directly, rather than being detected from user-space.
> 
No idea. It wasn't specifically that I need it or that we are going to use 
any of the chips. I just got into it after the recent emc driver submission,
and figured that since I tracked down the addresses and chip IDs, I might
as well put my knowledge to some use.

Also, while you are right about platform data on embedded devices
for the running code, there are additional aspects to consider.

First, I have often seen that HW specs for embedded devices can more or less
only be seeen as guidance. Not only do chips show up on unexpected addresses,
I have seen instances where chips were not there at all, or undocumented
chips show up. This gets difficult if one has to port linux to some older device,
where the HW designers may no longer be there.

Second, there is the case of people porting Linux to a box which wasn't supposed
to run Linux.

In both cases, sensors-detect can be a very useful tool to help figuring out
what is actually there.

How about removing the new addresses from the list ? Would you be ok 
with the patch if I do that ?

> If you look at sensors-detect, you'll see that for some other chips, we
> already skip unusual addresses on purpose (for the Maxim
> MAX6633/MAX6634/MAX6635 we skip 0x40-0x47 for example.)
> 
> BTW, probing address 0x7c is out of the question: it's nor even a valid
> 7-bit I2C address (marked as "Reserved for future purposes" in the I2C
> specification version 2.1.) And 0x10 is used by IPMI, so probing it
> would certainly cause trouble on may systems.
> 
> > @@ -5446,7 +5491,11 @@
> >  	return 7;
> >  }
> >  
> > -# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423
> > +# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423,
> > +#	4 = EMC1033, 5 = EMC1073, 6 = EMC1074, 7 = EMC1046, 8 = EMC1047,
> > +#	9 = EMC1402, 10 = EMC1072, 11 = EMC1424, 12 = EMC1002
> 
> The two lines above should be deleted, right?
> 
yes.

> > +#	4 = EMC1002, 5 = EMC1033, 6 = EMC1046, 7 = EMC1047, 8 = EMC1072,
> > +#	9 = EMC1073, 10 = EMC1074, 11 = EMC1402, 12 = EMC1424
> >  # Registers used:
> >  #   0xfd: Device ID register
> >  #   0xfe: Vendor ID register
> > @@ -5460,18 +5509,45 @@
> >  
> >  	return unless $man_id = 0x5d;	# SMSC
> >  
> > -	if ($chip = 0) {
> > +	if ($chip = 0) {		# EMC1403
> >  		return unless $dev_id = 0x21;
> >  		return unless $rev = 0x01;
> > -	} elsif ($chip = 1) {
> > +	} elsif ($chip = 1) {		# EMC1404
> >  		return unless $dev_id = 0x25;
> >  		return unless $rev = 0x01;
> > -	} elsif ($chip = 2) {
> > +	} elsif ($chip = 2) {		# EMC2103
> >  		return unless ($dev_id = 0x24) || ($dev_id = 0x26);
> >  		return unless $rev = 0x01;
> > -	} elsif ($chip = 3) {
> > +	} elsif ($chip = 3) {		# EMC1423
> >  		return unless $dev_id = 0x23;
> >  		return unless $rev = 0x01;
> > +	} elsif ($chip = 4) {		# EMC1002
> > +		return unless ($dev_id = 0x02) || ($dev_id = 0x03);
> > +		return unless $rev = 0x01;
> > +	} elsif ($chip = 5) {		# EMC1033
> > +		return unless ($dev_id = 0x0a) || ($dev_id = 0x0b);
> > +		return unless $rev = 0x01;
> > +	} elsif ($chip = 6) {		# EMC1046
> > +		return unless $dev_id = 0x1a;
> > +		return unless $rev = 0x01;
> > +	} elsif ($chip = 7) {		# EMC1047
> > +		return unless $dev_id = 0x1c;
> > +		return unless $rev = 0x01;
> > +	} elsif ($chip = 8) {		# EMC1072
> > +		return unless $dev_id = 0x20;
> > +		return unless $rev = 0x03;
> > +	} elsif ($chip = 9) {		# EMC1073
> > +		return unless $dev_id = 0x21;
> > +		return unless $rev = 0x03;
> > +	} elsif ($chip = 10) {		# EMC1074
> > +		return unless $dev_id = 0x25;
> > +		return unless $rev = 0x03;
> > +	} elsif ($chip = 11) {		# EMC1402
> > +		return unless $dev_id = 0x20;
> > +		return unless $rev = 0x01;
> > +	} elsif ($chip = 12) {		# EMC1424
> > +		return unless $dev_id = 0x27;
> > +		return unless $rev = 0x01;
> >  	}
> >  
> >  	return 6;
> 
> Looks OK.
> 
> > Index: CHANGES
> > =================================> > --- CHANGES	(revision 5913)
> > +++ CHANGES	(working copy)
> > @@ -22,6 +22,8 @@
> >                    Add detection of Maxim MAX6639
> >                    Add detection of EMC1023, EMC1043, EMC1053, and EMC1063
> >                    Add detection of Nuvoton NCT5571D, NCT5577D and NCT6776F
> > +                  Add detection of EMC1002, EMC1033, EMC1046, EMC1047,
> > +                        EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424
> 
> Please specify that these are SMSC chips.
> 
Ok.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
