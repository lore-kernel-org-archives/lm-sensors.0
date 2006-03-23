From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:51 +0000
Subject: [lm-sensors] [PATCH 30/36] I2C: i2c-ali1535: Drop redundant mutex
Message-Id: <11431538313629-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop a redundant mutex in driver i2c-ali1535. The struct i2c_adapter
includes a mutex for the same purpose, operated by i2c-core.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-ali1535.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

0cbcb4d39a83d4df7e45c13b5ebd9fe73e025237
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 115a731..d3ef46a 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -62,7 +62,6 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/mutex.h>
 #include <asm/io.h>
 
 
@@ -136,7 +135,6 @@
 
 static struct pci_driver ali1535_driver;
 static unsigned short ali1535_smba;
-static DEFINE_MUTEX(i2c_ali1535_mutex);
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -345,7 +343,6 @@ static s32 ali1535_access(struct i2c_ada
 	int timeout;
 	s32 result = 0;
 
-	mutex_lock(&i2c_ali1535_mutex);
 	/* make sure SMBus is idle */
 	temp = inb_p(SMBHSTSTS);
 	for (timeout = 0;
@@ -460,7 +457,6 @@ static s32 ali1535_access(struct i2c_ada
 		break;
 	}
 EXIT:
-	mutex_unlock(&i2c_ali1535_mutex);
 	return result;
 }
 
-- 
1.2.4



