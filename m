From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:03 +0000
Subject: [lm-sensors] [PATCH 37/44] [PATCH] i2c-i801: Remove PCI function
Message-Id: <11510010393810-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-i801: Remove PCI function check

Remove the PCI function number check when probing devices.
This check is redundant, each function has a separate PCI device
ID, so checking for that ID is sufficient.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-i801.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 0d5374c..b651493 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -107,10 +107,6 @@ static int i801_setup(struct pci_dev *de
 	int error_return = 0;
 	unsigned char temp;
 
-	/* Note: we keep on searching until we have found 'function 3' */
-	if(PCI_FUNC(dev->devfn) != 3)
-		return -ENODEV;
-
 	I801_dev = dev;
 	if ((dev->device = PCI_DEVICE_ID_INTEL_82801DB_3) ||
 	    (dev->device = PCI_DEVICE_ID_INTEL_82801EB_3) ||
-- 
1.4.0


