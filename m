From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:15 +0000
Subject: [lm-sensors] [PATCH 3/13] [PATCH] scx200_acb: Fix the state machine
Message-Id: <1152746852668-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Thomas Andrews <tandrews at grok.co.za>

Fix the scx200_acb state machine:

* Nack was sent one byte too late on reads >= 2 bytes.
* Stop bit was set one byte too late on reads.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/scx200_acb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 22a3eda..454086a 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -184,21 +184,21 @@ static void scx200_acb_machine(struct sc
 		break;
 
 	case state_read:
-		/* Set ACK if receiving the last byte */
-		if (iface->len = 1)
+		/* Set ACK if _next_ byte will be the last one */
+		if (iface->len = 2)
 			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
 		else
 			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
 
-		*iface->ptr++ = inb(ACBSDA);
-		--iface->len;
-
-		if (iface->len = 0) {
+		if (iface->len = 1) {
 			iface->result = 0;
 			iface->state = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		}
 
+		*iface->ptr++ = inb(ACBSDA);
+		--iface->len;
+
 		break;
 
 	case state_write:
-- 
1.4.1


