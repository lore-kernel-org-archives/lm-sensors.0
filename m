From: icampbell@arcom.com (Ian Campbell)
Date: Mon, 01 Aug 2005 09:49:28 +0000
Subject: [lm-sensors] Re: [PATCH] i2c-algo-pca -- gracefully handle a busy
Message-Id: <1122882496.19718.137.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122633085.19718.106.camel@icampbell-debian>
In-Reply-To: <1122633085.19718.106.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2005-07-31 at 18:22 +0200, Jean Delvare wrote:

> Fine with me, except for the few coding style issues below.

Sure thing. Fixed patch is below.

I've been running with this patch for a while now, and while I've never
seen it trigger except with buggy hardware I think it is a cleaner way
to handle a busy bus. I had -EBUSY until about 10 minutes ago but -EIO
seems to be what most of the existing algo drivers will return in the
same circumstances.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

%patch
Index: 2.6/drivers/i2c/algos/i2c-algo-pca.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-pca.c	2005-07-29 13:51:20.000000000 +0100
+++ 2.6/drivers/i2c/algos/i2c-algo-pca.c	2005-08-01 08:40:19.000000000 +0100
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
+	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
+		msleep(10);
+	}
+	if (state != 0xf8) {
+		dev_dbg(&i2c_adap->dev, "bus is not idle. status is %#04x\n", state);
+		return -EIO;
 	}
 
 	DEB1("{{{ XFER %d messages\n", num);


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
