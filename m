From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 28 Oct 2012 18:19:58 +0000
Subject: [lm-sensors] [PATCH 6/9] hwmon: (it87) Avoid quoted string splits across lines
Message-Id: <1351448401-13985-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix the respective checkpatch warnings.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index c6426c0..50e1017 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -601,8 +601,8 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 	reg &= ~(1 << nr);
 	reg &= ~(8 << nr);
 	if (val = 2) {	/* backwards compatibility */
-		dev_warn(dev, "Sensor type 2 is deprecated, please use 4 "
-			 "instead\n");
+		dev_warn(dev,
+			 "Sensor type 2 is deprecated, please use 4 instead\n");
 		val = 4;
 	}
 	/* 3 = thermal diode; 4 = thermistor; 0 = disabled */
@@ -801,8 +801,8 @@ static int check_trip_points(struct device *dev, int nr)
 	}
 
 	if (err) {
-		dev_err(dev, "Inconsistent trip points, not switching to "
-			"automatic mode\n");
+		dev_err(dev,
+			"Inconsistent trip points, not switching to automatic mode\n");
 		dev_err(dev, "Adjust the trip points and try again\n");
 	}
 	return err;
@@ -2110,8 +2110,8 @@ static int __devinit it87_check_pwm(struct device *dev)
 			 * PWM interface).
 			 */
 			if (!((pwm[0] | pwm[1] | pwm[2]) & 0x80)) {
-				dev_info(dev, "Reconfiguring PWM to "
-					 "active high polarity\n");
+				dev_info(dev,
+					 "Reconfiguring PWM to active high polarity\n");
 				it87_write_value(data, IT87_REG_FAN_CTL,
 						 tmp | 0x87);
 				for (i = 0; i < 3; i++)
@@ -2121,16 +2121,16 @@ static int __devinit it87_check_pwm(struct device *dev)
 				return 1;
 			}
 
-			dev_info(dev, "PWM configuration is "
-				 "too broken to be fixed\n");
+			dev_info(dev,
+				 "PWM configuration is too broken to be fixed\n");
 		}
 
-		dev_info(dev, "Detected broken BIOS "
-			 "defaults, disabling PWM interface\n");
+		dev_info(dev,
+			 "Detected broken BIOS defaults, disabling PWM interface\n");
 		return 0;
 	} else if (fix_pwm_polarity) {
-		dev_info(dev, "PWM configuration looks "
-			 "sane, won't touch\n");
+		dev_info(dev,
+			 "PWM configuration looks sane, won't touch\n");
 	}
 
 	return 1;
@@ -2440,8 +2440,7 @@ static void __exit sm_it87_exit(void)
 }
 
 
-MODULE_AUTHOR("Chris Gauthron, "
-	      "Jean Delvare <khali@linux-fr.org>");
+MODULE_AUTHOR("Chris Gauthron, Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("IT8705F/IT871xF/IT872xF hardware monitoring driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
