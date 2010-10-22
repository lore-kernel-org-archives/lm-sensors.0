From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 11:14:14 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] sensors-detect: Add detection of PMBus
Message-Id: <20101022111414.GA30859@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014154042.GA20794@ericsson.com>
In-Reply-To: <20101014154042.GA20794@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Oct 22, 2010 at 04:54:53AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late reply.
> 
No problem.

> On Thu, 14 Oct 2010 08:40:42 -0700, Guenter Roeck wrote:
> > This patch adds basic support for detection of PMBus devices.
> > It can easily be extended to support additional PMBus devices.
> > Key question right now is if this approach is acceptable.
> > 
> > Notable changes:
> > - Chip detection code now uses byte read to detect devices in address range [0x03..0x0a, 0x0d..0x3f]
> 
> This is a huge address range. And some of these addresses may be
I know :(.

> problematic: 0x03 to 0x07 were recently excluded from the list of
> scanned addresses in i2c-core. And 0x08 is generally the slave address
> on SMBus 2.0 controllers.
> 
I'll drop 0x03..0x08.

> Also, this is a range in which a lot of already supported devices live
> (in particular at 0x18-0x1a and 0x28-0x2f) so we have to be very
> careful. But in fact I am more worried about the addresses we were not
> probing so far, as it is very difficult to predict the result on all
> the PC motherboards out there.
> 
> >   TBD: Maybe we should use SMBUS_QUICK first followed by SMBUS_BYTE if it fails
> >   or if it is not supported by the adapter.
> 
> This would slow down the probing, as each non-responsive address would
> be tested twice instead of once. Now of course I can imagine that some
> chips may not reply to (or even hang on) the receive byte command.
> After all there is a reason why we defaulted to a quick write long ago,
> rather than a quick read: many devices don't have any legitimate use of
> transfers starting with a read message. So it would indeed be more
> conservative to always try a quick write first.
> 
That was the idea.

> > - Added support for SMBus block read command
> > - Fixed bug seen if I2C master numbering is non-sequential (which I should probably
> >   commit separately if the fix is ok).
> > 
> > Thanks,
> > Guenter
> > 
> > --
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5865)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -1249,6 +1249,31 @@
> >  		driver => "sbs", # ACPI driver, not sure if it always works
> >  		i2c_addrs => [0x0b],
> >  		i2c_detect => sub { smartbatt_detect(@_); },
> > +	}, {
> > +		name => "Linear Technology LTC2978",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x5c..0x64],
> > +		i2c_detect => sub { pmbus_detect(@_, 0); },
> > +	}, {
> > +		name => "Ericsson BMR450",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
> > +		i2c_detect => sub { pmbus_detect(@_, 1); },
> > +	}, {
> > +		name => "Ericsson BMR451",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
> > +		i2c_detect => sub { pmbus_detect(@_, 2); },
> > +	}, {
> > +		name => "Ericsson BMR453",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
> > +		i2c_detect => sub { pmbus_detect(@_, 3); },
> > +	}, {
> > +		name => "Ericsson BMR454",
> > +		driver => "to-be-written",
> > +		i2c_addrs => [0x03..0x0a, 0x0d..0x3f],
> > +		i2c_detect => sub { pmbus_detect(@_, 4); },
> >  	}
> >  );
> 
> One key question is: are these devices something which you expect to
> show up in consumer PC machines? The main target for sensors-detect is
> this. We don't necessarily want to add support for all
> hardware-monitoring-style devices in the world to this script.
> 
Those are not only HW monitoring chips, but also power supply controllers.
So it might well be that such chips will show up on PCs. Difficult to say,
though. Might be too expensive for PCs.

> A second question is: out of the possible addresses, do you expect all
> of these to be used in practice? The LM78 and W83781D devices, which we
> support for a long long time, can use virtually any I2C address, but in
> practice the vendors always stick to a few possibilities, and
> sensors-detect only probes for these addresses.
> 
I don't have enough data to determine if there is a "preferred" address range.

Some of the devices only support a limited address range, but several
use a set of two resistors. I hear talk about a board with 20+ of the
BMR45x chips, all to be accessible from PMBus.

