From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Aug 2005 13:28:35 +0000
Subject: [lm-sensors] Possible off-by-one error in fscpos
Message-Id: <20050825132807.165a85bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

Coverity uncovered a possible off-by-one error in your Linux 2.6 fscpos
driver, in function set_temp_reset. I believe it is correct, and the fix
is probably as simple as:

 drivers/hwmon/fscpos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc7.orig/drivers/hwmon/fscpos.c	2005-08-24 21:37:02.000000000 +0200
+++ linux-2.6.13-rc7/drivers/hwmon/fscpos.c	2005-08-25 13:23:13.000000000 +0200
@@ -168,7 +168,7 @@
 				"experience to the module author.\n");
 
 	/* Supported value: 2 (clears the status) */
-	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr], 2);
+	fscpos_write_value(client, FSCPOS_REG_TEMP_STATE[nr - 1], 2);
 	return count;
 }
 

Can you please comment on this, confirm the problem and solution, and
test the patch?

Thanks,
-- 
Jean Delvare
