From: "David O'Shea" <dcoshea@hotmail.com>
Date: Sun, 01 Mar 2009 22:37:25 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <SNT103-W80880E46B4E0612EA53640B8A80@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Jean,

> From: khali@linux-fr.org
[...]
> Your patch looks OK and it applies fine to 2.6.29-rc6. All it is
> missing is a proper subject, header comment, and your Signed-off-by
> as per Documentation/SubmittingPatches' "Sign your work" section.

Thanks for the pointer, is the below okay?  I hope hotmail doesn't reformat=
 this :)

Regards,
David

Subject: [PATCH] pci: Compaq Evo D510 SMBus quirk using USB instead of VGA

From: David O'Shea=20

On the Compaq Evo D510 SFF/CMT, a PCI quirk activated the SMBus device
based on detection of the on-board VGA controller, but the on-board
VGA is disabled if an AGP card is inserted, so look for one of the USB
controllers instead.

Signed-off-by: David O'Shea=20
---
 Patch against 2.6.27 re-generated with '-p' and '-X' flags:

diff -upr -X linux-2.6.27.i686.orig/Documentation/dontdiff linux-2.6.27.i68=
6.orig/drivers/pci/quirks.c linux-2.6.27.i686.compaq_evo_d51s_sensors/drive=
rs/pci/quirks.c
--- linux-2.6.27.i686.orig/drivers/pci/quirks.c    2009-01-18 13:31:39.0000=
00000 +1030
+++ linux-2.6.27.i686.compaq_evo_d51s_sensors/drivers/pci/quirks.c    2009-=
03-01 20:03:19.000000000 +1030
@@ -1067,10 +1067,15 @@ static void __init asus_hides_smbus_host
                  * its on-board VGA controller */
                 asus_hides_smbus =3D 1;
             }
-        else if (dev->device =3D PCI_DEVICE_ID_INTEL_82845G_IG)
+        else if (dev->device =3D PCI_DEVICE_ID_INTEL_82801DB_2)
             switch(dev->subsystem_device) {
             case 0x00b8: /* Compaq Evo D510 CMT */
             case 0x00b9: /* Compaq Evo D510 SFF */
+                /* Motherboard doesn't have Host bridge
+                 * subvendor/subdevice IDs and on-board VGA
+                 * controller is disabled if an AGP card is
+                 * inserted, therefore checking USB UHCI
+                 * Controller #1 */
                 asus_hides_smbus =3D 1;
             }
         else if (dev->device =3D PCI_DEVICE_ID_INTEL_82815_CGC)
@@ -1095,7 +1100,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82915=
GM_HB, asus_hides_smbus_hostbridge);
=20
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82810=
_IG3,    asus_hides_smbus_hostbridge);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82845=
G_IG,    asus_hides_smbus_hostbridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82801=
DB_2,    asus_hides_smbus_hostbridge);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82815=
_CGC,    asus_hides_smbus_hostbridge);
=20
 static void asus_hides_smbus_lpc(struct pci_dev *dev)
diff -upr -X linux-2.6.27.i686.orig/Documentation/dontdiff linux-2.6.27.i68=
6.orig/include/linux/pci_ids.h linux-2.6.27.i686.compaq_evo_d51s_sensors/in=
clude/linux/pci_ids.h
--- linux-2.6.27.i686.orig/include/linux/pci_ids.h    2009-01-18 13:32:39.0=
00000000 +1030
+++ linux-2.6.27.i686.compaq_evo_d51s_sensors/include/linux/pci_ids.h    20=
09-03-01 19:43:42.000000000 +1030
@@ -2322,6 +2322,7 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_12    0x248c
 #define PCI_DEVICE_ID_INTEL_82801DB_0    0x24c0
 #define PCI_DEVICE_ID_INTEL_82801DB_1    0x24c1
+#define PCI_DEVICE_ID_INTEL_82801DB_2    0x24c2
 #define PCI_DEVICE_ID_INTEL_82801DB_3    0x24c3
 #define PCI_DEVICE_ID_INTEL_82801DB_5    0x24c5
 #define PCI_DEVICE_ID_INTEL_82801DB_6    0x24c6


_________________________________________________________________
Find out what=92s new with your friends Download the new Windows Live Messe=
nger
http://download.live.com/
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
