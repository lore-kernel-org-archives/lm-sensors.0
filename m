From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-mv64xxx fix transaction abortion
Message-Id: <1136585258435@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-mv64xxx fix transaction abortion

When the i2c-mv64xxx i2c driver is signalled to abort a transaction,
it aborts it immediately by issuing a stop condition on the bus.
This violates the i2c protocol and can cause what appears to be an i2c
bus hang.  This patch delays issuing the stop condition until the i2c
device can reasonably expect a stop condition.

Also includes a minor fixup.

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>

---
commit e91c021c487110386a07facd0396e6c3b7cf9c1f
tree 50cd2a5ab8bba9711dd0185e3d232e323e8d6c39
parent 7c72ccf09b6debe55b8e049377ad3183ed4f4cb3
author Mark A. Greer <mgreer at mvista.com> Sun, 18 Dec 2005 17:22:01 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:27 -0800

 drivers/i2c/busses/i2c-mv64xxx.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 81031eb..22781d8 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -1,6 +1,4 @@
 /*
- * drivers/i2c/busses/i2c-mv64xxx.c
- * 
  * Driver for the i2c controller on the Marvell line of host bridges for MIPS
  * and PPC (e.g, gt642[46]0, mv643[46]0, mv644[46]0).
  *
@@ -65,7 +63,6 @@ enum {
 	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA,
-	MV64XXX_I2C_STATE_ABORTING,
 };
 
 /* Driver actions */
@@ -85,6 +82,7 @@ struct mv64xxx_i2c_data {
 	int			irq;
 	u32			state;
 	u32			action;
+	u32			aborting;
 	u32			cntl_bits;
 	void __iomem		*reg_base;
 	u32			reg_base_p;
@@ -122,12 +120,6 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data 
 		return;
 	}
 
-	if (drv_data->state = MV64XXX_I2C_STATE_ABORTING) {
-		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-		drv_data->state = MV64XXX_I2C_STATE_IDLE;
-		return;
-	}
-
 	/* The status from the ctlr [mostly] tells us what to do next */
 	switch (status) {
 	/* Start condition interrupt */
@@ -148,14 +140,16 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data 
 		/* FALLTHRU */
 	case MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK: /* 0xd0 */
 	case MV64XXX_I2C_STATUS_MAST_WR_ACK: /* 0x28 */
-		if (drv_data->bytes_left > 0) {
+		if ((drv_data->bytes_left = 0)
+				|| (drv_data->aborting
+					&& (drv_data->byte_posn != 0))) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		} else {
 			drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
 			drv_data->state  				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK;
 			drv_data->bytes_left--;
-		} else {
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-			drv_data->state = MV64XXX_I2C_STATE_IDLE;
 		}
 		break;
 
@@ -184,7 +178,7 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data 
 		}
 		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
 
-		if (drv_data->bytes_left = 1)
+		if ((drv_data->bytes_left = 1) || drv_data->aborting)
 			drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_ACK;
 		break;
 
@@ -320,6 +314,7 @@ mv64xxx_i2c_prepare_for_io(struct mv64xx
 	drv_data->msg = msg;
 	drv_data->byte_posn = 0;
 	drv_data->bytes_left = msg->len;
+	drv_data->aborting = 0;
 	drv_data->rc = 0;
 	drv_data->cntl_bits = MV64XXX_I2C_REG_CONTROL_ACK |
 		MV64XXX_I2C_REG_CONTROL_INTEN | MV64XXX_I2C_REG_CONTROL_TWSIEN;
@@ -359,17 +354,19 @@ mv64xxx_i2c_wait_for_completion(struct m
 	}
 
 	if (abort && drv_data->block) {
-		drv_data->state = MV64XXX_I2C_STATE_ABORTING;
+		drv_data->aborting = 1;
 		spin_unlock_irqrestore(&drv_data->lock, flags);
 
 		time_left = wait_event_timeout(drv_data->waitq,
 			!drv_data->block,
 			msecs_to_jiffies(drv_data->adapter.timeout));
 
-		if (time_left <= 0) {
+		if ((time_left <= 0) && drv_data->block) {
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
 			dev_err(&drv_data->adapter.dev,
-				"mv64xxx: I2C bus locked\n");
+				"mv64xxx: I2C bus locked, block: %d, "
+				"time_left: %d\n", drv_data->block,
+				(int)time_left);
 		}
 	} else
 		spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -510,7 +507,7 @@ mv64xxx_i2c_probe(struct platform_device
 		goto exit_kfree;
 	}
 
-	strncpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
+	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
 		I2C_NAME_SIZE);
 
 	init_waitqueue_head(&drv_data->waitq);


