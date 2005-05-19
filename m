From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <1074556768838@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567681965@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.29, 2004/01/19 15:17:17-08:00, greg@kroah.com

[PATCH] I2C: remove unneeded CVS Id: lines.


 drivers/i2c/algos/i2c-algo-pcf.h     |    2 --
 drivers/i2c/busses/i2c-philips-par.c |    2 --
 drivers/i2c/busses/i2c-velleman.c    |    2 --
 drivers/i2c/i2c-core.c               |    2 --
 4 files changed, 8 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.h b/drivers/i2c/algos/i2c-algo-pcf.h
--- a/drivers/i2c/algos/i2c-algo-pcf.h	Mon Jan 19 15:27:31 2004
+++ b/drivers/i2c/algos/i2c-algo-pcf.h	Mon Jan 19 15:27:31 2004
@@ -21,8 +21,6 @@
 
 /* With some changes from Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
-
 #ifndef I2C_PCF8584_H
 #define I2C_PCF8584_H 1
 
diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Mon Jan 19 15:27:31 2004
+++ b/drivers/i2c/busses/i2c-philips-par.c	Mon Jan 19 15:27:31 2004
@@ -21,8 +21,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #include <linux/config.h>
 #ifdef CONFIG_I2C_DEBUG_BUS
 #define DEBUG	1
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Jan 19 15:27:31 2004
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Jan 19 15:27:31 2004
@@ -18,8 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-velleman.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #include <linux/config.h>
 #ifdef CONFIG_I2C_DEBUG_BUS
 #define DEBUG	1
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Jan 19 15:27:31 2004
+++ b/drivers/i2c/i2c-core.c	Mon Jan 19 15:27:31 2004
@@ -21,8 +21,6 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-/* $Id: i2c-core.c,v 1.95 2003/01/22 05:25:08 kmalkki Exp $ */
-
 #include <linux/config.h>
 #ifdef CONFIG_I2C_DEBUG_CORE
 #define DEBUG	1

