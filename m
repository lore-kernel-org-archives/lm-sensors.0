From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Make master_xfer debug messages more useful
Message-Id: <1112311390208@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1112311390987@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2328, 2005/03/31 14:07:05-08:00, khali@linux-fr.org

[PATCH] I2C: Make master_xfer debug messages more useful

While working on the recent saa7110 mess, I found that the debug message
displayed when calling master_xfer wasn't as useful as it could be. Here
is a patch improving this.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-03-31 15:18:36 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-03-31 15:18:36 -08:00
@@ -587,7 +587,13 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num);
+#ifdef DEBUG
+		for (ret = 0; ret < num; ret++) {
+			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
+				"len=%d\n", ret, msgs[ret].flags & I2C_M_RD ?
+				'R' : 'W', msgs[ret].addr, msgs[ret].len);
+		}
+#endif
 
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);

