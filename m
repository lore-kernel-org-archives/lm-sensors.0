From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Jun 2014 02:09:01 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Nuvoton chip updates
Message-Id: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add reference to nct6883 driver
Add detection of NCT6792D
Show that NCT6102D/6104D/6106D are supported by nct6775 driver

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |  3 +++
 prog/detect/sensors-detect | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/CHANGES b/CHANGES
index a16e7be..f8d96df 100644
--- a/CHANGES
+++ b/CHANGES
@@ -14,6 +14,9 @@ SVN HEAD
                   Add detection of TMP441, TMP442, LM95233, LM95234,
                   and LM95235
                   Add detection of NCT7802Y
+                  Add reference to nct6883 driver
+                  Add detection of NCT6792D
+                  Show that NCT6102D/6104D/6106D are supported by nct6775 driver
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 9ce0cf2..1e6f140 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2111,7 +2111,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
 		name => "Nuvoton NCT6683D eSIO",
-		driver => "to-be-written",
+		driver => "nct6883",
 		devid => 0xC730,
 		devid_mask => 0xFFF0,
 		logdev => 0x0b,
@@ -2124,8 +2124,15 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
+		name => "Nuvoton NCT6792D Super IO Sensors",
 		driver => "to-be-written",	# nct6775
+		devid => 0xC910,
+		devid_mask => 0xFFF0,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
+		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
+		driver => "nct6775",
 		devid => 0xC450,
 		devid_mask => 0xFFF0,
 		logdev => 0x0b,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
