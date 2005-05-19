From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: i2c-sis630 driver (fixed)
Message-Id: <20030731032743.GB5625@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307302234.43914.amalysh@web.de>
In-Reply-To: <200307302234.43914.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Alexander Malysh <amalysh@web.de> [2003-07-31 00:59:50 +0200]:
> Hi Mark,
> 
> hmm, now I have undestand the problem... But it is not a right fix too (imo).
> with your changes i2c-sis630 will claim ISA brigde and block others if they 
> want use it or I missed anything? i2c-sis630 doesn't use isa brigde only for 
> detection of acpi base address.

My understanding is this:  If you need the resource (base address) from the ISA
bridge PCI device, that's a valid reason to claim it.  Do you know of some other
driver which uses the ACPI base address?  Is there some other driver which 
claims the ISA bridge PCI device?  Come to think of it - you have the datasheet
for that chipset - is there anything else on there that would need a driver?

You're right: the patch I proposed assumes that it is the one and only 
driver to claim the ISA bridge device.

*However*, since the resource in question is the "acpi base address" - I don't
know how ACPI fits into all this.

Maybe we'll get advice from Greg KH?  Or else we could try asking LKML...

> my proposal is to revert pci changes made by MDS and do the old detection.

The old way will not get accepted into 2.4.23, which is our goal.

> On Thursday 31 July 2003 00:35, Mark M. Hoffman wrote:
> > Hi Alex:
> >
> > * Alexander Malysh <amalysh@web.de> [2003-07-30 22:34:39 +0200]:
> > > Hi again,
> > >
> > > the bug is fixed now... I do not know how to close the tikets.
> >
> > It still has a bug: the pci system will associate the 630 or 730
> > device with your driver, such that no other driver (if there was
> > one) which might claim that device will work.  The thread where
> > this was first mentioned is here:
> >
> > http://archives.andrew.net.au/lm-sensors/msg03193.html
> >
> > So how about this patch? (against CVS, compiles, untested)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
