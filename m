From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Jan 2011 18:46:57 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Add humidity attribute to sysfs ABI
Message-Id: <1294339617-12308-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The humidity attribute is already supported by the sht15 driver, and another
driver supporting it is about to be added. Make it official.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
v2: Updated humidity units to be reported in milli-percent

 Documentation/hwmon/sysfs-interface |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 5997b5e..79411cb 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -505,6 +505,15 @@ energy[1-*]_input		Cumulative energy use
 				RO
 
 
+************
+* Humidity *
+************
+
+humidity[1-*]_input		Humidity
+				Unit: milli-percent (per cent mille, pcm)
+				RO
+
+
 **********
 * Alarms *
 **********
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
