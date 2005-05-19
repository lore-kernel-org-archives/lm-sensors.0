From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: [PATCH] i2c block write
Message-Id: <200210181419.AA00078@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems that i2c block write emulation need following modification.


Index: i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.88
diff -u -r1.88 i2c-core.c
--- i2c-core.c	2002/10/01 14:02:28	1.88
+++ i2c-core.c	2002/10/18 14:19:50
@@ -1368,15 +1368,15 @@
 		if (read_write = I2C_SMBUS_READ) {
 			msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
 		} else {
-			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 2) {
+			msg[0].len = data->block[0] + 1;
+			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
 				printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
 			}
-			for (i = 0; i < data->block[0]; i++)
-				msgbuf0[i] = data->block[i+1];
+			for (i = 1; i <= data->block[0]; i++)
+				msgbuf0[i] = data->block[i];
 		}
 		break;
 	default:

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
