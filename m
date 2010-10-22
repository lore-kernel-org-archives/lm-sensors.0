From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Oct 2010 13:32:31 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] sensors-detect: Add detection of PMBus
Message-Id: <20101022153231.26f654bd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014154042.GA20794@ericsson.com>
In-Reply-To: <20101014154042.GA20794@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 22 Oct 2010 04:14:14 -0700, Guenter Roeck wrote:
> On Fri, Oct 22, 2010 at 04:54:53AM -0400, Jean Delvare wrote:
> > A third question is: do these devices support SMBus ARP? This would be
> > an alternative to systematic device detection as we do today. Someone
> > is working on this already but progress is very slow (I think the guy
> > started over a year ago but doesn't have much time to invest in it.) If
> > your devices support ARP, that would be the right time to work on it
> > seriously.
> > 
> I don't think so; I don't see it mentioned anywhere in the PMBus specification.

You can just check (with i2cdetect) if anything responds to address
0x61. This is the SMBus ARP address.

> > (...)
> > As a side note, I am pretty surprised to see devices with such a large
> > range of possible I2C addresses. I presume these aren't selected by
> > pins but using a secondary bus access? One reason why I am asking is
> > that having such a large range of I2C addresses to probe would be a
> > problem in the kernel too, so we certainly need an alternative way to
> > find out the address of these devices.
>
> As mentioned above, the chips use two resistors to set the I2C address.
> Each resistor controls three address bits, which creates a 6-bit dynamic range
> for the address.

I see. This really doesn't seem to be compatible with device probing at
all.

> > > (...)
> > > +		return if $revision != 0x21;	# PMBus version 1.1, per spec
> > 
> > Did you mean PMBus 2.1?
> > 
> No.
> 
> There is an inconsistency in the PMBus specification. The idea
> was to have two sets of 4 bit in the revision register to report
> which portion of the device is compliant to which PMBus version.
> Unfortunately, there is a typo in the spec, indicating the upper four bit
> of the version would be in bit 5..7. So some manufacturers use bit 4..7
> to report the respective part of the version, others use bit 5..7.
> As a result, some chips report 0x11 to indicate they are PMBus 1.1 compliant,
> others report 0x21.
> 
> There was an attempt to clean that up in PMBus 1.2, but that got dropped, 
> and it is still in there.

Thanks for the clarification.

> > > +		return unless $vout_mode = 0x15;
> > > +		return unless $capability = 0xb0;
> > > +		# MFR_ID returns "Ericsson AB" with a length of 12 bytes.
> > > +		# Reading it as word returns 0x450c.
> > > +		$reg = i2c_smbus_read_word_data($file, 0x99);
> > > +		return unless $reg = 0x450c;
> > > +		# MFR_MODEL returns "BMR45x...." with a length of 20 bytes.
> > > +		# Reading it as word returns 0x4214.
> > > +		$reg = i2c_smbus_read_word_data($file, 0x9a);
> > > +		return unless $reg = 0x4214;
> > > +
> > > +		# Now try again with full strings if block data reads are supported.
> > > +		# Otherwise report BMR450 with lower probability.
> > 
> > Why does the BMR450 need to be handled differently here?
> > 
> The idea was that we know that it is a BMR45x, but we don't know which one.
> Returning BMR450 with lower probability seemed to make some sense.

Ah, OK, I get it now. Sorry for being slow.

> Not really sure what the best approach would be. Another option might be 
> to just check for (and report) BMR45x in the first place.

If they are all supported by the same driver, yes, that would make
sense.

I admit that the implementation we have in sensors-detect isn't very
flexible for that kind of case. It would be better if functions could
return more than a confidence value, but were also able to refine the
device name. It didn't bother me enough so far that I would actually
try to improve it.

> (...)
> Overall it seems to be better to either drop this for now, or not try
> to detect devices which don't support the QUICK command. What do you think ?

Indeed these devices don't seem to fit in our detection scheme, and
overall seems detection-unfriendly by design. So I wouldn't bother
adding detection support for them for the time being. Better add kernel
support first, and see the actual use cases for these devices. Then we
can discuss the user-spac detection again if needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
