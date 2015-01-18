From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 18 Jan 2015 22:48:23 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of IT8731F and IT8732F
Message-Id: <1421621303-7375-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8731F is found on Lenovo M92p-2988.
IT8732F is found on Gigabyte GA-6LXSL.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |  1 +
 prog/detect/sensors-detect | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/CHANGES b/CHANGES
index 9304ce2..128699b 100644
--- a/CHANGES
+++ b/CHANGES
@@ -28,6 +28,7 @@ SVN HEAD
                   Add detection of TMP400 and TMP435
                   Add detection of IT8786E
                   Add detection of IT8780F
+                  Add detection of IT8731F and IT8732F
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index c5a49f5..6fb9218 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2353,6 +2353,18 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x04,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "ITE IT8731F Super IO Sensors",
+		driver => "to-be-written",	# it87
+		devid => 0x8731,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
+		name => "ITE IT8732F Super IO Sensors",
+		driver => "to-be-written",	# it87
+		devid => 0x8732,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "ITE IT8752F Super IO Sensors",
 		driver => "to-be-written",	# it87
 		devid => 0x8752,
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
