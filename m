From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.6] I2C: Kill unused includes in i2c-sensor-detect.c
Message-Id: <20050128225919.09d0ce09.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Looks to me like i2c-sensor-detect.c includes a handful of headers it
doesn't need at all. This patch removes them.

Please confirm that I am doing the right thing :)
Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc2/drivers/i2c/i2c-sensor-detect.c.orig	2004-12-24 22:34:49.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/i2c-sensor-detect.c	2005-01-28 22:51:09.000000000 +0100
@@ -19,17 +19,10 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
-#include <linux/sysctl.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <asm/uaccess.h>
 
 static unsigned short empty[] = {I2C_CLIENT_END};
 static unsigned int empty_isa[] = {I2C_CLIENT_ISA_END};


-- 
Jean Delvare
http://khali.linux-fr.org/
