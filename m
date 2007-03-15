From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 12:42:08 +0000
Subject: [lm-sensors] [PATCH] smsc47m1: Use DRVNAME consistently
Message-Id: <20070315134208.c7c09a68.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Also use pr_info where possible.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- linux-2.6.21-rc3.orig/drivers/hwmon/smsc47m1.c	2007-03-15 13:19:42.000000000 +0100
+++ linux-2.6.21-rc3/drivers/hwmon/smsc47m1.c	2007-03-15 13:34:05.000000000 +0100
@@ -437,25 +437,23 @@ static int __init smsc47m1_find(unsigned
 	 */
 	switch (val) {
 	case 0x51:
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47B27x\n");
+		pr_info(DRVNAME ": Found SMSC LPC47B27x\n");
 		sio_data->type = smsc47m1;
 		break;
 	case 0x59:
-		printk(KERN_INFO "smsc47m1: Found SMSC "
-		       "LPC47M10x/LPC47M112/LPC47M13x\n");
+		pr_info(DRVNAME ": Found SMSC LPC47M10x/LPC47M112/LPC47M13x\n");
 		sio_data->type = smsc47m1;
 		break;
 	case 0x5F:
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M14x\n");
+		pr_info(DRVNAME ": Found SMSC LPC47M14x\n");
 		sio_data->type = smsc47m1;
 		break;
 	case 0x60:
-		printk(KERN_INFO "smsc47m1: Found SMSC "
-		       "LPC47M15x/LPC47M192/LPC47M997\n");
+		pr_info(DRVNAME ": Found SMSC LPC47M15x/LPC47M192/LPC47M997\n");
 		sio_data->type = smsc47m1;
 		break;
 	case 0x6B:
-		printk(KERN_INFO "smsc47m1: Found SMSC LPC47M292\n");
+		pr_info(DRVNAME ": Found SMSC LPC47M292\n");
 		sio_data->type = smsc47m2;
 		break;
 	default:
@@ -468,7 +466,7 @@ static int __init smsc47m1_find(unsigned
 	      |  superio_inb(SUPERIO_REG_BASE + 1);
 	val = superio_inb(SUPERIO_REG_ACT);
 	if (*addr = 0 || (val & 0x01) = 0) {
-		printk(KERN_INFO "smsc47m1: Device is disabled, will not use\n");
+		pr_info(DRVNAME ": Device is disabled, will not use\n");
 		superio_exit();
 		return -ENODEV;
 	}


-- 
Jean Delvare

