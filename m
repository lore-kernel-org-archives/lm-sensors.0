From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 18 Sep 2011 18:55:17 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: Add unspecified temperature
Message-Id: <1316372117-3365-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some recent temperature sensor chips provide thresholds which are not associated
with lower or upper limits. The use of those thresholds is application specific.

Provide sysfs ABI attributes to support such thresholds.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Something like that ?

Question is if the first threshold should be numbered 0 or 1.
I started with 1 for now since tempX also starts with 1.

 Documentation/hwmon/sysfs-interface |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index a4aa8f6..e65e7e8 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -394,6 +394,18 @@ temp_reset_history
 		Reset temp_lowest and temp_highest for all sensors
 		WO
 
+temp[1-*]_threshold[1-*]
+		Unspecified threshold. Use if the chip provides temperature
+		thresholds which are not associated with lower or upper limits.
+		RW
+		Unit: millidegree Celsius
+
+temp[1-*]_threshold[1-*]_triggered
+		Channel trigger information.
+		0: Temperature is below threshold.
+		1: Temperature is at or above threshold.
+		RO
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
