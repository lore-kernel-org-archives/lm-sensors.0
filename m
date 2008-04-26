From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Apr 2008 14:34:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7473) Initialize
Message-Id: <20080426163426.7684ce5d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

data->max_duty_at_overheat is not updated in adt7473_update_device,
so it might be used before it is initialized (if the user reads from
sysfs file max_duty_at_crit before writing to it.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/adt7473.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.26-rc0.orig/drivers/hwmon/adt7473.c	2008-04-26 15:36:41.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/adt7473.c	2008-04-26 16:15:05.000000000 +0200
@@ -298,6 +298,9 @@ no_sensor_update:
 						ADT7473_REG_PWM_BHVR(i));
 	}
 
+	i = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG4);
+	data->max_duty_at_overheat = !!(i & ADT7473_CFG4_MAX_DUTY_AT_OVT);
+
 	data->limits_last_updated = local_jiffies;
 	data->limits_valid = 1;
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
