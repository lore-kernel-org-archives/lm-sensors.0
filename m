From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 10 Jan 2006 06:00:02 +0000
Subject: [lm-sensors] patch add-i2c_bus_type-probe-and-remove-methods.patch
Message-Id: <1EwCY6-1lA-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [CFT 16/29] Add i2c_bus_type probe and remove methods

to my gregkh-2.6 tree.  Its filename is

     add-i2c_bus_type-probe-and-remove-methods.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From rmk+greg=kroah.com at arm.linux.org.uk Thu Jan  5 06:42:43 2006
From: Russell King <rmk at arm.linux.org.uk>
CC: Greg K-H <greg at kroah.com>, I2C <lm-sensors at lm-sensors.org>
Subject: [CFT 16/29] Add i2c_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:37:50 +0000
Message-ID: <20060105142951.13.16 at flint.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel at arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/i2c/i2c-core.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/i2c-core.c
+++ gregkh-2.6/drivers/i2c/i2c-core.c
@@ -63,13 +63,6 @@ static int i2c_bus_resume(struct device 
 	return rc;
 }
 
-struct bus_type i2c_bus_type = {
-	.name =		"i2c",
-	.match =	i2c_device_match,
-	.suspend =      i2c_bus_suspend,
-	.resume =       i2c_bus_resume,
-};
-
 static int i2c_device_probe(struct device *dev)
 {
 	return -ENODEV;
@@ -80,6 +73,15 @@ static int i2c_device_remove(struct devi
 	return 0;
 }
 
+struct bus_type i2c_bus_type = {
+	.name =		"i2c",
+	.match =	i2c_device_match,
+	.probe =	i2c_device_probe,
+	.remove =	i2c_device_remove,
+	.suspend =      i2c_bus_suspend,
+	.resume =       i2c_bus_resume,
+};
+
 void i2c_adapter_dev_release(struct device *dev)
 {
 	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
@@ -90,8 +92,6 @@ struct device_driver i2c_adapter_driver 
 	.owner = THIS_MODULE,
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
-	.probe = i2c_device_probe,
-	.remove = i2c_device_remove,
 };
 
 static void i2c_adapter_class_dev_release(struct class_device *dev)
@@ -294,8 +294,6 @@ int i2c_register_driver(struct module *o
 	/* add the driver to the list of i2c drivers in the driver core */
 	driver->driver.owner = owner;
 	driver->driver.bus = &i2c_bus_type;
-	driver->driver.probe = i2c_device_probe;
-	driver->driver.remove = i2c_device_remove;
 
 	res = driver_register(&driver->driver);
 	if (res)


Patches currently in gregkh-2.6 which might be from rmk at arm.linux.org.uk are

driver/add-bttv-sub-bus_type-probe-and-remove-methods.patch
driver/add-bus_type-probe-remove-shutdown-methods..patch
driver/add-ccwgroup_bus_type-probe-and-remove-methods.patch
driver/add-dio_bus_type-probe-and-remove-methods.patch
driver/add-ecard_bus_type-probe-remove-shutdown-methods.patch
driver/add-gameport-bus_type-probe-and-remove-methods.patch
driver/add-i2c_bus_type-probe-and-remove-methods.patch
driver/add-ide_bus_type-probe-and-remove-methods.patch
driver/add-locomo-bus_type-probe-remove-methods.patch
driver/add-logic-module-bus_type-probe-remove-methods.patch
driver/add-macio_bus_type-probe-and-remove-methods.patch
driver/add-mcp-bus_type-probe-and-remove-methods.patch
driver/add-mmc_bus_type-probe-and-remove-methods.patch
driver/add-ocp_bus_type-probe-and-remove-methods.patch
driver/add-of_platform_bus_type-probe-and-remove-methods.patch
driver/add-parisc_bus_type-probe-and-remove-methods.patch
driver/add-pci_bus_type-probe-and-remove-methods.patch
driver/add-pcmcia_bus_type-probe-and-remove-methods.patch
driver/add-pnp_bus_type-probe-and-remove-methods.patch
driver/add-pseudo-lld-bus_type-probe-and-remove-methods.patch
driver/add-rio_bus_type-probe-and-remove-methods.patch
driver/add-sa1111-bus_type-probe-remove-methods.patch
driver/add-serio-bus_type-probe-and-remove-methods.patch
driver/add-sh_bus_type-probe-and-remove-methods.patch
driver/add-superhyway_bus_type-probe-and-remove-methods.patch
driver/add-tiocx-bus_type-probe-remove-methods.patch
driver/add-usb_serial_bus_type-probe-and-remove-methods.patch
driver/add-vio_bus_type-probe-and-remove-methods.patch
driver/add-zorro_bus_type-probe-and-remove-methods.patch
driver/remove-usb-gadget-generic-driver-methods.patch

