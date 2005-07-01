From: gregkh@suse.de (gregkh@suse.de)
Date: Fri, 01 Jul 2005 23:48:01 +0000
Subject: [lm-sensors] patch i2c-dev-doc-update.patch added to gregkh-2.6 tree
Message-Id: <1DoTLa-3xg-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: Clarify the usage of i2c-dev.h

to my gregkh-2.6 tree.  Its filename is

     i2c-dev-doc-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-atxp1-build-fix.patch
i2c/i2c-dev-doc-update.patch
i2c/i2c-docs-01.patch
i2c/i2c-drop-bogus-eeprom-comment.patch
i2c/i2c-m41t00-kfree-fix.patch
i2c/i2c-max6875-Kconfig.patch
i2c/i2c-max6875-documentation.patch
i2c/i2c-max6875-may-do-bad-things.patch
i2c/i2c-string-strip.patch
i2c/i2c-tps6501x-cleanups.patch
i2c/i2c-via686a-cleanups.patch
pci/pci-quirk-asus.patch


From khali@linux-fr.org Sat Jun 25 02:39:22 2005
Date: Sat, 25 Jun 2005 11:37:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Nils Roeder <nroeder@inf.ed.ac.uk>
Subject: I2C: Clarify the usage of i2c-dev.h
Message-Id: <20050625113740.29b08918.khali@linux-fr.org>

Upon suggestion by Nils Roeder, here is an update to the i2c
documentation to clarify which header files user-space applications
relying on the i2c-dev interface should include.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/i2c/dev-interface |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/Documentation/i2c/dev-interface	2005-07-01 14:44:13.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/dev-interface	2005-07-01 14:44:14.000000000 -0700
@@ -14,9 +14,12 @@
 ==== 
 So let's say you want to access an i2c adapter from a C program. The
-first thing to do is `#include <linux/i2c.h>" and "#include <linux/i2c-dev.h>. 
-Yes, I know, you should never include kernel header files, but until glibc 
-knows about i2c, there is not much choice.
+first thing to do is "#include <linux/i2c-dev.h>". Please note that
+there are two files named "i2c-dev.h" out there, one is distributed
+with the Linux kernel and is meant to be included from kernel
+driver code, the other one is distributed with lm_sensors and is
+meant to be included from user-space programs. You obviously want
+the second one here.
 
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
@@ -78,7 +81,7 @@
 =============
 
 The following IOCTLs are defined and fully supported 
-(see also i2c-dev.h and i2c.h):
+(see also i2c-dev.h):
 
 ioctl(file,I2C_SLAVE,long addr)
   Change slave address. The address is passed in the 7 lower bits of the
