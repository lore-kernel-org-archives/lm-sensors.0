From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 02 Mar 2011 23:23:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add tachometer pulses per fan
Message-Id: <1299108238-14822-1-git-send-email-guenter.roeck@ericsson.com>
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
 Documentation/hwmon/sysfs-interface |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index c6559f1..134c6a4 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -187,6 +187,12 @@ fan[1-*]_div	Fan divisor.
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
+fan[1-*]_pulses	Number of tachometer pulses per fan revolution.
+		Integer value, typically between 1 and 4.
+		RW
+		Should only be created if the chip has a register to configure
+		the value.
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
