From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 08:31:54 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (it87) Don't arbitrarily enable
Message-Id: <20100409103154.2d0a840f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature channels can be used in 2 different modes (thermistor and
thermal diode) and we don't know which one, if any, is correct for
every given board. So don't arbitrarily choose one. Instead, leave the
temperature channels untouched. They can be configured from user-space
if needed anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.34-rc3.orig/drivers/hwmon/it87.c	2010-04-09 10:02:33.000000000 +0200
+++ linux-2.6.34-rc3/drivers/hwmon/it87.c	2010-04-09 10:02:47.000000000 +0200
@@ -545,6 +545,7 @@ static ssize_t set_sensor(struct device
 
 	mutex_lock(&data->update_lock);
 
+	data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
 	data->sensor &= ~(1 << nr);
 	data->sensor &= ~(8 << nr);
 	if (val = 2) {	/* backwards compatibility */
@@ -1841,15 +1842,6 @@ static void __devinit it87_init_device(s
 			it87_write_value(data, IT87_REG_TEMP_HIGH(i), 127);
 	}
 
-	/* Check if temperature channels are reset manually or by some reason */
-	tmp = it87_read_value(data, IT87_REG_TEMP_ENABLE);
-	if ((tmp & 0x3f) = 0) {
-		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
-		tmp = (tmp & 0xc0) | 0x2a;
-		it87_write_value(data, IT87_REG_TEMP_ENABLE, tmp);
-	}
-	data->sensor = tmp;
-
 	/* Check if voltage monitors are reset manually or by some reason */
 	tmp = it87_read_value(data, IT87_REG_VIN_ENABLE);
 	if ((tmp & 0xff) = 0) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
