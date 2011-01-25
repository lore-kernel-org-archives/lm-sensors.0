From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 25 Jan 2011 14:24:37 +0000
Subject: [lm-sensors] [PATCH] lis33: add retries for SPI mode
Message-Id: <20110125142426.9713.52651.stgit@bob.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kalhan Trisal <kalhan.trisal@intel.com>

Turn down the no IRQ message - on some platforms that's a normal state of
affairs.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hwmon/lis3lv02d.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 1b674b7..d805e8e 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -957,7 +957,7 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 
 	/* bail if we did not get an IRQ from the bus layer */
 	if (!dev->irq) {
-		pr_err("No IRQ. Disabling /dev/freefall\n");
+		pr_debug("No IRQ. Disabling /dev/freefall\n");
 		goto out;
 	}
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
