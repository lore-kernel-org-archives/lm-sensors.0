From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Jan 2006 22:17:01 +0000
Subject: [lm-sensors] [PATCH 14/17] i2c: Semaphore to mutex conversions,
Message-Id: <20060118231701.3d26b007.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-convert-semaphores-to-mutexes-3.patch

Cleanup after the semaphores to mutexes conversions in the i2c
subsystem.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-ali1535.c |    1 -
 drivers/i2c/busses/i2c-pxa.c     |    2 +-
 drivers/i2c/busses/scx200_acb.c  |    9 +++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc1.orig/drivers/i2c/busses/i2c-ali1535.c	2006-01-18 20:49:40.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/busses/i2c-ali1535.c	2006-01-18 21:19:30.000000000 +0100
@@ -64,7 +64,6 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
 
 
 /* ALI1535 SMBus address offsets */
--- linux-2.6.16-rc1.orig/drivers/i2c/busses/i2c-pxa.c	2006-01-18 20:49:40.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/busses/i2c-pxa.c	2006-01-18 21:19:30.000000000 +0100
@@ -647,7 +647,7 @@
 }
 
 /*
- * We are protected by the adapter bus semaphore.
+ * We are protected by the adapter bus mutex.
  */
 static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 {
--- linux-2.6.16-rc1.orig/drivers/i2c/busses/scx200_acb.c	2006-01-18 20:59:10.000000000 +0100
+++ linux-2.6.16-rc1/drivers/i2c/busses/scx200_acb.c	2006-01-18 21:19:30.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include <asm/msr.h>
 
@@ -74,7 +75,7 @@
 	struct scx200_acb_iface *next;
 	struct i2c_adapter adapter;
 	unsigned base;
-	struct semaphore sem;
+	struct mutex mutex;
 
 	/* State machine data */
 	enum scx200_acb_state state;
@@ -314,7 +315,7 @@
 		return -EINVAL;
 	}
 
-	down(&iface->sem);
+	mutex_lock(&iface->mutex);
 
 	iface->address_byte = (address << 1) | rw;
 	iface->command = command;
@@ -338,7 +339,7 @@
 
 	rc = iface->result;
 
-	up(&iface->sem);
+	mutex_unlock(&iface->mutex);
 
 	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && rw = I2C_SMBUS_READ)
 		data->word = le16_to_cpu(cur_word);
@@ -431,7 +432,7 @@
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
-	init_MUTEX(&iface->sem);
+	mutex_init(&iface->mutex);
 
 	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
 		 text, adapter->name);

-- 
Jean Delvare

