From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 May 2009 20:06:52 +0000
Subject: [lm-sensors] PCI: Quirk for hwmon access on MSI MS-7031 board
Message-Id: <20090525220652.04c2468f@hyperion.delvare>
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
 drivers/pci/quirks.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- linux-2.6.30-rc6.orig/drivers/pci/quirks.c	2009-04-30 08:45:23.000000000 +0200
+++ linux-2.6.30-rc6/drivers/pci/quirks.c	2009-05-20 21:28:56.000000000 +0200
@@ -2464,6 +2464,30 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 
 #endif	/* CONFIG_PCI_IOV */
 
+#if defined CONFIG_X86 && (defined CONFIG_HWMON || defined CONFIG_HWMON_MODULE)
+/* Open access to 0x295-0x296 (hardware monitoring chip) on MSI MS-7031 */
+static void __devinit ati_ixp300_open_ioport(struct pci_dev *dev)
+{
+	u16 base;
+	u8 enable;
+
+	if (!(dev->subsystem_vendor = 0x1462 &&	/* MSI */
+	      dev->subsystem_device = 0x0031))		/* MS-7031 */
+		return;
+
+	pci_read_config_byte(dev, 0x48, &enable);
+	pci_read_config_word(dev, 0x64, &base);
+
+	if (base = 0 && !(enable & BIT(2))) {
+		dev_info(&dev->dev, "Opening wide generic port at 0x295\n");
+		pci_write_config_word(dev, 0x64, 0x295);
+		pci_write_config_byte(dev, 0x48, enable | BIT(2));
+	}
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, 0x436c, ati_ixp300_open_ioport);
+#endif	/* CONFIG_X86 && CONFIG_HWMON */
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 			  struct pci_fixup *end)
 {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
