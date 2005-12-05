From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 05 Dec 2005 18:11:32 +0000
Subject: [lm-sensors] [PATCH 2/3] w1 : move master and slave code into
Message-Id: <808c8e9d0512051011q2dc21d45l8998f40d3cae1803@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Move w1 bus master code into 'w1/masters' and move w1 slave code into
'w1/slaves'.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/w1/Kconfig                |   60 --
 drivers/w1/Makefile               |   10=20
 drivers/w1/ds_w1_bridge.c         |  174 --------
 drivers/w1/dscore.c               |  795 ---------------------------------=
-----
 drivers/w1/dscore.h               |  166 -------
 drivers/w1/masters/Kconfig        |   38 +
 drivers/w1/masters/Makefile       |   11=20
 drivers/w1/masters/ds_w1_bridge.c |  174 ++++++++
 drivers/w1/masters/dscore.c       |  795 +++++++++++++++++++++++++++++++++=
+++++
 drivers/w1/masters/dscore.h       |  166 +++++++
 drivers/w1/masters/matrox_w1.c    |  247 +++++++++++
 drivers/w1/matrox_w1.c            |  247 -----------
 drivers/w1/slaves/Kconfig         |   38 +
 drivers/w1/slaves/Makefile        |   12=20
 drivers/w1/slaves/w1_ds2433.c     |  329 +++++++++++++++
 drivers/w1/slaves/w1_smem.c       |   71 +++
 drivers/w1/slaves/w1_therm.c      |  268 ++++++++++++
 drivers/w1/w1_ds2433.c            |  329 ---------------
 drivers/w1/w1_smem.c              |   71 ---
 drivers/w1/w1_therm.c             |  268 ------------
 20 files changed, 2152 insertions(+), 2117 deletions(-)

Index: linux-2.6.15-rc3-mm1/drivers/w1/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/Kconfig
+++ linux-2.6.15-rc3-mm1/drivers/w1/Kconfig
@@ -11,63 +11,7 @@ config W1
 	  This W1 support can also be built as a module.  If so, the module
 	  will be called wire.ko.
=20
-config W1_MATROX
-	tristate "Matrox G400 transport layer for 1-wire"
-	depends on W1 && PCI
-	help
-	  Say Y here if you want to communicate with your 1-wire devices
-	  using Matrox's G400 GPIO pins.
-
-	  This support is also available as a module.  If so, the module
-	  will be called matrox_w1.ko.
-
-config W1_DS9490
-	tristate "DS9490R transport layer driver"
-	depends on W1 && USB
-	help
-	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
-
-	  This support is also available as a module.  If so, the module
-	  will be called ds9490r.ko.
-
-config W1_DS9490_BRIDGE
-	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_DS9490
-	help
-	  Say Y here if you want to communicate with your 1-wire devices
-	  using DS9490R USB bridge.
-
-	  This support is also available as a module.  If so, the module
-	  will be called ds_w1_bridge.ko.
-
-config W1_THERM
-	tristate "Thermal family implementation"
-	depends on W1
-	help
-	  Say Y here if you want to connect 1-wire thermal sensors to you
-	  wire.
-
-config W1_SMEM
-	tristate "Simple 64bit memory family implementation"
-	depends on W1
-	help
-	  Say Y here if you want to connect 1-wire
-	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
-
-config W1_DS2433
-	tristate "4kb EEPROM family support (DS2433)"
-	depends on W1
-	help
-	  Say Y here if you want to use a 1-wire
-	  4kb EEPROM family device (DS2433).
-
-config W1_DS2433_CRC
-	bool "Protect DS2433 data with a CRC16"
-	depends on W1_DS2433
-	select CRC16
-	help
-	  Say Y here to protect DS2433 data with a CRC16.
-	  Each block has 30 bytes of data and a two byte CRC16.
-	  Full block writes are only allowed if the CRC is valid.
+source drivers/w1/masters/Kconfig
+source drivers/w1/slaves/Kconfig
=20
 endmenu
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/Kconfig
@@ -0,0 +1,38 @@
+#
+# 1-wire bus master configuration
+#
+
+menu "1-wire Bus Masters"
+	depends on W1
+
+config W1_MASTER_MATROX
+	tristate "Matrox G400 transport layer for 1-wire"
+	depends on W1 && PCI
+	help
+	  Say Y here if you want to communicate with your 1-wire devices
+	  using Matrox's G400 GPIO pins.
+
+	  This support is also available as a module.  If so, the module
+	  will be called matrox_w1.ko.
+
+config W1_MASTER_DS9490
+	tristate "DS9490R transport layer driver"
+	depends on W1 && USB
+	help
+	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
+
+	  This support is also available as a module.  If so, the module
+	  will be called ds9490r.ko.
+
+config W1_MASTER_DS9490_BRIDGE
+	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
+	depends on W1_DS9490
+	help
+	  Say Y here if you want to communicate with your 1-wire devices
+	  using DS9490R USB bridge.
+
+	  This support is also available as a module.  If so, the module
+	  will be called ds_w1_bridge.ko.
+
+endmenu
+
Index: linux-2.6.15-rc3-mm1/drivers/w1/slaves/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/slaves/Kconfig
@@ -0,0 +1,38 @@
+#
+# 1-wire slaves configuration
+#
+
+menu "1-wire Slaves"
+	depends on W1
+
+config W1_SLAVE_THERM
+	tristate "Thermal family implementation"
+	depends on W1
+	help
+	  Say Y here if you want to connect 1-wire thermal sensors to you
+	  wire.
+
+config W1_SLAVE_SMEM
+	tristate "Simple 64bit memory family implementation"
+	depends on W1
+	help
+	  Say Y here if you want to connect 1-wire
+	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
+
+config W1_SLAVE_DS2433
+	tristate "4kb EEPROM family support (DS2433)"
+	depends on W1
+	help
+	  Say Y here if you want to use a 1-wire
+	  4kb EEPROM family device (DS2433).
+
+config W1_SLAVE_DS2433_CRC
+	bool "Protect DS2433 data with a CRC16"
+	depends on W1_DS2433
+	select CRC16
+	help
+	  Say Y here to protect DS2433 data with a CRC16.
+	  Each block has 30 bytes of data and a two byte CRC16.
+	  Full block writes are only allowed if the CRC is valid.
+
+endmenu
Index: linux-2.6.15-rc3-mm1/drivers/w1/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/Makefile
+++ linux-2.6.15-rc3-mm1/drivers/w1/Makefile
@@ -13,13 +13,5 @@ endif
 obj-$(CONFIG_W1)	+=3D wire.o
 wire-objs		:=3D w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
