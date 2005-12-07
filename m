From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 07 Dec 2005 01:53:05 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5-mm1] i2c: i2c-mv64xxx - Abort may
Message-Id: <20051207015305.GC21553@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051207014449.GA21553@mag.az.mvista.com>
In-Reply-To: <20051207014449.GA21553@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When the i2c-mv64xxx i2c driver is signalled to abort a transaction,
it aborts it immediately by issuing a stop condition on the bus.
This violates the i2c protocol and can cause what appears to be an i2c
bus hang.  This patch delays issuing the stop condition until the i2c
device can reasonably expect a stop condition.

Also includes a minor fixup.

Signed-off-by: Mark A. Greer <mgreer at mvista.com>
--

diff -Nur linux-2.6.15-rc5-mm1-p1/drivers/i2c/busses/i2c-mv64xxx.c linux-2.6.15-rc5-mm1-p2/drivers/i2c/busses/i2c-mv64xxx.c
--- linux-2.6.15-rc5-mm1-p1/drivers/i2c/busses/i2c-mv64xxx.c	2005-12-06 18:08:59.000000000 -0700
+++ linux-2.6.15-rc5-mm1-p2/drivers/i2c/busses/i2c-mv64xxx.c	2005-12-06 18:24:16.000000000 -0700
@@ -1,6 +1,4 @@
 /*
- * drivers/i2c/busses/i2c-mv64xxx.c
- * 
  * Driver for the i2c controller on the Marvell line of host bridges for MIPS
  * and PPC (e.g, gt642[46]0, mv643[46]0, mv644[46]0).
  *
@@ -65,7 +63,6 @@
 	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA,
-	MV64XXX_I2C_STATE_ABORTING,
 };
 
 /* Driver actions */
@@ -85,6 +82,7 @@
 	int			irq;
 	u32			state;
 	u32			action;
+	u32			aborting;
 	u32			cntl_bits;
 	void __iomem		*reg_base;
 	u32			reg_base_p;
@@ -122,12 +120,6 @@
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
@@ -148,14 +140,16 @@
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
 
@@ -184,7 +178,7 @@
 		}
 		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
 
-		if (drv_data->bytes_left = 1)
+		if ((drv_data->bytes_left = 1) || drv_data->aborting)
 			drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_ACK;
 		break;
 
@@ -320,6 +314,7 @@
 	drv_data->msg = msg;
 	drv_data->byte_posn = 0;
 	drv_data->bytes_left = msg->len;
+	drv_data->aborting = 0;
 	drv_data->rc = 0;
 	drv_data->cntl_bits = MV64XXX_I2C_REG_CONTROL_ACK |
 		MV64XXX_I2C_REG_CONTROL_INTEN | MV64XXX_I2C_REG_CONTROL_TWSIEN;
@@ -359,17 +354,19 @@
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
+				"mv64xxx: I2C bus locked, block: %d,"
+				" time_left: %d, before: %d, after: %d\n",
+				drv_data->block, time_left);
 		}
 	} else
 		spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -510,7 +507,7 @@
 		goto exit_kfree;
 	}
 
-	strncpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
+	strlcpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
 		I2C_NAME_SIZE);
 
 	init_waitqueue_head(&drv_data->waitq);

