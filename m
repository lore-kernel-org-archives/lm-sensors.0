From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: Fw: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503062210340.25688@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> to try it. And if you need more information from this motherboard,
> please

Yes I have one question. They advise to write to port all 8 bits.
More clear solution would be to modify the bits that are "in the game"

So my question is:

What bit(s) exactly in that port need(s) to be modified?
We simply like clean solutions.

(we can compare with isadump from that address before we clobber
with i2cset)  My bet is bit 2.

Also here patch for 2.6 kernels it should do the isaset automatically.
It can be applied to 2.6.10 or 2.6.11

Basically if it is working you should se in
cat /proc/ioports the GPIO ranges and also you should see in log:
PCI: Canceling ASUS hide and seek played with with SMBus monitoring
chip. And of course your driver should work :)

And about the block reads. It seems the driver support them but I dont
remember if there is same problem. Just try without eeprom module. This
should prevent the bus lock if there is problem. (so similar as 2.4 case)

I hope this helps and works :)

Regards

Rudolf

diff -Naur a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2005-02-03 02:54:56.000000000 +0100
+++ b/drivers/pci/quirks.c	2005-03-06 20:40:31.565227944 +0100
@@ -296,6 +296,32 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi );

+/* Not only ASUS hides SMBUS, sometimes hides also devices on it.
+It is known that they use GPIO lines from ISA bridge or LPC IO chip
+to trigger the multiplexer on SMBUS.
+
+Information for this particular W83792D case was provided by ASUS R&D on
+request from Winbond.
+*/
+
+#define ASUS_GPIO_ENABLE_DEVICE 0x08
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
@@ -310,6 +336,11 @@

 	pci_read_config_dword(dev, 0x58, &region);
 	quirk_io_region(dev, region, 64, PCI_BRIDGE_RESOURCES+1);
+
+	if (asus_server_board_hides_smbus_devices) {
+		outb(ASUS_GPIO_ENABLE_DEVICE, (region&~GPIO_IOSIZE_MASK)+GPIO_OUTPUT2_REG_HIGH);
+		printk(KERN_INFO "PCI: Canceling ASUS hide and seek played with SMBus monitoring chip\n");
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AA_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801AB_0,		quirk_ich4_lpc_acpi );
@@ -320,6 +351,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_0,		quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801DB_12,	quirk_ich4_lpc_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801EB_0,		quirk_ich4_lpc_acpi );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );

 /*
  * VIA ACPI: One IO region pointed to by longword at
