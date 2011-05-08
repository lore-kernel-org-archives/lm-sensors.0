From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 May 2011 08:46:00 +0000
Subject: [lm-sensors] [PATCH] i8k: Properly handle errors
Message-Id: <20110508104600.0bae8f45@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My code originally didn't expect the temperature sensor to be missing,
and also didn't properly handle run-time errors. This is fixed now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Massimo Dal Zotto <dz@debian.org>
---
I'll merge this fix in patch "i8k: Integrate with the hwmon subsystem".

 drivers/char/i8k.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- linux-2.6.39-rc6.orig/drivers/char/i8k.c	2011-05-07 19:10:27.000000000 +0200
+++ linux-2.6.39-rc6/drivers/char/i8k.c	2011-05-08 10:32:56.000000000 +0200
@@ -473,6 +473,8 @@ static ssize_t i8k_hwmon_show_temp(struc
 	int cpu_temp;
 
 	cpu_temp = i8k_get_temp(0);
+	if (cpu_temp < 0)
+		return cpu_temp;
 	return sprintf(buf, "%d\n", cpu_temp * 1000);
 }
 
@@ -484,6 +486,8 @@ static ssize_t i8k_hwmon_show_fan(struct
 	int fan_speed;
 
 	fan_speed = i8k_get_fan_speed(index);
+	if (fan_speed < 0)
+		return fan_speed;
 	return sprintf(buf, "%d\n", fan_speed);
 }
 
@@ -541,14 +545,20 @@ static int __init i8k_init_hwmon(void)
 	if (err)
 		goto exit_unregister;
 
-	/* CPU temperature attributes */
-	err = device_create_file(i8k_hwmon_dev, &dev_attr_temp1_input);
-	if (err)
-		goto exit_remove_files;
-	err = device_create_file(i8k_hwmon_dev,
-				 &sensor_dev_attr_temp1_label.dev_attr);
-	if (err)
-		goto exit_remove_files;
+	/* CPU temperature attributes, if temperature reading is OK */
+	err = i8k_get_temp(0);
+	if (err < 0) {
+		dev_dbg(i8k_hwmon_dev,
+			"Not creating temperature attributes (%d)\n", err);
+	} else {
+		err = device_create_file(i8k_hwmon_dev, &dev_attr_temp1_input);
+		if (err)
+			goto exit_remove_files;
+		err = device_create_file(i8k_hwmon_dev,
+					 &sensor_dev_attr_temp1_label.dev_attr);
+		if (err)
+			goto exit_remove_files;
+	}
 
 	/* Left fan attributes, if left fan is present */
 	err = i8k_get_fan_status(I8K_FAN_LEFT);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
