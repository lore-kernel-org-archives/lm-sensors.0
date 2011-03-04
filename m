From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 15:09:46 +0000
Subject: [lm-sensors] [PATCH] libsensors: Add support for fanX_pulses sysfs
Message-Id: <20110304150946.GA1804@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for the fanX_pulses sysfs attribute.

--
Index: lib/sensors.h
=================================--- lib/sensors.h	(revision 5937)
+++ lib/sensors.h	(working copy)
@@ -170,6 +170,7 @@
 	SENSORS_SUBFEATURE_FAN_FAULT,
 	SENSORS_SUBFEATURE_FAN_DIV,
 	SENSORS_SUBFEATURE_FAN_BEEP,
+	SENSORS_SUBFEATURE_FAN_PULSES,
 
 	SENSORS_SUBFEATURE_TEMP_INPUT = SENSORS_FEATURE_TEMP << 8,
 	SENSORS_SUBFEATURE_TEMP_MAX,
Index: lib/sysfs.c
=================================--- lib/sysfs.c	(revision 5937)
+++ lib/sysfs.c	(working copy)
@@ -265,6 +265,7 @@
 	{ "input", SENSORS_SUBFEATURE_FAN_INPUT },
 	{ "min", SENSORS_SUBFEATURE_FAN_MIN },
 	{ "div", SENSORS_SUBFEATURE_FAN_DIV },
+	{ "pulses", SENSORS_SUBFEATURE_FAN_PULSES },
 	{ "alarm", SENSORS_SUBFEATURE_FAN_ALARM },
 	{ "fault", SENSORS_SUBFEATURE_FAN_FAULT },
 	{ "beep", SENSORS_SUBFEATURE_FAN_BEEP },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
