From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH] I2C-MPC: use wait_event_interruptible_timeout between
Message-Id: <11059983961556@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11059983962750@kroah.com>
References: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: galak@somerset.sps.mot.com

ChangeSet 1.2329.2.10, 2005/01/14 14:44:42-08:00, galak@somerset.sps.mot.com

[PATCH] I2C-MPC: use wait_event_interruptible_timeout between transactions

Use wait_event_interruptible_timeout so we dont waste time waiting between
transactions like we use to.  Also, we use the adapters timeout so the
ioctl cmd I2C_TIMEOUT will now work.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-mpc.c |   36 +++++++++++++++---------------------
 1 files changed, 15 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c	2005-01-17 13:19:57 -08:00
+++ b/drivers/i2c/busses/i2c-mpc.c	2005-01-17 13:19:57 -08:00
@@ -6,7 +6,7 @@
  * MPC107/Tsi107 PowerPC northbridge and processors that include
  * the same I2C unit (8240, 8245, 85xx). 
  *
- * Release 0.6
+ * Release 0.7
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -75,7 +75,6 @@
 
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	unsigned long orig_jiffies = jiffies;
 	u32 x;
 	int result = 0;
@@ -92,28 +91,22 @@
 		x = readb(i2c->base + MPC_I2C_SR);
 		writeb(0, i2c->base + MPC_I2C_SR);
 	} else {
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&i2c->queue, &wait);
-		while (!(i2c->interrupt & CSR_MIF)) {
-			if (signal_pending(current)) {
-				pr_debug("I2C: Interrupted\n");
-				result = -EINTR;
-				break;
-			}
-			if (time_after(jiffies, orig_jiffies + timeout)) {
-				pr_debug("I2C: timeout\n");
-				result = -EIO;
-				break;
-			}
-			msleep_interruptible(jiffies_to_msecs(timeout));
+		/* Interrupt mode */
+		result = wait_event_interruptible_timeout(i2c->queue, 
+			(i2c->interrupt & CSR_MIF), timeout * HZ);
+
+		if (unlikely(result < 0))
+			pr_debug("I2C: wait interrupted\n");
+		else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
+			pr_debug("I2C: wait timeout\n");
+			result = -ETIMEDOUT;
 		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&i2c->queue, &wait);
+
 		x = i2c->interrupt;
 		i2c->interrupt = 0;
 	}
 
-	if (result < -0)
+	if (result < 0)
 		return result;
 
 	if (!(x & CSR_MCF)) {
@@ -165,7 +158,7 @@
 		     const u8 * data, int length, int restart)
 {
 	int i;
-	unsigned timeout = HZ;
+	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Start with MEN */
@@ -193,7 +186,7 @@
 static int mpc_read(struct mpc_i2c *i2c, int target,
 		    u8 * data, int length, int restart)
 {
-	unsigned timeout = HZ;
+	unsigned timeout = i2c->adap.timeout;
 	int i;
 	u32 flags = restart ? CCR_RSTA : 0;
 
@@ -302,6 +295,7 @@
 	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
+	memset(i2c, 0, sizeof(*i2c));
 	i2c->ocpdef = ocp->def;
 	init_waitqueue_head(&i2c->queue);
 

