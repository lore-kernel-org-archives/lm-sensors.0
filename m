From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <20040821150042.64b7e833@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 Aug 2004 09:30:57 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Evgeniy,

Hi, Jean.
 
> Here are my comments on your code. I'll only comment on the Super-I/O
> part, since I don't know much (and don't really care) about the GPIO
> driver.
> 
> First question, why the name "sc"? We'll have to find a more suitable
> name for the driver. What about simply "superio"?

It was derived from "Soekris" board name since it was initially wrote
for those board. 
It looks like it was bad crack since now I do not see letter "c" in
it's name... Hmmm, maybe it was "Soekris control" or "SuperIO
Control"? :)

> ### sc.h
> 
> > #define SIO_LDN_GPIO		0x07	/* General-Purpose I/O (GPIO) Ports */
> 
> This is PC87366-specific and doesn't belong to that driver.

No, I think it just should be extended and include any other defines(for
temperature, voltage and others). Although they may live in drivers for
those logical devices. Driver for PC87366 may use it... I will move it
there after it will be created(actually separated to support several
main SuperIO chips at once).

> > #define SIO_ACTIVE_EN		0x01	/* enabled */
> > (...)
> > #define LDEV_ACTIVE		(1<<0)
> 
> Aren't these the same thing?

Actually not, the former is register value, the latter is bit in
->flags bitfield.
Although it is not very usefull to create bitfield for one bit, but it
can be exteded to support states for chips that requires several steps
for initialization.

> > #define SIO_GPDO0		0x00
> > #define SIO_GPDI0 		0x01
> > #define SIO_GPEVEN0		0x02 
> > #define SIO_GPEVST0		0x03 
> > #define SIO_GPDO1 		0x04
> > #define SIO_GPDI1 		0x05
> > #define SIO_GPEVEN1		0x06 
> > #define SIO_GPEVST1		0x07 
> > #define SIO_GPDO2 		0x08
> > #define SIO_GPDI2 		0x09
> > #define SIO_GPDO3 		0x0A
> > #define SIO_GPDI3 		0x0B
> 
> Same here, PC87366-specific (I believe) so doesn't belong to that
> driver.

I think I should move them into GPIO driver's header or header for
PC87366 SuperIO module(next step).

> > struct logical_dev
> > {
> > (...)
> >	int			(*activate)(void *);
> >	u8			(*read)(void *, int);
> >	void			(*write)(void *, int, u8);
> >	void			(*control)(void *, int, u8, u8);
> > };
> 
> Please give the function parameters names in your prototypes. Without
> them, the prototype is useless to us humans (although the compiler is
> perfectly happy without them).

Actually I always remove names from prototypes, since I think prototypes
are needed not for detailed explanation of appropriate function but only
for overall design view...

> 
> > void sc_write_reg(struct sc_dev *, u8, u8);
> > u8 sc_read_reg(struct sc_dev *, u8);
> > 
> > int sc_add_logical_dev(struct logical_dev *);
> > void sc_del_logical_dev(struct logical_dev *);
> > struct logical_dev *sc_get_ldev(char *);
> > void sc_put_ldev(struct logical_dev *);
> 
> Ditto.
> 
> At this point, I'd appreciate a detailed explanation of your choices
> of implementation. It looks rather complex to me so the choices are
> not that obvious. I'd simply have provided read and write functions,
> keeping things really simple and low level, while it looks like you
> intend to implement the concept of logical device registration. Why is
> it needed? How is it going to work?
> 
> Please explain what the 6 functions are meant for, and how the three
> different structures will be used.

Sure.

sc_{add,del}_logical_dev() links and unlinks logical device from the
main SuperIO module. After being added any logical device becomes
visible for the external world, but it should be accessed only through
main module using sc_{get,put}_ldev, which also increment/decrement is's
usage counter and may implement additional functionality. When logical
device is registered userspace can connect to it(actually it is the next
step and will be implemented after ability to handle several main
SuperIO logical modules) using either ioctl or netlink but again only
through main module - with such approach we can control any data/control
flow only in one place and do not disperse efforts.

> ### sc.c
> 
> > #include <asm/atomic.h>
> > #include <asm/types.h>
> > #include <asm/io.h>
> 
> > #include <linux/delay.h>
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> > #include <linux/list.h>
> > #include <linux/interrupt.h>
> > #include <linux/spinlock.h>
> > #include <linux/timer.h>
> > #include <linux/slab.h>
> > #include <linux/timer.h>
> > 
> > #include "../w1/w1.h"
> > #include "../w1/w1_int.h"
> > #include "../w1/w1_log.h"
> > 
> > #include "sc.h"
> > #include "sc_gpio.h"
> 
> Wow. I doubt you need all that. At any rate, you should not include
> any device-specific or protocol-specific header here. There's no
> reason you would need them. The superio driver offers an interface to
> the other drivers, not the other way around.

