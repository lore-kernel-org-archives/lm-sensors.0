From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 24 Sep 2005 10:19:46 +0000
Subject: [lm-sensors] [PATCH] fix SW PEC for write byte data
Message-Id: <200509240819.AA01317@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: kernel/i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.110
diff -u -r1.110 i2c-core.c
--- kernel/i2c-core.c	12 Aug 2005 20:39:21 -0000	1.110
+++ kernel/i2c-core.c	24 Sep 2005 08:20:35 -0000
@@ -979,7 +979,7 @@
 			break;
 		case I2C_SMBUS_BYTE_DATA:
 			buf[2] = data->byte;
-			data->word = buf[2] ||
+			data->word = buf[2] |
 			            (i2c_smbus_pec(3, buf, NULL) << 8);
 			size = I2C_SMBUS_WORD_DATA;
 			break;

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
