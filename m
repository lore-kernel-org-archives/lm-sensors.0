From: jirislaby@gmail.com (Jiri Slaby)
Date: Fri, 26 May 2006 00:09:43 +0000
Subject: [lm-sensors] [PATCH 1/3] pci: i2c scx200_acb avoid pci_find_device
Message-Id: <mailman.1.1148602184.3279.lm-sensors@lm-sensors.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c scx200_acb avoid pci_find_device

i2c scx200_acb bus driver pci_find_device -> pci_get_device conversion.

Signed-off-by: Jiri Slaby <jirislaby at gmail.com>

---
commit ab3443d79c94d0ae6a9e020daefa4d29eccff50d
tree 3372341e382c936c1ce3e5bda4d98bac75f8f9f3
parent 264844223a71591b12228a4f1320a7a0824cf926
author Jiri Slaby <ku at bellona.localdomain> Thu, 25 May 2006 22:48:28 +0159
committer Jiri Slaby <ku at bellona.localdomain> Thu, 25 May 2006 22:48:28 +0159

 drivers/i2c/busses/scx200_acb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 5d8d54c..d5056c9 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -498,6 +498,8 @@ static int __init scx200_acb_create(char
  errout_free:
 	kfree(iface);
  errout:
+	if (iface->pdev != NULL)
+		pci_dev_put(iface->pdev);
 	return rc;
 }
 
@@ -532,7 +534,7 @@ static int scx200_add_cs553x(void)
 
 	for (dev = 0; dev < DIVIL_LENGTH; dev++) {
 		pdev -		    pci_find_device(divil_pci[dev].vendor,
+		    pci_get_device(divil_pci[dev].vendor,
 				    divil_pci[dev].device, NULL);
 		if (pdev != NULL)
 			break;
@@ -579,9 +581,10 @@ static void __exit scx200_acb_cleanup(vo
 
 		i2c_del_adapter(&iface->adapter);
 
-		if (iface->pdev != NULL)
+		if (iface->pdev != NULL) {
 			pci_release_region(iface->pdev, iface->bar);
-		else
+			pci_dev_put(iface->pdev);
+		} else
 			release_region(iface->base, 8);
 
 		kfree(iface);

