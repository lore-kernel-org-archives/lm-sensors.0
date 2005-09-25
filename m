From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:53:34 +0000
Subject: [lm-sensors] [PATCH] (10/13) i2c: Fix I2C_FUNC_PROTOCOL_MANGLING
Message-Id: <20050925165304.159076c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix the description of I2C_FUNC_PROTOCOL_MANGLING.

From: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/functionality |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc2.orig/Documentation/i2c/functionality	2005-09-25 09:03:34.000000000 +0200
+++ linux-2.6.14-rc2/Documentation/i2c/functionality	2005-09-25 14:54:45.000000000 +0200
@@ -17,9 +17,10 @@
   I2C_FUNC_I2C                    Plain i2c-level commands (Pure SMBus
                                   adapters typically can not do these)
   I2C_FUNC_10BIT_ADDR             Handles the 10-bit address extensions
-  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_REV_DIR_ADDR,
-                                  I2C_M_REV_DIR_ADDR and I2C_M_REV_DIR_NOSTART
-                                  flags (which modify the i2c protocol!)
+  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_IGNORE_NAK,
+                                  I2C_M_REV_DIR_ADDR, I2C_M_NOSTART and
+                                  I2C_M_NO_RD_ACK flags (which modify the
+                                  I2C protocol!)
   I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
   I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
   I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command

-- 
Jean Delvare
