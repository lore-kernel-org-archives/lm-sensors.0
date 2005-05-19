From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814532188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814533933@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.28, 2004/04/12 15:17:24-07:00, khali@linux-fr.org

[PATCH] I2C: Fix voltage rounding in lm80

This one line patch fixes voltage rounding in the lm80 chip driver.


 drivers/i2c/chips/lm80.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:26 2004
+++ b/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:26 2004
@@ -68,7 +68,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT((val)/10,0,255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT(((val)+5)/10,0,255))
 #define IN_FROM_REG(val)	((val)*10)
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)

