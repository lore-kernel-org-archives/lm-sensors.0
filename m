From: Matthew Garrett <mjg@redhat.com>
Date: Tue, 09 Aug 2011 16:14:43 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: Add interrupt support to applesmc
Message-Id: <1312906483-3046-3-git-send-email-mjg@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The applesmc hardware supports providing interrupts for significant
accelerometer events. Add framework for this - we'll want to notify
userspace on these in the long run to handle head unloading, but we need
to figure out the best interface for that first. Code based on a patch by
Nicolas Boichat and the FreeBSD kernel code.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Nicolas Boichat <nicolas@boichat.ch>
---
 drivers/hwmon/applesmc.c |  138 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 4540bb1..ac2f9a2 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -45,11 +45,13 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/pnp.h>
+#include <linux/interrupt.h>
 
 /* data port used by Apple SMC */
 #define APPLESMC_DATA_PORT	0
 /* command/status port used by Apple SMC */
 #define APPLESMC_CMD_PORT	0x4
+#define APPLESMC_INT_PORT	0x1f
 
 #define APPLESMC_NR_PORTS	32
 
@@ -78,6 +80,14 @@
 #define MOTION_SENSOR_Z_KEY	"MO_Z" /* r-o sp78 (2 bytes) */
 #define MOTION_SENSOR_KEY	"MOCN" /* r/w ui16 */
 
+#define NOTIFY_KEY		"NTOK" /* r/w ui8 */
+
+#define NOTIFY_LOW_RATE		"MOLD" /* r/w ui8 */
+#define NOTIFY_HIGH_RATE	"MOHD" /* r/w ui8 */
+#define NOTIFY_LOW_THRESH	"MOLT" /* r/w ui16 */
+#define NOTIFY_HIGH_THRESH	"MOHT" /* r/w ui16 */
+#define NOTIFY_FLAG		"MSDW" /* r/w ui8 */
+
 #define FANS_COUNT		"FNum" /* r-o ui8 */
 #define FANS_MANUAL		"FS! " /* r-w ui16 */
 #define FAN_ID_FMT		"F%dID" /* r-o char[16] */
