From: Rodolfo Giometti <giometti@enneenne.com>
Date: Fri, 18 Sep 2009 12:09:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090918120923.GR19578@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7845154980418041296=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============7845154980418041296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyOXVFQXzAE23HDB"
Content-Disposition: inline


--RyOXVFQXzAE23HDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

this new proposal patch sounds better to you? :)

Ciao,

Rodolfo

--

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..bc7058f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -894,6 +894,7 @@ config SENSORS_W83L786NG
=20
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	depends on 83627HF
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 389150b..4757668 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -51,18 +51,10 @@
 #include <linux/mutex.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "lm75.h"
+#include <linux/mfd/w83627hf.h>
=20
-static struct platform_device *pdev;
-
-#define DRVNAME "w83627hf"
-enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
-
-static u16 force_addr;
-module_param(force_addr, ushort, 0);
-MODULE_PARM_DESC(force_addr,
-		 "Initialize the base address of the sensors");
 static u8 force_i2c =3D 0x1f;
 module_param(force_i2c, byte, 0);
 MODULE_PARM_DESC(force_i2c,
@@ -72,92 +64,8 @@ static int init =3D 1;
 module_param(init, bool, 0);
 MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");
=20
-static unsigned short force_id;
-module_param(force_id, ushort, 0);
-MODULE_PARM_DESC(force_id, "Override the detected device ID");
-
-/* modified from kernel/include/traps.c */
-static int REG;		/* The register to read/write */
-#define	DEV	0x07	/* Register: Logical device select */
-static int VAL;		/* The value to read/write */
-
-/* logical device numbers for superio_select (below) */
-#define W83627HF_LD_FDC		0x00
-#define W83627HF_LD_PRT		0x01
-#define W83627HF_LD_UART1	0x02
-#define W83627HF_LD_UART2	0x03
-#define W83627HF_LD_KBC		0x05
-#define W83627HF_LD_CIR		0x06 /* w83627hf only */
-#define W83627HF_LD_GAME	0x07
-#define W83627HF_LD_MIDI	0x07
-#define W83627HF_LD_GPIO1	0x07
-#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
-#define W83627HF_LD_GPIO2	0x08
-#define W83627HF_LD_GPIO3	0x09
-#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
-#define W83627HF_LD_ACPI	0x0a
-#define W83627HF_LD_HWM		0x0b
-
-#define	DEVID	0x20	/* Register: Device ID */
-
-#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
-#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
-#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
-
-#define W83687THF_VID_EN	0x29 /* w83687thf only */
-#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
-#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
-
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
-
-static inline void
-superio_select(int ld)
-{
-	outb(DEV, REG);
-	outb(ld, VAL);
-}
-
-static inline void
-superio_enter(void)
-{
-	outb(0x87, REG);
-	outb(0x87, REG);
-}
-
-static inline void
-superio_exit(void)
-{
-	outb(0xAA, REG);
-}
-
-#define W627_DEVID 0x52
-#define W627THF_DEVID 0x82
-#define W697_DEVID 0x60
-#define W637_DEVID 0x70
-#define W687THF_DEVID 0x85
-#define WINB_ACT_REG 0x30
-#define WINB_BASE_REG 0x60
 /* Constants specified below */
=20
-/* Alignment of the base address */
-#define WINB_ALIGNMENT		~7
-
-/* Offset & size of I/O region we are interested in */
-#define WINB_REGION_OFFSET	5
-#define WINB_REGION_SIZE	2
-
 /* Where are the sensors address/data registers relative to the region off=
set */
 #define W83781D_ADDR_REG_OFFSET 0
 #define W83781D_DATA_REG_OFFSET 1
@@ -380,10 +288,6 @@ struct w83627hf_data {
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
=20
-struct w83627hf_sio_data {
-	enum chips type;
-};
-
=20
 static int w83627hf_probe(struct platform_device *pdev);
 static int __devexit w83627hf_remove(struct platform_device *pdev);
@@ -397,7 +301,7 @@ static void w83627hf_init_device(struct platform_device=
 *pdev);
 static struct platform_driver w83627hf_driver =3D {
 	.driver =3D {
 		.owner	=3D THIS_MODULE,
-		.name	=3D DRVNAME,
+		.name	=3D DRVNAME "_hwmon",
 	},
 	.probe		=3D w83627hf_probe,
 	.remove		=3D __devexit_p(w83627hf_remove),
@@ -1126,80 +1030,6 @@ show_name(struct device *dev, struct device_attribut=
e *devattr, char *buf)
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
=20
-static int __init w83627hf_find(int sioaddr, unsigned short *addr,
-				struct w83627hf_sio_data *sio_data)
-{
-	int err =3D -ENODEV;
-	u16 val;
-
-	static const __initdata char *names[] =3D {
-		"W83627HF",
-		"W83627THF",
-		"W83697HF",
-		"W83637HF",
-		"W83687THF",
-	};
-
-	REG =3D sioaddr;
-	VAL =3D sioaddr + 1;
-
-	superio_enter();
-	val =3D force_id ? force_id : superio_inb(DEVID);
-	switch (val) {
-	case W627_DEVID:
-		sio_data->type =3D w83627hf;
-		break;
-	case W627THF_DEVID:
-		sio_data->type =3D w83627thf;
-		break;
-	case W697_DEVID:
-		sio_data->type =3D w83697hf;
-		break;
-	case W637_DEVID:
-		sio_data->type =3D w83637hf;
-		break;
-	case W687THF_DEVID:
-		sio_data->type =3D w83687thf;
-		break;
-	case 0xff:	/* No device at all */
-		goto exit;
-	default:
-		pr_debug(DRVNAME ": Unsupported chip (DEVID=3D0x%02x)\n", val);
-		goto exit;
-	}
-
-	superio_select(W83627HF_LD_HWM);
-	force_addr &=3D WINB_ALIGNMENT;
-	if (force_addr) {
-		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
-		       force_addr);
-		superio_outb(WINB_BASE_REG, force_addr >> 8);
-		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
-	}
-	val =3D (superio_inb(WINB_BASE_REG) << 8) |
-	       superio_inb(WINB_BASE_REG + 1);
-	*addr =3D val & WINB_ALIGNMENT;
-	if (*addr =3D=3D 0) {
-		printk(KERN_WARNING DRVNAME ": Base address not set, "
-		       "skipping\n");
-		goto exit;
-	}
-
-	val =3D superio_inb(WINB_ACT_REG);
-	if (!(val & 0x01)) {
-		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
-		superio_outb(WINB_ACT_REG, val | 0x01);
-	}
-
-	err =3D 0;
-	pr_info(DRVNAME ": Found %s chip at %#x\n",
-		names[sio_data->type], *addr);
-
- exit:
-	superio_exit();
-	return err;
-}
-
 #define VIN_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
 	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
@@ -1281,20 +1111,17 @@ static const struct attribute_group w83627hf_group_=
opt =3D {
 static int __devinit w83627hf_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct w83627hf_sio_data *sio_data =3D dev->platform_data;
+	struct w83627hf_sio_data *sio_data =3D dev->parent->platform_data;
 	struct w83627hf_data *data;
 	struct resource *res;
 	int err, i;
=20
-	static const char *names[] =3D {
-		"w83627hf",
-		"w83627thf",
-		"w83697hf",
-		"w83637hf",
-		"w83687thf",
-	};
-
 	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
+
+	err =3D acpi_check_resource_conflict(&res);
+	if (err)
+		goto ERROR0;
+
 	if (!request_region(res->start, WINB_REGION_SIZE, DRVNAME)) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)res->start,
@@ -1309,7 +1136,7 @@ static int __devinit w83627hf_probe(struct platform_d=
evice *pdev)
 	}
 	data->addr =3D res->start;
 	data->type =3D sio_data->type;
-	data->name =3D names[sio_data->type];
+	data->name =3D sio_data->name;
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
@@ -1511,20 +1338,22 @@ static int w83627hf_read_value(struct w83627hf_data=
 *data, u16 reg)
=20
 static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
+	struct w83627hf_sio_data *sio_data =3D dev->parent->platform_data;
 	int res =3D 0xff, sel;
=20
-	superio_enter();
-	superio_select(W83627HF_LD_GPIO5);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_GPIO5);
=20
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
 		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
 		goto exit;
 	}
