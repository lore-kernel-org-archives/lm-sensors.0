From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: voltage conversions in via686a
Message-Id: <20040412135930.10527d57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just noticed that the voltage conversions in via686a have severe
rounding issues. And all in all they are artificially complex, and
wrong.

Two hints confirm my suspicions:

1* In the source code, the original author states:
// These get us close, but they don't completely agree with what my BIOS 
// says- they are all a bit low.  But, it all we have to go on...

2* In etc/sensors.conf.eg, I found:
# For at least one Tyan S1598, the following corrections make the sensors
# readings more in-line with the BIOS readings on boot.  Try these, and
# adjust as necessary.

  #compute "2.0V" 1.02*@ ,  @/1.02
  #compute "3.3V" 1.02*@  ,  @/1.02
  #compute "5.0V" 1.009*@  ,  @/1.009
  #compute "12V" 1.04*@ ,  @/1.04

So this would tend to confirm that the proposed change would convert the
register values more accurately. Patch against CVS attached. A similar
patch for 2.6 is available here:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.5-mm3-i2c-via686a-2-in-values.diff
It has to be applied on top of (at least):
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.5-mm3-i2c-via686a-1-init.diff

I tested both on my own VIA686A chip, but since it's not used on my
motherboard, I have no real values to confirm that the change is
correct. I just could see what O expected, i.e. the (bogus) readings
went about 2% up.

Lennard Klein tested on a real chip (2.6 kernel) and also observed
slightly greater readings. Looks OK, although he didn't reboot the
system to compare with the BIOS (yet).

If anyone has a working VIA686A, please test and comment.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: kernel/chips/via686a.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/via686a.c,v
retrieving revision 1.33
diff -u -r1.33 via686a.c
--- kernel/chips/via686a.c	12 Apr 2004 11:27:00 -0000	1.33
+++ kernel/chips/via686a.c	12 Apr 2004 11:31:43 -0000
@@ -125,48 +125,40 @@
 // regVal = (volts/factor-133)/25
 // (These conversions were contributed by Jonathan Teh Soon Yew 
 // <j.teh@iname.com>)
-// 
-// These get us close, but they don't completely agree with what my BIOS 
-// says- they are all a bit low.  But, it all we have to go on...
 static inline u8 IN_TO_REG(long val, int inNum)
 {
-	// to avoid floating point, we multiply everything by 100.
-	// val is guaranteed to be positive, so we can achieve the effect of 
-	// rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
-	// /250 (which should really be /2500).
-	// At the end, we need to /100 because we *100 everything and we need
-	// to /10 because of the rounding thing, so we /1000.  
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   Rounding is done (1205000 is actually 1330000 - 125000).
+	   Remember that val is expressed in 0.01V/bit, which is why we divide
+	   by an additional 1000 (10000 for +12V): 100 for val and 10 (100)
+	   for the constants. */
 	if (inNum <= 1)
 		return (u8)
-		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 21024 - 1205000) / 250000, 0, 255);
 	else if (inNum = 2)
 		return (u8)
-		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 15737 - 1205000) / 250000, 0, 255);
 	else if (inNum = 3)
 		return (u8)
-		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 10108 - 1205000) / 250000, 0, 255);
 	else
-		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
-					  / 1000, 0, 255);
+		return (u8)
+		    SENSORS_LIMIT((val * 41714 - 12050000) / 2500000, 0, 255);
 }
 
 static inline long IN_FROM_REG(u8 val, int inNum)
 {
-	// to avoid floating point, we multiply everything by 100.
-	// val is guaranteed to be positive, so we can achieve the effect of
-	// rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	// We need to scale with *100 anyway, so no need to /100 at the end.
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   We also multiply them by 100 because we want 0.01V/bit for the
+	   output value. Rounding is done. */
 	if (inNum <= 1)
-		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
+		return (long) ((25000 * val + 133000 + 21024 / 2) / 21024);
 	else if (inNum = 2)
-		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
+		return (long) ((25000 * val + 133000 + 15737 / 2) / 15737);
 	else if (inNum = 3)
-		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
+		return (long) ((25000 * val + 133000 + 10108 / 2) / 10108);
 	else
-		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 41714 / 2) / 41714);
 }
 
 /********* FAN RPM CONVERSIONS ********/
