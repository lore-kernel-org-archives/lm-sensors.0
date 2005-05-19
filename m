From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <1081981450639@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814501036@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.12, 2004/04/02 11:02:14-08:00, mochel@digitalimplant.org

[PATCH] I2C: Add ALi 1563 Device ID to pci_ids.h


 include/linux/pci_ids.h |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Wed Apr 14 15:14:00 2004
+++ b/include/linux/pci_ids.h	Wed Apr 14 15:14:00 2004
@@ -994,6 +994,7 @@
 #define PCI_DEVICE_ID_AL_M1531		0x1531
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1541		0x1541
+#define PCI_DEVICE_ID_AL_M1563		0x1563
 #define PCI_DEVICE_ID_AL_M1621		0x1621
 #define PCI_DEVICE_ID_AL_M1631		0x1631
 #define PCI_DEVICE_ID_AL_M1632		0x1632

