From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Wed, 14 Sep 2005 16:20:45 +0000
Subject: [lm-sensors] [PATCH] I2C Documentation fix
Message-Id: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: doc/functionality
=================================RCS file: /home/cvs/i2c/doc/functionality,v
retrieving revision 1.3
diff -u -r1.3 functionality
--- doc/functionality	28 Jul 2005 17:04:23 -0000	1.3
+++ doc/functionality	14 Sep 2005 14:19:25 -0000
@@ -17,8 +17,8 @@
   I2C_FUNC_I2C                    Plain i2c-level commands (Pure SMBus
                                   adapters typically can not do these)
   I2C_FUNC_10BIT_ADDR             Handles the 10-bit address extensions
-  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_REV_DIR_ADDR,
-                                  I2C_M_REV_DIR_ADDR and I2C_M_REV_DIR_NOSTART
+  I2C_FUNC_PROTOCOL_MANGLING      Knows about the I2C_M_IGNORE_NAK,
+                                  I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
                                   flags (which modify the i2c protocol!)
   I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
   I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command


----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