=20
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
-	sel =3D superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
+	sel =3D superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
 	if ((sel & 0x1f) !=3D 0x1f) {
 		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
 			"function\n");
@@ -1532,37 +1361,39 @@ static int __devinit w83627thf_read_gpio5(struct pl=
atform_device *pdev)
 	}
=20
 	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
-	res =3D superio_inb(W83627THF_GPIO5_DR) & sel;
+	res =3D superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
=20
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
=20
 static int __devinit w83687thf_read_vid(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
+	struct w83627hf_sio_data *sio_data =3D dev->parent->platform_data;
 	int res =3D 0xff;
=20
-	superio_enter();
-	superio_select(W83627HF_LD_HWM);
+	superio_enter(sio_data);
+	superio_select(sio_data, W83627HF_LD_HWM);
=20
 	/* Make sure these GPIO pins are enabled */
-	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
 		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
 		goto exit;
 	}
=20
 	/* Make sure the pins are configured for input */
-	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
+	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
 		dev_dbg(&pdev->dev, "VID configured as output, "
 			"no VID function\n");
 		goto exit;
 	}
=20
-	res =3D superio_inb(W83687THF_VID_DATA) & 0x3f;
+	res =3D superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
=20
 exit:
-	superio_exit();
+	superio_exit(sio_data);
 	return res;
 }
