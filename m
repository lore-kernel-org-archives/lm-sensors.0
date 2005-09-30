From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:51:55 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 1/5] i2c: update .owner field for
Message-Id: <433D50BF.1090804@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch updates .owner field for various struct pci_driver variables. 

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

Index: linux-2.6-mm/drivers/i2c/busses/i2c-ali1535.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-ali1535.c	2005-09-30 09:05:10.832863750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-ali1535.c	2005-09-30 09:20:32.002433250 +0200
@@ -513,6 +513,7 @@
 }
 
 static struct pci_driver ali1535_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali1535_smbus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-ali1563.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-ali1563.c	2005-09-30 09:05:10.832863750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-ali1563.c	2005-09-30 09:22:08.096438750 +0200
@@ -408,6 +408,7 @@
 MODULE_DEVICE_TABLE (pci, ali1563_id_table);
 
 static struct pci_driver ali1563_pci_driver = {
+	.owner		= THIS_MODULE,
  	.name		= "ali1563_smbus",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-ali15x3.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-ali15x3.c	2005-09-30 09:05:10.836864000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-ali15x3.c	2005-09-30 09:20:32.058436750 +0200
@@ -504,6 +504,7 @@
 }
 
 static struct pci_driver ali15x3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-amd756.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-amd756.c	2005-09-30 09:05:10.836864000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-amd756.c	2005-09-30 09:20:32.058436750 +0200
@@ -401,6 +401,7 @@
 }
 
 static struct pci_driver amd756_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-amd8111.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-amd8111.c	2005-09-30 09:05:10.840864250 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-amd8111.c	2005-09-30 09:20:32.058436750 +0200
@@ -392,6 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-hydra.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-hydra.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-hydra.c	2005-09-30 09:20:32.062437000 +0200
@@ -155,6 +155,7 @@
 
 
 static struct pci_driver hydra_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-i801.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-i801.c	2005-09-30 09:05:10.864865750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-i801.c	2005-09-30 09:20:32.062437000 +0200
@@ -586,6 +586,7 @@
 }
 
 static struct pci_driver i801_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-i810.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-i810.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-i810.c	2005-09-30 09:20:32.062437000 +0200
@@ -232,6 +232,7 @@
 }
 
 static struct pci_driver i810_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i810_smbus",
 	.id_table	= i810_ids,
 	.probe		= i810_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-nforce2.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-nforce2.c	2005-09-30 09:05:10.880866750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-nforce2.c	2005-09-30 09:20:32.062437000 +0200
@@ -356,6 +356,7 @@
 }
 
 static struct pci_driver nforce2_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-piix4.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-piix4.c	2005-09-30 09:05:10.888867250 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-piix4.c	2005-09-30 09:20:32.070437500 +0200
@@ -462,6 +462,7 @@
 }
 
 static struct pci_driver piix4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-prosavage.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-prosavage.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-prosavage.c	2005-09-30 09:20:32.070437500 +0200
@@ -308,6 +308,7 @@
 MODULE_DEVICE_TABLE (pci, prosavage_pci_tbl);
 
 static struct pci_driver prosavage_driver = {
+	.owner		=	THIS_MODULE,
 	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-savage4.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-savage4.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-savage4.c	2005-09-30 09:20:32.078438000 +0200
@@ -179,6 +179,7 @@
 }
 
 static struct pci_driver savage4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "savage4_smbus",
 	.id_table	= savage4_ids,
 	.probe		= savage4_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-sis5595.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-sis5595.c	2005-09-30 09:05:10.912868750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-sis5595.c	2005-09-30 09:20:32.078438000 +0200
@@ -398,6 +398,7 @@
 }
 
 static struct pci_driver sis5595_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis5595_smbus",
 	.id_table	= sis5595_ids,
 	.probe		= sis5595_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-sis630.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-sis630.c	2005-09-30 09:05:10.912868750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-sis630.c	2005-09-30 09:20:32.082438250 +0200
@@ -496,6 +496,7 @@
 
 
 static struct pci_driver sis630_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-sis96x.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-sis96x.c	2005-09-30 09:05:10.920869250 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-sis96x.c	2005-09-30 09:20:32.082438250 +0200
@@ -329,6 +329,7 @@
 }
 
 static struct pci_driver sis96x_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-via.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-via.c	2005-09-30 09:05:10.944870750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-via.c	2005-09-30 09:20:32.082438250 +0200
@@ -159,6 +159,7 @@
 
 
 static struct pci_driver vt586b_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-viapro.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-viapro.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-viapro.c	2005-09-30 09:20:32.082438250 +0200
@@ -423,6 +423,7 @@
 MODULE_DEVICE_TABLE (pci, vt596_ids);
 
 static struct pci_driver vt596_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
Index: linux-2.6-mm/drivers/i2c/busses/i2c-voodoo3.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-voodoo3.c	2005-09-30 09:03:39.000000000 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-voodoo3.c	2005-09-30 09:20:32.122440750 +0200
@@ -225,6 +225,7 @@
 }
 
 static struct pci_driver voodoo3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "voodoo3_smbus",
 	.id_table	= voodoo3_ids,
 	.probe		= voodoo3_probe,




-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/60044ae9/signature.bin
