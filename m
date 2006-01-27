From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 27 Jan 2006 05:47:10 +0000
Subject: [lm-sensors] [patch 0/2] hwmon: add a superio_locks coordinator
Message-Id: <43D9B3DE.3030208@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


this 2 part patch-set adds a superio_locks module to hwmon.
The module makes it simple for a driver using a Super-IO chip
to obtain a shared lock, and thereby coordinate with any other users
of that chip, without knowing who they are.

I went for a simple helper approach:

- provides an array of lock-structs (mod-param sets size),
    which are handed out upon request.

- does *not* search for super-IO ports,
    it expects drivers to know what ports are on the chips theyre 
written for,
    and to request them specifically.
    (forex: pc87360 must be at 2e or 4e)

- supports driver doing the 'search'
    driver makes 1 call to get_superio_gate_any() to:
       check several command-addresses, for several device ids
       save the return value, which is the gate* (locks are in gates)
    assumes data-addr is *always* command-addr + 1

- allocates a lock for 1st requester of a (sio-port,device-id) pair, if 
found
    2nd requester shares that lock.
    ie its a singleton

- doesnt / cannot protect against rogue driver
    (I wouldnt know how)

- drivers are expected to do their own locking, unlocking
   driver chooses efficiency vs long-lock-time

- superio lock structure (gate) is exposed in header
    allow user-drivers to get inside it
    sioaddr and devid are both useful to driver logic.

So, the API:

struct superio_gate {
       struct semaphore sema;  /* lock is here, for no-offset cast */
       int sioaddr;            /* this port's cmd-address */
       int devid;            /* device id found by 1st user */
};
 
struct superio_gate* get_sio_gate(int sioaddr, int devid_addr, int 
devid_val);
struct superio_gate* get_sio_gate_any(u8 sioaddr[], int devid_addr, u8 
devid_val[]);
void sio_lock(struct superio_gate*);
void sio_unlock(struct superio_gate*);
int  sio_inb(struct superio_gate*, int reg);
void sio_outb(struct superio_gate*, int reg, int val );
void sio_exit(struct superio_gate*);


users will do:
    struct superio_gate* gate = get_sio_gate_any( sioaddrs, devid_addr, 
wanted_ids );

and then either:
   superio_lock(gate);
   lock_mutex(&gate->mutex);

Once users have taken the lock, they can use (with some prep in latter 
examples)
   superio_inb(gate->sioaddr);
   superio_inb(mysioaddr);
   sio_inb(gate);
   inb(..)



2nd patch converts pc87360 to use it.   This patch has 2 versions;
    diff.uselocks.alpha-hilock
    diff.uselocks.alpha-lolock

the lolock version puts the lock-unlock pair around the low level routines;
pc87360_write_value, pc87360_read_value.  This is the way to do it
if your priority is short lock times.

the hilock version puts the locking in users of those routines,
which means less locking, but holds the lock much longer,
(thru a full scan of all sensor-attrs)





