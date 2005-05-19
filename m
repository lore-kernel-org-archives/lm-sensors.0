From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: [PATCH] More i2c driver changes 2.6.0-test2
Message-Id: <10603869402949@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10603869391598@kroah.com>
References: <10603869373490@kroah.com>
In-Reply-To: <10603869373490@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1127, 2003/08/08 16:36:42-07:00, seanlkml@rogers.com

[PATCH] I2C: Additional P4B subsystem id for hidden asus smbus

  This patch adds another P4B motherboard subsystem identifier to the recent
asus sensor patch for the 2.6 kernel.


 drivers/pci/quirks.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Fri Aug  8 16:47:06 2003
+++ b/drivers/pci/quirks.c	Fri Aug  8 16:47:06 2003
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

