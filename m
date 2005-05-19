From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: SIS 645 (was: Re: SIS 630 (ID))
Message-Id: <3D67EA7D.2727E1E1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020823224314.A13520@mercury.solarsys.net>
In-Reply-To: <20020823224314.A13520@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With respect to the PCI "junk",
the "right" way to do it is to use the kernel's PCI hotplug facility.
Two examples are the m7101 and p4b_smbus modules in prog/hotlug in our
package.
I think it's the only acceptable way.
We have many people using these modules, they work well.

These are "fixup" modules that enable a PCI device. They must
be run before the corresponding i2c driver.

We've always treated boards that failed to enable a PCI device
as the exception - and haven't put the hotplug code into any i2c driver
itself. You could certainly do that for yours, it would have to
be wrapped with #ifdef CONFIG_HOTPLUG. You're most of the way
there already.

How many people run kernels with CONFIG_HOTPLUG, I have no idea -
but you can always put out a printk telling them to
enable it if they want to get their SMBus device.

I also checked in your ID.

mds




"Mark M. Hoffman" wrote:
> 
> Hello sensors list:
> 
> I'm also ready for an ID for SiS645 SMbus.  You can put my name down for
> 635, 645, and 735; although this first attempt only supports 645.
> 
> According to SiS, it should also work for the others.  But this is the *only*
> information I got from them - still no datasheets.  Thanks to Alexander for
> finding the 630 datasheet though... it's close enough to put this over the
> top.
> 
> It tests OK on my Asus P4S333.  You can find the driver here...
> http://home.pacbell.net/mh0ffman/sensors/i2c-sis645.c
> 
> I'll follow this up w/ docs, sensors-detect patch, etc. as soon as I can.
> 
> I'm interested in any comments or suggestions; especially would someone
> with more PCI experience care to comment on the junk starting at line 168?
> 
> Thanks and regards,
> 
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
> On Wed, Aug 21, 2002 at 06:01:26PM -0400, Mark Studebaker wrote:
> > OK,
> > I'll give you an ID tonight.
> > If you haven't please review doc/developers/new-drivers.
> > Do you know if the 630 driver will work for any of the other
> > SiS devices listed on our new drivers page?
> >
> > Alexander Malysh wrote:
> > >
> > > Hello,
> > >
> > > as i already wrote , i have implemented smbus support for sis630. Since my
> > > first posting i have found and fixed several bugs (please do not use old
> > > one). New version can be found at : http://amalysh.bei.t-online.de/linux/
> > > Now i need ID for sis630 SMBUS in i2c-id.h
> > >
> > > Thank you for you help ...
> > >
> > > --
> > > Regargs,
> > >
> > > Dipl.-Ing. Alexander Malysh
