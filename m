From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913911774@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913902844@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.7, 2004/02/18 09:39:10-08:00, greg@kroah.com

I2C: fix oops in i2c-ali1535 driver if no hardware is present.

Thanks to Dave Jones for pointing this out.


 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:37:27 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:37:27 2004
@@ -517,6 +517,7 @@
 static void __devexit ali1535_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&ali1535_adapter);
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 static struct pci_driver ali1535_driver = {
@@ -534,7 +535,6 @@
 static void __exit i2c_ali1535_exit(void)
 {
 	pci_unregister_driver(&ali1535_driver);
-	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "

