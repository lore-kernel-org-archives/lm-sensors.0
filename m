From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2012 09:35:20 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix chip feature table headers
Message-Id: <20121023113520.72087ec4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: Fix chip feature table headers

These got broken by recent patches fixing checkpatch warnings in these
drivers. The trick is that the patches themselves looked good, but the
source files after applying them do not. That's why I am not a big fan
of using tabs inside comments.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asb100.c    |    2 +-
 drivers/hwmon/w83627hf.c  |    2 +-
 drivers/hwmon/w83781d.c   |    2 +-
 drivers/hwmon/w83791d.c   |    2 +-
 drivers/hwmon/w83792d.c   |    2 +-
 drivers/hwmon/w83l786ng.c |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-3.7-rc2.orig/drivers/hwmon/asb100.c	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/asb100.c	2012-10-23 11:27:47.274320737 +0200
@@ -32,7 +32,7 @@
  * ASB100-A supports pwm1, while plain ASB100 does not.  There is no known
  * way for the driver to tell which one is there.
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * asb100	7	3	1	4	0x31	0x0694	yes	no
  */
 
--- linux-3.7-rc2.orig/drivers/hwmon/w83627hf.c	2012-10-23 11:23:21.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83627hf.c	2012-10-23 11:28:13.640347494 +0200
@@ -25,7 +25,7 @@
 /*
  * Supports following chips:
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
  * w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
  * w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
--- linux-3.7-rc2.orig/drivers/hwmon/w83781d.c	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83781d.c	2012-10-23 11:28:17.467351377 +0200
@@ -24,7 +24,7 @@
 /*
  * Supports following chips:
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * as99127f	7	3	0	3	0x31	0x12c3	yes	no
  * as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
  * w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
--- linux-3.7-rc2.orig/drivers/hwmon/w83791d.c	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83791d.c	2012-10-23 11:28:04.775338497 +0200
@@ -22,7 +22,7 @@
 /*
  * Supports following chips:
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * w83791d	10	5	5	3	0x71	0x5ca3	yes	no
  *
  * The w83791d chip appears to be part way between the 83781d and the
--- linux-3.7-rc2.orig/drivers/hwmon/w83792d.c	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83792d.c	2012-10-23 11:28:10.088343889 +0200
@@ -31,7 +31,7 @@
 /*
  * Supports following chips:
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * w83792d	9	7	7	3	0x7a	0x5ca3	yes	no
  */
 
--- linux-3.7-rc2.orig/drivers/hwmon/w83l786ng.c	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83l786ng.c	2012-10-23 11:28:01.912335592 +0200
@@ -20,7 +20,7 @@
 /*
  * Supports following chips:
  *
- * Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
+ * Chip		#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
  * w83l786ng	3	2	2	2	0x7b	0x5ca3	yes	no
  */
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
