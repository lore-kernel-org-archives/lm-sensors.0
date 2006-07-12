From: greg@kroah.com (Greg KH)
Date: Wed, 12 Jul 2006 23:27:21 +0000
Subject: [lm-sensors] [PATCH 9/13] [PATCH] i2c-algo-bit: Wipe out dead code
Message-Id: <11527468711986-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Uwe Bugla <uwe.bugla at gmx.de>

i2c-algo-bit: Wipe out dead code

Signed-off-by: Uwe Bugla <uwe.bugla at gmx.de>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/algos/i2c-algo-bit.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 3d6fc82..ab230c0 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -372,7 +372,6 @@ static inline int readbytes(struct i2c_a
 
 	while (count > 0) {
 		inval = i2c_inb(i2c_adap);
-/*printk("%#02x ",inval); if ( ! (count % 16) ) printk("\n"); */
 		if (inval>=0) {
 			*temp = inval;
 			rdcount++;
-- 
1.4.1


