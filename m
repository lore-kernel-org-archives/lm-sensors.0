From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [BK PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040824220450.GE11165@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040715000527.GA18923@kroah.com> <1093384722.8445.10.camel@tdi>
In-Reply-To: <1093384722.8445.10.camel@tdi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Williamson <alex.williamson@hp.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Tue, Aug 24, 2004 at 03:58:42PM -0600, Alex Williamson wrote:
> On Wed, 2004-07-14 at 17:05 -0700, Greg KH wrote:
> 
> > <orange:fobie.net>:
> >   o I2C: patch quirks.c - SMBus hidden on hp laptop
> 
>    This particular patch, along w/ the new 20040715 ACPI drop has made
> my nc6000 laptop unusable.  The problem is we're exposing a device that
> firmware considers hidden.  The new motherboard driver in ACPI goes out
> and tries to claim resources to prevent them from being stepped on.  It
> rightfully considers the hidden SMBus device a motherboard resource.
> The PCI code then stumbles onto this device, sees that the BAR it's
> using is unavailable and moves it somewhere else in the address space.
> At this point, I lose two for the three thermal zones on the laptop
> because the AML that deals with them assumes they haven't moved.
> 
>    I'm not sure what the point on un-hiding this devices it.  ACPI sets
> up an OpRegion to access this device and should have exclusive access to
> that region.  Letting a sensor driver poke at it may be fun, but I'd
> rather not fry my laptop.  Can we drop the un-hiding of the SMBus for
> this laptop (probably the nc8000 too), or is there some way to make the
> ACPI motherboard driver and this quirk live together?  Thanks,

See the bugzilla.kernel.org bug #3191 for more information.

If someone can come up with a patch that works for everyone, I'll be
glad to apply it.

thanks,

greg k-h
