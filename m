From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:12:45 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-i810 documentation update
Message-Id: <1130533663595@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-i810 documentation update

Update the documented list of devices supported by the i2c-i810
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 142078f6f09986c2b8f5ebe215ce405438080317
tree 4dbfcd958b06e3935ba64f3ba6bbbd12c5b26f5b
parent eb00a28ae1a8fc4b3914f94ab1944396b8dda9fc
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 21:21:50 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 Documentation/i2c/busses/i2c-i810 |    1 +
 drivers/i2c/busses/Kconfig        |    3 ++-
 drivers/i2c/busses/i2c-i810.c     |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-i810 b/Documentation/i2c/busses/i2c-i810
index 0544eb3..83c3b97 100644
--- a/Documentation/i2c/busses/i2c-i810
+++ b/Documentation/i2c/busses/i2c-i810
@@ -2,6 +2,7 @@ Kernel driver i2c-i810
 
 Supported adapters:
   * Intel 82810, 82810-DC100, 82810E, and 82815 (GMCH)
+  * Intel 82845G (GMCH)
 
 Authors: 
 	Frodo Looijaard <frodol@dds.nl>, 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 3badfec..4010fe9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -135,11 +135,12 @@ config I2C_I810
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  810/815 family of mainboard I2C interfaces.  Specifically, the 
-	  following versions of the chipset is supported:
+	  following versions of the chipset are supported:
 	    i810AA
 	    i810AB
 	    i810E
 	    i815
+	    i845G
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i810.
diff --git a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
index 1b3393b..52bc305 100644
--- a/drivers/i2c/busses/i2c-i810.c
+++ b/drivers/i2c/busses/i2c-i810.c
@@ -32,6 +32,7 @@
    i810AB		7123           
    i810E		7125           
    i815			1132           
+   i845G		2562
 */
 
 #include <linux/kernel.h>

