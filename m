From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 20 Dec 2005 22:58:31 +0000
Subject: [lm-sensors] [PATCH 3/7] i2c: scx200_acb - refactor and simplify
Message-Id: <808c8e9d0512201458u37d663b1paac7c6b6e96c54ce@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191052u2479cc66w87148f04af51f564@mail.gmail.com>
In-Reply-To: <808c8e9d0512191052u2479cc66w87148f04af51f564@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: refactor/simplify code (no functional changes)

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
---
This is the second version of the series.
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   73 +++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 44 deletions(-)

--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm3/drivers/i2c/busses/scx200_acb.c
@@ -124,8 +124,17 @@ static void scx200_acb_machine(struct sc
 		errmsg = "not master";
 		goto error;
 	}
-	if (status & ACBST_NEGACK)
-		goto negack;
+	if (status & ACBST_NEGACK) {
+		dev_dbg(&iface->adapter.dev, "negative ack in state %s\n",
+			scx200_acb_state_name[iface->state]);
+
+		iface->state = state_idle;
+		iface->result = -ENXIO;
+
+		outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+		outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+		return;
+	}
 
 	switch (iface->state) {
 	case state_idle:
@@ -202,17 +211,6 @@ static void scx200_acb_machine(struct sc
 
 	return;
 
- negack:
-	dev_dbg(&iface->adapter.dev, "negative ack in state %s\n",
-		scx200_acb_state_name[iface->state]);
-
-	iface->state = state_idle;
-	iface->result = -ENXIO;
-
-	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
-	return;
-
  error:
 	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
 		scx200_acb_state_name[iface->state]);
@@ -222,20 +220,10 @@ static void scx200_acb_machine(struct sc
 	iface->needs_reset = 1;
 }
 
-static void scx200_acb_timeout(struct scx200_acb_iface *iface)
-{
-	dev_err(&iface->adapter.dev, "timeout in state %s\n",
-		scx200_acb_state_name[iface->state]);
-
-	iface->state = state_idle;
-	iface->result = -EIO;
-	iface->needs_reset = 1;
-}
-
 #ifdef POLLED_MODE
 static void scx200_acb_poll(struct scx200_acb_iface *iface)
 {
-	u8 status = 0;
+	u8 status;
 	unsigned long timeout;
 
 	timeout = jiffies + POLL_TIMEOUT;
@@ -248,7 +236,12 @@ static void scx200_acb_poll(struct scx20
 		msleep(10);
 	}
 
-	scx200_acb_timeout(iface);
+	dev_err(&iface->adapter.dev, "timeout in state %s\n",
+		scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
 }
 #endif /* POLLED_MODE */
 
@@ -291,13 +284,8 @@ static s32 scx200_acb_smbus_xfer(struct 
 		break;
 
 	case I2C_SMBUS_BYTE:
-		if (rw = I2C_SMBUS_READ) {
-			len = 1;
-			buffer = &data->byte;
-		} else {
-			len = 1;
-			buffer = &command;
-		}
+		len = 1;
+		buffer = rw ? &data->byte : &command;
 		break;
 
 	case I2C_SMBUS_BYTE_DATA:
@@ -331,9 +319,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 
 	down(&iface->sem);
 
-	iface->address_byte = address<<1;
-	if (rw = I2C_SMBUS_READ)
-		iface->address_byte |= 1;
+	iface->address_byte = (address << 1) | rw;
 	iface->command = command;
 	iface->ptr = buffer;
 	iface->len = len;
@@ -433,7 +419,7 @@ static int  __init scx200_acb_create(int
 {
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
-	int rc = 0;
+	int rc;
 	char description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
@@ -459,14 +445,14 @@ static int  __init scx200_acb_create(int
 		printk(KERN_ERR NAME ": can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
 		rc = -EBUSY;
-		goto errout;
+		goto errout_free;
 	}
 	iface->base = base;
 
 	rc = scx200_acb_probe(iface);
 	if (rc) {
 		printk(KERN_WARNING NAME ": probe failed\n");
-		goto errout;
+		goto errout_release;
 	}
 
 	scx200_acb_reset(iface);
@@ -474,7 +460,7 @@ static int  __init scx200_acb_create(int
 	if (i2c_add_adapter(adapter) < 0) {
 		printk(KERN_ERR NAME ": failed to register\n");
 		rc = -ENODEV;
-		goto errout;
+		goto errout_release;
 	}
 
 	lock_kernel();
@@ -484,12 +470,11 @@ static int  __init scx200_acb_create(int
 
 	return 0;
 
+ errout_release:
+	release_region(iface->base, 8);
+ errout_free:
+	kfree(iface);
  errout:
-	if (iface) {
-		if (iface->base)
-			release_region(iface->base, 8);
-		kfree(iface);
-	}
 	return rc;
 }
 
