From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 18:51:16 +0000
Subject: [lm-sensors] [PATCH 2/7] i2c: scx200_acb - debug log cleanup
Message-Id: <808c8e9d0512191051u6f7c0b38k2c9843a6baed00bf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb debug log cleanup.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm1/drivers/i2c/busses/scx200_acb.c
@@ -45,12 +45,6 @@ static int base[MAX_DEVICES] = { 0x820, 
 module_param_array(base, int, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
-#ifdef DEBUG
-#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
-#else
-#define DBG(x...)
-#endif
-
 /* The hardware supports interrupt driven mode too, but I haven't
    implemented that. */
 #define POLLED_MODE	1
@@ -120,8 +114,8 @@ static void scx200_acb_machine(struct sc
 {
 	const char *errmsg;
 
-	DBG("state %s, status = 0x%02x\n",
-	    scx200_acb_state_name[iface->state], status);
+	dev_dbg(&iface->adapter.dev, "state %s, status = 0x%02x\n",
+		scx200_acb_state_name[iface->state], status);
 
 	if (status & ACBST_BER) {
 		errmsg = "bus error";
@@ -210,8 +204,8 @@ static void scx200_acb_machine(struct sc
 	return;
 
  negack:
-	DBG("negative acknowledge in state %s\n",
-	    scx200_acb_state_name[iface->state]);
+	dev_dbg(&iface->adapter.dev, "negative acknowledge in state %s\n",
+		scx200_acb_state_name[iface->state]);
 
 	iface->state  = state_idle;
 	iface->result = -ENXIO;
@@ -327,16 +321,17 @@ static s32 scx200_acb_smbus_xfer(struct 
 		return -EINVAL;
 	}
 
-	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
-	    size, address, command, len, rw = I2C_SMBUS_READ);
+	dev_dbg(&adapter->dev,
+		"size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
+		size, address, command, len, rw);
 
 	if (!len && rw = I2C_SMBUS_READ) {
-		dev_warn(&adapter->dev, "zero length read\n");
+		dev_dbg(&adapter->dev, "zero length read\n");
 		return -EINVAL;
 	}
 
 	if (len && !buffer) {
-		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
+		dev_dbg(&adapter->dev, "nonzero length but no buffer\n");
 		return -EFAULT;
 	}
 
@@ -376,7 +371,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 		data->word = le16_to_cpu(cur_word);
 
 #ifdef DEBUG
-	DBG(": transfer done, result: %d", rc);
+	dev_dbg(&adapter->dev, "transfer done, result: %d", rc);
 	if (buffer) {
 		int i;
 		printk(" data:");
@@ -413,7 +408,7 @@ static int scx200_acb_probe(struct scx20
 	outb(0x70, ACBCTL2);
 
 	if (inb(ACBCTL2) != 0x70) {
-		DBG("ACBCTL2 readback failed\n");
+		dev_dbg(&iface->adapter.dev, "ACBCTL2 readback failed\n");
 		return -ENXIO;
 	}
 
@@ -421,7 +416,8 @@ static int scx200_acb_probe(struct scx20
 
 	val = inb(ACBCTL1);
 	if (val) {
-		DBG("disabled, but ACBCTL1=0x%02x\n", val);
+		dev_dbg(&iface->adapter.dev, "disabled, but ACBCTL1=0x%02x\n",
+			val);
 		return -ENXIO;
 	}
 
@@ -431,7 +427,9 @@ static int scx200_acb_probe(struct scx20
 
 	val = inb(ACBCTL1);
 	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
-		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
+		dev_dbg(&iface->adapter.dev,
+			"enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n",
+			val);
 		return -ENXIO;
 	}
 
