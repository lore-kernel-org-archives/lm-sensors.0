From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:12:19 +0000
Subject: [lm-sensors] [PATCH 12/14] i2c: kzalloc cleanups, 1 of 2
Message-Id: <20051017231236.111e196d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=kzalloc-04-drop-useless-casts.patch

Drop useless casts on kzalloc returned values, as suggested by
Jiri Slaby.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-keywest.c |    2 +-
 drivers/i2c/busses/i2c-nforce2.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-keywest.c	2005-10-13 22:21:36.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-keywest.c	2005-10-13 22:46:35.000000000 +0200
@@ -535,7 +535,7 @@
 
 	tsize = sizeof(struct keywest_iface) +
 		(sizeof(struct keywest_chan) + 4) * nchan;
-	iface = (struct keywest_iface *) kzalloc(tsize, GFP_KERNEL);
+	iface = kzalloc(tsize, GFP_KERNEL);
 	if (iface = NULL) {
 		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
 		pmac_low_i2c_unlock(np);
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-nforce2.c	2005-10-13 22:21:36.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-nforce2.c	2005-10-13 22:46:22.000000000 +0200
@@ -313,8 +313,7 @@
 	int res1, res2;
 
 	/* we support 2 SMBus adapters */
-	if (!(smbuses = (void *)kzalloc(2*sizeof(struct nforce2_smbus),
-				       	GFP_KERNEL)))
+	if (!(smbuses = kzalloc(2*sizeof(struct nforce2_smbus), GFP_KERNEL)))
 		return -ENOMEM;
 	pci_set_drvdata(dev, smbuses);
 

-- 
Jean Delvare
