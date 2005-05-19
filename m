From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH] I2C: add MODULE_DEVICE_TABLE to via686a.c driver
Message-Id: <11059983952870@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050117214543.GB28400@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: greg@kroah.com

ChangeSet 1.2329.2.1, 2005/01/14 14:41:19-08:00, greg@kroah.com

[PATCH] I2C: add MODULE_DEVICE_TABLE to via686a.c driver

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/via686a.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2005-01-17 13:21:21 -08:00
+++ b/drivers/i2c/chips/via686a.c	2005-01-17 13:21:21 -08:00
@@ -786,14 +786,11 @@
 }
 
 static struct pci_device_id via686a_pci_ids[] = {
-       {
-	       .vendor 		= PCI_VENDOR_ID_VIA, 
-	       .device 		= PCI_DEVICE_ID_VIA_82C686_4, 
-	       .subvendor	= PCI_ANY_ID, 
-	       .subdevice	= PCI_ANY_ID, 
-       },
+       { PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
        { 0, }
 };
+
+MODULE_DEVICE_TABLE(pci, via686a_pci_ids);
 
 static int __devinit via686a_pci_probe(struct pci_dev *dev,
                                       const struct pci_device_id *id)

