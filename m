From: linux@horizon.com
Date: Sun, 17 Jun 2007 13:00:56 +0000
Subject: Re: [lm-sensors] Is it possible to raise the abituguru voltage test
Message-Id: <20070617130056.14577.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613121553.17775.qmail@science.horizon.com>
In-Reply-To: <20070613121553.17775.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Something like that should work yes, good idea. Attached is a version
> with this implemented. I've attached a makefile for easy out of tree
> compilation too, just drop the makefile and abituguru.c in a dir, type
> make and you should get an abituguru.ko to insmod.

Ah, oops.  I should have sent you what I implemented and tested.  Now
I'll go test yours.

One thing I noticed in code review: if the reading is very low, do
you want to bother doing the temperature test?  It seems like it would
never alarm, so is just a waste of time.

> Please let me know how this works for you. Notice that I only use the
> volt high test for readings > 240, as this is delicated code and I do
> not want to change the code path for already working setups.

Yes, yours works too, even with the changeover level moved to 20 to
get a better test.  Um... what does "delicated" mean?  Delicate?


My (tested and working) variant is enclosed.  Note the "temp too low
to test" condition you don't have.  Another version is coming next e-mail.

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index bede4d9..9a25dd0 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -418,7 +418,7 @@ static int __devinit
 abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 				   u8 sensor_addr)
 {
-	u8 val, buf[3];
+	u8 val, buf[3], flag;
 	int i, ret = -ENODEV; /* error is the most common used retval :| */
 
 	/* If overriden by the user return the user selected type */
@@ -435,24 +435,23 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 			1, ABIT_UGURU_MAX_RETRIES) != 1)
 		return -ENODEV;
 
-	/* Test val is sane / usable for sensor type detection. */
-	if ((val < 10u) || (val > 240u)) {
-		printk(KERN_WARNING ABIT_UGURU_NAME
-			": bank1-sensor: %d reading (%d) too close to limits, "
-			"unable to determine sensor type, skipping sensor\n",
-			(int)sensor_addr, (int)val);
-		/* assume no sensor is there for sensors for which we can't
-		   determine the sensor type because their reading is too close
-		   to their limits, this usually means no sensor is there. */
-		return ABIT_UGURU_NC;
-	}
-
 	ABIT_UGURU_DEBUG(2, "testing bank1 sensor %d\n", (int)sensor_addr);
 	/* Volt sensor test, enable volt low alarm, set min value ridicously
 	   high. If its a volt sensor this should always give us an alarm. */
-	buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
-	buf[1] = 245;
-	buf[2] = 250;
+	if (val < 128) {
+		ABIT_UGURU_DEBUG(2, "Value = %d; using low alarm\n", val);
+		buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
+		buf[1] = 245;
+		buf[2] = 250;
+		flag = ABIT_UGURU_VOLT_LOW_ALARM_FLAG;
+	} else {
+		ABIT_UGURU_DEBUG(2, "Value = %d; using high alarm\n", val);
+		buf[0] = ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE;
+		buf[1] = 5;
+		buf[2] = 10;
+		flag = ABIT_UGURU_VOLT_HIGH_ALARM_FLAG;
+	}
+
 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
 			buf, 3) != 3)
 		goto abituguru_detect_bank1_sensor_type_exit;
@@ -469,17 +468,29 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 				sensor_addr, buf, 3,
 				ABIT_UGURU_MAX_RETRIES) != 3)
 			goto abituguru_detect_bank1_sensor_type_exit;
-		if (buf[0] & ABIT_UGURU_VOLT_LOW_ALARM_FLAG) {
+		if (buf[0] & flag) {
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
 
+	/* Test val is sane / usable for sensor type detection. */
+	if (val < 10u) {
+		printk(KERN_WARNING ABIT_UGURU_NAME
+			": bank1-sensor: %d reading (%d) too close to limits, "
+			"unable to determine sensor type, skipping sensor\n",
+			(int)sensor_addr, (int)val);
+		/* assume no sensor is there for sensors for which we can't
+		   determine the sensor type because their reading is too close
+		   to their limits, this usually means no sensor is there. */
+		goto abituguru_detect_bank1_sensor_type_nc;
+	}
+
 	/* Temp sensor test, enable sensor as a temp sensor, set beep value
 	   ridicously low (but not too low, otherwise uguru ignores it).
 	   If its a temp sensor this should always give us an alarm. */
@@ -513,6 +524,7 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 		ABIT_UGURU_DEBUG(2, "  alarm not raised during temp sensor "
 			"test\n");
 
+abituguru_detect_bank1_sensor_type_nc:
 	ret = ABIT_UGURU_NC;
 abituguru_detect_bank1_sensor_type_exit:
 	/* Restore original settings, failing here is really BAD, it has been


And they produce the output:
abituguru: testing bank1 sensor 0
abituguru: Value = 35; using low alarm
abituguru:   alarm not raised during volt sensor test
abituguru:   found temp sensor
abituguru: testing bank1 sensor 1
abituguru: Value = 26; using low alarm
abituguru:   alarm not raised during volt sensor test
abituguru:   found temp sensor
abituguru: testing bank1 sensor 3
abituguru: Value = 101; using low alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 4
abituguru: Value = 193; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 10
abituguru: Value = 97; using low alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 8
abituguru: Value = 116; using low alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 14
abituguru: Value = 184; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 2
abituguru: Value = 89; using low alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 9
abituguru: Value = 241; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 6
abituguru: Value = 209; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 5
abituguru: Value = 195; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 11
abituguru: Value = 209; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 15
abituguru: Value = 29; using low alarm
abituguru:   alarm not raised during volt sensor test
abituguru:   found temp sensor
abituguru: testing bank1 sensor 13
abituguru: Value = 216; using high alarm
abituguru:   found volt sensor
abituguru: testing bank1 sensor 7
abituguru: Value = 118; using low alarm
abituguru:   alarm not raised during volt sensor test
abituguru:   alarm not raised during temp sensor test
abituguru: testing bank1 sensor 12
abituguru: Value = 0; using low alarm
abituguru:   alarm not raised during volt sensor test
abituguru: bank1-sensor: 12 reading (0) too close to limits, unable to determine sensor type, skipping sensor
abituguru: detecting number of fan sensors
abituguru:   bank2 sensor 5 does not seem to be a fan sensor: the threshold (0) is below the minimum (5)
abituguru:  found: 5 fan sensors
abituguru: detecting number of PWM outputs
abituguru:   pwm channel 3 does not seem to be a pwm channel: settings[0] = C9
abituguru:  found: 3 PWM outputs

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
