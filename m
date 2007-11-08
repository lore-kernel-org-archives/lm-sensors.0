From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Nov 2007 23:03:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: Let the user overrule the detected
Message-Id: <20071109000324.3ea312e1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While it is possible to force SMBus-based hardware monitoring chip
drivers to drive a not officially supported device, we do not have this
possibility for Super-I/O-based drivers. That's unfortunate because
sometimes newer chips are fully compatible and just forcing the driver
to load would work. Instead of that we have to tell the users to
recompile the kernel driver, which isn't an easy task for everyone.

So, I propose that we add a module parameter to all Super-I/O based
hardware monitoring drivers, letting advanced users force the driver
to load on their machine. The user has to provide the device ID of a
supposedly compatible device. This requires looking at the source code or
a datasheet, so I am confident that users can't randomly force a driver
without knowing what they are doing. Thus this should be relatively safe.

As you can see from the code, the implementation is pretty simple and
unintrusive.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/dme1737.c    |    6 +++++-
 drivers/hwmon/f71805f.c    |    6 +++++-
 drivers/hwmon/f71882fg.c   |    6 +++++-
 drivers/hwmon/it87.c       |    6 +++++-
 drivers/hwmon/pc87360.c    |    6 +++++-
 drivers/hwmon/pc87427.c    |    6 +++++-
 drivers/hwmon/smsc47b397.c |    6 +++++-
 drivers/hwmon/smsc47m1.c   |    6 +++++-
 drivers/hwmon/vt1211.c     |    8 +++++++-
 drivers/hwmon/w83627ehf.c  |   11 +++++++++--
 drivers/hwmon/w83627hf.c   |    6 +++++-
 11 files changed, 61 insertions(+), 12 deletions(-)

