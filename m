From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 24 Sep 2005 14:19:33 +0000
Subject: [lm-sensors] [PATCH] remove broken SW PEC support for read_byte
Message-Id: <200509241219.AA01318@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: TODO
=================================RCS file: /home/cvs/i2c/TODO,v
retrieving revision 1.20
diff -u -r1.20 TODO
--- TODO	15 May 2005 10:02:39 -0000	1.20
+++ TODO	24 Sep 2005 12:15:07 -0000
@@ -14,7 +14,7 @@
 * SMBus 2.0 Completion
   SMBus 2.0 adds PEC, ARP, and a block process call message.
   All is complete in release 2.6.4 except for:
-	- SW PEC for Word Data and Process Call. No place to put PEC
+	- SW PEC for Read Byte, Word Data and Process Call. No place to put PEC
 	  in the current i2c_smbus_data structure.
   For a summary of SMBus protocol support, see
 	http://www2.lm-sensors.nu/~lm78/protocol.html
Index: kernel/i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.110
diff -u -r1.110 i2c-core.c
--- kernel/i2c-core.c	12 Aug 2005 20:39:21 -0000	1.110
+++ kernel/i2c-core.c	24 Sep 2005 12:15:07 -0000
@@ -1002,11 +1002,6 @@
 
 	buf[1] = command;
 	switch(size) {
-		case I2C_SMBUS_BYTE_DATA:
-			buf[0] = (addr << 1) | 1;
-			cpec = i2c_smbus_pec(2, buf, NULL);
-			rpec = data->byte;
-			break;
 		case I2C_SMBUS_WORD_DATA:
 			buf[0] = (addr << 1) | 1;
 			buf[2] = data->word & 0xff;

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
