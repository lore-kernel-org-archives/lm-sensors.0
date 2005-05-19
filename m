From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <107939139468@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913942653@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.12, 2004/03/15 10:28:32-08:00, greg@kroah.com

[PATCH] I2C: add CONFIG_I2C_DEBUG_ALGO to be consistant.


 drivers/i2c/Kconfig              |    9 +++++++++
 drivers/i2c/algos/Makefile       |    4 ++++
 drivers/i2c/algos/i2c-algo-bit.c |    2 --
 drivers/i2c/algos/i2c-algo-pcf.c |    2 --
 4 files changed, 13 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/Kconfig	Mon Mar 15 14:34:18 2004
@@ -46,6 +46,15 @@
 	  messages to the system log.  Select this if you are having a
 	  problem with I2C support and want to see more of what is going on.
 
+config I2C_DEBUG_ALGO
+	bool "I2C Algorithm debugging messages"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C algorithm drivers to produce a bunch
+	  of debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
 config I2C_DEBUG_BUS
 	bool "I2C Bus debugging messages"
 	depends on I2C
diff -Nru a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
--- a/drivers/i2c/algos/Makefile	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/Makefile	Mon Mar 15 14:34:18 2004
@@ -5,3 +5,7 @@
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
+
+ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/i2c-algo-bit.c	Mon Mar 15 14:34:18 2004
@@ -21,8 +21,6 @@
 /* With some changes from Frodo Looijaard <frodol@dds.nl>, Ky?sti M?lkki
    <kmalkki@cc.hut.fi> and Jean Delvare <khali@linux-fr.org> */
 
-/* #define DEBUG 1 */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	Mon Mar 15 14:34:18 2004
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	Mon Mar 15 14:34:18 2004
@@ -27,8 +27,6 @@
    messages, proper stop/repstart signaling during receive,
    added detect code */
 
-/* #define DEBUG 1 */		/* to pick up dev_dbg calls */
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>

