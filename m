From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:21:09 +0000
Subject: [lm-sensors] [PATCH 08/16] i2c: i2c-i810 documentation update
Message-Id: <20051026212150.010e7472.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-i810-update-device-list.patch

Update the documented list of devices supported by the i2c-i810
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 Documentation/i2c/busses/i2c-i810 |    1 +
 drivers/i2c/busses/Kconfig        |    3 ++-
 drivers/i2c/busses/i2c-i810.c     |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc4.orig/Documentation/i2c/busses/i2c-i810	2005-08-29 20:33:28.000000000 +0200
+++ linux-2.6.14-rc4/Documentation/i2c/busses/i2c-i810	2005-10-22 18:09:10.000000000 +0200
@@ -2,6 +2,7 @@
 
 Supported adapters:
   * Intel 82810, 82810-DC100, 82810E, and 82815 (GMCH)
+  * Intel 82845G (GMCH)
 
 Authors: 
 	Frodo Looijaard <frodol@dds.nl>, 
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/Kconfig	2005-10-22 18:02:36.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/Kconfig	2005-10-22 18:08:11.000000000 +0200
@@ -135,11 +135,12 @@
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
--- linux-2.6.14-rc4.orig/drivers/i2c/busses/i2c-i810.c	2005-10-17 20:33:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-i810.c	2005-10-22 18:07:07.000000000 +0200
@@ -32,6 +32,7 @@
    i810AB		7123           
    i810E		7125           
    i815			1132           
+   i845G		2562
 */
 
 #include <linux/kernel.h>

-- 
Jean Delvare
