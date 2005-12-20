From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Dec 2005 19:52:31 +0000
Subject: [lm-sensors] [PATCH] LM77: correction of "register to
Message-Id: <20051220205231.48d267e0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> Temperature conversion in lm77.c is currently broken for negative
> temperatures, as discovered in
> http://list.voyage.hk/pipermail/voyage-linux/2005-December/000540.html
> 
> National uses the upper 4 bits of the temperature registers to represent
> the sign (all these are either set or unset at the same time), while the
> lower 3 bits are either unused or represent the alarm status (depending
> on which of the temperature registers you look at).

You seem to think that using more than one bit for sign is odd from
National. This is actually the standard way of doing though. Think
about it. If you store signed values on 8 bit, you'll be able to store
values from -128 to +127. If for some reason, you need the range of
values to be shorter than that, say, -32 to +31, then all valid negative
values will start with three "1" bits, and all valid positive values
will start with three "0" bits. It's the simple consequence of the range
limitation, not a design decision.

> The "register to temperature" conversion doesn't properly consider these
> sign bits. In the result they are used as part of the absolute
> temperature value, so that negative temperatures are incorrectly
> converted to huge positive values instead. 
> (Side note: the "temperature to register" conversion works fine with
> positive and negative values.)
> 
> The attached patch (which is against kernel 2.6.14.4) solves this issue.
> It has been tested against all the sample values given in the LM77
> datasheet (section 1.4) to proof it is working correctly.

Your patch is probably correct but also needlessly complex. All we
really have here is a unsigned vs. signed issue. What about this more
simple fix instead?

Fix negative temperature readings in lm77 driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm77.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc6.orig/drivers/hwmon/lm77.c	2005-12-19 20:15:58.000000000 +0100
+++ linux-2.6.15-rc6/drivers/hwmon/lm77.c	2005-12-20 19:44:11.000000000 +0100
@@ -87,15 +87,15 @@
 
 /* In the temperature registers, the low 3 bits are not part of the
    temperature values; they are the status bits. */
-static inline u16 LM77_TEMP_TO_REG(int temp)
+static inline s16 LM77_TEMP_TO_REG(int temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
-	return (u16)((ntemp / 500) * 8);
+	return (ntemp / 500) * 8;
 }
 
-static inline int LM77_TEMP_FROM_REG(u16 reg)
+static inline int LM77_TEMP_FROM_REG(s16 reg)
 {
-	return ((int)reg / 8) * 500;
+	return (reg / 8) * 500;
 }
 
 /* sysfs stuff */


-- 
Jean Delvare

