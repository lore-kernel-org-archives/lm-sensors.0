From: jordan.crouse@amd.com (Jordan Crouse)
Date: Fri, 31 Mar 2006 22:49:54 +0000
Subject: [lm-sensors] [PATCH 2.6] scx200_acb - Fix for CS5535 eratta
Message-Id: <20060331224954.GC17261@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, info-linux@ldcmail.amd.com, BGardner@Wabtec.com

Hey all - This is a fix for the recently added CS5535/CS5536 support in
the scx200_acb driver.  This works around an errata in the CS5535 that 
sometimes results in NEGACK not being cleared.  It would be great if we
could get this into 2.6.17 with the driver.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
-------------- next part --------------
[PATCH] scx200_acb: Fix for negack clear errata

From: Jordan Crouse <jordan.crouse at amd.com>

This patch is a fix for the CS5535 errata 111:

When the SMB controller tries to access a non-existing device, it sets
the NEGACK bit, SMB I/O Offset 01h[4], to 1 after it detects no
acknowledge at the ninth clock. The specification says there are only
two ways to clear this status bit: write 1 to this bit or disable the
SMB controller. Sometimes this bit is cleared by a read of this
register, but not always.

Signed-off-by: Jordan Crouse <jordan.crouse at amd.com>
---

 drivers/i2c/busses/scx200_acb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 8bd305e..e7a2225 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -133,6 +133,9 @@ static void scx200_acb_machine(struct sc
 
 		outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+
+		/* Reset the status register */
+		outb(0, ACBST);
 		return;
 	}
 
@@ -228,6 +231,10 @@ static void scx200_acb_poll(struct scx20
 	timeout = jiffies + POLL_TIMEOUT;
 	while (time_before(jiffies, timeout)) {
 		status = inb(ACBST);
+
+		/* Reset the status register to avoid the hang */
+		outb(0, ACBST);
+
 		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
 			scx200_acb_machine(iface, status);
 			return;
