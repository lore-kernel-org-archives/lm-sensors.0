From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 23:02:28 +0000
Subject: [lm-sensors] [ patch 2/4 RFC for 2.6.23-rc0 ] superio-locks in
Message-Id: <4671C904.7070605@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070703010405030407040403"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703010405030407040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



use superio_locks in pc8736x_gpio
this driver keeps the superio reservation for the lifetime of the module
( __init til __exit )


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

---

[jimc@harpo mylocks]$ diffstat diff.locks-superio-usein-pc8736x_gpio
  Kconfig        |    1
  pc8736x_gpio.c |   89 
+++++++++++++++++++++++++--------------------------------
  2 files changed, 41 insertions(+), 49 deletions(-)
[jimc@harpo mylocks]$


--------------070703010405030407040403
Content-Type: text/plain;
 name="diff.locks-superio-usein-pc8736x_gpio"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="diff.locks-superio-usein-pc8736x_gpio"

diff -ruNp -X exclude-diffs locks-2/drivers/char/Kconfig locks-3/drivers/char/Kconfig
--- locks-2/drivers/char/Kconfig	2007-06-13 09:49:40.000000000 -0600
+++ locks-3/drivers/char/Kconfig	2007-06-13 12:06:41.000000000 -0600
@@ -961,6 +961,7 @@ config PC8736x_GPIO
 	depends on X86
 	default SCx200_GPIO	# mostly N
 	select NSC_GPIO		# needed for support routines
+	select SUPERIO_LOCKS
 	help
 	  Give userspace access to the GPIO pins on the National
 	  Semiconductor PC-8736x (x=[03456]) SuperIO chip.  The chip
diff -ruNp -X exclude-diffs locks-2/drivers/char/pc8736x_gpio.c locks-3/drivers/char/pc8736x_gpio.c
--- locks-2/drivers/char/pc8736x_gpio.c	2007-02-04 11:44:54.000000000 -0700
+++ locks-3/drivers/char/pc8736x_gpio.c	2007-06-13 12:06:41.000000000 -0600
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/superio-locks.h>
 #include <asm/uaccess.h>
 
 #define DEVNAME "pc8736x_gpio"
@@ -36,14 +37,22 @@ static DEFINE_MUTEX(pc8736x_gpio_config_
 static unsigned pc8736x_gpio_base;
 static u8 pc8736x_gpio_shadow[4];
 
-#define SIO_BASE1       0x2E	/* 1st command-reg to check */
-#define SIO_BASE2       0x4E	/* alt command-reg to check */
-
-#define SIO_SID		0x20	/* SuperI/O ID Register */
-#define SIO_SID_VALUE	0xe9	/* Expected value in SuperI/O ID Register */
+static struct superio* gate;
 
+#define SIO_DEVID	0x20	/* SuperI/O Device ID Register */
 #define SIO_CF1		0x21	/* chip config, bit0 is chip enable */
 
+static u16 cmd_addrs[] = { 0x2E, 0x4E, 0 };
+static u16 devid_vals[] = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SIO_DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 0,
+};
+
 #define PC8736X_GPIO_RANGE	16 /* ioaddr range */
 #define PC8736X_GPIO_CT		32 /* minors matching 4 8 bit ports */
 
@@ -62,7 +71,6 @@ static u8 pc8736x_gpio_shadow[4];
 #define SIO_GPIO_PIN_CONFIG     0xF1
 #define SIO_GPIO_PIN_EVENT      0xF2
 
-static unsigned char superio_cmd = 0;
 static unsigned char selected_device = 0xFF;	/* bogus start val */
 
 /* GPIO port runtime access, functionality */
