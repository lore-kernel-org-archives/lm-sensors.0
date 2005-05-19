From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Fix MAX6657/8/9 detection in lm90
Message-Id: <20041226152229.16d51a7c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I received no additional feedback about my MAX6657/8/9 detection fix.
Since it was correct for the only chips I got a report for, I propose we
apply it. After all, maybe people don't know they have such a chip
because the detection was previously not correct.

The patch below is the one I sent to the LM Sensors and Linux Kernel
mailing-lists two weeks ago, unchanged. Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/chips/lm90.c.orig	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/lm90.c	2004-12-12 16:28:42.000000000 +0100
@@ -35,12 +35,13 @@
  * Among others, it has a higher accuracy than the LM90, much like the
  * LM86 does.
  *
- * This driver also supports the MAX6657 and MAX6658, sensor chips made
- * by Maxim. These chips are similar to the LM86. Complete datasheet
- * can be obtained at Maxim's website at:
+ * This driver also supports the MAX6657, MAX6658 and MAX6659 sensor
+ * chips made by Maxim. These chips are similar to the LM86. Complete
+ * datasheet can be obtained at Maxim's website at:
  *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
- * Note that there is no way to differenciate between both chips (but
- * no need either).
+ * Note that there is no easy way to differenciate between the three
+ * variants. The extra address and features of the MAX6659 are not
+ * supported by this driver.
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and
@@ -70,9 +71,11 @@
 
 /*
  * Addresses to scan
- * Address is fully defined internally and cannot be changed.
+ * Address is fully defined internally and cannot be changed except for
+ * MAX6659.
  * LM86, LM89, LM90, LM99, ADM1032, MAX6657 and MAX6658 have address 0x4c.
  * LM89-1, and LM99-1 have address 0x4d.
+ * MAX6659 can have address 0x4c, 0x4d or 0x4e (unsupported).
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
@@ -386,8 +389,17 @@
 			}
 		} else
 		if (man_id = 0x4D) { /* Maxim */
-			if (address = 0x4C
-			 && (reg_config1 & 0x1F) = 0
+			/*
+			 * The Maxim variants do NOT have a chip_id register.
+			 * Reading from that address will return the last read
+			 * value, which in our case is those of the man_id
+			 * register. Likewise, the config1 register seems to
+			 * lack a low nibble, so the value will be those of the
+			 * previous read, so in our case those of the man_id
+			 * register.
+			 */
+			if (chip_id = man_id
+			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
 			 && reg_convrate <= 0x09) {
 			 	kind = max6657;
 			}


-- 
Jean Delvare
http://khali.linux-fr.org/
