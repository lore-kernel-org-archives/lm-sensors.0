From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 May 2011 07:21:23 +0000
Subject: [lm-sensors] =?utf-8?q?=5BPATCH_1/3=5D_hwmon/sch5627=3A_Factor_ou?=
Message-Id: <1306567285-2322-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This patch adds a new sch56xx-common.ko which contains code which will also
be used in the new sch5636 driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/Kconfig          |    5 +
 drivers/hwmon/Makefile         |    1 +
 drivers/hwmon/sch5627.c        |  334 +++---------------------------------=
---
 drivers/hwmon/sch56xx-common.c |  336 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/hwmon/sch56xx-common.h |   24 +++
 5 files changed, 390 insertions(+), 310 deletions(-)
 create mode 100644 drivers/hwmon/sch56xx-common.c
 create mode 100644 drivers/hwmon/sch56xx-common.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 16db83c..e273c0c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1041,8 +1041,13 @@ config SENSORS_SMSC47B397
 	  This driver can also be built as a module.  If so, the module
 	  will be called smsc47b397.
=20
+config SENSORS_SCH56XX_COMMON
+	tristate
+	default n
+
 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
+	select SENSORS_SCH56XX_COMMON
 	help
 	  If you say yes here you get support for the hardware monitoring
 	  features of the SMSC SCH5627 Super-I/O chip.
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 28061cf..ae59bca 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_SENSORS_PC87360)	+=3D pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+=3D pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+=3D pcf8591.o
 obj-$(CONFIG_SENSORS_S3C)	+=3D s3c-hwmon.o
+obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+=3D sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+=3D sch5627.o
 obj-$(CONFIG_SENSORS_SHT15)	+=3D sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+=3D sht21.o
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 020c872..695b2ab 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -28,33 +28,15 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/io.h>
-#include <linux/acpi.h>
-#include <linux/delay.h>
+#include "sch56xx-common.h"
=20
 #define DRVNAME "sch5627"
 #define DEVNAME DRVNAME /* We only support one model */
=20
-#define SIO_SCH5627_EM_LD	0x0C	/* Embedded Microcontroller LD */
-#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
-#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
-
-#define SIO_REG_LDSEL		0x07	/* Logical device select */
-#define SIO_REG_DEVID		0x20	/* Device ID */
-#define SIO_REG_ENABLE		0x30	/* Logical device enable */
-#define SIO_REG_ADDR		0x66	/* Logical device address (2 bytes) */
-
-#define SIO_SCH5627_ID		0xC6	/* Chipset ID */
-
-#define REGION_LENGTH		9
-
 #define SCH5627_HWMON_ID		0xa5
 #define SCH5627_COMPANY_ID		0x5c
 #define SCH5627_PRIMARY_ID		0xa0
=20
-#define SCH5627_CMD_READ		0x02
-#define SCH5627_CMD_WRITE		0x03
-
 #define SCH5627_REG_BUILD_CODE		0x39
 #define SCH5627_REG_BUILD_ID		0x3a
 #define SCH5627_REG_HWMON_ID		0x3c
@@ -111,182 +93,6 @@ struct sch5627_data {
 	u16 in[SCH5627_NO_IN];
 };
=20
-static struct platform_device *sch5627_pdev;
-
-/* Super I/O functions */
-static inline int superio_inb(int base, int reg)
-{
-	outb(reg, base);
-	return inb(base + 1);
-}
-
-static inline int superio_enter(int base)
-{
-	/* Don't step on other drivers' I/O space by accident */
-	if (!request_muxed_region(base, 2, DRVNAME)) {
-		pr_err("I/O address 0x%04x already in use\n", base);
-		return -EBUSY;
-	}
-
-	outb(SIO_UNLOCK_KEY, base);
-
-	return 0;
-}
-
-static inline void superio_select(int base, int ld)
-{
-	outb(SIO_REG_LDSEL, base);
-	outb(ld, base + 1);
-}
-
-static inline void superio_exit(int base)
-{
-	outb(SIO_LOCK_KEY, base);
-	release_region(base, 2);
-}
-
-static int sch5627_send_cmd(struct sch5627_data *data, u8 cmd, u16 reg, u8=
 v)
