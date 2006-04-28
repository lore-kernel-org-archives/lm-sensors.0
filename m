From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Apr 2006 20:53:30 +0000
Subject: [lm-sensors] [PATCH] scx200_acb: Fix for the CS5535 errata
Message-Id: <20060428225330.8f95903f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This should go in 2.6.17.

From: Jordan Crouse <jordan.crouse at amd.com>
Content-Disposition: inline; filename=i2c-scx200_acb-fix-for-cs5535-errata.patch

This is a fix for the CS5535 errata 111:

When the SMBus controller tries to access a non-existing device, it sets
the NEGACK bit, SMBus I/O offset 01h[4], to 1 after it detects no
acknowledge at the ninth clock.  The specification states that the bit
can be cleared by writing a 1 to it, but under certain circumstances it
is possible for this bit to not clear.  

Writing a 0 to the bit resets the internal state machine and clears
the issue.

Since all writable bits in ACBST are W1C bits (write-one-to-clear)
the second write doesn't affect any other logic except the buggy 
NEGACK state machine. The second write clears an internal register
which is responsible for "overwriting" the NEGACK bit in ACBST. 

Signed-off-by: Jordan Crouse <jordan.crouse at amd.com>
Signed-off-by: Andrew Morton <akpm at osdl.org>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---

 drivers/i2c/busses/scx200_acb.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/i2c/busses/scx200_acb.c~scx200_acb-fix-for-cs5535-eratta drivers/i2c/busses/scx200_acb.c
--- devel/drivers/i2c/busses/scx200_acb.c~scx200_acb-fix-for-cs5535-eratta	2006-04-01 16:32:47.000000000 -0800
+++ devel-akpm/drivers/i2c/busses/scx200_acb.c	2006-04-01 16:32:47.000000000 -0800
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


-- 
Jean Delvare

