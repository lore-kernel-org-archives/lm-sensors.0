From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Fix fan speeds on ADM1026
Message-Id: <3EE7EEF7.1040803@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jerome Hsiao @ Arima pointed out to me that the fan speeds from the 
ADM1026 driver were not consistent with other drivers.

Seems that most (all?) drivers assume two pulses per rev from the fans. 
  I expected that users would need to use a "compute" directive to 
modify the fan speed for the number of pulses-per-rev of their fans. 
(All the fans I use are 4 ppr so I'm always having to "compute" a 
correct value.)

But it's not consistent with the other drives...

So here is a patch to fix the ADM1026 so it reports fan speeds 
consistent with the other drivers...

This was done against CVS...

:v)


-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
-------------- next part --------------
Index: lm_sensors2/kernel/chips/adm1026.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/adm1026.c,v
retrieving revision 1.1
diff -u -r1.1 adm1026.c
--- lm_sensors2/kernel/chips/adm1026.c	8 Jun 2003 21:33:38 -0000	1.1
+++ lm_sensors2/kernel/chips/adm1026.c	12 Jun 2003 03:13:03 -0000
@@ -29,6 +29,10 @@
                  Fix silly bug in fan_div logic
                  Fix fan_min handling so that 0xff is 0 is 0xff
     2003-05-25   Fix more silly typos...
+    2003-06-11   Change FAN_xx_REG macros to use different scaling
+                 Most (all?) drivers assume two pulses per rev fans
+                 and the old scaling was producing double the RPM's
+                 Thanks to Jerome Hsiao @ Arima for pointing this out.
 */
 
 #include <linux/version.h>
@@ -244,10 +248,11 @@
 #endif
 
 /* FAN speed is measured using 22.5kHz clock and counts for 2 pulses
- *      22500 * 60 * 2 = 2700000
+ *   and we assume a 2 pulse-per-rev fan tach signal
+ *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) = 1350000
  */
-#define FAN_TO_REG(val,div)  ((val)<=0 ? 0xff : SENSORS_LIMIT(2700000/((val)*(div)),1,254))
-#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=0xff ? 0 : 2700000/((val)*(div)))
+#define FAN_TO_REG(val,div)  ((val)<=0 ? 0xff : SENSORS_LIMIT(1350000/((val)*(div)),1,254))
+#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=0xff ? 0 : 1350000/((val)*(div)))
 #define DIV_FROM_REG(val) (1<<(val))
 #define DIV_TO_REG(val) ((val)>=8 ? 3 : (val)>=4 ? 2 : (val)>=2 ? 1 : 0)
 
@@ -1117,7 +1122,7 @@
 		for (i = 0 ; i <= 7 ; ++i) {
 			data->fan_min[i]  			    adm1026_read_value(client, ADM1026_REG_FAN_MIN(i));
-			data->fan_div[i] = 1 << (value & 0x03);
+			data->fan_div[i] = DIV_FROM_REG(value & 0x03);
 			value >>= 2 ;
 		}
 
