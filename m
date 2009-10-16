From: Roel Kluin <roel.kluin@gmail.com>
Date: Fri, 16 Oct 2009 14:48:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix check on unsigned in
Message-Id: <4AD887C6.9000809@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If unsigned the watchdog_trigger() return value will not be
checked correctly.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 2a7a85a..da1b1f9 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -819,7 +819,7 @@ static int watchdog_release(struct inode *inode, struct file *filp)
 static ssize_t watchdog_write(struct file *filp, const char __user *buf,
 	size_t count, loff_t *offset)
 {
-	size_t ret;
+	int ret;
 	struct fschmd_data *data = filp->private_data;
 
 	if (count) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