=20
-obj-$(CONFIG_W1_MATROX)		+=3D matrox_w1.o
-obj-$(CONFIG_W1_THERM)		+=3D w1_therm.o
-obj-$(CONFIG_W1_SMEM)		+=3D w1_smem.o
+obj-y			+=3D masters/ slaves/
=20
-obj-$(CONFIG_W1_DS9490)		+=3D ds9490r.o
-ds9490r-objs    :=3D dscore.o
-
-obj-$(CONFIG_W1_DS9490_BRIDGE)	+=3D ds_w1_bridge.o
-
-obj-$(CONFIG_W1_DS2433)		+=3D w1_ds2433.o
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/Makefile
@@ -0,0 +1,11 @@
+#
+# Makefile for 1-wire bus master drivers.
+#
+
+obj-$(CONFIG_W1_MASTER_MATROX)		+=3D matrox_w1.o
+
+obj-$(CONFIG_W1_MASTER_DS9490)		+=3D ds9490r.o
+ds9490r-objs    :=3D dscore.o
+
+obj-$(CONFIG_W1_MASTER_DS9490_BRIDGE)	+=3D ds_w1_bridge.o
+
Index: linux-2.6.15-rc3-mm1/drivers/w1/slaves/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/slaves/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for the Dallas's 1-wire slaves.
+#
+
+ifeq ($(CONFIG_W1_SLAVE_DS2433_CRC), y)
+EXTRA_CFLAGS +=3D -DCONFIG_W1_F23_CRC
+endif
+
+obj-$(CONFIG_W1_SLAVE_THERM)	+=3D w1_therm.o
+obj-$(CONFIG_W1_SLAVE_SMEM)	+=3D w1_smem.o
+obj-$(CONFIG_W1_SLAVE_DS2433)	+=3D w1_ds2433.o
+
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/matrox_w1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/matrox_w1.c
@@ -0,0 +1,247 @@
+/*
+ *	matrox_w1.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/types.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
+#include <linux/timer.h>
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "../w1_log.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for transport(Dallas 1-wire prtocol) over VGA D=
DC(matrox gpio).");
+
+static struct pci_device_id matrox_w1_tbl[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MATROX, PCI_DEVICE_ID_MATROX_G400) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, matrox_w1_tbl);
+
+static int __devinit matrox_w1_probe(struct pci_dev *, const struct pci_de=
vice_id *);
+static void __devexit matrox_w1_remove(struct pci_dev *);
+
+static struct pci_driver matrox_w1_pci_driver =3D {
+	.name =3D "matrox_w1",
+	.id_table =3D matrox_w1_tbl,
+	.probe =3D matrox_w1_probe,
+	.remove =3D __devexit_p(matrox_w1_remove),
+};
+
+/*
+ * Matrox G400 DDC registers.
+ */
+
+#define MATROX_G400_DDC_CLK		(1<<4)
+#define MATROX_G400_DDC_DATA		(1<<1)
+
+#define MATROX_BASE			0x3C00
+#define MATROX_STATUS			0x1e14
+
+#define MATROX_PORT_INDEX_OFFSET	0x00
+#define MATROX_PORT_DATA_OFFSET		0x0A
+
+#define MATROX_GET_CONTROL		0x2A
+#define MATROX_GET_DATA			0x2B
+#define MATROX_CURSOR_CTL		0x06
+
+struct matrox_device
+{
+	void __iomem *base_addr;
+	void __iomem *port_index;
+	void __iomem *port_data;
+	u8 data_mask;
+
+	unsigned long phys_addr;
+	void __iomem *virt_addr;
+	unsigned long found;
+
+	struct w1_bus_master *bus_master;
+};
+
+static u8 matrox_w1_read_ddc_bit(void *);
+static void matrox_w1_write_ddc_bit(void *, u8);
+
+/*
+ * These functions read and write DDC Data bit.
+ *
+ * Using tristate pins, since i can't find any open-drain pin in whole mot=
herboard.
+ * Unfortunately we can't connect to Intel's 82801xx IO controller
+ * since we don't know motherboard schema, wich has pretty unused(may be n=
ot) GPIO.
+ *
+ * I've heard that PIIX also has open drain pin.
+ *
+ * Port mapping.
+ */
+static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
+{
+	u8 ret;
+
+	writeb(reg, dev->port_index);
+	ret =3D readb(dev->port_data);
+	barrier();
+
+	return ret;
+}
+
+static __inline__ void matrox_w1_write_reg(struct matrox_device *dev, u8 r=
eg, u8 val)
+{
+	writeb(reg, dev->port_index);
+	writeb(val, dev->port_data);
+	wmb();
+}
+
+static void matrox_w1_write_ddc_bit(void *data, u8 bit)
+{
+	u8 ret;
+	struct matrox_device *dev =3D data;
+
+	if (bit)
+		bit =3D 0;
+	else
+		bit =3D dev->data_mask;
+
+	ret =3D matrox_w1_read_reg(dev, MATROX_GET_CONTROL);
+	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, ((ret & ~dev->data_mask) | b=
it));
+	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
+}
+
+static u8 matrox_w1_read_ddc_bit(void *data)
+{
+	u8 ret;
+	struct matrox_device *dev =3D data;
+
+	ret =3D matrox_w1_read_reg(dev, MATROX_GET_DATA);
+
+	return ret;
+}
+
+static void matrox_w1_hw_init(struct matrox_device *dev)
+{
+	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0xFF);
+	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, 0x00);
+}
+
+static int __devinit matrox_w1_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
+{
+	struct matrox_device *dev;
+	int err;
+
+	assert(pdev !=3D NULL);
+	assert(ent !=3D NULL);
+
+	if (pdev->vendor !=3D PCI_VENDOR_ID_MATROX || pdev->device !=3D PCI_DEVIC=
E_ID_MATROX_G400)
+		return -ENODEV;
+
+	dev =3D kmalloc(sizeof(struct matrox_device) +
+		       sizeof(struct w1_bus_master), GFP_KERNEL);
+	if (!dev) {
+		dev_err(&pdev->dev,
+			"%s: Failed to create new matrox_device object.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	memset(dev, 0, sizeof(struct matrox_device) + sizeof(struct w1_bus_master=
));
+
+	dev->bus_master =3D (struct w1_bus_master *)(dev + 1);
+
+	/*
+	 * True for G400, for some other we need resource 0, see drivers/video/ma=
trox/matroxfb_base.c
+	 */
+
+	dev->phys_addr =3D pci_resource_start(pdev, 1);
+
+	dev->virt_addr =3D ioremap_nocache(dev->phys_addr, 16384);
+	if (!dev->virt_addr) {
+		dev_err(&pdev->dev, "%s: failed to ioremap(0x%lx, %d).\n",
+			__func__, dev->phys_addr, 16384);
+		err =3D -EIO;
+		goto err_out_free_device;
+	}
+
+	dev->base_addr =3D dev->virt_addr + MATROX_BASE;
+	dev->port_index =3D dev->base_addr + MATROX_PORT_INDEX_OFFSET;
+	dev->port_data =3D dev->base_addr + MATROX_PORT_DATA_OFFSET;
+	dev->data_mask =3D (MATROX_G400_DDC_DATA);
+
+	matrox_w1_hw_init(dev);
+
+	dev->bus_master->data =3D dev;
+	dev->bus_master->read_bit =3D &matrox_w1_read_ddc_bit;
+	dev->bus_master->write_bit =3D &matrox_w1_write_ddc_bit;
+
+	err =3D w1_add_master_device(dev->bus_master);
+	if (err)
+		goto err_out_free_device;
+
+	pci_set_drvdata(pdev, dev);
+
+	dev->found =3D 1;
+
+	dev_info(&pdev->dev, "Matrox G400 GPIO transport layer for 1-wire.\n");
+
+	return 0;
+
+err_out_free_device:
+	kfree(dev);
+
+	return err;
+}
+
+static void __devexit matrox_w1_remove(struct pci_dev *pdev)
+{
+	struct matrox_device *dev =3D pci_get_drvdata(pdev);
+
+	assert(dev !=3D NULL);
+
+	if (dev->found) {
+		w1_remove_master_device(dev->bus_master);
+		iounmap(dev->virt_addr);
+	}
+	kfree(dev);
+}
+
+static int __init matrox_w1_init(void)
+{
+	return pci_register_driver(&matrox_w1_pci_driver);
+}
+
+static void __exit matrox_w1_fini(void)
+{
+	pci_unregister_driver(&matrox_w1_pci_driver);
+}
+
+module_init(matrox_w1_init);
+module_exit(matrox_w1_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/matrox_w1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/matrox_w1.c
+++ /dev/null
@@ -1,247 +0,0 @@
-/*
- *	matrox_w1.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <asm/types.h>
-#include <asm/atomic.h>
-#include <asm/io.h>
-
-#include <linux/delay.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/pci_ids.h>
-#include <linux/pci.h>
-#include <linux/timer.h>
-
-#include "w1.h"
-#include "w1_int.h"
-#include "w1_log.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for transport(Dallas 1-wire prtocol) over VGA D=
DC(matrox gpio).");
-
-static struct pci_device_id matrox_w1_tbl[] =3D {
-	{ PCI_DEVICE(PCI_VENDOR_ID_MATROX, PCI_DEVICE_ID_MATROX_G400) },
-	{ },
-};
-MODULE_DEVICE_TABLE(pci, matrox_w1_tbl);
-
-static int __devinit matrox_w1_probe(struct pci_dev *, const struct pci_de=
vice_id *);
-static void __devexit matrox_w1_remove(struct pci_dev *);
-
-static struct pci_driver matrox_w1_pci_driver =3D {
-	.name =3D "matrox_w1",
-	.id_table =3D matrox_w1_tbl,
-	.probe =3D matrox_w1_probe,
-	.remove =3D __devexit_p(matrox_w1_remove),
-};
-
-/*
- * Matrox G400 DDC registers.
- */
-
-#define MATROX_G400_DDC_CLK		(1<<4)
-#define MATROX_G400_DDC_DATA		(1<<1)
-
-#define MATROX_BASE			0x3C00
-#define MATROX_STATUS			0x1e14
-
-#define MATROX_PORT_INDEX_OFFSET	0x00
-#define MATROX_PORT_DATA_OFFSET		0x0A
-
-#define MATROX_GET_CONTROL		0x2A
-#define MATROX_GET_DATA			0x2B
-#define MATROX_CURSOR_CTL		0x06
-
-struct matrox_device
-{
-	void __iomem *base_addr;
-	void __iomem *port_index;
-	void __iomem *port_data;
-	u8 data_mask;
-
-	unsigned long phys_addr;
-	void __iomem *virt_addr;
-	unsigned long found;
-
-	struct w1_bus_master *bus_master;
-};
-
-static u8 matrox_w1_read_ddc_bit(void *);
-static void matrox_w1_write_ddc_bit(void *, u8);
-
-/*
- * These functions read and write DDC Data bit.
- *
- * Using tristate pins, since i can't find any open-drain pin in whole mot=
herboard.
- * Unfortunately we can't connect to Intel's 82801xx IO controller
- * since we don't know motherboard schema, wich has pretty unused(may be n=
ot) GPIO.
- *
- * I've heard that PIIX also has open drain pin.
- *
- * Port mapping.
- */
-static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
-{
-	u8 ret;
-
-	writeb(reg, dev->port_index);
-	ret =3D readb(dev->port_data);
-	barrier();
-
-	return ret;
-}
-
-static __inline__ void matrox_w1_write_reg(struct matrox_device *dev, u8 r=
eg, u8 val)
-{
-	writeb(reg, dev->port_index);
-	writeb(val, dev->port_data);
-	wmb();
-}
-
-static void matrox_w1_write_ddc_bit(void *data, u8 bit)
-{
-	u8 ret;
-	struct matrox_device *dev =3D data;
-
-	if (bit)
-		bit =3D 0;
-	else
-		bit =3D dev->data_mask;
-
-	ret =3D matrox_w1_read_reg(dev, MATROX_GET_CONTROL);
-	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, ((ret & ~dev->data_mask) | b=
it));
-	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
-}
-
-static u8 matrox_w1_read_ddc_bit(void *data)
-{
-	u8 ret;
-	struct matrox_device *dev =3D data;
-
-	ret =3D matrox_w1_read_reg(dev, MATROX_GET_DATA);
-
-	return ret;
-}
-
-static void matrox_w1_hw_init(struct matrox_device *dev)
-{
-	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0xFF);
-	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, 0x00);
-}
-
-static int __devinit matrox_w1_probe(struct pci_dev *pdev, const struct pc=
i_device_id *ent)
-{
-	struct matrox_device *dev;
-	int err;
-
-	assert(pdev !=3D NULL);
-	assert(ent !=3D NULL);
-
-	if (pdev->vendor !=3D PCI_VENDOR_ID_MATROX || pdev->device !=3D PCI_DEVIC=
E_ID_MATROX_G400)
-		return -ENODEV;
-
-	dev =3D kmalloc(sizeof(struct matrox_device) +
-		       sizeof(struct w1_bus_master), GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev,
-			"%s: Failed to create new matrox_device object.\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	memset(dev, 0, sizeof(struct matrox_device) + sizeof(struct w1_bus_master=
));
-
-	dev->bus_master =3D (struct w1_bus_master *)(dev + 1);
-
-	/*
-	 * True for G400, for some other we need resource 0, see drivers/video/ma=
trox/matroxfb_base.c
-	 */
-
-	dev->phys_addr =3D pci_resource_start(pdev, 1);
-
-	dev->virt_addr =3D ioremap_nocache(dev->phys_addr, 16384);
-	if (!dev->virt_addr) {
-		dev_err(&pdev->dev, "%s: failed to ioremap(0x%lx, %d).\n",
-			__func__, dev->phys_addr, 16384);
-		err =3D -EIO;
-		goto err_out_free_device;
-	}
-
-	dev->base_addr =3D dev->virt_addr + MATROX_BASE;
-	dev->port_index =3D dev->base_addr + MATROX_PORT_INDEX_OFFSET;
-	dev->port_data =3D dev->base_addr + MATROX_PORT_DATA_OFFSET;
-	dev->data_mask =3D (MATROX_G400_DDC_DATA);
-
-	matrox_w1_hw_init(dev);
-
-	dev->bus_master->data =3D dev;
-	dev->bus_master->read_bit =3D &matrox_w1_read_ddc_bit;
-	dev->bus_master->write_bit =3D &matrox_w1_write_ddc_bit;
-
-	err =3D w1_add_master_device(dev->bus_master);
-	if (err)
-		goto err_out_free_device;
-
-	pci_set_drvdata(pdev, dev);
-
-	dev->found =3D 1;
-
-	dev_info(&pdev->dev, "Matrox G400 GPIO transport layer for 1-wire.\n");
-
-	return 0;
-
-err_out_free_device:
-	kfree(dev);
-
-	return err;
-}
-
-static void __devexit matrox_w1_remove(struct pci_dev *pdev)
-{
-	struct matrox_device *dev =3D pci_get_drvdata(pdev);
-
-	assert(dev !=3D NULL);
-
-	if (dev->found) {
-		w1_remove_master_device(dev->bus_master);
-		iounmap(dev->virt_addr);
-	}
-	kfree(dev);
-}
-
-static int __init matrox_w1_init(void)
-{
-	return pci_register_driver(&matrox_w1_pci_driver);
-}
-
-static void __exit matrox_w1_fini(void)
-{
-	pci_unregister_driver(&matrox_w1_pci_driver);
-}
-
-module_init(matrox_w1_init);
-module_exit(matrox_w1_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/ds_w1_bridge.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/ds_w1_brid=
ge.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- *	ds_w1_bridge.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-
-#include "../w1/w1.h"
-#include "../w1/w1_int.h"
-#include "dscore.h"
-
-static struct ds_device *ds_dev;
-static struct w1_bus_master *ds_bus_master;
-
-static u8 ds9490r_touch_bit(void *data, u8 bit)
-{
-	u8 ret;
-	struct ds_device *dev =3D data;
-
-	if (ds_touch_bit(dev, bit, &ret))
-		return 0;
-
-	return ret;
-}
-
-static void ds9490r_write_bit(void *data, u8 bit)
-{
-	struct ds_device *dev =3D data;
-
-	ds_write_bit(dev, bit);
-}
-
-static void ds9490r_write_byte(void *data, u8 byte)
-{
-	struct ds_device *dev =3D data;
-
-	ds_write_byte(dev, byte);
-}
-
-static u8 ds9490r_read_bit(void *data)
-{
-	struct ds_device *dev =3D data;
-	int err;
-	u8 bit =3D 0;
-
-	err =3D ds_touch_bit(dev, 1, &bit);
-	if (err)
-		return 0;
-	//err =3D ds_read_bit(dev, &bit);
-	//if (err)
-	//	return 0;
-
-	return bit & 1;
-}
-
-static u8 ds9490r_read_byte(void *data)
-{
-	struct ds_device *dev =3D data;
-	int err;
-	u8 byte =3D 0;
-
-	err =3D ds_read_byte(dev, &byte);
-	if (err)
-		return 0;
-
-	return byte;
-}
-
-static void ds9490r_write_block(void *data, const u8 *buf, int len)
-{
-	struct ds_device *dev =3D data;
-
-	ds_write_block(dev, (u8 *)buf, len);
-}
-
-static u8 ds9490r_read_block(void *data, u8 *buf, int len)
-{
-	struct ds_device *dev =3D data;
-	int err;
-
-	err =3D ds_read_block(dev, buf, len);
-	if (err < 0)
-		return 0;
-
-	return len;
-}
-
-static u8 ds9490r_reset(void *data)
-{
-	struct ds_device *dev =3D data;
-	struct ds_status st;
-	int err;
-
-	memset(&st, 0, sizeof(st));
-
-	err =3D ds_reset(dev, &st);
-	if (err)
-		return 1;
-
-	return 0;
-}
-
-static int __devinit ds_w1_init(void)
-{
-	int err;
-
-	ds_bus_master =3D kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
-	if (!ds_bus_master) {
-		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structur=
e.\n");
-		return -ENOMEM;
-	}
-
-	ds_dev =3D ds_get_device();
-	if (!ds_dev) {
-		printk(KERN_ERR "DS9490R is not registered.\n");
-		err =3D  -ENODEV;
-		goto err_out_free_bus_master;
-	}
-
-	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
-
-	ds_bus_master->data		=3D ds_dev;
-	ds_bus_master->touch_bit	=3D &ds9490r_touch_bit;
-	ds_bus_master->read_bit		=3D &ds9490r_read_bit;
-	ds_bus_master->write_bit	=3D &ds9490r_write_bit;
-	ds_bus_master->read_byte	=3D &ds9490r_read_byte;
-	ds_bus_master->write_byte	=3D &ds9490r_write_byte;
-	ds_bus_master->read_block	=3D &ds9490r_read_block;
-	ds_bus_master->write_block	=3D &ds9490r_write_block;
-	ds_bus_master->reset_bus	=3D &ds9490r_reset;
-
-	err =3D w1_add_master_device(ds_bus_master);
-	if (err)
-		goto err_out_put_device;
-
-	return 0;
-
-err_out_put_device:
-	ds_put_device(ds_dev);
-err_out_free_bus_master:
-	kfree(ds_bus_master);
-
-	return err;
-}
-
-static void __devexit ds_w1_fini(void)
-{
-	w1_remove_master_device(ds_bus_master);
-	ds_put_device(ds_dev);
-	kfree(ds_bus_master);
-}
-
-module_init(ds_w1_init);
-module_exit(ds_w1_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/ds_w1_bridge.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/ds_w1_bridge.c
@@ -0,0 +1,174 @@
+/*
+ *	ds_w1_bridge.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "dscore.h"
+
+static struct ds_device *ds_dev;
+static struct w1_bus_master *ds_bus_master;
+
+static u8 ds9490r_touch_bit(void *data, u8 bit)
+{
+	u8 ret;
+	struct ds_device *dev =3D data;
+
+	if (ds_touch_bit(dev, bit, &ret))
+		return 0;
+
+	return ret;
+}
+
+static void ds9490r_write_bit(void *data, u8 bit)
+{
+	struct ds_device *dev =3D data;
+
+	ds_write_bit(dev, bit);
+}
+
+static void ds9490r_write_byte(void *data, u8 byte)
+{
+	struct ds_device *dev =3D data;
+
+	ds_write_byte(dev, byte);
+}
+
+static u8 ds9490r_read_bit(void *data)
+{
+	struct ds_device *dev =3D data;
+	int err;
+	u8 bit =3D 0;
+
+	err =3D ds_touch_bit(dev, 1, &bit);
+	if (err)
+		return 0;
+	//err =3D ds_read_bit(dev, &bit);
+	//if (err)
+	//	return 0;
+
+	return bit & 1;
+}
+
+static u8 ds9490r_read_byte(void *data)
+{
+	struct ds_device *dev =3D data;
+	int err;
+	u8 byte =3D 0;
+
+	err =3D ds_read_byte(dev, &byte);
+	if (err)
+		return 0;
+
+	return byte;
+}
+
+static void ds9490r_write_block(void *data, const u8 *buf, int len)
+{
+	struct ds_device *dev =3D data;
+
+	ds_write_block(dev, (u8 *)buf, len);
+}
+
+static u8 ds9490r_read_block(void *data, u8 *buf, int len)
+{
+	struct ds_device *dev =3D data;
+	int err;
+
+	err =3D ds_read_block(dev, buf, len);
+	if (err < 0)
+		return 0;
+
+	return len;
+}
+
+static u8 ds9490r_reset(void *data)
+{
+	struct ds_device *dev =3D data;
+	struct ds_status st;
+	int err;
+
+	memset(&st, 0, sizeof(st));
+
+	err =3D ds_reset(dev, &st);
+	if (err)
+		return 1;
+
+	return 0;
+}
+
+static int __devinit ds_w1_init(void)
+{
+	int err;
+
+	ds_bus_master =3D kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
+	if (!ds_bus_master) {
+		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structur=
e.\n");
+		return -ENOMEM;
+	}
+
+	ds_dev =3D ds_get_device();
+	if (!ds_dev) {
+		printk(KERN_ERR "DS9490R is not registered.\n");
+		err =3D  -ENODEV;
+		goto err_out_free_bus_master;
+	}
+
+	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
+
+	ds_bus_master->data		=3D ds_dev;
+	ds_bus_master->touch_bit	=3D &ds9490r_touch_bit;
+	ds_bus_master->read_bit		=3D &ds9490r_read_bit;
+	ds_bus_master->write_bit	=3D &ds9490r_write_bit;
+	ds_bus_master->read_byte	=3D &ds9490r_read_byte;
+	ds_bus_master->write_byte	=3D &ds9490r_write_byte;
+	ds_bus_master->read_block	=3D &ds9490r_read_block;
+	ds_bus_master->write_block	=3D &ds9490r_write_block;
+	ds_bus_master->reset_bus	=3D &ds9490r_reset;
+
+	err =3D w1_add_master_device(ds_bus_master);
+	if (err)
+		goto err_out_put_device;
+
+	return 0;
+
+err_out_put_device:
+	ds_put_device(ds_dev);
+err_out_free_bus_master:
+	kfree(ds_bus_master);
+
+	return err;
+}
+
+static void __devexit ds_w1_fini(void)
+{
+	w1_remove_master_device(ds_bus_master);
+	ds_put_device(ds_dev);
+	kfree(ds_bus_master);
+}
+
+module_init(ds_w1_init);
+module_exit(ds_w1_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
Index: linux-2.6.15-rc3-mm1/drivers/w1/dscore.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/dscore.c
+++ /dev/null
@@ -1,795 +0,0 @@
-/*
- *	dscore.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
-#include <linux/usb.h>
-
-#include "dscore.h"
-
-static struct usb_device_id ds_id_table [] =3D {
-	{ USB_DEVICE(0x04fa, 0x2490) },
-	{ },
-};
-MODULE_DEVICE_TABLE(usb, ds_id_table);
-
-static int ds_probe(struct usb_interface *, const struct usb_device_id *);
-static void ds_disconnect(struct usb_interface *);
-
-int ds_touch_bit(struct ds_device *, u8, u8 *);
-int ds_read_byte(struct ds_device *, u8 *);
-int ds_read_bit(struct ds_device *, u8 *);
-int ds_write_byte(struct ds_device *, u8);
-int ds_write_bit(struct ds_device *, u8);
-static int ds_start_pulse(struct ds_device *, int);
-int ds_reset(struct ds_device *, struct ds_status *);
-struct ds_device * ds_get_device(void);
-void ds_put_device(struct ds_device *);
-
-static inline void ds_dump_status(unsigned char *, unsigned char *, int);
-static int ds_send_control(struct ds_device *, u16, u16);
-static int ds_send_control_mode(struct ds_device *, u16, u16);
-static int ds_send_control_cmd(struct ds_device *, u16, u16);
-
-
-static struct usb_driver ds_driver =3D {
-	.name =3D		"DS9490R",
-	.probe =3D	ds_probe,
-	.disconnect =3D	ds_disconnect,
-	.id_table =3D	ds_id_table,
-};
-
-static struct ds_device *ds_dev;
-
-struct ds_device * ds_get_device(void)
-{
-	if (ds_dev)
-		atomic_inc(&ds_dev->refcnt);
-	return ds_dev;
-}
-
-void ds_put_device(struct ds_device *dev)
-{
-	atomic_dec(&dev->refcnt);
-}
-
-static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
-{
-	int err;
-
-	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
-			CONTROL_CMD, 0x40, value, index, NULL, 0, 1000);
-	if (err < 0) {
-		printk(KERN_ERR "Failed to send command control message %x.%x: err=3D%d.=
\n",
-				value, index, err);
-		return err;
-	}
-
-	return err;
-}
-
-static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 inde=
x)
-{
-	int err;
-
-	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
-			MODE_CMD, 0x40, value, index, NULL, 0, 1000);
-	if (err < 0) {
-		printk(KERN_ERR "Failed to send mode control message %x.%x: err=3D%d.\n",
-				value, index, err);
-		return err;
-	}
-
-	return err;
-}
-
-static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
-{
-	int err;
-
-	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
-			COMM_CMD, 0x40, value, index, NULL, 0, 1000);
-	if (err < 0) {
-		printk(KERN_ERR "Failed to send control message %x.%x: err=3D%d.\n",
-				value, index, err);
-		return err;
-	}
-
-	return err;
-}
-
-static inline void ds_dump_status(unsigned char *buf, unsigned char *str, =
int off)
-{
-	printk("%45s: %8x\n", str, buf[off]);
-}
-
-static int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *=
st,
-				 unsigned char *buf, int size)
-{
-	int count, err;
-
-	memset(st, 0, sizeof(st));
-
-	count =3D 0;
-	err =3D usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_STA=
TUS]), buf, size, &count, 100);
-	if (err < 0) {
-		printk(KERN_ERR "Failed to read 1-wire data from 0x%x: err=3D%d.\n", dev=
->ep[EP_STATUS], err);
-		return err;
-	}
-
-	if (count >=3D sizeof(*st))
-		memcpy(st, buf, sizeof(*st));
-
-	return count;
-}
-
-static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
-{
-	unsigned char buf[64];
-	int count, err =3D 0, i;
-
-	memcpy(st, buf, sizeof(*st));
-
-	count =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
-	if (count < 0)
-		return err;
-
-	printk("0x%x: count=3D%d, status: ", dev->ep[EP_STATUS], count);
-	for (i=3D0; i<count; ++i)
-		printk("%02x ", buf[i]);
-	printk("\n");
-
-	if (count >=3D 16) {
-		ds_dump_status(buf, "enable flag", 0);
-		ds_dump_status(buf, "1-wire speed", 1);
-		ds_dump_status(buf, "strong pullup duration", 2);
-		ds_dump_status(buf, "programming pulse duration", 3);
-		ds_dump_status(buf, "pulldown slew rate control", 4);
-		ds_dump_status(buf, "write-1 low time", 5);
-		ds_dump_status(buf, "data sample offset/write-0 recovery time", 6);
-		ds_dump_status(buf, "reserved (test register)", 7);
-		ds_dump_status(buf, "device status flags", 8);
-		ds_dump_status(buf, "communication command byte 1", 9);
-		ds_dump_status(buf, "communication command byte 2", 10);
-		ds_dump_status(buf, "communication command buffer status", 11);
-		ds_dump_status(buf, "1-wire data output buffer status", 12);
-		ds_dump_status(buf, "1-wire data input buffer status", 13);
-		ds_dump_status(buf, "reserved", 14);
-		ds_dump_status(buf, "reserved", 15);
-	}
-
-	memcpy(st, buf, sizeof(*st));
-
-	if (st->status & ST_EPOF) {
-		printk(KERN_INFO "Resetting device after ST_EPOF.\n");
-		err =3D ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
-		if (err)
-			return err;
-		count =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
-		if (count < 0)
-			return err;
-	}
-#if 0
-	if (st->status & ST_IDLE) {
-		printk(KERN_INFO "Resetting pulse after ST_IDLE.\n");
-		err =3D ds_start_pulse(dev, PULLUP_PULSE_DURATION);
-		if (err)
-			return err;
-	}
-#endif
-
-	return err;
-}
-
-static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int siz=
e)
-{
-	int count, err;
-	struct ds_status st;
-
-	count =3D 0;
-	err =3D usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DAT=
A_IN]),
-				buf, size, &count, 1000);
-	if (err < 0) {
-		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
-		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]=
));
-		ds_recv_status(dev, &st);
-		return err;
-	}
-
-#if 0
-	{
-		int i;
-
-		printk("%s: count=3D%d: ", __func__, count);
-		for (i=3D0; i<count; ++i)
-			printk("%02x ", buf[i]);
-		printk("\n");
-	}
-#endif
-	return count;
-}
-
-static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
-{
-	int count, err;
-
-	count =3D 0;
-	err =3D usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DAT=
A_OUT]), buf, len, &count, 1000);
-	if (err < 0) {
-		printk(KERN_ERR "Failed to read 1-wire data from 0x02: err=3D%d.\n", err=
);
-		return err;
-	}
-
-	return err;
-}
-
-#if 0
-
-int ds_stop_pulse(struct ds_device *dev, int limit)
-{
-	struct ds_status st;
-	int count =3D 0, err =3D 0;
-	u8 buf[0x20];
-
-	do {
-		err =3D ds_send_control(dev, CTL_HALT_EXE_IDLE, 0);
-		if (err)
-			break;
-		err =3D ds_send_control(dev, CTL_RESUME_EXE, 0);
-		if (err)
-			break;
-		err =3D ds_recv_status_nodump(dev, &st, buf, sizeof(buf));
-		if (err)
-			break;
-
-		if ((st.status & ST_SPUA) =3D 0) {
-			err =3D ds_send_control_mode(dev, MOD_PULSE_EN, 0);
-			if (err)
-				break;
-		}
-	} while(++count < limit);
-
-	return err;
-}
-
-int ds_detect(struct ds_device *dev, struct ds_status *st)
-{
-	int err;
-
-	err =3D ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
-	if (err)
-		return err;
-
-	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
-	if (err)
-		return err;
-
-	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x4=
0);
-	if (err)
-		return err;
-
-	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
-	if (err)
-		return err;
-
-	err =3D ds_recv_status(dev, st);
-
-	return err;
-}
-
-#endif  /*  0  */
-
-static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
-{
-	u8 buf[0x20];
-	int err, count =3D 0;
-
-	do {
-		err =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
-#if 0
-		if (err >=3D 0) {
-			int i;
-			printk("0x%x: count=3D%d, status: ", dev->ep[EP_STATUS], err);
-			for (i=3D0; i<err; ++i)
-				printk("%02x ", buf[i]);
-			printk("\n");
-		}
-#endif
-	} while(!(buf[0x08] & 0x20) && !(err < 0) && ++count < 100);
-
-
-	if (((err > 16) && (buf[0x10] & 0x01)) || count >=3D 100 || err < 0) {
-		ds_recv_status(dev, st);
-		return -1;
-	} else
-		return 0;
-}
-
-int ds_reset(struct ds_device *dev, struct ds_status *st)
-{
-	int err;
-
-	//err =3D ds_send_control(dev, COMM_1_WIRE_RESET | COMM_F | COMM_IM | COM=
M_SE, SPEED_FLEXIBLE);
-	err =3D ds_send_control(dev, 0x43, SPEED_NORMAL);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, st);
-#if 0
-	if (st->command_buffer_status) {
-		printk(KERN_INFO "Short circuit.\n");
-		return -EIO;
-	}
-#endif
-=09
-	return 0;
-}
-
-#if 0
-int ds_set_speed(struct ds_device *dev, int speed)
-{
-	int err;
-=09
-	if (speed !=3D SPEED_NORMAL && speed !=3D SPEED_FLEXIBLE && speed !=3D SP=
EED_OVERDRIVE)
-		return -EINVAL;
-
-	if (speed !=3D SPEED_OVERDRIVE)
-		speed =3D SPEED_FLEXIBLE;
-
-	speed &=3D 0xff;
-
-	err =3D ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
-	if (err)
-		return err;
-
-	return err;
-}
-#endif  /*  0  */
-
-static int ds_start_pulse(struct ds_device *dev, int delay)
-{
-	int err;
-	u8 del =3D 1 + (u8)(delay >> 4);
-	struct ds_status st;
-
-#if 0
-	err =3D ds_stop_pulse(dev, 10);
-	if (err)
-		return err;
-
-	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
-	if (err)
-		return err;
-#endif
-	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM, del);
-	if (err)
-		return err;
-
-	err =3D ds_send_control(dev, COMM_PULSE | COMM_IM | COMM_F, 0);
-	if (err)
-		return err;
-
-	mdelay(delay);
-
-	ds_wait_status(dev, &st);
-
-	return err;
-}
-
-int ds_touch_bit(struct ds_device *dev, u8 bit, u8 *tbit)
-{
-	int err, count;
-	struct ds_status st;
-	u16 value =3D (COMM_BIT_IO | COMM_IM) | ((bit) ? COMM_D : 0);
-	u16 cmd;
-
-	err =3D ds_send_control(dev, value, 0);
-	if (err)
-		return err;
-
-	count =3D 0;
-	do {
-		err =3D ds_wait_status(dev, &st);
-		if (err)
-			return err;
-
-		cmd =3D st.command0 | (st.command1 << 8);
-	} while (cmd !=3D value && ++count < 10);
-
-	if (err < 0 || count >=3D 10) {
-		printk(KERN_ERR "Failed to obtain status.\n");
-		return -EINVAL;
-	}
-
-	err =3D ds_recv_data(dev, tbit, sizeof(*tbit));
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-int ds_write_bit(struct ds_device *dev, u8 bit)
-{
-	int err;
-	struct ds_status st;
-
-	err =3D ds_send_control(dev, COMM_BIT_IO | COMM_IM | (bit) ? COMM_D : 0, =
0);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	return 0;
-}
-
-int ds_write_byte(struct ds_device *dev, u8 byte)
-{
-	int err;
-	struct ds_status st;
-	u8 rbyte;
-
-	err =3D ds_send_control(dev, COMM_BYTE_IO | COMM_IM | COMM_SPU, byte);
-	if (err)
-		return err;
-
-	err =3D ds_wait_status(dev, &st);
-	if (err)
-		return err;
-
-	err =3D ds_recv_data(dev, &rbyte, sizeof(rbyte));
-	if (err < 0)
-		return err;
-
-	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
-
-	return !(byte =3D rbyte);
-}
-
-int ds_read_bit(struct ds_device *dev, u8 *bit)
-{
-	int err;
-
-	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
-	if (err)
-		return err;
-
-	err =3D ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0=
);
-	if (err)
-		return err;
-
-	err =3D ds_recv_data(dev, bit, sizeof(*bit));
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-int ds_read_byte(struct ds_device *dev, u8 *byte)
-{
-	int err;
-	struct ds_status st;
-
-	err =3D ds_send_control(dev, COMM_BYTE_IO | COMM_IM , 0xff);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	err =3D ds_recv_data(dev, byte, sizeof(*byte));
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-int ds_read_block(struct ds_device *dev, u8 *buf, int len)
-{
-	struct ds_status st;
-	int err;
-
-	if (len > 64*1024)
-		return -E2BIG;
-
-	memset(buf, 0xFF, len);
-
-	err =3D ds_send_data(dev, buf, len);
-	if (err < 0)
-		return err;
-
-	err =3D ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	memset(buf, 0x00, len);
-	err =3D ds_recv_data(dev, buf, len);
-
-	return err;
-}
-
-int ds_write_block(struct ds_device *dev, u8 *buf, int len)
-{
-	int err;
-	struct ds_status st;
-
-	err =3D ds_send_data(dev, buf, len);
-	if (err < 0)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	err =3D ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	err =3D ds_recv_data(dev, buf, len);
-	if (err < 0)
-		return err;
-
-	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
-
-	return !(err =3D len);
-}
-
-#if 0
-
-int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int=
 conditional_search)
-{
-	int err;
-	u16 value, index;
-	struct ds_status st;
-
-	memset(buf, 0, sizeof(buf));
-
-	err =3D ds_send_data(ds_dev, (unsigned char *)&init, 8);
-	if (err)
-		return err;
-
-	ds_wait_status(ds_dev, &st);
-
-	value =3D COMM_SEARCH_ACCESS | COMM_IM | COMM_SM | COMM_F | COMM_RTS;
-	index =3D (conditional_search ? 0xEC : 0xF0) | (id_number << 8);
-	err =3D ds_send_control(ds_dev, value, index);
-	if (err)
-		return err;
-
-	ds_wait_status(ds_dev, &st);
-
-	err =3D ds_recv_data(ds_dev, (unsigned char *)buf, 8*id_number);
-	if (err < 0)
-		return err;
-
-	return err/8;
-}
-
-int ds_match_access(struct ds_device *dev, u64 init)
-{
-	int err;
-	struct ds_status st;
-
-	err =3D ds_send_data(dev, (unsigned char *)&init, sizeof(init));
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	err =3D ds_send_control(dev, COMM_MATCH_ACCESS | COMM_IM | COMM_RST, 0x00=
55);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	return 0;
-}
-
-int ds_set_path(struct ds_device *dev, u64 init)
-{
-	int err;
-	struct ds_status st;
-	u8 buf[9];
-
-	memcpy(buf, &init, 8);
-	buf[8] =3D BRANCH_MAIN;
-
-	err =3D ds_send_data(dev, buf, sizeof(buf));
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	err =3D ds_send_control(dev, COMM_SET_PATH | COMM_IM | COMM_RST, 0);
-	if (err)
-		return err;
-
-	ds_wait_status(dev, &st);
-
-	return 0;
-}
-
-#endif  /*  0  */
-
-static int ds_probe(struct usb_interface *intf,
-		    const struct usb_device_id *udev_id)
-{
-	struct usb_device *udev =3D interface_to_usbdev(intf);
-	struct usb_endpoint_descriptor *endpoint;
-	struct usb_host_interface *iface_desc;
-	int i, err;
-
-	ds_dev =3D kmalloc(sizeof(struct ds_device), GFP_KERNEL);
-	if (!ds_dev) {
-		printk(KERN_INFO "Failed to allocate new DS9490R structure.\n");
-		return -ENOMEM;
-	}
-
-	ds_dev->udev =3D usb_get_dev(udev);
-	usb_set_intfdata(intf, ds_dev);
-
-	err =3D usb_set_interface(ds_dev->udev, intf->altsetting[0].desc.bInterfa=
ceNumber, 3);
-	if (err) {
-		printk(KERN_ERR "Failed to set alternative setting 3 for %d interface: e=
rr=3D%d.\n",
-				intf->altsetting[0].desc.bInterfaceNumber, err);
-		return err;
-	}
-
-	err =3D usb_reset_configuration(ds_dev->udev);
-	if (err) {
-		printk(KERN_ERR "Failed to reset configuration: err=3D%d.\n", err);
-		return err;
-	}
-
-	iface_desc =3D &intf->altsetting[0];
-	if (iface_desc->desc.bNumEndpoints !=3D NUM_EP-1) {
-		printk(KERN_INFO "Num endpoints=3D%d. It is not DS9490R.\n", iface_desc-=
>desc.bNumEndpoints);
-		return -ENODEV;
-	}
-
-	atomic_set(&ds_dev->refcnt, 0);
-	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
-
-	/*
-	 * This loop doesn'd show control 0 endpoint,
-	 * so we will fill only 1-3 endpoints entry.
-	 */
-	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint =3D &iface_desc->endpoint[i].desc;
-
-		ds_dev->ep[i+1] =3D endpoint->bEndpointAddress;
-
-		printk("%d: addr=3D%x, size=3D%d, dir=3D%s, type=3D%x\n",
-			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
-			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
-			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
-	}
-
-#if 0
-	{
-		int err, i;
-		u64 buf[3];
-		u64 init=3D0xb30000002078ee81ull;
-		struct ds_status st;
-
-		ds_reset(ds_dev, &st);
-		err =3D ds_search(ds_dev, init, buf, 3, 0);
-		if (err < 0)
-			return err;
-		for (i=3D0; i<err; ++i)
-			printk("%d: %llx\n", i, buf[i]);
-
-		printk("Resetting...\n");
-		ds_reset(ds_dev, &st);
-		printk("Setting path for %llx.\n", init);
-		err =3D ds_set_path(ds_dev, init);
-		if (err)
-			return err;
-		printk("Calling MATCH_ACCESS.\n");
-		err =3D ds_match_access(ds_dev, init);
-		if (err)
-			return err;
-
-		printk("Searching the bus...\n");
-		err =3D ds_search(ds_dev, init, buf, 3, 0);
-
-		printk("ds_search() returned %d\n", err);
-
-		if (err < 0)
-			return err;
-		for (i=3D0; i<err; ++i)
-			printk("%d: %llx\n", i, buf[i]);
-
-		return 0;
-	}
-#endif
-
-	return 0;
-}
-
-static void ds_disconnect(struct usb_interface *intf)
-{
-	struct ds_device *dev;
-
-	dev =3D usb_get_intfdata(intf);
-	usb_set_intfdata(intf, NULL);
-
-	while (atomic_read(&dev->refcnt)) {
-		printk(KERN_INFO "Waiting for DS to become free: refcnt=3D%d.\n",
-				atomic_read(&dev->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
-
-	usb_put_dev(dev->udev);
-	kfree(dev);
-	ds_dev =3D NULL;
-}
-
-static int ds_init(void)
-{
-	int err;
-
-	err =3D usb_register(&ds_driver);
-	if (err) {
-		printk(KERN_INFO "Failed to register DS9490R USB device: err=3D%d.\n", e=
rr);
-		return err;
-	}
-
-	return 0;
-}
-
-static void ds_fini(void)
-{
-	usb_deregister(&ds_driver);
-}
-
-module_init(ds_init);
-module_exit(ds_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
-
-EXPORT_SYMBOL(ds_touch_bit);
-EXPORT_SYMBOL(ds_read_byte);
-EXPORT_SYMBOL(ds_read_bit);
-EXPORT_SYMBOL(ds_read_block);
-EXPORT_SYMBOL(ds_write_byte);
-EXPORT_SYMBOL(ds_write_bit);
-EXPORT_SYMBOL(ds_write_block);
-EXPORT_SYMBOL(ds_reset);
-EXPORT_SYMBOL(ds_get_device);
-EXPORT_SYMBOL(ds_put_device);
-
-/*
- * This functions can be used for EEPROM programming,
- * when driver will be included into mainline this will
- * require uncommenting.
- */
-#if 0
-EXPORT_SYMBOL(ds_start_pulse);
-EXPORT_SYMBOL(ds_set_speed);
-EXPORT_SYMBOL(ds_detect);
-EXPORT_SYMBOL(ds_stop_pulse);
-EXPORT_SYMBOL(ds_search);
-#endif
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/dscore.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/dscore.c
@@ -0,0 +1,795 @@
+/*
+ *	dscore.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/usb.h>
+
+#include "dscore.h"
+
+static struct usb_device_id ds_id_table [] =3D {
+	{ USB_DEVICE(0x04fa, 0x2490) },
+	{ },
+};
+MODULE_DEVICE_TABLE(usb, ds_id_table);
+
+static int ds_probe(struct usb_interface *, const struct usb_device_id *);
+static void ds_disconnect(struct usb_interface *);
+
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+static int ds_start_pulse(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
+
+static inline void ds_dump_status(unsigned char *, unsigned char *, int);
+static int ds_send_control(struct ds_device *, u16, u16);
+static int ds_send_control_mode(struct ds_device *, u16, u16);
+static int ds_send_control_cmd(struct ds_device *, u16, u16);
+
+
+static struct usb_driver ds_driver =3D {
+	.name =3D		"DS9490R",
+	.probe =3D	ds_probe,
+	.disconnect =3D	ds_disconnect,
+	.id_table =3D	ds_id_table,
+};
+
+static struct ds_device *ds_dev;
+
+struct ds_device * ds_get_device(void)
+{
+	if (ds_dev)
+		atomic_inc(&ds_dev->refcnt);
+	return ds_dev;
+}
+
+void ds_put_device(struct ds_device *dev)
+{
+	atomic_dec(&dev->refcnt);
+}
+
+static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
+{
+	int err;
+
+	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
+			CONTROL_CMD, 0x40, value, index, NULL, 0, 1000);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send command control message %x.%x: err=3D%d.=
\n",
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 inde=
x)
+{
+	int err;
+
+	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
+			MODE_CMD, 0x40, value, index, NULL, 0, 1000);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send mode control message %x.%x: err=3D%d.\n",
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
+{
+	int err;
+
+	err =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_=
CONTROL]),
+			COMM_CMD, 0x40, value, index, NULL, 0, 1000);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to send control message %x.%x: err=3D%d.\n",
+				value, index, err);
+		return err;
+	}
+
+	return err;
+}
+
+static inline void ds_dump_status(unsigned char *buf, unsigned char *str, =
int off)
+{
+	printk("%45s: %8x\n", str, buf[off]);
+}
+
+static int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *=
st,
+				 unsigned char *buf, int size)
+{
+	int count, err;
+
+	memset(st, 0, sizeof(st));
+
+	count =3D 0;
+	err =3D usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_STA=
TUS]), buf, size, &count, 100);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to read 1-wire data from 0x%x: err=3D%d.\n", dev=
->ep[EP_STATUS], err);
+		return err;
+	}
+
+	if (count >=3D sizeof(*st))
+		memcpy(st, buf, sizeof(*st));
+
+	return count;
+}
+
+static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
+{
+	unsigned char buf[64];
+	int count, err =3D 0, i;
+
+	memcpy(st, buf, sizeof(*st));
+
+	count =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+	if (count < 0)
+		return err;
+
+	printk("0x%x: count=3D%d, status: ", dev->ep[EP_STATUS], count);
+	for (i=3D0; i<count; ++i)
+		printk("%02x ", buf[i]);
+	printk("\n");
+
+	if (count >=3D 16) {
+		ds_dump_status(buf, "enable flag", 0);
+		ds_dump_status(buf, "1-wire speed", 1);
+		ds_dump_status(buf, "strong pullup duration", 2);
+		ds_dump_status(buf, "programming pulse duration", 3);
+		ds_dump_status(buf, "pulldown slew rate control", 4);
+		ds_dump_status(buf, "write-1 low time", 5);
+		ds_dump_status(buf, "data sample offset/write-0 recovery time", 6);
+		ds_dump_status(buf, "reserved (test register)", 7);
+		ds_dump_status(buf, "device status flags", 8);
+		ds_dump_status(buf, "communication command byte 1", 9);
+		ds_dump_status(buf, "communication command byte 2", 10);
+		ds_dump_status(buf, "communication command buffer status", 11);
+		ds_dump_status(buf, "1-wire data output buffer status", 12);
+		ds_dump_status(buf, "1-wire data input buffer status", 13);
+		ds_dump_status(buf, "reserved", 14);
+		ds_dump_status(buf, "reserved", 15);
+	}
+
+	memcpy(st, buf, sizeof(*st));
+
+	if (st->status & ST_EPOF) {
+		printk(KERN_INFO "Resetting device after ST_EPOF.\n");
+		err =3D ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
+		if (err)
+			return err;
+		count =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+		if (count < 0)
+			return err;
+	}
+#if 0
+	if (st->status & ST_IDLE) {
+		printk(KERN_INFO "Resetting pulse after ST_IDLE.\n");
+		err =3D ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+		if (err)
+			return err;
+	}
+#endif
+
+	return err;
+}
+
+static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int siz=
e)
+{
+	int count, err;
+	struct ds_status st;
+
+	count =3D 0;
+	err =3D usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DAT=
A_IN]),
+				buf, size, &count, 1000);
+	if (err < 0) {
+		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
+		usb_clear_halt(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]=
));
+		ds_recv_status(dev, &st);
+		return err;
+	}
+
+#if 0
+	{
+		int i;
+
+		printk("%s: count=3D%d: ", __func__, count);
+		for (i=3D0; i<count; ++i)
+			printk("%02x ", buf[i]);
+		printk("\n");
+	}
+#endif
+	return count;
+}
+
+static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
+{
+	int count, err;
+
+	count =3D 0;
+	err =3D usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DAT=
A_OUT]), buf, len, &count, 1000);
+	if (err < 0) {
+		printk(KERN_ERR "Failed to read 1-wire data from 0x02: err=3D%d.\n", err=
);
+		return err;
+	}
+
+	return err;
+}
+
+#if 0
+
+int ds_stop_pulse(struct ds_device *dev, int limit)
+{
+	struct ds_status st;
+	int count =3D 0, err =3D 0;
+	u8 buf[0x20];
+
+	do {
+		err =3D ds_send_control(dev, CTL_HALT_EXE_IDLE, 0);
+		if (err)
+			break;
+		err =3D ds_send_control(dev, CTL_RESUME_EXE, 0);
+		if (err)
+			break;
+		err =3D ds_recv_status_nodump(dev, &st, buf, sizeof(buf));
+		if (err)
+			break;
+
+		if ((st.status & ST_SPUA) =3D 0) {
+			err =3D ds_send_control_mode(dev, MOD_PULSE_EN, 0);
+			if (err)
+				break;
+		}
+	} while(++count < limit);
+
+	return err;
+}
+
+int ds_detect(struct ds_device *dev, struct ds_status *st)
+{
+	int err;
+
+	err =3D ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
+	if (err)
+		return err;
+
+	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
+	if (err)
+		return err;
+
+	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x4=
0);
+	if (err)
+		return err;
+
+	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
+	if (err)
+		return err;
+
+	err =3D ds_recv_status(dev, st);
+
+	return err;
+}
+
+#endif  /*  0  */
+
+static int ds_wait_status(struct ds_device *dev, struct ds_status *st)
+{
+	u8 buf[0x20];
+	int err, count =3D 0;
+
+	do {
+		err =3D ds_recv_status_nodump(dev, st, buf, sizeof(buf));
+#if 0
+		if (err >=3D 0) {
+			int i;
+			printk("0x%x: count=3D%d, status: ", dev->ep[EP_STATUS], err);
+			for (i=3D0; i<err; ++i)
+				printk("%02x ", buf[i]);
+			printk("\n");
+		}
+#endif
+	} while(!(buf[0x08] & 0x20) && !(err < 0) && ++count < 100);
+
+
+	if (((err > 16) && (buf[0x10] & 0x01)) || count >=3D 100 || err < 0) {
+		ds_recv_status(dev, st);
+		return -1;
+	} else
+		return 0;
+}
+
+int ds_reset(struct ds_device *dev, struct ds_status *st)
+{
+	int err;
+
+	//err =3D ds_send_control(dev, COMM_1_WIRE_RESET | COMM_F | COMM_IM | COM=
M_SE, SPEED_FLEXIBLE);
+	err =3D ds_send_control(dev, 0x43, SPEED_NORMAL);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, st);
+#if 0
+	if (st->command_buffer_status) {
+		printk(KERN_INFO "Short circuit.\n");
+		return -EIO;
+	}
+#endif
+
+	return 0;
+}
+
+#if 0
+int ds_set_speed(struct ds_device *dev, int speed)
+{
+	int err;
+
+	if (speed !=3D SPEED_NORMAL && speed !=3D SPEED_FLEXIBLE && speed !=3D SP=
EED_OVERDRIVE)
+		return -EINVAL;
+
+	if (speed !=3D SPEED_OVERDRIVE)
+		speed =3D SPEED_FLEXIBLE;
+
+	speed &=3D 0xff;
+
+	err =3D ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
+	if (err)
+		return err;
+
+	return err;
+}
+#endif  /*  0  */
+
+static int ds_start_pulse(struct ds_device *dev, int delay)
+{
+	int err;
+	u8 del =3D 1 + (u8)(delay >> 4);
+	struct ds_status st;
+
+#if 0
+	err =3D ds_stop_pulse(dev, 10);
+	if (err)
+		return err;
+
+	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
+	if (err)
+		return err;
+#endif
+	err =3D ds_send_control(dev, COMM_SET_DURATION | COMM_IM, del);
+	if (err)
+		return err;
+
+	err =3D ds_send_control(dev, COMM_PULSE | COMM_IM | COMM_F, 0);
+	if (err)
+		return err;
+
+	mdelay(delay);
+
+	ds_wait_status(dev, &st);
+
+	return err;
+}
+
+int ds_touch_bit(struct ds_device *dev, u8 bit, u8 *tbit)
+{
+	int err, count;
+	struct ds_status st;
+	u16 value =3D (COMM_BIT_IO | COMM_IM) | ((bit) ? COMM_D : 0);
+	u16 cmd;
+
+	err =3D ds_send_control(dev, value, 0);
+	if (err)
+		return err;
+
+	count =3D 0;
+	do {
+		err =3D ds_wait_status(dev, &st);
+		if (err)
+			return err;
+
+		cmd =3D st.command0 | (st.command1 << 8);
+	} while (cmd !=3D value && ++count < 10);
+
+	if (err < 0 || count >=3D 10) {
+		printk(KERN_ERR "Failed to obtain status.\n");
+		return -EINVAL;
+	}
+
+	err =3D ds_recv_data(dev, tbit, sizeof(*tbit));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int ds_write_bit(struct ds_device *dev, u8 bit)
+{
+	int err;
+	struct ds_status st;
+
+	err =3D ds_send_control(dev, COMM_BIT_IO | COMM_IM | (bit) ? COMM_D : 0, =
0);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+int ds_write_byte(struct ds_device *dev, u8 byte)
+{
+	int err;
+	struct ds_status st;
+	u8 rbyte;
+
+	err =3D ds_send_control(dev, COMM_BYTE_IO | COMM_IM | COMM_SPU, byte);
+	if (err)
+		return err;
+
+	err =3D ds_wait_status(dev, &st);
+	if (err)
+		return err;
+
+	err =3D ds_recv_data(dev, &rbyte, sizeof(rbyte));
+	if (err < 0)
+		return err;
+
+	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+
+	return !(byte =3D rbyte);
+}
+
+int ds_read_bit(struct ds_device *dev, u8 *bit)
+{
+	int err;
+
+	err =3D ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
+	if (err)
+		return err;
+
+	err =3D ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0=
);
+	if (err)
+		return err;
+
+	err =3D ds_recv_data(dev, bit, sizeof(*bit));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int ds_read_byte(struct ds_device *dev, u8 *byte)
+{
+	int err;
+	struct ds_status st;
+
+	err =3D ds_send_control(dev, COMM_BYTE_IO | COMM_IM , 0xff);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err =3D ds_recv_data(dev, byte, sizeof(*byte));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+{
+	struct ds_status st;
+	int err;
+
+	if (len > 64*1024)
+		return -E2BIG;
+
+	memset(buf, 0xFF, len);
+
+	err =3D ds_send_data(dev, buf, len);
+	if (err < 0)
+		return err;
+
+	err =3D ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	memset(buf, 0x00, len);
+	err =3D ds_recv_data(dev, buf, len);
+
+	return err;
+}
+
+int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+{
+	int err;
+	struct ds_status st;
+
+	err =3D ds_send_data(dev, buf, len);
+	if (err < 0)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err =3D ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err =3D ds_recv_data(dev, buf, len);
+	if (err < 0)
+		return err;
+
+	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
+
+	return !(err =3D len);
+}
+
+#if 0
+
+int ds_search(struct ds_device *dev, u64 init, u64 *buf, u8 id_number, int=
 conditional_search)
+{
+	int err;
+	u16 value, index;
+	struct ds_status st;
+
+	memset(buf, 0, sizeof(buf));
+
+	err =3D ds_send_data(ds_dev, (unsigned char *)&init, 8);
+	if (err)
+		return err;
+
+	ds_wait_status(ds_dev, &st);
+
+	value =3D COMM_SEARCH_ACCESS | COMM_IM | COMM_SM | COMM_F | COMM_RTS;
+	index =3D (conditional_search ? 0xEC : 0xF0) | (id_number << 8);
+	err =3D ds_send_control(ds_dev, value, index);
+	if (err)
+		return err;
+
+	ds_wait_status(ds_dev, &st);
+
+	err =3D ds_recv_data(ds_dev, (unsigned char *)buf, 8*id_number);
+	if (err < 0)
+		return err;
+
+	return err/8;
+}
+
+int ds_match_access(struct ds_device *dev, u64 init)
+{
+	int err;
+	struct ds_status st;
+
+	err =3D ds_send_data(dev, (unsigned char *)&init, sizeof(init));
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err =3D ds_send_control(dev, COMM_MATCH_ACCESS | COMM_IM | COMM_RST, 0x00=
55);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+int ds_set_path(struct ds_device *dev, u64 init)
+{
+	int err;
+	struct ds_status st;
+	u8 buf[9];
+
+	memcpy(buf, &init, 8);
+	buf[8] =3D BRANCH_MAIN;
+
+	err =3D ds_send_data(dev, buf, sizeof(buf));
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	err =3D ds_send_control(dev, COMM_SET_PATH | COMM_IM | COMM_RST, 0);
+	if (err)
+		return err;
+
+	ds_wait_status(dev, &st);
+
+	return 0;
+}
+
+#endif  /*  0  */
+
+static int ds_probe(struct usb_interface *intf,
+		    const struct usb_device_id *udev_id)
+{
+	struct usb_device *udev =3D interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *endpoint;
+	struct usb_host_interface *iface_desc;
+	int i, err;
+
+	ds_dev =3D kmalloc(sizeof(struct ds_device), GFP_KERNEL);
+	if (!ds_dev) {
+		printk(KERN_INFO "Failed to allocate new DS9490R structure.\n");
+		return -ENOMEM;
+	}
+
+	ds_dev->udev =3D usb_get_dev(udev);
+	usb_set_intfdata(intf, ds_dev);
+
+	err =3D usb_set_interface(ds_dev->udev, intf->altsetting[0].desc.bInterfa=
ceNumber, 3);
+	if (err) {
+		printk(KERN_ERR "Failed to set alternative setting 3 for %d interface: e=
rr=3D%d.\n",
+				intf->altsetting[0].desc.bInterfaceNumber, err);
+		return err;
+	}
+
+	err =3D usb_reset_configuration(ds_dev->udev);
+	if (err) {
+		printk(KERN_ERR "Failed to reset configuration: err=3D%d.\n", err);
+		return err;
+	}
+
+	iface_desc =3D &intf->altsetting[0];
+	if (iface_desc->desc.bNumEndpoints !=3D NUM_EP-1) {
+		printk(KERN_INFO "Num endpoints=3D%d. It is not DS9490R.\n", iface_desc-=
>desc.bNumEndpoints);
+		return -ENODEV;
+	}
+
+	atomic_set(&ds_dev->refcnt, 0);
+	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
+
+	/*
+	 * This loop doesn'd show control 0 endpoint,
+	 * so we will fill only 1-3 endpoints entry.
+	 */
+	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
+		endpoint =3D &iface_desc->endpoint[i].desc;
+
+		ds_dev->ep[i+1] =3D endpoint->bEndpointAddress;
+
+		printk("%d: addr=3D%x, size=3D%d, dir=3D%s, type=3D%x\n",
+			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
+			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
+			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
+	}
+
+#if 0
+	{
+		int err, i;
+		u64 buf[3];
+		u64 init=3D0xb30000002078ee81ull;
+		struct ds_status st;
+
+		ds_reset(ds_dev, &st);
+		err =3D ds_search(ds_dev, init, buf, 3, 0);
+		if (err < 0)
+			return err;
+		for (i=3D0; i<err; ++i)
+			printk("%d: %llx\n", i, buf[i]);
+
+		printk("Resetting...\n");
+		ds_reset(ds_dev, &st);
+		printk("Setting path for %llx.\n", init);
+		err =3D ds_set_path(ds_dev, init);
+		if (err)
+			return err;
+		printk("Calling MATCH_ACCESS.\n");
+		err =3D ds_match_access(ds_dev, init);
+		if (err)
+			return err;
+
+		printk("Searching the bus...\n");
+		err =3D ds_search(ds_dev, init, buf, 3, 0);
+
+		printk("ds_search() returned %d\n", err);
+
+		if (err < 0)
+			return err;
+		for (i=3D0; i<err; ++i)
+			printk("%d: %llx\n", i, buf[i]);
+
+		return 0;
+	}
+#endif
+
+	return 0;
+}
+
+static void ds_disconnect(struct usb_interface *intf)
+{
+	struct ds_device *dev;
+
+	dev =3D usb_get_intfdata(intf);
+	usb_set_intfdata(intf, NULL);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting for DS to become free: refcnt=3D%d.\n",
+				atomic_read(&dev->refcnt));
+
+		if (msleep_interruptible(1000))
+			flush_signals(current);
+	}
+
+	usb_put_dev(dev->udev);
+	kfree(dev);
+	ds_dev =3D NULL;
+}
+
+static int ds_init(void)
+{
+	int err;
+
+	err =3D usb_register(&ds_driver);
+	if (err) {
+		printk(KERN_INFO "Failed to register DS9490R USB device: err=3D%d.\n", e=
rr);
+		return err;
+	}
+
+	return 0;
+}
+
+static void ds_fini(void)
+{
+	usb_deregister(&ds_driver);
+}
+
+module_init(ds_init);
+module_exit(ds_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
+
+EXPORT_SYMBOL(ds_touch_bit);
+EXPORT_SYMBOL(ds_read_byte);
+EXPORT_SYMBOL(ds_read_bit);
+EXPORT_SYMBOL(ds_read_block);
+EXPORT_SYMBOL(ds_write_byte);
+EXPORT_SYMBOL(ds_write_bit);
+EXPORT_SYMBOL(ds_write_block);
+EXPORT_SYMBOL(ds_reset);
+EXPORT_SYMBOL(ds_get_device);
+EXPORT_SYMBOL(ds_put_device);
+
+/*
+ * This functions can be used for EEPROM programming,
+ * when driver will be included into mainline this will
+ * require uncommenting.
+ */
+#if 0
+EXPORT_SYMBOL(ds_start_pulse);
+EXPORT_SYMBOL(ds_set_speed);
+EXPORT_SYMBOL(ds_detect);
+EXPORT_SYMBOL(ds_stop_pulse);
+EXPORT_SYMBOL(ds_search);
+#endif
Index: linux-2.6.15-rc3-mm1/drivers/w1/dscore.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/dscore.h
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- *	dscore.h
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __DSCORE_H
-#define __DSCORE_H
-
-#include <linux/usb.h>
-#include <asm/atomic.h>
-
-/* COMMAND TYPE CODES */
-#define CONTROL_CMD			0x00
-#define COMM_CMD			0x01
-#define MODE_CMD			0x02
-
-/* CONTROL COMMAND CODES */
-#define CTL_RESET_DEVICE		0x0000
-#define CTL_START_EXE			0x0001
-#define CTL_RESUME_EXE			0x0002
-#define CTL_HALT_EXE_IDLE		0x0003
-#define CTL_HALT_EXE_DONE		0x0004
-#define CTL_FLUSH_COMM_CMDS		0x0007
-#define CTL_FLUSH_RCV_BUFFER		0x0008
-#define CTL_FLUSH_XMT_BUFFER		0x0009
-#define CTL_GET_COMM_CMDS		0x000A
-
-/* MODE COMMAND CODES */
-#define MOD_PULSE_EN			0x0000
-#define MOD_SPEED_CHANGE_EN		0x0001
-#define MOD_1WIRE_SPEED			0x0002
-#define MOD_STRONG_PU_DURATION		0x0003
-#define MOD_PULLDOWN_SLEWRATE		0x0004
-#define MOD_PROG_PULSE_DURATION		0x0005
-#define MOD_WRITE1_LOWTIME		0x0006
-#define MOD_DSOW0_TREC			0x0007
-
-/* COMMUNICATION COMMAND CODES */
-#define COMM_ERROR_ESCAPE		0x0601
-#define COMM_SET_DURATION		0x0012
-#define COMM_BIT_IO			0x0020
-#define COMM_PULSE			0x0030
-#define COMM_1_WIRE_RESET		0x0042
-#define COMM_BYTE_IO			0x0052
-#define COMM_MATCH_ACCESS		0x0064
-#define COMM_BLOCK_IO			0x0074
-#define COMM_READ_STRAIGHT		0x0080
-#define COMM_DO_RELEASE			0x6092
-#define COMM_SET_PATH			0x00A2
-#define COMM_WRITE_SRAM_PAGE		0x00B2
-#define COMM_WRITE_EPROM		0x00C4
-#define COMM_READ_CRC_PROT_PAGE		0x00D4
-#define COMM_READ_REDIRECT_PAGE_CRC	0x21E4
-#define COMM_SEARCH_ACCESS		0x00F4
-
-/* Communication command bits */
-#define COMM_TYPE			0x0008
-#define COMM_SE				0x0008
-#define COMM_D				0x0008
-#define COMM_Z				0x0008
-#define COMM_CH				0x0008
-#define COMM_SM				0x0008
-#define COMM_R				0x0008
-#define COMM_IM				0x0001
-
-#define COMM_PS				0x4000
-#define COMM_PST			0x4000
-#define COMM_CIB			0x4000
-#define COMM_RTS			0x4000
-#define COMM_DT				0x2000
-#define COMM_SPU			0x1000
-#define COMM_F				0x0800
-#define COMM_NTP			0x0400
-#define COMM_ICP			0x0200
-#define COMM_RST			0x0100
-
-#define PULSE_PROG			0x01
-#define PULSE_SPUE			0x02
-
-#define BRANCH_MAIN			0xCC
-#define BRANCH_AUX			0x33
-
-/*
- * Duration of the strong pull-up pulse in milliseconds.
- */
-#define PULLUP_PULSE_DURATION		750
-
-/* Status flags */
-#define ST_SPUA				0x01  /* Strong Pull-up is active */
-#define ST_PRGA				0x02  /* 12V programming pulse is being generated */
-#define ST_12VP				0x04  /* external 12V programming voltage is present */
-#define ST_PMOD				0x08  /* DS2490 powered from USB and external sources */
-#define ST_HALT				0x10  /* DS2490 is currently halted */
-#define ST_IDLE				0x20  /* DS2490 is currently idle */
-#define ST_EPOF				0x80
-
-#define SPEED_NORMAL			0x00
-#define SPEED_FLEXIBLE			0x01
-#define SPEED_OVERDRIVE			0x02
-
-#define NUM_EP				4
-#define EP_CONTROL			0
-#define EP_STATUS			1
-#define EP_DATA_OUT			2
-#define EP_DATA_IN			3
-
-struct ds_device
-{
-	struct usb_device	*udev;
-	struct usb_interface	*intf;
-
-	int			ep[NUM_EP];
-
-	atomic_t		refcnt;
-};
-
-struct ds_status
-{
-	u8			enable;
-	u8			speed;
-	u8			pullup_dur;
-	u8			ppuls_dur;
-	u8			pulldown_slew;
-	u8			write1_time;
-	u8			write0_time;
-	u8			reserved0;
-	u8			status;
-	u8			command0;
-	u8			command1;
-	u8			command_buffer_status;
-	u8			data_out_buffer_status;
-	u8			data_in_buffer_status;
-	u8			reserved1;
-	u8			reserved2;
-
-};
-
-int ds_touch_bit(struct ds_device *, u8, u8 *);
-int ds_read_byte(struct ds_device *, u8 *);
-int ds_read_bit(struct ds_device *, u8 *);
-int ds_write_byte(struct ds_device *, u8);
-int ds_write_bit(struct ds_device *, u8);
-int ds_reset(struct ds_device *, struct ds_status *);
-struct ds_device * ds_get_device(void);
-void ds_put_device(struct ds_device *);
-int ds_write_block(struct ds_device *, u8 *, int);
-int ds_read_block(struct ds_device *, u8 *, int);
-
-#endif /* __DSCORE_H */
-
Index: linux-2.6.15-rc3-mm1/drivers/w1/masters/dscore.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/masters/dscore.h
@@ -0,0 +1,166 @@
+/*
+ *	dscore.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __DSCORE_H
+#define __DSCORE_H
+
+#include <linux/usb.h>
+#include <asm/atomic.h>
+
+/* COMMAND TYPE CODES */
+#define CONTROL_CMD			0x00
+#define COMM_CMD			0x01
+#define MODE_CMD			0x02
+
+/* CONTROL COMMAND CODES */
+#define CTL_RESET_DEVICE		0x0000
+#define CTL_START_EXE			0x0001
+#define CTL_RESUME_EXE			0x0002
+#define CTL_HALT_EXE_IDLE		0x0003
+#define CTL_HALT_EXE_DONE		0x0004
+#define CTL_FLUSH_COMM_CMDS		0x0007
+#define CTL_FLUSH_RCV_BUFFER		0x0008
+#define CTL_FLUSH_XMT_BUFFER		0x0009
+#define CTL_GET_COMM_CMDS		0x000A
+
+/* MODE COMMAND CODES */
+#define MOD_PULSE_EN			0x0000
+#define MOD_SPEED_CHANGE_EN		0x0001
+#define MOD_1WIRE_SPEED			0x0002
+#define MOD_STRONG_PU_DURATION		0x0003
+#define MOD_PULLDOWN_SLEWRATE		0x0004
+#define MOD_PROG_PULSE_DURATION		0x0005
+#define MOD_WRITE1_LOWTIME		0x0006
+#define MOD_DSOW0_TREC			0x0007
+
+/* COMMUNICATION COMMAND CODES */
+#define COMM_ERROR_ESCAPE		0x0601
+#define COMM_SET_DURATION		0x0012
+#define COMM_BIT_IO			0x0020
+#define COMM_PULSE			0x0030
+#define COMM_1_WIRE_RESET		0x0042
+#define COMM_BYTE_IO			0x0052
+#define COMM_MATCH_ACCESS		0x0064
+#define COMM_BLOCK_IO			0x0074
+#define COMM_READ_STRAIGHT		0x0080
+#define COMM_DO_RELEASE			0x6092
+#define COMM_SET_PATH			0x00A2
+#define COMM_WRITE_SRAM_PAGE		0x00B2
+#define COMM_WRITE_EPROM		0x00C4
+#define COMM_READ_CRC_PROT_PAGE		0x00D4
+#define COMM_READ_REDIRECT_PAGE_CRC	0x21E4
+#define COMM_SEARCH_ACCESS		0x00F4
+
+/* Communication command bits */
+#define COMM_TYPE			0x0008
+#define COMM_SE				0x0008
+#define COMM_D				0x0008
+#define COMM_Z				0x0008
+#define COMM_CH				0x0008
+#define COMM_SM				0x0008
+#define COMM_R				0x0008
+#define COMM_IM				0x0001
+
+#define COMM_PS				0x4000
+#define COMM_PST			0x4000
+#define COMM_CIB			0x4000
+#define COMM_RTS			0x4000
+#define COMM_DT				0x2000
+#define COMM_SPU			0x1000
+#define COMM_F				0x0800
+#define COMM_NTP			0x0400
+#define COMM_ICP			0x0200
+#define COMM_RST			0x0100
+
+#define PULSE_PROG			0x01
+#define PULSE_SPUE			0x02
+
+#define BRANCH_MAIN			0xCC
+#define BRANCH_AUX			0x33
+
+/*
+ * Duration of the strong pull-up pulse in milliseconds.
+ */
+#define PULLUP_PULSE_DURATION		750
+
+/* Status flags */
+#define ST_SPUA				0x01  /* Strong Pull-up is active */
+#define ST_PRGA				0x02  /* 12V programming pulse is being generated */
+#define ST_12VP				0x04  /* external 12V programming voltage is present */
+#define ST_PMOD				0x08  /* DS2490 powered from USB and external sources */
+#define ST_HALT				0x10  /* DS2490 is currently halted */
+#define ST_IDLE				0x20  /* DS2490 is currently idle */
+#define ST_EPOF				0x80
+
+#define SPEED_NORMAL			0x00
+#define SPEED_FLEXIBLE			0x01
+#define SPEED_OVERDRIVE			0x02
+
+#define NUM_EP				4
+#define EP_CONTROL			0
+#define EP_STATUS			1
+#define EP_DATA_OUT			2
+#define EP_DATA_IN			3
+
+struct ds_device
+{
+	struct usb_device	*udev;
+	struct usb_interface	*intf;
+
+	int			ep[NUM_EP];
+
+	atomic_t		refcnt;
+};
+
+struct ds_status
+{
+	u8			enable;
+	u8			speed;
+	u8			pullup_dur;
+	u8			ppuls_dur;
+	u8			pulldown_slew;
+	u8			write1_time;
+	u8			write0_time;
+	u8			reserved0;
+	u8			status;
+	u8			command0;
+	u8			command1;
+	u8			command_buffer_status;
+	u8			data_out_buffer_status;
+	u8			data_in_buffer_status;
+	u8			reserved1;
+	u8			reserved2;
+
+};
+
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_reset(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
+int ds_write_block(struct ds_device *, u8 *, int);
+int ds_read_block(struct ds_device *, u8 *, int);
+
+#endif /* __DSCORE_H */
+
Index: linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_ds2433.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_ds2433.c
@@ -0,0 +1,329 @@
+/*
+ *	w1_ds2433.c - w1 family 23 (DS2433) driver
+ *
+ * Copyright (c) 2005 Ben Gardner <bgardner at wabtec.com>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2. See the file COPYING for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#ifdef CONFIG_W1_F23_CRC
+#include <linux/crc16.h>
+
+#define CRC16_INIT		0
+#define CRC16_VALID		0xb001
+
+#endif
+
+#include "../w1.h"
+#include "../w1_io.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ben Gardner <bgardner at wabtec.com>");
+MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
+
+#define W1_EEPROM_SIZE		512
+#define W1_PAGE_COUNT		16
+#define W1_PAGE_SIZE		32
+#define W1_PAGE_BITS		5
+#define W1_PAGE_MASK		0x1F
+
+#define W1_F23_TIME		300
+
+#define W1_F23_READ_EEPROM	0xF0
+#define W1_F23_WRITE_SCRATCH	0x0F
+#define W1_F23_READ_SCRATCH	0xAA
+#define W1_F23_COPY_SCRATCH	0x55
+
+struct w1_f23_data {
+	u8	memory[W1_EEPROM_SIZE];
+	u32	validcrc;
+};
+
+/**
+ * Check the file size bounds and adjusts count as needed.
+ * This would not be needed if the file size didn't reset to 0 after a wri=
te.
+ */
+static inline size_t w1_f23_fix_count(loff_t off, size_t count, size_t siz=
e)
+{
+	if (off > size)
+		return 0;
+
+	if ((off + count) > size)
+		return (size - off);
+
+	return count;
+}
+
+#ifdef CONFIG_W1_F23_CRC
+static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *d=
ata,
+				int block)
+{
+	u8	wrbuf[3];
+	int	off =3D block * W1_PAGE_SIZE;
+
+	if (data->validcrc & (1 << block))
+		return 0;
+
+	if (w1_reset_select_slave(sl)) {
+		data->validcrc =3D 0;
+		return -EIO;
+	}
+
+	wrbuf[0] =3D W1_F23_READ_EEPROM;
+	wrbuf[1] =3D off & 0xff;
+	wrbuf[2] =3D off >> 8;
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_read_block(sl->master, &data->memory[off], W1_PAGE_SIZE);
+
+	/* cache the block if the CRC is valid */
+	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) =3D CRC16_VALID)
+		data->validcrc |=3D (1 << block);
+
+	return 0;
+}
+#endif	/* CONFIG_W1_F23_CRC */
+
+static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off,
+			       size_t count)
+{
+	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
+#ifdef CONFIG_W1_F23_CRC
+	struct w1_f23_data *data =3D sl->family_data;
+	int i, min_page, max_page;
+#else
+	u8 wrbuf[3];
+#endif
+
+	if ((count =3D w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) =3D 0)
+		return 0;
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count =3D 0;
+		goto out_dec;
+	}
+
+#ifdef CONFIG_W1_F23_CRC
+
+	min_page =3D (off >> W1_PAGE_BITS);
+	max_page =3D (off + count - 1) >> W1_PAGE_BITS;
+	for (i =3D min_page; i <=3D max_page; i++) {
+		if (w1_f23_refresh_block(sl, data, i)) {
+			count =3D -EIO;
+			goto out_up;
+		}
+	}
+	memcpy(buf, &data->memory[off], count);
+
+#else 	/* CONFIG_W1_F23_CRC */
+
+	/* read directly from the EEPROM */
+	if (w1_reset_select_slave(sl)) {
+		count =3D -EIO;
+		goto out_up;
+	}
+
+	wrbuf[0] =3D W1_F23_READ_EEPROM;
+	wrbuf[1] =3D off & 0xff;
+	wrbuf[2] =3D off >> 8;
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_read_block(sl->master, buf, count);
+
+#endif	/* CONFIG_W1_F23_CRC */
+
+out_up:
+	up(&sl->master->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+/**
+ * Writes to the scratchpad and reads it back for verification.
+ * Then copies the scratchpad to EEPROM.
+ * The data must be on one page.
+ * The master must be locked.
+ *
+ * @param sl	The slave structure
+ * @param addr	Address for the write
+ * @param len   length must be <=3D (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
+ * @param data	The data to write
+ * @return	0=3DSuccess -1=FAilure
+ */
+static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *=
data)
+{
+	u8 wrbuf[4];
+	u8 rdbuf[W1_PAGE_SIZE + 3];
+	u8 es =3D (addr + len - 1) & 0x1f;
+
+	/* Write the data to the scratchpad */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] =3D W1_F23_WRITE_SCRATCH;
+	wrbuf[1] =3D addr & 0xff;
+	wrbuf[2] =3D addr >> 8;
+
+	w1_write_block(sl->master, wrbuf, 3);
+	w1_write_block(sl->master, data, len);
+
+	/* Read the scratchpad and verify */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	w1_write_8(sl->master, W1_F23_READ_SCRATCH);
+	w1_read_block(sl->master, rdbuf, len + 3);
+
+	/* Compare what was read against the data written */
+	if ((rdbuf[0] !=3D wrbuf[1]) || (rdbuf[1] !=3D wrbuf[2]) ||
+	    (rdbuf[2] !=3D es) || (memcmp(data, &rdbuf[3], len) !=3D 0))
+		return -1;
+
+	/* Copy the scratchpad to EEPROM */
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	wrbuf[0] =3D W1_F23_COPY_SCRATCH;
+	wrbuf[3] =3D es;
+	w1_write_block(sl->master, wrbuf, 4);
+
+	/* Sleep for 5 ms to wait for the write to complete */
+	msleep(5);
+
+	/* Reset the bus to wake up the EEPROM (this may not be needed) */
+	w1_reset_bus(sl->master);
+
+	return 0;
+}
+
+static ssize_t w1_f23_write_bin(struct kobject *kobj, char *buf, loff_t of=
f,
+				size_t count)
+{
+	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
+	int addr, len, idx;
+
+	if ((count =3D w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) =3D 0)
+		return 0;
+
+#ifdef CONFIG_W1_F23_CRC
+	/* can only write full blocks in cached mode */
+	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
+		dev_err(&sl->dev, "invalid offset/count off=3D%d cnt=3D%zd\n",
+			(int)off, count);
+		return -EINVAL;
+	}
+
+	/* make sure the block CRCs are valid */
+	for (idx =3D 0; idx < count; idx +=3D W1_PAGE_SIZE) {
+		if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) !=3D CRC16_VALID) {
+			dev_err(&sl->dev, "bad CRC at offset %d\n", (int)off);
+			return -EINVAL;
+		}
+	}
+#endif	/* CONFIG_W1_F23_CRC */
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count =3D 0;
+		goto out_dec;
+	}
+
+	/* Can only write data to one page at a time */
+	idx =3D 0;
+	while (idx < count) {
+		addr =3D off + idx;
+		len =3D W1_PAGE_SIZE - (addr & W1_PAGE_MASK);
+		if (len > (count - idx))
+			len =3D count - idx;
+
+		if (w1_f23_write(sl, addr, len, &buf[idx]) < 0) {
+			count =3D -EIO;
+			goto out_up;
+		}
+		idx +=3D len;
+	}
+
+out_up:
+	up(&sl->master->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+static struct bin_attribute w1_f23_bin_attr =3D {
+	.attr =3D {
+		.name =3D "eeprom",
+		.mode =3D S_IRUGO | S_IWUSR,
+		.owner =3D THIS_MODULE,
+	},
+	.size =3D W1_EEPROM_SIZE,
+	.read =3D w1_f23_read_bin,
+	.write =3D w1_f23_write_bin,
+};
+
+static int w1_f23_add_slave(struct w1_slave *sl)
+{
+	int err;
+#ifdef CONFIG_W1_F23_CRC
+	struct w1_f23_data *data;
+
+	data =3D kmalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	memset(data, 0, sizeof(struct w1_f23_data));
+	sl->family_data =3D data;
+
+#endif	/* CONFIG_W1_F23_CRC */
+
+	err =3D sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+
+#ifdef CONFIG_W1_F23_CRC
+	if (err)
+		kfree(data);
+#endif	/* CONFIG_W1_F23_CRC */
+
+	return err;
+}
+
+static void w1_f23_remove_slave(struct w1_slave *sl)
+{
+#ifdef CONFIG_W1_F23_CRC
+	kfree(sl->family_data);
+	sl->family_data =3D NULL;
+#endif	/* CONFIG_W1_F23_CRC */
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
+}
+
+static struct w1_family_ops w1_f23_fops =3D {
+	.add_slave      =3D w1_f23_add_slave,
+	.remove_slave   =3D w1_f23_remove_slave,
+};
+
+static struct w1_family w1_family_23 =3D {
+	.fid =3D W1_EEPROM_DS2433,
+	.fops =3D &w1_f23_fops,
+};
+
+static int __init w1_f23_init(void)
+{
+	return w1_register_family(&w1_family_23);
+}
+
+static void __exit w1_f23_fini(void)
+{
+	w1_unregister_family(&w1_family_23);
+}
+
+module_init(w1_f23_init);
+module_exit(w1_f23_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_smem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_smem.c
@@ -0,0 +1,71 @@
+/*
+ *	w1_smem.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/types.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "../w1.h"
+#include "../w1_io.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memor=
y family.");
+
+static struct w1_family w1_smem_family_01 =3D {
+	.fid =3D W1_FAMILY_SMEM_01,
+};
+
+static struct w1_family w1_smem_family_81 =3D {
+	.fid =3D W1_FAMILY_SMEM_81,
+};
+
+static int __init w1_smem_init(void)
+{
+	int err;
+
+	err =3D w1_register_family(&w1_smem_family_01);
+	if (err)
+		return err;
+
+	err =3D w1_register_family(&w1_smem_family_81);
+	if (err) {
+		w1_unregister_family(&w1_smem_family_01);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit w1_smem_fini(void)
+{
+	w1_unregister_family(&w1_smem_family_01);
+	w1_unregister_family(&w1_smem_family_81);
+}
+
+module_init(w1_smem_init);
+module_exit(w1_smem_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_therm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null
+++ linux-2.6.15-rc3-mm1/drivers/w1/slaves/w1_therm.c
@@ -0,0 +1,268 @@
+/*
+ *	w1_therm.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the therms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/types.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include "../w1.h"
+#include "../w1_io.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature=
 family.");
+
+static u8 bad_roms[][9] =3D {
+				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87},
+				{}
+			};
+
+static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
+
+static struct bin_attribute w1_therm_bin_attr =3D {
+	.attr =3D {
+		.name =3D "w1_slave",
+		.mode =3D S_IRUGO,
+		.owner =3D THIS_MODULE,
+	},
+	.size =3D W1_SLAVE_DATA_SIZE,
+	.read =3D w1_therm_read_bin,
+};
+
+static int w1_therm_add_slave(struct w1_slave *sl)
+{
+	return sysfs_create_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}
+
+static void w1_therm_remove_slave(struct w1_slave *sl)
+{
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
+}
+
+static struct w1_family_ops w1_therm_fops =3D {
+	.add_slave	=3D w1_therm_add_slave,
+	.remove_slave	=3D w1_therm_remove_slave,
+};
+
+static struct w1_family w1_therm_family_DS18S20 =3D {
+	.fid =3D W1_THERM_DS18S20,
+	.fops =3D &w1_therm_fops,
+};
+
+static struct w1_family w1_therm_family_DS18B20 =3D {
+	.fid =3D W1_THERM_DS18B20,
+	.fops =3D &w1_therm_fops,
+};
+
+static struct w1_family w1_therm_family_DS1822 =3D {
+	.fid =3D W1_THERM_DS1822,
+	.fops =3D &w1_therm_fops,
+};
+
+struct w1_therm_family_converter
+{
+	u8			broken;
+	u16			reserved;
+	struct w1_family	*f;
+	int			(*convert)(u8 rom[9]);
+};
+
+static inline int w1_DS18B20_convert_temp(u8 rom[9]);
+static inline int w1_DS18S20_convert_temp(u8 rom[9]);
+
+static struct w1_therm_family_converter w1_therm_families[] =3D {
+	{
+		.f		=3D &w1_therm_family_DS18S20,
+		.convert 	=3D w1_DS18S20_convert_temp
+	},
+	{
+		.f		=3D &w1_therm_family_DS1822,
+		.convert 	=3D w1_DS18B20_convert_temp
+	},
+	{
+		.f		=3D &w1_therm_family_DS18B20,
+		.convert 	=3D w1_DS18B20_convert_temp
+	},
+};
+
+static inline int w1_DS18B20_convert_temp(u8 rom[9])
+{
+	int t =3D (rom[1] << 8) | rom[0];
+	t /=3D 16;
+	return t;
+}
+
+static inline int w1_DS18S20_convert_temp(u8 rom[9])
+{
+	int t, h;
+
+	if (!rom[7])
+		return 0;
+
+	if (rom[1] =3D 0)
+		t =3D ((s32)rom[0] >> 1)*1000;
+	else
+		t =3D 1000*(-1*(s32)(0x100-rom[0]) >> 1);
+
+	t -=3D 250;
+	h =3D 1000*((s32)rom[7] - (s32)rom[6]);
+	h /=3D (s32)rom[7];
+	t +=3D h;
+
+	return t;
+}
+
+static inline int w1_convert_temp(u8 rom[9], u8 fid)
+{
+	int i;
+
+	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
+		if (w1_therm_families[i].f->fid =3D fid)
+			return w1_therm_families[i].convert(rom);
+
+	return 0;
+}
+
+static int w1_therm_check_rom(u8 rom[9])
+{
+	int i;
+
+	for (i=3D0; i<sizeof(bad_roms)/9; ++i)
+		if (!memcmp(bad_roms[i], rom, 9))
+			return 1;
+
+	return 0;
+}
+
+static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
+{
+	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
+	struct w1_master *dev =3D sl->master;
+	u8 rom[9], crc, verdict;
+	int i, max_trying =3D 10;
+
+	atomic_inc(&sl->refcnt);
+	smp_mb__after_atomic_inc();
+	if (down_interruptible(&sl->master->mutex)) {
+		count =3D 0;
+		goto out_dec;
+	}
+
+	if (off > W1_SLAVE_DATA_SIZE) {
+		count =3D 0;
+		goto out;
+	}
+	if (off + count > W1_SLAVE_DATA_SIZE) {
+		count =3D 0;
+		goto out;
+	}
+
+	memset(buf, 0, count);
+	memset(rom, 0, sizeof(rom));
+
+	count =3D 0;
+	verdict =3D 0;
+	crc =3D 0;
+
+	while (max_trying--) {
+		if (!w1_reset_select_slave(sl)) {
+			int count =3D 0;
+			unsigned int tm =3D 750;
+
+			w1_write_8(dev, W1_CONVERT_TEMP);
+
+			while (tm) {
+				tm =3D msleep_interruptible(tm);
+				if (signal_pending(current))
+					flush_signals(current);
+			}
+
+			if (!w1_reset_select_slave(sl)) {
+
+				w1_write_8(dev, W1_READ_SCRATCHPAD);
+				if ((count =3D w1_read_block(dev, rom, 9)) !=3D 9) {
+					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", co=
unt);
+				}
+
+				crc =3D w1_calc_crc8(rom, 8);
+
+				if (rom[8] =3D crc && rom[0])
+					verdict =3D 1;
+			}
+		}
+
+		if (!w1_therm_check_rom(rom))
+			break;
+	}
+
+	for (i =3D 0; i < 9; ++i)
+		count +=3D sprintf(buf + count, "%02x ", rom[i]);
+	count +=3D sprintf(buf + count, ": crc=3D%02x %s\n",
+			   crc, (verdict) ? "YES" : "NO");
+	if (verdict)
+		memcpy(sl->rom, rom, sizeof(sl->rom));
+	else
+		dev_warn(&dev->dev, "18S20 doesn't respond to CONVERT_TEMP.\n");
+
+	for (i =3D 0; i < 9; ++i)
+		count +=3D sprintf(buf + count, "%02x ", sl->rom[i]);
+
+	count +=3D sprintf(buf + count, "t=3D%d\n", w1_convert_temp(rom, sl->fami=
ly->fid));
+out:
+	up(&dev->mutex);
+out_dec:
+	smp_mb__before_atomic_inc();
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+static int __init w1_therm_init(void)
+{
+	int err, i;
+
+	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i=
) {
+		err =3D w1_register_family(w1_therm_families[i].f);
+		if (err)
+			w1_therm_families[i].broken =3D 1;
+	}
+
+	return 0;
+}
+
+static void __exit w1_therm_fini(void)
+{
+	int i;
+
+	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
+		if (!w1_therm_families[i].broken)
+			w1_unregister_family(w1_therm_families[i].f);
+}
+
+module_init(w1_therm_init);
+module_exit(w1_therm_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/w1_ds2433.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/w1_ds2433.c
+++ /dev/null
@@ -1,329 +0,0 @@
-/*
- *	w1_ds2433.c - w1 family 23 (DS2433) driver
- *
- * Copyright (c) 2005 Ben Gardner <bgardner at wabtec.com>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#ifdef CONFIG_W1_F23_CRC
-#include <linux/crc16.h>
-
-#define CRC16_INIT		0
-#define CRC16_VALID		0xb001
-
-#endif
-
-#include "w1.h"
-#include "w1_io.h"
-#include "w1_int.h"
-#include "w1_family.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Ben Gardner <bgardner at wabtec.com>");
-MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
-
-#define W1_EEPROM_SIZE		512
-#define W1_PAGE_COUNT		16
-#define W1_PAGE_SIZE		32
-#define W1_PAGE_BITS		5
-#define W1_PAGE_MASK		0x1F
-
-#define W1_F23_TIME		300
-
-#define W1_F23_READ_EEPROM	0xF0
-#define W1_F23_WRITE_SCRATCH	0x0F
-#define W1_F23_READ_SCRATCH	0xAA
-#define W1_F23_COPY_SCRATCH	0x55
-
-struct w1_f23_data {
-	u8	memory[W1_EEPROM_SIZE];
-	u32	validcrc;
-};
-
-/**
- * Check the file size bounds and adjusts count as needed.
- * This would not be needed if the file size didn't reset to 0 after a wri=
te.
- */
-static inline size_t w1_f23_fix_count(loff_t off, size_t count, size_t siz=
e)
-{
-	if (off > size)
-		return 0;
-
-	if ((off + count) > size)
-		return (size - off);
-
-	return count;
-}
-
-#ifdef CONFIG_W1_F23_CRC
-static int w1_f23_refresh_block(struct w1_slave *sl, struct w1_f23_data *d=
ata,
-				int block)
-{
-	u8	wrbuf[3];
-	int	off =3D block * W1_PAGE_SIZE;
-
-	if (data->validcrc & (1 << block))
-		return 0;
-
-	if (w1_reset_select_slave(sl)) {
-		data->validcrc =3D 0;
-		return -EIO;
-	}
-
-	wrbuf[0] =3D W1_F23_READ_EEPROM;
-	wrbuf[1] =3D off & 0xff;
-	wrbuf[2] =3D off >> 8;
-	w1_write_block(sl->master, wrbuf, 3);
-	w1_read_block(sl->master, &data->memory[off], W1_PAGE_SIZE);
-
-	/* cache the block if the CRC is valid */
-	if (crc16(CRC16_INIT, &data->memory[off], W1_PAGE_SIZE) =3D CRC16_VALID)
-		data->validcrc |=3D (1 << block);
-
-	return 0;
-}
-#endif	/* CONFIG_W1_F23_CRC */
-
-static ssize_t w1_f23_read_bin(struct kobject *kobj, char *buf, loff_t off,
-			       size_t count)
-{
-	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
-#ifdef CONFIG_W1_F23_CRC
-	struct w1_f23_data *data =3D sl->family_data;
-	int i, min_page, max_page;
-#else
-	u8 wrbuf[3];
-#endif
-
-	if ((count =3D w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) =3D 0)
-		return 0;
-
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count =3D 0;
-		goto out_dec;
-	}
-
-#ifdef CONFIG_W1_F23_CRC
-
-	min_page =3D (off >> W1_PAGE_BITS);
-	max_page =3D (off + count - 1) >> W1_PAGE_BITS;
-	for (i =3D min_page; i <=3D max_page; i++) {
-		if (w1_f23_refresh_block(sl, data, i)) {
-			count =3D -EIO;
-			goto out_up;
-		}
-	}
-	memcpy(buf, &data->memory[off], count);
-
-#else 	/* CONFIG_W1_F23_CRC */
-
-	/* read directly from the EEPROM */
-	if (w1_reset_select_slave(sl)) {
-		count =3D -EIO;
-		goto out_up;
-	}
-
-	wrbuf[0] =3D W1_F23_READ_EEPROM;
-	wrbuf[1] =3D off & 0xff;
-	wrbuf[2] =3D off >> 8;
-	w1_write_block(sl->master, wrbuf, 3);
-	w1_read_block(sl->master, buf, count);
-
-#endif	/* CONFIG_W1_F23_CRC */
-
-out_up:
-	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
-
-	return count;
-}
-
-/**
- * Writes to the scratchpad and reads it back for verification.
- * Then copies the scratchpad to EEPROM.
- * The data must be on one page.
- * The master must be locked.
- *
- * @param sl	The slave structure
- * @param addr	Address for the write
- * @param len   length must be <=3D (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
- * @param data	The data to write
- * @return	0=3DSuccess -1=FAilure
- */
-static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *=
data)
-{
-	u8 wrbuf[4];
-	u8 rdbuf[W1_PAGE_SIZE + 3];
-	u8 es =3D (addr + len - 1) & 0x1f;
-
-	/* Write the data to the scratchpad */
-	if (w1_reset_select_slave(sl))
-		return -1;
-
-	wrbuf[0] =3D W1_F23_WRITE_SCRATCH;
-	wrbuf[1] =3D addr & 0xff;
-	wrbuf[2] =3D addr >> 8;
-
-	w1_write_block(sl->master, wrbuf, 3);
-	w1_write_block(sl->master, data, len);
-
-	/* Read the scratchpad and verify */
-	if (w1_reset_select_slave(sl))
-		return -1;
-
-	w1_write_8(sl->master, W1_F23_READ_SCRATCH);
-	w1_read_block(sl->master, rdbuf, len + 3);
-
-	/* Compare what was read against the data written */
-	if ((rdbuf[0] !=3D wrbuf[1]) || (rdbuf[1] !=3D wrbuf[2]) ||
-	    (rdbuf[2] !=3D es) || (memcmp(data, &rdbuf[3], len) !=3D 0))
-		return -1;
-
-	/* Copy the scratchpad to EEPROM */
-	if (w1_reset_select_slave(sl))
-		return -1;
-
-	wrbuf[0] =3D W1_F23_COPY_SCRATCH;
-	wrbuf[3] =3D es;
-	w1_write_block(sl->master, wrbuf, 4);
-
-	/* Sleep for 5 ms to wait for the write to complete */
-	msleep(5);
-
-	/* Reset the bus to wake up the EEPROM (this may not be needed) */
-	w1_reset_bus(sl->master);
-
-	return 0;
-}
-
-static ssize_t w1_f23_write_bin(struct kobject *kobj, char *buf, loff_t of=
f,
-				size_t count)
-{
-	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
-	int addr, len, idx;
-
-	if ((count =3D w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) =3D 0)
-		return 0;
-
-#ifdef CONFIG_W1_F23_CRC
-	/* can only write full blocks in cached mode */
-	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
-		dev_err(&sl->dev, "invalid offset/count off=3D%d cnt=3D%zd\n",
-			(int)off, count);
-		return -EINVAL;
-	}
-
-	/* make sure the block CRCs are valid */
-	for (idx =3D 0; idx < count; idx +=3D W1_PAGE_SIZE) {
-		if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) !=3D CRC16_VALID) {
-			dev_err(&sl->dev, "bad CRC at offset %d\n", (int)off);
-			return -EINVAL;
-		}
-	}
-#endif	/* CONFIG_W1_F23_CRC */
-
-	atomic_inc(&sl->refcnt);
-	if (down_interruptible(&sl->master->mutex)) {
-		count =3D 0;
-		goto out_dec;
-	}
-
-	/* Can only write data to one page at a time */
-	idx =3D 0;
-	while (idx < count) {
-		addr =3D off + idx;
-		len =3D W1_PAGE_SIZE - (addr & W1_PAGE_MASK);
-		if (len > (count - idx))
-			len =3D count - idx;
-
-		if (w1_f23_write(sl, addr, len, &buf[idx]) < 0) {
-			count =3D -EIO;
-			goto out_up;
-		}
-		idx +=3D len;
-	}
-
-out_up:
-	up(&sl->master->mutex);
-out_dec:
-	atomic_dec(&sl->refcnt);
-
-	return count;
-}
-
-static struct bin_attribute w1_f23_bin_attr =3D {
-	.attr =3D {
-		.name =3D "eeprom",
-		.mode =3D S_IRUGO | S_IWUSR,
-		.owner =3D THIS_MODULE,
-	},
-	.size =3D W1_EEPROM_SIZE,
-	.read =3D w1_f23_read_bin,
-	.write =3D w1_f23_write_bin,
-};
-
-static int w1_f23_add_slave(struct w1_slave *sl)
-{
-	int err;
-#ifdef CONFIG_W1_F23_CRC
-	struct w1_f23_data *data;
-
-	data =3D kmalloc(sizeof(struct w1_f23_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-	memset(data, 0, sizeof(struct w1_f23_data));
-	sl->family_data =3D data;
-
-#endif	/* CONFIG_W1_F23_CRC */
-
-	err =3D sysfs_create_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
-
-#ifdef CONFIG_W1_F23_CRC
-	if (err)
-		kfree(data);
-#endif	/* CONFIG_W1_F23_CRC */
-
-	return err;
-}
-
-static void w1_f23_remove_slave(struct w1_slave *sl)
-{
-#ifdef CONFIG_W1_F23_CRC
-	kfree(sl->family_data);
-	sl->family_data =3D NULL;
-#endif	/* CONFIG_W1_F23_CRC */
-	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
-}
-
-static struct w1_family_ops w1_f23_fops =3D {
-	.add_slave      =3D w1_f23_add_slave,
-	.remove_slave   =3D w1_f23_remove_slave,
-};
-
-static struct w1_family w1_family_23 =3D {
-	.fid =3D W1_EEPROM_DS2433,
-	.fops =3D &w1_f23_fops,
-};
-
-static int __init w1_f23_init(void)
-{
-	return w1_register_family(&w1_family_23);
-}
-
-static void __exit w1_f23_fini(void)
-{
-	w1_unregister_family(&w1_family_23);
-}
-
-module_init(w1_f23_init);
-module_exit(w1_f23_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/w1_smem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/w1_smem.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- *	w1_smem.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the smems of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <asm/types.h>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/types.h>
-
-#include "w1.h"
-#include "w1_io.h"
-#include "w1_int.h"
-#include "w1_family.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memor=
y family.");
-
-static struct w1_family w1_smem_family_01 =3D {
-	.fid =3D W1_FAMILY_SMEM_01,
-};
-
-static struct w1_family w1_smem_family_81 =3D {
-	.fid =3D W1_FAMILY_SMEM_81,
-};
-
-static int __init w1_smem_init(void)
-{
-	int err;
-
-	err =3D w1_register_family(&w1_smem_family_01);
-	if (err)
-		return err;
-=09
-	err =3D w1_register_family(&w1_smem_family_81);
-	if (err) {
-		w1_unregister_family(&w1_smem_family_01);
-		return err;
-	}
-
-	return 0;
-}
-
-static void __exit w1_smem_fini(void)
-{
-	w1_unregister_family(&w1_smem_family_01);
-	w1_unregister_family(&w1_smem_family_81);
-}
-
-module_init(w1_smem_init);
-module_exit(w1_smem_fini);
Index: linux-2.6.15-rc3-mm1/drivers/w1/w1_therm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/w1_therm.c
+++ /dev/null
@@ -1,268 +0,0 @@
-/*
- *	w1_therm.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol at 2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the therms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <asm/types.h>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-
-#include "w1.h"
-#include "w1_io.h"
-#include "w1_int.h"
-#include "w1_family.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol at 2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature=
 family.");
-
-static u8 bad_roms[][9] =3D {
-				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87},
-				{}
-			};
-
-static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
-
-static struct bin_attribute w1_therm_bin_attr =3D {
-	.attr =3D {
-		.name =3D "w1_slave",
-		.mode =3D S_IRUGO,
-		.owner =3D THIS_MODULE,
-	},
-	.size =3D W1_SLAVE_DATA_SIZE,
-	.read =3D w1_therm_read_bin,
-};
-
-static int w1_therm_add_slave(struct w1_slave *sl)
-{
-	return sysfs_create_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
-}
-
-static void w1_therm_remove_slave(struct w1_slave *sl)
-{
-	sysfs_remove_bin_file(&sl->dev.kobj, &w1_therm_bin_attr);
-}
-
-static struct w1_family_ops w1_therm_fops =3D {
-	.add_slave	=3D w1_therm_add_slave,
-	.remove_slave	=3D w1_therm_remove_slave,
-};
-
-static struct w1_family w1_therm_family_DS18S20 =3D {
-	.fid =3D W1_THERM_DS18S20,
-	.fops =3D &w1_therm_fops,
-};
-
-static struct w1_family w1_therm_family_DS18B20 =3D {
-	.fid =3D W1_THERM_DS18B20,
-	.fops =3D &w1_therm_fops,
-};
-
-static struct w1_family w1_therm_family_DS1822 =3D {
-	.fid =3D W1_THERM_DS1822,
-	.fops =3D &w1_therm_fops,
-};
-
-struct w1_therm_family_converter
-{
-	u8			broken;
-	u16			reserved;
-	struct w1_family	*f;
-	int			(*convert)(u8 rom[9]);
-};
-
-static inline int w1_DS18B20_convert_temp(u8 rom[9]);
-static inline int w1_DS18S20_convert_temp(u8 rom[9]);
-
-static struct w1_therm_family_converter w1_therm_families[] =3D {
-	{
-		.f		=3D &w1_therm_family_DS18S20,
-		.convert 	=3D w1_DS18S20_convert_temp
-	},
-	{
-		.f		=3D &w1_therm_family_DS1822,
-		.convert 	=3D w1_DS18B20_convert_temp
-	},
-	{
-		.f		=3D &w1_therm_family_DS18B20,
-		.convert 	=3D w1_DS18B20_convert_temp
-	},
-};
-
-static inline int w1_DS18B20_convert_temp(u8 rom[9])
-{
-	int t =3D (rom[1] << 8) | rom[0];
-	t /=3D 16;
-	return t;
-}
-
-static inline int w1_DS18S20_convert_temp(u8 rom[9])
-{
-	int t, h;
-
-	if (!rom[7])
-		return 0;
-=09
-	if (rom[1] =3D 0)
-		t =3D ((s32)rom[0] >> 1)*1000;
-	else
-		t =3D 1000*(-1*(s32)(0x100-rom[0]) >> 1);
-=09
-	t -=3D 250;
-	h =3D 1000*((s32)rom[7] - (s32)rom[6]);
-	h /=3D (s32)rom[7];
-	t +=3D h;
-
-	return t;
-}
-
-static inline int w1_convert_temp(u8 rom[9], u8 fid)
-{
-	int i;
-
-	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
-		if (w1_therm_families[i].f->fid =3D fid)
-			return w1_therm_families[i].convert(rom);
-
-	return 0;
-}
-
-static int w1_therm_check_rom(u8 rom[9])
-{
-	int i;
-
-	for (i=3D0; i<sizeof(bad_roms)/9; ++i)
-		if (!memcmp(bad_roms[i], rom, 9))
-			return 1;
-
-	return 0;
-}
-
-static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t o=
ff, size_t count)
-{
-	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
-	struct w1_master *dev =3D sl->master;
-	u8 rom[9], crc, verdict;
-	int i, max_trying =3D 10;
-
-	atomic_inc(&sl->refcnt);
-	smp_mb__after_atomic_inc();
-	if (down_interruptible(&sl->master->mutex)) {
-		count =3D 0;
-		goto out_dec;
-	}
-
-	if (off > W1_SLAVE_DATA_SIZE) {
-		count =3D 0;
-		goto out;
-	}
-	if (off + count > W1_SLAVE_DATA_SIZE) {
-		count =3D 0;
-		goto out;
-	}
-
-	memset(buf, 0, count);
-	memset(rom, 0, sizeof(rom));
-
-	count =3D 0;
-	verdict =3D 0;
-	crc =3D 0;
-
-	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
-			int count =3D 0;
-			unsigned int tm =3D 750;
-
-			w1_write_8(dev, W1_CONVERT_TEMP);
-
-			while (tm) {
-				tm =3D msleep_interruptible(tm);
-				if (signal_pending(current))
-					flush_signals(current);
-			}
-
-			if (!w1_reset_select_slave(sl)) {
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				if ((count =3D w1_read_block(dev, rom, 9)) !=3D 9) {
-					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", co=
unt);
-				}
-
-				crc =3D w1_calc_crc8(rom, 8);
-
-				if (rom[8] =3D crc && rom[0])
-					verdict =3D 1;
-			}
-		}
-
-		if (!w1_therm_check_rom(rom))
-			break;
-	}
-
-	for (i =3D 0; i < 9; ++i)
-		count +=3D sprintf(buf + count, "%02x ", rom[i]);
-	count +=3D sprintf(buf + count, ": crc=3D%02x %s\n",
-			   crc, (verdict) ? "YES" : "NO");
-	if (verdict)
-		memcpy(sl->rom, rom, sizeof(sl->rom));
-	else
-		dev_warn(&dev->dev, "18S20 doesn't respond to CONVERT_TEMP.\n");
-
-	for (i =3D 0; i < 9; ++i)
-		count +=3D sprintf(buf + count, "%02x ", sl->rom[i]);
-=09
-	count +=3D sprintf(buf + count, "t=3D%d\n", w1_convert_temp(rom, sl->fami=
ly->fid));
-out:
-	up(&dev->mutex);
-out_dec:
-	smp_mb__before_atomic_inc();
-	atomic_dec(&sl->refcnt);
-
-	return count;
-}
-
-static int __init w1_therm_init(void)
-{
-	int err, i;
-
-	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i=
) {
-		err =3D w1_register_family(w1_therm_families[i].f);
-		if (err)
-			w1_therm_families[i].broken =3D 1;
-	}
-
-	return 0;
-}
-
-static void __exit w1_therm_fini(void)
-{
-	int i;
-
-	for (i=3D0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
-		if (!w1_therm_families[i].broken)
-			w1_unregister_family(w1_therm_families[i].f);
-}
-
-module_init(w1_therm_init);
-module_exit(w1_therm_fini);
