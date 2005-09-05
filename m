From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:17 +0000
Subject: [lm-sensors] [PATCH] I2C: Drop the I2C_ACK_TEST ioctl
Message-Id: <11259567722697@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Drop the I2C_ACK_TEST ioctl

Drop the I2C_ACK_TEST ioctl, which was commented out. It never really
existed (not after 1999 anyway), and there is no such thing as a ack
test on I2C/SMBus anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 77ae84554cc0178e03862391599a0cedf96fa4c4
tree 8cfd81bdceb3720be7a96084c65019912e8b3e89
parent 11be27ea9bfd0ea7bca797ba6937285d18d426c2
author Jean Delvare <khali@linux-fr.org> Sat, 03 Sep 2005 10:52:11 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:56 -0700

 include/linux/i2c.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -508,9 +508,6 @@ union i2c_smbus_data {
 #define I2C_FUNCS	0x0705	/* Get the adapter functionality */
 #define I2C_RDWR	0x0707	/* Combined R/W transfer (one stop only)*/
 #define I2C_PEC		0x0708	/* != 0 for SMBus PEC                   */
-#if 0
-#define I2C_ACK_TEST	0x0710	/* See if a slave is at a specific address */
-#endif
 
 #define I2C_SMBUS	0x0720	/* SMBus-level access */
 

