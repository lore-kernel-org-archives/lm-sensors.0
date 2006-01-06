From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Add support for Barco LPT->DVI to
Message-Id: <11365852542964@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Add support for Barco LPT->DVI to i2c-parport

The following patch adds support for the Barco LPT->DVI I2C adapter to
the i2c-parport driver.

Signed-off-by: Peter Korsgaard <jacmet at sunsite.dk>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 1d26f455eb0db0bf4d4b7177547f4310b645a32a
tree 9d54d48bf529b83abd272e37fc33e0c9adf431eb
parent 7e94436942a7517d08c0cd1a8831122a0fea289e
author Peter Korsgaard <jacmet at sunsite.dk> Sat, 26 Nov 2005 20:18:43 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:21 -0800

 Documentation/i2c/busses/i2c-parport |    1 +
 drivers/i2c/busses/i2c-parport.h     |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-parport b/Documentation/i2c/busses/i2c-parport
index 9f1d008..d9f23c0 100644
--- a/Documentation/i2c/busses/i2c-parport
+++ b/Documentation/i2c/busses/i2c-parport
@@ -17,6 +17,7 @@ It currently supports the following devi
  * Velleman K8000 adapter
  * ELV adapter
  * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+ * Barco LPT->DVI (K5800236) adapter
 
 These devices use different pinout configurations, so you have to tell
 the driver what you have, using the type module parameter. There is no
diff --git a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
index f63a537..d702e5e 100644
--- a/drivers/i2c/busses/i2c-parport.h
+++ b/drivers/i2c/busses/i2c-parport.h
@@ -80,6 +80,14 @@ static struct adapter_parm adapter_parm[
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
 	},
+	/* type 6: Barco LPT->DVI (K5800236) adapter */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x20, STAT, 0 },
+		.getscl	= { 0x40, STAT, 0 },
+		.init	= { 0xfc, DATA, 0 },
+	},
 };
 
 static int type;
@@ -91,4 +99,6 @@ MODULE_PARM_DESC(type,
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Barco LPT->DVI (K5800236) adapter\n"
+);


