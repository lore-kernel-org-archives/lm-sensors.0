From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Mar 2012 08:03:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix temp2 source for W83627UHG
Message-Id: <20120313090327.657d702f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Properly set the source of temp2 for the W83627UHG. Also fix a
comment right before that, and document the W83627UHG as reporting up
to 3 temperatures.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: stable@vger.kernel.org
---
 Documentation/hwmon/w83627ehf |    2 +-
 drivers/hwmon/w83627ehf.c     |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-3.3-rc7.orig/drivers/hwmon/w83627ehf.c	2012-03-13 08:44:34.000000000 +0100
+++ linux-3.3-rc7/drivers/hwmon/w83627ehf.c	2012-03-13 08:46:26.824677268 +0100
@@ -39,7 +39,7 @@
 					       0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
     w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
-    w83627uhg    8      2       2       2      0xa230 0xc1    0x5ca3
+    w83627uhg    8      2       2       3      0xa230 0xc1    0x5ca3
     w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
     w83667hg-b   9      5       3       4      0xb350 0xc1    0x5ca3
     nct6775f     9      4       3       9      0xb470 0xc1    0x5ca3
@@ -2157,16 +2157,16 @@ static int __devinit w83627ehf_probe(str
 		w83627ehf_set_temp_reg_ehf(data, 3);
 
 		/*
-		 * Temperature sources for temp1 and temp2 are selected with
+		 * Temperature sources for temp2 and temp3 are selected with
 		 * bank 0, registers 0x49 and 0x4a.
 		 */
 		data->temp_src[0] = 0;	/* SYSTIN */
 		reg = w83627ehf_read_value(data, 0x49) & 0x07;
 		/* Adjust to have the same mapping as other source registers */
 		if (reg = 0)
-			data->temp_src[1]++;
+			data->temp_src[1] = 1;
 		else if (reg >= 2 && reg <= 5)
-			data->temp_src[1] += 2;
+			data->temp_src[1] = reg + 2;
 		else	/* should never happen */
 			data->have_temp &= ~(1 << 1);
 		reg = w83627ehf_read_value(data, 0x4a);
--- linux-3.3-rc7.orig/Documentation/hwmon/w83627ehf	2012-02-11 22:51:12.000000000 +0100
+++ linux-3.3-rc7/Documentation/hwmon/w83627ehf	2012-03-13 08:55:43.282772621 +0100
@@ -50,7 +50,7 @@ W83627DHG, W83627DHG-P, W83627UHG, W8366
 (NCT6775F), and NCT6776F super I/O chips. We will refer to them collectively
 as Winbond chips.
 
-The chips implement 2 to 4 temperature sensors (9 for NCT6775F and NCT6776F),
+The chips implement 3 to 4 temperature sensors (9 for NCT6775F and NCT6776F),
 2 to 5 fan rotation speed sensors, 8 to 10 analog voltage sensors, one VID
 (except for 627UHG), alarms with beep warnings (control unimplemented),
 and some automatic fan regulation strategies (plus manual fan control mode).


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