-{
-	u8 val;
-	int i;
-	/*
-	 * According to SMSC for the commands we use the maximum time for
-	 * the EM to respond is 15 ms, but testing shows in practice it
-	 * responds within 15-32 reads, so we first busy poll, and if
-	 * that fails sleep a bit and try again until we are way past
-	 * the 15 ms maximum response time.
-	 */
-	const int max_busy_polls =3D 64;
-	const int max_lazy_polls =3D 32;
-
-	/* (Optional) Write-Clear the EC to Host Mailbox Register */
-	val =3D inb(data->addr + 1);
-	outb(val, data->addr + 1);
-
-	/* Set Mailbox Address Pointer to first location in Region 1 */
-	outb(0x00, data->addr + 2);
-	outb(0x80, data->addr + 3);
-
-	/* Write Request Packet Header */
-	outb(cmd, data->addr + 4); /* VREG Access Type read:0x02 write:0x03 */
-	outb(0x01, data->addr + 5); /* # of Entries: 1 Byte (8-bit) */
-	outb(0x04, data->addr + 2); /* Mailbox AP to first data entry loc. */
-
-	/* Write Value field */
-	if (cmd =3D SCH5627_CMD_WRITE)
-		outb(v, data->addr + 4);
-
-	/* Write Address field */
-	outb(reg & 0xff, data->addr + 6);
-	outb(reg >> 8, data->addr + 7);
-
-	/* Execute the Random Access Command */
-	outb(0x01, data->addr); /* Write 01h to the Host-to-EC register */
-
-	/* EM Interface Polling "Algorithm" */
-	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
-		if (i >=3D max_busy_polls)
-			msleep(1);
-		/* Read Interrupt source Register */
-		val =3D inb(data->addr + 8);
-		/* Write Clear the interrupt source bits */
-		if (val)
-			outb(val, data->addr + 8);
-		/* Command Completed ? */
-		if (val & 0x01)
-			break;
-	}
-	if (i =3D max_busy_polls + max_lazy_polls) {
-		pr_err("Max retries exceeded reading virtual "
-		       "register 0x%04hx (%d)\n", reg, 1);
-		return -EIO;
-	}
-
-	/*
-	 * According to SMSC we may need to retry this, but sofar I've always
-	 * seen this succeed in 1 try.
-	 */
-	for (i =3D 0; i < max_busy_polls; i++) {
-		/* Read EC-to-Host Register */
-		val =3D inb(data->addr + 1);
-		/* Command Completed ? */
-		if (val =3D 0x01)
-			break;
-
-		if (i =3D 0)
-			pr_warn("EC reports: 0x%02x reading virtual register "
-				"0x%04hx\n", (unsigned int)val, reg);
-	}
-	if (i =3D max_busy_polls) {
-		pr_err("Max retries exceeded reading virtual "
-		       "register 0x%04hx (%d)\n", reg, 2);
-		return -EIO;
-	}
-
-	/*
-	 * According to the SMSC app note we should now do:
-	 *
-	 * Set Mailbox Address Pointer to first location in Region 1 *
-	 * outb(0x00, data->addr + 2);
-	 * outb(0x80, data->addr + 3);
-	 *
-	 * But if we do that things don't work, so let's not.
-	 */
-
-	/* Read Value field */
-	if (cmd =3D SCH5627_CMD_READ)
-		return inb(data->addr + 4);
-
-	return 0;
-}
-
-static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
-{
-	return sch5627_send_cmd(data, SCH5627_CMD_READ, reg, 0);
-}
-
-static int sch5627_write_virtual_reg(struct sch5627_data *data,
-				     u16 reg, u8 val)
-{
-	return sch5627_send_cmd(data, SCH5627_CMD_WRITE, reg, val);
-}
-
-static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
-{
-	int lsb, msb;
-
-	/* Read LSB first, this will cause the matching MSB to be latched */
-	lsb =3D sch5627_read_virtual_reg(data, reg);
-	if (lsb < 0)
-		return lsb;
-
-	msb =3D sch5627_read_virtual_reg(data, reg + 1);
-	if (msb < 0)
-		return msb;
-
-	return lsb | (msb << 8);
-}
-
-static int sch5627_read_virtual_reg12(struct sch5627_data *data, u16 msb_r=
eg,
-				      u16 lsn_reg, int high_nibble)
-{
-	int msb, lsn;
-
-	/* Read MSB first, this will cause the matching LSN to be latched */
-	msb =3D sch5627_read_virtual_reg(data, msb_reg);
-	if (msb < 0)
-		return msb;
-
-	lsn =3D sch5627_read_virtual_reg(data, lsn_reg);
-	if (lsn < 0)
-		return lsn;
-
-	if (high_nibble)
-		return (msb << 4) | (lsn >> 4);
-	else
-		return (msb << 4) | (lsn & 0x0f);
-}
-
 static struct sch5627_data *sch5627_update_device(struct device *dev)
 {
 	struct sch5627_data *data =3D dev_get_drvdata(dev);
@@ -297,7 +103,7 @@ static struct sch5627_data *sch5627_update_device(struc=
t device *dev)
=20
 	/* Trigger a Vbat voltage measurement every 5 minutes */
 	if (time_after(jiffies, data->last_battery + 300 * HZ)) {
-		sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
+		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
 					  data->control | 0x10);
 		data->last_battery =3D jiffies;
 	}
