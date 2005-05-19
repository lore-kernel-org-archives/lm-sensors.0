From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] PCI: Quirk for Asus M5N
Message-Id: <20050323201043.30437b30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

One more Asus laptop which requires a PCI quirk to unhide the SMBus.
Contributed by Matthias Hensler through bugzilla (#4391).

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10/drivers/pci/quirks.c.orig	2005-03-23 10:55:50.196069852 +0100
+++ linux-2.6.10/drivers/pci/quirks.c	2005-03-23 11:01:19.439422888 +0100
@@ -752,6 +752,7 @@
 		if (dev->device = PCI_DEVICE_ID_INTEL_82855GM_HB)
 			switch (dev->subsystem_device) {
 			case 0x1751: /* M2N notebook */
+			case 0x1821: /* M5N notebook */
 				asus_hides_smbus = 1;
 			}
 		if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)

-- 
Jean Delvare
