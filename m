From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734213872@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734201540@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.6, 2003/09/15 16:44:07-07:00, greg@kroah.com

[PATCH] I2C: turn off debugging on the new sis i2c bus drivers.

Forgot to do this before...


 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 drivers/i2c/busses/i2c-sis630.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:15:15 2003
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Sep 22 16:15:15 2003
@@ -55,7 +55,7 @@
  * Add adapter resets
  */
 
-#define DEBUG
+/* #define DEBUG 1 */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:15:15 2003
+++ b/drivers/i2c/busses/i2c-sis630.c	Mon Sep 22 16:15:15 2003
@@ -48,7 +48,7 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#define DEBUG
+/* #define DEBUG 1 */
 
 #include <linux/kernel.h>
 #include <linux/module.h>

