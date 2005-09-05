From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:15 +0000
Subject: [lm-sensors] [PATCH] I2C: i2c-algo-pca -- gracefully handle a busy
Message-Id: <11259567673174@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: i2c-algo-pca -- gracefully handle a busy bus

I've been running with this patch for a while now, and while I've never
seen it trigger except with buggy hardware I think it is a cleaner way
to handle a busy bus. I had -EBUSY until about 10 minutes ago but -EIO
seems to be what most of the existing algo drivers will return in the
same circumstances.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 48edcb65ddcd93b6421831ad133599aacea9724a
tree 8897c3568fc5f6651fa0ddb80d7e60a8ca2adef4
parent cdcb19219714c796ddef1202e952566c5f86354d
author Ian Campbell <icampbell@arcom.com> Wed, 10 Aug 2005 08:51:16 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:15 -0700

 drivers/i2c/algos/i2c-algo-pca.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -187,12 +187,14 @@ static int pca_xfer(struct i2c_adapter *
 	int numbytes = 0;
 	int state;
 	int ret;
+	int timeout = 100;
 
-	state = pca_status(adap);
-	if ( state != 0xF8 ) {
-		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state );
-		/* FIXME: what to do. Force stop ? */
-		return -EREMOTEIO;
+	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
+		msleep(10);
+	}
+	if (state != 0xf8) {
+		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
+		return -EIO;
 	}
 
 	DEB1("{{{ XFER %d messages\n", num);