=20
@@ -1783,94 +1614,20 @@ static struct w83627hf_data *w83627hf_update_device=
(struct device *dev)
 	return data;
 }
=20
-static int __init w83627hf_device_add(unsigned short address,
-				      const struct w83627hf_sio_data *sio_data)
-{
-	struct resource res =3D {
-		.start	=3D address + WINB_REGION_OFFSET,
-		.end	=3D address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
-		.name	=3D DRVNAME,
-		.flags	=3D IORESOURCE_IO,
-	};
-	int err;
-
-	err =3D acpi_check_resource_conflict(&res);
-	if (err)
-		goto exit;
-
-	pdev =3D platform_device_alloc(DRVNAME, address);
-	if (!pdev) {
-		err =3D -ENOMEM;
-		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
-		goto exit;
-	}
-
-	err =3D platform_device_add_resources(pdev, &res, 1);
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Device resource addition failed "
-		       "(%d)\n", err);
-		goto exit_device_put;
-	}
-
-	err =3D platform_device_add_data(pdev, sio_data,
-				       sizeof(struct w83627hf_sio_data));
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
-		goto exit_device_put;
-	}
-
-	err =3D platform_device_add(pdev);
-	if (err) {
-		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
-		       err);
-		goto exit_device_put;
-	}
-
-	return 0;
-
-exit_device_put:
-	platform_device_put(pdev);
-exit:
-	return err;
-}
-
 static int __init sensors_w83627hf_init(void)
 {
-	int err;
-	unsigned short address;
-	struct w83627hf_sio_data sio_data;
-
-	if (w83627hf_find(0x2e, &address, &sio_data)
-	 && w83627hf_find(0x4e, &address, &sio_data))
-		return -ENODEV;
-
-	err =3D platform_driver_register(&w83627hf_driver);
-	if (err)
-		goto exit;
-
-	/* Sets global pdev as a side effect */
-	err =3D w83627hf_device_add(address, &sio_data);
-	if (err)
-		goto exit_driver;
-
-	return 0;
-
-exit_driver:
-	platform_driver_unregister(&w83627hf_driver);
-exit:
-	return err;
+	return platform_driver_register(&w83627hf_driver);
 }
