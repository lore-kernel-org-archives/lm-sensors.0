From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: [PATCH 2.6] Prevent i2c-dev oops with debug
Message-Id: <20040302224909.444663af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Looks like i2c-dev suffers the same problem with dev_dbg as i2c-core did
twice. Here is a patch that fixed a oops I and another user were
experiencing when running sensors-detect.

Please note that I have no idea if this is the correct way to fix the
problem. I mostly copied the fix from i2c-core. I don't quite understand
what we are supposed to pass to dev_dbg.

BTW, I read that you don't plan to send any i2c patch to Linus before
2.6.4. I agree that we need to calm down a bit ;) but there are a
several oops preventing patches in my list (i2c-core, i2c-i801,
i2c-sis5595, i2c-ali1535 and now i2c-dev). Shouldn't these simple but
important fixes be sent to Linus?

Also, I sent a mail to you some times ago about classes. The fact that 3
bus drivers are unusable at the moment sounds like an important issue to
me, and we would need to decide about what should be done.

Thanks a lot for your precious help.

--- linux-2.6.3-g1/drivers/i2c/i2c-dev.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3-g1/drivers/i2c/i2c-dev.c	Tue Mar  2 20:42:12 2004
@@ -187,7 +187,7 @@
 	int i,datasize,res;
 	unsigned long funcs;
 
-	dev_dbg(&client->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
+	dev_dbg(&client->adapter->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
 		iminor(inode),cmd, arg);
 
 	switch ( cmd ) {
@@ -308,7 +308,7 @@
 		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"size out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.size);
 			return -EINVAL;
@@ -317,7 +317,7 @@
 		   so the check is valid if size=I2C_SMBUS_QUICK too. */
 		if ((data_arg.read_write != I2C_SMBUS_READ) && 
 		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
-			dev_dbg(&client->dev, 
+			dev_dbg(&client->adapter->dev, 
 				"read_write out of range (%x) in ioctl I2C_SMBUS.\n",
 				data_arg.read_write);
 			return -EINVAL;
@@ -336,7 +336,7 @@
 					      data_arg.size, NULL);
 
 		if (data_arg.data = NULL) {
-			dev_dbg(&client->dev,
+			dev_dbg(&client->adapter->dev,
 				"data is NULL pointer in ioctl I2C_SMBUS.\n");
 			return -EINVAL;
 		}


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
