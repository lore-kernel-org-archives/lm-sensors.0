From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Resolve resource conflict between i2c-viapro and
Message-Id: <20050115122555.087f9a7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes the finalized version of our patch solving the PCI device
resource conflict between the i2c-viapro bus driver and and the via686a
chip driver. It is based on your original work and the IRC conversation
we had yesterday.

The retained solution is to not permanently register the PCI device in
either driver. This is legitimate since we only need it at init time to
retrieve the ISA address of a sub-device (SMBus master or integrated
sensors), and possibly change that address on user request. Once this is
done we can safely release the PCI device for others to use.

I am really glad to see this problem finally solved, as this was the
last remaining annoying issue left from the Linux 2.6 migration (missing
drivers left apart), and was generating many complaints both at our
level and at the distributions' support.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

--- linux-2.6.11-rc1/drivers/i2c/busses/i2c-viapro.c.orig	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/busses/i2c-viapro.c	2005-01-15 12:03:54.000000000 +0100
@@ -45,6 +45,8 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
+static struct pci_dev *vt596_pdev;
+
 #define SMBBA1	   	 0x90
 #define SMBBA2     	 0x80
 #define SMBBA3     	 0xD0
@@ -381,19 +383,23 @@
 	snprintf(vt596_adapter.name, I2C_NAME_SIZE,
 			"SMBus Via Pro adapter at %04x", vt596_smba);
 	
-	return i2c_add_adapter(&vt596_adapter);
+	vt596_pdev = pci_dev_get(pdev);
+	if (i2c_add_adapter(&vt596_adapter)) {
+		pci_dev_put(vt596_pdev);
+		vt596_pdev = NULL;
+	}
+
+	/* Always return failure here.  This is to allow other drivers to bind
+	 * to this pci device.  We don't really want to have control over the
+	 * pci device, we only wanted to read as few register values from it.
+	 */
+	return -ENODEV;
 
  release_region:
 	release_region(vt596_smba, 8);
 	return error;
 }
 
-static void __devexit vt596_remove(struct pci_dev *pdev)
-{
-	i2c_del_adapter(&vt596_adapter);
-	release_region(vt596_smba, 8);
-}
-
 static struct pci_device_id vt596_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596_3),
 	  .driver_data = SMBBA1 },
@@ -420,7 +426,6 @@
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
-	.remove		= __devexit_p(vt596_remove),
 };
 
 static int __init i2c_vt596_init(void)
@@ -432,6 +437,12 @@
 static void __exit i2c_vt596_exit(void)
 {
 	pci_unregister_driver(&vt596_driver);
+	if (vt596_pdev != NULL) {
+		i2c_del_adapter(&vt596_adapter);
+		release_region(vt596_smba, 8);
+		pci_dev_put(vt596_pdev);
+		vt596_pdev = NULL;
+	}
 }
 
 MODULE_AUTHOR(
--- linux-2.6.11-rc1/drivers/i2c/chips/via686a.c.orig	2005-01-14 18:37:07.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/via686a.c	2005-01-15 10:42:32.000000000 +0100
@@ -815,20 +815,24 @@
                return -ENODEV;
        }
        normal_isa[0] = addr;
-       s_bridge = dev;
-       return i2c_add_driver(&via686a_driver);
-}
 
-static void __devexit via686a_pci_remove(struct pci_dev *dev)
-{
-       i2c_del_driver(&via686a_driver);
+	s_bridge = pci_dev_get(dev);
+	if (i2c_add_driver(&via686a_driver)) {
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
+
+	/* Always return failure here.  This is to allow other drivers to bind
+	 * to this pci device.  We don't really want to have control over the
+	 * pci device, we only wanted to read as few register values from it.
+	 */
+	return -ENODEV;
 }
 
 static struct pci_driver via686a_pci_driver = {
        .name		= "via686a",
        .id_table	= via686a_pci_ids,
        .probe		= via686a_pci_probe,
-       .remove		= __devexit_p(via686a_pci_remove),
 };
 
 static int __init sm_via686a_init(void)
@@ -838,7 +842,12 @@
 
 static void __exit sm_via686a_exit(void)
 {
-       pci_unregister_driver(&via686a_pci_driver);
+	pci_unregister_driver(&via686a_pci_driver);
+	if (s_bridge != NULL) {
+		i2c_del_driver(&via686a_driver);
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
 }
 
 MODULE_AUTHOR("Ky?sti M?lkki <kmalkki@cc.hut.fi>, "



-- 
Jean Delvare
http://khali.linux-fr.org/
