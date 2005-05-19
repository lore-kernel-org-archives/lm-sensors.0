From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.6] amd756 byte writes
Message-Id: <3FDBA474.AC098F99@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This fixes byte writes (used by the eeprom driver) in the i2c-amd756
driver.
It is similar to recent fixes for the i2c-amd8111 and i2c-nforce2
drivers.
Tested by me.
please apply.
mds
-------------- next part --------------
--- src-linux-2.6.0-test11/drivers/i2c/busses/i2c-amd756.c.orig	Sun Oct 26 13:57:11 2003
+++ src-linux-2.6.0-test11/drivers/i2c/busses/i2c-amd756.c	Sat Dec 13 18:01:40 2003
@@ -213,9 +213,8 @@
 	case I2C_SMBUS_BYTE:
 		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
 		       SMB_HOST_ADDRESS);
-		/* TODO: Why only during write? */
 		if (read_write = I2C_SMBUS_WRITE)
-			outb_p(command, SMB_HOST_COMMAND);
+			outb_p(command, SMB_HOST_DATA);
 		size = AMD756_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
