From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Aug 2005 18:44:06 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: Off-by-one error in fscpos driver
Message-Id: <20050825184337.5eafe364.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Stefan Ott <stefan@desire.ch>, Greg KH <greg@kroah.com>

Hi Linus, all,

Coverity uncovered an off-by-one error in the fscpos driver, in function
set_temp_reset(). Writing to the temp3_reset sysfs file will lead to an
array overrun, in turn causing an I2C write to a random register of the
FSC Poseidon chip. Additionally, writing to temp1_reset and temp2_reset
will not work as expected. The fix is straightforward.

This patch is a candidate for 2.6.13 (or 2.6.13.1 if it's too late for
2.6.13.)

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/fscpos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc7.orig/drivers/hwmon/fscpos.c	2005-08-25 18:21:37.000000000 +0200
+++ linux-2.6.13-rc7/drivers/hwmon/fscpos.c	2005-08-25 18:22:09.000000000 +0200
@@ -167,7 +167,7 @@
 				"experience to the module author.\n");
 
 	/* Supported value: 2 (clears the status) */
-	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr], 2);
+	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr - 1], 2);
 	return count;
 }
 

-- 
Jean Delvare
