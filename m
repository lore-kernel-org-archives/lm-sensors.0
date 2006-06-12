From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:49:36 +0000
Subject: [lm-sensors] [PATCH 06/14] i2c-i801: Fix block transaction poll
Message-Id: <20060612214936.d81fd1b9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-i801-01-fix-block-transaction-poll-loops.patch

i2c-i801: Fix block transaction poll loops

Two of the three poll loops have the poll and sleep swapped,
causing an extra sleep to occur after the polled condition is
fulfilled. In practice, this doubles the amount of sleep time for
every block transaction. 

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-i801.c	2006-06-07 17:59:52.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-i801.c	2006-06-08 13:25:36.000000000 +0200
@@ -334,8 +334,8 @@
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
 		do {
-			temp = inb_p(SMBHSTSTS);
 			msleep(1);
+			temp = inb_p(SMBHSTSTS);
 		}
 		    while ((!(temp & 0x80))
 			   && (timeout++ < MAX_TIMEOUT));
@@ -393,8 +393,8 @@
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
-			temp = inb_p(SMBHSTSTS);
 			msleep(1);
+			temp = inb_p(SMBHSTSTS);
 		} while ((!(temp & 0x02))
 			   && (timeout++ < MAX_TIMEOUT));
 

-- 
Jean Delvare