@@ -305,7 +111,7 @@ static struct sch5627_data *sch5627_update_device(struc=
t device *dev)
 	/* Cache the values for 1 second */
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		for (i =3D 0; i < SCH5627_NO_TEMPS; i++) {
-			val =3D sch5627_read_virtual_reg12(data,
+			val =3D sch56xx_read_virtual_reg12(data->addr,
 				SCH5627_REG_TEMP_MSB[i],
 				SCH5627_REG_TEMP_LSN[i],
 				SCH5627_REG_TEMP_HIGH_NIBBLE[i]);
@@ -317,7 +123,7 @@ static struct sch5627_data *sch5627_update_device(struc=
t device *dev)
 		}
=20
 		for (i =3D 0; i < SCH5627_NO_FANS; i++) {
-			val =3D sch5627_read_virtual_reg16(data,
+			val =3D sch56xx_read_virtual_reg16(data->addr,
 							 SCH5627_REG_FAN[i]);
 			if (unlikely(val < 0)) {
 				ret =3D ERR_PTR(val);
@@ -327,7 +133,7 @@ static struct sch5627_data *sch5627_update_device(struc=
t device *dev)
 		}
=20
 		for (i =3D 0; i < SCH5627_NO_IN; i++) {
-			val =3D sch5627_read_virtual_reg12(data,
+			val =3D sch56xx_read_virtual_reg12(data->addr,
 				SCH5627_REG_IN_MSB[i],
 				SCH5627_REG_IN_LSN[i],
 				SCH5627_REG_IN_HIGH_NIBBLE[i]);
@@ -355,18 +161,21 @@ static int __devinit sch5627_read_limits(struct sch56=
27_data *data)
 		 * Note what SMSC calls ABS, is what lm_sensors calls max
 		 * (aka high), and HIGH is what lm_sensors calls crit.
 		 */
-		val =3D sch5627_read_virtual_reg(data, SCH5627_REG_TEMP_ABS[i]);
+		val =3D sch56xx_read_virtual_reg(data->addr,
+					       SCH5627_REG_TEMP_ABS[i]);
 		if (val < 0)
 			return val;
 		data->temp_max[i] =3D val;
=20
-		val =3D sch5627_read_virtual_reg(data, SCH5627_REG_TEMP_HIGH[i]);
+		val =3D sch56xx_read_virtual_reg(data->addr,
+					       SCH5627_REG_TEMP_HIGH[i]);
 		if (val < 0)
 			return val;
 		data->temp_crit[i] =3D val;
 	}
 	for (i =3D 0; i < SCH5627_NO_FANS; i++) {
-		val =3D sch5627_read_virtual_reg16(data, SCH5627_REG_FAN_MIN[i]);
+		val =3D sch56xx_read_virtual_reg16(data->addr,
+						 SCH5627_REG_FAN_MIN[i]);
 		if (val < 0)
 			return val;
 		data->fan_min[i] =3D val;
@@ -667,7 +476,7 @@ static int __devinit sch5627_probe(struct platform_devi=
ce *pdev)
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
=20
-	val =3D sch5627_read_virtual_reg(data, SCH5627_REG_HWMON_ID);
+	val =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_HWMON_ID);
 	if (val < 0) {
 		err =3D val;
 		goto error;
@@ -679,7 +488,7 @@ static int __devinit sch5627_probe(struct platform_devi=
ce *pdev)
 		goto error;
 	}
=20
-	val =3D sch5627_read_virtual_reg(data, SCH5627_REG_COMPANY_ID);
+	val =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_COMPANY_ID);
 	if (val < 0) {
 		err =3D val;
 		goto error;
@@ -691,7 +500,7 @@ static int __devinit sch5627_probe(struct platform_devi=
ce *pdev)
 		goto error;
 	}
=20
-	val =3D sch5627_read_virtual_reg(data, SCH5627_REG_PRIMARY_ID);
+	val =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PRIMARY_ID);
 	if (val < 0) {
 		err =3D val;
 		goto error;
@@ -703,25 +512,28 @@ static int __devinit sch5627_probe(struct platform_de=
vice *pdev)
 		goto error;
 	}
=20
-	build_code =3D sch5627_read_virtual_reg(data, SCH5627_REG_BUILD_CODE);
+	build_code =3D sch56xx_read_virtual_reg(data->addr,
+					      SCH5627_REG_BUILD_CODE);
 	if (build_code < 0) {
 		err =3D build_code;
 		goto error;
 	}
=20
-	build_id =3D sch5627_read_virtual_reg16(data, SCH5627_REG_BUILD_ID);
+	build_id =3D sch56xx_read_virtual_reg16(data->addr,
+					      SCH5627_REG_BUILD_ID);
 	if (build_id < 0) {
 		err =3D build_id;
 		goto error;
 	}
=20
-	hwmon_rev =3D sch5627_read_virtual_reg(data, SCH5627_REG_HWMON_REV);
+	hwmon_rev =3D sch56xx_read_virtual_reg(data->addr,
+					     SCH5627_REG_HWMON_REV);
 	if (hwmon_rev < 0) {
 		err =3D hwmon_rev;
 		goto error;
 	}
=20
-	val =3D sch5627_read_virtual_reg(data, SCH5627_REG_CTRL);
+	val =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_CTRL);
 	if (val < 0) {
 		err =3D val;
 		goto error;
@@ -734,7 +546,7 @@ static int __devinit sch5627_probe(struct platform_devi=
ce *pdev)
 	}
 	/* Trigger a Vbat voltage measurement, so that we get a valid reading
 	   the first time we read Vbat */
-	sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
+	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
 				  data->control | 0x10);
 	data->last_battery =3D jiffies;