Sure, w1 includes absolutely do not needed there.

> > void sc_write_reg(struct sc_dev *, u8, u8);
> > u8 sc_read_reg(struct sc_dev *, u8);
> > 
> > int sc_add_logical_dev(struct logical_dev *);
> > void sc_del_logical_dev(struct logical_dev *);
> 
> These are already defined in the .h file.

Yep, will remove.

> > static int sc_activate_one_logical(struct sc_dev *dev, struct
> > logical_dev *ldev)(...)
> > static void sc_activate_logical(struct sc_dev *dev)
> 
> I doubt that the second one will ever be needed. There's no point in
> arbitrary activating all logical devices at once, is there? Ditto for
> deactivating.

Now it even is not called from any place. It was usefull when all
logical devices lived with main driver in one file and we registered all
at once.

> > static int sc_chip_id(u8 id)
> 
> This one is supposed to convert an id into an index, isn't it? It
> would better be called sc_chip_index then.

No problem.

> > static int sc_find_device(struct sc_dev *dev, unsigned long __base)
> > {
> > 	unsigned long base;
> > 	unsigned long size = 2;
> > 	int i, sz;
> > 
> > 	if (__base)
> > 	{
> > 		base = __base;
> > 		sz = 1;
> > 	}
> > 	else
> > 	{
> > 		base = 0; /* Make compiler happy */
> > 		sz = sizeof(base_addr)/sizeof(base_addr[0]);
> > 	}
> > 	
> > 	for (i=0; i<sz; ++i)
> > 	{
> > 		u8 id;
> > 		int chip_num;
> > 		
> > 		if (!__base)
> > 			base = base_addr[i];
> > 
> > 		dev->base_index = base;
> > 		dev->base_data = base + 1;
> > (...)
> 
> You handling of base is complex without a reason. If __base is set, do
> base_addr[0] = __base and sz = 1. If it isn't, sz > sizeof(base_addr)/sizeof(base_addr[0]) (unchanged). Then you don't
> have to care about it in the for loop:

base_addr is global and may be accessed later.
And it do will be accessed when I create ability to dynamically add and
remove main SuperIO "logical" modules(like with situation when we have
two of them in one board).

> static int sc_find_device(struct sc_dev *dev, unsigned long base)
> {
> 	unsigned long size = 2;
> 	int i, sz;
> 
> 	if (base)
> 	{
> 		base_addr[0] = base;
> 		sz = 1;
> 	}
> 	else
> 	{
> 		sz = sizeof(base_addr)/sizeof(base_addr[0]);
> 	}
> 	
> 	for (i=0; i<sz; ++i)
> 	{
> 		u8 id;
> 		int chip_num;
> 		
> 		dev->base_index = base_addr[i];
> 		dev->base_data = base_addr[i] + 1;
> 
> How about it?
> 
> BTW, I see no reason why you would want to force the base address. The
> possible addresses are standardized (0x2e/0x2f and 0x4e/0x4f), 99% of
> the case the super I/O is at 0x2e/0x2f. So I wouldn't even bother with
> that parameter.

The may live in PCI space, like SC1100 Geode processor.
It also has SuperIO, and although linux already have driver for it I
will extend SuperIO main driver to support several chips at one time.

> > 		if (chip_num >= 0)
> > 		{
> > 			printk(KERN_INFO "Found %s [0x%x] at
> > 			0x%04lx-0x%04lx.\n", 
> > 					sc_sio_ids[chip_num].name,
> > 					sc_sio_ids[chip_num].id, base, base+size);
> > 			return i;
> > 		}
> > 
> > 		printk(KERN_INFO "Found nothing at 0x%04lx-0x%04lx.\n", base,
> > 		base+size);
> 
> base+size is really base+size-1. And actually size could go away and
> it would be base+1. Again, it's standard. I wouldn't even print it as
> "0x%x/0x%x". Super-I/O have a couple addresses by nature, not an I/O
> range (although this translates into a 2-address range in the end).

Sure, it should be base+size-1, but if it is not PC8736* but for example
SC1100 we must request more than 2 bytes at a time, because of such
chips I've added size parameter.

> I also see that your function wouldn't support a system with two
> similar Super-I/Os at different addresses. I admit it was never seen
> and will probably never be, but since you seem to be wanting to handle
> all cases, that's a strange choice.

It is in my TODO list and wil be implemeted very soon after current
technical problems are resolved.

> As for the rest, it's way above me until you explain what it is
> supposed to do.
> 
> Thanks.

Thank you for review and comments.

> 
> -- 
> Jean "Khali" Delvare
> http://khali.linux-fr.org/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
