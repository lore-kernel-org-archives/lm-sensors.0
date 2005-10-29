From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:25:08 +0000
Subject: [lm-sensors] [PATCH] i2c: kzalloc cleanups, 1 of 2
Message-Id: <11305336623316@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: kzalloc cleanups, 1 of 2

Drop useless casts on kzalloc returned values, as suggested by
Jiri Slaby.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 078d9fe4fe8dada13e37d2e2790b0ad780324097
tree dc878bab118133d65a78eb553d7eaa7ccb21cc84
parent 5263ebb51eb098b01caf229498c954999117e4a7
author Jean Delvare <khali@linux-fr.org> Mon, 17 Oct 2005 23:12:36 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:12 -0700

 drivers/i2c/busses/i2c-keywest.c |    2 +-
 drivers/i2c/busses/i2c-nforce2.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
index ef281e0..d61f748 100644
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -535,7 +535,7 @@ create_iface(struct device_node *np, str
 
 	tsize = sizeof(struct keywest_iface) +
 		(sizeof(struct keywest_chan) + 4) * nchan;
-	iface = (struct keywest_iface *) kzalloc(tsize, GFP_KERNEL);
+	iface = kzalloc(tsize, GFP_KERNEL);
 	if (iface = NULL) {
 		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
 		pmac_low_i2c_unlock(np);
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 87b6e26..9b42476 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -313,8 +313,7 @@ static int __devinit nforce2_probe(struc
 	int res1, res2;
 
 	/* we support 2 SMBus adapters */
-	if (!(smbuses = (void *)kzalloc(2*sizeof(struct nforce2_smbus),
-				       	GFP_KERNEL)))
+	if (!(smbuses = kzalloc(2*sizeof(struct nforce2_smbus), GFP_KERNEL)))
 		return -ENOMEM;
 	pci_set_drvdata(dev, smbuses);
 

