From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 23:06:57 +0000
Subject: [lm-sensors] [PATCH 02/16] i2c: Cleanup i2c-dev ioctl debug message
Message-Id: <20051007230627.1eba9aee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cleanup the ioctl debug message in i2c-dev. In particular, the minor
number is redundant now that the minor number and the adapter number
are kept in sync.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/i2c-dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/i2c-dev.c	2005-10-07 20:08:17.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/i2c-dev.c	2005-10-07 20:24:20.000000000 +0200
@@ -177,8 +177,8 @@
 	int i,datasize,res;
 	unsigned long funcs;
 
-	dev_dbg(&client->adapter->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
-		iminor(inode),cmd, arg);
+	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
+		cmd, arg);
 
 	switch ( cmd ) {
 	case I2C_SLAVE:

-- 
Jean Delvare