=20
 static void __exit sensors_w83627hf_exit(void)
 {
-	platform_device_unregister(pdev);
 	platform_driver_unregister(&w83627hf_driver);
 }
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
 	      "Philip Edelbrock <phil@netroedge.com>, "
 	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
-MODULE_DESCRIPTION("W83627HF driver");
+MODULE_DESCRIPTION("W83627HF hwmon driver");
 MODULE_LICENSE("GPL");
=20
 module_init(sensors_w83627hf_init);
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 491ac0f..784a892 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -263,6 +263,20 @@ config EZX_PCAP
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..
=20
+config MFD_W83627HF
+	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
+	help
+	  If you say yes here you add support for the Winbond W836X7 series
+	  of super-IO chips: the W83627HF, W83627THF, W83637HF, W83687THF and
+	  W83697HF to your platform.
+
+	  This is a multi functional device and this support defines a new
+	  platform device only. See other configuration submenus in order to
+	  enable the drivers of Winbond chip's functionalities.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83627hf-core.
+
 endmenu
=20
 menu "Multimedia Capabilities Port drivers"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 6f8a9a1..1401ac9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_TWL4030_CORE)	+=3D twl4030-core.o twl4030-ir=
q.o
 obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
=20
 obj-$(CONFIG_EZX_PCAP)		+=3D ezx-pcap.o
+obj-$(CONFIG_MFD_W83627HF)	+=3D w83627hf-core.o
=20
 obj-$(CONFIG_MCP)		+=3D mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+=3D mcp-sa11x0.o
