From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH] drivers/i2c/*: #include <linux/config.h> cleanup
Message-Id: <20050416184922.7c09d848.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> Files that don't use CONFIG_* stuff shouldn't include config.h
> Files that use CONFIG_* stuff should include config.h
>
> It's that simple. ;-)

I agree. This won't change anything though, as all drivers include
either device.h or module.h, which in turn include config.h. But you are
still correct, so I approve your patch.

For completeness, I would propose the following on top of your own
patch:

i2c bus drivers do not need to define DEBUG themselves, as the Kconfig
system takes care of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

Index: linux-2.6.12-rc2/drivers/i2c/busses/i2c-ixp2000.c
=================================--- linux-2.6.12-rc2.orig/drivers/i2c/busses/i2c-ixp2000.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.12-rc2/drivers/i2c/busses/i2c-ixp2000.c	2005-04-16 18:41:14.000000000 +0200
@@ -26,11 +26,6 @@
  * 'enabled' to drive the GPIOs.
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
Index: linux-2.6.12-rc2/drivers/i2c/busses/i2c-ixp4xx.c
=================================--- linux-2.6.12-rc2.orig/drivers/i2c/busses/i2c-ixp4xx.c	2005-04-06 19:42:31.000000000 +0200
+++ linux-2.6.12-rc2/drivers/i2c/busses/i2c-ixp4xx.c	2005-04-16 18:41:00.000000000 +0200
@@ -26,11 +26,6 @@
  *       that is passed as the platform_data to this driver.
  */
 
-#include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_BUS
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>



-- 
Jean Delvare
