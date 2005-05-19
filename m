From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] more i2c bus drivers (1/2)
Message-Id: <20031205221443.482486b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes i2c_smbus_write_byte() being broken for i2c-amd8111.
This causes trouble when that module is used together with eeprom (which
is also in 2.6). We have had no report so far, but the problem is
similar to the one addressed by a recent patch to i2c-nforce2.

Credits go to Hans-Frieder Vogt for finding and fixing the problem. Mark
D. Studebaker found and fixed the original problem in i2c-nforce2.

This is a serious bug fix, and I believe you shouldn't wait too long
before applying it.

--- linux-2.6.0-test11/drivers/i2c/busses/i2c-amd8111.c.orig	Sat Oct 25 20:44:33 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/i2c-amd8111.c	Mon Dec  1 21:06:43 2003
@@ -192,7 +192,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write = I2C_SMBUS_WRITE)
-				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+				amd_ec_write(smbus, AMD_SMB_CMD, command);
 			protocol |= AMD_SMB_PRTCL_BYTE;
 			break;
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
