From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:40 +0000
Subject: [lm-sensors] [PATCH 9/30] i2c-au1550: Fix timeout problem
Message-Id: <11593189491224-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Domen Puncer <domen.puncer at ultra.si>

i2c-au1550: Fix timeout problem

Fix from Jordan Crouse:
If the transmit and recieve FIFOS are not empty, forceably flush them
rather then waiting for them to drain on their own.

This solves at least a problem reported by Clem Taylor:
http://www.linux-mips.org/archives/linux-mips/2006-05/msg00240.html
(1% of I2C transactions would timeout)

Signed-off-by: Domen Puncer <domen.puncer at ultra.si>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-au1550.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index d06edce..02a359e 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -118,13 +118,19 @@ do_address(struct i2c_au1550_data *adap,
 
 	/* Reset the FIFOs, clear events.
 	*/
-	sp->psc_smbpcr = PSC_SMBPCR_DC;
+	stat = sp->psc_smbstat;
 	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
 	au_sync();
-	do {
-		stat = sp->psc_smbpcr;
+
+	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
+		sp->psc_smbpcr = PSC_SMBPCR_DC;
 		au_sync();
-	} while ((stat & PSC_SMBPCR_DC) != 0);
+		do {
+			stat = sp->psc_smbpcr;
+			au_sync();
+		} while ((stat & PSC_SMBPCR_DC) != 0);
+		udelay(50);
+	}
 
 	/* Write out the i2c chip address and specify operation
 	*/
-- 
1.4.2.1


