From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 20:02:09 +0000
Subject: [lm-sensors] [PATCH 6/6] w83627ehf: Fix the detection of fan5
Message-Id: <20061008220209.b58acd71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at assembler.cz>
Content-Disposition: inline; filename=hwmon-w83627ehf-fix-fan5-detection.patch

Fix the detection of fan5 and preserve the bit between the
register writes, because the bit is write only.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc1.orig/drivers/hwmon/w83627ehf.c	2006-10-08 12:29:27.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/w83627ehf.c	2006-10-08 12:39:24.000000000 +0200
@@ -354,6 +354,8 @@
 	case 0:
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0xcf)
 		    | ((data->fan_div[0] & 0x03) << 4);
+		/* fan5 input control bit is write only, compute the value */
+		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
 		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xdf)
 		    | ((data->fan_div[0] & 0x04) << 3);
@@ -362,6 +364,8 @@
 	case 1:
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0x3f)
 		    | ((data->fan_div[1] & 0x03) << 6);
+		/* fan5 input control bit is write only, compute the value */
+		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
 		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xbf)
 		    | ((data->fan_div[1] & 0x04) << 4);
@@ -1216,13 +1220,16 @@
 	superio_exit();
 
 	/* It looks like fan4 and fan5 pins can be alternatively used
-	   as fan on/off switches */
+	   as fan on/off switches, but fan5 control is write only :/
+	   We assume that if the serial interface is disabled, designers
+	   connected fan5 as input unless they are emitting log 1, which
+	   is not the default. */
 
 	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
 	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
 	if ((i & (1 << 2)) && (!fan4pin))
 		data->has_fan |= (1 << 3);
-	if ((i & (1 << 0)) && (!fan5pin))
+	if (!(i & (1 << 1)) && (!fan5pin))
 		data->has_fan |= (1 << 4);
 
 	/* Register sysfs hooks */

-- 
Jean Delvare

