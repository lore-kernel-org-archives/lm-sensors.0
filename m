From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:57:14 +0000
Subject: [lm-sensors] [PATCH] (11/13) i2c: Fix union i2c_smbus_data
Message-Id: <20050925165643.151d5da1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The i2c_smbus_data union block member has a comment stating that an
extra byte is required for SMBus Block Process Call transactions. This
has been true for three weeks around June 2002, but no more since, so
it is about time that we drop this comment and fix the definition.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.14-rc2.orig/include/linux/i2c.h	2005-09-25 09:03:34.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c.h	2005-09-25 14:55:39.000000000 +0200
@@ -454,8 +454,7 @@
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;
-	__u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
-                          /* one more for read length in block process call */
+	__u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
 	                                            /* and one more for PEC */
 };
 

-- 
Jean Delvare