diff --git a/drivers/mfd/w83627hf-core.c b/drivers/mfd/w83627hf-core.c
new file mode 100644
index 0000000..39b6190
--- /dev/null
+++ b/drivers/mfd/w83627hf-core.c
@@ -0,0 +1,236 @@
+/*
+ *  w83627hf.c - platform device support
+ *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
+ *
+ *  Based on drivers/hwmon/w83627hf.c
+ *
+ *  Original copyright note:
+ *    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
+ *    Philip Edelbrock <phil@netroedge.com>,
+ *    and Mark Studebaker <mdsxyz123@yahoo.com>
+ *    Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
+ *    Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *    GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/ioport.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/w83627hf.h>
+
+static u16 force_hwmon_addr;
+module_param(force_hwmon_addr, ushort, 0);
+MODULE_PARM_DESC(force_hwmon_addr,
+		 "Initialize the base address of the hwmon sensors");
+
+static unsigned short force_id;
+module_param(force_id, ushort, 0);
+MODULE_PARM_DESC(force_id, "Override the detected device ID");
+
+/*
+ * Devices definitions
+ */
+
+static struct platform_device *pdev;
+
+static char *names[] =3D {
+	"w83627hf",
+	"w83627thf",
+	"w83697hf",
+	"w83637hf",
+	"w83687thf",
+};
+
+static struct resource hwmon_res =3D {
+	/* .start  =3D ? - NOTE: set at runtime */
+	/* .end    =3D ? - NOTE: set at runtime */
+	.name   =3D DRVNAME "_hwmon",
+	.flags  =3D IORESOURCE_IO,
+};
+
+static struct mfd_cell cells[] =3D {
+	{
+		.name	   =3D DRVNAME "_hwmon",
+		.num_resources  =3D 1,
+		.resources      =3D &hwmon_res,
+	},
+};
+
+/*
+ * Local functions
+ */
+
+#define W627_DEVID		0x52
+#define W627THF_DEVID		0x82
+#define W697_DEVID		0x60
+#define W637_DEVID		0x70
+#define W687THF_DEVID		0x85
+#define WINB_ACT_REG		0x30
+#define WINB_BASE_REG		0x60
+/* Constants specified below */
+
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+static int __init w83627hf_find(int sioaddr, unsigned short *addr,
+				struct w83627hf_sio_data *sio_data)
+{
+	int err =3D -ENODEV;
+	u16 val;
+
+	sio_data->sioaddr =3D sioaddr;
+
+	superio_enter(sio_data);
+	val =3D force_id ? force_id : superio_inb(sio_data, 0x20);
+	switch (val) {
+	case W627_DEVID:
+		sio_data->type =3D w83627hf;
+		break;
+	case W627THF_DEVID:
+		sio_data->type =3D w83627thf;
+		break;
+	case W697_DEVID:
+		sio_data->type =3D w83697hf;
+		break;
+	case W637_DEVID:
+		sio_data->type =3D w83637hf;
+		break;
+	case W687THF_DEVID:
+		sio_data->type =3D w83687thf;
+		break;
+	case 0xff:	/* No device at all */
+		goto exit;
+	default:
+		pr_debug(DRVNAME ": Unsupported chip (DEVID=3D0x%02x)\n", val);
+		goto exit;
+	}
+
+	sio_data->name =3D names[sio_data->type];
+
+	superio_select(sio_data, W83627HF_LD_HWM);
+	force_hwmon_addr &=3D (~7);
+	if (force_hwmon_addr) {
+		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
+		       force_hwmon_addr);
+		superio_outb(sio_data, WINB_BASE_REG, force_hwmon_addr >> 8);
+		superio_outb(sio_data, WINB_BASE_REG + 1,
+					force_hwmon_addr & 0xff);
+	}
+	val =3D (superio_inb(sio_data, WINB_BASE_REG) << 8) |
+	       superio_inb(sio_data, WINB_BASE_REG + 1);
+	*addr =3D val & (~7);
+	if (*addr =3D=3D 0) {
+		printk(KERN_WARNING DRVNAME ": Base address not set, "
+		       "skipping\n");
+		goto exit;
+	}
+
+	val =3D superio_inb(sio_data, WINB_ACT_REG);
+	if (!(val & 0x01)) {
+		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
+		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
+	}
+
+	err =3D 0;
+	pr_info(DRVNAME ": Found %s chip at %#x\n",
+		names[sio_data->type], *addr);
+
+ exit:
+	superio_exit(sio_data);
+	return err;
+}
+
+static int __init w83627hf_device_add(unsigned short address,
+				      const struct w83627hf_sio_data *sio_data)
+{
+	int err;
+
+	hwmon_res.start =3D address + WINB_REGION_OFFSET;
+	hwmon_res.end =3D address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1;
+
+	pdev =3D platform_device_alloc(DRVNAME, address);
+	if (!pdev) {
+		err =3D -ENOMEM;
+		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
+		goto exit;
+	}
+
+	err =3D platform_device_add_data(pdev, sio_data,
+				       sizeof(struct w83627hf_sio_data));
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
+		goto exit_device_put;
+	}
+
+	err =3D platform_device_add(pdev);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
+		       err);
+		goto exit_device_put;
+	}
+
+	err =3D mfd_add_devices(&pdev->dev, pdev->id, cells, ARRAY_SIZE(cells),
+			(struct resource *) (address & 0xffff), -1);
+	if (err) {
+		printk(KERN_ERR DRVNAME ": Cannot add sub devices (%d)\n",
+			err);
+		goto exit_device_unregister;
+	}
+
+	return 0;
+
+exit_device_unregister:
+	platform_device_unregister(pdev);
+exit_device_put:
+	platform_device_put(pdev);
+exit:
+	return err;
+}
+
+static int __init w83627hf_init(void)
+{
+	unsigned short address;
+	struct w83627hf_sio_data sio_data;
+
+	mutex_init(&sio_data.lock);
+
+	if (w83627hf_find(0x2e, &address, &sio_data)
+	 && w83627hf_find(0x4e, &address, &sio_data))
+		return -ENODEV;
+
+	/* Sets global pdev as a side effect */
+	return w83627hf_device_add(address, &sio_data);
+}
+
+static void __exit w83627hf_exit(void)
+{
+	mfd_remove_devices(&pdev->dev);
+	platform_device_unregister(pdev);
+}
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
+MODULE_DESCRIPTION("W83627HF platform devices definitions");
+MODULE_LICENSE("GPL");
+
+module_init(w83627hf_init);
+module_exit(w83627hf_exit);
diff --git a/include/linux/mfd/w83627hf.h b/include/linux/mfd/w83627hf.h
new file mode 100644
index 0000000..c9f537d
--- /dev/null
+++ b/include/linux/mfd/w83627hf.h
@@ -0,0 +1,112 @@
+/*
+ *  w83627hf.h - platform device support, header file
+ *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/mutex.h>
+#include <linux/io.h>
+
+#define DRVNAME "w83627hf"
+
+enum chips {
+	w83627hf,
+	w83627thf,
+	w83697hf,
+	w83637hf,
+	w83687thf
+};
+
+struct w83627hf_sio_data {
+	int sioaddr;
+	enum chips type;
+	char *name;
+
+	struct mutex lock;
+};
+
+/* logical device numbers for superio_select (below) */
+#define W83627HF_LD_FDC		0x00
+#define W83627HF_LD_PRT		0x01
+#define W83627HF_LD_UART1	0x02
+#define W83627HF_LD_UART2	0x03
+#define W83627HF_LD_KBC		0x05
+#define W83627HF_LD_CIR		0x06 /* w83627hf only */
+#define W83627HF_LD_GAME	0x07
+#define W83627HF_LD_MIDI	0x07
+#define W83627HF_LD_GPIO1	0x07
+#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
+#define W83627HF_LD_GPIO2	0x08
+#define W83627HF_LD_GPIO3	0x09
+#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
+#define W83627HF_LD_ACPI	0x0a
+#define W83627HF_LD_HWM		0x0b
+
+#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
+#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
+#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
+
+#define W83687THF_VID_EN	0x29 /* w83687thf only */
+#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
+#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
+
+/*
+ * Common configuration registers access functions.
+ *
+ * These registers are special and they must me accessed by using a well
+ * specified protocol. Client drivers __must__ do as follow in order to
+ * get access correctly to these registers:
+ *
+ *	superio_enter()
+ *
+ *	superio_select()/superio_outb()/superio_inb()
+ *
+ *	superio_exit();
+ *
+ */
+
+static inline void superio_enter(struct w83627hf_sio_data *sio)
+{
+	mutex_lock(&sio->lock);
+
+	outb(0x87, sio->sioaddr);
+	outb(0x87, sio->sioaddr);
+}
+
+static inline void superio_select(struct w83627hf_sio_data *sio, int ld)
+{
+	outb(0x07, sio->sioaddr);
+	outb(ld, sio->sioaddr + 1);
+}
+
+static inline void superio_outb(struct w83627hf_sio_data *sio, int reg, in=
t val)
+{
+	outb(reg, sio->sioaddr);
+	outb(val, sio->sioaddr + 1);
+}
+
+static inline int superio_inb(struct w83627hf_sio_data *sio, int reg)
+{
+	outb(reg, sio->sioaddr);
+	return inb(sio->sioaddr + 1);
+}
+
+static inline void superio_exit(struct w83627hf_sio_data *sio)
+{
+	outb(0xAA, sio->sioaddr);
+
+	mutex_unlock(&sio->lock);
+}


--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--RyOXVFQXzAE23HDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqzeHMACgkQQaTCYNJaVjOdRACePqie2O/KeN7SR7wxzSEWUUuf
dmQAn2FxNWEr7RK3blcySxjfbLg+Tkk/
=3ojX
-----END PGP SIGNATURE-----

--RyOXVFQXzAE23HDB--


--===============7845154980418041296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7845154980418041296==--
