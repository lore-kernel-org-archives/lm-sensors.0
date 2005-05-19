From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <1072821970466@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219701447@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.20.2, 2003/12/19 10:47:09-08:00, mds@paradyne.com

[PATCH] I2C: fix amd756 byte writes

This fixes byte writes (used by the eeprom driver) in the i2c-amd756
driver.  It is similar to recent fixes for the i2c-amd8111 and
i2c-nforce2 drivers.

Tested by me.


 drivers/i2c/busses/i2c-amd756.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:29:49 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Tue Dec 30 12:29:49 2003
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

