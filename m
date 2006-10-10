From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 10 Oct 2006 20:54:31 +0000
Subject: [lm-sensors] patch hwmon-w83627ehf-fix-fan5-detection.patch added
Message-Id: <20061010205423.7B0746122ED@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 6/6] w83627ehf: Fix the detection of fan5

to my gregkh-2.6 tree.  Its filename is

     hwmon-w83627ehf-fix-fan5-detection.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Oct  8 13:02:21 2006
Date: Sun, 8 Oct 2006 22:02:09 +0200
From: Rudolf Marek <r.marek at assembler.cz>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Rudolf Marek <r.marek at assembler.cz>
Subject: [PATCH 6/6] w83627ehf: Fix the detection of fan5
Message-Id: <20061008220209.b58acd71.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-w83627ehf-fix-fan5-detection.patch

From: Rudolf Marek <r.marek at assembler.cz>

Fix the detection of fan5 and preserve the bit between the
register writes, because the bit is write only.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/w83627ehf.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/w83627ehf.c
+++ gregkh-2.6/drivers/hwmon/w83627ehf.c
@@ -354,6 +354,8 @@ static void w83627ehf_write_fan_div(stru
 	case 0:
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0xcf)
 		    | ((data->fan_div[0] & 0x03) << 4);
+		/* fan5 input control bit is write only, compute the value */
+		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
 		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xdf)
 		    | ((data->fan_div[0] & 0x04) << 3);
@@ -362,6 +364,8 @@ static void w83627ehf_write_fan_div(stru
 	case 1:
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0x3f)
 		    | ((data->fan_div[1] & 0x03) << 6);
+		/* fan5 input control bit is write only, compute the value */
+		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
 		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
 		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xbf)
 		    | ((data->fan_div[1] & 0x04) << 4);
@@ -1216,13 +1220,16 @@ static int w83627ehf_detect(struct i2c_a
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


Patches currently in gregkh-2.6 which might be from r.marek at assembler.cz are

i2c/hwmon-k8temp-documentation-update.patch
i2c/hwmon-w83627ehf-fix-fan5-detection.patch

