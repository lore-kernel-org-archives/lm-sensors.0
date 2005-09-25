From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:58:54 +0000
Subject: [lm-sensors] [PATCH] (12/13) i2c: Minor i2c-amd8111 cleanup
Message-Id: <20050925165822.3421429b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I noticed a useless instruction in the i2c-amd8111 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
CC: Vojtech Pavlik <vojtech@suse.cz>

 drivers/i2c/busses/i2c-amd8111.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.14-rc2.orig/drivers/i2c/busses/i2c-amd8111.c	2005-09-25 14:38:01.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/busses/i2c-amd8111.c	2005-09-25 14:58:13.000000000 +0200
@@ -244,7 +244,6 @@
 			break;
 
 		case I2C_SMBUS_BLOCK_PROC_CALL:
-			protocol |= pec;
 			len = min_t(u8, data->block[0], 31);
 			amd_ec_write(smbus, AMD_SMB_CMD, command);
 			amd_ec_write(smbus, AMD_SMB_BCNT, len);

-- 
Jean Delvare
