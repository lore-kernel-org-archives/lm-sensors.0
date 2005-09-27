From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Tue, 27 Sep 2005 19:54:46 +0000
Subject: [lm-sensors] [PATCH] synchronize i2c_msg structure in i2c and
Message-Id: <200509271754.AA01322@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Without this, I2C_RDWR ioctl does not work correctly.

Index: kernel/include/i2c-dev.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
retrieving revision 1.9
diff -u -r1.9 i2c-dev.h
--- kernel/include/i2c-dev.h	26 Sep 2005 17:35:48 -0000	1.9
+++ kernel/include/i2c-dev.h	27 Sep 2005 17:45:03 -0000
@@ -45,8 +45,6 @@
 #define I2C_M_NO_RD_ACK		0x0800
 	short len;		/* msg length				*/
 	char *buf;		/* pointer to msg data			*/
-	int err;
-	short done;
 };
 
 /* To determine what functionality is present */

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
