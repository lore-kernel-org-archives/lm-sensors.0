From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 08:40:49 +0000
Subject: Re: [lm-sensors] [ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
Message-Id: <4690A311.3090407@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

Jim Cromie <jim.cromie at gmail.com> Wrote:

 > this patch set
 >
 > 01 - adds superio_locks -
 >
 > drivers needing superio access register, and get a 'slot'with port-id
 > info and a mutex,
 > multiple drivers share the same 'slot', and coordinate access with its
 > mutex.
 >
 >     superio_find()     - finds and reserves the slot, returned as ptr or
null
 >     superio_release()  - relinguishes the slot (ref-counted)
 >
 > Once theyve got the reservation in struct superio * gate (as done in
 > patches 2,3,4)
 > they *may* use
 >
 >     superio_lock(gate)
 >     superio_inb(gate, addr),
 >     superio_outb(gate, addr, val)
 >
 > or they can do it themselves with inb/outb, and gate->sioaddr, etc.
 > My objective was to be as
 >
 > superio_find was chosen to fit the idiom used in hwmon/*.c

I noticed on Mark's kernel todo list that this patch needed someone to review 
it. But first lets discuss the API for this, I'm hoping for some input from 
others (Jean, Mark) here, once the API is ok-ed I can review this.

Personally I would like to see the following changes to the API:

1) Make the cmdreg_addrs and device_ids members of the superio_search struct 
fixed size arrays instead of pointers, using [2] for cmdreg_addrs and [8] for 
device_ids, stopping at a 0 addr/id or end of array.

This way code like this:

static u16 cmd_addrs[] = { 0x2E, 0x4E, 0 };
static u16 devid_vals[] = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };

static struct superio_search where = {
	.cmdreg_addrs = cmd_addrs,
	.device_ids   = devid_vals,
	.devid_addr   = SIO_DEVID,
	.devid_mask   = 0,
	.devid_word   = 0,
};

Can be changed into:

static struct superio_search where = {
	.cmdreg_addrs = { 0x2E, 0x4E},
	.device_ids   = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 },
	.devid_addr   = SIO_DEVID,
	.devid_mask   = 0,
	.devid_word   = 0,
};

Also the superio_search structs in the using drivers should be declared on the 
stack as they are not needed anymore after the superio_find call.

2) make superio_find return the device_id which was found through a by 
reference param, this way drivers who support multiple id's do not need to read 
the device_id registers again, but can use the returned value.

3) move superio_select from the drivers to the superio code.


 > CAVEATS
 > - see 4
Explain?

 > - Ive not thought much about the 16-bit device-id check
     ( I need hardware to sharpen this focus )
I can check that on / with the f71882fg

 > - superio_get() feels clumsy.
It looks fine to me

 > - superio_{enter,exit} are no-ops on my natsemi chip, so again the code
 > is {}
 >
 > the prob is (of course) that every chip does it differently,
 > and superio_locks shouldnt care.  Probably best to drop them
 > from superio-locks API, and expect drivers to do them themselves.

I think its fine to leave any additional handshaking to the drivers, besides 
that, as you say with this locking that won't be necessary anymore.

 > - no device knowledge (digression - for later)
 >
 > its tempting to (create another module) to have a Logical-device table,
 > with strings to describe the LDs, etc.  I dont want to dwell on it now,
 > except to avoid foreclosing design options by bad choices now (in
 > superio_locks).
 >
 > struct sio_logical_device pc87366_units[] = {
 >        { 8,    "Floppy Disk Controller (FDC)" },
 >        { 8,    "Parallel Port (PP)" },         /* also 6 more at 0x400 */
 >        { 8,    "Serial Port 2 with IR (SP2)" },
 >       ...
 >
 > I suspect that a pointer field in struct superio could
 > carry whatever info a notional pc8736x_sio.ko would need,
 > but might pose some reclamation issues.
 >
 > such a module should support interrogating the LD's config-regs,
 > extracting ISA addresses, etc, and could for example, add a bit
 > more detail for display in /proc/ioports, which currently shows:

Why all this trouble ? Remember most superio devices are already in 
/proc/ioports with proper descriptions through there resp. drivers, for example 
floppy, serial, parallel_pc, kbd, etc.

I can see added value in a get superio_get_base_address(gate, logical_device, 
base_address_no) function, but I think more then that is more trouble then its 
worth. Its important here to realize that most superio logical devices are 
being driven by legacy drivers and that those drivers do not care (and should 
not need to care) wether the legacy device is in an lpc connected superio, or 
truely on the isa bus.

Regards,

Hans




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
