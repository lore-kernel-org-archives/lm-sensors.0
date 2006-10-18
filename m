From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:37 +0000
Subject: [lm-sensors] [PATCH 6/8] w83627ehf: Fix the detection of fan5
Message-Id: <11612021961186-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at assembler.cz>

Fix the detection of fan5 and preserve the bit between the
register writes, because the bit is write only.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/w83627ehf.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 833faa2..2257806 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
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
-- 
1.4.2.4


