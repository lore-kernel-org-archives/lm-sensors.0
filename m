From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: SiS735 chipset SMBus driver for kernel 2.6
Message-Id: <20040219020339.GE21829@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paolo:

(cc'ed to sensors mailing list...)

* Paolo Cesare BERVA <paolo.berva@st.com> [2004-02-18 08:22:27 +0100]:
> Hi Mark, here the tests I did with kernel 2.6.2:

<snip>

> # setpci -s 00:02.0 0x40
> 98
> # setpci -s 00:02.0 0x40=0xd8
> 
> # lspci -H1 -n | grep "00:02.0"
> 00:02.0 Class 0601: 1039:0018
> # setpci -s 00:02.0 0x40=0x98
> 
> # lspci -H1 -n | grep "00:02.0"
> 00:02.0 Class 0601: 1039:0008

Excellent, that's just as I expected.

> Mark M. Hoffman wrote:

<snip>

> >You are missing device 1039:0016 here.  I think I understand
> >why, but I want to make sure.  I asked another user to take
> >some further steps, but he never responded.  
> >
> >You can find the steps here:
> >
> >http://archives.andrew.net.au/lm-sensors/msg06132.html
> >
> >Everything starting from "With kernel 2.6, the driver" applies
> >to you.  If you could please follow those steps and send the
> >results, then next I will send a patch to test.

So here's the patch vs. 2.6.3.  When you build it, select
eeprom as a module (and of course i2c-sis96x).  Please try
it, and send me the results of a few commands...

lspci -n (again)
modprobe i2c-sis96x
modprobe eeprom
sensors

If none of that seems to work, then please send the results
of 'dmesg'.

Thanks again,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
diff -Nru linux-2.6.3-orig/drivers/pci/quirks.c linux-2.6.3-mmh/drivers/pci/quirks.c
--- linux-2.6.3-orig/drivers/pci/quirks.c	2004-02-10 12:55:18.000000000 -0500
+++ linux-2.6.3-mmh/drivers/pci/quirks.c	2004-02-18 20:37:32.000000000 -0500
@@ -757,7 +757,7 @@
 
 #define SIS_DETECT_REGISTER 0x40
 
-static void __init quirk_sis_503_smbus(struct pci_dev *dev)
+static void __init quirk_sis_503(struct pci_dev *dev)
 {
 	u8 reg;
 	u16 devid;
@@ -765,7 +765,7 @@
 	pci_read_config_byte(dev, SIS_DETECT_REGISTER, &reg);
 	pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg | (1 << 6));
 	pci_read_config_word(dev, PCI_DEVICE_ID, &devid);
-	if ((devid & 0xfff0) != 0x0960) {
+	if (((devid & 0xfff0) != 0x0960) && (devid != 0x0018)) {
 		pci_write_config_byte(dev, SIS_DETECT_REGISTER, reg);
 		return;
 	}
@@ -877,12 +877,14 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
-	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503_smbus },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus },
diff -Nru linux-2.6.3-orig/include/linux/pci_ids.h linux-2.6.3-mmh/include/linux/pci_ids.h
--- linux-2.6.3-orig/include/linux/pci_ids.h	2004-02-18 20:20:21.000000000 -0500
+++ linux-2.6.3-mmh/include/linux/pci_ids.h	2004-02-18 20:29:25.000000000 -0500
@@ -569,6 +569,7 @@
 #define PCI_DEVICE_ID_SI_6202		0x0002
 #define PCI_DEVICE_ID_SI_503		0x0008
 #define PCI_DEVICE_ID_SI_ACPI		0x0009
+#define PCI_DEVICE_ID_SI_LPC		0x0018
 #define PCI_DEVICE_ID_SI_5597_VGA	0x0200
 #define PCI_DEVICE_ID_SI_6205		0x0205
 #define PCI_DEVICE_ID_SI_501		0x0406
