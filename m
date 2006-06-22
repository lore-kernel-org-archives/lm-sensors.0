From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:28:01 +0000
Subject: [lm-sensors] [PATCH 35/44] [PATCH] i2c-i801: Fix block transaction
Message-Id: <11510010333805-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-i801: Fix block transaction poll loops

Two of the three poll loops have the poll and sleep swapped,
causing an extra sleep to occur after the polled condition is
fulfilled. In practice, this doubles the amount of sleep time for
every block transaction.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-i801.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index dfca749..4396dc9 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -334,8 +334,8 @@ static int i801_block_transaction(union 
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
 		do {
-			temp = inb_p(SMBHSTSTS);
 			msleep(1);
+			temp = inb_p(SMBHSTSTS);
 		}
 		    while ((!(temp & 0x80))
 			   && (timeout++ < MAX_TIMEOUT));
@@ -393,8 +393,8 @@ static int i801_block_transaction(union 
 		/* wait for INTR bit as advised by Intel */
 		timeout = 0;
 		do {
-			temp = inb_p(SMBHSTSTS);
 			msleep(1);
+			temp = inb_p(SMBHSTSTS);
 		} while ((!(temp & 0x02))
 			   && (timeout++ < MAX_TIMEOUT));
 
-- 
1.4.0


