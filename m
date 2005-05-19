From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: [PATCH 2.6] I2C: Spare 1 byte in lm90 driver
Message-Id: <20041011194511.30b86de9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I just noticed the other day that the lm90 driver uses an u16 to store
the value of the 8-bit alarms register. This is most probably due to the
fact that I originally copied the lm90 driver from the lm83 driver,
which actually has two 8-bit registers for alarms, and obviously forgot
to change the variable type.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc3/drivers/i2c/chips/lm90.c.orig
+++ linux-2.6.9-rc3/drivers/i2c/chips/lm90.c
@@ -185,7 +185,7 @@
 	s16 temp_input2, temp_low2, temp_high2; /* remote, combined */
 	s8 temp_crit1, temp_crit2;
 	u8 temp_hyst;
-	u16 alarms; /* bitvector, combined */
+	u8 alarms; /* bitvector */
 };
 
 /*


-- 
Jean Delvare
http://khali.linux-fr.org/
