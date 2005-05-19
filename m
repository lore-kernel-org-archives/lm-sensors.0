From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913931477@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913931516@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.2, 2004/03/09 14:57:49-08:00, khali@linux-fr.org

[PATCH] I2C: Prevent i2c-dev oops with debug

Looks like i2c-dev suffers the same problem with dev_dbg as i2c-core did
twice. Here is a patch that fixed a oops I and another user were
experiencing when running sensors-detect.


 drivers/i2c/i2c-dev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:13 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:13 2004
@@ -189,7 +189,7 @@
 	int i,datasize,res;
 	unsigned long funcs;
 
-	dev_dbg(&client->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
+	dev_dbg(&client->adapter->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
 		iminor(inode),cmd, arg);
 
 	switch ( cmd ) {
@@ -310,7 +310,7 @@
 		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"size out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.size);
 			return -EINVAL;
@@ -319,7 +319,7 @@
 		   so the check is valid if size=I2C_SMBUS_QUICK too. */
 		if ((data_arg.read_write != I2C_SMBUS_READ) && 
 		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
-			dev_dbg(&client->dev, 
+			dev_dbg(&client->adapter->dev, 
 				"read_write out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.read_write);
 			return -EINVAL;
@@ -338,7 +338,7 @@
 					      data_arg.size, NULL);
 
 		if (data_arg.data = NULL) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"data is NULL pointer in ioctl I2C_SMBUS.\n");
 			return -EINVAL;
 		}

