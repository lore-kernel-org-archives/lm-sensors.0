From: linux@horizon.com
Date: Wed, 13 Jun 2007 12:15:53 +0000
Subject: [lm-sensors] Is it possible to raise the abituguru voltage test
Message-Id: <20070613121553.17775.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On my motherboard, bank 1 input 13 is not connected to 3VDual, but rather
to the +12V line via a 23/96 voltage divider.  (At least, that's the
ratio that makes the raw in10 limit voltages of 2.3V and 3.45V match
the 9.6 and 14.4 V limits reported by the BIOS.)

I had more significant problems with +5SB on input 9 (in6).  This is
labelled "AGP VDDQ", and appears to be connected straight through,
but is a 3.3V level on my system.  That's very close to the 3.5V Vref,
leading to a raw reading of 241.

That makes the sensor type determination say:

> abituguru: bank1-sensor: 9 reading (241) too close to limits, unable to determine sensor type, skipping sensor

Changing the code to have a limit of 245 (using a min and max of 250 and 253)
seems to work, and saves me an annoying bank1_types=-1,...,-1,0 parameter.

Then I get:
AGP VDDQ Voltage:       +3.30 V (min  +3.00 V, max  +3.49 V)
ATX +5V:                +5.10 V (min  +4.75 V, max  +5.24 V)
ATX +3.3V:              +3.33 V (min  +3.13 V, max  +3.47 V)

Not that I have an AGP slot, but it's something.

Actually, couldn't the code be amended to set the maximum very low if the
reading is high and detect a voltage sensor with ANY reading that way?

Something like (diff-like markers inserted by hand):

	ABIT_UGURU_DEBUG(2, "testing bank1 sensor %d\n", (int)sensor_addr);
	/* Volt sensor test: enable volt low alarm, set min value ridicously
	   high. If its a volt sensor this should always give us an alarm.
	   If the voltage is high, do the opposite. */

!	if (val < 128) {
!		buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
!		buf[1] = 245;	/* Very high minimum value */
!		buf[2] = 250;
!		flag = ABIT_UGURU_VOLT_LOW_ALARM_FLAG;
!	} else {
!		buf[0] = ABIT_UGURU_VOLT_HIGH_ALARM_ENABLE;
!		buf[1] = 5;
!		buf[2] = 10;	/* Very low maximum value */
!		flag = ABIT_UGURU_VOLT_HIGH_ALARM_FLAG;
!	}
	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
			buf, 3) != 3)
		goto abituguru_detect_bank1_sensor_type_exit;
	/* Now we need 20 ms to give the uguru time to read the sensors
	   and raise a voltage alarm */
	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule_timeout(HZ/50);
	/* Check for alarm and check the alarm is a volt low alarm. */
	if (abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0, buf, 3,
			ABIT_UGURU_MAX_RETRIES) != 3)
		goto abituguru_detect_bank1_sensor_type_exit;
	if (buf[sensor_addr/8] & (0x01 << (sensor_addr % 8))) {
		if (abituguru_read(data, ABIT_UGURU_SENSOR_BANK1 + 1,
				sensor_addr, buf, 3,
				ABIT_UGURU_MAX_RETRIES) != 3)
			goto abituguru_detect_bank1_sensor_type_exit;
!		if (buf[0] & flag) {
			ABIT_UGURU_DEBUG(2, "  found volt sensor\n");
			ret = ABIT_UGURU_IN_SENSOR;
			goto abituguru_detect_bank1_sensor_type_exit;
		} else
			ABIT_UGURU_DEBUG(2, "  alarm raised during volt "
				"sensor test, but volt range flag not set\n");
	} else
		ABIT_UGURU_DEBUG(2, "  alarm not raised during volt sensor "
			"test\n");

!	/* Test temperature is sane; we need to be able to set the alarm */
!	if (val < 15u) {
		printk(KERN_WARNING ABIT_UGURU_NAME
			": bank1-sensor: %d reading (%d) too close to limits, "
			"unable to determine sensor type, skipping sensor\n",
			(int)sensor_addr, (int)val);
		/* assume no sensor is there for sensors for which we can't
		   determine the sensor type because their reading is too close
		   to their limits, this usually means no sensor is there. */
!		ret = ABIT_UGURU_NC;
!		goto abituguru_detect_bank1_sensor_type_exit;
	}


Alternatively, if you wanted to ignore very low voltages as well as
temperatures, just use the "voltage too high" alarm for all testing.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
