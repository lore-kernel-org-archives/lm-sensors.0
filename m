From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <10898500351442@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10898500353542@kroah.com>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1784.1.96, 2004/07/14 16:04:27-07:00, orange@fobie.net

[PATCH] I2C: patch quirks.c - SMBus hidden on hp laptop

This patch unhides the SMBus on the hp nc8000 and nc6000 laptops. The
patch has been co-written by Jean Delvare and Rudolf Marek. I've only
tested this on nc8000, but it should work for the nc6000 too.

Unfortunatley, we had to little information to fix the problem described
in the reported bug below, as is probably the same problem. But if we're
very lucky it might solve it too.
http://bugzilla.kernel.org/show_bug.cgi?id)76


Signed-off-by: ?rjan Persson <orange@fobie.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |   58 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 23 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-07-14 16:58:40 -07:00
+++ b/drivers/pci/quirks.c	2004-07-14 16:58:40 -07:00
@@ -694,29 +694,38 @@
 
 static void __init asus_hides_smbus_hostbridge(struct pci_dev *dev)
 {
-	if (likely(dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK))
-		return;
-
-	if (dev->device = PCI_DEVICE_ID_INTEL_82845_HB)
-		switch(dev->subsystem_device) {
-		case 0x8070: /* P4B */
-	    	case 0x8088: /* P4B533 */
-			asus_hides_smbus = 1;
-		}
-	if (dev->device = PCI_DEVICE_ID_INTEL_82845G_HB)
-		switch(dev->subsystem_device) {
- 		case 0x80b1: /* P4GE-V */
-		case 0x80b2: /* P4PE */
- 		case 0x8093: /* P4B533-V */
-			asus_hides_smbus = 1;
-		}
-	if ((dev->device = PCI_DEVICE_ID_INTEL_82850_HB) &&
-	    (dev->subsystem_device = 0x8030)) /* P4T533 */
-		asus_hides_smbus = 1;
-	if ((dev->device = PCI_DEVICE_ID_INTEL_7205_0) &&
-	    (dev->subsystem_device = 0x8070)) /* P4G8X Deluxe */
-		asus_hides_smbus = 1;
-	return;
+	if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_ASUSTEK)) {
+		if (dev->device = PCI_DEVICE_ID_INTEL_82845_HB)
+			switch(dev->subsystem_device) {
+			case 0x8070: /* P4B */
+			case 0x8088: /* P4B533 */
+				asus_hides_smbus = 1;
+			}
+		if (dev->device = PCI_DEVICE_ID_INTEL_82845G_HB)
+			switch(dev->subsystem_device) {
+			case 0x80b1: /* P4GE-V */
+			case 0x80b2: /* P4PE */
+			case 0x8093: /* P4B533-V */
+				asus_hides_smbus = 1;
+			}
+		if (dev->device = PCI_DEVICE_ID_INTEL_82850_HB)
+			switch(dev->subsystem_device) {
+			case 0x8030: /* P4T533 */
+				asus_hides_smbus = 1;
+			}
+		if (dev->device = PCI_DEVICE_ID_INTEL_7205_0)
+			switch (dev->subsystem_device) {
+			case 0x8070: /* P4G8X Deluxe */
+				asus_hides_smbus = 1;
+			}
+	} else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_HP)) {
+		if (dev->device =  PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch(dev->subsystem_device) {
+			case 0x088C: /* HP Compaq nc8000 */
+			case 0x0890: /* HP Compaq nc6000 */
+				asus_hides_smbus = 1;
+			}
+	}
 }
 
 static void __init asus_hides_smbus_lpc(struct pci_dev *dev)
@@ -987,13 +996,16 @@
 
 	/*
 	 * on Asus P4B boards, the i801SMBus device is disabled at startup.
+	 * this also goes for boards in HP Compaq nc6000 and nc8000 notebooks.
 	 */
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82845G_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82850_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_7205_0,	asus_hides_smbus_hostbridge },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82855PM_HB,	asus_hides_smbus_hostbridge },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	asus_hides_smbus_lpc },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc },
 
 #ifdef CONFIG_SCSI_SATA
 	/* Fixup BIOSes that configure Parallel ATA (PATA / IDE) and

