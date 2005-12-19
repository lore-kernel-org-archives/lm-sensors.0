From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 18:52:55 +0000
Subject: [lm-sensors] [PATCH 3/7] i2c: scx200_acb - refactor and simplify
Message-Id: <808c8e9d0512191052u2479cc66w87148f04af51f564@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb refactor/simplify code (no functional changes).

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   77 +++++++++++++++-------------------------
 1 files changed, 30 insertions(+), 47 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm1/drivers/i2c/busses/scx200_acb.c
@@ -125,8 +125,17 @@ static void scx200_acb_machine(struct sc
 		errmsg = "not master";
 		goto error;
 	}
-	if (status & ACBST_NEGACK)
-		goto negack;
+	if (status & ACBST_NEGACK) {
+		dev_dbg(&iface->adapter.dev, "negative ack in state %s\n",
+			scx200_acb_state_name[iface->state]);
+
+		iface->state  = state_idle;
+		iface->result = -ENXIO;
+
+		outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+		outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+		return;
+	}
 
 	switch (iface->state) {
 	case state_idle:
@@ -203,17 +212,6 @@ static void scx200_acb_machine(struct sc
 
 	return;
 
- negack:
-	dev_dbg(&iface->adapter.dev, "negative acknowledge in state %s\n",
-		scx200_acb_state_name[iface->state]);
-
-	iface->state  = state_idle;
-	iface->result = -ENXIO;
-
-	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
-	return;
-
  error:
 	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
 		scx200_acb_state_name[iface->state]);
@@ -223,20 +221,10 @@ static void scx200_acb_machine(struct sc
 	iface->needs_reset = 1;
 }
 
-static void scx200_acb_timeout(struct scx200_acb_iface *iface)
-{
-	dev_err(&iface->adapter.dev, "timeout in state %s\n",
-		scx200_acb_state_name[iface->state]);
-
-	iface->state       = state_idle;
-	iface->result      = -EIO;
-	iface->needs_reset = 1;
-}
-
 #ifdef POLLED_MODE
 static void scx200_acb_poll(struct scx200_acb_iface *iface)
 {
-	u8		status = 0;
+	u8		status;
 	unsigned long	timeout;
 
 	timeout = jiffies + POLL_TIMEOUT;
@@ -249,7 +237,12 @@ static void scx200_acb_poll(struct scx20
 		msleep(10);
 	}
 
-	scx200_acb_timeout(iface);
+	dev_err(&iface->adapter.dev, "timeout in state %s\n",
+		scx200_acb_state_name[iface->state]);
+
+	iface->state       = state_idle;
+	iface->result      = -EIO;
+	iface->needs_reset = 1;
 }
 #endif /* POLLED_MODE */
 
@@ -292,13 +285,8 @@ static s32 scx200_acb_smbus_xfer(struct 
 		break;
 
 	case I2C_SMBUS_BYTE:
-		if (rw = I2C_SMBUS_READ) {
-			len    = 1;
-			buffer = &data->byte;
-		} else {
-			len    = 1;
-			buffer = &command;
-		}
+		len    = 1;
+		buffer = (rw = I2C_SMBUS_READ) ? &data->byte : &command;
 		break;
 
 	case I2C_SMBUS_BYTE_DATA:
@@ -337,9 +325,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 
 	down(&iface->sem);
 
-	iface->address_byte = address<<1;
-	if (rw = I2C_SMBUS_READ)
-		iface->address_byte |= 1;
+	iface->address_byte = (address << 1) | rw;
 	iface->command      = command;
 	iface->ptr          = buffer;
 	iface->len          = len;
@@ -440,14 +426,13 @@ static int  __init scx200_acb_create(int
 {
 	struct scx200_acb_iface	*iface;
 	struct i2c_adapter	*adapter;
-	int			rc = 0;
+	int			rc;
 	char			description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
 		printk(KERN_ERR NAME ": can't allocate memory\n");
-		rc = -ENOMEM;
-		goto errout;
+		return -ENOMEM;
 	}
 
 	adapter = &iface->adapter;
@@ -466,14 +451,14 @@ static int  __init scx200_acb_create(int
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
 		rc = -EBUSY;
-		goto errout;
+		goto errout_free;
 	}
 	iface->base = base;
 
 	rc = scx200_acb_probe(iface);
 	if (rc) {
 		dev_warn(&adapter->dev, "probe failed\n");
-		goto errout;
+		goto errout_release;
 	}
 
 	scx200_acb_reset(iface);
@@ -481,7 +466,7 @@ static int  __init scx200_acb_create(int
 	if (i2c_add_adapter(adapter) < 0) {
 		dev_err(&adapter->dev, "failed to register\n");
 		rc = -ENODEV;
-		goto errout;
+		goto errout_release;
 	}
 
 	lock_kernel();
@@ -491,12 +476,10 @@ static int  __init scx200_acb_create(int
 
 	return 0;
 
- errout:
-	if (iface) {
-		if (iface->base)
-			release_region(iface->base, 8);
-		kfree(iface);
-	}
+ errout_release:
+	release_region(iface->base, 8);
+ errout_free:
+	kfree(iface);
 	return rc;
 }
 
