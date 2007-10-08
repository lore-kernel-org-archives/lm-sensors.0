From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Oct 2007 20:48:10 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm87: Disable VID when it should be
Message-Id: <20071008224810.4e80536d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A stupid bit shifting bug caused the VID value to be always exported
even when the hardware is configured for something different.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm87.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.23-rc9.orig/drivers/hwmon/lm87.c	2007-10-08 21:26:20.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/lm87.c	2007-10-08 22:14:50.000000000 +0200
@@ -146,7 +146,7 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A,
 #define CHAN_NO_FAN(nr)		(1 << (nr))
 #define CHAN_TEMP3		(1 << 2)
 #define CHAN_VCC_5V		(1 << 3)
-#define CHAN_NO_VID		(1 << 8)
+#define CHAN_NO_VID		(1 << 7)
 
 /*
  * Functions declaration


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
