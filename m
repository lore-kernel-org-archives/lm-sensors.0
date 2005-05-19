From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix i2c busses warnings with DEBUG
Message-Id: <20040118124027.00622b74.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Greg,

Two bus drivers (i2c-via and scx200_acb.c) generate warnings when the
whole i2c subsystem is compiled with -DDEBUG. Suggested changes follow.

diff -ru linux-2.6.1-k1/drivers/i2c/busses/i2c-via.c linux-2.6.1-k3/drivers/i2c/busses/i2c-via.c
--- linux-2.6.1-k1/drivers/i2c/busses/i2c-via.c	Thu Dec 18 03:58:56 2003
+++ linux-2.6.1-k3/drivers/i2c/busses/i2c-via.c	Sun Jan 18 12:22:37 2004
@@ -21,7 +21,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#define DEBUG
+/* #define DEBUG */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -ru linux-2.6.1-k1/drivers/i2c/busses/scx200_acb.c linux-2.6.1-k3/drivers/i2c/busses/scx200_acb.c
--- linux-2.6.1-k1/drivers/i2c/busses/scx200_acb.c	Thu Dec 18 03:58:49 2003
+++ linux-2.6.1-k3/drivers/i2c/busses/scx200_acb.c	Sun Jan 18 12:20:32 2004
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


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
