From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] Yet more i2c driver changes for 2.5.69
Message-Id: <10533859472025@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030519231156.GA27535@kroah.com>
References: <20030323081431.GF26145@kroah.com>
In-Reply-To: <20030323081431.GF26145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1093.2.1, 2003/05/13 12:33:20-07:00, greg@kroah.com

[PATCH] i2c: piix4 driver: turn common error message to a debug level and rename the sysfs driver name.


 drivers/i2c/busses/i2c-piix4.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon May 19 15:59:14 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon May 19 15:59:14 2003
@@ -269,7 +269,7 @@
 
 	if (temp & 0x04) {
 		result = -1;
-		dev_err(&piix4_adapter.dev, "Error: no response!\n");
+		dev_dbg(&piix4_adapter.dev, "Error: no response!\n");
 	}
 
 	if (inb_p(SMBHSTSTS) != 0x00)
@@ -467,7 +467,7 @@
 
 
 static struct pci_driver piix4_driver = {
-	.name		= "piix4 smbus",
+	.name		= "piix4-smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
 	.remove		= __devexit_p(piix4_remove),

