From: jcromie@divsol.com (jcromie@divsol.com)
Date: Mon, 22 Aug 2005 19:50:01 +0000
Subject: [lm-sensors] test-send vref-ext-email again
Message-Id: <200508221702.j7MH2P36007729@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, etal

[ apologies in advance for any mail bogosity - 
this is sent with a minimal sendmail script to avoid mime attachements.
Ive tested it on myself, but u never know..
pls advise if bogosity is subtle - if obvious I hope to know ]

This patch corrects a voltage-reference value swap in current code.
It now agrees with your previous explanation; the internal voltage ref
is higher than the value specd/recommended for an external reference.

This is a minimal change, and qualifies strictly as a bug-fix.
After .13 is out, Id want to replace/add a module-param to specify the
external ref voltage that is actually supplied, though on my board it is
the recommended value, so I dont need the param.

heres a before and after:
voltages drop approx 2%, which is in agreement with calcs: 1-(2966/3025)


root@soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)
VCORE:     +2.00 V  (min =  +0.00 V, max =  +3.01 V)
VCC:       +4.96 V  (min =  +0.00 V, max =  +6.03 V)
VPWR:     +13.55 V  (min =  +5.93 V, max = +28.02 V)
+12V:     +11.74 V  (min =  +0.00 V, max = +14.46 V)
-12V:     -12.97 V  (min = -60.61 V, max =  -2.76 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)
Vsb:       +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Vdd:       +2.91 V  (min =  +3.00 V, max =  +3.59 V)       ALARM
Vbat:      +3.01 V  (min =  +2.40 V, max =  +3.01 V)
AVdd:      +3.28 V  (min =  +3.00 V, max =  +3.59 V)
Temp:       +107 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM

root@soekris:~#
root@soekris:~# rmmod pc87360; modprobe pc87360; sensors -s ; sensors
pc87360: Device 0x09 not activated
pc87360 9191-6620: VLM conversion set to 1s period, 160us delay
pc87366-isa-6620
Adapter: ISA adapter
avi0:      +2.95 V  (min =  +0.00 V, max =  +2.95 V)
VCORE:     +1.95 V  (min =  +0.00 V, max =  +2.95 V)
VCC:       +4.87 V  (min =  +0.00 V, max =  +5.91 V)
VPWR:     +12.34 V  (min =  +6.05 V, max = +27.94 V)
+12V:     +11.51 V  (min =  +0.00 V, max = +14.18 V)
-12V:     -13.89 V  (min = -60.61 V, max =  -3.89 V)
GND:       +0.00 V  (min =  +0.00 V, max =  +2.95 V)
Vsb:       +3.22 V  (min =  +2.99 V, max =  +3.59 V)
Vdd:       +2.85 V  (min =  +2.99 V, max =  +3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =  +2.95 V)
AVdd:      +3.22 V  (min =  +2.99 V, max =  +3.59 V)
Temp:       +106 C  (low  =    +0 C, high =   +70 C)   ALARM
Critical:    +85 C ALARM


Henrik Brix Anderson has kindly tested a version of this patch
which added several new module-parameters, and is thus unsuitable
for 13 at this late stage.  If this doesnt get in (for obvious
reasons), Ill repost a version with a mod-param to set external vref.

Im copy-pasting his words and signoff, and cc'g him.

Brix, when you tested, you evidently measured your vrefext.
The code default is 1.211mv, not your measured 1.210mv.
Did you use the mod-param to tweak it down 1mv ?
Or were the defaults also a 'great' improvment.
Can you quantify 'great' ?  errs 10mv -> 1mv ??
Did you mess about with the vrefscale setting ?

thanks
Signed-off-by:  Jim Cromie <jcromie@divsol.com>


I have tested this patch with a measured vrefext of 1210mV - it greatly
improves the precision of my sensor readings compared to the measured
voltages.

Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>


diff -ruNp -X exclude-diffs ../linux-2.6.13-rc5-mm1/drivers/hwmon/pc87360.c vref-int-ext/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc5-mm1/drivers/hwmon/pc87360.c	2005-08-07 13:17:29.000000000 -0600
+++ vref-int-ext/drivers/hwmon/pc87360.c	2005-08-14 10:29:20.000000000 -0600
@@ -798,7 +798,7 @@ static int pc87360_detect(struct i2c_ada
 			i &= pc87360_read_value(data, LD_TEMP, NO_BANK,
 						PC87365_REG_TEMP_CONFIG);
 		}
-		data->in_vref = (i&0x02) ? 3025 : 2966;
+		data->in_vref = (i&0x02) ? 2966 : 3025; /* vref (mV) * 2.54 */
 		dev_dbg(&new_client->dev, "Using %s reference voltage\n",
 			(i&0x02) ? "external" : "internal");
 
