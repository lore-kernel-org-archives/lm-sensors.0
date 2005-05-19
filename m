From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <20040822104851.6ae41e6b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > #define SIO_LDN_GPIO		0x07	/* General-Purpose I/O (GPIO) Ports */
> > 
> > This is PC87366-specific and doesn't belong to that driver.
> 
> No, I think it just should be extended and include any other
> defines(for temperature, voltage and others). Although they may live
> in drivers for those logical devices. Driver for PC87366 may use it...
> I will move it there after it will be created (actually separated to
> support several main SuperIO chips at once).

I'm not sure I get everything you mean here (especially the last
sentence). At any rate, the logical device usage is
manufacturer-dependant and, in most cases, chip dependant. And when two
different chips each have a logical device for, say, temperature
monitoring, the way it is organized "inside" each logical device will be
different. So there's no benefit in adding labels or classes to each
logical device of each chip, since we will never be able to use them.

I insist that the superio driver should be mostly chip-independant. The
only part which will not be is the Super-I/O enter sequence. Since the
PC8736x chips don't need any, you may not be familiar with it. Most
Super-I/O chips need a special sequence to be written to them before
they activate. Since the superio driver won't know what it is looking
for before it finds it, it'll probably have to test all known keys, then
the client driver will ask not only for a given chip ID but for a key +
chip ID pair. This also means that you will have to store the (variable
length) key in the superio structure.

> > > struct logical_dev
> > > {
> > > (...)
> > >	int			(*activate)(void *);
> > >	u8			(*read)(void *, int);
> > >	void			(*write)(void *, int, u8);
> > >	void			(*control)(void *, int, u8, u8);
> > > };
> > 
> > Please give the function parameters names in your prototypes.
> > Without them, the prototype is useless to us humans (although the
> > compiler is perfectly happy without them).
> 
> Actually I always remove names from prototypes, since I think
> prototypes are needed not for detailed explanation of appropriate
> function but only for overall design view...

You probably miss the target then. In the above example, I can easily
imagine what the activate, read and write member functions are for (left
apart the fact that I wonder what the void * is for), but I just cannot
guess what the control member function is for. Anonymous parameters
don't help. At any rate, other kernel headers seem to include parameters
names in their functions declarations.

While we're at it, I start wondering why you need these callback
functions here. Is the client not supposed to just call sc_read_reg and
sc_write_reg? I see nothing logical-device-dependent here.

> sc_{add,del}_logical_dev() links and unlinks logical device from the
> main SuperIO module. After being added any logical device becomes
> visible for the external world, but it should be accessed only through
> main module using sc_{get,put}_ldev, which also increment/decrement
> is's usage counter and may implement additional functionality. When
> logical device is registered userspace can connect to it (actually it
> is the next step and will be implemented after ability to handle
> several main SuperIO logical modules) using either ioctl or netlink
> but again only through main module - with such approach we can control
> any data/control flow only in one place and do not disperse efforts.

What's the idea behind logical device registration? I don't see how this
is needed. The reason why a superio driver is needed, as I understand
it, is to handle concurrent accesses to 0x2E/0x2F. This means that all
we really need is:

* Super-I/O detection.
* Read and write functions (specifying a logical device and a register)
* User-space interface to read and write.

Anything above that may be discussed but isn't strictly needed. I
wouldn't mind shortcut functions for retrieving the logical device I/O
address or activating the logical device, but these are really only
read and write functions.

I don't even see the need of having a structure for logical devices.

Could you please explain what benefit your approach offers? I may be
missing something.

Greg, I much would like to hear you about this.

> > > static int sc_activate_one_logical(struct sc_dev *dev, struct
> > > logical_dev *ldev)(...)
> > > static void sc_activate_logical(struct sc_dev *dev)
> > 
> > I doubt that the second one will ever be needed. There's no point in
> > arbitrary activating all logical devices at once, is there? Ditto
> > for deactivating.
> 
> Now it even is not called from any place. It was usefull when all
> logical devices lived with main driver in one file and we registered
> all at once.

Registering is one thing (even if I don't much get the interest at this
point), activating is one other. Registering is a software, lernel
internal action. Activating may have hardware consequences. If the
functions are really about registering, they should be renamed. If they
are about activating, then doing this on all logical devices at once
doesn't make any sense and a function that does so shouldn't even exist.

> > You handling of base is complex without a reason. If __base is set,
> > do base_addr[0] = __base and sz = 1. If it isn't, sz > > sizeof(base_addr)/sizeof(base_addr[0]) (unchanged). Then you don't
> > have to care about it in the for loop:
> 
> base_addr is global and may be accessed later.
> And it do will be accessed when I create ability to dynamically add
> and remove main SuperIO "logical" modules(like with situation when we
> have two of them in one board).

Hm OK I see the idea now. The function may be called more than once, and
my method will make the second call (possibly) fail. I admit it's no
good. Forget about my proposal.

> > base+size is really base+size-1. And actually size could go away and
> > it would be base+1. Again, it's standard. I wouldn't even print it
> > as"0x%x/0x%x". Super-I/O have a couple addresses by nature, not an
> > I/O range (although this translates into a 2-address range in the
> > end).
> 
> Sure, it should be base+size-1, but if it is not PC8736* but for
> example SC1100 we must request more than 2 bytes at a time, because of
> such chips I've added size parameter.

If the SC1100 does live at different addresses and uses a different
number of I/O ports, I start wondering the point in having a common
driver. What are the common points between regular Super-I/O chips and
the SC1100? Care to explain how the SC1100 works?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
