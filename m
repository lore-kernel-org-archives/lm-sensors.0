From: jimc <jim.cromie@gmail.com>
Date: Thu, 14 Jun 2007 23:12:20 +0000
Subject: [lm-sensors] [ patch 4/4 RFC for 2.6.23-rc0 ] superio-locks in rest
Message-Id: <4671CB54.5060108@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000008050704010408060004"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008050704010408060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


04 - use superio-locks in rest of drivers/hwmon/*.c

This patch(s) is compile-tested only, please review before installing 
and testing.


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

---

[jimc@harpo mylocks]$ diffstat diff.locks-superio-usein-hwmon
  Kconfig      |    8 ++++
  f71805f.c    |   71 ++++++++++++++++++++++++--------------
  it87.c       |   75 +++++++++++++++++++++++++++-------------
  smsc47b397.c |   65 ++++++++++++++++++++++++-----------
  smsc47m1.c   |   58 ++++++++++++++++++++++---------
  vt1211.c     |   63 +++++++++++++++++++++++-----------
  w83627ehf.c  |   96 ++++++++++++++++++++++++---------------------------
  w83627hf.c   |  109 
++++++++++++++++++++++++++++++++++++-----------------------
  8 files changed, 348 insertions(+), 197 deletions(-)

--------------000008050704010408060004
Content-Type: text/plain;
 name="diff.locks-superio-usein-hwmon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.locks-superio-usein-hwmon"

diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/f71805f.c locks-4/drivers/hwmon/f71805f.c
--- locks-3/drivers/hwmon/f71805f.c	2007-06-13 09:49:44.000000000 -0600
+++ locks-4/drivers/hwmon/f71805f.c	2007-06-13 17:46:11.000000000 -0600
@@ -36,6 +36,7 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/ioport.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -61,6 +62,21 @@ enum kinds { f71805f, f71872f };
 #define SIO_F71805F_ID		0x0406
 #define SIO_F71872F_ID		0x0341
 
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { 0x2e, 0x4e, 0 };
+static u16 devid_vals[]	= { SIO_F71805F_ID, SIO_F71872F_ID, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SIO_REG_DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 1,
+};
+
+#if 0
+
 static inline int
 superio_inb(int base, int reg)
 {
@@ -80,13 +96,6 @@ superio_inw(int base, int reg)
 }
 
 static inline void
-superio_select(int base, int ld)
-{
-	outb(SIO_REG_LDSEL, base);
-	outb(ld, base + 1);
-}
-
-static inline void
 superio_enter(int base)
 {
 	outb(0x87, base);
@@ -99,6 +108,14 @@ superio_exit(int base)
 	outb(0xaa, base);
 }
 
+#endif
+
+static inline void
+superio_select(struct superio * const gate, int ld)
+{
+	superio_outb(gate, SIO_REG_LDSEL, ld);
+}
+
 /*
  * ISA constants
  */
@@ -1315,31 +1332,36 @@ exit:
 	return err;
 }
 
