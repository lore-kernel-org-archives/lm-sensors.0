From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: FW: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503091142110.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



>    GPIO42 : 0 (Low)
>    GPIO43 : 1 (High)
>
>   For 6300ESB, the access method of these two pins is showed below.
> Bit10, bit 11 are for these two pins.

Yes thank you.

Here is updated patch.

Regards

Rudolf

diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-03-02 08:37:31.000000000 +0100
+++ b/drivers/pci/quirks.c	2005-03-09 10:56:36.877494936 +0100
@@ -306,6 +306,36 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );

+/* Not only ASUS hides SMBUS, sometimes hides also devices on it.
+It is known that they use GPIO lines from ISA bridge or LPC IO chip
+to trigger the multiplexer on SMBUS.
+
+Information for this particular W83792D case was provided by ASUS R&D on
+request from Winbond.
+
+If we want to access W83792D, we should program these to GPO pins to
+   GPIO42 : 0 (Low)
+   GPIO43 : 1 (High)
+(This should work for 6300ESB based motherboards)
+*/
+
+#define GPIO_OUTPUT2_REG_HIGH 0x39
+#define GPIO_IOSIZE_MASK 0x3F
+
+static int __initdata asus_server_board_hides_smbus_devices = 0;
+
+static void __init asus_hides_smbus_devices(struct pci_dev *dev) {
+	if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
+			switch(dev->subsystem_device) {
+			case 0x8117: /* ASUS server board (NCLV-D) */
+				asus_server_board_hides_smbus_devices = 1;
+				break;
+			}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_4,	asus_hides_smbus_devices );
+
+
 /*
  * ICH4, ICH4-M, ICH5, ICH5-M ACPI: Three IO regions pointed to by longwords at
  *	0x40 (128 bytes of ACPI, GPIO & TCO registers)
@@ -320,6 +350,15 @@

 	pci_read_config_dword(dev, 0x58, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+
+	if (asus_server_board_hides_smbus_devices) {
+		unsigned char val;
+		val=inb((region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
+		val&=~0x4; /* GPIO42 : 0 (Low) */
+		val|=0x8;  /* GPIO43 : 1 (High) */
+		outb(val, (region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
+		printk(KERN_INFO "PCI: Canceling ASUS hide and seek played with SMBus monitoring chip\n");
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
@@ -330,6 +369,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );

 /*
  * VIA ACPI: One IO region pointed to by longword at
