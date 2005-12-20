From: gardner.ben@gmail.com (Ben Gardner)
Date: Tue, 20 Dec 2005 23:02:44 +0000
Subject: [lm-sensors] [PATCH 6/7] i2c: scx200_acb - fix poll loop
Message-Id: <808c8e9d0512201502i538a4a74wdbc483377dff9d4c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191059h1cae3745k2a77b32f56ac2349@mail.gmail.com>
In-Reply-To: <808c8e9d0512191059h1cae3745k2a77b32f56ac2349@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb: Fix and speed up the poll loop

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
---
This is the second version of the series.
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

--- linux-2.6.15-rc5-mm3.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm3/drivers/i2c/busses/scx200_acb.c
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
