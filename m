From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] I2C: update the lm83 driver
Message-Id: <20040809202853.749bbc6f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040808221739.07e433f9.khali@linux-fr.org>
In-Reply-To: <20040808221739.07e433f9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Oops, I already applied the previous one :(
> 
> Care to send me just a fix against the previous patch instead?

Certainly. Sorry for the noise again.

Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ruN linux-2.6.8-rc2/drivers/i2c/chips.old/lm83.c linux-2.6.8-rc2/drivers/i2c/chips/lm83.c
--- linux-2.6.8-rc2/drivers/i2c/chips.old/lm83.c	2004-08-08 21:39:28.000000000 +0200
+++ linux-2.6.8-rc2/drivers/i2c/chips/lm83.c	2004-08-09 20:26:52.000000000 +0200
@@ -83,10 +83,10 @@
  * The LM83 uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	(((val) > 127 ? (val)-0xFF : (val)) * 1000)
-#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0xFF : (val) >= 127000 ? 127 : \
+#define TEMP_FROM_REG(val)	(((val) > 127 ? (val) - 0x100 : (val)) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0x100 : (val) >= 127000 ? 127 : \
 				 (val) > -500 ? ((val)+500) / 1000 : \
-				 ((val)-500) / 1000 + 0xFF)
+				 ((val)-500) / 1000 + 0x100)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
