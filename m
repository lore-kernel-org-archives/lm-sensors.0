From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <20040826073018.GA22852@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 23, 2004 at 03:08:29PM +0400, Evgeniy Polyakov wrote:
> On Sun, 2004-08-22 at 12:48, Jean Delvare wrote:
> > > > > #define SIO_LDN_GPIO		0x07	/* General-Purpose I/O (GPIO) Ports */
> > > > 
> > > > This is PC87366-specific and doesn't belong to that driver.
> > > 
> > > No, I think it just should be extended and include any other
> > > defines(for temperature, voltage and others). Although they may live
> > > in drivers for those logical devices. Driver for PC87366 may use it...
> > > I will move it there after it will be created (actually separated to
> > > support several main SuperIO chips at once).
> > 
> > I'm not sure I get everything you mean here (especially the last
> > sentence). At any rate, the logical device usage is
> > manufacturer-dependant and, in most cases, chip dependant. And when two
> > different chips each have a logical device for, say, temperature
> > monitoring, the way it is organized "inside" each logical device will be
> > different. So there's no benefit in adding labels or classes to each
> > logical device of each chip, since we will never be able to use them.
> > 
> > I insist that the superio driver should be mostly chip-independant. The
> > only part which will not be is the Super-I/O enter sequence. Since the
> > PC8736x chips don't need any, you may not be familiar with it. Most
> > Super-I/O chips need a special sequence to be written to them before
> > they activate. Since the superio driver won't know what it is looking
> > for before it finds it, it'll probably have to test all known keys, then
> > the client driver will ask not only for a given chip ID but for a key +
> > chip ID pair. This also means that you will have to store the (variable
> > length) key in the superio structure.
> 
> I'm absolutely agree here.
> I mean above that when I will split sc.c into generic part and pc8736*
> part I will move those definitions into the header for pc8736* driver.

That sounds fine.

> As I described above we will not have code duplication and will have
> ability to add/remove logical devices in run-time.

Which is a good thing.

> > Greg, I much would like to hear you about this.
> 
> I think we will come to logical conclusion when he will back from
> vocation.
> Or not.

Heh, it looks good to me.  Oh, and I suggest putting this in
drivers/superio for a location.

thanks,

greg k-h
