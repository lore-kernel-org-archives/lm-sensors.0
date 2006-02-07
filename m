From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 07 Feb 2006 16:19:14 +0000
Subject: [lm-sensors] [PATCH] i2c-amd756: Improve mutex initialization
Message-Id: <20060207171914.2b3bd201.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am adding the following patch to my stack.

Static mutexes can be initialized at declaration time.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.16-rc2.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2006-02-07 10:56:24.000000000 +0100
+++ linux-2.6.16-rc2/drivers/i2c/busses/i2c-amd756-s4882.c	2006-02-07 10:57:17.000000000 +0100
@@ -46,7 +46,7 @@
 static struct i2c_algorithm *s4882_algo;
 
 /* Wrapper access functions for multiplexed SMBus */
-static struct mutex amd756_lock;
+static DEFINE_MUTEX(amd756_lock);
 
 static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
 			       unsigned short flags, char read_write,
@@ -167,8 +167,6 @@
 	}
 
 	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
-	mutex_init(&amd756_lock);
-
 	/* Define the 5 virtual adapters and algorithms structures */
 	if (!(s4882_adapter = kzalloc(5 * sizeof(struct i2c_adapter),
 				      GFP_KERNEL))) {


-- 
Jean Delvare

