From: seanlkml@rogers.com (Sean Estabrooks)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [PATCH] Asus P4B hidden smbus : additional subsystem ID
Message-Id: <1060067933.1451.36.camel@linux1.classroom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

    My P4B motherboard reports a different subsystem number
than the one given in the 2.6 kernel.  Patch attached against 
2.6.0-test2 that adds it in.  Asus website lists over 20 
variations of the P4B motherboard so there may yet be more
subsystem id's discovered.

Cheers,
Sean

-------------- next part --------------
--- mm3/drivers/pci/quirks.c.pre	Tue Aug  5 02:23:02 2003
+++ mm3/drivers/pci/quirks.c	Tue Aug  5 02:29:31 2003
@@ -681,9 +681,12 @@
 	if (likely(dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK))
 		return;
 
-	if ((dev->device = PCI_DEVICE_ID_INTEL_82845_HB) && 
-	    (dev->subsystem_device = 0x8088)) /* P4B533 */
-		asus_hides_smbus = 1;
+	if (dev->device = PCI_DEVICE_ID_INTEL_82845_HB)
+		switch(dev->subsystem_device) {
+		case 0x8070: /* P4B */
+	    	case 0x8088: /* P4B533 */
+			asus_hides_smbus = 1;
+		}
 	if ((dev->device = PCI_DEVICE_ID_INTEL_82845G_HB) &&
 	    (dev->subsystem_device = 0x80b2)) /* P4PE */
 		asus_hides_smbus = 1;
