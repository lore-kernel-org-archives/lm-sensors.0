From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 02:04:24 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Add tachometer pulses per fan
Message-Id: <1299204264-10435-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some fan control chips support a configuration register to set the number of
tachometer pulses per fan revolution. Add an ABI attribute to support this
configuration register.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Added more details to attribute description

 Documentation/hwmon/sysfs-interface |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index c6559f1..83a6987 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -187,6 +187,17 @@ fan[1-*]_div	Fan divisor.
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
+fan[1-*]_pulses	Number of tachometer pulses per fan revolution.
+		Integer value, typically between 1 and 4.
+		RW
+		This value is a characteristic of the fan connected to the
+		device's input, so it has to be set in accordance with the fan
+		model.
+		Should only be created if the chip has a register to configure
+		the number of pulses. In the absence of such a register (and
+		thus attribute) the value assumed by all devices is 2 pulses
+		per fan revolution.
+
 fan[1-*]_target
 		Desired fan speed
 		Unit: revolution/min (RPM)
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