=20
@@ -746,6 +558,7 @@ static int __devinit sch5627_probe(struct platform_devi=
ce *pdev)
 	if (err)
 		goto error;
=20
+	pr_info("found %s chip at %#hx\n", DEVNAME, data->addr);
 	pr_info("firmware build: code 0x%02X, id 0x%04X, hwmon: rev 0x%02X\n",
 		build_code, build_id, hwmon_rev);
=20
@@ -768,85 +581,6 @@ error:
 	return err;
 }
=20
-static int __init sch5627_find(int sioaddr, unsigned short *address)
-{
-	u8 devid;
-	int err =3D superio_enter(sioaddr);
-	if (err)
-		return err;
-
-	devid =3D superio_inb(sioaddr, SIO_REG_DEVID);
-	if (devid !=3D SIO_SCH5627_ID) {
-		pr_debug("Unsupported device id: 0x%02x\n",
-			 (unsigned int)devid);
-		err =3D -ENODEV;
-		goto exit;
-	}
-
-	superio_select(sioaddr, SIO_SCH5627_EM_LD);
-
-	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
-		pr_warn("Device not activated\n");
-		err =3D -ENODEV;
-		goto exit;
-	}
-
-	/*
-	 * Warning the order of the low / high byte is the other way around
-	 * as on most other superio devices!!
-	 */
-	*address =3D superio_inb(sioaddr, SIO_REG_ADDR) |
-		   superio_inb(sioaddr, SIO_REG_ADDR + 1) << 8;
-	if (*address =3D 0) {
-		pr_warn("Base address not set\n");
-		err =3D -ENODEV;
-		goto exit;
-	}
-
-	pr_info("Found %s chip at %#hx\n", DEVNAME, *address);
-exit:
-	superio_exit(sioaddr);
-	return err;
-}
-
-static int __init sch5627_device_add(unsigned short address)
-{
-	struct resource res =3D {
-		.start	=3D address,
-		.end	=3D address + REGION_LENGTH - 1,
-		.flags	=3D IORESOURCE_IO,
-	};
-	int err;
-
-	sch5627_pdev =3D platform_device_alloc(DRVNAME, address);
-	if (!sch5627_pdev)
-		return -ENOMEM;
-
-	res.name =3D sch5627_pdev->name;
-	err =3D acpi_check_resource_conflict(&res);
-	if (err)
-		goto exit_device_put;
-
-	err =3D platform_device_add_resources(sch5627_pdev, &res, 1);
-	if (err) {
-		pr_err("Device resource addition failed\n");
-		goto exit_device_put;
-	}
-
-	err =3D platform_device_add(sch5627_pdev);
-	if (err) {
-		pr_err("Device addition failed\n");
-		goto exit_device_put;
-	}
-
-	return 0;
-
-exit_device_put:
-	platform_device_put(sch5627_pdev);
-
-	return err;
-}
-
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.owner	=3D THIS_MODULE,
@@ -858,31 +592,11 @@ static struct platform_driver sch5627_driver =3D {
=20
 static int __init sch5627_init(void)
 {
-	int err =3D -ENODEV;
-	unsigned short address;
-
-	if (sch5627_find(0x4e, &address) && sch5627_find(0x2e, &address))
-		goto exit;
-
-	err =3D platform_driver_register(&sch5627_driver);
-	if (err)
-		goto exit;
-
-	err =3D sch5627_device_add(address);
-	if (err)
-		goto exit_driver;
-
-	return 0;
-
-exit_driver:
-	platform_driver_unregister(&sch5627_driver);
-exit:
-	return err;
+	return platform_driver_register(&sch5627_driver);
 }
=20
 static void __exit sch5627_exit(void)
 {
-	platform_device_unregister(sch5627_pdev);
 	platform_driver_unregister(&sch5627_driver);
 }
=20
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
new file mode 100644
index 0000000..c610b5f
--- /dev/null
+++ b/drivers/hwmon/sch56xx-common.c
@@ -0,0 +1,336 @@
+/*************************************************************************=
**
+ *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>          =
 *
+ *                                                                        =
 *
+ *   This program is free software; you can redistribute it and/or modify =
 *
+ *   it under the terms of the GNU General Public License as published by =
 *
+ *   the Free Software Foundation; either version 2 of the License, or    =
 *
+ *   (at your option) any later version.                                  =
 *
+ *                                                                        =
 *
+ *   This program is distributed in the hope that it will be useful,      =
 *
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of       =
 *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        =
 *
+ *   GNU General Public License for more details.                         =
 *
+ *                                                                        =
 *
+ *   You should have received a copy of the GNU General Public License    =
 *
+ *   along with this program; if not, write to the                        =
 *
+ *   Free Software Foundation, Inc.,                                      =
 *
+ *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.            =
 *
+ *************************************************************************=
**/
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include "sch56xx-common.h"
+
+#define SIO_SCH56XX_LD_EM	0x0C	/* Embedded =C5=B3Controller Logical Dev */
+#define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
+
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID */
+#define SIO_REG_ENABLE		0x30	/* Logical device enable */
+#define SIO_REG_ADDR		0x66	/* Logical device address (2 bytes) */
+
+#define SIO_SCH5627_ID		0xC6	/* Chipset ID */
+
+#define REGION_LENGTH		9
+
+#define SCH56XX_CMD_READ	0x02
+#define SCH56XX_CMD_WRITE	0x03
+
+static struct platform_device *sch56xx_pdev;
+
+/* Super I/O functions */
+static inline int superio_inb(int base, int reg)
+{
+	outb(reg, base);
+	return inb(base + 1);
+}
+
+static inline int superio_enter(int base)
+{
+	/* Don't step on other drivers' I/O space by accident */
+	if (!request_muxed_region(base, 2, "sch56xx")) {
+		pr_err("I/O address 0x%04x already in use\n", base);
+		return -EBUSY;
+	}
+
+	outb(SIO_UNLOCK_KEY, base);
+
+	return 0;
+}
+
+static inline void superio_select(int base, int ld)
+{
+	outb(SIO_REG_LDSEL, base);
+	outb(ld, base + 1);
+}
+
+static inline void superio_exit(int base)
+{
+	outb(SIO_LOCK_KEY, base);
+	release_region(base, 2);
+}
+
+static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg, u8 v)
+{
+	u8 val;
+	int i;
+	/*
+	 * According to SMSC for the commands we use the maximum time for
+	 * the EM to respond is 15 ms, but testing shows in practice it
+	 * responds within 15-32 reads, so we first busy poll, and if
+	 * that fails sleep a bit and try again until we are way past
+	 * the 15 ms maximum response time.
+	 */
+	const int max_busy_polls =3D 64;
+	const int max_lazy_polls =3D 32;
+
+	/* (Optional) Write-Clear the EC to Host Mailbox Register */
+	val =3D inb(addr + 1);
+	outb(val, addr + 1);
+
+	/* Set Mailbox Address Pointer to first location in Region 1 */
+	outb(0x00, addr + 2);
+	outb(0x80, addr + 3);
+
+	/* Write Request Packet Header */
+	outb(cmd, addr + 4); /* VREG Access Type read:0x02 write:0x03 */
+	outb(0x01, addr + 5); /* # of Entries: 1 Byte (8-bit) */
+	outb(0x04, addr + 2); /* Mailbox AP to first data entry loc. */
+
+	/* Write Value field */
+	if (cmd =3D SCH56XX_CMD_WRITE)
+		outb(v, addr + 4);
+
+	/* Write Address field */
+	outb(reg & 0xff, addr + 6);
+	outb(reg >> 8, addr + 7);
+
+	/* Execute the Random Access Command */
+	outb(0x01, addr); /* Write 01h to the Host-to-EC register */
+
+	/* EM Interface Polling "Algorithm" */
+	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
+		if (i >=3D max_busy_polls)
+			msleep(1);
+		/* Read Interrupt source Register */
+		val =3D inb(addr + 8);
+		/* Write Clear the interrupt source bits */
+		if (val)
+			outb(val, addr + 8);
+		/* Command Completed ? */
+		if (val & 0x01)
+			break;
+	}
+	if (i =3D max_busy_polls + max_lazy_polls) {
+		pr_err("Max retries exceeded reading virtual "
+		       "register 0x%04hx (%d)\n", reg, 1);
+		return -EIO;
+	}
+
+	/*
+	 * According to SMSC we may need to retry this, but sofar I've always
+	 * seen this succeed in 1 try.
+	 */
+	for (i =3D 0; i < max_busy_polls; i++) {
+		/* Read EC-to-Host Register */
+		val =3D inb(addr + 1);
+		/* Command Completed ? */
+		if (val =3D 0x01)
+			break;
+
+		if (i =3D 0)
+			pr_warn("EC reports: 0x%02x reading virtual register "
+				"0x%04hx\n", (unsigned int)val, reg);
+	}
+	if (i =3D max_busy_polls) {
+		pr_err("Max retries exceeded reading virtual "
+		       "register 0x%04hx (%d)\n", reg, 2);
+		return -EIO;
+	}
+
+	/*
+	 * According to the SMSC app note we should now do:
+	 *
+	 * Set Mailbox Address Pointer to first location in Region 1 *
+	 * outb(0x00, addr + 2);
+	 * outb(0x80, addr + 3);
+	 *
+	 * But if we do that things don't work, so let's not.
+	 */
+
+	/* Read Value field */
+	if (cmd =3D SCH56XX_CMD_READ)
+		return inb(addr + 4);
+
+	return 0;
+}
+
+int sch56xx_read_virtual_reg(u16 addr, u16 reg)
+{
+	return sch56xx_send_cmd(addr, SCH56XX_CMD_READ, reg, 0);
+}
+EXPORT_SYMBOL(sch56xx_read_virtual_reg);
+
+int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val)
+{
+	return sch56xx_send_cmd(addr, SCH56XX_CMD_WRITE, reg, val);
+}
+EXPORT_SYMBOL(sch56xx_write_virtual_reg);
+
+int sch56xx_read_virtual_reg16(u16 addr, u16 reg)
+{
+	int lsb, msb;
+
+	/* Read LSB first, this will cause the matching MSB to be latched */
+	lsb =3D sch56xx_read_virtual_reg(addr, reg);
+	if (lsb < 0)
+		return lsb;
+
+	msb =3D sch56xx_read_virtual_reg(addr, reg + 1);
+	if (msb < 0)
+		return msb;
+
+	return lsb | (msb << 8);
+}
+EXPORT_SYMBOL(sch56xx_read_virtual_reg16);
+
+int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
+			       int high_nibble)
+{
+	int msb, lsn;
+
+	/* Read MSB first, this will cause the matching LSN to be latched */
+	msb =3D sch56xx_read_virtual_reg(addr, msb_reg);
+	if (msb < 0)
+		return msb;
+
+	lsn =3D sch56xx_read_virtual_reg(addr, lsn_reg);
+	if (lsn < 0)
+		return lsn;
+
+	if (high_nibble)
+		return (msb << 4) | (lsn >> 4);
+	else
+		return (msb << 4) | (lsn & 0x0f);
+}
+EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
+
+static int __init sch56xx_find(int sioaddr, unsigned short *address,
+			       const char **name)
+{
+	u8 devid;
+	int err;
+
+	err =3D superio_enter(sioaddr);
+	if (err)
+		return err;
+
+	devid =3D superio_inb(sioaddr, SIO_REG_DEVID);
+	switch (devid) {
+	case SIO_SCH5627_ID:
+		*name =3D "sch5627";
+		break;
+	default:
+		pr_debug("Unsupported device id: 0x%02x\n",
+			 (unsigned int)devid);
+		err =3D -ENODEV;
+		goto exit;
+	}
+
+	superio_select(sioaddr, SIO_SCH56XX_LD_EM);
+
+	if (!(superio_inb(sioaddr, SIO_REG_ENABLE) & 0x01)) {
+		pr_warn("Device not activated\n");
+		err =3D -ENODEV;
+		goto exit;
+	}
+
+	/*
+	 * Warning the order of the low / high byte is the other way around
+	 * as on most other superio devices!!
+	 */
+	*address =3D superio_inb(sioaddr, SIO_REG_ADDR) |
+		   superio_inb(sioaddr, SIO_REG_ADDR + 1) << 8;
+	if (*address =3D 0) {
+		pr_warn("Base address not set\n");
+		err =3D -ENODEV;
+		goto exit;
+	}
+
+exit:
+	superio_exit(sioaddr);
+	return err;
+}
+
+static int __init sch56xx_device_add(unsigned short address, const char *n=
ame)
+{
+	struct resource res =3D {
+		.start	=3D address,
+		.end	=3D address + REGION_LENGTH - 1,
+		.flags	=3D IORESOURCE_IO,
+	};
+	int err;
+
+	sch56xx_pdev =3D platform_device_alloc(name, address);
+	if (!sch56xx_pdev)
+		return -ENOMEM;
+
+	res.name =3D sch56xx_pdev->name;
+	err =3D acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit_device_put;
+
+	err =3D platform_device_add_resources(sch56xx_pdev, &res, 1);
+	if (err) {
+		pr_err("Device resource addition failed\n");
+		goto exit_device_put;
+	}
+
+	err =3D platform_device_add(sch56xx_pdev);
+	if (err) {
+		pr_err("Device addition failed\n");
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(sch56xx_pdev);
+
+	return err;
+}
+
+static int __init sch56xx_init(void)
+{
+	int err;
+	unsigned short address;
+	const char *name;
+
+	err =3D sch56xx_find(0x4e, &address, &name);
+	if (err)
+		err =3D sch56xx_find(0x2e, &address, &name);
+	if (err)
+		return err;
+
+	return sch56xx_device_add(address, name);
+}
+
+static void __exit sch56xx_exit(void)
+{
+	platform_device_unregister(sch56xx_pdev);
+}
+
+MODULE_DESCRIPTION("SMSC SCH56xx Hardware Monitoring Common Code");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL");
+
+module_init(sch56xx_init);
+module_exit(sch56xx_exit);
diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common.h
new file mode 100644
index 0000000..d5eaf3b
--- /dev/null
+++ b/drivers/hwmon/sch56xx-common.h
@@ -0,0 +1,24 @@
+/*************************************************************************=
**
+ *   Copyright (C) 2010-2011 Hans de Goede <hdegoede@redhat.com>          =
 *
+ *                                                                        =
 *
+ *   This program is free software; you can redistribute it and/or modify =
 *
+ *   it under the terms of the GNU General Public License as published by =
 *
+ *   the Free Software Foundation; either version 2 of the License, or    =
 *
+ *   (at your option) any later version.                                  =
 *
+ *                                                                        =
 *
+ *   This program is distributed in the hope that it will be useful,      =
 *
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of       =
 *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        =
 *
+ *   GNU General Public License for more details.                         =
 *
+ *                                                                        =
 *
+ *   You should have received a copy of the GNU General Public License    =
 *
+ *   along with this program; if not, write to the                        =
 *
+ *   Free Software Foundation, Inc.,                                      =
 *
+ *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.            =
 *
+ *************************************************************************=
**/
+
+int sch56xx_read_virtual_reg(u16 addr, u16 reg);
+int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val);
+int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
+int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
+			       int high_nibble);
--=20
1.7.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
