From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 2.6] Add PCI quirk for SMBus on the Toshiba Satellite A40
Message-Id: <20050213204639.1f0b4a27.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Frans Pop <aragorn@tiscali.nl>

Hi all,

The Toshiba Satellite A40 laptop hides its SMBus device, much like a
number of Asus boards reputedly do. This prevents access to the LM90
hardware monitoring chip. This simple patch extends the PCI quirk used
for the Asus and HP systems to this Toshiba laptop.

Please consider for merge into the PCI subsystem,
thanks.

Signed-off-by: Frans Pop <aragorn@tiscali.nl>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux/drivers/pci/quirks.c.orig	2005-02-12 19:44:37.000000000 +0100
+++ linux/drivers/pci/quirks.c	2005-02-13 12:35:28.000000000 +0100
@@ -801,6 +801,12 @@
 			case 0x12bc: /* HP D330L */
 				asus_hides_smbus = 1;
 			}
+	} else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_TOSHIBA)) {
+		if (dev->device = PCI_DEVICE_ID_INTEL_82855GM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Satellite A40 */
+				asus_hides_smbus = 1;
+			}
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge );


-- 
Jean Delvare
