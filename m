From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Thu, 22 Sep 2005 19:46:33 +0000
Subject: [lm-sensors] [PATCH] increase size of buffer in
Message-Id: <200509221745.AA01313@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One more byte is needed for PEC.

Index: kernel/i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.110
diff -u -r1.110 i2c-core.c
--- kernel/i2c-core.c	12 Aug 2005 20:39:21 -0000	1.110
+++ kernel/i2c-core.c	22 Sep 2005 17:42:52 -0000
@@ -1216,7 +1216,7 @@
 	  need to use only one message; when reading, we need two. We initialize
 	  most things with sane defaults, to keep the code below somewhat
 	  simpler. */
-	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+2];
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
 	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
 	int num = read_write = I2C_SMBUS_READ?2:1;
 	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
