From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sun, 25 Sep 2005 13:57:49 +0000
Subject: [lm-sensors] [PATCH] fix SMBus write_byte ioctl
Message-Id: <200509251157.AA01319@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c_smbus_xfer needs the structure i2c_smbus_data for write_byte with SW PEC.
However, NULL is passed from i2cdev_ioctl.
Currently
	ioctl(fd,I2C_PEC,1);
	i2c_smbus_write_byte(fd,value);
causes NULL pointer access in i2c_smbus_add_pec.

Index: kernel/i2c-dev.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-dev.c,v
retrieving revision 1.61
diff -u -r1.61 i2c-dev.c
--- kernel/i2c-dev.c	19 May 2005 20:50:29 -0000	1.61
+++ kernel/i2c-dev.c	25 Sep 2005 09:33:21 -0000
@@ -329,7 +329,8 @@
 			                      client->flags,
 			                      data_arg.read_write,
 			                      data_arg.command,
-			                      data_arg.size, NULL);
+			                      data_arg.size,
+			                      (data_arg.size = I2C_SMBUS_QUICK) ? NULL : &temp);
 
 		if (data_arg.data = NULL) {
 #ifdef DEBUG

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
