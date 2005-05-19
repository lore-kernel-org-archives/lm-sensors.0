From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913911614@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913913301@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.9, 2004/02/23 16:27:33-08:00, khali@linux-fr.org

[PATCH] I2C: fix mor rmmod oopses

> Oh nevermind, that's just a dumb driver.  It's doing a release_region
> on memory it didn't get.  Stupid, stupid, stupid...

While we're at it, what about fixing two other drivers that obviously
have the same problem?

(BTW I didn't get an oops as I tried reproducing the problem, only a
"Trying to free nonexistent resource" in dmesg.)


 drivers/i2c/busses/i2c-i801.c    |    2 +-
 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:37:14 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:37:14 2004
@@ -608,6 +608,7 @@
 static void __devexit i801_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&i801_adapter);
+	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
 static struct pci_driver i801_driver = {
@@ -625,7 +626,6 @@
 static void __exit i2c_i801_exit(void)
 {
 	pci_unregister_driver(&i801_driver);
-	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
 MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:37:14 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:37:14 2004
@@ -391,6 +391,7 @@
 static void __devexit sis5595_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&sis5595_adapter);
+	release_region(sis5595_base + SMB_INDEX, 2);
 }
 
 static struct pci_driver sis5595_driver = {
@@ -408,7 +409,6 @@
 static void __exit i2c_sis5595_exit(void)
 {
 	pci_unregister_driver(&sis5595_driver);
-	release_region(sis5595_base + SMB_INDEX, 2);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");

