From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <1072821975626@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219742126@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.9.6, 2003/12/04 13:53:39-08:00, khali@linux-fr.org

[PATCH] I2C: add Serverworks CSB6 support to i2c-piix4

This patch adds support for the Serverworks CSB6 to i2c-piix4 driver. It
was confirmed to work by lasirona at yahoo dot com in support ticket
#1424:
http://secure.netroedge.com/~lm78/readticket.cgi?ticket24


 drivers/i2c/busses/Kconfig     |    3 ++-
 drivers/i2c/busses/i2c-piix4.c |    9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Tue Dec 30 12:31:40 2003
+++ b/drivers/i2c/busses/Kconfig	Tue Dec 30 12:31:40 2003
@@ -161,11 +161,12 @@
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset is supported:
+	  versions of the chipset are supported:
 	    Intel PIIX4
 	    Intel 440MX
 	    Serverworks OSB4
 	    Serverworks CSB5
+	    Serverworks CSB6
 	    SMSC Victory66
 
 	  This driver can also be built as a module.  If so, the module
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Tue Dec 30 12:31:40 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Tue Dec 30 12:31:40 2003
@@ -22,7 +22,7 @@
 /*
    Supports:
 	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5
+	Serverworks OSB4, CSB5, CSB6
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one SMBus interface.
@@ -418,6 +418,13 @@
 	{
 		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
 		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB6,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
 		.driver_data =	0,

