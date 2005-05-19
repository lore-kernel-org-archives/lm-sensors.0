From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [BK PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040825061445.GA16938@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040715000527.GA18923@kroah.com> <1093384722.8445.10.camel@tdi> <20040824220450.GE11165@kroah.com> <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org> <1093397881.9555.6.camel@tdi> <Pine.LNX.4.58.0408241847460.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408241847460.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Williamson <alex.williamson@hp.com>, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Tue, Aug 24, 2004 at 07:02:47PM -0700, Linus Torvalds wrote:
> On Tue, 24 Aug 2004, Alex Williamson wrote:
> > > How about this _trivial_ change? Does that fix things for you guys? Can 
> > > you send the /proc/ioport output if this works out for you, just so that 
> > > we can see?
> > 
> >    Yes, this works.  Please commit.
> 
> Greg? Opinions? I'll happily commit it, since it's almost certainly bound
> to be better than what we have now, but I have to admit that I could also 
> see it causing confusion if two devices are set up by the BIOS to be on 
> top of each other (since insert_resource() would indeed allow that).
> 
> Now, admittedly, that would be a VERY broken BIOS, and likely such a 
> situation wouldn't have worked _anyway_, but you're the PCI maintainer, so 
> you get to sit in the hot seat and say aye or nay.

It looks correct to me, please apply it.  If it breaks people's boxes
that used to work, I'm sure I'll hear about it :)

> > 1200-121f : motherboard
> >   1200-121f : 0000:00:1f.3
> 
> This is apparently the one that used to cause trouble, and you can see it 
> from the nesting level: the device nests inside the description, rather 
> than the other way around.
> 
> This does bring up an alternate fix: namely to do the PCI quirks 
> _earlier_.
> 
> If we had done the PCI quirk handling and probing for this device _before_
> ACPI populated the IO stuff, and we'd never have seen this problem. Why 
> did we let ACPI come in first in the first place? Greg? Len?

I don't really know, I think that happened before both Len and I took
over this code base.  I don't have a problem with doing it in this
order, but I'm sure there's some ACPI issue that I'm not aware of that
needs to be run first.

> The right order (I think) should be:
>  - walk the existing PCI setup, do the header quirks, populate the device 
>    and resource trees..
>  - _than_ do the ACPI resources

For a box such as this one, it would make sense to do it in this order,
I agree.

thanks,

greg k-h
