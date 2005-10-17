From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:47:37 +0000
Subject: [lm-sensors] [PATCH 01/14] Owner field additions to many i2c
Message-Id: <20051017224748.75cdda3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-owner-field-01-struct-pci-driver.patch

This patch updates .owner field for various struct pci_driver variables. 

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-ali1535.c   |    1 +
 drivers/i2c/busses/i2c-ali1563.c   |    1 +
 drivers/i2c/busses/i2c-ali15x3.c   |    1 +
 drivers/i2c/busses/i2c-amd756.c    |    1 +
 drivers/i2c/busses/i2c-amd8111.c   |    1 +
 drivers/i2c/busses/i2c-hydra.c     |    1 +
 drivers/i2c/busses/i2c-i801.c      |    1 +
 drivers/i2c/busses/i2c-i810.c      |    1 +
 drivers/i2c/busses/i2c-nforce2.c   |    1 +
 drivers/i2c/busses/i2c-piix4.c     |    1 +
 drivers/i2c/busses/i2c-prosavage.c |    1 +
 drivers/i2c/busses/i2c-savage4.c   |    1 +
 drivers/i2c/busses/i2c-sis5595.c   |    1 +
 drivers/i2c/busses/i2c-sis630.c    |    1 +
 drivers/i2c/busses/i2c-sis96x.c    |    1 +
 drivers/i2c/busses/i2c-via.c       |    1 +
 drivers/i2c/busses/i2c-viapro.c    |    1 +
 drivers/i2c/busses/i2c-voodoo3.c   |    1 +
 18 files changed, 18 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ali1535.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ali1535.c	2005-10-08 16:35:36.000000000 +0200
@@ -513,6 +513,7 @@
 }
 
 static struct pci_driver ali1535_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali1535_smbus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ali1563.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ali1563.c	2005-10-08 16:35:36.000000000 +0200
@@ -408,6 +408,7 @@
 MODULE_DEVICE_TABLE (pci, ali1563_id_table);
 
 static struct pci_driver ali1563_pci_driver = {
+	.owner		= THIS_MODULE,
  	.name		= "ali1563_smbus",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ali15x3.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ali15x3.c	2005-10-08 16:35:36.000000000 +0200
@@ -504,6 +504,7 @@
 }
 
 static struct pci_driver ali15x3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-amd756.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-amd756.c	2005-10-08 16:35:36.000000000 +0200
@@ -401,6 +401,7 @@
 }
 
 static struct pci_driver amd756_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-amd8111.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-amd8111.c	2005-10-08 16:35:36.000000000 +0200
@@ -392,6 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-hydra.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-hydra.c	2005-10-08 16:35:36.000000000 +0200
@@ -155,6 +155,7 @@
 
 
 static struct pci_driver hydra_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-i801.c	2005-10-07 20:50:16.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-i801.c	2005-10-08 16:35:36.000000000 +0200
@@ -568,6 +568,7 @@
 }
 
 static struct pci_driver i801_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-i810.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-i810.c	2005-10-08 16:35:36.000000000 +0200
@@ -232,6 +232,7 @@
 }
 
 static struct pci_driver i810_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i810_smbus",
 	.id_table	= i810_ids,
 	.probe		= i810_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-nforce2.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-nforce2.c	2005-10-08 16:35:36.000000000 +0200
@@ -356,6 +356,7 @@
 }
 
 static struct pci_driver nforce2_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-piix4.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-piix4.c	2005-10-08 16:35:36.000000000 +0200
@@ -462,6 +462,7 @@
 }
 
 static struct pci_driver piix4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-prosavage.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-prosavage.c	2005-10-08 16:35:36.000000000 +0200
@@ -308,6 +308,7 @@
 MODULE_DEVICE_TABLE (pci, prosavage_pci_tbl);
 
 static struct pci_driver prosavage_driver = {
+	.owner		=	THIS_MODULE,
 	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-savage4.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-savage4.c	2005-10-08 16:35:36.000000000 +0200
@@ -179,6 +179,7 @@
 }
 
 static struct pci_driver savage4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "savage4_smbus",
 	.id_table	= savage4_ids,
 	.probe		= savage4_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-sis5595.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-sis5595.c	2005-10-08 16:35:36.000000000 +0200
@@ -398,6 +398,7 @@
 }
 
 static struct pci_driver sis5595_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis5595_smbus",
 	.id_table	= sis5595_ids,
 	.probe		= sis5595_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-sis630.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-sis630.c	2005-10-08 16:35:36.000000000 +0200
@@ -496,6 +496,7 @@
 
 
 static struct pci_driver sis630_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-sis96x.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-sis96x.c	2005-10-08 16:35:36.000000000 +0200
@@ -329,6 +329,7 @@
 }
 
 static struct pci_driver sis96x_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-via.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-via.c	2005-10-08 16:35:36.000000000 +0200
@@ -159,6 +159,7 @@
 
 
 static struct pci_driver vt586b_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-viapro.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-viapro.c	2005-10-08 16:35:36.000000000 +0200
@@ -439,6 +439,7 @@
 MODULE_DEVICE_TABLE(pci, vt596_ids);
 
 static struct pci_driver vt596_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-voodoo3.c	2005-10-07 19:56:11.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-voodoo3.c	2005-10-08 16:35:36.000000000 +0200
@@ -225,6 +225,7 @@
 }
 
 static struct pci_driver voodoo3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "voodoo3_smbus",
 	.id_table	= voodoo3_ids,
 	.probe		= voodoo3_probe,

-- 
Jean Delvare
