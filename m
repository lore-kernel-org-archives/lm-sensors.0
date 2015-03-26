From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Mar 2015 13:32:22 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: ITE updates
Message-Id: <1427376742-17682-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add detection of ITE8790E.
Reflect that IT8620E will soon be supported by the it87 driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Patches to it87.c follow.

 CHANGES                    | 1 +
 prog/detect/sensors-detect | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/CHANGES b/CHANGES
index 3d710c0..a5eb974 100644
--- a/CHANGES
+++ b/CHANGES
@@ -35,6 +35,7 @@ SVN HEAD
                   Add detection of TSE2004 and TS3001
                   Document driver support for NCT7802Y
                   Add detection of NCT7904D
+                  Add detection of IT8790E
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 436cf95..08721f0 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2303,7 +2303,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
 		name => "ITE IT8620E Super IO Sensors",
-		driver => "to-be-written",	# it87
+		driver => "it87",
 		devid => 0x8620,
 		logdev => 0x04,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
@@ -2427,6 +2427,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		devid => 0x8786,
 		logdev => 0x04,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
+		name => "ITE IT8790E Super IO Sensors",
+		driver => "it87",
+		devid => 0x8790,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}
 );
 
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
