From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 15 Oct 2007 05:04:20 +0000
Subject: [lm-sensors] [ patch .24-rc0 0/5 ] SuperIO locks coordinator
Message-Id: <4712F4D4.4050707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux kernel <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

this patchset (on hwmon-git) re-introduces superio_locks module, 
previously RFC'd here, where I 'borrowed' another thread..

http://marc.info/?l=linux-kernel&m5821759424601&w=2

The module shares out slots/shared-reservations containing
a mutex, so that multiple modules can coordinate access to
the sio-port.

Im crossposting - LKML for more reviewers, lm-sensors for
folks with the hardware and (perhaps) more interest.

If its not too late, please consider for 2.6.24-rc0

01 - adds superio_locks module

User-drivers specify the sio-port characteristics they can support
device-ids, sio-port-addrs, enter & exit sequences, etc in 
a struct superio_search (in __devinit, preferably). 

superio_find() then searches existing slots/shared-reservations 
for a matching sio-port, and returns it if found. 
Otherwize it probes port-addrs, specified by find() user, 
and makes and returns a new reservation.

    superio_find()	finds and reserves the slot, 
			returned as ptr or null
    superio_release()	relinguishes the slot (ref-counted)

Once theyve got the reservation in struct superio * gate 
(as named in patches 2-5) they *may* use

    superio_lock(gate)
    superio_enter/exit(gate)
    superio_inb/w(gate, regaddr),
    superio_outb/w(gate, regaddr, val)

or they can do it themselves with inb/outb, by using gate->sioaddr, etc.

The API names (superio_find etc) were chosen to fit the idiom 
used in hwmon/*.c, patches 2-5 remove the per-user-driver
copies of the superio_*() fns.

I added the module to /drivers/hwmon, mostly cuz thats where
Ive used it - perhaps drivers/isa is better ?


02 - use superio-locks in drivers/hwmon/w83627hf.c

tested on an AMD-Barton mobo.


03 - use superio-locks in drivers/hwmon/pc87360

this driver keeps the slot for only during __init, since it 
only needs the sio-port to read the ISA addresses of the 
Logical Devices in the chip, which are then used exclusively.


04 - use superio-locks in drivers/char/pc8736x_gpio

this driver keeps the slot for the lifetime of the driver 
( __init til __exit ), since the driver needs the sio-port
to change pin configurations.

patches 03,04 were tested on a soekris 4801 a year ago,
the box is currently busy.  Together they sanity-test
the sharing of a reservation with 2 different life-cycles.


05 - use superio-locks in rest of drivers/hwmon/*.c

this patch is compile-tested only, please review for sanity before you 
try running them.  Things to look for - missing superio_release(),
opportunities to use superio_devid(), superio_inw(), etc.


Driver sizes:
without/with DEBUG
   2364     664      96    3124     c34 drivers/hwmon/superio_locks.ko
   2938     664      96    3698     e72 drivers/hwmon/superio_locks.ko

effect on user-driver sizes:
before/after
  12209    4004      36   16249    3f79 drivers/hwmon/pc87360.ko
  12434    4068      36   16538    409a drivers/hwmon/pc87360.ko

I hope this is small enough; per the link, there apparently are 
actual problems (not just theoretical) that this should help with.

OPERATION

The previous thread includes cut-paste from dmesg, from when 
I tested on the soekris.  No point in repasting here..

RANDOM POINTS/CAVEATS

- Ive not tested the 16-bit device-id check (no hardware)

- superio_(enter|exit) and superio(un)?lock are nearly redundant.
The former also sends the active/idle command sequences, with a tiny
overhead when none are needed (forex the pc87360 chip).  One driver
in patch 5 needed a my_superio_enter() due to an odd unlock sequence.

- uses request_region - this might detect a 'rogue' sio-port user
(which requests region, but doesnt use this module).
It did detect a missing superio_release(), which I hacked around
with the paranoid mod-option (easier than rebooting)

- superio-locks.h has static-inline fns, probably not enough
code to do an export for, since >2 sio-ports is probably rare.

- superio_locks may be relevant elsewhere (ACPI ?) 
but I havent thought about them, hwmon seemed like a good testcase.

- implements several defaults (byte-sized devid, ldn-addr=7, 
devid-addr ).  Perhaps more are possible, as long as theres
an override.  I avoided setting the defaults into struct superio_search,
so that it could be const'd.

Please identify those that are standard enough.
This could include #define LPC_* constants, for use in
superio_inb(gate, LPC_LDN), superio_inw(gate, LPC_ISA_ADDR) 
then user drivers could just #define SIO_* for non-standard registers.

- Hans, I think Ive added all your suggestions, thanks.

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
---
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
