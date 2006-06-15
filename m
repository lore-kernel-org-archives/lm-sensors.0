From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Jun 2006 08:11:28 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <20060615101128.b9a31a13.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Attached is a suggested patch for the i2c-nforce2 driver, applying on
> top of your own cleanup patch. Other drivers (i2c-amd8111 and the not
> yet merged i2c-acpi-ec) would need something similar. That being said,
> I doubt this will fix the hangs I was observing, as they seem to be
> caused by the hardware itself and not the i2c-nforce2 driver.

Hm, here it is:


The ACPI specification says that the length of SMBus block transactions
is stored on 5 bits. This suggests that the maximum value of 32 is encoded
as 0, so we must modify the i2c-nforce2 driver to handle this special case
properly.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-nforce2.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/i2c-nforce2.c	2006-06-15 09:16:16.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/i2c-nforce2.c	2006-06-15 09:27:51.000000000 +0200
@@ -149,7 +149,9 @@
 			outb_p(command, NVIDIA_SMB_CMD);
 			if (read_write = I2C_SMBUS_WRITE) {
 				len = min_t(u8, data->block[0], 32);
-				outb_p(len, NVIDIA_SMB_BCNT);
+				/* Block length is stored on only 5 bits
+				   internally, 0 means 32 */
+				outb_p(len & 0x1f, NVIDIA_SMB_BCNT);
 				for (i = 0; i < len; i++)
 					outb_p(data->block[i + 1], NVIDIA_SMB_DATA+i);
 			}
@@ -195,8 +197,11 @@
 			break;
 
 		case I2C_SMBUS_BLOCK_DATA:
-			len = inb_p(NVIDIA_SMB_BCNT);
-			len = min_t(u8, len, 32);
+			/* Block length is stored on only 5 bits internally,
+			   0 means 32 */
+			len = inb_p(NVIDIA_SMB_BCNT) & 0x1f;
+			if (len = 0)
+				len = 32;
 			for (i = 0; i < len; i++)
 				data->block[i+1] = inb_p(NVIDIA_SMB_DATA + i);
 			data->block[0] = len;

-- 
Jean Delvare

