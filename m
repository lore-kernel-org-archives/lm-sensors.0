From: jimc <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 22:54:55 +0000
Subject: [lm-sensors] [ patch 1/4 RFC for 2.6.23-rc0 ] add superio-locks to
Message-Id: <4671C73F.8000904@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060502030000030905020400"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060502030000030905020400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

01 - adds superio_locks -

drivers needing superio access register, and get a 'slot' with port-id
info and a mutex,multiple drivers share the same 'slot', and coordinate 
access with its mutex.

   superio_find() - finds and reserves the slot, returned as ptr or null
   superio_release()  - relinguishes the slot (ref-counted)

Once theyve got the reservation in struct superio * gate (as done in
patches 2,3,4) they *may* use

     superio_lock(gate)
     superio_inb(gate, addr),
     superio_outb(gate, addr, val)



Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

---

[jimc@harpo mylocks]$ diffstat diff.locks-superio
  drivers/hwmon/Kconfig         |   10 ++
  drivers/hwmon/Makefile        |    1
  drivers/hwmon/superio_locks.c |  210 
++++++++++++++++++++++++++++++++++++++++++
  include/linux/superio-locks.h |   71 ++++++++++++++
  4 files changed, 292 insertions(+)

--------------060502030000030905020400
Content-Type: text/plain;
 name="diff.locks-superio"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.locks-superio"

diff -ruNp -X exclude-diffs locks-0/drivers/hwmon/Kconfig locks-1/drivers/hwmon/Kconfig
--- locks-0/drivers/hwmon/Kconfig	2007-06-13 10:28:00.000000000 -0600
+++ locks-1/drivers/hwmon/Kconfig	2007-06-13 12:05:30.000000000 -0600
@@ -342,6 +342,7 @@ config SENSORS_LM85
 	tristate "National Semiconductor LM85 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for National Semiconductor LM85
 	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
@@ -649,4 +650,13 @@ config HWMON_DEBUG_CHIP
 	  a problem with I2C support and want to see more of what is going
 	  on.
 
+config SUPERIO_LOCKS
+	tristate "Super-IO port sharing"
+	default n
+	help
+	  this module provides locks for use by drivers which need to
+	  share access to a multi-function device via its superio port, 
+	  and which register that port.
+
 endif # HWMON
+
diff -ruNp -X exclude-diffs locks-0/drivers/hwmon/Makefile locks-1/drivers/hwmon/Makefile
--- locks-0/drivers/hwmon/Makefile	2007-06-13 09:49:44.000000000 -0600
+++ locks-1/drivers/hwmon/Makefile	2007-06-13 12:05:30.000000000 -0600
@@ -63,3 +63,4 @@ ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
 
