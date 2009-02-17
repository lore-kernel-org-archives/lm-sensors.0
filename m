From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 22:02:15 +0000
Subject: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <20090217230215.5106b6c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

A number of users have asked us to support the chassis intrusion
detection feature which some hardware monitoring chip have. I've
created a ticket for this:
http://www.lm-sensors.org/ticket/2370
Here is a proposal.

sysfs interface
=======
chassis_intrusion
		Chassis intrusion detection
		0: OK
		1: intrusion detected
		RW
		Writing 0 clears the detection flag.
		Writing other values is unsupported.

It's not totally clear whether clearing should be done by writing 0 or
1. 0 is more respectful of traditional sysfs semantics that you should
be able to read back what you just wrote, so it has my vote.

drivers
===
Drivers adm9240, w83792d and w83793 implement this feature in
non-standard ways. They should be converted to the new, standard
interface.

libsensors
=====

Either

SENSORS_FEATURE_CHASSIS_INTRUSION = 0x19
SENSORS_SUBFEATURE_CHASSIS_INTRUSION = SENSORS_FEATURE_CHASSIS_INTRUSION << 8

or rename SENSORS_FEATURE_BEEP_ENABLE to SENSORS_FEATURE_MISC and

SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_MISC << 8
SENSORS_SUBFEATURE_CHASSIS_INTRUSION = (SENSORS_FEATURE_MISC << 8) + 1

sensors
===
Reading the value of the chassis intrusion detection subfeature is done
like for any other subfeature.

Writing, OTOH, can't be handled the same as writing limits, because we
certainly don't want to clear the flag automatically at lm_sensors
start or restart time. So we could add a dedicated flag to clear the
chassis intrusion detection flag (e.g. "sensors --clear-chassis").

If anyone has objections or comments, please speak up.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
