From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 09 Jul 2011 17:37:44 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: Add several attributes to sysfs ABI
Message-Id: <1310233064-3792-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add the following attributes to the sysfs ABI.

in[0-*]_average
in[0-*]_lowest
in[0-*]_highest
in[0-*]_reset_history
in_reset_history

curr[1-*]_average
curr[1-*]_lowest
curr[1-*]_highest
curr[1-*]_reset_history
curr_reset_history

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
This is a followup to my previous mail. Turns out historic attributes already
exist for temperatures, so there is nothing to do for those. I named the new
attributes to follow the historic temperature attribute names, since those seem
to be a bit more consistent than the power attribute names.

 Documentation/hwmon/sysfs-interface |   46 +++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 8f63c24..a4aa8f6 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -139,6 +139,29 @@ in[0-*]_input	Voltage input value.
 		thumb: drivers should report the voltage values at the
 		"pins" of the chip.
 
+in[0-*]_average
+		Average voltage
+		Unit: millivolt
+		RO
+
+in[0-*]_lowest
+		Historical minimum voltage
+		Unit: millivolt
+		RO
+
+in[0-*]_highest
+		Historical maximum voltage
+		Unit: millivolt
+		RO
+
+in[0-*]_reset_history
+		Reset inX_lowest and inX_highest
+		WO
+
+in_reset_history
+		Reset inX_lowest and inX_highest for all sensors
+		WO
+
 in[0-*]_label	Suggested voltage channel label.
 		Text string
 		Should only be created if the driver has hints about what
@@ -407,6 +430,29 @@ curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
 
+curr[1-*]_average
+		Average current use
+		Unit: milliampere
+		RO
+
+curr[1-*]_lowest
+		Historical minimum current
+		Unit: milliampere
+		RO
+
+curr[1-*]_highest
+		Historical maximum current
+		Unit: milliampere
+		RO
+
+curr[1-*]_reset_history
+		Reset currX_lowest and currX_highest
+		WO
+
+curr_reset_history
+		Reset currX_lowest and currX_highest for all sensors
+		WO
+
 Also see the Alarms section for status flags associated with currents.
 
 *********
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
