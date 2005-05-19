From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <107939139263@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913911123@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.13, 2004/02/23 16:31:52-08:00, khali@linux-fr.org

[PATCH] I2C: fix another oops in i2c-core with debug

Some times ago, you fixed an oops in i2c-core when debugging is enabled:
http://marc.theaimsgroup.com/?l=linux-kernel&m7585749612115&w=2

Looks like you missed that second one:


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 15 14:36:50 2004
+++ b/drivers/i2c/i2c-core.c	Mon Mar 15 14:36:50 2004
@@ -618,7 +618,7 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	dev_dbg(&client->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
+	dev_dbg(&client->adapter->dev, "i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg);
 	switch (cmd) {
 		case I2C_RETRIES:
 			adap->retries = arg;

