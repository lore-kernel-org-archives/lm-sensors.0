From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 31 May 2009 18:20:11 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: PCI quirk for hwmon access on MSI
Message-Id: <20090531202011.61d66389@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The MSI MS-7031 is based on an ATI IXP300 south bridge. On this south
bridge, accessible I/O ports must be enabled explicitly. Unfortunately
the BIOS forgets to enable access to the hardware monitoring chip I/O
ports, so hardware monitoring fails.

Add a quirk enabling access to the required ports (0x295-0x296). This
is exactly what MSI's own hardware monitoring application is doing, so
it has to be the right way.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/hwmon.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- linux-2.6.30-rc7.orig/drivers/hwmon/hwmon.c	2009-03-24 13:43:33.000000000 +0100
+++ linux-2.6.30-rc7/drivers/hwmon/hwmon.c	2009-05-27 19:02:43.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/hwmon.h>
 #include <linux/gfp.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
@@ -86,8 +87,36 @@ void hwmon_device_unregister(struct devi
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
 
+static void __init hwmon_pci_quirks(void)
+{
+#if defined CONFIG_X86 && defined CONFIG_PCI
+	struct pci_dev *sb;
+	u16 base;
+	u8 enable;
+
+	/* Open access to 0x295-0x296 on MSI MS-7031 */
+	sb = pci_get_device(PCI_VENDOR_ID_ATI, 0x436c, NULL);
+	if (sb &&
+	    (sb->subsystem_vendor = 0x1462 &&	/* MSI */
+	     sb->subsystem_device = 0x0031)) {	/* MS-7031 */
+
+		pci_read_config_byte(sb, 0x48, &enable);
+		pci_read_config_word(sb, 0x64, &base);
+
+		if (base = 0 && !(enable & BIT(2))) {
+			dev_info(&sb->dev,
+				 "Opening wide generic port at 0x295\n");
+			pci_write_config_word(sb, 0x64, 0x295);
+			pci_write_config_byte(sb, 0x48, enable | BIT(2));
+		}
+	}
+#endif
+}
+
 static int __init hwmon_init(void)
 {
+	hwmon_pci_quirks();
+
 	hwmon_class = class_create(THIS_MODULE, "hwmon");
 	if (IS_ERR(hwmon_class)) {
 		printk(KERN_ERR "hwmon.c: couldn't create sysfs class\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
