From: jlavi@iki.fi (Jarkko Lavinen)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Setting w83627hf fan divisor 128 fails.
Message-Id: <20050508193026.GA777@smooth.piipiip.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

I couldn't set the divisor 128 through fan1_div sysfs entry even though the 
chip supports it and setting divisors 1..64 worked. This was due to 
POWER_TO_REG() only checking 2's powers 0 till 5 but not 6.

Regards
Jarkko Lavinen

--- linux-2.6.12-rc3/drivers/i2c/chips/w83627hf.c       2005-04-21 03:03:13.000000000 +0300
+++ linux-2.6.12-rc3-koe/drivers/i2c/chips/w83627hf.c   2005-05-08 20:04:04.000000000 +0300
@@ -264,7 +264,7 @@ static inline u8 DIV_TO_REG(long val)
 {
        int i;
        val = SENSORS_LIMIT(val, 1, 128) >> 1;
-       for (i = 0; i < 6; i++) {
+       for (i = 0; i < 7; i++) {
                if (val = 0)
                        break;
                val >>= 1;
