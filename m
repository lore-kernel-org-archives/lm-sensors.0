From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 18:53:04 +0000
Subject: [lm-sensors] [PATCH 04/23] w83791d: Documentation update
Message-Id: <20060924205304.5ecc36c2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>
Content-Disposition: inline; filename=hwmon-w83791d-doc-update.patch

w83791d: Documentation update

The alarm bits and the beep enable bits are in different positions in
the hardware. Document the problem and leave it to the user-space code
to handle the situation. When this driver is updated to the standardized
sysfs alarm/beep methodology, this won't be a problem.

This is a documentation only change.

Signed-off by: Charles Spirakis <bezaur at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/w83791d |   67 ++++++++++++++++++++++++-------------------
 drivers/hwmon/w83791d.c     |    7 ++--
 2 files changed, 41 insertions(+), 33 deletions(-)

--- linux-2.6.18.orig/Documentation/hwmon/w83791d	2006-09-23 15:24:25.000000000 +0200
+++ linux-2.6.18/Documentation/hwmon/w83791d	2006-09-23 15:51:12.000000000 +0200
@@ -5,7 +5,7 @@
   * Winbond W83791D
     Prefix: 'w83791d'
     Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83791Da.pdf
+    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83791D_W83791Gb.pdf
 
 Author: Charles Spirakis <bezaur at gmail.com>
 
@@ -20,6 +20,9 @@
     Chunhao Huang <DZShen at Winbond.com.tw>,
     Rudolf Marek <r.marek at sh.cvut.cz>
 
+Additional contributors:
+    Sven Anders <anders at anduras.de>
+
 Module Parameters
 -----------------
 
@@ -46,7 +49,8 @@
 Description
 -----------
 
-This driver implements support for the Winbond W83791D chip.
+This driver implements support for the Winbond W83791D chip. The W83791G
+chip appears to be the same as the W83791D but is lead free.
 
 Detection of the chip can sometimes be foiled because it can be in an
 internal state that allows no clean access (Bank with ID register is not
@@ -71,34 +75,36 @@
 An alarm is triggered if the voltage has crossed a programmable minimum
 or maximum limit.
 
-Alarms are provided as output from a "realtime status register". The
-following bits are defined:
+The bit ordering for the alarm "realtime status register" and the
+"beep enable registers" are different.
 
-bit - alarm on:
-0  - Vcore
-1  - VINR0
-2  - +3.3VIN
-3  - 5VDD
-4  - temp1
-5  - temp2
-6  - fan1
-7  - fan2
-8  - +12VIN
-9  - -12VIN
-10 - -5VIN
-11 - fan3
-12 - chassis
-13 - temp3
-14 - VINR1
-15 - reserved
-16 - tart1
-17 - tart2
-18 - tart3
-19 - VSB
-20 - VBAT
-21 - fan4
-22 - fan5
-23 - reserved
+in0 (VCORE)  :  alarms: 0x000001 beep_enable: 0x000001
+in1 (VINR0)  :  alarms: 0x000002 beep_enable: 0x002000 <= mismatch
+in2 (+3.3VIN):  alarms: 0x000004 beep_enable: 0x000004
+in3 (5VDD)   :  alarms: 0x000008 beep_enable: 0x000008
+in4 (+12VIN) :  alarms: 0x000100 beep_enable: 0x000100
+in5 (-12VIN) :  alarms: 0x000200 beep_enable: 0x000200
+in6 (-5VIN)  :  alarms: 0x000400 beep_enable: 0x000400
+in7 (VSB)    :  alarms: 0x080000 beep_enable: 0x010000 <= mismatch
+in8 (VBAT)   :  alarms: 0x100000 beep_enable: 0x020000 <= mismatch
+in9 (VINR1)  :  alarms: 0x004000 beep_enable: 0x004000
+temp1        :  alarms: 0x000010 beep_enable: 0x000010
+temp2        :  alarms: 0x000020 beep_enable: 0x000020
+temp3        :  alarms: 0x002000 beep_enable: 0x000002 <= mismatch
+fan1         :  alarms: 0x000040 beep_enable: 0x000040
+fan2         :  alarms: 0x000080 beep_enable: 0x000080
+fan3         :  alarms: 0x000800 beep_enable: 0x000800
+fan4         :  alarms: 0x200000 beep_enable: 0x200000
+fan5         :  alarms: 0x400000 beep_enable: 0x400000
+tart1        :  alarms: 0x010000 beep_enable: 0x040000 <= mismatch
+tart2        :  alarms: 0x020000 beep_enable: 0x080000 <= mismatch
+tart3        :  alarms: 0x040000 beep_enable: 0x100000 <= mismatch
+case_open    :  alarms: 0x001000 beep_enable: 0x001000
+user_enable  :  alarms: -------- beep_enable: 0x800000
+
+*** NOTE: It is the responsibility of user-space code to handle the fact
+that the beep enable and alarm bits are in different positions when using that
+feature of the chip.
 
 When an alarm goes off, you can be warned by a beeping signal through your
 computer speaker. It is possible to enable all beeping globally, or only
@@ -109,5 +115,6 @@
 
 W83791D TODO:
 ---------------
-Provide a patch for per-file alarms as discussed on the mailing list
+Provide a patch for per-file alarms and beep enables as defined in the hwmon
+	documentation (Documentation/hwmon/sysfs-interface)
 Provide a patch for smart-fan control (still need appropriate motherboard/fans)
--- linux-2.6.18.orig/drivers/hwmon/w83791d.c	2006-09-23 15:24:25.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/w83791d.c	2006-09-23 15:49:05.000000000 +0200
@@ -27,9 +27,9 @@
 
     The w83791d chip appears to be part way between the 83781d and the
     83792d. Thus, this file is derived from both the w83792d.c and
-    w83781d.c files, but its output is more along the lines of the
-    83781d (which means there are no changes to the user-mode sensors
-    program which treats the 83791d as an 83781d).
+    w83781d.c files.
+
+    The w83791g chip is the same as the w83791d but lead-free.
 */
 
 #include <linux/config.h>
@@ -1172,6 +1172,7 @@
 			(w83791d_read(client, W83791D_REG_BEEP_CTRL[1]) << 8) +
 			(w83791d_read(client, W83791D_REG_BEEP_CTRL[2]) << 16);
 
+		/* Extract global beep enable flag */
 		data->beep_enable  			(data->beep_mask >> GLOBAL_BEEP_ENABLE_SHIFT) & 0x01;
 

-- 
Jean Delvare

