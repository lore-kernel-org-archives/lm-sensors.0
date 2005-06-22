From: jcromie@divsol.com (Jim Cromie)
Date: Wed, 22 Jun 2005 20:13:49 +0000
Subject: [lm-sensors] Re: Qs on chips/pc87360
Message-Id: <42B9AA2F.9070103@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B97A75.3060503@divsol.com>
In-Reply-To: <42B97A75.3060503@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> <I wrote, snipped>
>
>The real problem here is that this driver should NOT belong to the i2c
>subsystem at all. It drives Super-I/O chips, not I2C chips. The problem
>is that the current kernel code doesn't allow for hardware monitoring
>drivers not to rely on the i2c subsystem. There are plans to change that
>soon, but it promises to take some time.
>  
>
more background later ?

>That being said, you will notice that the pc87360 driver only accesses
>the Super-I/O space when you load it. The semaphores protect the
>hardware monitoring I/O ranges, NOT the Super-I/O space, this is
>different. The Super-I/O space is not protected (which is not exactly
>fine, but happens to work as long as the only accesses are from the init
>section of the driver).
>
>  
>
ok - thats clearer.

in sc200_gpio, reconfiguring the pins is done by writing to the 
device-files, so
is exposed to user-space, and can be done anytime.  Presuming I keep the 
same
interface (I planned to do so), pc87366_gpio would also.  Not that this 
changes
anything.


>So you could add and export a semaphore protecting the Super-I/O range,
>but this would make it impossible for anyone to use your GPIO driver
>without loading the hardware monitoring driver. Better would be to have
>a common driver for the Super-I/O access, which both the GPIO and the
>hardware monitoring drivers would rely on. 
>
hmm.  Ive already worked up a patch which moved your locks into a 
sio-lock module,
which EXPORT_SYMBOL'd  them, and extern'd them in your module, and mine. 
Im not sending it, cuz as you pointed out, your locks arent protecting 
what I thought they were.

BTW - why semaphores, and not read-write locks ? (parrotting a question 
asked
of me on kernelnewbies, where I posted the patch for comments)

this approach seems a good middle ground - not too complex, not too distant
from what Ive already done.  So, let me outline a 1st-look approach,
please shoot it if hideous:

struct semaphore*  sio_chip_present ( unsigned command_addr,
                                        unsigned dev_id_addr,
                                        unsigned dev_id_value )

returns 0 if using command-addr & command_addr +1,
    the device-id value is not found at the device id address.
otherwize  
    kallocs a lock for that command-addr
    or returns existing one if already created
    ( locks can be allocated on heap, yes ? )

thereafter, users try each combo of 3 args they might expect
    ( 2 combos for pc87366: [2e,4e] and e9,
      10 combos for pc87360:  [2e,4e ] X [ e1, e8, e4, e5, e9 ] )

If they get a non-null addr returned, they should lock each access with it.
ie, they should lock, use, unlock.

pls substitute $lock for semaphore as appropriate.

Well - I went and tried that - it seemed worth a strawman at least.
(which is what it is, attached).  In particular, it doesnt attempt to:

1. test for previously fetched locks.  In perl Id use a hash for this, 
are there
hash functions in the kernel I should use ?  A hash is arguably overkill,
its realistic to think that there are < 10 sio devices in any system, which
is easy to test linearly.  Still, I dont like arbitrary limits like that.

2. have any drop_lock to match the  get-lock done by sio_chip_present.
I need new/better names for these..

Im starting to work on a hopefully-working version, but am sending this
in case now to see if its soo blooody ugly that it needs to die now.
 

>Yet another approach would be
>to have a generic Super-I/O subsystem which would take care of the
>problem for all Super-I/O chips. 
>
I gather from the '66 pdf that sio cmd&data are either at 2e&2f or 4e&4F.
the sc-1100 has its own sio, at either 2e&2f or 15c&15d.  My board,
which has both chips, uses 2e for the '66, so (I presume) must use 15c 
for the sc-1100.

>Evgeniy Polyakov is working on this
>(although in a much more complex way I would have suggested). I don't
>know the current status though.
>
>  
>
the kernel-connector stuff right ?  It made it into 12-rcX-mmY,
but I only know what I read on LWN.

