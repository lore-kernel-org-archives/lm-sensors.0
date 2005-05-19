From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-sis630 driver (fixed)
Message-Id: <200308012335.38471.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307302234.43914.amalysh@web.de>
In-Reply-To: <200307302234.43914.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 31 July 2003 05:27, Mark M. Hoffman wrote:
> * Alexander Malysh <amalysh@web.de> [2003-07-31 00:59:50 +0200]:
> > Hi Mark,
> >
> > hmm, now I have undestand the problem... But it is not a right fix too
> > (imo). with your changes i2c-sis630 will claim ISA brigde and block
> > others if they want use it or I missed anything? i2c-sis630 doesn't use
> > isa brigde only for detection of acpi base address.
>
> My understanding is this:  If you need the resource (base address) from the
> ISA bridge PCI device, that's a valid reason to claim it.  Do you know of
> some other driver which uses the ACPI base address?  Is there some other
> driver which claims the ISA bridge PCI device?  Come to think of it - you
> have the datasheet for that chipset - is there anything else on there that
> would need a driver?

i2c-sis630 doesn't use (base addr) from the isa brigde pci device, only acpi 
base addr will be used by the driver and may not play with acpi very well if 
acpi make use of smbus (e.g.defined in the dsdt).Unfortunately I have not 
tested it yet, because in dstdt from my laptop is no smbus defined.

>
> You're right: the patch I proposed assumes that it is the one and only
> driver to claim the ISA bridge device.

but why should driver claim this device? I can not get really answer , if any 
other driver claims the isa brigde pci device , but unfortunately I can not 
undestand why?

>
> *However*, since the resource in question is the "acpi base address" - I
> don't know how ACPI fits into all this.
>
> Maybe we'll get advice from Greg KH?  Or else we could try asking LKML...
>
> > my proposal is to revert pci changes made by MDS and do the old
> > detection.
>
> The old way will not get accepted into 2.4.23, which is our goal.
>
> > On Thursday 31 July 2003 00:35, Mark M. Hoffman wrote:
> > > Hi Alex:
> > >
> > > * Alexander Malysh <amalysh@web.de> [2003-07-30 22:34:39 +0200]:
> > > > Hi again,
> > > >
> > > > the bug is fixed now... I do not know how to close the tikets.
> > >
> > > It still has a bug: the pci system will associate the 630 or 730
> > > device with your driver, such that no other driver (if there was
> > > one) which might claim that device will work.  The thread where
> > > this was first mentioned is here:
> > >
> > > http://archives.andrew.net.au/lm-sensors/msg03193.html
> > >
> > > So how about this patch? (against CVS, compiles, untested)
>
> Regards,

-- 
Best regards,
Dipl.-Ing.
Alexander Malysh
