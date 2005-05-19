From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: [PATCH 2.6] i2c bus drivers (2/4)
Message-Id: <20031129211021.3626bd06.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes i2c_smbus_write_byte() being broken for i2c-nforce2.
This causes trouble when that module is used together with eeprom (which
is also in 2.6). We have had three user reports about the problem.

Credits go to Mark D. Studebaker for finding and fixing the problem. We
have also been contacting the module author (Hans-Frieder Vogt) but had
no answer so far.

This is a serious bug fix, and I believe you shouldn't wait too long
before applying it.

--- linux-2.6.0-test11/drivers/i2c/busses/i2c-nforce2.c.orig	Sat Oct 25 20:43:02 2003
+++ linux-2.6.0-test11/drivers/i2c/busses/i2c-nforce2.c	Fri Nov 28 21:49:21 2003
@@ -147,7 +147,7 @@
 
 		case I2C_SMBUS_BYTE:
 			if (read_write = I2C_SMBUS_WRITE)
-				outb_p(data->byte, NVIDIA_SMB_DATA);
+				outb_p(command, NVIDIA_SMB_CMD);
 			protocol |= NVIDIA_SMB_PRTCL_BYTE;
 			break;
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
