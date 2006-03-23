From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 18/36] i2c: Semaphore to mutex conversions,
Message-Id: <1143153831767-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cleanup after the semaphores to mutexes conversions in the i2c
subsystem.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-ali1535.c |    1 -
 drivers/i2c/busses/i2c-pxa.c     |    2 +-
 drivers/i2c/busses/scx200_acb.c  |    9 +++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

3fb9a65529615944138d527b70174840c95c637a
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 26cf891..115a731 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -64,7 +64,6 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
 
 
 /* ALI1535 SMBus address offsets */
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 7579f4b..5155010 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -647,7 +647,7 @@ static inline void i2c_pxa_start_message
 }
 
 /*
- * We are protected by the adapter bus semaphore.
+ * We are protected by the adapter bus mutex.
  */
 static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 {
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 8e646bd..8bd305e 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -31,6 +31,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #include <asm/io.h>
 #include <asm/msr.h>
 
@@ -74,7 +75,7 @@ struct scx200_acb_iface {
 	struct scx200_acb_iface *next;
 	struct i2c_adapter adapter;
 	unsigned base;
-	struct semaphore sem;
+	struct mutex mutex;
 
 	/* State machine data */
 	enum scx200_acb_state state;
@@ -314,7 +315,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 		return -EINVAL;
 	}
 
-	down(&iface->sem);
+	mutex_lock(&iface->mutex);
 
 	iface->address_byte = (address << 1) | rw;
 	iface->command = command;
@@ -338,7 +339,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 
 	rc = iface->result;
 
-	up(&iface->sem);
+	mutex_unlock(&iface->mutex);
 
 	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && rw = I2C_SMBUS_READ)
 		data->word = le16_to_cpu(cur_word);
@@ -431,7 +432,7 @@ static int  __init scx200_acb_create(con
 	adapter->algo = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
-	init_MUTEX(&iface->sem);
+	mutex_init(&iface->mutex);
 
 	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
 		 text, adapter->name);
-- 
1.2.4