Have you outlined your simpler counter-proposal ?
I didnt find it at gmane.org, searching for
'superio' by 'delvare'

-------------- next part --------------
diff -ruN -X exclude-diffs linux-2.6.12-soekris/drivers/char/Makefile i2c/drivers/char/Makefile
--- linux-2.6.12-soekris/drivers/char/Makefile	2005-06-18 07:04:14.000000000 -0600
+++ i2c/drivers/char/Makefile	2005-06-21 12:04:41.000000000 -0600
@@ -12,6 +12,8 @@
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-y				+= misc.o
+obj-m				+= sio_lock.o
+
 obj-$(CONFIG_VT)		+= vt_ioctl.o vc_screen.o consolemap.o \
 				   consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE)	+= vt.o defkeymap.o
diff -ruN -X exclude-diffs linux-2.6.12-soekris/drivers/char/sio_lock.c i2c/drivers/char/sio_lock.c
--- linux-2.6.12-soekris/drivers/char/sio_lock.c	1969-12-31 17:00:00.000000000 -0700
+++ i2c/drivers/char/sio_lock.c	2005-06-22 11:19:59.000000000 -0600
@@ -0,0 +1,60 @@
+
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <asm-i386/semaphore.h>
+
+MODULE_AUTHOR("Jim Cromie");
+MODULE_LICENSE("Dual BSD/GPL");
+
+/** 
+    struct semaphore* sio_chip_present() uses the command-addr given,
+    and tests for the presence of the device-id word (typically byte)
+    at that location.
+
+    returns 0 if using command-addr & command_addr +1,
+    the device-id value is not found at the device id address.
+otherwize  
+    kallocs a lock for that command-addr
+    or returns existing one if already created
+    ( locks can be allocated on heap, yes ? )
+
+    
+*/
+
+//static DEFINE_SPINLOCK(sio_lock);
+
+struct semaphore* sio_chip_present ( unsigned command_addr,
+				     unsigned dev_id_addr,
+				     unsigned dev_id_value )
+{
+  // for moment, just test that kmalloc of a lock works.
+  struct semaphore* lockaddy;
+  lockaddy = (struct semaphore*) kmalloc(sizeof(struct semaphore),
+					 GFP_KERNEL);
+
+  return lockaddy;
+}
+
+
+int sio_lock_init_module(void)
+{
+  printk(KERN_NOTICE "sio_lock_init_module\n");
+  return 0;
+}
+
+void sio_lock_cleanup_module(void)
+{
+  printk(KERN_NOTICE "sio_lock_cleanup_module\n");
+}
+
+EXPORT_SYMBOL(sio_chip_present);
+
+module_init(sio_lock_init_module);
+module_exit(sio_lock_cleanup_module);
+
+
+
diff -ruN -X exclude-diffs linux-2.6.12-soekris/drivers/i2c/chips/pc87360.c i2c/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-soekris/drivers/i2c/chips/pc87360.c	2005-06-18 07:04:21.000000000 -0600
+++ i2c/drivers/i2c/chips/pc87360.c	2005-06-22 11:29:53.000000000 -0600
@@ -1307,10 +1307,26 @@
 	return data;
 }
 
+extern struct semaphore* sio_chip_present(unsigned, unsigned, unsigned);
+
 static int __init pc87360_init(void)
 {
 	int i;
 
+
+	struct semaphore* sio_lock;
+
+	sio_lock = sio_chip_present(0x2e, DEVID, 0xE9);
+
+	if (!sio_lock) {
+	  printk(KERN_WARNING "pc87360: PC8736x sio not detected, "
+		       "module not inserted.\n");
+		return -ENODEV;
+	} else {
+	  printk(KERN_WARNING "pc87360: PC87366 found, "
+		       "be sure to lock and unlock sio access.\n");
+	}
+
 	if (pc87360_find(0x2e, &devid, extra_isa)
 	 && pc87360_find(0x4e, &devid, extra_isa)) {
 		printk(KERN_WARNING "pc87360: PC8736x not detected, "
