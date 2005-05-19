From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH] I2C support for Intel ICH7 - 2.6.10 - resubmit
Message-Id: <1105998395759@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11059983952870@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: jason.d.gaston@intel.com

ChangeSet 1.2329.2.2, 2005/01/14 14:41:41-08:00, jason.d.gaston@intel.com

[PATCH] I2C support for Intel ICH7 - 2.6.10 - resubmit

This patch adds the Intel ICH7 DID to the i2c-i801.c driver and adds an
entry to Kconfig for I2C(SMBus) support.  Note: This patch relies on the
already submitted and accepted PATA patch to pci_ids.h containing all
ICH7 DID's.


Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig    |    1 +
 drivers/i2c/busses/i2c-i801.c |    2 ++
 2 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-01-17 13:21:11 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-01-17 13:21:11 -08:00
@@ -112,6 +112,7 @@
 	    82801EB
 	    6300ESB
 	    ICH6
+	    ICH7
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2005-01-17 13:21:11 -08:00
+++ b/drivers/i2c/busses/i2c-i801.c	2005-01-17 13:21:11 -08:00
@@ -30,6 +30,7 @@
     82801EB		24D3   (HW PEC supported, 32 byte buffer not supported)
     6300ESB		25A4
     ICH6		266A
+    ICH7		27DA
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
     of Intel's '810' and other chipsets.
@@ -556,6 +557,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
 	{ 0, }
 };
 

