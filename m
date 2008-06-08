From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 08 Jun 2008 11:47:02 +0000
Subject: [lm-sensors] [PATCH] Unhide the SMBus on the Compaq Deskpro EN
Message-Id: <20080608134702.401b9fb5.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org, rh1985@wp.pl

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch unhides the SMBus on Compaq Deskpro EN
SFF P667 with the Intel 815E chipset. Unhiding it reveals=20
a THMC51 hardware monitoring chip.

Jean Delvare has checked that this machine has no ACPI
magic touching the SMBus nor the hardware monitoring chip,
so this should be safe.

The patch was tested on Fedora Core 9 with 2.6.25.4 kernel.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Tested-by: Rafa=B3 Ha=B3aduda <rh1985@wp.pl>
CC: Jean Delvare <khali@linux-fr.org>

---
If someone owns the Compaq Deskpro EN machine, please
test the patch as well.

diff -urp linux-2.6.25/drivers/pci/quirks.c linux-new/drivers/pci/quirks.c
--- linux-2.6.25/drivers/pci/quirks.c	2008-05-27 21:58:34.380144607 +0200
+++ linux-new/drivers/pci/quirks.c	2008-05-30 23:12:57.510219450 +0200
@@ -1054,6 +1054,14 @@ static void __init asus_hides_smbus_host
 				 * its on-board VGA controller */
 				asus_hides_smbus =3D 1;
 			}
+		else if (dev->device =3D PCI_DEVICE_ID_INTEL_82815_CGC)
+			switch (dev->subsystem_device) {
+			case 0x001A: /* Compaq Deskpro EN SSF P667 815E */
+				/* Motherboard doesn't have host bridge
+				 * subvendor/subdevice IDs, therefore checking
+				 * its on-board VGA controller */
+				asus_hides_smbus =3D 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB=
,	asus_hides_smbus_hostbridge);
@@ -1068,6 +1076,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82915GM_=
HB, asus_hides_smbus_hostbridge);
=20
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82810_IG=
3,	asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82815_CG=
C,	asus_hides_smbus_hostbridge);
=20
 static void asus_hides_smbus_lpc(struct pci_dev *dev)
 {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
