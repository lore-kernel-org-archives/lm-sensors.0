From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:03:25 +0000
Subject: [lm-sensors] [PATCH] Owner field additions to many i2c drivers,
Message-Id: <1130533662814@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11305336621501@kroah.com>
In-Reply-To: <11305336621501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] Owner field additions to many i2c drivers, 1 of 5

This patch updates .owner field for various struct pci_driver variables.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ccd7aa0cc9413b79b69f6cd7c18daa1c22dfa512
tree da13f4e66aeb206019d5a1a5796b5a30ac65da7d
parent fe3d6a99782d5345b1927e872d77d1778668094b
author Laurent Riffard <laurent.riffard@free.fr> Mon, 17 Oct 2005 22:47:48 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

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
 18 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 3eb4789..ba90f51 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -513,6 +513,7 @@ static void __devexit ali1535_remove(str
 }
 
 static struct pci_driver ali1535_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali1535_smbus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index e6f6320..f1a62d8 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -408,6 +408,7 @@ static struct pci_device_id __devinitdat
 MODULE_DEVICE_TABLE (pci, ali1563_id_table);
 
 static struct pci_driver ali1563_pci_driver = {
+	.owner		= THIS_MODULE,
  	.name		= "ali1563_smbus",
 	.id_table	= ali1563_id_table,
  	.probe		= ali1563_probe,
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 7a5c094..400b08e 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -504,6 +504,7 @@ static void __devexit ali15x3_remove(str
 }
 
 static struct pci_driver ali15x3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "ali15x3_smbus",
 	.id_table	= ali15x3_ids,
 	.probe		= ali15x3_probe,
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 1750ded..de035d1 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -401,6 +401,7 @@ static void __devexit amd756_remove(stru
 }
 
 static struct pci_driver amd756_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd756_smbus",
 	.id_table	= amd756_ids,
 	.probe		= amd756_probe,
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 6200c9a..0d29e78 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -392,6 +392,7 @@ static void __devexit amd8111_remove(str
 }
 
 static struct pci_driver amd8111_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "amd8111_smbus2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
diff --git a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
index e0cb3b0..1b5354e 100644
--- a/drivers/i2c/busses/i2c-hydra.c
+++ b/drivers/i2c/busses/i2c-hydra.c
@@ -155,6 +155,7 @@ static void __devexit hydra_remove(struc
 
 
 static struct pci_driver hydra_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "hydra_smbus",
 	.id_table	= hydra_ids,
 	.probe		= hydra_probe,
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 413930c..e90b6c4 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -568,6 +568,7 @@ static void __devexit i801_remove(struct
 }
 
 static struct pci_driver i801_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
diff --git a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
index 0ff7016..1b3393b 100644
--- a/drivers/i2c/busses/i2c-i810.c
+++ b/drivers/i2c/busses/i2c-i810.c
@@ -232,6 +232,7 @@ static void __devexit i810_remove(struct
 }
 
 static struct pci_driver i810_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "i810_smbus",
 	.id_table	= i810_ids,
 	.probe		= i810_probe,
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index dd4b6d8..5dc6211 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -356,6 +356,7 @@ static void __devexit nforce2_remove(str
 }
 
 static struct pci_driver nforce2_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "nForce2_smbus",
 	.id_table	= nforce2_ids,
 	.probe		= nforce2_probe,
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 692f473..7d63eec 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -462,6 +462,7 @@ static void __devexit piix4_remove(struc
 }
 
 static struct pci_driver piix4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "piix4_smbus",
 	.id_table	= piix4_ids,
 	.probe		= piix4_probe,
diff --git a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
index 83fd16d..92b7442 100644
--- a/drivers/i2c/busses/i2c-prosavage.c
+++ b/drivers/i2c/busses/i2c-prosavage.c
@@ -308,6 +308,7 @@ static struct pci_device_id prosavage_pc
 MODULE_DEVICE_TABLE (pci, prosavage_pci_tbl);
 
 static struct pci_driver prosavage_driver = {
+	.owner		=	THIS_MODULE,
 	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
 	.probe		=	prosavage_probe,
diff --git a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
index 0c85182..aebe87b 100644
--- a/drivers/i2c/busses/i2c-savage4.c
+++ b/drivers/i2c/busses/i2c-savage4.c
@@ -179,6 +179,7 @@ static void __devexit savage4_remove(str
 }
 
 static struct pci_driver savage4_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "savage4_smbus",
 	.id_table	= savage4_ids,
 	.probe		= savage4_probe,
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index b57ab74..3ad27c3 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -398,6 +398,7 @@ static void __devexit sis5595_remove(str
 }
 
 static struct pci_driver sis5595_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis5595_smbus",
 	.id_table	= sis5595_ids,
 	.probe		= sis5595_probe,
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index acb75e2..7f49e5f 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -496,6 +496,7 @@ static void __devexit sis630_remove(stru
 
 
 static struct pci_driver sis630_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis630_smbus",
 	.id_table	= sis630_ids,
 	.probe		= sis630_probe,
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 3024907..6a134c0 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -329,6 +329,7 @@ static void __devexit sis96x_remove(stru
 }
 
 static struct pci_driver sis96x_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
index 484bbac..544a38e 100644
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -159,6 +159,7 @@ static void __devexit vt586b_remove(stru
 
 
 static struct pci_driver vt586b_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt586b_smbus",
 	.id_table	= vt586b_ids,
 	.probe		= vt586b_probe,
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 566342d..c9366b5 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -439,6 +439,7 @@ static struct pci_device_id vt596_ids[] 
 MODULE_DEVICE_TABLE(pci, vt596_ids);
 
 static struct pci_driver vt596_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
 	.probe		= vt596_probe,
diff --git a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
index b675773..650c3eb 100644
--- a/drivers/i2c/busses/i2c-voodoo3.c
+++ b/drivers/i2c/busses/i2c-voodoo3.c
@@ -225,6 +225,7 @@ static void __devexit voodoo3_remove(str
 }
 
 static struct pci_driver voodoo3_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "voodoo3_smbus",
 	.id_table	= voodoo3_ids,
 	.probe		= voodoo3_probe,

