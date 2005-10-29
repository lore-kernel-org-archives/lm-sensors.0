From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:15:52 +0000
Subject: [lm-sensors] [PATCH] i2c: Fix union i2c_smbus_data definition
Message-Id: <11305336582121@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Fix union i2c_smbus_data definition

The i2c_smbus_data union block member has a comment stating that an
extra byte is required for SMBus Block Process Call transactions. This
has been true for three weeks around June 2002, but no more since, so
it is about time that we drop this comment and fix the definition.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 include/linux/i2c.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

---
commit 332bf92b3338e140cbcfc25f69911e8ca59788c7
tree d6d8a3ee39fc08a3bc23b76c62403dbfe0fad36d
parent d057c96cab72bc6b70570d25b90404f81d98e886
author Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp> Sun, 25 Sep 2005 16:56:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:07 -0700

 include/linux/i2c.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 3d49a30..17d63c1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -454,8 +454,7 @@ struct i2c_msg {
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;
-	__u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
-                          /* one more for read length in block process call */
+	__u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
 	                                            /* and one more for PEC */
 };
 

