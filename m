From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Sep 2005 10:52:18 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Drop the I2C_ACK_TEST ioctl
Message-Id: <20050903105211.5907174a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Drop the I2C_ACK_TEST ioctl, which was commented out. It never really
existed (not after 1999 anyway), and there is no such thing as a ack
test on I2C/SMBus anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.13.orig/include/linux/i2c.h	2005-09-03 10:37:31.000000000 +0200
+++ linux-2.6.13/include/linux/i2c.h	2005-09-03 10:43:35.000000000 +0200
@@ -508,9 +508,6 @@
 #define I2C_FUNCS	0x0705	/* Get the adapter functionality */
 #define I2C_RDWR	0x0707	/* Combined R/W transfer (one stop only)*/
 #define I2C_PEC		0x0708	/* != 0 for SMBus PEC                   */
-#if 0
-#define I2C_ACK_TEST	0x0710	/* See if a slave is at a specific address */
-#endif
 
 #define I2C_SMBUS	0x0720	/* SMBus-level access */
 

-- 
Jean Delvare
