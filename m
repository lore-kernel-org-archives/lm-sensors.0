From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 17 Jun 2007 19:56:25 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-volt-test.patch
Message-Id: <46759456.9080905@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040806020800030607020505"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040806020800030607020505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch fixes the detection of volt inputs with a reading of more then 240
units.

Mark, please apply to your tree and send upstream.

Regards,

Hans


--------------040806020800030607020505
Content-Type: text/x-patch;
 name="hwmon-abituguru-volt-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-abituguru-volt-test.patch"

This patch fixes the detection of volt inputs with a reading of more then 240
units.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -urN linux-2.6.22-rc4.orig/drivers/hwmon/abituguru.c linux-2.6.22-rc4/drivers/hwmon/abituguru.c
--- linux-2.6.22-rc4.orig/drivers/hwmon/abituguru.c	2007-06-17 09:10:17.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/abituguru.c	2007-06-17 09:09:48.000000000 +0200
@@ -418,7 +418,7 @@
 abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 				   u8 sensor_addr)
 {
-	u8 val, buf[3];
+	u8 val, test_flag, buf[3];
 	int i, ret = -ENODEV; /* error is the most common used retval :| */
 
 	/* If overriden by the user return the user selected type */
@@ -436,7 +436,7 @@
 		return -ENODEV;
 
 	/* Test val is sane / usable for sensor type detection. */
-	if ((val < 10u) || (val > 240u)) {
+	if ((val < 10u) || (val > 250u)) {
 		printk(KERN_WARNING ABIT_UGURU_NAME
 			": bank1-sensor: %d reading (%d) too close to limits, "
 			"unable to determine sensor type, skipping sensor\n",
@@ -449,10 +449,23 @@
 
 	ABIT_UGURU_DEBUG(2, "testing bank1 sensor %d\n", (int)sensor_addr);
 	/* Volt sensor test, enable volt low alarm, set min value ridicously
-	   high. If its a volt sensor this should always give us an alarm. */
-	buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
-	buf[1] = 245;
-	buf[2] = 250;
+	   high, or vica versa if the reading is very high. If its a volt
+	   sensor this should always give us an alarm. */
+	if (val <= 240u)
+	{
+		buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
+		buf[1] = 245;
+		buf[2] = 250;
+		test_flag = ABIT_UGURU_VOLT_LOW_ALARM_FLAG;
+	}
+	else
+	{
+		buf[0] = ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE;
+		buf[1] = 5;
+		buf[2] = 10;
+		test_flag = ABIT_UGURU_VOLT_HIGH_ALARM_FLAG;
+	}
+	
 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
 			buf, 3) != 3)
 		goto abituguru_detect_bank1_sensor_type_exit;
@@ -469,13 +482,13 @@
 				sensor_addr, buf, 3,
 				ABIT_UGURU_MAX_RETRIES) != 3)
 			goto abituguru_detect_bank1_sensor_type_exit;
-		if (buf[0] & ABIT_UGURU_VOLT_LOW_ALARM_FLAG) {
+		if (buf[0] & test_flag) {
 			ABIT_UGURU_DEBUG(2, "  found volt sensor\n");
 			ret = ABIT_UGURU_IN_SENSOR;
 			goto abituguru_detect_bank1_sensor_type_exit;
 		} else
 			ABIT_UGURU_DEBUG(2, "  alarm raised during volt "
-				"sensor test, but volt low flag not set\n");
+				"sensor test, but volt range flag not set\n");
 	} else
 		ABIT_UGURU_DEBUG(2, "  alarm not raised during volt sensor "
 			"test\n");

--------------040806020800030607020505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040806020800030607020505--
