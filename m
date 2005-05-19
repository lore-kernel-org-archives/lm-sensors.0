From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <1080913517.2859.116.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[ I didn't receive your answer directly, so answering after copy-pasting
from web archive. Sorry for thread brokeing. ]

On Fri, 2004-04-02 at 17:03, Greg KH wrote:
> On Fri, Apr 02, 2004 at 01:24:53AM +0400, Evgeniy Polyakov wrote: 
> > Here is driver implementing the most interesting IMHO parts of Dallas
> > 1-wire protocol for linux kernel 2.6.
> 
> Nice, but can you send this in patch form?  That's necessary if you want
> this added to the kernel tree.

I know about patch, and when all questions be resolved i definetely will
do it.

> > It supports search/reset/read temperature and prowides API like i2c
> > layer does.
> > Since i only have 18s20 termometer driver provides only
> > temperature reading. Obviously it is easy to report alarms,
> > writing/reading eeprom and so on with created 1-wire framework.
> > 
> > For testing i soldered ddc pin in my matrox g400 card to termometer's
> > data pin and used this pin in GPIO mode. 
> > Strong pull-up was got from harddrive +5V.
> > 
> > Read/write GPIO bits primitives are written and described in
> > matrox_w1.c.
> > Great thanks to Petr Vandrovec <VANDROVE@vc.cvut.cz> for explaining some
> > bits of his matrox_fb driver, GPIO and I2C.
> > 
> > The basic schema is following:
> > wire.ko - provides general 1-wire API, netlink logging of search
> > process(can be easily extended to log any other 1-wire events), sysfs
> > processing and so on.
> 
> Why netlink?  What's wrong with just monitoring the sysfs files?

Because sometimes it is not very comfortable to monitor whole sysfs
tree, but very convenient to just get event, wake up and begin
processing.
Since any slave may appear and disappear(slave removing actually not
turned on but only created in a code, since after connecting to DDC pin
1-wire protocol is filled with 90% of DDC video card <-> monitor data
noise and master very frequently losts it's slaves) asynchronously, so
we always need to monitor at least this events. I think netlink is the
best for this kind of events. The whole hotplug is overhead here i
think.
Actually one can poll() master's statistic file and determine what
slaves are connected/disconnected by parsing ascii output, but is think
it is not very convenient.

> I have a few minor comments on the code below:
> 
> > #ifdef MATROX_W1_DEBUG
> > #define log(f, a...) printk(KERN_DEBUG "matrox_w1: " f, ## a)
> > #define loga(f, a...) printk(f, ## a)
> > #else
> > #define log(f, a...)
> > #define loga(f, a...)
> > #endif
> 
> Stick to the i2c standard logging functions, dev_printk(), dev_dbg(),
> dev_err() and friends.

Ok, i will replace it.

> > static __inline__ u8 mreadb(unsigned long addr)
> > {
> > #ifdef MEMORY_MAPPED_ACCESS
> > 	return readb(addr);
> > #else
> > 	return inb_p(addr);
> > #endif
> > }
> 
> Ick.  Can you do this a runtime instead?

Actually MEMORY_MAPPED_ACCESS was introduced only for purpose of sharing
those primitives between different low level transport drivers, and i
think we can just delete port mapping access, since now only matrox_w1.c
uses it and only in memory access mode.

> > static int matrox_w1_find_device(struct matrox_device *dev)
> > {
> > 	struct pci_dev *pdev;
> > 	
> > 	pdev = pci_find_device(PCI_VENDOR_ID_MATROX, PCI_DEVICE_ID_MATROX_G400, NULL);
> 
> Do NOT use pci_find_device anymore.  Please use the proper pci api to
> get your driver called with the proper struct pci_dev already set up for
> you.  It's safer that way, and much nicer.  Also, pci_find_device is
> racy and unsafe in many different ways...

Ok, i will replace it.

> > 	if (!pdev)
> > 	{
> 
> Please follow Documentation/CodingStyle for how you place your {}.  You
> do this wrong in a number of places in your code.

Hmm... I know and ... Let's discuss this topic after all technical
questions be resolved. :)

> > static int w1_master_match(struct device *dev, struct device_driver *drv)
> > {
> > 	log("%s: dev=%p, rv=%p\n", __func__, dev, drv);
> > 	return 1;
> > }
> 
> If you are going to create your own type of bus and driver and devices,
> please do it correctly.  But is it really necessary?  Why not just use
> the i2c framework for this?

This was my initial idea too.
But as a first approximation i didn't find easy way to create different
masters("master" not in i2c notation, but "devices" which have the same
transport driver, but for example have different base address). And we
can't control masters/slaves with current i2c stack(for example delete
one slave through ioctl), with current w1 stack we can't do it also but
it is very easy to add(it is in TODO at least).
And actually when i became implementing 1-wire protocol driver i didn't
know about "byte" mode(or what is appropriate name for mode when
"master" only receives data from i2c stack and sends it into the wire
itself through software-defined timeouts(and actually in case of 1-wire
protocol through it's own protocol) and so on, not through hardware i2c
controller).

> > static __inline__ void w1_write_bit(struct w1_master *dev, int bit)
> > {
> > 	if (bit)
> > 	{
> > 		dev->bus_master->write_bit(dev->bus_master->data, 0);
> > 		__udelay(6);
> > 		dev->bus_master->write_bit(dev->bus_master->data, 1);
> > 		__udelay(64);
> 
> Why __udelay()?  Why not udelay()?  That should be the proper way to do
> it.

With long wires we may increase timeouts a bit, although Dallas 1-wire
protocol doesn't permit it.
I think this should be done not in compilation time but in a realtime.

> thanks,

Thank you for reviewing the code and comments.

> greg k-h
-- 
	Evgeniy Polaykov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040402/92056d2a/attachment.bin
