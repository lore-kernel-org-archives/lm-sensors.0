From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Jul 2013 05:05:02 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6681D, NCT6682D, and NCT6683D
Message-Id: <1372655102-8946-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6683D is found on recent Intel mainboards (eg DH87MC, DH87RL).
NCT6681D is mentioned on the Nuvoton web site. NCT6682D is similar
to NCT6681D with added support for current monitoring.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    1 +
 prog/detect/sensors-detect |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/CHANGES b/CHANGES
index b264f41..59ea06a 100644
--- a/CHANGES
+++ b/CHANGES
@@ -7,6 +7,7 @@ SVN HEAD
                   Use modules.builtin instead of /sys/module
                   Handle built-in modules properly
                   Add detection of NCT6791D
+                  Add detection of NCT6681D, NCT6682D, and NCT6683D
 
 3.3.4 (2013-05-27)
   sensors.conf.5: Mention "sensors -u" to get the raw feature names
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 9c213b6..14c092a 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2031,6 +2031,13 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "Nuvoton NCT6681D/NCT6682D eSIO",
+		driver => "to-be-written",
+		devid => 0xB270,
+		devid_mask => 0xFFF0,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "Nuvoton W83667HG-B (NCT5571D) Super IO Sensors",
 		driver => "w83627ehf",
 		devid => 0xB350,
@@ -2063,6 +2070,13 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "Nuvoton NCT6683D eSIO",
+		driver => "to-be-written",
+		devid => 0xC730,
+		devid_mask => 0xFFF0,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "Nuvoton NCT6791D Super IO Sensors",
 		driver => "nct6775",
 		devid => 0xC800,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
