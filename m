From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH ] LM87: Add code to retry reads on error
Message-Id: <23812885.1096307898769.JavaMail.root@huey.psp.pas.earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds code to retry if there are any read errors.   This code has been copied almost verbatim from the LM93 driver (Thanks, Mark!).  

Just as in the LM93, it's not clear what the right thing would be to do if the retries all fail, so I return 0, just as the LM93 does.

David

--- lm_sensors/kernel/chips/lm87.c.orig	2004-09-27 13:00:26.000000000 -0400
+++ lm_sensors/kernel/chips/lm87.c	2004-09-27 13:19:23.000000000 -0400
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-proc.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include "version.h"
 #include "sensors_vid.h"
 
@@ -487,7 +488,7 @@
 
 	if ((err = i2c_detach_client(client))) {
 		printk
-		    ("lm87.o: Client deregistration failed, client not detached.\n");
+		    (KERN_ERR "lm87.o: Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
@@ -496,9 +497,26 @@
 	return 0;
 }
 
+#define MAX_RETRIES 5
+
 static int lm87_read_value(struct i2c_client *client, u8 reg)
 {
-	return 0xFF & i2c_smbus_read_byte_data(client, reg);
+	int value, i;
+
+	/* retry in case of read errors */
+	for (i=1; i<=MAX_RETRIES; i++) {
+		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
+			return value;
+		} else {
+			printk(KERN_WARNING "lm87.o: read byte data failed, "
+				"address 0x%02x.\n", reg);
+			mdelay(i);
+		}
+
+	}
+
+	/* <TODO> what to return in case of error? */
+	return 0;
 }
 
 static int lm87_write_value(struct i2c_client *client, u8 reg, u8 value)
@@ -964,7 +982,7 @@
 
 static int __init sm_lm87_init(void)
 {
-	printk("lm87.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk(KERN_INFO "lm87.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&LM87_driver);
 }
 
