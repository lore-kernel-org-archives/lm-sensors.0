From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913942653@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913941866@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.11, 2004/03/15 10:27:53-08:00, greg@kroah.com

[PATCH] I2C: fix up CONFIG_I2C_DEBUG_CORE logic to be simpler on the .c files.


 drivers/i2c/Makefile     |    4 ++++
 drivers/i2c/i2c-core.c   |    4 ----
 drivers/i2c/i2c-dev.c    |    4 ----
 drivers/i2c/i2c-sensor.c |    4 ----
 4 files changed, 4 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Mar 15 14:34:23 2004
+++ b/drivers/i2c/Makefile	Mon Mar 15 14:34:23 2004
@@ -6,3 +6,7 @@
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-y				+= busses/ chips/ algos/
+
+ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:34:23 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:34:23 2004
@@ -22,10 +22,6 @@
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CORE
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:34:23 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:34:23 2004
@@ -30,10 +30,6 @@
    <pmhahn@titan.lahn.de> */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CORE
-#define DEBUG	1
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Mon Mar 15 14:34:23 2004
+++ b/drivers/i2c/i2c-sensor.c	Mon Mar 15 14:34:23 2004
@@ -20,10 +20,6 @@
 */
 
 #include <linux/config.h>
-#ifdef CONFIG_I2C_DEBUG_CORE
-#define DEBUG	1
-#endif
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>

