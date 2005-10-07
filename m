From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 23:09:38 +0000
Subject: [lm-sensors] [PATCH 03/16] i2c: Drop useless CVS revision IDs
Message-Id: <20051007230904.1a956707.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CVS revision IDs are totally useless and irrelevant by now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c-algo-bit.h |    2 --
 include/linux/i2c-algo-pcf.h |    2 --
 include/linux/i2c-dev.h      |    2 --
 include/linux/i2c.h          |    2 --
 4 files changed, 8 deletions(-)

--- linux-2.6.14-rc2.orig/include/linux/i2c-algo-bit.h	2005-09-30 20:45:18.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c-algo-bit.h	2005-09-30 20:48:44.000000000 +0200
@@ -21,8 +21,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.h,v 1.10 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_ALGO_BIT_H
 #define _LINUX_I2C_ALGO_BIT_H
 
--- linux-2.6.14-rc2.orig/include/linux/i2c-algo-pcf.h	2005-09-30 20:45:18.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c-algo-pcf.h	2005-09-30 20:48:44.000000000 +0200
@@ -22,8 +22,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-pcf.h,v 1.8 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_ALGO_PCF_H
 #define _LINUX_I2C_ALGO_PCF_H
 
--- linux-2.6.14-rc2.orig/include/linux/i2c-dev.h	2005-09-30 20:45:18.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c-dev.h	2005-09-30 20:48:44.000000000 +0200
@@ -19,8 +19,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.13 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_DEV_H
 #define _LINUX_I2C_DEV_H
 
--- linux-2.6.14-rc2.orig/include/linux/i2c.h	2005-09-30 20:45:18.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c.h	2005-09-30 20:48:44.000000000 +0200
@@ -23,8 +23,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.68 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
 

-- 
Jean Delvare
