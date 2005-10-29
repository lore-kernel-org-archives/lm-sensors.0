From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:32:08 +0000
Subject: [lm-sensors] [PATCH] i2c: Cleanup i2c-dev ioctl debug message
Message-Id: <11305336594090@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Cleanup i2c-dev ioctl debug message

Cleanup the ioctl debug message in i2c-dev. In particular, the minor
number is redundant now that the minor number and the adapter number
are kept in sync.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e8aafcb2bba1fe122907161701a167e38174c7a5
tree 1353e18055286d52d7f4f3a1d4a5cf028f024f5f
parent 8a1b028bca95b5af36e94a660c4d284fe3313f74
author Jean Delvare <khali@linux-fr.org> Fri, 07 Oct 2005 23:06:27 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:08 -0700

 drivers/i2c/i2c-dev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index aa7a4fa..89f54a5 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -177,8 +177,8 @@ static int i2cdev_ioctl(struct inode *in
 	int i,datasize,res;
 	unsigned long funcs;
 
-	dev_dbg(&client->adapter->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
-		iminor(inode),cmd, arg);
+	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
+		cmd, arg);
 
 	switch ( cmd ) {
 	case I2C_SLAVE:

