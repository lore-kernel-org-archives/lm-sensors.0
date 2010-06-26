From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Jun 2010 02:40:11 +0000
Subject: [lm-sensors] [PATCH/RFC 3/3] hwmon: Update current alarm attributes
Message-Id: <1277520011-29782-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds currX_alarm, currX_min_alarm, and currX_max_alarm attributes
to the hwmon sysfs API.

currX_min_alarm and currX_max_alarm are already supported by the LTC4215 and
LTC4245 drivers. currX_alarm is supported by the LTC4261 driver.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/sysfs-interface |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index d4e2917..520fa7a 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -471,6 +471,7 @@ limit-related alarms, not both. The driver should just reflect the hardware
 implementation.
 
 in[0-*]_alarm
+curr[1-*]_alarm
 fan[1-*]_alarm
 temp[1-*]_alarm
 		Channel alarm
@@ -482,6 +483,8 @@ OR
 
 in[0-*]_min_alarm
 in[0-*]_max_alarm
+curr[1-*]_min_alarm
+curr[1-*]_max_alarm
 fan[1-*]_min_alarm
 fan[1-*]_max_alarm
 temp[1-*]_min_alarm
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
