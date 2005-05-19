From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <1093259309.21197.152.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2004-08-22 at 12:48, Jean Delvare wrote:
> > > > #define SIO_LDN_GPIO		0x07	/* General-Purpose I/O (GPIO) Ports */
> > > 
> > > This is PC87366-specific and doesn't belong to that driver.
> > 
> > No, I think it just should be extended and include any other
> > defines(for temperature, voltage and others). Although they may live
> > in drivers for those logical devices. Driver for PC87366 may use it...
> > I will move it there after it will be created (actually separated to
> > support several main SuperIO chips at once).
> 
> I'm not sure I get everything you mean here (especially the last
> sentence). At any rate, the logical device usage is
> manufacturer-dependant and, in most cases, chip dependant. And when two
> different chips each have a logical device for, say, temperature
> monitoring, the way it is organized "inside" each logical device will be
> different. So there's no benefit in adding labels or classes to each
> logical device of each chip, since we will never be able to use them.
> 
> I insist that the superio driver should be mostly chip-independant. The
> only part which will not be is the Super-I/O enter sequence. Since the
> PC8736x chips don't need any, you may not be familiar with it. Most
> Super-I/O chips need a special sequence to be written to them before
> they activate. Since the superio driver won't know what it is looking
> for before it finds it, it'll probably have to test all known keys, then
> the client driver will ask not only for a given chip ID but for a key +
> chip ID pair. This also means that you will have to store the (variable
> length) key in the superio structure.

I'm absolutely agree here.
I mean above that when I will split sc.c into generic part and pc8736*
part I will move those definitions into the header for pc8736* driver.

Hm, if I understood you correctly you propose following design:
each superio chip has it's own driver each of which can be connected to
the main superio driver, but inside it will not have different logical
devices, only one monolithic module which handles all them at once.

The main idea about logical devices was that we need a simple set of
cubes(logical devices) and a table(superio chip's driver) and can create
any set of functionality we need.

Logical device GPIO in SC1100 is very similar with PC87366 one.
I even think that _any_ GPIO logical device in any SuperIO chip works
only in following way:
pin_select();
read_value();

Where pin_select() is
	write(base + index_reg, pin_select_reg_number);
	read(base + data_reg);

So if we create logical device GPIO which will get from main driver(from
main SuperIO module, which in turn will get it from chip specific
driver(like pc87366, sc1100)) those registers it becomes to work.

> > > > struct logical_dev
> > > > {
> > > > (...)
> > > >	int			(*activate)(void *);
> > > >	u8			(*read)(void *, int);
> > > >	void			(*write)(void *, int, u8);
> > > >	void			(*control)(void *, int, u8, u8);
> > > > };
> > > 
> > > Please give the function parameters names in your prototypes.
> > > Without them, the prototype is useless to us humans (although the
> > > compiler is perfectly happy without them).
> > 
> > Actually I always remove names from prototypes, since I think
> > prototypes are needed not for detailed explanation of appropriate
> > function but only for overall design view...
> 
> You probably miss the target then. In the above example, I can easily
> imagine what the activate, read and write member functions are for (left
> apart the fact that I wonder what the void * is for), but I just cannot
> guess what the control member function is for. Anonymous parameters
> don't help. At any rate, other kernel headers seem to include parameters
> names in their functions declarations.

->control() is for control logical device - one may enable/disable
logical device, turn on/off additional functionality et cetera using
this function.

I'm not insist on removing parameters name, I just do not understand why
they are needed there. :)

> 
> While we're at it, I start wondering why you need these callback
> functions here. Is the client not supposed to just call sc_read_reg and
> sc_write_reg? I see nothing logical-device-dependent here.

