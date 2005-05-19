From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (2/3)
Message-Id: <20050501195005.41c99f62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Corey Minyard <minyard@acm.org>

Fix I2C_FUNC_* defines in i2c.h. These defines lack surrounding
parentheses, which might cause unexpected results where used. These were
originally fixed by Corey Minyard in Linux 2.6.

http://marc.theaimsgroup.com/?l=linux-kernel&m0928784629301
http://linux.bkbits.net:8080/linux-2.5/diffs/include/linux/i2c.h@1.48

--- linux-2.4.30-rc1/include/linux/i2c.h.orig	2005-03-19 13:17:40.000000000 +0100
+++ linux-2.4.30-rc1/include/linux/i2c.h	2005-03-19 13:22:52.000000000 +0100
@@ -390,23 +390,23 @@
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* New I2C-like block */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* transfer */
 
-#define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
-                            I2C_FUNC_SMBUS_WRITE_BYTE
-#define I2C_FUNC_SMBUS_BYTE_DATA I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_WORD_DATA I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BLOCK_DATA I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
-#define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
+#define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
+                             I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA (I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA (I2C_FUNC_SMBUS_READ_WORD_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA (I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+
+#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
+                             I2C_FUNC_SMBUS_BYTE | \
+                             I2C_FUNC_SMBUS_BYTE_DATA | \
+                             I2C_FUNC_SMBUS_WORD_DATA | \
+                             I2C_FUNC_SMBUS_PROC_CALL | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
 
 /* 
  * Data for SMBus Messages 


-- 
Jean Delvare