@@ -147,6 +157,7 @@ struct applesmc_registers {
 struct applesmc_dev {
 	int iobase;
 	int iolen;
+	int irq;
 	struct work_struct backlight_work;
 	struct applesmc_registers smcreg;
 	/*
@@ -447,6 +458,37 @@ static int applesmc_write_key(struct applesmc_dev *pdev, const char *key,
 	return applesmc_write_entry(pdev, entry, buffer, len);
 }
 
+static int applesmc_write_key_check(struct applesmc_dev *pdev, const char *key,
+				    u8 *buffer, u8 len)
+{
+	int total, ret, i, compare;
+
+	u8 rdbuffer[APPLESMC_MAX_DATA_LENGTH];
+
+	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
+		ret = applesmc_read_key(pdev, key, rdbuffer, len);
+		if (!ret) {
+			compare = 1;
+			for (i = 0; i < len; i++) {
+				if (rdbuffer[i] != buffer[i]) {
+					compare = 0;
+					break;
+				}
+			}
+
+			if (compare)
+				return 0;
+		}
+		ret = applesmc_write_key(pdev, key, buffer, len);
+		msleep(INIT_WAIT_MSECS);
+	}
+
+	if (ret)
+		return ret;
+	else
+		return -EIO;
+}
+
 static int applesmc_has_key(struct applesmc_dev *pdev, const char *key,
 			    bool *value)
 {
@@ -489,27 +531,49 @@ static int applesmc_read_motion_sensor(struct applesmc_dev *pdev, int index,
 }
 
 /*
- * applesmc_device_init - initialize the accelerometer.  Can sleep.
+ * applesmc_accel_init - initialize the accelerometer.  Can sleep.
  */
-static void applesmc_device_init(struct applesmc_dev *pdev)
+static void applesmc_accel_init(struct applesmc_dev *pdev)
 {
-	int total;
+	int ret;
 	u8 buffer[2];
 
 	if (!pdev->smcreg.has_accelerometer)
 		return;
 
-	for (total = INIT_TIMEOUT_MSECS; total > 0; total -= INIT_WAIT_MSECS) {
-		if (!applesmc_read_key(pdev, MOTION_SENSOR_KEY, buffer, 2) &&
-				(buffer[0] != 0x00 || buffer[1] != 0x00))
-			return;
-		buffer[0] = 0xe0;
-		buffer[1] = 0x00;
-		applesmc_write_key(pdev, MOTION_SENSOR_KEY, buffer, 2);
-		msleep(INIT_WAIT_MSECS);
-	}
+	buffer[0] = 20;
+	ret = applesmc_write_key_check(pdev, NOTIFY_LOW_RATE, buffer, 1);
+	if (ret)
+		goto out;
+
+	ret = applesmc_write_key_check(pdev, NOTIFY_HIGH_RATE, buffer, 1);
+	if (ret)
+		goto out;
 
-	pr_warn("failed to init the device\n");
+	buffer[0] = 0;
+	buffer[1] = 0x60;
+	ret = applesmc_write_key_check(pdev, NOTIFY_LOW_THRESH, buffer, 2);
+	if (ret)
+		goto out;
+
+	buffer[0] = 1;
+	buffer[1] = 0xc0;
+	ret = applesmc_write_key_check(pdev, NOTIFY_HIGH_THRESH, buffer, 2);
+	if (ret)
+		goto out;
+
+	buffer[0] = 0xe0;
+	buffer[1] = 0xf8;
+	ret = applesmc_write_key_check(pdev, MOTION_SENSOR_KEY, buffer, 2);
+
+	buffer[0] = 1;
+	ret = applesmc_write_key(pdev, NOTIFY_FLAG, buffer, 1);
+	if (ret)
+		goto out;
+
+out:
+	if (ret)
+		pr_warn("failed to init the accelerometer\n");
 }
 
 /*
@@ -629,7 +693,7 @@ static int applesmc_pm_restore(struct device *dev)
 	struct pnp_dev *pnpdev = to_pnp_dev(dev);
 	struct applesmc_dev *pdev = pnp_get_drvdata(pnpdev);
 
-	applesmc_device_init(pdev);
+	applesmc_accel_init(pdev);
 	return applesmc_pm_resume(dev);
 }
 
@@ -1265,10 +1329,36 @@ static void applesmc_release_key_backlight(struct applesmc_dev *pdev)
 	destroy_workqueue(pdev->applesmc_led_wq);
 }
 
+static irqreturn_t applesmc_interrupt(int irq, void *d)
+{
+	struct applesmc_dev *pdev = d;
+	u8 intr = applesmc_read_reg(pdev, APPLESMC_INT_PORT);
+
+	switch (intr) {
+	case 0x60:
+		printk(KERN_INFO "applesmc: Free fall interrupt\n");
+		break;
+	case 0x6f:
+		printk(KERN_INFO "applesmc: High acceleration interrupt\n");
+		break;
+	case 0x80:
+		printk(KERN_INFO "applesmc: Shock interrupt\n");
+		break;
+	default:
+		if (intr)
+			printk(KERN_INFO "applesmc: Unknown interrupt %x\n",
+			       intr);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit applesmc_pnp_probe(struct pnp_dev *dev,
 					const struct pnp_device_id *dev_id)
 {
 	int ret;
+	u8 buffer = 1;
 	struct resource *res;
 	struct applesmc_dev *pdev = kzalloc(sizeof(struct applesmc_dev),
 					    GFP_KERNEL);
@@ -1295,6 +1385,15 @@ static int __devinit applesmc_pnp_probe(struct pnp_dev *dev,
 		goto out;
 	}
 
+	res = pnp_get_resource(dev, IORESOURCE_IRQ, 0);
+
+	if (res) {
+		ret = request_irq(res->start, applesmc_interrupt,
+				  IRQF_DISABLED, "applesmc", pdev);
+		if (!ret)
+			pdev->irq = res->start;
+	}
+
 	/* create register cache */
 
 	ret = applesmc_init_smcreg(pdev);
@@ -1333,7 +1432,9 @@ static int __devinit applesmc_pnp_probe(struct pnp_dev *dev,
 
 	INIT_WORK(&pdev->backlight_work, &applesmc_backlight_set);
 
-	applesmc_device_init(pdev);
+	applesmc_accel_init(pdev);
+
+	applesmc_write_key(pdev, NOTIFY_KEY, &buffer, 1);
 
 	return 0;
 
@@ -1352,6 +1453,8 @@ out_info:
 out_smcreg:
 	applesmc_destroy_smcreg(pdev);
 out_region:
+	if (pdev->irq)
+		free_irq(pdev->irq, pdev);
 	release_region(pdev->iobase, pdev->iolen);
 out:
 	kfree(pdev);
@@ -1362,7 +1465,12 @@ out:
 static void __devexit applesmc_pnp_remove(struct pnp_dev *dev)
 {
 	struct applesmc_dev *pdev = pnp_get_drvdata(dev);
+	u8 buffer = 0;
 
+	if (pdev->irq) {
+		applesmc_write_key(pdev, NOTIFY_KEY, &buffer, 1);
+		free_irq(pdev->irq, pdev);
+	}
 	hwmon_device_unregister(pdev->hwmon_dev);
 	applesmc_release_key_backlight(pdev);
 	applesmc_release_light_sensor(pdev);
-- 
1.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
