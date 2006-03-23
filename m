From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:50 +0000
Subject: [lm-sensors] [PATCH 10/36] i2c: scx200_acb fix and speed up the
Message-Id: <11431538301289-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: Fix and speed up the poll loop

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/scx200_acb.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

f933ff504f5b3f0f94b98d69d48fc8d3c1e92267
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 0ae77f8..8e646bd 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -47,10 +47,7 @@ static int base[MAX_DEVICES] = { 0x820, 
 module_param_array(base, int, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
-/* The hardware supports interrupt driven mode too, but I haven't
-   implemented that. */
-#define POLLED_MODE 1
-#define POLL_TIMEOUT (HZ)
+#define POLL_TIMEOUT	(HZ/5)
 
 enum scx200_acb_state {
 	state_idle,
@@ -222,7 +219,6 @@ static void scx200_acb_machine(struct sc
 	iface->needs_reset = 1;
 }
 
-#ifdef POLLED_MODE
 static void scx200_acb_poll(struct scx200_acb_iface *iface)
 {
 	u8 status;
@@ -235,7 +231,7 @@ static void scx200_acb_poll(struct scx20
 			scx200_acb_machine(iface, status);
 			return;
 		}
-		msleep(10);
+		yield();
 	}
 
 	dev_err(&iface->adapter.dev, "timeout in state %s\n",
@@ -245,7 +241,6 @@ static void scx200_acb_poll(struct scx20
 	iface->result = -EIO;
 	iface->needs_reset = 1;
 }
-#endif /* POLLED_MODE */
 
 static void scx200_acb_reset(struct scx200_acb_iface *iface)
 {
@@ -335,12 +330,8 @@ static s32 scx200_acb_smbus_xfer(struct 
 	else
 		iface->state = state_address;
 
-#ifdef POLLED_MODE
 	while (iface->state != state_idle)
 		scx200_acb_poll(iface);
-#else /* POLLED_MODE */
-#error Interrupt driven mode not implemented
-#endif /* POLLED_MODE */	
 
 	if (iface->needs_reset)
 		scx200_acb_reset(iface);
-- 
1.2.4