-static int __init f71805f_find(int sioaddr, unsigned short *address,
-			       struct f71805f_sio_data *sio_data)
+static int __init f71805f_find(struct f71805f_sio_data *sio_data)
 {
 	int err = -ENODEV;
-	u16 devid;
-
+	u16 devid, address;
+	
 	static const char *names[] = {
 		"F71805F/FG",
 		"F71872F/FG",
 	};
 
-	superio_enter(sioaddr);
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
 
-	devid = superio_inw(sioaddr, SIO_REG_MANID);
+	devid = superio_inw(gate, SIO_REG_MANID);
 	if (devid != SIO_FINTEK_ID)
 		goto exit;
 
-	devid = superio_inw(sioaddr, SIO_REG_DEVID);
+	devid = superio_inw(gate, SIO_REG_DEVID);
 	switch (devid) {
 	case SIO_F71805F_ID:
 		sio_data->kind = f71805f;
 		break;
 	case SIO_F71872F_ID:
 		sio_data->kind = f71872f;
-		sio_data->fnsel1 = superio_inb(sioaddr, SIO_REG_FNSEL1);
+		sio_data->fnsel1 = superio_inb(gate, SIO_REG_FNSEL1);
 		break;
 	default:
 		printk(KERN_INFO DRVNAME ": Unsupported Fintek device, "
@@ -1347,28 +1369,28 @@ static int __init f71805f_find(int sioad
 		goto exit;
 	}
 
-	superio_select(sioaddr, F71805F_LD_HWM);
-	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
+	superio_select(gate, F71805F_LD_HWM);
+	if (!(superio_inb(gate, SIO_REG_ENABLE) & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Device not activated, "
 		       "skipping\n");
 		goto exit;
 	}
 
-	*address = superio_inw(sioaddr, SIO_REG_ADDR);
-	if (*address == 0) {
+	address = superio_inw(gate, SIO_REG_ADDR);
+	if (address == 0) {
 		printk(KERN_WARNING DRVNAME ": Base address not set, "
 		       "skipping\n");
 		goto exit;
 	}
-	*address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
+	address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
 	err = 0;
 	printk(KERN_INFO DRVNAME ": Found %s chip at %#x, revision %u\n",
-	       names[sio_data->kind], *address,
-	       superio_inb(sioaddr, SIO_REG_DEVREV));
+	       names[sio_data->kind], address,
+	       superio_inb(gate, SIO_REG_DEVREV));
 
 exit:
-	superio_exit(sioaddr);
+	superio_exit(gate);
 	return err;
 }
 
@@ -1378,8 +1400,7 @@ static int __init f71805f_init(void)
 	unsigned short address;
 	struct f71805f_sio_data sio_data;
 
-	if (f71805f_find(0x2e, &address, &sio_data)
-	 && f71805f_find(0x4e, &address, &sio_data))
+	if (f71805f_find(&sio_data))
 		return -ENODEV;
 
 	err = platform_driver_register(&f71805f_driver);
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/it87.c locks-4/drivers/hwmon/it87.c
--- locks-3/drivers/hwmon/it87.c	2007-05-20 23:18:13.000000000 -0600
+++ locks-4/drivers/hwmon/it87.c	2007-06-13 19:06:14.000000000 -0600
@@ -38,6 +38,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 
 
@@ -52,6 +53,31 @@ enum chips { it87, it8712, it8716, it871
 #define	DEVID	0x20	/* Register: Device ID */
 #define	DEVREV	0x22	/* Register: Device Revision */
 
+/* Logical device 4 registers */
+#define IT8712F_DEVID 0x8712
+#define IT8705F_DEVID 0x8705
+#define IT8716F_DEVID 0x8716
+#define IT8718F_DEVID 0x8718
+#define IT87_ACT_REG  0x30
+#define IT87_BASE_REG 0x60
+
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { REG, 0 };
+static u16 devid_vals[]	= { 
+	IT8712F_DEVID, IT8716F_DEVID, IT8718F_DEVID, IT8705F_DEVID, 0
+};
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 1,
+};
+
+#if 0
+
 static inline int
 superio_inb(int reg)
 {
@@ -70,13 +96,6 @@ static int superio_inw(int reg)
 }
 
 static inline void
-superio_select(int ldn)
-{
-	outb(DEV, REG);
-	outb(ldn, VAL);
-}
-
-static inline void
 superio_enter(void)
 {
 	outb(0x87, REG);
@@ -92,13 +111,14 @@ superio_exit(void)
 	outb(0x02, VAL);
 }
 
-/* Logical device 4 registers */
-#define IT8712F_DEVID 0x8712
-#define IT8705F_DEVID 0x8705
-#define IT8716F_DEVID 0x8716
-#define IT8718F_DEVID 0x8718
-#define IT87_ACT_REG  0x30
-#define IT87_BASE_REG 0x60
+#endif
+
+static inline void
+superio_select(struct superio * const gate, int ldn)
+{
+	superio_outb(gate, DEV, ldn);
+}
+
 
 /* Logical device 7 registers (IT8712F and later) */
 #define IT87_SIO_PINX2_REG	0x2c	/* Pin selection */
@@ -881,21 +901,28 @@ static int __init it87_find(unsigned sho
 {
 	int err = -ENODEV;
 
-	superio_enter();
-	chip_type = superio_inw(DEVID);
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+
+	chip_type = superio_inw(gate, DEVID);
 	if (chip_type != IT8712F_DEVID
 	 && chip_type != IT8716F_DEVID
 	 && chip_type != IT8718F_DEVID
 	 && chip_type != IT8705F_DEVID)
 	 	goto exit;
 
-	superio_select(PME);
-	if (!(superio_inb(IT87_ACT_REG) & 0x01)) {
+	superio_select(gate, PME);
+	if (!(superio_inb(gate, IT87_ACT_REG) & 0x01)) {
 		pr_info("it87: Device not activated, skipping\n");
 		goto exit;
 	}
 
-	*address = superio_inw(IT87_BASE_REG) & ~(IT87_EXTENT - 1);
+	*address = superio_inw(gate, IT87_BASE_REG) & ~(IT87_EXTENT - 1);
 	if (*address == 0) {
 		pr_info("it87: Base address not set, skipping\n");
 		goto exit;
@@ -903,17 +930,17 @@ static int __init it87_find(unsigned sho
 
 	err = 0;
 	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
-		chip_type, *address, superio_inb(DEVREV) & 0x0f);
+		chip_type, *address, superio_inb(gate, DEVREV) & 0x0f);
 
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
 	if (chip_type != IT8705F_DEVID) {
 		int reg;
 
-		superio_select(GPIO);
+		superio_select(gate, GPIO);
 		if (chip_type == it8718)
-			vid_value = superio_inb(IT87_SIO_VID_REG);
+			vid_value = superio_inb(gate, IT87_SIO_VID_REG);
 
-		reg = superio_inb(IT87_SIO_PINX2_REG);
+		reg = superio_inb(gate, IT87_SIO_PINX2_REG);
 		if (reg & (1 << 0))
 			pr_info("it87: in3 is VCC (+5V)\n");
 		if (reg & (1 << 1))
@@ -921,7 +948,7 @@ static int __init it87_find(unsigned sho
 	}
 
 exit:
-	superio_exit();
+	superio_exit(gate);
 	return err;
 }
 
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/Kconfig locks-4/drivers/hwmon/Kconfig
--- locks-3/drivers/hwmon/Kconfig	2007-06-13 12:06:00.000000000 -0600
+++ locks-4/drivers/hwmon/Kconfig	2007-06-13 23:12:39.000000000 -0600
@@ -191,6 +191,7 @@ config SENSORS_DS1621
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG and F71872F/FG"
 	depends on EXPERIMENTAL
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of the Fintek F71805F/FG and F71872F/FG Super-I/O
@@ -253,6 +254,7 @@ config SENSORS_IT87
 	depends on I2C
 	select I2C_ISA
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for ITE IT8705F, IT8712F,
 	  IT8716F and IT8718F sensor chips, and the SiS960 clone.
@@ -422,6 +424,7 @@ config SENSORS_PC87360
 config SENSORS_PC87427
 	tristate "National Semiconductor PC87427"
 	depends on EXPERIMENTAL
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get access to the hardware monitoring
 	  functions of the National Semiconductor PC87427 Super-I/O chip.
@@ -445,6 +448,7 @@ config SENSORS_SIS5595
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for the integrated fan
 	  monitoring and control capabilities of the SMSC LPC47B27x,
@@ -479,6 +483,7 @@ config SENSORS_SMSC47M192
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
 	depends on EXPERIMENTAL
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
 	  sensor chip.
@@ -501,6 +506,7 @@ config SENSORS_VT1211
 	tristate "VIA VT1211"
 	depends on EXPERIMENTAL
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here then you get support for hardware monitoring
 	  features of the VIA VT1211 Super-I/O chip.
@@ -576,6 +582,7 @@ config SENSORS_W83L785TS
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
 	select HWMON_VID
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
 	  of sensor chips: the W83627HF, W83627THF, W83637HF, W83687THF and
@@ -588,6 +595,7 @@ config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF"
 	depends on I2C && EXPERIMENTAL
 	select I2C_ISA
+	select SUPERIO_LOCKS
 	help
 	  If you say yes here you get preliminary support for the hardware
 	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/smsc47b397.c locks-4/drivers/hwmon/smsc47b397.c
--- locks-3/drivers/hwmon/smsc47b397.c	2007-06-13 09:49:44.000000000 -0600
+++ locks-4/drivers/hwmon/smsc47b397.c	2007-06-13 19:06:46.000000000 -0600
@@ -36,6 +36,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -44,6 +45,29 @@ static struct platform_device *pdev;
 
 /* Super-I/0 registers and commands */
 
+#define SUPERIO_REG_DEVID	0x20
+#define SUPERIO_REG_DEVREV	0x21
+#define SUPERIO_REG_BASE_MSB	0x60
+#define SUPERIO_REG_BASE_LSB	0x61
+#define SUPERIO_REG_LD8		0x08
+
+#define SMSC_EXTENT		0x02
+
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { 0x2e, 0x4e, 0 };
+static u16 devid_vals[]	= { 0x6f, 0x81, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SUPERIO_REG_DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 0,
+};
+
+#if 0
+
 #define	REG	0x2e	/* The register to read/write */
 #define	VAL	0x2f	/* The value to read/write */
 
@@ -59,12 +83,6 @@ static inline int superio_inb(int reg)
 	return inb(VAL);
 }
 
-/* select superio logical device */
-static inline void superio_select(int ld)
-{
-	superio_outb(0x07, ld);
-}
-
 static inline void superio_enter(void)
 {
 	outb(0x55, REG);
@@ -75,13 +93,14 @@ static inline void superio_exit(void)
 	outb(0xAA, REG);
 }
 
-#define SUPERIO_REG_DEVID	0x20
-#define SUPERIO_REG_DEVREV	0x21
-#define SUPERIO_REG_BASE_MSB	0x60
-#define SUPERIO_REG_BASE_LSB	0x61
-#define SUPERIO_REG_LD8		0x08
+#endif
+
+/* select superio logical device */
+static inline void superio_select(struct superio * const gate, int ld)
+{
+	superio_outb(gate, 0x07, ld);
+}
 
-#define SMSC_EXTENT		0x02
 
 /* 0 <= nr <= 3 */
 static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
@@ -330,25 +349,31 @@ static int __init smsc47b397_find(unsign
 {
 	u8 id, rev;
 
-	superio_enter();
-	id = superio_inb(SUPERIO_REG_DEVID);
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+	id = superio_inb(gate, SUPERIO_REG_DEVID);
 
 	if ((id != 0x6f) && (id != 0x81)) {
-		superio_exit();
+		superio_exit(gate);
 		return -ENODEV;
 	}
 
-	rev = superio_inb(SUPERIO_REG_DEVREV);
+	rev = superio_inb(gate, SUPERIO_REG_DEVREV);
 
-	superio_select(SUPERIO_REG_LD8);
-	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
-		 |  superio_inb(SUPERIO_REG_BASE_LSB);
+	superio_select(gate, SUPERIO_REG_LD8);
+	*addr = (superio_inb(gate, SUPERIO_REG_BASE_MSB) << 8)
+		 |  superio_inb(gate, SUPERIO_REG_BASE_LSB);
 
 	printk(KERN_INFO DRVNAME ": found SMSC %s "
 		"(base address 0x%04x, revision %u)\n",
 		id == 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
 
-	superio_exit();
+	superio_exit(gate);
 	return 0;
 }
 
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/smsc47m1.c locks-4/drivers/hwmon/smsc47m1.c
--- locks-3/drivers/hwmon/smsc47m1.c	2007-06-13 09:49:44.000000000 -0600
+++ locks-4/drivers/hwmon/smsc47m1.c	2007-06-13 18:37:09.000000000 -0600
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -46,9 +47,28 @@ enum chips { smsc47m1, smsc47m2 };
 
 /* Super-I/0 registers and commands */
 
+#define SUPERIO_REG_ACT		0x30
+#define SUPERIO_REG_BASE	0x60
+#define SUPERIO_REG_DEVID	0x20
+
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { 0x2e, 0x4e, 0 };
+static u16 devid_vals[]	= { 0x51, 0x59, 0x5F, 0x60, 0x6B, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SUPERIO_REG_DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 1,
+};
+
 #define	REG	0x2e	/* The register to read/write */
 #define	VAL	0x2f	/* The value to read/write */
 
+#if 0
+
 static inline void
 superio_outb(int reg, int val)
 {
@@ -63,9 +83,6 @@ superio_inb(int reg)
 	return inb(VAL);
 }
 
-/* logical device for fans is 0x0A */
-#define superio_select() superio_outb(0x07, 0x0A)
-
 static inline void
 superio_enter(void)
 {
@@ -78,9 +95,13 @@ superio_exit(void)
 	outb(0xAA, REG);
 }
 
-#define SUPERIO_REG_ACT		0x30
-#define SUPERIO_REG_BASE	0x60
-#define SUPERIO_REG_DEVID	0x20
+#endif
+
+/* select superio logical device */
+static inline void superio_select(struct superio * const gate, int ld)
+{
+	superio_outb(gate, 0x07, ld);
+}
 
 /* Logical device registers */
 
@@ -398,8 +419,14 @@ static int __init smsc47m1_find(unsigned
 {
 	u8 val;
 
-	superio_enter();
-	val = superio_inb(SUPERIO_REG_DEVID);
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+	val = superio_inb(gate, SUPERIO_REG_DEVID);
 
 	/*
 	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
@@ -434,21 +461,20 @@ static int __init smsc47m1_find(unsigned
 		sio_data->type = smsc47m2;
 		break;
 	default:
-		superio_exit();
+		superio_exit(gate);
 		return -ENODEV;
 	}
-
-	superio_select();
-	*addr = (superio_inb(SUPERIO_REG_BASE) << 8)
-	      |  superio_inb(SUPERIO_REG_BASE + 1);
-	val = superio_inb(SUPERIO_REG_ACT);
+	superio_select(gate, 0x0A);
+	*addr = (superio_inb(gate, SUPERIO_REG_BASE) << 8)
+	      |  superio_inb(gate, SUPERIO_REG_BASE + 1);
+	val = superio_inb(gate, SUPERIO_REG_ACT);
 	if (*addr == 0 || (val & 0x01) == 0) {
 		pr_info(DRVNAME ": Device is disabled, will not use\n");
-		superio_exit();
+		superio_exit(gate);
 		return -ENODEV;
 	}
 
-	superio_exit();
+	superio_exit(gate);
 	return 0;
 }
 
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/vt1211.c locks-4/drivers/hwmon/vt1211.c
--- locks-3/drivers/hwmon/vt1211.c	2007-06-13 09:49:44.000000000 -0600
+++ locks-4/drivers/hwmon/vt1211.c	2007-06-13 17:22:36.000000000 -0600
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 
 static int uch_config = -1;
@@ -195,6 +196,21 @@ struct vt1211_data {
 /* VT1211 logical device numbers */
 #define SIO_VT1211_LDN_HWMON	0x0b	/* HW monitor */
 
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { SIO_REG_CIP1, SIO_REG_CIP2, 0 };
+static u16 devid_vals[]	= { SIO_VT1211_ID, 0 };
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SIO_VT1211_DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 0,
+};
+
+#if 0
+
 static inline void superio_outb(int sio_cip, int reg, int val)
 {
 	outb(reg, sio_cip);
@@ -207,12 +223,6 @@ static inline int superio_inb(int sio_ci
 	return inb(sio_cip + 1);
 }
 
-static inline void superio_select(int sio_cip, int ldn)
-{
-	outb(SIO_VT1211_LDN, sio_cip);
-	outb(ldn, sio_cip + 1);
-}
-
 static inline void superio_enter(int sio_cip)
 {
 	outb(0x87, sio_cip);
@@ -224,6 +234,13 @@ static inline void superio_exit(int sio_
 	outb(0xaa, sio_cip);
 }
 
+#endif
+
+static inline void superio_select(struct superio * const gate, int ldn)
+{
+	superio_outb(gate, SIO_VT1211_LDN, ldn);
+}
+
 /* ---------------------------------------------------------------------
  * Device I/O access
  * --------------------------------------------------------------------- */
@@ -1277,27 +1294,35 @@ EXIT:
 	return err;
 }
 
-static int __init vt1211_find(int sio_cip, unsigned short *address)
+static int __init vt1211_find(void)
 {
 	int err = -ENODEV;
+	u16 address;
 
-	superio_enter(sio_cip);
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
 
-	if (superio_inb(sio_cip, SIO_VT1211_DEVID) != SIO_VT1211_ID) {
+	if (superio_inb(gate, SIO_VT1211_DEVID) != SIO_VT1211_ID) {
 		goto EXIT;
 	}
 
-	superio_select(sio_cip, SIO_VT1211_LDN_HWMON);
+	superio_select(gate, SIO_VT1211_LDN_HWMON);
 
-	if ((superio_inb(sio_cip, SIO_VT1211_ACTIVE) & 1) == 0) {
+	if ((superio_inb(gate, SIO_VT1211_ACTIVE) & 1) == 0) {
 		printk(KERN_WARNING DRVNAME ": HW monitor is disabled, "
 		       "skipping\n");
 		goto EXIT;
 	}
 
-	*address = ((superio_inb(sio_cip, SIO_VT1211_BADDR) << 8) |
-		    (superio_inb(sio_cip, SIO_VT1211_BADDR + 1))) & 0xff00;
-	if (*address == 0) {
+	address = ((superio_inb(gate, SIO_VT1211_BADDR) << 8) |
+		   (superio_inb(gate, SIO_VT1211_BADDR + 1) & 0xff00));	// parens ?!?
+
+	if (address == 0) {
 		printk(KERN_WARNING DRVNAME ": Base address is not set, "
 		       "skipping\n");
 		goto EXIT;
@@ -1305,11 +1330,11 @@ static int __init vt1211_find(int sio_ci
 
 	err = 0;
 	printk(KERN_INFO DRVNAME ": Found VT1211 chip at 0x%04x, "
-	       "revision %u\n", *address,
-	       superio_inb(sio_cip, SIO_VT1211_DEVREV));
+	       "revision %u\n", address,
+	       superio_inb(gate, SIO_VT1211_DEVREV));
 
 EXIT:
-	superio_exit(sio_cip);
+	superio_exit(gate);
 	return err;
 }
 
@@ -1318,10 +1343,8 @@ static int __init vt1211_init(void)
 	int err;
 	unsigned short address = 0;
 
-	if ((err = vt1211_find(SIO_REG_CIP1, &address)) &&
-	    (err = vt1211_find(SIO_REG_CIP2, &address))) {
+	if ((err = vt1211_find()))
 		goto EXIT;
-	}
 
 	if ((uch_config < -1) || (uch_config > 31)) {
 		err = -EINVAL;
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/w83627ehf.c locks-4/drivers/hwmon/w83627ehf.c
--- locks-3/drivers/hwmon/w83627ehf.c	2007-05-20 23:18:14.000000000 -0600
+++ locks-4/drivers/hwmon/w83627ehf.c	2007-06-13 17:00:24.000000000 -0600
@@ -47,6 +47,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -82,39 +83,24 @@ static int w83627ehf_num_in;
 #define SIO_W83627DHG_ID	0xa020
 #define SIO_ID_MASK		0xFFF0
 
-static inline void
-superio_outb(int reg, int val)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
-static inline int
-superio_inb(int reg)
-{
-	outb(reg, REG);
-	return inb(VAL);
-}
+static struct superio* gate;
 
-static inline void
-superio_select(int ld)
-{
-	outb(SIO_REG_LDSEL, REG);
-	outb(ld, VAL);
-}
+static u16 cmd_addrs[] = { 0x2E, 0x4E, 0 };
+static u16 devid_vals[] = { SIO_W83627EHF_ID, SIO_W83627EHG_ID, SIO_W83627DHG_ID, 0 };
 
-static inline void
-superio_enter(void)
-{
-	outb(0x87, REG);
-	outb(0x87, REG);
-}
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = SIO_REG_DEVID,
+	.devid_mask   = SIO_ID_MASK,
+	.devid_word   = 1,
+};
 
 static inline void
-superio_exit(void)
+superio_select(struct superio * const gate, int ld)
 {
-	outb(0x02, REG);
-	outb(0x02, VAL);
+	superio_outb(gate, SIO_REG_LDSEL, REG);
+	superio_outb(gate, ld, VAL);
 }
 
 /*
@@ -1236,10 +1222,10 @@ static int w83627ehf_detect(struct i2c_a
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
 
-	superio_enter();
-	fan5pin = superio_inb(0x24) & 0x2;
-	fan4pin = superio_inb(0x29) & 0x6;
-	superio_exit();
+	superio_enter(gate);
+	fan5pin = superio_inb(gate, 0x24) & 0x2;
+	fan4pin = superio_inb(gate, 0x29) & 0x6;
+	superio_exit(gate);
 
 	/* It looks like fan4 and fan5 pins can be alternatively used
 	   as fan on/off switches, but fan5 control is write only :/
@@ -1352,16 +1338,25 @@ static struct i2c_driver w83627ehf_drive
 	.detach_client	= w83627ehf_detach_client,
 };
 
-static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
+static int __init w83627ehf_find(void)
 {
-	u16 val;
+	u16 val, addr;
+
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+
+	REG = gate->sioaddr;
+	VAL = gate->sioaddr + 1;
+
+	val = (superio_inb(gate, SIO_REG_DEVID) << 8)
+		| superio_inb(gate, SIO_REG_DEVID + 1);
 
-	REG = sioaddr;
-	VAL = sioaddr + 1;
-	superio_enter();
 
-	val = (superio_inb(SIO_REG_DEVID) << 8)
-	    | superio_inb(SIO_REG_DEVID + 1);
 	switch (val & SIO_ID_MASK) {
 	case SIO_W83627DHG_ID:
 		w83627ehf_num_in = 9;
@@ -1373,32 +1368,31 @@ static int __init w83627ehf_find(int sio
 	default:
 		printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
 			val);
-		superio_exit();
+		superio_exit(gate);
 		return -ENODEV;
 	}
 
-	superio_select(W83627EHF_LD_HWM);
-	val = (superio_inb(SIO_REG_ADDR) << 8)
-	    | superio_inb(SIO_REG_ADDR + 1);
-	*addr = val & IOREGION_ALIGNMENT;
-	if (*addr == 0) {
-		superio_exit();
+	superio_select(gate, W83627EHF_LD_HWM);
+	val = (superio_inb(gate, SIO_REG_ADDR) << 8)
+		| superio_inb(gate, SIO_REG_ADDR + 1);
+	addr = val & IOREGION_ALIGNMENT;
+	if (addr == 0) {
+		superio_exit(gate);
 		return -ENODEV;
 	}
 
 	/* Activate logical device if needed */
-	val = superio_inb(SIO_REG_ENABLE);
+	val = superio_inb(gate, SIO_REG_ENABLE);
 	if (!(val & 0x01))
-		superio_outb(SIO_REG_ENABLE, val | 0x01);
+		superio_outb(gate, SIO_REG_ENABLE, val | 0x01);
 
-	superio_exit();
+	superio_exit(gate);
 	return 0;
 }
 
 static int __init sensors_w83627ehf_init(void)
 {
-	if (w83627ehf_find(0x2e, &address)
-	 && w83627ehf_find(0x4e, &address))
+	if (w83627ehf_find())
 		return -ENODEV;
 
 	return i2c_isa_add_driver(&w83627ehf_driver);
diff -ruNp -X dontdiff -X exclude-diffs locks-3/drivers/hwmon/w83627hf.c locks-4/drivers/hwmon/w83627hf.c
--- locks-3/drivers/hwmon/w83627hf.c	2007-06-13 09:49:44.000000000 -0600
+++ locks-4/drivers/hwmon/w83627hf.c	2007-06-13 18:05:40.000000000 -0600
@@ -49,6 +49,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
+#include <linux/superio-locks.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -106,6 +107,32 @@ static int VAL;		/* The value to read/wr
 #define W83687THF_VID_CFG	0xF0 /* w83687thf only */
 #define W83687THF_VID_DATA	0xF1 /* w83687thf only */
 
+#define W627_DEVID		0x52
+#define W627THF_DEVID		0x82
+#define W697_DEVID		0x60
+#define W637_DEVID		0x70
+#define W687THF_DEVID		0x85
+
+#define WINB_ACT_REG		0x30
+#define WINB_BASE_REG		0x60
+
+static struct superio* gate;
+
+static u16 cmd_addrs[]	= { 0x2e, 0x4e, 0 };
+static u16 devid_vals[]	= { 
+	W627_DEVID, W627THF_DEVID, W697_DEVID, W637_DEVID, W687THF_DEVID, 0
+};
+
+static struct superio_search where = {
+	.cmdreg_addrs = cmd_addrs,
+	.device_ids   = devid_vals,
+	.devid_addr   = DEVID,
+	.devid_mask   = 0,
+	.devid_word   = 1,
+};
+
+#if 0
+
 static inline void
 superio_outb(int reg, int val)
 {
@@ -121,13 +148,6 @@ superio_inb(int reg)
 }
 
 static inline void
-superio_select(int ld)
-{
-	outb(DEV, REG);
-	outb(ld, VAL);
-}
-
-static inline void
 superio_enter(void)
 {
 	outb(0x87, REG);
@@ -140,13 +160,14 @@ superio_exit(void)
 	outb(0xAA, REG);
 }
 
-#define W627_DEVID 0x52
-#define W627THF_DEVID 0x82
-#define W697_DEVID 0x60
-#define W637_DEVID 0x70
-#define W687THF_DEVID 0x85
-#define WINB_ACT_REG 0x30
-#define WINB_BASE_REG 0x60
+#endif
+
+static inline void
+superio_select(struct superio * const gate, int ld)
+{
+	superio_outb(gate, DEV, ld);
+}
+
 /* Constants specified below */
 
 /* Alignment of the base address */
@@ -930,7 +951,7 @@ static ssize_t show_name(struct device *
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static int __init w83627hf_find(int sioaddr, unsigned short *addr,
+static int __init w83627hf_find(unsigned short *addr,
 				struct w83627hf_sio_data *sio_data)
 {
 	int err = -ENODEV;
@@ -944,11 +965,18 @@ static int __init w83627hf_find(int sioa
 		"W83687THF",
 	};
 
-	REG = sioaddr;
-	VAL = sioaddr + 1;
+	gate = superio_find(&where);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+
+	REG = gate->sioaddr;
+	VAL = gate->sioaddr + 1;
 
-	superio_enter();
-	val= superio_inb(DEVID);
+	val= superio_inb(gate, DEVID);
 	switch (val) {
 	case W627_DEVID:
 		sio_data->type = w83627hf;
@@ -972,16 +1000,16 @@ static int __init w83627hf_find(int sioa
 		goto exit;
 	}
 
-	superio_select(W83627HF_LD_HWM);
+	superio_select(gate, W83627HF_LD_HWM);
 	force_addr &= WINB_ALIGNMENT;
 	if (force_addr) {
 		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
 		       force_addr);
-		superio_outb(WINB_BASE_REG, force_addr >> 8);
-		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
+		superio_outb(gate, WINB_BASE_REG, force_addr >> 8);
+		superio_outb(gate, WINB_BASE_REG + 1, force_addr & 0xff);
 	}
-	val = (superio_inb(WINB_BASE_REG) << 8) |
-	       superio_inb(WINB_BASE_REG + 1);
+	val = (superio_inb(gate, WINB_BASE_REG) << 8) |
+	       superio_inb(gate, WINB_BASE_REG + 1);
 	*addr = val & WINB_ALIGNMENT;
 	if (*addr == 0) {
 		printk(KERN_WARNING DRVNAME ": Base address not set, "
@@ -989,10 +1017,10 @@ static int __init w83627hf_find(int sioa
 		goto exit;
 	}
 
-	val = superio_inb(WINB_ACT_REG);
+	val = superio_inb(gate, WINB_ACT_REG);
 	if (!(val & 0x01)) {
 		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
-		superio_outb(WINB_ACT_REG, val | 0x01);
+		superio_outb(gate, WINB_ACT_REG, val | 0x01);
 	}
 
 	err = 0;
@@ -1000,7 +1028,7 @@ static int __init w83627hf_find(int sioa
 		names[sio_data->type], *addr);
 
  exit:
-	superio_exit();
+	superio_exit(gate);
 	return err;
 }
 
@@ -1245,18 +1273,18 @@ static int __devinit w83627thf_read_gpio
 {
 	int res = 0xff, sel;
 
-	superio_enter();
-	superio_select(W83627HF_LD_GPIO5);
+	superio_enter(gate);
+	superio_select(gate, W83627HF_LD_GPIO5);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+	if (!(superio_inb(gate, W83627THF_GPIO5_EN) & (1<<3))) {
 		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
-	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
+	sel = superio_inb(gate, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) != 0x1f) {
 		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
 			"function\n");
@@ -1264,10 +1292,10 @@ static int __devinit w83627thf_read_gpio
 	}
 
 	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
-	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+	res = superio_inb(gate, W83627THF_GPIO5_DR) & sel;
 
 exit:
-	superio_exit();
+	superio_exit(gate);
 	return res;
 }
 
@@ -1275,26 +1303,26 @@ static int __devinit w83687thf_read_vid(
 {
 	int res = 0xff;
 
-	superio_enter();
-	superio_select(W83627HF_LD_HWM);
+	superio_enter(gate);
+	superio_select(gate, W83627HF_LD_HWM);
 
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
+	if (!(superio_inb(gate, W83687THF_VID_EN) & (1 << 2))) {
 		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
 		goto exit;
 	}
 
 	/* Make sure the pins are configured for input */
-	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
+	if (!(superio_inb(gate, W83687THF_VID_CFG) & (1 << 4))) {
 		dev_dbg(&pdev->dev, "VID configured as output, "
 			"no VID function\n");
 		goto exit;
 	}
 
-	res = superio_inb(W83687THF_VID_DATA) & 0x3f;
+	res = superio_inb(gate, W83687THF_VID_DATA) & 0x3f;
 
 exit:
-	superio_exit();
+	superio_exit(gate);
 	return res;
 }
 
@@ -1579,8 +1607,7 @@ static int __init sensors_w83627hf_init(
 	unsigned short address;
 	struct w83627hf_sio_data sio_data;
 
-	if (w83627hf_find(0x2e, &address, &sio_data)
-	 && w83627hf_find(0x4e, &address, &sio_data))
+	if (w83627hf_find(&address, &sio_data))
 		return -ENODEV;
 
 	err = platform_driver_register(&w83627hf_driver);

--------------000008050704010408060004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000008050704010408060004--
