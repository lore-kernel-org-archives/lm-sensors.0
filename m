From: rddunlap@osdl.org (Randy.Dunlap)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH] i2c-prosavage.c section usage
Message-Id: <20040307194701.0cf1ec47.rddunlap@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

prosavage_remove() is called during init, so it shouldn't be
marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)

--
~Randy


// Linux 2.6.4-rc2
// prosavage_remove() shouldn't be marked as __devexit;


diffstat: drivers/i2c/busses/i2c-prosavage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./drivers/i2c/busses/i2c-prosavage.c~i2cpro_init ./drivers/i2c/busses/i2c-prosavage.c
--- ./drivers/i2c/busses/i2c-prosavage.c~i2cpro_init	2004-02-17 19:57:22.000000000 -0800
+++ ./drivers/i2c/busses/i2c-prosavage.c	2004-03-07 16:10:16.000000000 -0800
@@ -216,7 +216,7 @@ static int i2c_register_bus(struct pci_d
 /*
  * Cleanup stuff
  */
-static void __devexit prosavage_remove(struct pci_dev *dev)
+static void prosavage_remove(struct pci_dev *dev)
 {
 	struct s_i2c_chip *chip;
 	int i, ret;
@@ -321,7 +321,7 @@ static struct pci_driver prosavage_drive
 	.name		=	"prosavage-smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
-	.remove		=	__devexit_p(prosavage_remove),
+	.remove		=	prosavage_remove,
 };
 
 static int __init i2c_prosavage_init(void)
