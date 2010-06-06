From: Steve.Glendinning@smsc.com
Date: Sun, 06 Jun 2010 17:32:21 +0000
Subject: Re: [lm-sensors] [PATCH] Add detection of SMSC EMC2103 to
Message-Id: <OF20DECC17.56F875D9-ON8025773A.005B5988-8025773A.006057E4@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100604093342.79e576c0@hyperion.delvare>
In-Reply-To: <20100604093342.79e576c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> > index 43b1095..7d59cee 100755
> > --- a/prog/detect/sensors-detect
> > +++ b/prog/detect/sensors-detect
> > @@ -1130,6 +1130,11 @@ use vars qw(@i2c_adapter_names);
> >        i2c_addrs => [0x2c..0x2e],
> >        i2c_detect => sub { dme1737_detect(@_, 2); },
> >     }, {
> > +      name => "SMSC EMC2103",
> > +      driver => "smscemc",
> 
> I don't much like this driver name. This driver won't support all the
> SMSC EMC series, so it's confusing. If nothing else, the EMC1403,
> EMC6D100, EMC6D101, EMC6D102 and EMC6D103 are already supported by two
> other drivers (emc1403 and lm85). And there are many other SMSC EMC
> chips, and I doubt they will all be compatible with the EMC2103, right?
> So I would much prefer that you name your driver "emc2103".

Right now this driver only supports the EMC2103 family, but it is intended
to support a whole family of parts in future - hence the quite generic 
name.
I've submitted a new version of the driver for review with the name 
emc2103,
but I'm unsure of the impact of this.  If we want to add support for more
devices after this is merged can we rename it?

> > +      i2c_addrs => [0x2e],
> > +      i2c_detect => sub { smsc_emc2103_detect(@_); },
> > +   }, {
> >        name => "Fintek F75121R/F75122R/RG (VID+GPIO)",
> >        driver => "to-be-written",
> >        i2c_addrs => [0x4e], # 0x37 not probed
> > @@ -5079,6 +5084,21 @@ sub smsc47m192_detect
> >     return ($addr = 0x2d ? 6 : 5);
> >  }
> > 
> > +# Registers used:
> > +#   0xFD: Product ID
> > +#   0xFE: Manufacturer ID
> > +#   0xFF: Revision
> 
> Your detection routine below doesn't actually use register 0xff. It
> should if possible: this would make the detection more robust.

What should the detection policy be for this?  All the devices I
currently have access to have a revision register value of 1, so
should the driver only allow this specifically tested revision?
I notice that's what the newly added emc1403 driver does.  I
guess this would mean that we'll have to submit patches to allow
support for newer revisions?

Future revisions *should* be 100% register compatible, but obviously
we can't actually test this as they don't exist yet!

> > +sub smsc_emc2103_detect
> > +{
> > +   my ($file, $addr) = @_;
> > +   return unless i2c_smbus_read_byte_data($file, 0xFE) = 0x5D;
> > +
> > +   my $product = i2c_smbus_read_byte_data($file, 0xFD);
> > +   return unless (($product = 0x24) || ($product = 0x26));
> > +
> > +   return 8;
> 
> You can't grant such a high confidence value after checking only 15
> bits: it would rather be confidence 5 or 6. 

Ok, I'll update this.

> Also, the detection registers seem similar to the EMC1403's, so it
> might make sense to reuse function emc1403_detect for the EMC2103,
> instead of writing a new one.

Ahh, I actually wrote the sensors-detect routine before the EMC1403
support was merged.  This definitely makes sense, the patch is much
smaller now.

Steve

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
