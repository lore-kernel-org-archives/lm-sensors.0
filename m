From: Roman Fietze <roman.fietze@telemotive.de>
Date: Mon, 15 Nov 2010 14:14:18 +0000
Subject: [lm-sensors] Const buffers for SMBus/I2C block write functions
Message-Id: <201011151514.18969.roman.fietze@telemotive.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello List,

Wouldn't it help in some places, when the block write functions would
take a const buffer pointer?

Please see the diff below.


Index: include/linux/i2c-dev.h
=================================--- include/linux/i2c-dev.h	(revision 5881)
+++ include/linux/i2c-dev.h	(working copy)
@@ -258,7 +258,7 @@
 }
 
 static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
-                                               __u8 length, __u8 *values)
+                                               __u8 length, const __u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;
@@ -296,7 +296,7 @@
 }
 
 static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-                                               __u8 length, __u8 *values)
+                                               __u8 length, const __u8 *values)
 {
 	union i2c_smbus_data data;
 	int i;



Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
