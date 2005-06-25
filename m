From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 25 Jun 2005 11:38:05 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Clarify the usage of i2c-dev.h
Message-Id: <20050625113740.29b08918.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Upon suggestion by Nils Roeder, here is an update to the i2c
documentation to clarify which header files user-space applications
relying on the i2c-dev interface should include.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/dev-interface |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.12-git5.orig/Documentation/i2c/dev-interface	2004-12-24 22:34:00.000000000 +0100
+++ linux-2.6.12-git5/Documentation/i2c/dev-interface	2005-06-25 11:19:19.000000000 +0200
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


-- 
Jean Delvare