@@ -76,35 +84,9 @@ static int port_offset[] = { 0, 4, 8, 10
 
 static struct platform_device *pdev;  /* use in dev_*() */
 
-static inline void superio_outb(int addr, int val)
-{
-	outb_p(addr, superio_cmd);
-	outb_p(val, superio_cmd + 1);
-}
-
-static inline int superio_inb(int addr)
-{
-	outb_p(addr, superio_cmd);
-	return inb_p(superio_cmd + 1);
-}
-
-static int pc8736x_superio_present(void)
-{
-	/* try the 2 possible values, read a hardware reg to verify */
-	superio_cmd = SIO_BASE1;
-	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
-		return superio_cmd;
-
-	superio_cmd = SIO_BASE2;
-	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
-		return superio_cmd;
-
-	return 0;
-}
-
 static void device_select(unsigned devldn)
 {
-	superio_outb(SIO_UNIT_SEL, devldn);
+	superio_outb(gate, SIO_UNIT_SEL, devldn);
 	selected_device = devldn;
 }
 
@@ -112,7 +94,7 @@ static void select_pin(unsigned iminor)
 {
 	/* select GPIO port/pin from device minor number */
 	device_select(SIO_GPIO_UNIT);
-	superio_outb(SIO_GPIO_PIN_SELECT,
+	superio_outb(gate, SIO_GPIO_PIN_SELECT,
 		     ((iminor << 1) & 0xF0) | (iminor & 0x7));
 }
 
@@ -121,19 +103,19 @@ static inline u32 pc8736x_gpio_configure
 {
 	u32 config, new_config;
 
+	superio_enter(gate);
 	mutex_lock(&pc8736x_gpio_config_lock);
 
-	device_select(SIO_GPIO_UNIT);
+	/* read pin's current config value */
 	select_pin(index);
-
-	/* read current config value */
-	config = superio_inb(func_slct);
+	config = superio_inb(gate, func_slct);
 
 	/* set new config */
 	new_config = (config & mask) | bits;
-	superio_outb(func_slct, new_config);
+	superio_outb(gate, func_slct, new_config);
 
 	mutex_unlock(&pc8736x_gpio_config_lock);
+	superio_exit(gate);
 
 	return config;
 }
@@ -259,40 +241,44 @@ static int __init pc8736x_gpio_init(void
 		rc = -ENODEV;
 		goto undo_platform_dev_alloc;
 	}
+	pc8736x_gpio_ops.dev = &pdev->dev;
+
 	dev_info(&pdev->dev, "NatSemi pc8736x GPIO Driver Initializing\n");
 
-	if (!pc8736x_superio_present()) {
+	gate = superio_find(&where);
+	if (!gate) {
 		rc = -ENODEV;
-		dev_err(&pdev->dev, "no device found\n");
+		dev_err(&pdev->dev, "no superio port found\n");
+		// goto err2;
 		goto undo_platform_dev_add;
 	}
-	pc8736x_gpio_ops.dev = &pdev->dev;
 
 	/* Verify that chip and it's GPIO unit are both enabled.
 	   My BIOS does this, so I take minimum action here
 	 */
-	rc = superio_inb(SIO_CF1);
+	superio_enter(gate);
+	rc = superio_inb(gate, SIO_CF1);
 	if (!(rc & 0x01)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "device not enabled\n");
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 	device_select(SIO_GPIO_UNIT);
-	if (!superio_inb(SIO_UNIT_ACT)) {
+	if (!superio_inb(gate, SIO_UNIT_ACT)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO unit not enabled\n");
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 
 	/* read the GPIO unit base addr that chip responds to */
-	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
-			     | superio_inb(SIO_BASE_LADDR));
+	pc8736x_gpio_base = (superio_inb(gate, SIO_BASE_HADDR) << 8
+			     | superio_inb(gate, SIO_BASE_LADDR));
 
 	if (!request_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE, DEVNAME)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
 			pc8736x_gpio_base);
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 	dev_info(&pdev->dev, "GPIO ioport %x reserved\n", pc8736x_gpio_base);
 
@@ -319,10 +305,14 @@ static int __init pc8736x_gpio_init(void
 	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fileops);
 	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
 
+	superio_exit(gate);	/* no release, we need to stay registered */
 	return 0;
 
 undo_request_region:
 	release_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE);
+undo_superio_enter:
+	superio_exit(gate);
+	superio_release(gate);
 undo_platform_dev_add:
 	platform_device_del(pdev);
 undo_platform_dev_alloc:
@@ -341,6 +331,7 @@ static void __exit pc8736x_gpio_cleanup(
 
 	platform_device_del(pdev);
 	platform_device_put(pdev);
+	superio_release(gate);
 }
 
 module_init(pc8736x_gpio_init);

--------------070703010405030407040403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070703010405030407040403--