> A third question is: do these devices support SMBus ARP? This would be
> an alternative to systematic device detection as we do today. Someone
> is working on this already but progress is very slow (I think the guy
> started over a year ago but doesn't have much time to invest in it.) If
> your devices support ARP, that would be the right time to work on it
> seriously.
> 
I don't think so; I don't see it mentioned anywhere in the PMBus specification.

> As a summary, this patch seems dangerous and I would like you to take a
> more conservative and pragmatic path if you have to go for old-style
> probing. Even better if you can do without probing (using ARP).
> 
Maybe not bother probing for PMBus devices at all would be the best approach,
at least until any show up on PCs. Or only probe for devices supporting
the QUICK command.

> As a side note, I am pretty surprised to see devices with such a large
> range of possible I2C addresses. I presume these aren't selected by
> pins but using a secondary bus access? One reason why I am asking is
> that having such a large range of I2C addresses to probe would be a
> problem in the kernel too, so we certainly need an alternative way to
> find out the address of these devices.
> 
As mentioned above, the chips use two resistors to set the I2C address.
Each resistor controls three address bits, which creates a 6-bit dynamic range
for the address.

> > +     } elsif ($chip > 0 && $chip < 5) {
> 
> I think this is better written $chip >= 1 && $chip <= 4.

Agreed; I had changed that already.

> > +		return if $revision != 0x21;	# PMBus version 1.1, per spec
> 
> Did you mean PMBus 2.1?
> 
No.

There is an inconsistency in the PMBus specification. The idea
was to have two sets of 4 bit in the revision register to report
which portion of the device is compliant to which PMBus version.
Unfortunately, there is a typo in the spec, indicating the upper four bit
of the version would be in bit 5..7. So some manufacturers use bit 4..7
to report the respective part of the version, others use bit 5..7.
As a result, some chips report 0x11 to indicate they are PMBus 1.1 compliant,
others report 0x21.

There was an attempt to clean that up in PMBus 1.2, but that got dropped, 
and it is still in there.

> > +		return unless $vout_mode = 0x15;
> > +		return unless $capability = 0xb0;
> > +		# MFR_ID returns "Ericsson AB" with a length of 12 bytes.
> > +		# Reading it as word returns 0x450c.
> > +		$reg = i2c_smbus_read_word_data($file, 0x99);
> > +		return unless $reg = 0x450c;
> > +		# MFR_MODEL returns "BMR45x...." with a length of 20 bytes.
> > +		# Reading it as word returns 0x4214.
> > +		$reg = i2c_smbus_read_word_data($file, 0x9a);
> > +		return unless $reg = 0x4214;
> > +
> > +		# Now try again with full strings if block data reads are supported.
> > +		# Otherwise report BMR450 with lower probability.
> 
> Why does the BMR450 need to be handled differently here?
> 
The idea was that we know that it is a BMR45x, but we don't know which one.
Returning BMR450 with lower probability seemed to make some sense.
Not really sure what the best approach would be. Another option might be 
to just check for (and report) BMR45x in the first place.

> > +		$funcs = i2c_get_funcs($file);
> > +		if (!($funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
> > +			return 5 if $chip = 1;
> > +			return 0;
> > +		}
> > +		$data = i2c_smbus_read_block_data($file, 0x99);
> > +		# Should return "Ericsson AB"
> > +		return if substr($data, 0, 11) ne "Ericsson AB";
> > +		$data = i2c_smbus_read_block_data($file, 0x9a);
> > +		# Should return "BMR45x"
> > +		return if $chip = 1 && substr($data, 0, 6) ne "BMR450";
> > +		return if $chip = 2 && substr($data, 0, 6) ne "BMR451";
> > +		return if $chip = 3 && substr($data, 0, 6) ne "BMR453";
> > +		return if $chip = 2 && substr($data, 0, 6) ne "BMR454";
> > +	}
> > +
> > +	return 9;
> 
> 9 is higher that I would expect for the LTC2978. 8 would be more
> reasonable.
> 
Ok.

Overall it seems to be better to either drop this for now, or not try
to detect devices which don't support the QUICK command. What do you think ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
