From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Sep 2005 22:42:36 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: fix sis5595,
Message-Id: <20050908224236.1f2d5d78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Recent changes to the i2c-isa design broke the force_addr parameter of
two hardware monitoring drivers as a side effect: sis5595 and via686a.
The last address test was in fact useless beforehand, and the redesign
turned it into a bug. I'm sorry about that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/sis5595.c |    5 -----
 drivers/hwmon/via686a.c |    5 -----
 2 files changed, 10 deletions(-)

--- linux-2.6.13-git7.orig/drivers/hwmon/sis5595.c	2005-09-08 10:42:51.000000000 +0200
+++ linux-2.6.13-git7/drivers/hwmon/sis5595.c	2005-09-08 11:51:46.000000000 +0200
@@ -758,11 +758,6 @@
 		return -ENODEV;
 	}
 
-	if (!address) {
-		dev_err(&dev->dev,"No SiS 5595 sensors found.\n");
-		return -ENODEV;
-	}
-
 	s_bridge = pci_dev_get(dev);
 	if (i2c_isa_add_driver(&sis5595_driver)) {
 		pci_dev_put(s_bridge);
--- linux-2.6.13-git7.orig/drivers/hwmon/via686a.c	2005-09-08 11:42:22.000000000 +0200
+++ linux-2.6.13-git7/drivers/hwmon/via686a.c	2005-09-08 11:51:37.000000000 +0200
@@ -812,11 +812,6 @@
 		return -ENODEV;
 	}
 
-	if (!address) {
-		dev_err(&dev->dev, "No Via 686A sensors found.\n");
-		return -ENODEV;
-	}
-
 	s_bridge = pci_dev_get(dev);
 	if (i2c_isa_add_driver(&via686a_driver)) {
 		pci_dev_put(s_bridge);


-- 
Jean Delvare
