From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <108198145169@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1081981450639@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.13, 2004/04/02 11:02:40-08:00, mochel@digitalimplant.org

[PATCH] I2C: Add support for the ALi 1563 in the PCI IRQ routing code.


 arch/i386/pci/irq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Wed Apr 14 15:13:55 2004
+++ b/arch/i386/pci/irq.c	Wed Apr 14 15:13:55 2004
@@ -590,12 +590,13 @@
 {
 	switch(device)
 	{
-		case PCI_DEVICE_ID_AL_M1533:
+	case PCI_DEVICE_ID_AL_M1533:
+	case PCI_DEVICE_ID_AL_M1563:
+		printk("PCI: Using ALI IRQ Router\n");
 			r->name = "ALI";
 			r->get = pirq_ali_get;
 			r->set = pirq_ali_set;
 			return 1;
-		/* Should add 156x some day */
 	}
 	return 0;
 }