+obj-$(CONFIG_SUPERIO_LOCKS)	+= superio_locks.o
\ No newline at end of file
diff -ruNp -X exclude-diffs locks-0/drivers/hwmon/superio_locks.c locks-1/drivers/hwmon/superio_locks.c
--- locks-0/drivers/hwmon/superio_locks.c	1969-12-31 17:00:00.000000000 -0700
+++ locks-1/drivers/hwmon/superio_locks.c	2007-06-13 15:03:00.000000000 -0600
@@ -0,0 +1,210 @@
+/* 
+   junk to prove cpp working for me
+
+   static char hello[] = "hello ther";
+   
+   pr_debug("sharing port:%x dev:%x users:%d\n",
+  	 gate->sioaddr, gate->devid, gate->users);
+*/
+
+#define DEBUG 1
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/ioport.h>
+#include <linux/superio-locks.h>
+
+// pr_debug("sharing port:%x dev:%x users \n");
+
+
+// #include <linux/err.h>
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com");
+MODULE_LICENSE("GPL");
+
+/*
+ * This module allows multiple driver modules to coordinate their use
+ * of a Super-IO port to control the multiple logical devices behind
+ * it.  Drivers will superio_find() their port, and 2 modules share a
+ * slot containing the lock.
+ */
+static int max_locks = 3;	/* 3 is enough for 90% uses */
+module_param(max_locks, int, 0);
+MODULE_PARM_DESC(max_locks,
+		 " Number of sio-lock clients to serve (default=3)");
+
+static struct superio *sio_locks;
+static int num_locks;
+static struct mutex reservation_lock;
+
+/* superio_get() checks whether the expected SuperIO device is present
+ * at a specific cmd-addr.  Use in loop to scan.
+ */
+static struct superio* superio_get(const struct superio_search * const where,
+				   int ci, int di)
+{
+	int slot, rc, mydevid;
+	struct superio *gate;
+	int cmd_addr = where->cmdreg_addrs[ci];
+	int want_devid = where->device_ids[di];
+
+	/* share any already allocated lock for this cmd_addr, device-id */
+	for (slot = 0; slot < max_locks; slot++) {
+		gate = &sio_locks[slot];
+
+		if (gate->users && cmd_addr == gate->sioaddr
+		    && want_devid == gate->devid) {
+
+			if (gate->users >= 255) {
+				pr_info("too many drivers sharing port %x\n",
+					gate->sioaddr);
+				return NULL;
+			}
+			gate->users++;
+			pr_debug("sharing port:%x dev:%x users:%d\n",
+				gate->sioaddr, gate->devid, gate->users);
+			return gate;
+		}
+	}
+	/* 1st check that cmd-reg remembers the val just written */
+	outb(where->devid_addr, cmd_addr);
+	rc = inb(cmd_addr);
+	if (rc != (where->devid_addr & 0xFF)) {
+		pr_debug("cmd-reg absent at %x\n", cmd_addr);
+		return NULL;
+	}
+	/* read the device-id register(s), using cmd written above */
+	if (!where->devid_word) {
+		mydevid = inb(cmd_addr+1);
+	} else {
+		/* want 16 bit devid, so get it */
+		mydevid = inb(cmd_addr+1) << 8;
+		outb(where->devid_addr+1, cmd_addr);
+		mydevid |= inb(cmd_addr+1);
+	}
+	/* test for the desired device id value */
+	mydevid &= ~ where->devid_mask;
+	if (mydevid != want_devid) {
+		pr_debug("got %x want %x\n", mydevid, want_devid);
+		return NULL;
+	}
+	/* find 1st unused slot */
+	for (slot = 0; slot < max_locks; slot++)
+		if (!sio_locks[slot].users) {
+			gate = &sio_locks[slot];
+			break;
+		}
+	if (slot >= max_locks) {
+		printk(KERN_ERR "No superio-locks left. increase max_locks\n");
+		return NULL;
+	}
+	/* grab the io-port range */
+	if (!request_region(cmd_addr, 2, "superio")) {
+		printk(KERN_ERR "requested region already claimed\n");
+		return NULL;
+	}
+
+	pr_debug("allocating slot %d, addr %x for device %x\n",
+		slot, cmd_addr, want_devid);
+
+	gate->sioaddr = cmd_addr;
+	gate->devid = want_devid;
+	gate->users = 1;
+	num_locks++;
+
+	return gate;
+}
+
+/**
+ * superio_find: - find a superio-port, and reserve it
+ * @search-criterion : device-id addrs, values that driver
+
+ * Description: searches for the specified superio device-id at
+
+
+finds the sio-lock reservation taken previously.
+ */
+
+struct superio* superio_find(const struct superio_search * const where)
+{
+	int ci, di;
+	struct superio* gate = NULL;
+
+	mutex_lock(&reservation_lock);
+	for (ci = 0; where->cmdreg_addrs[ci]; ci++) {
+		for (di = 0; where->device_ids[di]; di++) {
+			
+			gate = superio_get(where, ci, di);
+			if (!gate) {
+				pr_debug("no devid:%x at port:%x\n",
+					where->device_ids[di],
+					where->cmdreg_addrs[ci]);
+			} else
+				goto OUT;
+		}
+	}
+OUT:
+	if (gate)
+		pr_info("found devid:%x port:%x users:%d\n",
+			gate->devid, gate->sioaddr, gate->users);
+
+	mutex_unlock(&reservation_lock);
+	return gate;
+}
+EXPORT_SYMBOL_GPL(superio_find);
+
+/**
+ * superio_release:
+ * @gate : sio-lock reservation
+ * Description: releases the sio-lock reservation taken previously.
+ */
+void superio_release(struct superio* const gate)
+{
+	mutex_lock(&reservation_lock);
+
+	if (gate < &sio_locks[0] || gate >= &sio_locks[max_locks]) {
+		printk(KERN_ERR
+		       " superio: attempt to release corrupted superio-lock"
+		       " %p vs %p\n", gate, &sio_locks);
+		mutex_unlock(&reservation_lock);
+		return;
+	}
+	if (!(--gate->users)) {
+		release_region(gate->sioaddr, 2);
+		pr_debug("releasing last user of superio-port %x\n",
+			gate->sioaddr);
+	}
+
+	mutex_unlock(&reservation_lock);
+	return;
+}
+EXPORT_SYMBOL_GPL(superio_release);
+
+static int superio_locks_init_module(void)
+{
+	int i;
+
+	pr_debug("initializing with %d reservation slots\n", max_locks);
+	sio_locks = kzalloc(max_locks*sizeof(struct superio), GFP_KERNEL);
+	if (!sio_locks) {
+		printk(KERN_ERR "superio: no memory\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < max_locks; i++)
+		mutex_init(&sio_locks[i].lock);
+
+	mutex_init(&reservation_lock);
+	return 0;
+}
+
+static void superio_locks_cleanup_module(void)
+{
+	pr_debug("releasing %d superio reservation slots\n", max_locks);
+	kfree(sio_locks);
+}
+
+module_init(superio_locks_init_module);
+module_exit(superio_locks_cleanup_module);
diff -ruNp -X exclude-diffs locks-0/include/linux/superio-locks.h locks-1/include/linux/superio-locks.h
--- locks-0/include/linux/superio-locks.h	1969-12-31 17:00:00.000000000 -0700
+++ locks-1/include/linux/superio-locks.h	2007-06-13 12:05:30.000000000 -0600
@@ -0,0 +1,71 @@
+#include <linux/mutex.h>
+#include <asm/io.h>
+
+/* Super-IO ports are found in low-pin-count hardware (typically ISA,
+ * any others ?).  They usually provide access to many functional
+ * units, so many drivers must share the superio port.  This struct
+ * provides a lock that allows the drivers to coordinate access to
+ * that port.
+ */
+struct superio {
+	struct mutex lock;	/* lock shared amongst user drivers */
+	u16 sioaddr;		/* port's tested cmd-address */
+	u16 devid;		/* devid found by the registering driver */
+	u16 users;		/* count client drivers */
+};
+
+struct superio_search {
+	u16 * cmdreg_addrs;	/* null terminated */
+	u16 * device_ids;	/* null terminated */
+	u16 devid_addr;		/* addr of LSB of device-id */
+	u16 devid_mask;		/* some devices document this way */
+	u16 devid_word;		/* some devices have 2 byte device id */
+};
+
+struct superio* superio_find(const struct superio_search * const where);
+void superio_release(struct superio* const gate);
+
+/* superio_enter() and superio_exit() were formerly implemented in the
+ * client drivers, and managed the superio port by sending idling &
+ * activation sequences, which differ per device.  However, the
+ * protection was incomplete, since any driver would activate the port
+ * before using it, thus defeating the idling done by another driver
+ * to 'lock' the port.  We therefore claim 'eminent domain', and
+ * re-implment them here to properly manage the mutex.
+ */
+static inline void superio_enter(struct superio * const sio_port)
+{
+	mutex_lock(&sio_port->lock);
+}
+
+static inline void superio_exit(struct superio * const sio_port)
+{
+	mutex_unlock(&sio_port->lock);
+}
+
+/* superio_inb(), superio_outb() are also former client funcs */
+
+static inline int superio_inb(struct superio * const sio_port, u8 reg)
+{
+	outb(reg, sio_port->sioaddr);
+	return inb(sio_port->sioaddr+1);
+}
+
+static inline void superio_outb(struct superio * const sio_port, u8 reg, u8 val)
+{
+	outb(reg, sio_port->sioaddr);
+	outb(val, sio_port->sioaddr+1);
+}
+
+static inline int superio_inw(struct superio * const sio_port, u8 reg)
+{
+	int val;
+
+	outb(reg++, sio_port->sioaddr);
+	val = inb(sio_port->sioaddr) << 8;
+	outb(reg, sio_port->sioaddr);
+	val |= inb(sio_port->sioaddr+1);
+
+	return val;
+}
+

--------------060502030000030905020400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060502030000030905020400--
