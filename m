From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 10 Jun 2006 17:58:22 +0000
Subject: [lm-sensors] [RFC patch 0/2] hwmon: add a superio locks coordinator
Message-Id: <448B083E.3060809@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ooof. 
I just realized this has been sitting in my drafts folder since 5/21.
And I just sent these 2 described patches in a yet older draft response
to Thomas Andrews  :-}

Too many irons in the fire perhaps..

This 2 part patch-set: 
 - adds a superio_locks module to hwmon dir
 - uses it in hwmon/pc87360

The 1st patch makes this an LKML message, 2nd an lm-sensors msg.

SuperIO ports are found on LPC (low pin count) chips, and may have
many (15) functional units behind a 2 IO address resource space.
These units need device drivers, which must coordinate for use of the
shared SuperIO resource.



patch/driver is as simple as possible:

+struct superio {
+       struct mutex lock;      /* lock shared amongst user drivers */
+       int sioaddr;            /* port's tested cmd-address */
+       int devid;              /* devid found by the registering driver */
+};

a singleton: superio_locks.ko, which:

- waits for client drivers to register for a superio port
  a known device-id, at a known devid-addr, via a known command-addr

- 1st client who probes/registers a port that
  tests ok - like a superio command addr should,
  gets a fresh superio struct
	initialized to the just-found cmd addr and devid

- next client registering the same command-addr and devid
  gets the same pointer value as 1st client.
  1st and later clients are equal
  they share the slot, and the lock therein

- they agree not to change sioaddr, devid
  a reasonable interface contract

- they use the lock when they need exclusion
  ie whenever they use the superio,
    typically in sequences of: 
      superio_inb(), superio_outb()
  point is: lock use is *not* lock allocation, which is here.

- clients dont change sioaddr, devid
  a reasonable contract

- no module unregister, 
  We hold memory for shared locks, so we 'own' them,
  therefore, we preclude removal, easy and safe.


The API

struct superio* get_superio(int sioaddr, int devid_addr, int devid_val);
/* arrays are 0 terminated */
struct superio* find_superio(u8 sioaddr[],
                            int devid_addr, u8 devid_val[]);


1. get/find your superio,
	
	struct superio* gate = find_superio(&my_candidate_cmdports,
			                    devid_addr,
					    &supported_devids);

devid_addr is a superio-address, and is 'probed' for the device id
found there.  If we find a supported id at that sioaddr, and the
sioaddr also reads back the devid-addr we just wrote there, we call it
*good*, reserve and return the slot.

find_* is built on get_*, its more convenient.  There may be some
corner cases where the iteration is oversimplified.  Drivers should
iterate over combos of cmdaddrs and devids they are prepared to
support, til they get a port that responds properly to the probe.

2. lock the superio port while using it

  // reach thru the struct to lock and unlock - obvious is good
  mutex_lock($gate->lock);
  do_stuff()
  mutex_unlock($gate->lock);

Driver knows when locks are needed, we dont.

The hwmon/pc87360 driver only uses the superio port during
initialization, so the gate obtained in 1 can even be forgotten after
init.  The 2nd patch doesnt go this far, I plan to look for reuse of
sioaddr and devid in the rest of the driver 1st.


NOTES

module has no unload.  doing so would lose locks promised and shared
amongst possibly multiple drivers.  Module usage counts are unwise
or evil.

just treat the shared superio struct as RO.
	deref to fields, or
	copy values to statics,
	your choice.

SuperIO ports are slow anyway (multiple ISA bus cycles), so a pointer
deref + struct offset is trivial.

0-terminated arrays.  are they OK, or asking for errors?


The IO space is not currently reserved.  This matches history; nobody
has complained about another module seizing the superio.  IOW, the
sharing is happening now, just nothing *bad* has been detected.

So, is there a need / real problem ? 

Yes - at least on paper.  Ive got work-in-progress to peel nsc_gpio.c
out of scx200_gpio.c, then copy and rework the latter into
pc87360_gpio.c.  This last module will need to coordinate at least
once, maybe more.

Also, Ive heard that the pc87360 has a serial port that is used for
com2 on the soekris (ML hearsay)


FutureQ

Consider claiming a 2-byte IO resource for the superIO.  This should
expose rogue users, IFF such intra-kernel barriers are mandatory.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>



