From: jimc <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 23:07:46 +0000
Subject: [lm-sensors] [ patch 3/4 RFC for 2.6.23-rc0 ] use superio-locks in
Message-Id: <4671CA42.9020703@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040404040608050102020407"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404040608050102020407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


use superio-locks in hwmon/pc87360


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

---

[jimc@harpo mylocks]$ diffstat diff.locks-superio-usein-pc87360
  Kconfig   |    2 +
  pc87360.c |   78 
++++++++++++++++++++++++++++----------------------------------
  2 files changed, 38 insertions(+), 42 deletions(-)


--------------040404040608050102020407
Content-Type: text/plain;
 name="diff.locks-superio-usein-pc87360"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.locks-superio-usein-pc87360"

diff -ruNp -X exclude-diffs locks-1/drivers/hwmon/Kconfig locks-2/drivers/hwmon/Kconfig
--- locks-1/drivers/hwmon/Kconfig	2007-06-13 12:05:30.000000000 -0600
+++ locks-2/drivers/hwmon/Kconfig	2007-06-13 12:06:00.000000000 -0600
@@ -354,6 +354,7 @@ config SENSORS_LM87
 	tristate "National Semiconductor LM87"
 	depends on I2C
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for National Semiconductor LM87
 	  sensor chips.
@@ -407,6 +408,7 @@ config SENSORS_MAX6650
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get access to the hardware monitoring
 	  functions of the National Semiconductor PC8736x Super-I/O chips.
diff -ruNp -X exclude-diffs locks-1/drivers/hwmon/pc87360.c locks-2/drivers/hwmon/pc87360.c
--- locks-1/drivers/hwmon/pc87360.c	2007-06-13 10:28:01.000000000 -0600
+++ locks-2/drivers/hwmon/pc87360.c	2007-06-13 12:06:00.000000000 -0600
@@ -41,6 +41,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
+#include <linux/superio-locks.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
@@ -68,6 +69,17 @@ MODULE_PARM_DESC(init,
 #define ACT	0x30	/* Register: Device activation */
 #define BASE	0x60	/* Register: Base address */
 
+u16 cmdreg_addrs[] = { 0x2E, 0x4E, 0 };
+u16 device_ids[]   = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmdreg_addrs,
+	.device_ids   = device_ids,
+	.devid_addr   = DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 0,
+};
+
 #define FSCM	0x09	/* Logical device: fans */
 #define VLM	0x0d	/* Logical device: voltages */
 #define TMS	0x0e	/* Logical device: temperatures */
@@ -77,24 +89,6 @@ static const u8 logdev[3] = { FSCM, VLM,
 #define LD_IN		1
 #define LD_TEMP		2
 
-static inline void superio_outb(int sioaddr, int reg, int val)
-{
-	outb(reg, sioaddr);
-	outb(val, sioaddr+1);
-}
-
-static inline int superio_inb(int sioaddr, int reg)
-{
-	outb(reg, sioaddr);
-	return inb(sioaddr+1);
-}
-
-static inline void superio_exit(int sioaddr)
-{
-	outb(0x02, sioaddr);
-	outb(0x02, sioaddr+1);
-}
-
 /*
  * Logical devices
  */
@@ -817,17 +811,22 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
  * Device detection, registration and update
  */
 
-static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(unsigned short *addresses)
 {
 	u16 val;
-	int i;
-	int nrdev; /* logical device count */
+	int i, nrdev; /* logical device count */
 
-	/* No superio_enter */
+	struct superio* const gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+	devid = gate->devid;		/* Remember the device id */
 
 	/* Identify device */
-	val = superio_inb(sioaddr, DEVID);
-	switch (val) {
+	switch (devid) {
 	case 0xE1: /* PC87360 */
 	case 0xE8: /* PC87363 */
 	case 0xE4: /* PC87364 */
@@ -838,25 +837,23 @@ static int __init pc87360_find(int sioad
 		nrdev = 3;
 		break;
 	default:
-		superio_exit(sioaddr);
+		superio_exit(gate);
 		return -ENODEV;
 	}
-	/* Remember the device id */
-	*devid = val;
 
 	for (i = 0; i < nrdev; i++) {
 		/* select logical device */
-		superio_outb(sioaddr, DEV, logdev[i]);
+		superio_outb(gate, DEV, logdev[i]);
 
-		val = superio_inb(sioaddr, ACT);
+		val = superio_inb(gate, ACT);
 		if (!(val & 0x01)) {
 			printk(KERN_INFO "pc87360: Device 0x%02x not "
 			       "activated\n", logdev[i]);
 			continue;
 		}
 
-		val = (superio_inb(sioaddr, BASE) << 8)
-		    | superio_inb(sioaddr, BASE + 1);
+		val = (superio_inb(gate, BASE) << 8)
+		    | superio_inb(gate, BASE + 1);
 		if (!val) {
 			printk(KERN_INFO "pc87360: Base address not set for "
 			       "device 0x%02x\n", logdev[i]);
@@ -866,8 +863,8 @@ static int __init pc87360_find(int sioad
 		addresses[i] = val;
 
 		if (i==0) { /* Fans */
-			confreg[0] = superio_inb(sioaddr, 0xF0);
-			confreg[1] = superio_inb(sioaddr, 0xF1);
+			confreg[0] = superio_inb(gate, 0xF0);
+			confreg[1] = superio_inb(gate, 0xF1);
 
 #ifdef DEBUG
 			printk(KERN_DEBUG "pc87360: Fan 1: mon=%d "
@@ -882,12 +879,12 @@ static int __init pc87360_find(int sioad
 #endif
 		} else if (i==1) { /* Voltages */
 			/* Are we using thermistors? */
-			if (*devid == 0xE9) { /* PC87366 */
+			if (devid == 0xE9) { /* PC87366 */
 				/* These registers are not logical-device
 				   specific, just that we won't need them if
 				   we don't use the VLM device */
-				confreg[2] = superio_inb(sioaddr, 0x2B);
-				confreg[3] = superio_inb(sioaddr, 0x25);
+				confreg[2] = superio_inb(gate, 0x2B);
+				confreg[3] = superio_inb(gate, 0x25);
 
 				if (confreg[2] & 0x40) {
 					printk(KERN_INFO "pc87360: Using "
@@ -903,7 +900,8 @@ static int __init pc87360_find(int sioad
 		}
 	}
 
-	superio_exit(sioaddr);
+	superio_exit(gate);
+	superio_release(gate);	/* not needed for any post-load operations */
 	return 0;
 }
 
@@ -1449,12 +1447,8 @@ static int __init pc87360_init(void)
 	int err, i;
 	unsigned short address = 0;
 
-	if (pc87360_find(0x2e, &devid, extra_isa)
-	 && pc87360_find(0x4e, &devid, extra_isa)) {
-		printk(KERN_WARNING "pc87360: PC8736x not detected, "
-		       "module not inserted.\n");
+	if (pc87360_find(extra_isa))
 		return -ENODEV;
-	}
 
 	/* Arbitrarily pick one of the addresses */
 	for (i = 0; i < 3; i++) {

--------------040404040608050102020407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040404040608050102020407--
