From: jmunsin@iki.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040608190550.GA8911@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 08, 2004 at 07:44:27PM +0200, Jean Delvare wrote:
> Care to provide a similar fix for 2.4?

As mentioned on IRC, I think I will stay away from 2.4.

> > Btw, "grep SENSORS_LIMIT drivers/i2c/chips/*.c|grep 127" shows that
> > lm85.c has a rounding error in it's TEMP_TO_REG() macro (and probably
> > in at least one other place).
> 
> Correct. BTW, the same grep shows that rounding is probably missing in
> EXTTEMP_TO_REG and OFFSET_TO_REG of the same driver. Feel free to submit
> a patch to Greg that fixes this. If a similar fix is required for 2.4
> (and most likely it is), a patch will of course be welcome as well.

How's this?

--- drivers/i2c/chips/lm85.c.orig.2.6.7-rc2	2004-06-08 21:23:07.000000000 +0300
+++ drivers/i2c/chips/lm85.c	2004-06-08 21:46:21.000000000 +0300
@@ -153,10 +153,12 @@
 #define FAN_FROM_REG(val)	((val)=0?-1:(val)=0xffff?0:5400000/(val))
 
 /* Temperature is reported in .001 degC increments */
-#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)+500)/1000,-127,127))
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
+					((val)+500)/1000),-127,127))
 #define TEMPEXT_FROM_REG(val,ext)	((val)*1000 + (ext)*250)
 #define TEMP_FROM_REG(val)		(TEMPEXT_FROM_REG(val,0))
-#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/250,-127,127))
+#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT(((val)<0?(((val)-125)/250):\
+					((val)+125)/250),-127,127))
 
 #define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
 #define PWM_FROM_REG(val)		(val)
@@ -290,7 +292,8 @@
 #define HYST_TO_REG(val) (SENSORS_LIMIT((-(val)+5)/10,0,15))
 #define HYST_FROM_REG(val) (-(val)*10)
 
-#define OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/25,-127,127))
+#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-12)/25):\
+					((val)+13)/25),-127,127))
 #define OFFSET_FROM_REG(val) ((val)*25)
 
 #define PPR_MASK(fan) (0x03<<(fan *2))
