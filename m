From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Jan 2013 04:40:47 +0000
Subject: [lm-sensors] [PATCH 1/2] sensors-detect: Add detection of IT8752F
Message-Id: <1359434448-21181-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IT8752F appears to be mostly compatible to IT8728F.
Supported by HWSensors4 and derived code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    3 ++-
 prog/detect/sensors-detect |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/CHANGES b/CHANGES
index 7ef4c2b..465bd61 100644
--- a/CHANGES
+++ b/CHANGES
@@ -4,7 +4,8 @@ lm-sensors CHANGES file
 SVN HEAD
   sensors.conf.5: Mention "sensors -u" to get the raw feature names
   sensors: Clarify what option -u is good for
-  sensors-detect: Add detection of AMD family 16h power sensors
+  sensors-detect: Add detection of IT8752F
+                  Add detection of AMD family 16h power sensors
                   Map IT8771E, IT8772E, IT8782F and IT8783F to it87
                   Use /sys/module instead of /proc/modules where available
                   Drop legacy sysconfig configuration file syntax
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index a96a33e..59378c2 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2224,6 +2224,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x04,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "ITE IT8752F Super IO Sensors",
+		driver => "to-be-written",	# it87
+		devid => 0x8752,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "ITE IT8771E Super IO Sensors",
 		driver => "it87",
 		devid => 0x8771,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
