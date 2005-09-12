From: gregkh@suse.de (Greg KH)
Date: Mon, 12 Sep 2005 22:10:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix sis5595,
Message-Id: <11265555191080@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: fix sis5595, via686a force_addr module parameter

Recent changes to the i2c-isa design broke the force_addr parameter of
two hardware monitoring drivers as a side effect: sis5595 and via686a.
The last address test was in fact useless beforehand, and the redesign
turned it into a bug. I'm sorry about that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b51f64c0de0355338480093abb35d5232f6d349a
tree 5d72e0ef37629387c8613c2b48afadafbeaca6b4
parent 860e1d6b46bd4cbc67d8d065f0f682143513382f
author Jean Delvare <khali@linux-fr.org> Thu, 08 Sep 2005 22:42:36 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:34:20 -0700

 drivers/hwmon/sis5595.c |    5 -----
 drivers/hwmon/via686a.c |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -758,11 +758,6 @@ static int __devinit sis5595_pci_probe(s
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
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -812,11 +812,6 @@ static int __devinit via686a_pci_probe(s
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

