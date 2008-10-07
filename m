From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 18:25:54 +0000
Subject: [lm-sensors] [PATCH 3/6] hwmon: (w83781d) Additional information
Message-Id: <20081007202554.64b6d8f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This information was provided in lm-sensors ticket #2350:
http://www.lm-sensors.org/ticket/2350

This is IMHO still not enough to be able to safely implement fan
control support for the AS99127F, but this is valuable information so
I am adding it to the documentation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/w83781d |   37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc8.orig/Documentation/hwmon/w83781d	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.27-rc8/Documentation/hwmon/w83781d	2008-10-04 13:36:02.000000000 +0200
@@ -353,7 +353,7 @@ in6%5
 
 # PWM
 
-Additional info about PWM on the AS99127F (may apply to other Asus
+* Additional info about PWM on the AS99127F (may apply to other Asus
 chips as well) by Jean Delvare as of 2004-04-09:
 
 AS99127F revision 2 seems to have two PWM registers at 0x59 and 0x5A,
@@ -396,7 +396,7 @@ Please contact us if you can figure out
 long as we don't know more, the w83781d driver doesn't handle PWM on
 AS99127F chips at all.
 
-Additional info about PWM on the AS99127F rev.1 by Hector Martin:
+* Additional info about PWM on the AS99127F rev.1 by Hector Martin:
 
 I've been fiddling around with the (in)famous 0x59 register and
 found out the following values do work as a form of coarse pwm:
@@ -418,3 +418,36 @@ change.
 My mobo is an ASUS A7V266-E. This behavior is similar to what I got
 with speedfan under Windows, where 0-15% would be off, 15-2x% (can't
 remember the exact value) would be 70% and higher would be full on.
+
+* Additional info about PWM on the AS99127F rev.1 from lm-sensors
+  ticket #2350:
+
+I conducted some experiment on Asus P3B-F motherboard with AS99127F
+(Ver. 1).
+
+I confirm that 0x59 register control the CPU_Fan Header on this
+motherboard, and 0x5a register control PWR_Fan.
+
+In order to reduce the dependency of specific fan, the measurement is
+conducted with a digital scope without fan connected. I found out that
+P3B-F actually output variable DC voltage on fan header center pin,
+looks like PWM is filtered on this motherboard.
+
+Here are some of measurements:
+
+0x80     20 mV
+0x81     20 mV
+0x82    232 mV
+0x83   1.2  V
+0x84   2.31 V
+0x85   3.44 V
+0x86   4.62 V
+0x87   5.81 V
+0x88   7.01 V
+9x89   8.22 V
+0x8a   9.42 V
+0x8b  10.6  V
+0x8c  11.9  V
+0x8d  12.4  V
+0x8e  12.4  V
+0x8f  12.4  V

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
