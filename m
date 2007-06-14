From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 21:10:16 +0000
Subject: [lm-sensors] [ patch 0/4  RFC for 2.6.23-rc0 ] superio-locks
Message-Id: <4671AEB8.20503@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


this patch set

01 - adds superio_locks -

drivers needing superio access register, and get a 'slot'with port-id 
info and a mutex,
multiple drivers share the same 'slot', and coordinate access with its 
mutex.

    superio_find()     - finds and reserves the slot, returned as ptr or 
null
    superio_release()  - relinguishes the slot (ref-counted)

Once theyve got the reservation in struct superio * gate (as done in 
patches 2,3,4)
they *may* use

    superio_lock(gate)
    superio_inb(gate, addr),
    superio_outb(gate, addr, val)

or they can do it themselves with inb/outb, and gate->sioaddr, etc.
My objective was to be as

superio_find was chosen to fit the idiom used in hwmon/*.c


02 - use it in pc8736x_gpio

this driver keeps the slot for the lifetime of the module ( __init til 
__exit )


03 - uses it in  pc87360

this driver keeps the slot for only during __init, since it only needs to
read the ISA addresses of the Logical Devices in the chip.


04 - use it in rest of drivers/hwmon/*.c

this patch is compile-tested only, please review for sanity before you 
try running them.


OPERATION

Here they are, working on my soekris box
 - with #define DEBUG 1,  and  sysctl -w kernel.printk=8

simple sharing:

soekris:~# modprobe pc8736x_gpio
[  201.308543] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[  201.319118] got e9 want e1
[  201.322297] no devid:e1 at port:2e
[  201.325996] got e9 want e8
[  201.328770] no devid:e8 at port:2e
[  201.332375] got e9 want e4
[  201.335259] no devid:e4 at port:2e
[  201.338847] got e9 want e5
[  201.341728] no devid:e5 at port:2e
[  201.349112] allocating slot 0, addr 2e for device e9
[  201.354345] found devid:e9 port:2e users:1
[  201.371547] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
soekris:~#
soekris:~# modprobe pc87360
[  201.757736] got e9 want e1
[  201.760694] no devid:e1 at port:2e
[  201.764317] got e9 want e8
[  201.767263] no devid:e8 at port:2e
[  201.770899] got e9 want e4
[  201.773669] no devid:e4 at port:2e
[  201.777248] got e9 want e5
[  201.780135] no devid:e5 at port:2e
[  201.783731] sharing port:2e dev:e9 users:2
[  201.788015] found devid:e9 port:2e users:2
[  201.806848] pc87360: Device 0x09 not activated
[  201.827262] pc87360 pc87360.26144: VLM conversion set to 1s period, 
160us delay
soekris:~#



soekris:~# rmmod pc8736x_gpio
[  206.934821] releasing last user of superio-port 2e
soekris:~# rmmod pc87360    

I removed both, but the slot released after the 1st,
because the other module released it at end of init,
and is no longer holding the reservation


soekris:~# modprobe pc87360
[  208.173676] got e9 want e1
[  208.176483] no devid:e1 at port:2e
[  208.180115] got e9 want e8
[  208.183028] no devid:e8 at port:2e
[  208.186625] got e9 want e4
[  208.189515] no devid:e4 at port:2e
[  208.192986] got e9 want e5
[  208.195865] no devid:e5 at port:2e
[  208.203700] allocating slot 0, addr 2e for device e9
[  208.209125] found devid:e9 port:2e users:1
[  208.214555] pc87360: Device 0x09 not activated
[  208.219853] releasing last user of superio-port 2e
[  208.252041] pc87360 pc87360.26144: VLM conversion set to 1s period, 
160us delay
soekris:~#

again, can see init-only usage by driver, and last-release message.


soekris:~# modprobe pc8736x_gpio
[  208.633842] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[  208.643221] got e9 want e1
[  208.646017] no devid:e1 at port:2e
[  208.649634] got e9 want e8
[  208.652566] no devid:e8 at port:2e
[  208.656161] got e9 want e4
[  208.659108] no devid:e4 at port:2e
[  208.662584] got e9 want e5
[  208.665457] no devid:e5 at port:2e
[  208.680637] allocating slot 0, addr 2e for device e9
[  208.685846] found devid:e9 port:2e users:1
[  208.693420] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
soekris:~#

can see here that we're the only holder of that reservation.



CAVEATS

- see 4
- Ive not thought much about the 16-bit device-id check
    ( I need hardware to sharpen this focus )
- superio_get() feels clumsy.

- superio_{enter,exit} are no-ops on my natsemi chip, so again the code 
is {}

the prob is (of course) that every chip does it differently,
and superio_locks shouldnt care.  Probably best to drop them
from superio-locks API, and expect drivers to do them themselves.

Callbacks are possible but pointless, but given that the driver author
must call enter & exit explicitly, they should just call their function 
directly.

- no device knowledge (digression - for later)

its tempting to (create another module) to have a Logical-device table,
with strings to describe the LDs, etc.  I dont want to dwell on it now,
except to avoid foreclosing design options by bad choices now (in 
superio_locks).

struct sio_logical_device pc87366_units[] = {
        { 8,    "Floppy Disk Controller (FDC)" },
        { 8,    "Parallel Port (PP)" },         /* also 6 more at 0x400 */
        { 8,    "Serial Port 2 with IR (SP2)" },
       ...

I suspect that a pointer field in struct superio could
carry whatever info a notional pc8736x_sio.ko would need,
but might pose some reclamation issues.

such a module should support interrogating the LD's config-regs,
extracting ISA addresses, etc, and could for example, add a bit
more detail for display in /proc/ioports, which currently shows:

6008-600d : NatSemi SCx200 High-Resolution Timer
6100-613f : 0000:00:12.0
  6100-612b : NatSemi SCx200 GPIO
6200-623f : 0000:00:12.0
6300-63ff : 0000:00:12.1
6500-653f : 0000:00:12.5
6600-660f : pc8736x_gpio
6620-662f : pc87360
6640-664f : pc87360
  6640-664f : pc87360

I suspect that the multiple pc87360 regions are for the LDs controlled
by hwmon/pc87360, since pc8736x_gpio also shows up (once).
It would be cool if they said which ldn, something like

6620-662f : pc87360.voltages
6640-664f : pc87360.temps
  6640-664f : pc87360.dunno

<aside> Does it look 'right' to you ?


- superio_locks may be relevant elsewhere (ACPI ?) but I havent thought 
about them


WHATS NEXT

- see if any drivers in patch 4 are sane/insane
    probably break 4 into separate patches ..

- get the feedback --> fix the code
- submit formally
     here ? LKML ? other subsystem MLs ?


thanks,
-jimc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
