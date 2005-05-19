From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] Fix voltage rounding in lm80
Message-Id: <20040412092227.681cff39.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This one line patch fixes voltage rounding in the lm80 chip driver.

Please apply,
thanks.

--- linux-2.6.5-mm3/drivers/i2c/chips/lm80.c.orig	Sat Apr 10 10:33:01 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/lm80.c	Mon Apr 12 09:14:01 2004
@@ -68,7 +68,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT((val)/10,0,255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT(((val)+5)/10,0,255))
 #define IN_FROM_REG(val)	((val)*10)
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
