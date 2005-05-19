From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913933600@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913932514@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.5, 2004/03/09 14:59:37-08:00, rddunlap@osdl.org

[PATCH] I2C: fix i2c-prosavage.c section usage

prosavage_remove() is called during init, so it shouldn't be
marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)


 drivers/i2c/busses/i2c-prosavage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:55 2004
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Mar 15 14:34:55 2004
@@ -216,7 +216,7 @@
 /*
  * Cleanup stuff
  */
-static void __devexit prosavage_remove(struct pci_dev *dev)
+static void prosavage_remove(struct pci_dev *dev)
 {
 	struct s_i2c_chip *chip;
 	int i, ret;
@@ -321,7 +321,7 @@
 	.name		=	"prosavage-smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
-	.remove		=	__devexit_p(prosavage_remove),
+	.remove		=	prosavage_remove,
 };
 
 static int __init i2c_prosavage_init(void)

