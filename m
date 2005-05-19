From: rddunlap@osdl.org (Randy.Dunlap)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH] i2c-ali1563: fix init & exit section usage
Message-Id: <20050106230456.0961014b.rddunlap@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Fix init & exit section usages, beginning with this diagnostic
from reference_discarded.pl (make buildcheck):
Error: ./drivers/i2c/busses/i2c-ali1563.o .data refers to 00000278 R_386_32          .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat: drivers/i2c/busses/i2c-ali1563.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp ./drivers/i2c/busses/i2c-ali1563.c~i2c_ali_devexit ./drivers/i2c/busses/i2c-ali1563.c
--- ./drivers/i2c/busses/i2c-ali1563.c~i2c_ali_devexit	2004-12-24 13:35:01.000000000 -0800
+++ ./drivers/i2c/busses/i2c-ali1563.c	2005-01-06 21:42:06.556855352 -0800
@@ -306,7 +306,7 @@ static void ali1563_enable(struct pci_de
 	pci_write_config_word(dev,ALI1563_SMBBA,ctrl);
 }
 
-static int __init ali1563_setup(struct pci_dev * dev)
+static int __devinit ali1563_setup(struct pci_dev * dev)
 {
 	u16 ctrl;
 
@@ -362,7 +362,7 @@ static struct i2c_adapter ali1563_adapte
 	.algo	= &ali1563_algorithm,
 };
 
-static int __init ali1563_probe(struct pci_dev * dev,
+static int __devinit ali1563_probe(struct pci_dev * dev,
 				const struct pci_device_id * id_table)
 {
 	int error;
@@ -378,7 +378,7 @@ static int __init ali1563_probe(struct p
 	return error;
 }
 
-static void __exit ali1563_remove(struct pci_dev * dev)
+static void __devexit ali1563_remove(struct pci_dev * dev)
 {
 	i2c_del_adapter(&ali1563_adapter);
 	ali1563_shutdown(dev);
@@ -400,7 +400,7 @@ static struct pci_driver ali1563_pci_dri
  	.name		= "ali1563_i2c",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
-	.remove		= ali1563_remove,
+	.remove		= __devexit_p(ali1563_remove),
 };
 
 static int __init ali1563_init(void)


---
