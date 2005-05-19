From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH 2.6] Fix voltage rounding in asb100
Message-Id: <20040413190613.765faf39.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This one line patch fixes voltage rounding in the asb100 chip driver.
It's very similar to a patch I submitted for the lm80 a few days ago.

It applies cleanly on top of 2.6.5-mm5.

Thanks.

--- linux-2.6.5-mm5/drivers/i2c/chips/asb100.c.orig	2004-04-13 09:57:04.000000000 +0200
+++ linux-2.6.5-mm5/drivers/i2c/chips/asb100.c	2004-04-13 10:35:07.000000000 +0200
@@ -124,7 +124,7 @@
 static u8 IN_TO_REG(unsigned val)
 {
 	unsigned nval = SENSORS_LIMIT(val, ASB100_IN_MIN, ASB100_IN_MAX);
-	return nval / 16;
+	return (nval + 8) / 16;
 }
 
 static unsigned IN_FROM_REG(u8 reg)


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
