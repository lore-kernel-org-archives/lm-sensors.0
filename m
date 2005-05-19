From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Add byte commands to i2c-stub
Message-Id: <20041226151327.56a80b7c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, all,

While working on EEPROMs, DDC/EDID and the like these last few days, I
wanted to use your i2c-stub driver to test my code. However, I noticed
that it wouldn't handle byte commands, while both i2cdetect and the
eeprom driver need it for proper operation. Thus I added this
functionality to the driver. What do you think about it?

Greg, please apply to your tree unless Mark objects.
Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/busses/i2c-stub.c.orig	2004-12-23 15:53:41.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/busses/i2c-stub.c	2004-12-26 10:07:31.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
+static u8  stub_pointer;
 static u8  stub_bytes[256];
 static u16 stub_words[256];
 
@@ -44,6 +45,22 @@
 		ret = 0;
 		break;
 
+	case I2C_SMBUS_BYTE:
+		if (read_write = I2C_SMBUS_WRITE) {
+			stub_pointer = command;
+			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
+					"wrote 0x%02x.\n",
+					addr, command);
+		} else {
+			data->byte = stub_bytes[stub_pointer++];
+			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
+					"read  0x%02x.\n",
+					addr, data->byte);
+		}
+
+		ret = 0;
+		break;
+
 	case I2C_SMBUS_BYTE_DATA:
 		if (read_write = I2C_SMBUS_WRITE) {
 			stub_bytes[command] = data->byte;
@@ -56,6 +73,7 @@
 					"read  0x%02x at 0x%02x.\n",
 					addr, data->byte, command);
 		}
+		stub_pointer = command + 1;
 
 		ret = 0;
 		break;
@@ -87,8 +105,8 @@
 
 static u32 stub_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA;
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA;
 }
 
 static struct i2c_algorithm smbus_algorithm = {
--- linux-2.6.10-rc3/Documentation/i2c/i2c-stub.orig	2004-12-05 17:32:40.000000000 +0100
+++ linux-2.6.10-rc3/Documentation/i2c/i2c-stub	2004-12-26 15:08:02.000000000 +0100
@@ -2,14 +2,19 @@
 
 DESCRIPTION:
 
-This module is a very simple fake I2C/SMBus driver.  It implements three
-types of SMBus commands: write quick, (r/w) byte data, and (r/w) word data.
+This module is a very simple fake I2C/SMBus driver.  It implements four
+types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, and
+(r/w) word data.
 
 No hardware is needed nor associated with this module.  It will accept write
 quick commands to all addresses; it will respond to the other commands (also
 to all addresses) by reading from or writing to an array in memory.  It will
 also spam the kernel logs for every command it handles.
 
+A pointer register with auto-increment is implemented for all byte
+operations.  This allows for continuous byte reads like those supported by
+EEPROMs, among others.
+
 The typical use-case is like this:
 	1. load this module
 	2. use i2cset (from lm_sensors project) to pre-load some data


-- 
Jean Delvare
http://khali.linux-fr.org/
