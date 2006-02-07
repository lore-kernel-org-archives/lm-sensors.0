From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 07 Feb 2006 16:17:45 +0000
Subject: [lm-sensors] [PATCH] i2c-ali1535: Drop redundant mutex
Message-Id: <20060207171745.3fee3620.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am adding the following patch to my stack.

Drop a redundant mutex in driver i2c-ali1535. The struct i2c_adapter
includes a mutex for the same purpose, operated by i2c-core.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-ali1535.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.16-rc2.orig/drivers/i2c/busses/i2c-ali1535.c	2006-02-07 09:15:08.000000000 +0100
+++ linux-2.6.16-rc2/drivers/i2c/busses/i2c-ali1535.c	2006-02-07 10:04:44.000000000 +0100
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
@@ -345,7 +343,6 @@
 	int timeout;
 	s32 result = 0;
 
-	mutex_lock(&i2c_ali1535_mutex);
 	/* make sure SMBus is idle */
 	temp = inb_p(SMBHSTSTS);
 	for (timeout = 0;
@@ -460,7 +457,6 @@
 		break;
 	}
 EXIT:
-	mutex_unlock(&i2c_ali1535_mutex);
 	return result;
 }
 


-- 
Jean Delvare

