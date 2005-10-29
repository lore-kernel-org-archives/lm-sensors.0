From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:11:05 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop useless CVS revision IDs
Message-Id: <11305336601376@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop useless CVS revision IDs

CVS revision IDs are totally useless and irrelevant by now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bf813b314a2271c3f3903eb3279ebf5e09b3d27a
tree da029880a66422cd5aebe0191287a215e9d273b0
parent e8aafcb2bba1fe122907161701a167e38174c7a5
author Jean Delvare <khali@linux-fr.org> Fri, 07 Oct 2005 23:09:04 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 include/linux/i2c-algo-bit.h |    2 --
 include/linux/i2c-algo-pcf.h |    2 --
 include/linux/i2c-dev.h      |    2 --
 include/linux/i2c.h          |    2 --
 4 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index 1109044..fb59214 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -21,8 +21,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.h,v 1.10 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_ALGO_BIT_H
 #define _LINUX_I2C_ALGO_BIT_H
 
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index 2a50856..a0e534b 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -22,8 +22,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-pcf.h,v 1.8 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_ALGO_PCF_H
 #define _LINUX_I2C_ALGO_PCF_H
 
diff --git a/include/linux/i2c-dev.h b/include/linux/i2c-dev.h
index 5416956..81c229a 100644
--- a/include/linux/i2c-dev.h
+++ b/include/linux/i2c-dev.h
@@ -19,8 +19,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.13 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_DEV_H
 #define _LINUX_I2C_DEV_H
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 17d63c1..ec81884 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -23,8 +23,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.68 2003/01/21 08:08:16 kmalkki Exp $ */
-
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
 

