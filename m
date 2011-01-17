From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 21:04:56 +0000
Subject: Re: [lm-sensors] patch to sensor-detect script to support SMSC
Message-Id: <1295298296.9786.218.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D346ACA.8050601@gmail.com>
In-Reply-To: <4D346ACA.8050601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-01-17 at 15:29 -0500, Anish Patel wrote:
> On 01/17/11 14:36, Guenter Roeck wrote:
> > On Mon, 2011-01-17 at 14:04 -0500, Anish Patel wrote:
> >> On 01/17/11 13:09, Guenter Roeck wrote:
> >>> On Mon, Jan 17, 2011 at 11:14:02AM -0500, Anish Patel wrote:
> >>>> patch attached.
> >>>>
> >>>> *** sensors-detect	Fri Jan 14 11:11:56 2011
> >>>> --- sensors-detect-new	Sat Jan 15 03:01:01 2011
> >>>> ***************
> >>>> *** 1205,1210 ****
> >>>> --- 1205,1215 ----
> >>>>     		i2c_addrs =>   [0x18, 0x2a, 0x4c, 0x4d],
> >>>>     		i2c_detect =>   sub { emc1403_detect(@_, 3); },
> >>>>     	}, {
> >>>> + 		name =>   "SMSC_EMC1023",
> >>>> + 		driver =>   "emc1023",
> >>>> + 		i2c_addrs =>   [0x48,0x49,0x4c,0x4d],
> >>>> + 		i2c_detect =>   sub { emc1023_detect(@_); },
> >>>> + 	}, {
> >>>>     		name =>   "ST STTS424",
> >>>>     		driver =>   "jc42",
> >>>>     		i2c_addrs =>   [0x18..0x1f],
> >>>> ***************
> >>>> *** 5387,5392 ****
> >>>> --- 5392,5418 ----
> >>>>     	return 6;
> >>>>     }
> >>>>
> >>>> + # Chip to detect:
> >>>> + # Registers used:
> >>>> + #   0xed: Device ID register
> >>>> + #   0xfe: Vendor ID register
> >>>> + #   0xff: Revision register
> >>>> + sub emc1023_detect
> >>>> + {
> >>>> + 	my ($file, $addr, $chip) = @_;
> >>> You don't pass $chip as argument, so you should not extract it either.
> >> fixed
> >>>> + 	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
> >>>> + 	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
> >>>> + 	my $rev = i2c_smbus_read_byte_data($file, 0xff);
> >>>> +
> >>>> + 	return unless $man_id = 0x5d;	# SMSC
> >>>> +
> >>>> + 	return unless ($dev_id = 0x0c) || ($dev_id = 0x0d) || ($dev_id = 0x08) || ($dev_id = 0x09) ;
> >>> Per emc1023 datasheet, Product ID values should be 0x04 .. 0x07. Am I missing something ?
> >>>
> >>> Also, the Product ID and the chip address should match. So you could enhance detection
> >>> by checking for the match.
> >> i don't this this can happen, if you look at pg 2 of the data sheet, you
> >> can see where they hard code the addresses for the part.
> >> when you read out of ED, it seems to have stored the lower 4bits of the
> >> address as the product ID.  this is all i can say for the 5 boards i
> >> have here with the emc1023-1 and emc1023-2.
> >>
> > Page 11 says:
> > Read address	Register Name	Default Value (hex)
> > ED		Product ID	04 (-01)
> > 				05 (-02)
> > 				06 (-03)
> > 				07 (-04)
> > and on page 2:
> >
> > EMC1023-1-ACZL-TR (Address - 1001100b)
> > EMC1023-2-ACZL-TR (Address - 1001101b)
> > EMC1023-3-ACZL-TR (Address - 1001000b)
> > EMC1023-4-ACZL-TR (Address - 1001001b)
> >
> > So, as example, one should assume that EMC1023-1 should always be on
> > address 0x4c, and that reading register 0xed should return 0x04. I don't
> > see where it says that reading register 0xed should ever return the
> > lower 4 bits of the chip address.
> yes, that is what one would assume, but thats not whats happening, and 
> you are correct, the DS does not say that reading register 0xed should 
> return the lower 4bits of the chip address, but that is what i am seeing 
> while working on the system that has the EMC1023-1 and EMC1023-2.
> > Looking up other chips, I found the following product IDs for various
> > EMCxxxx chips using register 0xed as Product ID register.
> >
> > Chip		Register 0xed
> > emc1043		0x0c .. 0x0f, 0x2c
> > emc1053		0x3c .. 0x3f
> > emc1063		0x30 .. 0x33
> >
> > So I wonder if you might really have emc1043 on your board instead of
> > emc1023. Would that be possible ?
> its possible, but i just found a spare CPU carrier card and looked at 
> it.  the IC is def a 1023.
> I guess it is possible that i have fake/rebadged 1023.

Interesting. Should be easy to find out, though. emc1043 has register
0x04 with a default value of 0x09. That register does not exist on
emc1023 and should either return the previously read value or an error.
emc1043 also has registers 0x29 and 0x2a which don't exist on the
emc1023. Maybe you can use i2cdump to see what registers the chip
supports, and send the result to the list.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