--- linux-2.6.24-rc2.orig/drivers/hwmon/f71805f.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/f71805f.c	2007-11-08 23:23:38.000000000 +0100
@@ -42,6 +42,10 @@
 #include <linux/acpi.h>
 #include <asm/io.h>
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define DRVNAME "f71805f"
@@ -1502,7 +1506,7 @@ static int __init f71805f_find(int sioad
 	if (devid != SIO_FINTEK_ID)
 		goto exit;
 
-	devid = superio_inw(sioaddr, SIO_REG_DEVID);
+	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
 	switch (devid) {
 	case SIO_F71805F_ID:
 		sio_data->kind = f71805f;
--- linux-2.6.24-rc2.orig/drivers/hwmon/f71882fg.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/f71882fg.c	2007-11-08 23:36:51.000000000 +0100
@@ -75,6 +75,10 @@
 
 #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *f71882fg_pdev = NULL;
 
 /* Super-I/O Function prototypes */
@@ -844,7 +848,7 @@ static int __init f71882fg_find(int sioa
 		goto exit;
 	}
 
-	devid = superio_inw(sioaddr, SIO_REG_DEVID);
+	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
 	if (devid != SIO_F71882_ID) {
 		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");
 		goto exit;
--- linux-2.6.24-rc2.orig/drivers/hwmon/pc87360.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/pc87360.c	2007-11-08 23:38:59.000000000 +0100
@@ -60,6 +60,10 @@ MODULE_PARM_DESC(init,
  " 2: Forcibly enable all voltage and temperature channels, except in9\n"
  " 3: Forcibly enable all voltage and temperature channels, including in9");
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 /*
  * Super-I/O registers and operations
  */
@@ -827,7 +831,7 @@ static int __init pc87360_find(int sioad
 	/* No superio_enter */
 
 	/* Identify device */
-	val = superio_inb(sioaddr, DEVID);
+	val = force_id ? force_id : superio_inb(sioaddr, DEVID);
 	switch (val) {
 	case 0xE1: /* PC87360 */
 	case 0xE8: /* PC87363 */
--- linux-2.6.24-rc2.orig/drivers/hwmon/pc87427.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/pc87427.c	2007-11-08 23:38:50.000000000 +0100
@@ -35,6 +35,10 @@
 #include <linux/acpi.h>
 #include <asm/io.h>
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define DRVNAME "pc87427"
@@ -560,7 +564,7 @@ static int __init pc87427_find(int sioad
 	int i, err = 0;
 
 	/* Identify device */
-	val = superio_inb(sioaddr, SIOREG_DEVID);
+	val = force_id ? force_id : superio_inb(sioaddr, SIOREG_DEVID);
 	if (val != 0xf2) {	/* PC87427 */
 		err = -ENODEV;
 		goto exit;
--- linux-2.6.24-rc2.orig/drivers/hwmon/dme1737.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/dme1737.c	2007-11-08 23:43:19.000000000 +0100
@@ -45,6 +45,10 @@ static int force_start;
 module_param(force_start, bool, 0);
 MODULE_PARM_DESC(force_start, "Force the chip to start monitoring inputs");
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x2c, 0x2d, 0x2e, I2C_CLIENT_END};
 
@@ -2192,7 +2196,7 @@ static int __init dme1737_isa_detect(int
 	/* Check device ID
 	 * We currently know about SCH3112 (0x7c), SCH3114 (0x7d), and
 	 * SCH3116 (0x7f). */
-	reg = dme1737_sio_inb(sio_cip, 0x20);
+	reg = force_id ? force_id : dme1737_sio_inb(sio_cip, 0x20);
 	if (!(reg = 0x7c || reg = 0x7d || reg = 0x7f)) {
 		err = -ENODEV;
 		goto exit;
--- linux-2.6.24-rc2.orig/drivers/hwmon/it87.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/it87.c	2007-11-08 23:43:34.000000000 +0100
@@ -45,6 +45,10 @@
 
 enum chips { it87, it8712, it8716, it8718 };
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define	REG	0x2e	/* The register to read/write */
@@ -893,7 +897,7 @@ static int __init it87_find(unsigned sho
 	u16 chip_type;
 
 	superio_enter();
-	chip_type = superio_inw(DEVID);
+	chip_type = force_id ? force_id : superio_inw(DEVID);
 
 	switch (chip_type) {
 	case IT8705F_DEVID:
--- linux-2.6.24-rc2.orig/drivers/hwmon/smsc47b397.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/smsc47b397.c	2007-11-08 23:43:48.000000000 +0100
@@ -39,6 +39,10 @@
 #include <linux/acpi.h>
 #include <asm/io.h>
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define DRVNAME "smsc47b397"
@@ -338,7 +342,7 @@ static int __init smsc47b397_find(unsign
 	u8 id, rev;
 
 	superio_enter();
-	id = superio_inb(SUPERIO_REG_DEVID);
+	id = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
 
 	if ((id != 0x6f) && (id != 0x81) && (id != 0x85)) {
 		superio_exit();
--- linux-2.6.24-rc2.orig/drivers/hwmon/smsc47m1.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/smsc47m1.c	2007-11-08 23:44:10.000000000 +0100
@@ -40,6 +40,10 @@
 #include <linux/acpi.h>
 #include <asm/io.h>
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define DRVNAME "smsc47m1"
@@ -400,7 +404,7 @@ static int __init smsc47m1_find(unsigned
 	u8 val;
 
 	superio_enter();
-	val = superio_inb(SUPERIO_REG_DEVID);
+	val = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
 
 	/*
 	 * SMSC LPC47M10x/LPC47M112/LPC47M13x (device id 0x59), LPC47M14x
--- linux-2.6.24-rc2.orig/drivers/hwmon/vt1211.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/vt1211.c	2007-11-08 23:45:05.000000000 +0100
@@ -43,6 +43,10 @@ static int int_mode = -1;
 module_param(int_mode, int, 0);
 MODULE_PARM_DESC(int_mode, "Force the temperature interrupt mode");
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 static struct platform_device *pdev;
 
 #define DRVNAME "vt1211"
@@ -1285,10 +1289,12 @@ EXIT:
 static int __init vt1211_find(int sio_cip, unsigned short *address)
 {
 	int err = -ENODEV;
+	int devid;
 
 	superio_enter(sio_cip);
 
-	if (superio_inb(sio_cip, SIO_VT1211_DEVID) != SIO_VT1211_ID) {
+	devid = force_id ? force_id : superio_inb(sio_cip, SIO_VT1211_DEVID);
+	if (devid != SIO_VT1211_ID) {
 		goto EXIT;
 	}
 
--- linux-2.6.24-rc2.orig/drivers/hwmon/w83627ehf.c	2007-11-07 20:18:20.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/w83627ehf.c	2007-11-08 23:45:56.000000000 +0100
@@ -60,6 +60,10 @@ static const char * w83627ehf_device_nam
 	"w83627dhg",
 };
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 #define DRVNAME "w83627ehf"
 
 /*
@@ -1438,8 +1442,11 @@ static int __init w83627ehf_find(int sio
 
 	superio_enter(sioaddr);
 
-	val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8)
-	    | superio_inb(sioaddr, SIO_REG_DEVID + 1);
+	if (force_id)
+		val = force_id;
+	else
+		val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8)
+		    | superio_inb(sioaddr, SIO_REG_DEVID + 1);
 	switch (val & SIO_ID_MASK) {
 	case SIO_W83627EHF_ID:
 		sio_data->kind = w83627ehf;
--- linux-2.6.24-rc2.orig/drivers/hwmon/w83627hf.c	2007-11-08 22:59:44.000000000 +0100
+++ linux-2.6.24-rc2/drivers/hwmon/w83627hf.c	2007-11-08 23:46:11.000000000 +0100
@@ -76,6 +76,10 @@ static int init = 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
 
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Overrule the detected device ID");
+
 /* modified from kernel/include/traps.c */
 static int REG;		/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -1015,7 +1019,7 @@ static int __init w83627hf_find(int sioa
 	VAL = sioaddr + 1;
 
 	superio_enter();
-	val= superio_inb(DEVID);
+	val = force_id ? force_id : superio_inb(DEVID);
 	switch (val) {
 	case W627_DEVID:
 		sio_data->type = w83627hf;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