If we want to use read or write function outside the superio module set,
than we either need to know exact name( like
xyz_my_pRiVaTtte_superIo_ChIp_rEaD()) or have to use following chain:
->superio->logical_dev->read().
Or something like that...
So superio module will export common logical device structure which have
pointers to it's private functions and we may just call it.
Example of such behaviour is timer function(sc_timer_func()) in sc.c -
it is for testing and will definitely be removed.
External driver will get pointer to the logical device using
sc_{get,put}_ldev();

> > sc_{add,del}_logical_dev() links and unlinks logical device from the
> > main SuperIO module. After being added any logical device becomes
> > visible for the external world, but it should be accessed only through
> > main module using sc_{get,put}_ldev, which also increment/decrement
> > is's usage counter and may implement additional functionality. When
> > logical device is registered userspace can connect to it (actually it
> > is the next step and will be implemented after ability to handle
> > several main SuperIO logical modules) using either ioctl or netlink
> > but again only through main module - with such approach we can control
> > any data/control flow only in one place and do not disperse efforts.
> 
> What's the idea behind logical device registration? I don't see how this
> is needed. The reason why a superio driver is needed, as I understand
> it, is to handle concurrent accesses to 0x2E/0x2F. This means that all
> we really need is:
> 
> * Super-I/O detection.
> * Read and write functions (specifying a logical device and a register)
> * User-space interface to read and write.
> 
> Anything above that may be discussed but isn't strictly needed. I
> wouldn't mind shortcut functions for retrieving the logical device I/O
> address or activating the logical device, but these are really only
> read and write functions.
> 
> I don't even see the need of having a structure for logical devices.
> 
> Could you please explain what benefit your approach offers? I may be
> missing something.

As I described above we will not have code duplication and will have
ability to add/remove logical devices in run-time.

> Greg, I much would like to hear you about this.

I think we will come to logical conclusion when he will back from
vocation.
Or not.

``Quod erat demonstrandum'' wise latins would often say finishing
discussion with a scuffle :)

> > > > static int sc_activate_one_logical(struct sc_dev *dev, struct
> > > > logical_dev *ldev)(...)
> > > > static void sc_activate_logical(struct sc_dev *dev)
> > > 
> > > I doubt that the second one will ever be needed. There's no point in
> > > arbitrary activating all logical devices at once, is there? Ditto
> > > for deactivating.
> > 
> > Now it even is not called from any place. It was usefull when all
> > logical devices lived with main driver in one file and we registered
> > all at once.
> 
> Registering is one thing (even if I don't much get the interest at this
> point), activating is one other. Registering is a software, lernel
> internal action. Activating may have hardware consequences. If the
> functions are really about registering, they should be renamed. If they
> are about activating, then doing this on all logical devices at once
> doesn't make any sense and a function that does so shouldn't even exist.

Those function was used after all devices were logically registered and
then all we "hardware" activated.
In old version they were at one place and it was more convenient to
register them all at once and then to activate them all at once.

You right that it is deprecated now and not needed. I just explain why
it was there.

> > > base+size is really base+size-1. And actually size could go away and
> > > it would be base+1. Again, it's standard. I wouldn't even print it
> > > as"0x%x/0x%x". Super-I/O have a couple addresses by nature, not an
> > > I/O range (although this translates into a 2-address range in the
> > > end).
> > 
> > Sure, it should be base+size-1, but if it is not PC8736* but for
> > example SC1100 we must request more than 2 bytes at a time, because of
> > such chips I've added size parameter.
> 
> If the SC1100 does live at different addresses and uses a different
> number of I/O ports, I start wondering the point in having a common
> driver. What are the common points between regular Super-I/O chips and
> the SC1100? Care to explain how the SC1100 works?

sc1100 is a system-on-chip processor which has integrated superio
system.
Although AMD did not gave me spec(it's theirs fault), I have
documentation.
SuperIO chip there contains serial port, IR port, RTC, system wakeup
control and two AccessBUSes.
Although GPIO does not live in SuperIO module but in Core Logic module
it will enter into design quite good.

> 
> Thanks.
-- 
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040823/c756b448/attachment.bin
