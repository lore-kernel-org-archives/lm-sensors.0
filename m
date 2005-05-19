From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567653686@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567653998@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.22, 2004/01/19 12:50:11-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c busses warnings with DEBUG

Two bus drivers (i2c-via and scx200_acb.c) generate warnings when the
whole i2c subsystem is compiled with -DDEBUG. Suggested changes follow.


 drivers/i2c/busses/i2c-via.c    |    2 +-
 drivers/i2c/busses/scx200_acb.c |    6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Jan 19 15:29:00 2004
+++ b/drivers/i2c/busses/i2c-via.c	Mon Jan 19 15:29:00 2004
@@ -21,7 +21,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#define DEBUG
+/* #define DEBUG */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	Mon Jan 19 15:29:00 2004
+++ b/drivers/i2c/busses/scx200_acb.c	Mon Jan 19 15:29:00 2004
@@ -47,9 +47,7 @@
 MODULE_PARM(base, "1-4i");
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
-#define DEBUG 0
-
-#if DEBUG
+#ifdef DEBUG
 #define DBG(x...) printk(KERN_DEBUG NAME ": " x)
 #else
 #define DBG(x...)
@@ -374,7 +372,7 @@
 	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && rw = I2C_SMBUS_READ)
 	    	data->word = le16_to_cpu(cur_word);
 
-#if DEBUG
+#ifdef DEBUG
 	printk(KERN_DEBUG NAME ": transfer done, result: %d", rc);
 	if (buffer) {
 		int i;

