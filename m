From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: lm90 driver testers wanted (MAX6657/8/9)
Message-Id: <20041212225853.4126ae40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Hi all,

I received a report that my detection code for the Maxim MAX6657,
MAX6658 and MAX6659 temperature monitoring chipsets in the
i2c/chips/lm90 driver wouldn't work as intended. I have a patch ready
that should fix the problem. However, I was only able to test it on one
sample of the MAX6659, and am not certain that the MAX6657 and MAX6658
would behave exactly the same.

For this reason, I am looking for testers. I would appreciate if users
of the lm90 driver with Maxim chips would give a try to the patch below
and report success of failure. The patch is also available for a limited
duration at the following address:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.10-rc3-i2c-max6657-detection.diff

Thanks.

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
