From: icampbell@arcom.com (Ian Campbell)
Date: Fri, 29 Jul 2005 12:31:59 +0000
Subject: [lm-sensors] [PATCH] i2c-algo-pca -- gracefully handle a busy bus
Message-Id: <1122633085.19718.106.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been running with this patch for a while now, and while I've never
seen it trigger except with buggy hardware I think it is a cleaner way
to handle a busy bus. I had -EBUSY until about 10 minutes ago but -EIO
seems to be what most of the existing algo drivers will return in the
same circumstances.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%patch
Index: 2.6/drivers/i2c/algos/i2c-algo-pca.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-07-29 08:38:10.000000000 +0100
+++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2005-07-29 11:25:44.000000000 +0100
@@ -187,12 +187,14 @@
 	int numbytes = 0;
 	int state;
 	int ret;
+	int timeout = 100;
 
-	state = pca_status(adap);
-	if ( state != 0xF8 ) {
-		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state );
-		/* FIXME: what to do. Force stop ? */
-		return -EREMOTEIO;
+	while((state = pca_status(adap)) != 0xf8 && timeout--) {
+		msleep(10);
+	}
+	if ( state != 0xf8 ) {
+		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
+		return -EIO;
 	}
 
 	DEB1("{{{ XFER %d messages\n", num);


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

